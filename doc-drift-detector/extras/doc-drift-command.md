---
allowed-tools: Task(doc-drift-detector), Bash, Read, Grep, Glob
description: Scan for stale, missing, or inconsistent documentation across the project
---

Run the doc-drift-detector agent to scan all project documentation and cross-reference against recent code changes.

If the user provided arguments, pass them as context:
- `$ARGUMENTS`

Use the Task tool with `subagent_type: "doc-drift-detector"` and pass along any context the user specified.

Example prompts based on arguments:
- No args: "Scan all documentation in this project and check for drift against recent code changes."
- `--full`: "Run a full documentation audit against the entire codebase, not just recent changes."
- `--audit`: "Run a full documentation audit against the entire codebase, not just recent changes."
- `src/auth/`: "Check documentation drift for changes in src/auth/ only."
