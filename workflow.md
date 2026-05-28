# Workflow — 信息收集与交互

目标：用最少的打扰凑齐做卡所需信息，再产出。**先文案后渲染，先确认后装配。**

## Phase 1 · 冷启动（吸收用户已给的）

用户通常给以下之一：
- 一份 **PRD**（飞书文档 URL / 本地文件 / 粘贴文本）
- 一句话**功能描述**（"给 XX 功能写张推广卡"）

动作：
- PRD 是飞书文档 URL → 用 `lark-doc` 拉正文；本地文件 → 直接读
- 提取：功能名、user story、使用场景、目标用户、灰度状态、帮助文档/反馈链接、是否 AI、**头图素材（产品截图 / Figma）**
- 在心里建一个「已知 / 缺失」清单

## Phase 2 · 充分性门槛 + 结构化提问（硬门槛）

**信息不足不进入产出。** 循环：评估「已知 vs 缺口」→ 主动追问缺口 → 用户补充 → 再评估，直到足够为止。**一次性问，≤5 个问题**，能从 PRD 推断的绝不问。**PRD 几乎必缺的硬缺口**：灰度/发布状态、帮助文档/反馈链接、对外推广角度、头图素材。其他典型缺口：

**枚举型缺口 → 用 AskUserQuestion（给选项 + other），不要开放式 wait-for-input：**
1. 推**几个功能**？→ 选项：单点 / 合集
2. 什么**阶段**？→ 选项：功能上新(将全量) / 内测中(小范围)；以及这卡是 邀请进群 / 已灰度本群 / 已上线通知
3. **头图**怎么办？→ 选项：我提供图 / 装 base-botbanner 生成 / 先留 TODO
4. **布局**？→ 选项：纵向 / 左右并排 / 你定（注：长内容只能纵向）

**发散型 → 开放让用户自由说，你润色：**
5. 一句话**核心价值**（slogan）+ **2-4 个亮点**（关键词 + 一句）
6. **帮助文档 / 反馈群链接**（贴链接，没有就留 TODO）

> **平衡**：能枚举的就给选项（省得来回打字），发散的才开放。**别为选项而选项**；能从 PRD 推断的不问；一次问清最关键的几个。

文案规则见 [references/copy-rules.md](references/copy-rules.md)，出稿自检 [references/copy-checklist.md](references/copy-checklist.md)，仿写标杆 [references/golden-examples.md](references/golden-examples.md)。

## Phase 3 · 文案预览（先纯文字，别急着拼 JSON）

**不只是文案** —— 所有创作决策（对外叫法 / 标题 / slogan / 按钮组合 / 亮点取舍 / 配色 / 标签色）都列进方案，逐项给「建议 + 理由」让用户确认，**不自行拍板**。把拟好的内容用**纯文本**列给用户确认：

```
标题：…
slogan：…
亮点：
  • 关键词：描述
  • …
适用场景（可选）：…
按钮：[文案] → [链接]
尾注：…
```

用户改文案，你润色到位再进下一步。

## Phase 4 · 装配 + IM 预览

文案定稿后：
1. **头图**（需要时）：用户提供图；或（可选）引导用户**自行安装** base-botbanner 生成（功能描述 + 截图 → 2x PNG）→ `lark-cli im images create --as bot --file <png>` 拿 `img_key`。不想装 / 没图就留 `IMG_KEY_TODO`，别卡住。
2. 按 [SKILL.md](SKILL.md) Step 3-5 装配 `.card`（填入 img_key）
3. `bash bin/preview.sh <.card文件>` 发 IM 预览
4. 用户看渲染 → 提改动 → 迭代（多半是配色 / 容器风格 / 按钮）

## Phase 5 · 交付

输出 `.card` 文件 + TODO 清单：
- `IMG_KEY_TODO` → 头图待上传：`lark-cli im images create --as bot --file <图>` 拿 `img_key` 回填
- `HELP_DOC_URL_TODO` → 真实链接（四端 URL 都填）

## 原则

- **能推断就别问**：PRD 里有的信息直接用
- **批量问**：别一问一答 ping-pong，攒齐一次问
- **先文字后样式**：文案没定不要拼 JSON，省返工
- **用真实样本兜底**：拿不准布局就照 `samples/` 里同类卡抄结构（见 [samples/index.md](samples/index.md)）
