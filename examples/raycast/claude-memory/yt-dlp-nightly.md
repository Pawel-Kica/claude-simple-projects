# yt-dlp nightly

Use the yt-dlp nightly build, not Homebrew stable. Stable lags behind YouTube's blocks and gets `HTTP Error 403: Forbidden` on every adaptive format (`-F` lists formats fine, the download 403s). Nightly works.

The nightly standalone binary lives at `~/.local/bin/yt-dlp`, which comes before `/opt/homebrew/bin` in PATH, so it shadows brew's copy without uninstalling it. Refresh with `yt-dlp --update-to nightly`.

Dead ends, do not retry: `--cookies-from-browser chrome` decrypts cookies but only surfaces progressive format 18 (360p). `player_client=tv` returns storyboards only. `tv_embedded` is no longer a supported client.
