---
allowed-tools: Skill, Read, Grep, Glob
argument-hint: [path to lint | empty for ~/.claude]
description: Lint Claude Code skills, subagents, and commands for frontmatter, descriptions, and dead references
---

Run the `skill-linter` skill.

`$ARGUMENTS` is the path to lint — a repo of skills/agents, or empty to lint the installed set under `~/.claude`.

Invoke the skill via the Skill tool (`skill-linter`). Produce the lint report; only apply fixes if the user asks.
