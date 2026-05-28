---
name: base-botcard
description: 生成飞书多维表格（Base）功能推广卡片的 JSON 2.0 .card 文件。复用历史推广卡的文案风格与渲染样式，产出可直接导入飞书卡片平台、也能发 IM 预览的 .card。当用户要「写/做推广卡片、功能上新卡片、生成 card 文件、多维表格卡片、Base 推广卡、把功能/PRD 做成卡片」时使用。
---

# Bot Banner Card

把一个「多维表格功能上新」做成飞书 JSON 2.0 推广卡片（`.card` 文件）。沉淀自 58 张历史推广卡的文案规律 + 5 张真实 .card 的渲染规律。

## 前置认知（必读，否则会翻车）

1. **`.card` 是外壳**：`{"name":..., "dsl":{完整 JSON 2.0}, "variables":[]}`。平台导入要这层壳；IM 发送只要 `dsl` 裸体。
2. **JSON 2.0 对未知字段/未知 token 会报错**，导入显示空白。所有渲染规则、踩坑、已验证 token 全在 [references/rendering-guide.md](references/rendering-guide.md)，**装配前必读**。
3. **头图来源灵活**：用户提供 / 先留空 / 可选地引导用户装 `base-botbanner` 生成（见「头图」节）。**本 skill 不依赖图片工具、不替用户装。** 图片上传 bot-only，文案阶段先留 `IMG_KEY_TODO`。
4. **只做 2 类卡**（模板合集 / 共创招募不做）。

## 操作流程

### Step 0 · 判定类型（决定一切）

| 推几个功能 | 类型 | 起步模板 |
|---|---|---|
| **1 个**（含 AI、含"第 X 弹"系列） | **单点功能** | [templates/单点功能.card](templates/单点功能.card) |
| **2 个以上**（含发布会批次） | **多功能合集** | [templates/多功能合集.card](templates/多功能合集.card) |

分界线只有一条：**推几个功能**。AI / 系列 / 发布会都是皮肤，不是结构。

### Step 1 · 收集信息（含充分性门槛）

> **硬规则 · 信息充分性门槛**：信息不足时**禁止**开始写文案 / 装配。先自评「已知 vs 缺口」，**主动、具体地向用户追问**缺的部分（可用 AskUserQuestion）；用户补充后再评估，**直到足够才产出**。用户常常只丢一份 PRD —— PRD 几乎必缺：**灰度/发布状态、帮助文档/反馈链接、对外推广角度、头图素材**，这些必须补齐。能从 PRD 推断的别问，问就一次问清优先级最高的几个。

> **硬规则 · 不自行拍板**：不止缺失信息要问 —— **创作决策也不要自己定稿**（对外叫法、标题措辞、slogan、按钮组合、亮点取舍、配色、标签色等）。一律先列成「方案 + 理由」给用户确认，姿态是"我建议 X（因为 Y），你确认或改"，**不是**"我已经定了 X"。用户拍板后再产出。

按 [workflow.md](workflow.md) 双轨收集：用户给的 PRD/描述里能提取的先提取，缺的再一次性提问（≤5 问）。最终要凑齐：

- 功能名（→ 标题）
- 核心价值一句话（→ slogan）
- 2-4 个亮点（关键词 + 描述）
- 0-3 个适用场景（可选）
- 是否 AI 功能（→ 配色）
- 灰度状态：灰度 / 内测 / 超前内测 / 已上线（→ 尾注 + 标签）
- 帮助文档 / 反馈群 链接（→ 按钮）
- 头图（用户上传 / 留 TODO / 可选引导装 base-botbanner 生成，见「头图」节）

### Step 2 · 写文案

规则全集见 [references/copywriting-findings.md](references/copywriting-findings.md)。务必遵守的硬规则：

- **亮点条目**：`**关键词(4-7字)**：描述(15-30字)`，描述尽量"旧痛点→新解法"对比
- **痛点引入**："订单总延期？"提问式 / "告别 X"（每张卡 ≤1 处 告别）
- **量化优先**："30 多款""200 万行"，有数字用数字，别说"很多/提升"
- **emoji 克制**：整卡 ≤8 个；🔥 必双出 🔥🔥；标题纯功能可不带 emoji
- **称呼语统一**：默认「你」；B 端 / 正式语境用「您」，不混用
- **slogan**：AI 卡常用 `:GoGoGo:` 前缀（飞书 shortcode，仅飞书内渲染）

### Step 3 · 选渲染样式

详见 [references/rendering-guide.md](references/rendering-guide.md)。决策点：

- **配色**：AI/Agent/重磅 → `template: indigo` + header `icon: ai-common_colorful`；普通功能 → `template: blue` + 无 header icon。标签 `text_tag_list` 一律 green。
- **容器风格**（高亮块）：
  - **Style A（icon-field）**：每个亮点 = 一个功能点，markdown 带 `icon`（standard_icon, blue），`corner_radius:4px`
  - **Style B（font-header）**：一个主题 + 多个 bullet（如 核心亮点 / 适用场景），顶部 `<font color='blue'>**标题**</font>` + `- **关键词**：描述`，`corner_radius:8px`
- **按钮**：一律 `width:"fill"`。1 个直接放；2/3 个用 `column_set` N 列等权 → 等分铺满。图标用已验证 token（file-link-docx_outlined 等）。
- **尾注 div**：`person-admit_outlined`(grey) + notation 灰字，文案按灰度状态四态选（见 copywriting §II.4）。简单卡可省尾注。

### Step 4 · 装配 .card

1. 复制对应 `templates/*.card` 作骨架
2. 替换 header 标题/标签/配色、body 各 element 的文案
3. **不要动**通用骨架：`config.style.text_size.normal_v2`、4 值 padding/margin、每个 markdown 的 `text_align`+`text_size:normal_v2`
4. 图片填真实 `img_key` 或留 `IMG_KEY_TODO`；按钮四端 URL 填真值或留 `HELP_DOC_URL_TODO`

### Step 5 · 自检（文案 + 渲染两层都查）

**文案层**（详见 [references/copywriting-findings.md](references/copywriting-findings.md) §1b 精修铁律）：
- [ ] 加粗关键词等长、无逗号；同组 bullet 描述长度接近（换行整齐）；动词具体落到真实场景；**直接动宾、少写"用户/你"主语**；**无黑话缩写（SOP）也不口语（拿个/建个）**；列举引用项间加顿号；通读清晰无歧义

**渲染层**（详见 rendering-guide 踩坑清单）：
- [ ] padding/margin 全是 4 值形式（`"12px 12px 12px 12px"` / `"0px 0px 0px 0px"`）
- [ ] 每个 markdown 带 `text_align` + `text_size:"normal_v2"`
- [ ] 没有未在 token 表里的 `standard_icon`
- [ ] 没有 unicode emoji 当图标（图标走 standard_icon 或 Style B 色字标题）
- [ ] 按钮 `width:fill`，多按钮等权 column_set
- [ ] `.card` 外壳 `{name, dsl, variables:[]}` 齐全

### Step 6 · 预览

```bash
bash bin/preview.sh <你的.card文件> <接收者open_id>
```
自动抽 dsl、去掉占位 img、替换占位 URL、`--as bot` 发到指定 open_id 的 DM。去飞书看渲染。

### Step 7 · 交付

输出 `.card` 文件给用户，明确列出 TODO：
- `IMG_KEY_TODO` → 头图：用户提供，或（可选）引导其装 base-botbanner 生成 → `lark-cli im images create --as bot --file <图>` 拿 img_key 回填（见「头图」节）
- `HELP_DOC_URL_TODO` → 帮助文档/反馈群真实链接（四端都填）

## 头图（可选 · 联动 base-botbanner，非依赖）

**本 skill 不依赖任何图片工具，也不替用户安装。** 头图三种来源，由用户决定：

1. **用户自己提供图** → 上传拿 `img_key` 回填（上传命令见下方「⚠️ 上传命令」）
2. **先留空** → 保留 `IMG_KEY_TODO`，`bin/preview.sh` 预览时自动跳过
3. **想自动生成** → **推荐**（不强制）姊妹 skill `base-botbanner`，见下

> **⚠️ 上传命令（lark-cli 1.0.27 的 `--file <路径>` 打不开文件，是 bug！用 stdin 管道绕过）：**
> ```bash
> cat <图.png> | lark-cli im images create --as bot --data '{"image_type":"message"}' --file "image=-"
> ```
> 返回里取 `image_key`（形如 `img_v3_xxx`）回填到卡片 body 第一个 `img` 的 `img_key`。`--file "image=路径"` 会报 `cannot open file`，别用。

### 引导用户自行安装（仅当用户想自动生成头图、且没装时）

不要假设它已装，不要替用户装、不要静默调用。先问一句、给安装方式，让用户决定：

> 头图可以用配套的 `base-botbanner` skill 自动生成（独立项目）。需要的话你可以自行安装：
> `npx skills add wenqianwenny/base-botbanner -g -y`
> （来源：github.com/wenqianwenny/base-botbanner）

用户装了 / 已可用后再走：
- **输入**：功能描述 + 产品截图 / Figma URL（base-botbanner 必须要参考图）
- **输出**：900×500 横幅 2x PNG（1800×1000）；它会先问 布局 A/B/C + 背景
- **接回**：PNG → `cat <png> | lark-cli im images create --as bot --data '{"image_type":"message"}' --file "image=-"` 拿 `img_key` → 替换 `IMG_KEY_TODO`（注意 stdin 管道，见上方 ⚠️）

用户不想装 / 没截图：就走来源 1 或 2，不要卡在头图上。

## 目录

```
base-botcard/
├── SKILL.md                          # 本文件
├── workflow.md                       # 信息收集与交互流程
├── references/
│   ├── copywriting-findings.md       # 文案层规则（58 张 corpus）
│   ├── rendering-guide.md            # 渲染层规则（token/配色/容器/按钮/布局/踩坑）
│   └── samples/                      # 5 张真实 .card 正面样本
├── templates/
│   ├── 单点功能.card                  # 单点起步模板
│   └── 多功能合集.card                # 合集起步模板
└── bin/
    └── preview.sh                    # 发 IM 预览
```
