#!/bin/bash

# @raycast.schemaVersion 1
# @raycast.title Search Skills
# @raycast.mode fullOutput
# @raycast.packageName Claude
# @raycast.icon 🧠
# @raycast.argument1 { "type": "text", "placeholder": "query", "optional": true }
# @raycast.description List Claude Code skill names, three per line, filtered by an optional query.

q="$1"

names=()
while IFS= read -r name; do
  if [ -z "$q" ] || echo "$name" | grep -qi "$q"; then
    names+=("$name")
  fi
done < <(grep -h -m1 '^name:' ~/.claude/skills/*/SKILL.md | sed 's/^name: *//' | sort)

i=0
while [ $i -lt ${#names[@]} ]; do
  a="${names[$i]}"
  b="${names[$((i+1))]:-}"
  c="${names[$((i+2))]:-}"
  if [ -n "$b" ] && [ -n "$c" ]; then
    echo "$a,  $b,  $c"
  elif [ -n "$b" ]; then
    echo "$a,  $b"
  else
    echo "$a"
  fi
  i=$((i + 3))
done
