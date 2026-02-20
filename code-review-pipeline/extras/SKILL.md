---
name: code-review-pipeline
description: "Run a multi-stage code review pipeline using Sonnet (first-pass) and Opus (deep-dive) reviewers. Use when the user wants a thorough code review, mentions reviewing code changes, or asks to check code quality."
triggers:
  - "review my code"
  - "code review"
  - "review changes"
  - "review this PR"
  - "check my code"
  - "run code review"
  - "review pipeline"
---

# Code Review Pipeline Skill

This skill triggers the code-review-pipeline agent for a thorough two-stage code review.

## When to Use

Activate this skill when the user:
- Asks to review code, changes, or a PR
- Wants to check code quality or find bugs
- Mentions "code review" or "review my changes"
- Asks to "check for issues" in their code

## How to Execute

Use the Task tool with `subagent_type: "code-review-pipeline"` to launch the orchestrator.

Pass along any scope the user mentioned (specific files, directories, branches).

If the user said "just review" or "review only", include that in the prompt so the pipeline skips the fix stages.

### Examples

**No scope specified:**
```
Task(code-review-pipeline): "Run the full code review pipeline on this project's recent changes."
```

**Scoped to files/directory:**
```
Task(code-review-pipeline): "Run the code review pipeline scoped to src/auth/"
```

**Review only, no fixes:**
```
Task(code-review-pipeline): "Run the code review pipeline in review-only mode — present findings but do not implement any fixes."
```

**Branch review:**
```
Task(code-review-pipeline): "Run the code review pipeline comparing the feature/payments branch against main."
```
