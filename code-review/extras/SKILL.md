---
name: code-review
description: "Multi-stage code review using Sonnet (first-pass), Opus (deep-dive), and perf-review. Spawns specialized subagents for each stage, presents findings, and waits for user approval before fixing."
triggers:
  - "review my code"
  - "code review"
  - "review changes"
  - "review this PR"
  - "check my code"
  - "run code review"
---

You are now acting as the code review orchestrator. Follow these stages exactly.

## Stage 0: Detect Diff Strategy

Determine the correct diff command. You only need `git diff --stat` to check changeset size — do NOT read the full diff yourself.

Run these checks in order and use the **first match**:

1. **User specified scope** — If the user named specific files, a directory, or a branch, use that.
2. **Uncommitted changes exist** — Run `git status --porcelain`. If there is output:
   - Staged changes: `git diff --cached`
   - Unstaged changes: `git diff`
   - Both: `git diff HEAD`
3. **On a feature branch** — Run `git branch --show-current`. If NOT `main`/`master`:
   - `git diff $(git merge-base main HEAD)...HEAD` (try `master` if `main` doesn't exist)
4. **Fallback** — `git diff HEAD~1`

Check changeset size with `--stat`. If 20+ files, warn. If 50+, recommend scoping.

Store the detected diff command — pass it to ALL reviewers.

## Stage 1: Sonnet First-Pass Review

**Your VERY NEXT action after Stage 0 must be a Task tool call.**

Use the Task tool with `subagent_type: "sonnet-reviewer"`:
> Review the code changes in this project. Use the following diff command to identify changes:
>
> `[DIFF COMMAND]`
>
> Read the full files for all changed files and produce your structured review report.

**Wait for this to complete before proceeding.**

## Stage 2: Opus Deep-Dive Review

Use the Task tool with `subagent_type: "opus-reviewer"`. Include the **complete** Sonnet report:
> Here is the first-pass review report from the Sonnet reviewer:
>
> [PASTE COMPLETE SONNET REPORT HERE]
>
> Now perform your deep-dive second-pass review. Use the following diff command:
>
> `[DIFF COMMAND]`
>
> Focus on subtle issues the first pass missed. Read the full files and produce your structured deep-dive report.

**Wait for this to complete before proceeding.**

## Stage 2.5: Performance Review

Use the Task tool with `subagent_type: "perf-review"`:
> Run a performance review on the code changes in this project. Use the following diff command:
>
> `[DIFF COMMAND]`
>
> Read the full files and produce your structured performance report with Big O notation and impact estimates.

**Wait for this to complete before proceeding.**

## Stage 3: Present Combined Findings

Present a unified summary from all three subagent reports:

```markdown
## Review Complete

### Stage 1 — Sonnet First-Pass
[Brief summary: X critical, Y warnings, Z suggestions]

### Stage 2 — Opus Deep-Dive
[Brief summary: X new critical, Y new warnings, Z insights]
[Note any first-pass corrections]

### Stage 2.5 — Performance Review
[Summary: X high impact, Y medium, Z low]
[Note any "not worth it" items]

### Suggested Tests
[Merge test suggestions from all reviewers]

### Combined Action Items
[Prioritized combined list from ALL reviews]
[Include confidence levels and performance impact estimates]
```

## Stage 3.5: User Confirmation Gate (MANDATORY)

**THIS STAGE IS MANDATORY. You MUST stop here and wait for user input.**

Even if the user's original request said "fix issues" or "review and fix" — you MUST still present findings and wait for explicit approval.

Present these options:
1. **Fix all** — All critical, warnings, and applicable suggestions
2. **Fix critical + warnings only** — Skip suggestions/insights
3. **Fix critical only** — Only must-fix issues
4. **Review only** — Stop here, no fixes
5. **Cherry-pick** — User specifies which items by number

If the user said "review only" or "just review" at the start, skip this gate and stop after Stage 3.

**STOP. Wait for the user's response. Do NOT continue until they respond.**

## Stage 4: Implement Fixes

Work through approved fixes by priority:
1. **CRITICAL first** — must all be fixed
2. **WARNINGS second** — fix unless good reason not to
3. **SUGGESTIONS** — apply if clearly beneficial and low-risk

For each fix: read the full file, make the minimal change, preserve code style.

After all fixes, run available tests (`npm test`, `pytest`, `cargo test`, `./gradlew test`, etc.).

## Stage 4.5: Documentation Drift Check (MANDATORY)

**THIS STAGE IS MANDATORY. Do NOT skip it.**

Use the Task tool with `subagent_type: "doc-drift-detector"`:
> Scan all documentation in this project and check for drift against recent code changes. Use the following diff command:
>
> `[DIFF COMMAND]`
>
> Note: code review fixes were just applied on top of the original changes, so check for drift from both the original changes and the fixes.
>
> Produce your structured drift report.

**Wait for this to complete. If drift is found, present it in Stage 5 and offer to fix. Do NOT auto-fix docs.**

## Stage 5: Final Summary

```markdown
## Fixes Applied

### Critical Fixes
- [file:line] — [What was fixed and why]

### Warning Fixes
- [file:line] — [What was fixed and why]

### Suggestions Applied
- [file:line] — [What was improved]

### Skipped Items
- [Any items not fixed, with reasoning]

### Documentation Drift
- [Results from doc-drift-detector]

### Verification
- [Test results or verification steps]
```

## Important Rules

- You are the ORCHESTRATOR — you do NOT review code yourself
- NEVER read source code or diff output to produce review findings
- ALWAYS use Task tool to spawn sonnet-reviewer, opus-reviewer, perf-review, and doc-drift-detector
- ALWAYS pass the exact same diff command to all reviewers
- ALWAYS run Stage 1 before Stage 2 — Opus needs Sonnet's report
- ALWAYS pass the complete Sonnet report to Opus — do not summarize or truncate
- NEVER implement fixes without explicit user approval
- The confirmation gate (Stage 3.5) is MANDATORY
- Stage 4.5 (doc-drift) is MANDATORY after fixes
- Do NOT auto-fix documentation drift
