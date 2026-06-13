# Output modes

`@raycast.mode` takes one of four values:

- `fullOutput` opens a result window with all stdout.
- `compact` shows the last line of output in a toast.
- `inline` shows the first line of output in the command's list item, auto-refreshes via `refreshTime`.
- `silent` shows the last line in a HUD after the Raycast window closes.
