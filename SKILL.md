---
name: base-botcard
description: 生成飞书多维表格（Base）功能推广卡片的 JSON 2.0 .card 文件。复用历史推广卡的文案风格与渲染样式，产出可直接导入飞书卡片平台、也能发 IM 预览的 .card。当用户要「写/做推广卡片、功能上新卡片、生成 card 文件、多维表格卡片、Base 推广卡、把功能/PRD 做成卡片」时使用。
---

# Base Bot Card

把一个「多维表格功能上新」做成飞书 JSON 2.0 推广卡片（`.card` 文件）。沉淀自历史推广卡的文案规律 + 真实 .card 的渲染规律。

## 前置认知（必读，否则会翻车）

1. **`.card` 是外壳**：`{"name":..., "dsl":{完整 JSON 2.0}, "variables":[]}`。平台导入要这层壳；IM 发送只要 `dsl` 裸体。
2. **JSON 2.0 对未知字段/未知 token 会报错**，导入显示空白。渲染规则/踩坑/已验证 token 全在 [references/rendering-guide.md](references/rendering-guide.md)，**装配前必读**。
3. **头图：不依赖、不替装**。三种来源由用户定，**步骤顺序（先图后文 / 先文后图）也由用户定**（见「头图」节）。
4. **只做 2 类卡**：单点功能 / 多功能合集（模板合集、共创招募、直播预告等不做）。
5. **文案是命门**：AI 一次写"过关"不现实，领导抠得细。靠 [copy-checklist.md](references/copy-checklist.md) 黑名单**拦住写烂** + 人工微调 + [lessons.md](references/lessons.md) 沉淀，**越用越准**。

## 操作流程

### Step 0 · 判定类型（决定一切）

| 推几个功能 | 类型 | 起步模板 |
|---|---|---|
| **1 个**（含 AI、含"第 X 弹"系列） | **单点功能** | [templates/单点功能.card](templates/单点功能.card) |
| **2 个以上**（含发布会批次） | **多功能合集** | [templates/多功能合集.card](templates/多功能合集.card) |

分界线只有一条：**推几个功能**。AI / 系列 / 发布会都是皮肤，不是结构。

### Step 1 · 收集信息（含两条硬门槛）

> **硬规则 · 充分性门槛**：信息不足时**禁止**开始写/装配。先自评「已知 vs 缺口」，主动追问，直到足够才产出。PRD 几乎必缺：**发布状态、帮助文档/反馈链接、对外角度、头图素材**。
>
> **硬规则 · 不自行拍板**：创作决策（对外叫法/标题/slogan/按钮/亮点取舍/配色/标签色/布局）也先列「方案 + 理由」给用户确认，姿态是"我建议 X，你确认或改"。

按 [workflow.md](workflow.md) 收集：**能枚举的缺口用 AskUserQuestion 给选项 + other**（阶段/头图/布局/判型），发散项（核心价值、亮点）才开放让用户自由说。要凑齐：功能名、核心价值、2-4 亮点、可选场景、是否 AI、发布状态、链接、头图。

### Step 2 · 写文案

- **第一步（必做，别跳）**：先翻 [references/golden-examples.md](references/golden-examples.md) 选**最像的 archetype 标杆**，照它句式与节奏**仿写**，再换成本次内容。**别只凭规则空想首稿**——只靠规则容易"合规但不地道"（真实教训：端到端那次没仿样例、靠规则硬写，磨了 6 轮）。skill 发给别人后他们没本地语料，**只能靠这里的内嵌样例**，所以这步是自包含的关键。
- 写作规则：[references/copy-rules.md](references/copy-rules.md)（句式/痛点/量化/tag·尾注/CTA/emoji/称呼）
- **写完必过** [references/copy-checklist.md](references/copy-checklist.md) 黑名单自检
- 出稿时**主动标出没把握的句子**，把用户注意力导到该抠处

### Step 3 · 选渲染样式

详见 [references/rendering-guide.md](references/rendering-guide.md)。决策点：
- **配色**：AI/Agent/重磅 → `template:indigo` + header `ai-common_colorful`；普通功能 → `blue` + 无 icon。tag 色只用 green/blue。
- **容器**：Style A（icon-field）/ Style B（font-header 色字标题 + bullets）
- **布局**：纵向堆叠 vs 左右并排 —— **不写死**，默认随机/问用户；**唯一红线：长内容必纵向**（见 rendering-guide §6b）
- **按钮**：一律 `width:fill`，N 个等权 column_set 等分
- **尾注**：`person-admit_outlined`(grey) + notation 灰字

### Step 4 · 装配 .card

1. 复制对应 `templates/*.card` 作骨架
2. 替换 header 标题/标签/配色 + body 文案
3. **不要动**通用骨架：`config.style.text_size.normal_v2`、4 值 padding/margin、每个 markdown 的 `text_align`+`text_size:normal_v2`
4. 图片填真实 `img_key` 或留 `IMG_KEY_TODO`；按钮四端 URL 填真值或留占位

### Step 5 · 自检（两层都查）

- **文案层** → 逐条过 [references/copy-checklist.md](references/copy-checklist.md)
- **渲染层** → rendering-guide 踩坑清单：4 值 padding/margin、markdown 带 text_align+text_size、无未知 token、按钮 fill、`.card` 外壳齐全

### Step 6 · 预览

```bash
bash bin/preview.sh <你的.card文件> <接收者open_id>
```
自动抽 dsl、去占位 img、替换占位 URL、`--as bot` 发到指定 open_id 的 DM。

> **前提**：本机装了 lark-cli，且已**授权一个有 IM 权限的应用**——预览卡片就是通过这个 lark-cli 授权的应用（bot）发出的。没装/没权限就跳过 IM 预览，改走 Step 7 的 CardKit。

### Step 7 · 交付

输出 `.card` 文件 + TODO 清单：`IMG_KEY_TODO`（头图，见下）、按钮真实链接（四端都填）。

**`.card` 怎么用（两条路，用户自己选）**：
- **直接发**：用 Step 6 的 IM 预览卡片直接发出
- **导入精修**：把 `.card` 导入 [open.larkoffice.com/cardkit](https://open.larkoffice.com/cardkit)，渲染 + 可视化精调，再发给自己 / 群

### Step 8 · 持续迭代（让 skill 越用越准）

- **捕获修正**：用户每纠一处文案/渲染，就往 [references/lessons.md](references/lessons.md) append 一条（改了啥→为啥）；攒多了 consolidate 进正式规则。纯个人偏好放 `preferences.local.md`（gitignore），别进通用规则。
- **捕获新样本**：用户给一张做得好的 `.card`，存进 `samples/` + 在 [samples/index.md](samples/index.md) 登记"示范了什么"；若暴露新规则就回填 rendering-guide / copy-rules。**这是样本库随使用者增长的口子。**

## 头图（可选 · 联动 base-botbanner，非依赖）

**本 skill 不依赖图片工具、不替用户装、不静默调用。** 三种来源 + 顺序都由用户定：

1. **用户自己提供图** → 上传拿 `img_key`（命令见下方 ⚠️）
2. **先留空** → 保留 `IMG_KEY_TODO`，`bin/preview.sh` 预览时自动跳过
3. **想自动生成** → **推荐**（不强制）姊妹 skill `base-botbanner`：先问一句、给 `npx skills add wenqianwenny/base-botbanner -g -y`，**用户自行安装后**，把"功能描述 + 截图 + 一句想突出啥"递给它，**头图的全部逻辑（布局/背景/抽象/渲染）归它，我们不参与**。

**步骤顺序用户定**：先出头图再写文案、或先文案再补图，都行。没图/不想装 → 走来源 1 或 2，别卡住。

> **⚠️ 上传命令**（lark-cli 1.0.27 的 `--file <路径>` 打不开文件，是 bug！用 stdin 管道）：
> ```bash
> cat <图.png> | lark-cli im images create --as bot --data '{"image_type":"message"}' --file "image=-"
> ```
> 取返回的 `image_key`（`img_v3_xxx`）回填到 body 第一个 `img` 的 `img_key`。

## 目录

```
base-botcard/
├── SKILL.md                  # 本文件（入口）
├── workflow.md               # 信息收集流程（选择题+other）
├── references/
│   ├── copy-checklist.md     # ★ 文案黑名单自检闸（最高频）
│   ├── copy-rules.md         # 文案导向：句式/痛点/tag·尾注/CTA/emoji…
│   ├── golden-examples.md    # ★ 内嵌标杆文案（自包含，仿写用）
│   ├── rendering-guide.md    # 渲染：token/配色/容器/按钮/布局/踩坑
│   ├── research-notes.md     # 归档：58 张原始分析（少用）
│   └── lessons.md            # ★ 个人自迭代流水账
├── samples/{index.md,*.card} # ★ 真实样本库（可由使用者扩充）
├── templates/{单点功能,多功能合集}.card
├── preferences.local.md      # gitignore，个人偏好
└── bin/preview.sh            # 发 IM 预览
```
