---
name: create-character-cover
description: Create a series-style character cover with image generation from a user-supplied subject image, character name, and cover copy. Use when Codex needs to propose a reference-faithful or custom cover layout for user approval, preserve the original image, generate the approved anime or illustrated character cover, save synchronized versioned JPG or PNG outputs, and validate the delivery file.
---

# Create Character Cover

Create a cover that follows the project's established character-series visual language. Use image generation directly. Do not use Photoshop, COM automation, or PSD files.

## Required Input

Before generating, require:

- one subject image
- the character name
- issue text such as `VOL.01`
- the short sentence or supplementary copy
- optional canvas size; default to `2400x1500`

If the user gives only one language for the character name, verify the official Chinese and English names online before creating files. Do not invent missing copy.

## Confirm The Layout

Read [references/style-guide.md](references/style-guide.md) and inspect the supplied subject plus the local finished-cover references before generating.

Always pause and describe these choices:

1. **Reference layout**: center the subject, place oversized outlined English text at the top and bottom, place the large Chinese name across the middle, repeat the issue strip, and use the established logo and decoration positions.
2. **Custom layout**: describe the proposed subject position, text hierarchy, decoration positions, palette, and the main differences from the reference layout.

Ask the user to select one choice or request adjustments. Do not invoke image generation until the user explicitly confirms a layout.

## Start The Output Set

After layout approval, run:

```powershell
& .\scripts\new-output-set.ps1 `
  -InputImage <absolute-input-path> `
  -ChineseName <name> `
  -EnglishName <name>
```

Use the returned paths for every later step. The script creates `outputs/[Chinese name English name]/`, preserves the original file extension, and increments the original image and delivery image as one synchronized set. Never overwrite an earlier output.

## Generate The Cover

1. Inspect the source image for resolution, completeness, watermark artifacts, and usable subject edges.
2. Use the built-in image generation tool with the supplied subject as the primary visual reference.
3. Preserve the original drawing style, face, clothing, pose, and character identity. Extend missing edges, clothing, or limbs only when the supplied subject is actually incomplete.
4. Apply the user-approved layout. For the reference layout:
   - oversized outlined English character name at the top and bottom
   - large Chinese character name across the middle
   - repeated issue strip such as `VOL.01`
   - centered subject overlapping some text
   - corner blocks or short bars
5. Search for suitable work-specific decorations only when the user requests external assets or when a clear logo is essential. Prefer generated themed icons and neutral elements to reduce asset dependencies.
6. Record every downloaded decoration in `素材来源.md` with URL, purpose, and download date. Record generated decorations as generated assets.
7. Save the finished cover as the returned PNG or JPG path.
8. Inspect the generated image visually. Check character identity, composition, watermark artifacts, and every required text string.
9. Retry image generation when text is misspelled, required layout elements are missing, or the character drifts visibly. If a clean result still cannot be generated after reasonable retries, pause and report the visible issues instead of claiming completion.
10. Run `scripts/validate-cover.ps1` and report the final path, dimensions, format, asset sources, and any remaining manual revision points.

## Text Limitation

Image generation can misspell text. Keep supplied copy short, include it explicitly in the prompt, and verify it visually after generation. Do not promise exact typography when the generated image does not contain exact text.

## Validation

Run:

```powershell
& .\scripts\validate-cover.ps1 `
  -CharacterDirectory <character-folder> `
  -ChineseName <name> `
  -ExpectedWidth <width> `
  -ExpectedHeight <height>
```
