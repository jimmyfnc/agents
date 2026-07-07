---
allowed-tools: Task(doc-drift-detector), Bash, Read, Grep, Glob
argument-hint: [path | --full]
description: Scan for stale, missing, inconsistent, or obsolete documentation across the project
---

Run the `doc-drift-detector` agent to scan all project documentation and cross-reference it against code changes. Context: `$ARGUMENTS`

Use the Task tool with `subagent_type: "doc-drift-detector"`:

- No args → "Scan all documentation in this project and check for drift against recent code changes."
- `--full` / `--audit` → "Run a full documentation audit against the entire codebase."
- `<path>` → "Check documentation drift for changes in `<path>` only."
