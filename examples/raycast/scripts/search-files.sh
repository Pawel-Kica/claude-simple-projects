#!/bin/bash

# @raycast.schemaVersion 1
# @raycast.title Search Files
# @raycast.mode fullOutput
# @raycast.icon 🔎
# @raycast.packageName File Tools
# @raycast.argument1 { "type": "text", "placeholder": "filename pattern, e.g. *.pdf" }

# @raycast.author Example Developer
# @raycast.authorURL https://example.com
# @raycast.description Search the home directory for files matching a pattern.

pattern="$1"

if [ -z "$pattern" ]; then
  echo "No pattern given."
  exit 1
fi

echo "Searching ~ for: $pattern"
echo

matches=$(find "$HOME" -iname "$pattern" 2>/dev/null)

if [ -z "$matches" ]; then
  echo "No matches found."
else
  echo "$matches"
fi
