# Wrapping a CLI: display brightness

Example of wrapping a third-party CLI in a script command.

- A CLI like `betterdisplaycli` (installed via Homebrew, the companion app must be running) can set external display brightness.
- Set: `betterdisplaycli set -nameLike=<DisplayName> -brightness=50%`. It also accepts a 0.0 to 1.0 value.
- Read back: `betterdisplaycli get -nameLike=<DisplayName> -brightness`.
- Keep the display name generic, use `<DisplayName>` or "your external display". Do not hardcode a monitor model.

The pattern: find a CLI that does the thing, then wrap it in a one-line Raycast script with an argument for the variable part.
