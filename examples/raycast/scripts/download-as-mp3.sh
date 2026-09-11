#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Download as MP3
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🎵
# @raycast.packageName Media

# Documentation:
# @raycast.description Download audio from the clipboard URL as MP3 via yt-dlp to Downloads

# Raycast runs script commands with a bare PATH (no login shell), so ~/.local/bin
# (yt-dlp nightly) and /opt/homebrew/bin (ffmpeg, needed for the mp3 transcode) are missing.
# Nightly must win over brew's stale copy or every adaptive format 403s.
export PATH="$HOME/.local/bin:/opt/homebrew/bin:/usr/local/bin:$PATH"

YTDLP="$(command -v yt-dlp)"
LOG="/tmp/raycast-download-mp3.log"

if [[ -z "$YTDLP" ]]; then
  echo "yt-dlp not found"
  exit 1
fi

URL="$(pbpaste | tr -d '[:space:]')"

if [[ ! "$URL" =~ ^https?:// ]]; then
  echo "No URL in clipboard"
  exit 1
fi

DEST="$HOME/Downloads"
mkdir -p "$DEST"

(
  FILEPATH=$("$YTDLP" \
    -x --audio-format mp3 --audio-quality 0 \
    -o '%(title)s.%(ext)s' \
    -P "$DEST" \
    --no-playlist \
    --print after_move:filepath \
    "$URL" 2>"$LOG" | tail -1)

  if [[ -n "$FILEPATH" ]]; then
    FILENAME="$(basename "$FILEPATH")"
    osascript -e "display notification \"${FILENAME//\"/\\\"}\" with title \"Downloaded\""
  else
    osascript -e "display notification \"Failed, see $LOG\" with title \"Download as MP3\""
  fi
) &
disown

echo "Downloading..."
