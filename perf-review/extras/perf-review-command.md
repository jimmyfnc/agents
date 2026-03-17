---
allowed-tools: Task(perf-review), Bash, Read, Grep, Glob
description: Run a performance-focused code review with Big O analysis and impact estimation
---

Run the perf-review agent to perform a performance-focused review of the current project.

If the user provided arguments, pass them as the scope:
- `$ARGUMENTS`

If no arguments were provided, review recent changes for performance issues.

Use the Task tool with `subagent_type: "perf-review"` and pass along any scope the user specified.

Example prompts based on arguments:
- No args: "Run a performance review on this project's recent changes."
- `src/api/`: "Run a performance review scoped to src/api/"
- `--full`: "Run a full performance audit of the entire codebase."
- `--audit`: "Run a full performance audit of the entire codebase."
