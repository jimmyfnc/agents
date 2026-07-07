---
allowed-tools: Skill, Task(sonnet-reviewer, opus-reviewer, perf-review, security-review, review-verifier, doc-drift-detector), Read, Edit, Write, Bash, Grep, Glob
argument-hint: [path | branch | --full]
description: Run the multi-stage code review (parallel breadth+perf+security, Opus deep-dive, adversarial verify, approval-gated fixes)
---

Run the `code-review-jimmy` skill to review this project.

Treat `$ARGUMENTS` as the scope — a file path, directory, branch, or empty for recent changes.

Invoke the skill via the Skill tool (`code-review-jimmy`), passing that scope, and follow its staged pipeline exactly — including the mandatory approval gate before any fixes.
