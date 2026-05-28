# 渲染层指南（从 5 张真实 .card 提取）

> 文案层规则见 [copywriting-findings.md](copywriting-findings.md)。本文件只讲 **JSON 2.0 DSL 的渲染配置**：token / 配色 / 组件结构 / 布局，这些 corpus（labeled.md/raw.json）里没有，只能从真实 .card 提取。
>
> 样本在 [samples/](samples/)，5 张全是手工做的正面 case。

---

## 0. 范围 & 样本速览（2 类模型）

skill 只做 **2 类**卡（模板合集 / 共创招募已砍，不做）：

- **单点功能**：推 **1 个**功能（含 AI、含系列第X弹）。结构 = slogan + 核心亮点 + 适用场景。
- **多功能合集**：推 **2 个以上**功能（含发布会批次）。结构 = slogan + N 个功能块。

分界线就一条：**推几个功能**。AI / 系列 / 发布会都只是皮肤，不是独立结构。

5 张样本映射：

| 文件 | 类型 | 布局特征 | template |
|---|---|---|---|
| `A_单点常规_透视表.card` | **单点功能**（极简） | 纯 markdown + bullets，无容器 | blue |
| `B_仪表盘AI组件_核心亮点+适用场景.card` | **单点功能**（容器版） | 2 容器：核心亮点 / 适用场景（Style B） | indigo |
| `B_AI语音录入_2列容器.card` | **多功能合集**（2 功能） | 2 列并排容器（Style B） | blue |
| `B_AI三件套_1大2小.card` | **多功能合集**（3 功能） | 1 大容器 + column_set(2 小)（Style A） | indigo |
| `B_AI三件套_3竖排容器.card` | **多功能合集**（3 功能） | column_set(1 列 × 3 容器竖排)（Style A） | indigo |

→ 做**单点功能**看前 2 张；做**多功能合集**看后 3 张。voice_input 属单点功能，参考第 2 张。

---

## 1. 通用骨架（5 张完全一致，可写死）

```jsonc
{
  "name": "<卡片名>",
  "dsl": {
    "schema": "2.0",
    "config": {
      "update_multi": true,
      "style": { "text_size": { "normal_v2": {
        "default": "normal", "pc": "normal", "mobile": "heading"
      }}}
    },
    "body": {
      "direction": "vertical",
      "horizontal_spacing": "8px",
      "vertical_spacing": "8px",   // 或 "12px"
      "horizontal_align": "left",
      "vertical_align": "top",
      "padding": "12px 12px 12px 12px",
      "elements": [ /* ... */ ]
    },
    "header": {
      "title": { "tag": "plain_text", "content": "<标题>" },
      "subtitle": { "tag": "plain_text", "content": "" },  // 空也保留
      "text_tag_list": [{ "tag": "text_tag",
        "text": { "tag": "plain_text", "content": "功能上新" },
        "color": "green" }],
      "template": "indigo",   // 见 §2
      "icon": { "tag": "standard_icon", "token": "ai-common_colorful" },  // 见 §2
      "padding": "12px 12px 12px 12px"
    }
  },
  "variables": []
}
```

- 每个 element 必带 `margin: "0px 0px 0px 0px"`，markdown 必带 `text_align` + `text_size: "normal_v2"`
- 详见 memory 里的「导入空白踩坑清单」

---

## 2. 配色规则（强信号）

### template 主题色
| 值 | 用在 | 样本 |
|---|---|---|
| **`indigo`** | AI 类 / 重磅 / 发布会（**必配** header icon `ai-common_colorful`） | Block Agent、AI 三件套 ×2 |
| **`blue`** | 普通功能上新（**不配** header icon） | 透视表、AI 语音录入 |

**判定：** AI/Agent 相关 → indigo + ai-common_colorful；常规功能 → blue + 无 icon。

### text_tag（标题右侧标签）
**颜色只用 `green` 或 `blue`**（品牌规范，不要用其他色；哪个文案配哪个色，问用户确认）。文案见过：`功能上新`、`内测中`、`重磅内测`。

### background_style（容器底色）
| 值 | 效果 | 样本 |
|---|---|---|
| `blue-50` | 淡蓝（默认选它） | 多数 |
| `blue-100` | 稍深一点的蓝 | 3 竖排那张 |

### `<font color='X'>` 内联文字色
- `<font color='blue'>**标题**</font>` — 容器内小标题（font-header 风）
- `<font color='green'>...</font>` — slogan 强调（透视表）

---

## 3. standard_icon token 字典（已验证可用，共 10 个）

| token | 渲染 | 用途 | 出处样本 |
|---|---|---|---|
| `ai-common_colorful` | 紫色四角星 | **header**（AI 卡） | 全部 indigo 卡 |
| `person-admit_outlined` | 灰色小人 | **footer div**（配 grey） | 多数 |
| `bitableform_outlined` | 表单/勾选 | 问卷/表单类亮点 | AI 三件套 |
| `sheet-line_outlined` | 折线图 | 数据/问数类亮点 | AI 三件套 |
| `vote_outlined` | 柱状图 | 图表/组件类亮点 | AI 三件套 |
| `insert-chart_outlined` | 插入图表 | 分析/可视化类亮点 | 3 竖排 |
| `buzz_outlined` | 喇叭/秘籍 | button「快速上手秘籍」 | Block Agent |
| `high-light-repeatvalue_outlined` | 高亮/模板 | button「模板」 | Block Agent |
| `team-add_outlined` | 加人 | button「加入内测群」 | 3 竖排 |
| `file-link-docx_outlined` | 文档链接 | button「帮助文档」 | 透视表 |

亮点容器图标统一 `"color": "blue"`；button 图标不带 color；footer 图标 `"color": "grey"`。

不在表里的 token 别瞎填（2.0 未知 token 会报错）。要新图标去 CardKit 拖。

---

## 4. 高亮块的两种做法（重要）

### Style A — icon-field（图标在左，标题+描述）
容器里放**一个** markdown，markdown 自带 `icon` 字段：
```jsonc
{
  "tag": "interactive_container",
  "corner_radius": "4px", "has_border": false,
  "background_style": "blue-50",
  "padding": "4px 4px 4px 6px",
  /* width/height/direction/spacing/align/margin... */
  "elements": [{
    "tag": "markdown",
    "content": "**AI 生成问卷**\n不止于生成，AI 将深入洞察业务场景……",
    "text_align": "left", "text_size": "normal_v2", "margin": "0px 0px 0px 0px",
    "icon": { "tag": "standard_icon", "token": "bitableform_outlined", "color": "blue" }
  }]
}
```
- 出处：AI 三件套（1大2小 / 3竖排）
- 特征：`corner_radius:4px`、`padding:"4px 4px 4px 6px"`、一行标题 + 一行描述、左侧蓝 icon
- 适合：每个亮点是「一个功能点 + 一句话」

### Style B — font-header（顶部色字标题 + bullet 列表）
容器里放**多个** markdown：第一个是 `<font color='blue'>**标题**</font>`，后面是 bullets：
```jsonc
{
  "tag": "interactive_container",
  "corner_radius": "8px", "has_border": false,
  "background_style": "blue-50",
  "padding": "12px 8px 12px 8px",
  "elements": [
    { "tag": "markdown", "content": "<font color='blue'>**问卷支持 AI 语音录入** \n</font>",
      "text_align": "center", "text_size": "normal_v2", "margin": "0px 0px 0px 0px" },
    { "tag": "markdown", "content": "**• 打乱语序也能对**：连续说、跳着说……",
      "text_align": "left", "text_size": "normal_v2", "margin": "0px 0px 0px 0px" },
    { "tag": "markdown", "content": "**• 口语表达也能懂**：……", /* ... */ },
    { "tag": "markdown", "content": "**• 复杂环境也能填**：……", /* ... */ }
  ]
}
```
- 出处：**AI 语音录入**、Block Agent（核心亮点/适用场景）
- 特征：`corner_radius:8px`、`padding:"12px 8px 12px 8px"`、标题色字（可 center）、bullet 用 `**• 关键词**：描述`
- 适合：每个块是「一个主题 + 多个 bullet」（核心亮点、适用场景、某子功能的多个卖点）

**选哪种：** 亮点是"N 个并列小功能" → Style A；亮点是"主题下挂 2-4 个 bullet" → Style B。

---

## 5. 按钮

```jsonc
{
  "tag": "button",
  "text": { "tag": "plain_text", "content": "了解 AI 生成问卷" },
  "type": "primary",          // 见下
  "width": "fill",            // 见下
  "size": "medium",
  "icon": { "tag": "standard_icon", "token": "file-link-docx_outlined" },  // 可选
  "behaviors": [{ "type": "open_url",
    "default_url": "...", "pc_url": "...", "ios_url": "...", "android_url": "..." }],
  "margin": "0px 0px 0px 0px"
}
```

| 字段 | 取值 | 说明 |
|---|---|---|
| `type` | `primary` | 白底蓝边蓝字（多数） |
|  | `primary_filled` | 实心蓝（强 CTA，如「立即加入内测群」） |
| `width` | `fill` | **统一用 fill 满宽**（本 skill 约定，即便单个按钮也满宽） |
|  | `default` | 自适应宽度左对齐（历史卡偶见，**本 skill 不用**） |

**按钮宽度 & 均分规则（用户拍板）：** 按钮一律 `width:"fill"`。
- **1 个**：直接放 body，满宽一条
- **2 个**：`column_set`(flex_mode `stretch`) → 2 个 `column`(weight 1)，各 1 button → **均分**
- **3 个**：同理 3 列等权 → **等分**

即 N 个按钮 = N 列等权 column_set，每个 button `width:fill`，自动等分铺满整行。

---

## 6. 布局图谱（5 种已验证骨架）

```
【A 单点极简】 透视表
img → hr → markdown(slogan色字 + bullets 合并一个 md) → markdown(除此之外…) → hr → button(width:default 单个)
  · template blue, header 无 icon, 无 footer div

【B 2列并排】 AI 语音录入   ← voice_input 的标准答案！
img → slogan(:GoGoGo:+加粗) → column_set[2 col × 1 容器(StyleB)] → hr → column_set[2 button] → footer div
  · template blue

【B 3竖排】 2025升级
img → md → md → spacer(空md) → column_set[1 col × 3 容器(StyleA, blue-100)] → md(引导) → hr → button(primary_filled 单个)
  · template indigo

【B 1大2小】 AI 三件套
img → slogan → spacer(空md) → 容器(StyleA, full) → column_set[1 col × 2 容器(StyleA)] → md(引导) → hr → column_set[3 button] → footer div
  · template indigo

【B 核心亮点+适用场景】 Block Agent
img → slogan(加粗:GoGoGo:) → column_set[1 col × 2 容器(StyleB: 核心亮点 / 适用场景)] → md(引导) → hr → column_set[2 button] → footer div
  · template indigo
```

---

## 7. 间隔 / spacer 技巧

- **空 markdown** `{"tag":"markdown","content":"","text_align":"left","text_size":"normal_v2","margin":"0px 0px 0px 0px"}` → 加一段垂直留白（slogan 与内容块之间）
- **hr** → 分隔线（内容区与按钮区之间必有；透视表还在 img 下加了一条）
- ⚠️ 3 竖排那张里有个**空的 interactive_container**（`elements:[]`）—— 这是手工编辑残留，**别复制**

---

## 8. 引导区尾注 div（footer）

```jsonc
{
  "tag": "div",
  "text": { "tag": "plain_text", "content": "功能已对本群开启内测，期待你的反馈和建议。",
    "text_size": "notation", "text_align": "left", "text_color": "grey" },
  "icon": { "tag": "standard_icon", "token": "person-admit_outlined", "color": "grey" },
  "margin": "0px 0px 0px 0px"
}
```
- 文案三态见 copywriting-findings §II.4
- 简单卡（透视表）可省略 footer，直接以 button 收尾

---

## 9. 对照：我之前 voice_input_v3 错在哪

| v3 的做法 | 正确做法（依据 AI 语音录入 真卡） |
|---|---|
| 特性卡塞 emoji 🚪🎙️⚡ | 用 **Style B 容器**：`<font color='blue'>**标题**</font>` + `**• 关键词**：描述` bullets，**根本不用 emoji 也不用 standard_icon** |
| 适用场景裸 markdown 列表 | 包进**另一个 Style B 容器**（像 Block Agent 的「适用场景」块） |
| slogan 用 🤩 | 用 `:GoGoGo:  **……**` |
| 3 个特性竖排 | voice 是**单点功能**（1 功能多卖点）→ 核心亮点 + 适用场景 两个 Style B 容器 |
| 单 button 裸放 | 用 `width:default` 单按钮（如透视表），或包进 column_set |

**结论（已修正）：** voice_input 是**单点功能**，应照 `B_仪表盘AI组件_核心亮点+适用场景.card`（Block Agent）的单点结构重做，**不是** `B_AI语音录入_2列容器.card`（那张是语音+粘贴 2 功能 = 多功能合集）。已落地为 `Bot Banner/voice_input_v4.card`。
