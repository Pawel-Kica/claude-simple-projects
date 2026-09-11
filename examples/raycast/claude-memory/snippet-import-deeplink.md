# Snippet import deeplink

Add snippets from the CLI without touching the encrypted DB:

```
open -a "Raycast Beta" "raycast://snippets/import?snippet=<urlencoded JSON {name, text, keyword}>"
```

Always pass `-a "Raycast Beta"`, plain `open raycast://` may route to the old Raycast.app.

- One `snippet=` param per snippet, repeat it for batches (same format the ray.so snippet explorer uses).
- Opens Raycast's import view prefilled, the user confirms in the UI.
- Computer use can't control Raycast (overlay app, not in the grantable app list). The deeplink is the scriptable route.
