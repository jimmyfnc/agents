---
allowed-tools: Task(security-review), Bash, Read, Grep, Glob
argument-hint: [path | --full]
description: Run a security-focused code review with OWASP mapping, scanner-backed checks, and vulnerability detection
---

Run the `security-review` agent on this project. Scope: `$ARGUMENTS`

Use the Task tool with `subagent_type: "security-review"`:

- No args → "Run a security review on this project's recent changes."
- `<path>` → "Run a security review scoped to `<path>`."
- `--full` / `--audit` → "Run a full security audit of the entire codebase."
