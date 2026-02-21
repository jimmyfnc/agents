---
allowed-tools: Task(code-review-pipeline), Bash, Read, Grep, Glob
description: Run the multi-stage code review pipeline (Sonnet first-pass + Opus deep-dive)
---

Run the code-review-pipeline agent to perform a thorough two-stage code review of the current project.

If the user provided arguments, pass them as the scope:
- `$ARGUMENTS`

If no arguments were provided, review all recent changes.

Use the Task tool with `subagent_type: "code-review-pipeline"` and pass along any scope the user specified.

**IMPORTANT:** Never include "fix" or "fix issues" in the prompt. The pipeline has a mandatory confirmation gate — it will present findings first and ask the user how to proceed before making any changes.

Example prompts based on arguments:
- No args: "Run the full code review pipeline on this project's recent changes. Present findings and wait for my approval before making any fixes."
- `src/auth/`: "Run the code review pipeline scoped to src/auth/. Present findings and wait for my approval before making any fixes."
- `--review-only`: "Run the code review pipeline in review-only mode — no fixes."
- `feature/payments`: "Run the code review pipeline on the feature/payments branch against main. Present findings and wait for my approval before making any fixes."
