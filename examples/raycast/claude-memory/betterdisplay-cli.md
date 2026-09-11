# BetterDisplay CLI

- `betterdisplaycli` installed via Homebrew (`/opt/homebrew/bin/betterdisplaycli`). The BetterDisplay app must be running.
- Brightness control works in the free version, no Pro needed.
- `-nameLike=<DisplayName>` matches a substring of the display name, so one call hits every external display that shares it.
- Set: `betterdisplaycli set -nameLike=<DisplayName> -brightness=50%` (also accepts 0.0-1.0). Get: `betterdisplaycli get -nameLike=<DisplayName> -brightness` prints `0.5`, one value per matched display.
- Docs: https://github.com/waydabber/BetterDisplay/wiki/Integration-features,-CLI
