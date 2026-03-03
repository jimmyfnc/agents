---
allowed-tools: Task(code-review), Bash, Read, Grep, Glob
description: Run the multi-stage code review (Sonnet first-pass + Opus deep-dive)
---

Run the code-review agent to perform a thorough two-stage code review of the current project.

If the user provided arguments, pass them as the scope:
- `$ARGUMENTS`

If no arguments were provided, review all recent changes.

Use the Task tool with `subagent_type: "code-review"` and pass along any scope the user specified.

**IMPORTANT:** Never include "fix" or "fix issues" in the prompt. The review has a mandatory confirmation gate — it will present findings first and ask the user how to proceed before making any changes.

Example prompts based on arguments:
- No args: "Run the full code review on this project's recent changes. Present findings and wait for my approval before making any fixes."
- `src/auth/`: "Run the code review scoped to src/auth/. Present findings and wait for my approval before making any fixes."
- `--review-only`: "Run the code review in review-only mode — no fixes."
- `feature/payments`: "Run the code review on the feature/payments branch against main. Present findings and wait for my approval before making any fixes."
