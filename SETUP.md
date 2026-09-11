# Setup

> Human: run `claude "Read SETUP.md and follow it"` from inside this cloned repo, or paste that line into a Claude Code session here. Claude does the rest.

You are Claude, installing claude-simple-projects. Follow the steps in order. Ask one question at a time and wait for the answer.

## 1. Install the skills

1. Create `~/claude-projects/` if it does not exist. Every project lives here.
2. Copy `skills/project-create/` to `~/.claude/skills/project-create/`.
3. Copy `skills/past-conversations/` to `~/.claude/skills/past-conversations/`. Projects call it when their memory has nothing on a topic.

If either skill folder already exists, ask before overwriting it.

Confirm both are installed: `/project-create` (or "create a project") makes a project, `/past-conversations` searches past Claude Code chats.

## 2. Offer to create the first project

Ask: "Want to create your first project now, or stop here?"

If they stop, you are done. If they want one, follow `skills/project-create/SKILL.md` from Interview to Finish.

## 3. Hand off

1. Show what was created: the folder path, the files, and the new `/p-<name>` trigger.
2. Tell them how it runs from here: call `/p-<name>` to load the project. The rules under `How to work here` in its `CLAUDE.md` make the agent write new facts to `claude-memory/` the same turn, log every change in `CHANGELOG.md`, and search past chats before saying it doesn't know.
3. Point them at `examples/raycast/` for a real project to copy the shape from. Already have a notes folder? Move it to `~/claude-projects/<name>/` and run `/project-create`, it folds the notes in.
