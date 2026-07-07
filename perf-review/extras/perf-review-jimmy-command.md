---
allowed-tools: Task(perf-review), Bash, Read, Grep, Glob
argument-hint: [path | --full]
description: Run a performance-focused code review with Big O analysis and impact estimation
---

Run the `perf-review` agent on this project. Scope: `$ARGUMENTS`

Use the Task tool with `subagent_type: "perf-review"`:

- No args → "Run a performance review on this project's recent changes."
- `<path>` → "Run a performance review scoped to `<path>`."
- `--full` / `--audit` → "Run a full performance audit of the entire codebase."
