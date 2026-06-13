#!/bin/bash

# @raycast.schemaVersion 1
# @raycast.title Display Brightness
# @raycast.mode silent
# @raycast.icon 💡
# @raycast.packageName Display Tools
# @raycast.argument1 { "type": "text", "placeholder": "level 1-10" }

# @raycast.author Example Developer
# @raycast.authorURL https://example.com
# @raycast.description Set external display brightness, 1 to 10 maps to 10% to 100%.

level="$1"
display="<DisplayName>"

if ! [[ "$level" =~ ^([1-9]|10)$ ]]; then
  echo "Level must be a whole number from 1 to 10."
  exit 1
fi

if ! command -v betterdisplaycli >/dev/null 2>&1; then
  echo "betterdisplaycli not found. Install it via Homebrew and start the app."
  exit 1
fi

percent=$((level * 10))
betterdisplaycli set -nameLike="$display" -brightness="${percent}%"
echo "Brightness set to ${percent}%."
