# Setup

> Human: run `claude "Read SETUP.md and follow it"` from inside this cloned repo, or paste that line into a Claude Code session here. Claude does the rest.

You are Claude, installing claude-simple-projects. Follow the steps in order. Ask one question at a time and wait for the answer.

## 1. Install the skill

1. Create `~/claude-projects/` if it does not exist. This is the home for every project.
2. Copy `skill/SKILL.md` from this repo to `~/.claude/skills/project-manager/SKILL.md`, creating folders as needed. This gives the user `/project-manager` with its three modes: create, adopt, update-all.

Confirm the skill is installed and tell the user it is triggered by `/project-manager` or phrases like "create a project".

## 2. Offer to create the first project

Ask: "Want to create your first project now, or stop here?"

If they stop, you are done. If they want one, run the **create** flow from the skill (sections 2 to 5 of `skill/SKILL.md`):

1. Ask the name (kebab-case), what it is in one line, and where the starting context comes from: a blank start, an existing notes folder, or this conversation.
2. Interview for the initial durable facts and any hard rules the project must respect. One question at a time.
3. Scaffold `~/claude-projects/<name>/`: `CLAUDE.md` with a `# Memories` index, `claude-memory/` with one file per fact, an empty `notes/`, a thin `sessions.md`, and a one-line `README.md`.
4. Generate the project's own skill at `~/.claude/skills/<name>/SKILL.md` from the spine in section 4 of the skill.

## 3. Hand off

1. Show the user what was created: the folder path, the files, and the new `/<name>` trigger.
2. Tell them how it runs from here: call `/<name>` (or its trigger phrases) to load the project and work with full context. The skill writes new durable facts back to `claude-memory/` and the index automatically, keeps working narrative in `notes/`, and logs each session as one thin line in `sessions.md`.
3. Point them at `examples/raycast/` in this repo for a complete project to copy the shape from, and at `/project-manager adopt` to wrap a folder they already have.
