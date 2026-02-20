# Code Review Pipeline

A multi-stage code review pipeline using two specialized Claude agents (Sonnet + Opus) that work together for thorough, layered code analysis with optional automatic fixes.

## Agents

| Agent | Model | Role |
|-------|-------|------|
| `code-review-pipeline` | Sonnet | Orchestrator — detects diff strategy, coordinates reviewers, presents findings, gets user approval, implements fixes |
| `sonnet-reviewer` | Sonnet | Stage 1 — fast, broad first-pass review across 10 dimensions |
| `opus-reviewer` | Opus | Stage 2 — deep-dive second-pass catching subtle issues the first pass missed |

## Pipeline Flow

1. **Diff Detection** — Automatically determines the right diff command (uncommitted, staged, branch comparison, etc.) and checks changeset size
2. **Sonnet First-Pass** — Broad sweep across correctness, security, performance, code quality, architecture, edge cases, type safety, test coverage, API contracts, and error messages
3. **Opus Deep-Dive** — Receives the Sonnet report, independently analyzes the code for subtle logic flaws, concurrency issues, cross-file interactions, and implicit assumptions
4. **Present Combined Findings** — Unified summary with confidence levels for each finding
5. **User Confirmation** — Choose: fix all, critical+warnings only, critical only, review-only, or cherry-pick specific items
6. **Implement Fixes** — Automatically fixes approved issues by priority
7. **Verify** — Runs tests and presents a final summary

## Features

- **Smart diff detection** — Handles uncommitted changes, staged changes, feature branches, and user-specified scopes
- **Large changeset warnings** — Warns at 20+ files, recommends scoping at 50+
- **Confidence levels** — Every finding includes high/medium/low confidence to reduce false positive noise
- **Code snippets** — Every finding includes the problematic code for easy identification
- **Dependency auditing** — Flags new, removed, or changed dependencies
- **10 review dimensions** — Correctness, security, performance, code quality, architecture, edge cases, type safety, test coverage, API contracts, error messages
- **User confirmation gate** — Review-only mode or choose which fixes to apply before any code is changed
- **Two-model depth** — Sonnet catches breadth, Opus catches depth

## Installation

Copy the three `.md` files into your global Claude agents directory:

```
~/.claude/agents/review/
```

## Usage

Invoke from Claude Code by using the `code-review-pipeline` agent, or let it be triggered automatically when a thorough code review is needed.

```
# Review all changes on current branch
Review my code changes

# Review specific scope
Run the review pipeline on src/auth/

# Review only, no fixes
Just review my code, don't fix anything

# Review a branch
Review the feature/payments branch against main
```
