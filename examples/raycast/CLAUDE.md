A Raycast launcher and automation workspace. Script commands first, extensions only when a script's plain output is not enough.

# Memories

- [Script location and registration](claude-memory/script-location.md) - where scripts live and how to register the directory in Raycast.
- [Required metadata fields](claude-memory/script-metadata-required-fields.md) - the three `@raycast.*` fields every script needs.
- [Optional metadata fields](claude-memory/script-metadata-optional-fields.md) - icon, arguments, refreshTime, confirmation, and the rest.
- [Output modes](claude-memory/script-modes.md) - the four `@raycast.mode` values and how each renders.
- [Raycast version](claude-memory/raycast-version.md) - on v2 beta, and script command vs extension.
- [Wrapping a CLI: display brightness](claude-memory/display-brightness-cli.md) - the find-a-CLI-and-wrap-it pattern.
- [Scripts built so far](claude-memory/scripts-built-list.md) - the commands shipped in this workspace.

## Most useful

- Scripts live in `~/claude-projects/raycast/scripts/`. Register the folder via Settings -> Extensions -> Script Commands -> Add Script Directory.
- Each script is a file with an `@raycast.*` header block. After writing one, `chmod +x` it and run it once to test.
- Required header fields: `@raycast.schemaVersion 1`, `@raycast.title`, `@raycast.mode`.
- Metadata edits (rename, add an argument, change mode) are picked up live, no restart.
- v2 is beta, behavior shifts between builds. Web-search the official docs before declaring a metadata field invalid.

## Where things are

- `notes/docs.md` the official Raycast doc links.
- `sessions.md` the thin session log.
- `scripts/` the actual script command files.
- `README.md` the file map.
