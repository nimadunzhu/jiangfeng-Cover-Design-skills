# Jiangfeng Cover Design Skills

一个用于生成动漫、插画角色系列封面的 Codex 专案级 Skill。  
A project-level Codex skill for generating anime and illustrated character covers in a consistent series style.

## 中文说明

### 功能

`create-character-cover` 会根据用户提供的主体图片、角色名称与封面文案生成系列风格封面。

核心流程：

1. 检查原图、角色边缘与文案。
2. 在生成前提供两种排版选择：
   - **参考排版**：人物居中，顶部与底部使用超大英文描边字，中间放置中文角色名。
   - **自定义排版**：根据原图构图提出适配方案，并说明与参考排版的差异。
3. 等待用户确认排版。
4. 使用图像生成工具制作封面。
5. 保存原图与成品，并在重复生成时自动递增编号。
6. 校验文件命名与成品尺寸。

### 默认规范

- 默认画布尺寸：`2400×1500`
- 原图命名：`[中文名]原图.[扩展名]`
- 成品命名：`[中文名]成品.png` 或 `[中文名]成品.jpg`
- 再次生成：自动递增为 `原图2`、`成品2`，不会覆盖旧文件
- 输出目录：`outputs/[中文名 英文名]/`

### 使用方式

在 Codex 中提出类似请求：

```text
请参考角色文件夹里的原图，根据主体图片生成封面。
角色名：芙莉莲 / Frieren
期数文字：VOL.01
短句：Long lived, learning to live again
```

Skill 会先展示排版方案，收到确认后再生成图片。

### 已知限制

- 图像生成可能出现文字拼写错误。生成后必须检查，必要时重试。
- 复杂发丝、透明材质、肢体边缘和补画区域需要人工验收。
- 本项目不使用 Photoshop，也不生成 PSD。
- 本地参考素材、角色原图和生成封面不会提交到 GitHub。

## English

### Features

`create-character-cover` generates a consistent series-style cover from a user-supplied subject image, character name, and cover copy.

Workflow:

1. Inspect the source image, subject edges, and copy.
2. Present two layout choices before generation:
   - **Reference layout**: centered subject, oversized outlined English text at the top and bottom, and a large Chinese name across the middle.
   - **Custom layout**: an image-specific proposal with clearly stated differences from the reference layout.
3. Wait for explicit user approval.
4. Generate the cover with an image-generation tool.
5. Save the original and delivery image with synchronized version numbering.
6. Validate output naming and dimensions.

### Defaults

- Canvas size: `2400×1500`
- Original image: `[Chinese name]原图.[extension]`
- Delivery image: `[Chinese name]成品.png` or `[Chinese name]成品.jpg`
- Additional versions: `原图2`, `成品2`, and so on
- Output directory: `outputs/[Chinese name English name]/`

### Usage

Ask Codex for a character cover and provide the subject image, bilingual character name, issue text, and short sentence. The skill presents layout choices before generating any image.

### Known Limitations

- Generated typography may contain spelling mistakes and must be reviewed.
- Complex hair, transparent materials, anatomy, and extended edges require visual inspection.
- This project does not use Photoshop or create PSD files.
- Local reference artwork, user-supplied images, and generated covers are excluded from GitHub.

## Repository Structure

```text
.
├── SKILL.md
├── agents/
│   └── openai.yaml
├── references/
│   └── style-guide.md
├── scripts/
│   ├── new-output-set.ps1
│   └── validate-cover.ps1
├── LICENSE
└── NOTICE
```

## License

[MIT License](LICENSE)
