#!/bin/bash

# @raycast.schemaVersion 1
# @raycast.title Display Brightness
# @raycast.mode silent
# @raycast.packageName Displays
# @raycast.icon 🔆
# @raycast.argument1 { "type": "text", "placeholder": "1-10 (x10%)" }
# @raycast.description Set external display brightness via BetterDisplay. 1 = 10%, 10 = 100%.

# Raycast runs scripts with a bare PATH, betterdisplaycli lives in Homebrew's bin.
export PATH="/opt/homebrew/bin:$PATH"

# Replace with a substring of your display's name, as BetterDisplay shows it.
display="<DisplayName>"
n="$1"

if ! [[ "$n" =~ ^([1-9]|10)$ ]]; then
  echo "Use 1-10 (got: $n)"
  exit 1
fi

if ! pgrep -xq BetterDisplay; then
  echo "BetterDisplay is not running"
  exit 1
fi

pct=$((n * 10))
betterdisplaycli set -nameLike="$display" -brightness="${pct}%"
echo "Displays set to ${pct}%"
