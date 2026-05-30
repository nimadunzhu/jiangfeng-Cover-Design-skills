# Character Cover Style Guide

## Goal

Create a recognizable member of the existing cover family with image generation. Preserve the supplied character identity while adapting the palette and decorations to the character.

## Canvas

- Use the user's requested dimensions.
- Default to `2400x1500` when no size is requested.
- Keep the subject crisp at final export size.

## Layout Confirmation Gate

Before generating, inspect the supplied image and local finished-cover references. Describe both choices and wait for explicit approval:

- **Reference layout**: follow the established arrangement closely.
- **Custom layout**: explain the proposed differences before generating.

Do not silently choose a custom composition.

## Reference Layout

Use this hierarchy when the user chooses the established arrangement:

1. Center the main subject.
2. Place an oversized outlined English character name across the top.
3. Repeat or continue the oversized outlined English name across the bottom.
4. Place a large solid Chinese character name across the middle.
5. Add a narrow repeated issue strip such as `VOL.01 VOL.01 VOL.01`.
6. Let the centered subject overlap portions of the English and Chinese text.
7. Place corner blocks or bars to balance the frame.
8. Add a work logo near the lower-left corner when a clear asset exists.
9. Add small character decorations near the lower edge or sides when they help.
10. Add a framed themed icon near the right side when it helps.
11. Add the supplied short sentence as a restrained handwritten-style or italic accent.

Do not force optional decorations into the frame. Remove an element when it competes with the subject.

## Custom Layout

When proposing a custom layout, state:

- subject position and scale
- English and Chinese title positions
- issue-strip position
- icon, logo, and short-sentence positions
- palette
- differences from the reference layout

## Subject Handling

- Keep the original face, expression, pose, and clothing design.
- Use the supplied subject as the primary image-generation reference.
- Extend only genuine missing portions of edges, clothing, or limbs.
- Inspect hair, hands, accessories, clothing edges, and character identity after generation.
- Retry or stop for user revision when generation changes anatomy, identity, or drawing style.

## Color And Texture

- Derive the palette from the supplied subject.
- Use one dominant background color, one contrast color, and one restrained accent.
- Keep background texture low contrast so the subject and Chinese title remain dominant.
- Match corner blocks, issue text, and framed icon to the palette.

## Generated Text

- Request bold condensed Latin display lettering and bold Chinese display lettering.
- Include required copy explicitly in the generation prompt.
- Inspect spelling visually after generation.
- Retry when required copy is wrong or unreadable.
- Report remaining text defects honestly when retries do not solve them.

## Visual Checklist

- Character identity is unchanged.
- Subject edges look intentional.
- Required copy is spelled exactly as provided.
- Main Chinese title is legible behind and around the subject.
- English outline text and issue strip frame the composition without distracting from it.
- Corner blocks balance the frame.
- Downloaded or generated decorations are recorded in `素材来源.md`.
- Final JPG or PNG uses the approved layout.
