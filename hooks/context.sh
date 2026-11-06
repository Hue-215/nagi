#!/bin/bash
# instructions.mdをadditionalContextとして出力する。引数はフックのイベント名
# SubagentStartは標準出力のテキストを文脈に入れないので、SessionStartもJSONにそろえる
# jqの無い端末(WindowsのGit Bashなど)でも動くよう、エスケープは自前で行う
set -eu

text=""
while IFS= read -r line || [ -n "$line" ]; do
  line=${line//\\/\\\\}
  line=${line//\"/\\\"}
  line=${line//$'\t'/\\t}
  # 残った制御文字(CRを含む)はJSONを壊すので取り除く
  line=${line//[[:cntrl:]]/}
  text+="$line\\n"
done < "${CLAUDE_PLUGIN_ROOT}/instructions.md"

printf '{"hookSpecificOutput":{"hookEventName":"%s","additionalContext":"%s"}}\n' "$1" "$text"
