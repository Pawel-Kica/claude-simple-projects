# Scripts built

The four scripts in `scripts/`.

- `search-skills.sh`: lists Claude Code skill names from `~/.claude/skills/*/SKILL.md`, three per line, filtered by an optional query. Mode fullOutput. (First script.)
- `display-brightness.sh`: sets brightness on external displays via `betterdisplaycli -nameLike=<DisplayName>`. Argument 1-10 = 10%-100%. Mode silent. See [[betterdisplay-cli]].
- `download-as-mp4.sh`: downloads the video at the clipboard URL via yt-dlp to `~/Downloads`. Mode silent, HUD "Downloading..." and exits immediately while yt-dlp forks to the background via `& disown`. macOS notification with the filename when done. Always `--no-playlist`. See [[yt-dlp-nightly]] and [[raycast-script-path]].
- `download-as-mp3.sh`: audio twin of download-as-mp4, `yt-dlp -x --audio-format mp3 --audio-quality 0`. Same background fork and notification.
