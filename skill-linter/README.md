# skill-linter

Validates Claude Code **skills**, **subagents**, and **slash commands** for
correct frontmatter, quality descriptions, dead references, and stale model IDs —
then reports the problems with concrete fixes.

It specifically catches the **swapped-frontmatter** class of bug: command-style
frontmatter (`allowed-tools`, `$ARGUMENTS`) sitting in a `SKILL.md`, or skill-style
frontmatter (`triggers:`, no `allowed-tools`) sitting in a command file — the exact
issue that can silently break a `/command` or a skill.

## Checks

- **Frontmatter by type** — skills need `name`+`description` (no `$ARGUMENTS`/`allowed-tools`); subagents need `name`+`description`; commands that spawn subagents need `Task(...)` in `allowed-tools`, and must not carry `triggers:`.
- **Description quality** — third-person, says what + when, non-empty, not duplicated.
- **Dead references** — `[text](path)` links and referenced files that don't exist.
- **Stale model IDs** — hardcoded old ids, or a `model:` that contradicts the file name.
- **Install wiring** — assets the installer forgets, or installer entries with missing sources.

## Install

Installed by the repo `install.sh`. Manually:

```bash
mkdir -p ~/.claude/skills/skill-linter
cp skill-linter/SKILL.md ~/.claude/skills/skill-linter/SKILL.md
cp skill-linter/extras/skill-linter-jimmy-command.md ~/.claude/commands/skill-linter-jimmy.md
```

## Use

- `/skill-linter-jimmy` — lint everything under `~/.claude`.
- `/skill-linter-jimmy .` — lint the current repo of skills/agents (e.g. this one).
- Or: "lint my skills" / "check my agents' frontmatter".
