# Raycast snippets: storage and bulk editing

Snippets are not files. They live in `~/Library/Application Support/com.raycast.macos/raycast-enc.sqlite`, which is encrypted (SQLCipher, `sqlite3` returns "file is not a database"). The DB can't be read or edited directly.

The only route for bulk edits is **Export Snippets**, edit the JSON, **Import Snippets**. The JSON is an array of `{name, text, keyword}`, keyword optional. Import skips duplicates by an undocumented rule, so to rename or replace cleanly, delete all snippets first, then import the full edited file. There is no bulk delete, ⌘-click to multi-select in Search Snippets.

Rename keywords with a small transform: load the JSON, `s["keyword"] = kw.replace("!", "1")`, dump with `ensure_ascii=False, indent=2`.
