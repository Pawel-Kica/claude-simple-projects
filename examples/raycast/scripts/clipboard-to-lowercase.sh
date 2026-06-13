#!/bin/bash

# @raycast.schemaVersion 1
# @raycast.title Clipboard to Lowercase
# @raycast.mode silent
# @raycast.icon 🔡
# @raycast.packageName Text Tools

# @raycast.author Example Developer
# @raycast.authorURL https://example.com
# @raycast.description Lowercase whatever text is on the clipboard.

text="$(pbpaste)"

if [ -z "$text" ]; then
  echo "Clipboard is empty."
  exit 0
fi

printf '%s' "$text" | tr '[:upper:]' '[:lower:]' | pbcopy
echo "Clipboard lowercased."
