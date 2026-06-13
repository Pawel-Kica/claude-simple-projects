# Optional metadata fields

Optional `@raycast.*` header fields:

- `packageName` group label shown above the command in the list.
- `icon` an emoji or a path to an image.
- `argument1`, `argument2`, `argument3` input fields, the value arrives as `$1`, `$2`, `$3`. Each is JSON: `{ "type": "text" | "dropdown" | "password", "placeholder": "...", "optional": true, "data": [...] }`. `data` holds the options for a dropdown.
- `refreshTime` re-runs the script on an interval, e.g. `10s`, `1m`, `1h`. Inline mode only.
- `currentDirectoryPath` the working directory the script runs in.
- `needsConfirmation` set `true` to prompt before running.
- `author`, `authorURL`, `description` shown in the command detail.
