---
allowed-tools: Task(code-review-pipeline), Bash, Read, Grep, Glob
description: Run the multi-stage code review pipeline (Sonnet first-pass + Opus deep-dive)
---

Run the code-review-pipeline agent to perform a thorough two-stage code review of the current project.

If the user provided arguments, pass them as the scope:
- `$ARGUMENTS`

If no arguments were provided, review all recent changes.

Use the Task tool with `subagent_type: "code-review-pipeline"` and pass along any scope the user specified.

Example prompts based on arguments:
- No args: "Run the full code review pipeline on this project's recent changes."
- `src/auth/`: "Run the code review pipeline scoped to src/auth/"
- `--review-only`: "Run the code review pipeline in review-only mode — no fixes."
- `feature/payments`: "Run the code review pipeline on the feature/payments branch against main."
