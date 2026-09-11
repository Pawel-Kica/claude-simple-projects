# Raycast script PATH

Raycast runs script commands with a bare PATH, not a login shell. `~/.local/bin` and `/opt/homebrew/bin` are missing, so bare `yt-dlp` or `ffmpeg` resolves to nothing, or to Homebrew's stale copy.

Every script that calls a non-system binary exports PATH first:

    export PATH="$HOME/.local/bin:/opt/homebrew/bin:/usr/local/bin:$PATH"

Symptom: a script fails from Raycast while the same command works in the terminal, which inherits the interactive shell PATH. Resolve the binary once (`YTDLP=$(command -v yt-dlp)`) and write its stderr to a log in `/tmp`, not `/dev/null`, so the failure notification points at a real log.

Test a script the way Raycast runs it:

    env -i HOME="$HOME" PATH=/usr/bin:/bin:/usr/sbin:/sbin /bin/bash <script>
