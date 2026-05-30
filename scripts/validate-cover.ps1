param(
  [Parameter(Mandatory = $true)]
  [string]$CharacterDirectory,

  [Parameter(Mandatory = $true)]
  [string]$ChineseName,

  [int]$ExpectedWidth = 2400,

  [int]$ExpectedHeight = 1500
)

$ErrorActionPreference = "Stop"
$originalLabel = -join @([char]0x539F, [char]0x56FE)
$finalLabel = -join @([char]0x6210, [char]0x54C1)
$sourcesFileName = (-join @([char]0x7D20, [char]0x6750, [char]0x6765, [char]0x6E90)) + ".md"

function Get-Sequence([string]$Value) {
  if ($Value) {
    return [int]$Value
  }
  return 1
}

function Read-RasterSize([string]$Path) {
  Add-Type -AssemblyName System.Drawing
  $image = [System.Drawing.Image]::FromFile($Path)
  try {
    return [pscustomobject]@{
      width = $image.Width
      height = $image.Height
    }
  } finally {
    $image.Dispose()
  }
}

if (-not (Test-Path -LiteralPath $CharacterDirectory -PathType Container)) {
  throw "Character directory does not exist: $CharacterDirectory"
}

$sourcesPath = Join-Path $CharacterDirectory $sourcesFileName
if (-not (Test-Path -LiteralPath $sourcesPath -PathType Leaf)) {
  throw "Missing asset sources file: $sourcesPath"
}

$escapedName = [Regex]::Escape($ChineseName)
$escapedOriginalLabel = [Regex]::Escape($originalLabel)
$escapedFinalLabel = [Regex]::Escape($finalLabel)
$originalPattern = "^${escapedName}${escapedOriginalLabel}(?<number>\d*)\.[^.]+$"
$deliveryPattern = "^${escapedName}${escapedFinalLabel}(?<number>\d*)\.(png|jpe?g)$"
$originals = @{}
$deliveries = @{}

Get-ChildItem -LiteralPath $CharacterDirectory -File | ForEach-Object {
  if ($_.Name -match $originalPattern) {
    $originals[(Get-Sequence $Matches.number)] = $_.FullName
  } elseif ($_.Name -match $deliveryPattern) {
    $sequence = Get-Sequence $Matches.number
    if ($deliveries.ContainsKey($sequence)) {
      throw "Multiple delivery files found for sequence ${sequence}."
    }
    $deliveries[$sequence] = $_.FullName
  }
}

if ($deliveries.Count -eq 0) {
  throw "No delivery JPG or PNG files found for '$ChineseName'."
}

$results = @()
foreach ($sequence in ($deliveries.Keys | Sort-Object)) {
  if (-not $originals.ContainsKey($sequence)) {
    throw "Missing synchronized original image for sequence ${sequence}."
  }

  $deliverySize = Read-RasterSize $deliveries[$sequence]
  if ($deliverySize.width -ne $ExpectedWidth -or $deliverySize.height -ne $ExpectedHeight) {
    throw "Unexpected dimensions for sequence ${sequence}: expected ${ExpectedWidth}x${ExpectedHeight}, got $($deliverySize.width)x$($deliverySize.height)."
  }

  $results += [pscustomobject]@{
    sequence = $sequence
    originalPath = $originals[$sequence]
    deliveryPath = $deliveries[$sequence]
    width = $deliverySize.width
    height = $deliverySize.height
  }
}

[pscustomobject]@{
  ok = $true
  characterDirectory = (Resolve-Path -LiteralPath $CharacterDirectory).Path
  sourcesPath = $sourcesPath
  outputs = $results
} | ConvertTo-Json -Depth 10
