# Script location

Raycast script commands live in `~/claude-projects/raycast/scripts/`, at the top level and not under `resources/`, because Raycast has that exact path registered under Settings -> Script Commands -> Add Script Directory. Moving it unregisters every script.

Each script is a normal file with an `@raycast.*` comment header block. Always `chmod +x` and test before declaring done. Metadata edits (rename, add argument, change mode) are picked up live, no restart. Scaffold fast via Raycast -> "Create Script Command".
