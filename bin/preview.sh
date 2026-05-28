#!/usr/bin/env bash
# preview.sh — 把一个 .card 文件发到飞书 DM 预览（--as bot）
#
# 用法:
#   bash bin/preview.sh <card文件> <接收者open_id>
#   # 或用环境变量指定接收者： LARK_PREVIEW_TO=<open_id> bash bin/preview.sh <card文件>
#
# 接收者 open_id 由第二个参数或环境变量 LARK_PREVIEW_TO 指定。会自动：
#   1. 抽出 dsl（容忍 .card 外壳或裸 dsl）
#   2. 删掉 img_key 还是 IMG_KEY_TODO 的占位图（假 key 会让整卡渲染失败）
#   3. 把 HELP_DOC_URL_TODO 占位链接换成飞书帮助中心首页（可点）
#   4. lark-cli im +messages-send --as bot 发出
set -euo pipefail

CARD="${1:?用法: bash bin/preview.sh <card文件> <接收者open_id>}"
TO="${2:-${LARK_PREVIEW_TO:?需要接收者 open_id：作为第二个参数传入，或设置环境变量 LARK_PREVIEW_TO}}"
TMP="$(mktemp /tmp/bbcard.XXXXXX.json)"
trap 'rm -f "$TMP"' EXIT

python3 - "$CARD" "$TMP" <<'PY'
import json, sys
card = json.load(open(sys.argv[1], encoding="utf-8"))
dsl = card.get("dsl", card)   # 容忍 .card 外壳 或 裸 dsl

def scrub(o):
    if isinstance(o, dict):
        # 任意层级的 elements 数组里，去掉占位图
        if isinstance(o.get("elements"), list):
            o["elements"] = [e for e in o["elements"]
                             if not (isinstance(e, dict)
                                     and e.get("tag") == "img"
                                     and e.get("img_key") == "IMG_KEY_TODO")]
        for b in (o.get("behaviors") or []):
            for k in ("default_url", "pc_url", "ios_url", "android_url"):
                if b.get(k) == "HELP_DOC_URL_TODO":
                    b[k] = "https://www.feishu.cn/hc/zh-CN"
        for v in o.values():
            scrub(v)
    elif isinstance(o, list):
        for v in o:
            scrub(v)

scrub(dsl)
json.dump(dsl, open(sys.argv[2], "w", encoding="utf-8"), ensure_ascii=False)
PY

echo "→ 发送预览到 $TO ..."
lark-cli im +messages-send \
  --user-id "$TO" \
  --msg-type interactive \
  --content "$(cat "$TMP")" \
  --as bot
