# Raycast version

Uses only "Raycast Beta.app" (v2, bundle `com.raycast-x.macos`), not the old Raycast.app. Both sit in /Applications and the old one keeps a dormant RaycastAppIntents process, ignore it. v2 is a cross-platform rebuild (macOS + Windows) still in beta. WebSearch the official docs (manual.raycast.com, developers.raycast.com) before declaring any metadata field invalid.

Beta registers the URL schemes `raycast://` and `raycast-x://`, but the old app may catch a plain `open raycast://`. Always target it explicitly: `open -a "Raycast Beta" "raycast://..."`.

Script command vs extension. A script command is quick automation in any language (bash, zsh, python, node, swift, applescript) that runs and shows output, no UI. It is the default. An extension uses the Raycast API, is TypeScript only, and supports rich UI, AI extensions and store sharing.
