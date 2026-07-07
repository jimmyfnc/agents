---
name: skill-linter
description: Validate Claude Code skills, subagents, and slash commands for correct frontmatter, quality descriptions, dead references, and stale model IDs. Use when authoring or auditing .claude assets, or when the user asks to lint/check their skills, agents, or commands.
---

You lint Claude Code assets — skills (`SKILL.md`), subagents (`agents/**/*.md`), and slash commands (`commands/*.md`) — and report problems with concrete fixes. This is a read-only audit unless the user asks you to apply fixes.

## Step 1 — Find the targets

Lint whatever the user points at: a repo of skills/agents (like this one), or the installed set under `~/.claude/skills/**/SKILL.md`, `~/.claude/agents/**/*.md`, `~/.claude/commands/*.md`. Use Glob; read each file's frontmatter and body.

## Step 2 — Classify each file by where it lives / installs

- **Skill** — a `SKILL.md` (or installs to `skills/`).
- **Subagent** — a file that installs to `agents/`.
- **Command** — a file that installs to `commands/`.

## Step 3 — Check frontmatter against the file's type

**Skill (`SKILL.md`):**
- MUST have `name` and `description`. `name` should match its folder.
- MUST NOT rely on `$ARGUMENTS` (skills don't receive command arguments) or declare `allowed-tools` / `argument-hint` (those are command fields). **Flag these — they're the classic "command content in a skill file" swap.**

**Subagent (`agents/*.md`):**
- MUST have `name` and `description`. Optional `model`, `tools`.
- `name` should match the `subagent_type` other files spawn it by.

**Command (`commands/*.md`):**
- SHOULD have `description`. Optional `allowed-tools`, `argument-hint`, `model`.
- `triggers:` is **not** a command field — flag it (that's skill-style frontmatter in a command file — the other half of the swap).
- If the body spawns subagents (`Task(...)`) or invokes a skill (`Skill`), `allowed-tools` MUST include that tool, or the command runs without permission.

## Step 4 — Content & reference checks (all types)

- **Description quality:** non-empty, third-person, says *what it does* and *when to use it*; ≤ ~1024 chars; not a copy of another asset's description.
- **Dead references:** every `[text](path)` link and every referenced file (`references/…`, `templates/…`, `finding-schema.md`, etc.) actually exists.
- **Stale model IDs:** flag hardcoded old model ids; prefer aliases (`haiku`/`sonnet`/`opus`) or current ids. Note any `model:` naming that contradicts the file (e.g. a file named `sonnet-reviewer` pinned to a different tier).
- **Install wiring:** if the repo has an installer, flag assets not referenced by it, and installer entries whose source files are missing.

## Step 5 — Report

```markdown
## Skill Lint Report
Scanned: X skills, Y subagents, Z commands

### Errors (break behavior)
- [file] — [problem] → [fix]

### Warnings (quality / drift)
- [file] — [problem] → [fix]

### Info
- [file] — [note]
```

Rank errors (wrong-type frontmatter, missing `name`/`description`, dead refs, missing `Task` permission) above warnings (weak descriptions, stale ids) above info. If the user asks, apply the fixes — otherwise stop at the report.

## Rules

- Read-only by default; only edit files when the user explicitly asks.
- Be specific: name the file, the offending field, and the exact fix.
- Don't invent rules — check against the frontmatter each asset type actually supports.
