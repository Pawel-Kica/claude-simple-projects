---
name: project-manager
description: "Create and maintain context projects in ~/claude-projects/. A project is a knowledge folder plus a generated skill that loads it, so you never re-explain your setup. Trigger /project-manager, 'create a project', 'adopt this folder as a project', 'update all projects'."
argument-hint: <create | adopt | update-all> [name]
---

# Project Manager

A project is a curated knowledge folder at `~/claude-projects/<name>/` plus a generated `/<name>` skill that loads it. You give the context once, the project holds it, the skill means you never re-explain. Think of it as Claude Desktop's Projects, except it lives on your disk, loads on demand, and writes back what it learns.

This skill does three things: **create**, **adopt**, and **update-all**. It does not run a project. Working on a project happens through that project's own `/<name>` skill.

Projects live in `~/claude-projects/`, a plain folder at home root, not inside any repo or note vault. That keeps them out of your codebases and out of cloud-note sync, and gives every agent one place to look.

## 0. Pick the mode

- **create** - the user describes something fresh, or says "create a project". Build the folder and skill from a short interview. Sections 2 to 5.
- **adopt** - there is already a folder of notes, or the user wants to capture the current conversation as a project. Wrap what exists. Section 6.
- **update-all** - the user says "update all", "clean the projects". A cleanup pass over every project. Section 7.

If `~/claude-projects/<name>/` already exists, do not clobber it. Offer to update its skill or run update-all.

## 1. The file model

Every project folder works the same way: a brain doc with an index, a flat memory folder, working notes, and a thin session log.

| File | What it holds |
|---|---|
| `CLAUDE.md` | The brain. A one-line "what this is", a `# Memories` index (one bullet per memory file), the most-reached-for facts inline, and a "where things are" pointer block. Read first, kept clean. |
| `claude-memory/` | Flat folder, one durable fact per `.md` file (a config value, ID, spec, rule, settled decision), kebab-case name. The oft-referenced facts, each indexed in `CLAUDE.md`. |
| `notes/` | Working narrative the agent co-creates: plans, gotcha lists, status snapshots, drafts, checklists. Not always indexed. |
| `sessions.md` | A thin session-id list, one line each. Not prose summaries (see section 5). |
| `README.md` | A minimal human-facing one-liner. |

The split: a durable fact reached for repeatedly is a memory (one fact, one file); working or transient narrative is a note. When unsure, prefer memory. A project's knowledge lives inside its own folder, never scattered elsewhere. Pointers to live systems the project operates on (configs, source, a cloud account) are fine.

The memory format is the same one as [claude-simple-memory](https://github.com/Pawel-Kica/claude-simple-memory): frontmatter (`name`, `description`, `type` from `user`/`feedback`/`project`/`reference`) plus the fact. A project is that memory system scoped to one folder, plus `notes/` and `sessions.md`.

The one global rule: no em dashes anywhere.

## 2. Create: interview, do not assume

Gather just enough to make the project useful. Ask one question at a time, re-ask, never silently guess:

- **Name** (kebab-case, becomes `~/claude-projects/<name>/` and `/<name>`).
- **What it is** in one line, and what the user will use it for.
- **Source of the starting context**, one of:
  - *blank* - start empty, the project fills itself through use.
  - *a folder* - point at an existing notes folder to pull facts from (this overlaps with adopt, section 6).
  - *this conversation* - mine the current chat for durable facts worth keeping.
- **The initial durable facts** worth saving so the user never repeats them.
- **Any hard rules or footguns** the project skill must respect (a sacred path, a destructive command to avoid, a safety check before acting).

Keep it short. The project grows itself later through use.

## 3. Create: scaffold the folder

Create `~/claude-projects/<name>/` with:

- `CLAUDE.md` seeded from the interview, with a `# Memories` index (empty at first), a "Most useful" block, and a "Where things are" block.
- `claude-memory/` with one one-fact file per durable fact that surfaced, each indexed in `CLAUDE.md`.
- `notes/` (empty, or with a first working note if the conversation produced one).
- `sessions.md` (empty, or seeded with this session, see section 5).
- `README.md`, a one-line description.

## 4. Create: generate the per-project skill

Write `~/.claude/skills/<name>/SKILL.md`. Fill this spine, adapting the powers and rules to the project:

```
---
name: <name>
description: <one line on the project>. Loads the curated knowledge in ~/claude-projects/<name>/ so you never re-explain, works with full powers, writes back what it learns, logs the session id. Trigger /<name> or "<natural phrases>".
---

# <Project>

<one line on what this project is>

Persistent-memory project skill. Load the folder, work with the user, write back so the next session is smarter.

## 1. Load memory first
Read `CLAUDE.md` first; it holds the `# Memories` index and the most-reached-for facts. Lazy-read an individual `claude-memory/*.md` file when a memory bullet matches the request, rather than reading the whole folder. Read `notes/` files when their topic is relevant. Load silently, do not report status on launch, then handle the request. If the folder is missing, say so, do not invent it.

## 2. Question the memory
The files are a prior, not gospel, and may be stale.
- Verify against reality when checkable (disk, live config, the real world).
- Re-ask the user when something is ambiguous rather than assuming.
- If the user says something new, it supersedes the file. Update the file.

## 3. Act with full powers
<project-specific powers and any hard safety rules>

## 4. Write back after every meaningful exchange
The instant a durable canonical fact surfaces (a config value, ID, spec, rule, settled decision), write or update its one-fact file in `claude-memory/` and add or update its bullet in the `CLAUDE.md` `# Memories` index, in the same turn. Working narrative (drafts, plans, running gotcha lists, status, checklists) goes to `notes/`. Memory is for facts, notes are for narrative; when unsure, prefer memory. Keep both lean: dedupe, update existing files instead of piling new ones, prune what went stale. If in doubt whether it is durable, save it.

Log the session as ONE thin line in `sessions.md` (prepend, reverse-chronological): see the project-manager skill, section 5.

## 5. Conventions
Match the user's language. No em dashes. Lead with the conclusion, confirm what is done, not what is about to be done.
```

## 5. The session log

`sessions.md` is a thin pointer list, not a journal. One line per session, prepended (newest first):

```
<YYYY-MM-DD> · <session-id> · <three-word tag>
```

The session id is the filename of the current Claude Code transcript. Find it with:

```bash
basename "$(ls -t ~/.claude/projects/*/*.jsonl | head -1)" .jsonl
```

No prose summary. The line is a pointer: to recall what actually happened, search your Claude Code transcripts (`~/.claude/projects/*/*.jsonl`) for that id and read it back. This keeps the project lean while leaving a trail to the full history.

## 6. Adopt: wrap what already exists

Two sources:

- **An existing folder of notes.** Read every file. Move or copy it to `~/claude-projects/<name>/`, then reshape it into the file model: pull durable facts into one-fact files under `claude-memory/`, leave narrative in `notes/`, write a clean `CLAUDE.md` index, add `README.md` and `sessions.md`. Do not lose content; when unsure whether something is a fact or a note, keep it as a note.
- **The current conversation.** Mine the chat for durable facts and decisions, write them as memory files, capture any working narrative as a note, then scaffold `CLAUDE.md` around them.

Either way, finish by generating the `/<name>` skill (section 4) and confirming what was created.

## 7. Update-all: clean and regenerate

A cleanup pass over every project. Goal: each project ends with a clean `CLAUDE.md` (tight `# Memories` index, most-reached-for facts inline), a deduplicated `claude-memory/`, and trimmed `notes/`, with stale knowledge dropped.

List the projects first: `ls -d ~/claude-projects/*/`. Then, for each project (run them in parallel as subagents if your setup supports it, otherwise one at a time):

1. Read every file in the project folder.
2. Read `sessions.md`; when a session looks load-bearing, recall it from the transcript (section 5) to recover decisions that never made it into the notes.
3. Dedupe: merge repeated facts into one canonical file, delete stale or wrong knowledge (verify against disk or live config before deleting anything checkable), trim `notes/`.
4. Rewrite `CLAUDE.md` clean: a `# Memories` index covering every file in `claude-memory/` (no dangling bullets, no orphan files), the most-reached-for facts inline, and a "where things are" block. Keep `README.md` a minimal one-liner.
5. Report what changed.

This rewrites `CLAUDE.md` and reorganizes `claude-memory/` and `notes/` wholesale. Old content stays recoverable via git or transcripts. Confirm once before launching, then report the per-project summary.

## Conventions

Match the user's language. No em dashes. Lead with the conclusion, confirm what is done, not what is about to be done.
