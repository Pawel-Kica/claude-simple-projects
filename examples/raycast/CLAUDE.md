# raycast: Raycast launcher and automation workspace. Script commands first, extensions only when a script's plain output is not enough.

## How to work here
project-create owns this section. Add your own rules under Project-specific instead.

- **Write the moment a fact lands.** A durable fact appears in the conversation (config, ID, path, decision, rule, gotcha, correction) and its `claude-memory/` file is written before the reply goes out, silently. No turn ends with a durable fact living only in the chat.
- **The user's word wins.** They say something that contradicts a file, rewrite the file that turn. Don't ask.
- **Memory holds now, the changelog holds what moved.** Fact files carry current state and no history. Every file created, edited or dropped adds one line to the top of `CHANGELOG.md`: `YYYY-MM-DD - what moved, why`.
- **These files are a cache, not the truth.** An earlier session may have skipped a write, and the user may have worked on this somewhere else entirely. Something looks stale, thin or missing → `/past-conversations` before trusting it or saying you don't know.
- **Leave every file you touch true.** Disk contradicts a line (a script, path, setting or fact that is gone) and you fix it before you answer, same turn. A memory file whose subject no longer exists moves to `/tmp`, loses its index bullet, and gets a changelog line. There is no cleanup pass and no cleanup script, this is the cleanup. A stale line costs more than a missing one.
- **`resources/` is open.** Anything worth keeping goes there without asking, then gets a line under `Where things are`.
- **Verify against reality when it is checkable**, re-ask when it is ambiguous.
- Match the user's language, lead with the conclusion, confirm what is done. No em dashes.

### Project-specific
The user owns this. Leave it alone unless they ask.

#### Powers
- Write and edit script commands in `scripts/`, one file with the `@raycast.*` header block. `chmod +x` and test-run before declaring done. Metadata reference is `resources/docs.md`.
- `scripts/` stays at the top level. Raycast has that exact path registered under Settings -> Script Commands, so moving it unregisters every script.
- Richer needs (UI, AI extensions) get a TypeScript extension via the Raycast API. Default to a script command unless the task needs UI.

## Memories
- [Script location](claude-memory/script-location.md) - where scripts live, why top level, chmod/test rules
- [Script metadata: required fields](claude-memory/script-metadata-required-fields.md) - the three mandatory `@raycast.*` fields
- [Script metadata: optional fields](claude-memory/script-metadata-optional-fields.md) - packageName, icon, argument1..3, refreshTime, needsConfirmation, author
- [Script modes](claude-memory/script-modes.md) - the four `@raycast.mode` values and what each does
- [Scripts built](claude-memory/scripts-built-list.md) - the four scripts in `scripts/`
- [Raycast version](claude-memory/raycast-version.md) - Raycast Beta.app (v2) only, target deeplinks with `open -a "Raycast Beta"`, script command vs extension
- [Raycast script PATH](claude-memory/raycast-script-path.md) - bare PATH, no login shell, export ~/.local/bin + /opt/homebrew/bin, log stderr, test with `env -i`
- [yt-dlp nightly](claude-memory/yt-dlp-nightly.md) - brew stable 403s on YouTube, nightly at ~/.local/bin shadows it, `yt-dlp --update-to nightly`
- [BetterDisplay CLI](claude-memory/betterdisplay-cli.md) - betterdisplaycli brightness control, free version, `-nameLike` substring match
- [Snippets storage & editing](claude-memory/snippets-storage-and-editing.md) - encrypted DB, edit only via Export/Import JSON, delete-then-import to rename
- [Snippet import deeplink](claude-memory/snippet-import-deeplink.md) - `raycast://snippets/import?snippet=<json>` adds snippets from the CLI, user confirms in UI

## Hot facts
- Scripts live in `~/claude-projects/raycast/scripts/`. Registered via Settings -> Script Commands -> Add Script Directory.
- Each script is a normal file with an `@raycast.*` comment header block. Always `chmod +x` and test before declaring done.
- Metadata edits (rename, add argument, change mode) are picked up live, no restart. Scaffold fast via Raycast -> "Create Script Command".
- Running Raycast v2 (public beta): WebSearch official docs before declaring any metadata field invalid.

## Where things are
- `scripts/`: the script commands. Top level, not `resources/`, because Raycast has the path registered.
- `resources/docs.md`: official doc links (script commands manual, repo templates, arguments/output-modes docs, extensions API, v2 changelog).
