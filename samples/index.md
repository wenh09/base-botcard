# 样本库索引

真实「过关」.card 样本，用来核对渲染结构 + 仿写。每条标注：**类型 / 布局 / 它示范了什么**。

| 文件 | 类型 | 布局 | 示范了什么 |
|---|---|---|---|
| `A_单点常规_透视表.card` | 单点功能 | 纵向·无容器 | 最简单点：img + hr + markdown(slogan+bullets) + 单按钮(width default)；template **blue**、无 header icon |
| `B_仪表盘AI组件_核心亮点+适用场景.card` | 单点功能 | 纵向·2 容器 | 核心亮点 + 适用场景 各一个 **Style B** 蓝容器（`<font color='blue'>**标题**</font>` + bullets）；template indigo |
| `B_AI语音录入_2列容器.card` | 多功能合集(2 功能) | **左右并排** | 2 功能 → column_set 2 列，每列一个 Style B 容器；短内容适合并排；template blue |
| `B_AI三件套_1大2小.card` | 多功能合集(3 功能) | 1 大 + 2 小 | **Style A**（icon-field：markdown 带 standard_icon）；1 个满宽容器 + column_set(2 小)；3 按钮等分；indigo + ai-common_colorful |
| `B_AI三件套_3竖排容器.card` | 多功能合集(3 功能) | 纵向·3 竖排 | 同 3 功能换成 column_set(1 列×3 容器竖排)；`background_style: blue-100` 变体 |

> 渲染层（token/配色/容器风格/按钮/布局）已从这 5 张提炼进 [../references/rendering-guide.md](../references/rendering-guide.md)。文案标杆见 [../references/golden-examples.md](../references/golden-examples.md)。

---

## 📥 贡献新样本（欢迎未来使用者投喂）

本 skill 的渲染/文案能力会**随样本变多越用越准**。如果你手上有一张**做得好、过审过的** `.card`：

1. 把 `.card` 文件丢进本 `samples/` 目录（文件名建议：`<类型>_<一句话特征>.card`）
2. 在上表加一行：类型 / 布局 / **它示范了什么新东西**（新布局？新组件？新配色？新文案句式？）
3. 如果它暴露了**现有 references 没覆盖的规则**（如一个新 `standard_icon` token、一种没见过的容器布局、一句好句式），顺手回填到对应 reference：
   - 渲染相关 → `references/rendering-guide.md`
   - 文案相关 → `references/copy-rules.md` / `golden-examples.md`
4. （多人协作时）`git commit` + push，别人 `npx skills update` 就能拿到

> 维护者目前样本偏少（尤其**合集卡 + 左右布局**），这类样本最欢迎补充。
