param(
  [Parameter(Mandatory = $true)]
  [string]$InputImage,

  [Parameter(Mandatory = $true)]
  [string]$ChineseName,

  [Parameter(Mandatory = $true)]
  [string]$EnglishName,

  [string]$OutputRoot = (Join-Path (Get-Location) "outputs")
)

$ErrorActionPreference = "Stop"
$originalLabel = -join @([char]0x539F, [char]0x56FE)
$finalLabel = -join @([char]0x6210, [char]0x54C1)
$sourcesFileName = (-join @([char]0x7D20, [char]0x6750, [char]0x6765, [char]0x6E90)) + ".md"

if (-not (Test-Path -LiteralPath $InputImage -PathType Leaf)) {
  throw "Input image does not exist: $InputImage"
}

$characterDirectoryName = "$ChineseName $EnglishName"
$characterDirectory = Join-Path $OutputRoot $characterDirectoryName
New-Item -ItemType Directory -Path $characterDirectory -Force | Out-Null

$escapedChineseName = [Regex]::Escape($ChineseName)
$escapedOriginalLabel = [Regex]::Escape($originalLabel)
$escapedFinalLabel = [Regex]::Escape($finalLabel)
$pattern = "^${escapedChineseName}(?:${escapedOriginalLabel}|${escapedFinalLabel})(?<number>\d*)\."
$usedNumbers = @()

Get-ChildItem -LiteralPath $characterDirectory -File -ErrorAction SilentlyContinue |
  ForEach-Object {
    if ($_.Name -match $pattern) {
      if ($Matches.number) {
        $usedNumbers += [int]$Matches.number
      } else {
        $usedNumbers += 1
      }
    }
  }

$number = if ($usedNumbers.Count -gt 0) {
  ([int](($usedNumbers | Measure-Object -Maximum).Maximum)) + 1
} else {
  1
}

$suffix = if ($number -eq 1) { "" } else { [string]$number }
$extension = [System.IO.Path]::GetExtension($InputImage)
$originalPath = Join-Path $characterDirectory "${ChineseName}${originalLabel}${suffix}${extension}"
$pngPath = Join-Path $characterDirectory "${ChineseName}${finalLabel}${suffix}.png"
$jpgPath = Join-Path $characterDirectory "${ChineseName}${finalLabel}${suffix}.jpg"
$sourcesPath = Join-Path $characterDirectory $sourcesFileName

if (Test-Path -LiteralPath $originalPath) {
  throw "Refusing to overwrite existing original image: $originalPath"
}

Copy-Item -LiteralPath $InputImage -Destination $originalPath

if (-not (Test-Path -LiteralPath $sourcesPath)) {
  @(
    "# Asset Sources"
    ""
    "| Date | Purpose | Source URL | Notes |"
    "| --- | --- | --- | --- |"
  ) | Set-Content -LiteralPath $sourcesPath -Encoding UTF8
}

[pscustomobject]@{
  characterDirectory = $characterDirectory
  sequence = $number
  suffix = $suffix
  originalPath = $originalPath
  pngPath = $pngPath
  jpgPath = $jpgPath
  sourcesPath = $sourcesPath
} | ConvertTo-Json -Depth 5
