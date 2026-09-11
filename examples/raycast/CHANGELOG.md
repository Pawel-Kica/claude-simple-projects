# Changelog

What moved in this project and why. Newest first, one line per change, written the same turn the change happens.

- 2026-08-26 - `download-as-mp3.sh` and `download-as-mp4.sh` now export PATH and log yt-dlp stderr. Raycast's bare PATH hid `~/.local/bin`, so both failed from Raycast while the terminal worked. New memory `raycast-script-path`.
- 2026-08-19 - Switched to yt-dlp nightly in `~/.local/bin`, Homebrew stable 403'd on every YouTube format. New memory `yt-dlp-nightly`.
- 2026-07-06 - Added `snippet-import-deeplink`: `raycast://snippets/import` adds snippets from the CLI.
- 2026-06-15 - Added `snippets-storage-and-editing` after a bulk keyword rename. The snippets DB is encrypted, JSON export/import is the only route.
- 2026-06-13 - Project created: script location, metadata fields, modes, Raycast v2 facts. First script `search-skills.sh`.
