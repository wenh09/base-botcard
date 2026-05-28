# base-botcard

把「多维表格（Base）功能上新」做成飞书 **JSON 2.0 推广卡片**（`.card` 文件）的 skill。

沉淀自 **58 张历史推广卡的文案规律** + **5 张真实 .card 的渲染规律**，产出可直接导入飞书卡片平台、也能发 IM 预览的 `.card`。

## 怎么用

**作为 agent skill**：把本目录交给 Claude / agent，读 [SKILL.md](SKILL.md) 按流程产卡。

**人也能直接查**：
| 想干嘛 | 看哪 |
|---|---|
| 怎么写文案 | [references/copywriting-findings.md](references/copywriting-findings.md) |
| DSL 怎么拼 / 有哪些坑 | [references/rendering-guide.md](references/rendering-guide.md) |
| 要起步骨架 | [templates/单点功能.card](templates/单点功能.card) · [templates/多功能合集.card](templates/多功能合集.card) |
| 看真实样例 | [references/samples/](references/samples/) |
| 发预览 | `bash bin/preview.sh <你的.card>` |
| 要头图（可选） | 自行安装配套 skill **base-botbanner**（`npx skills add wenqianwenny/base-botbanner -g`）生成，出 2x PNG 后上传拿 `img_key`。**本 skill 不依赖它** |

## 只做 2 类卡

- **单点功能**：推 1 个功能（含 AI、含系列第 X 弹）
- **多功能合集**：推 2 个以上功能（含发布会批次）

（模板合集、共创招募不做。）

## 目录

```
base-botcard/
├── SKILL.md            # 入口：流程、判定、装配、自检
├── workflow.md         # 信息收集与交互流程
├── references/
│   ├── copywriting-findings.md   # 文案层规则
│   ├── rendering-guide.md        # 渲染层规则（token/配色/容器/按钮/布局/踩坑）
│   └── samples/                  # 5 张真实 .card 正面样本
├── templates/
│   ├── 单点功能.card
│   └── 多功能合集.card
└── bin/
    └── preview.sh      # 发 IM 预览
```

## 几个必知的坑

- `.card` 是外壳 `{name, dsl, variables}`；**IM 发送只要 `dsl` 裸体**
- JSON 2.0 对**未知字段 / 未知 token 报错**，会导入空白 —— 装配前读 rendering-guide
- 图片是 **bot-only 上传**，文案阶段先留 `IMG_KEY_TODO`
- padding/margin 一律 **4 值形式**；markdown 必带 `text_align` + `text_size:"normal_v2"`

## 预览发送依赖

需要本机装好并登录 [lark-cli](https://github.com/larksuite/cli)。`bin/preview.sh` 用 `--as bot` 发卡，接收者 open_id 由第二个参数或环境变量 `LARK_PREVIEW_TO` 指定。
