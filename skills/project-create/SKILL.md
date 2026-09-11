---
name: project-create
description: "Create a ~/claude-projects folder + its p-skill. Trigger /project-create, 'create a project'."
---

A project is a knowledge folder `~/claude-projects/<name>/` plus a skill `/p-<name>` that loads it. The user gives the context once and never re-explains it.

This skill creates one. It never runs a project, that is `/p-<name>`'s job.

## Interview

One question at a time, never guess:

1. Name, kebab-case. The folder and the skill both take it, so it has to be free (see The p-skill).
2. One line: what this is, what the user uses it for.
3. Durable context they already hold: configs, IDs, paths, decisions, footguns.
4. Rules the skill must respect. Anything destructive, anything that costs money, anything with a live blast radius.

## Scaffold

```
~/claude-projects/<name>/
  CLAUDE.md        the brain, template below
  claude-memory/   flat, one fact per file, kebab-case names
  resources/       scripts, docs, PDFs, exports, assets. Free-form, subfolders fine
  CHANGELOG.md     newest first, one dated line per change
```

Every durable fact from the interview becomes a `claude-memory/` file and an index bullet, now, not later. `CHANGELOG.md` opens with the create line.

Folder already exists → fill the gaps, never clobber. Existing notes get read and folded in, not replaced.

An external system pointing at a directory (a launchd plist, a registered Raycast script folder, a running app) keeps that directory where it is at the top level, and gets a line under `Where things are`. Everything else lives in `resources/`.

## CLAUDE.md template

````
# <name>: <one line what it is>

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

<powers, footguns, hard safety rules from the interview>

## Memories
<one bullet per claude-memory file. The bullet is the lazy-read trigger, so it names the nouns that should make you open the file.>

## Hot facts
<what is needed nearly every session, inline. Paths, binaries, the two commands that always run.>

## Where things are
<resources/ index, top-level code dirs, sibling projects and their p-skills.>
````

Changing the template block means restamping `How to work here` in every existing project the same turn, so the rules never fork. `### Project-specific` is the user's, it is never rewritten.

## The p-skill

The `p-` prefix keeps projects apart from regular skills. `p-<name>` must be free: scan `~/.claude/skills`, and if anything already answers to that name, stop and ask for another one.

The body is a loader. Every behavioural rule lives in the project's `CLAUDE.md`, so it is one edit per project and never drifts between the skill and the folder.

```
---
name: p-<name>
description: <what it is + the nouns the user would say>. Trigger /p-<name>, "<phrases>".
---

<one line what this project is>

Knowledge lives in `~/claude-projects/<name>/`, not here. Read its `CLAUDE.md` first, silently, then work the request.

`How to work here` in that file is binding: same-turn writes, changelog lines, `resources/`, and its project-specific rules.
```

The description is the only thing the model sees when deciding to load a project, so it stays hand-tuned: under 50 tokens, the concrete nouns the user says out loud, always trigger phrases. Model-invocable, no `disable-model-invocation`.

## Finish

Confirm the folder path, what got written, and the new `/p-<name>` trigger. Migrated from somewhere → update the old pointers.
