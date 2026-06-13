# Script location and registration

- Raycast script commands live in `~/claude-projects/raycast/scripts/`.
- Register the directory in Raycast: Settings -> Extensions -> Script Commands -> Add Script Directory, point it at that folder.
- Each script is a normal file (bash, zsh, python, node, swift, or applescript) with an `@raycast.*` comment header block at the top.
- Always `chmod +x` a new script and run it once from the terminal to test before declaring it done.
- Metadata edits (rename, add an argument, change the mode) are picked up live. No restart needed.
- Scaffold a new one fast via Raycast -> "Create Script Command", which writes the header block for you.
