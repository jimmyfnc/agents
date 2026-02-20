# Code Review Pipeline

A multi-stage code review pipeline using two specialized Claude agents (Sonnet + Opus) that work together for thorough, layered code analysis with optional automatic fixes.

## How It Works

```
┌─────────────────────────────────────────────────────┐
│  Stage 0: Detect Diff Strategy                      │
│  Auto-detect: uncommitted / staged / branch / scope │
├─────────────────────────────────────────────────────┤
│  Stage 1: Sonnet First-Pass                         │
│  Fast, broad review across 10 dimensions            │
├─────────────────────────────────────────────────────┤
│  Stage 2: Opus Deep-Dive                            │
│  Subtle bugs, architecture, cross-file issues       │
├─────────────────────────────────────────────────────┤
│  Stage 3: Present Combined Findings                 │
│  Unified report with confidence levels              │
├─────────────────────────────────────────────────────┤
│  Stage 3.5: User Confirmation Gate                  │
│  Fix all / critical only / review-only / cherry-pick│
├─────────────────────────────────────────────────────┤
│  Stage 4: Implement Fixes                           │
│  Auto-fix approved issues by priority               │
├─────────────────────────────────────────────────────┤
│  Stage 5: Verify & Summarize                        │
│  Run tests, present final report                    │
└─────────────────────────────────────────────────────┘
```

## Agents

| Agent | Model | Role |
|-------|-------|------|
| `code-review-pipeline` | Sonnet | Orchestrator — detects diff strategy, coordinates reviewers, presents findings, gets user approval, implements fixes |
| `sonnet-reviewer` | Sonnet | Stage 1 — fast, broad first-pass review across 10 dimensions |
| `opus-reviewer` | Opus | Stage 2 — deep-dive second-pass catching subtle issues the first pass missed |

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

### 1. Install the agents (required)

Copy the three `.md` agent files into your global Claude agents directory:

```bash
mkdir -p ~/.claude/agents/review
cp code-review-pipeline.md sonnet-reviewer.md opus-reviewer.md ~/.claude/agents/review/
```

### 2. Install the slash command (optional)

Adds `/review` as a slash command you can type directly in chat:

```bash
cp extras/review-command.md ~/.claude/commands/review.md
```

### 3. Install the skill (optional)

Auto-triggers the pipeline when you say things like "review my code" or "check my changes":

```bash
mkdir -p ~/.claude/skills/code-review-pipeline
cp extras/SKILL.md ~/.claude/skills/code-review-pipeline/SKILL.md
```

Then restart Claude Code. The agents will be available automatically.

## Usage

There are three ways to invoke the pipeline:

### Slash command
```
/review
/review src/auth/
/review --review-only
```

### Natural language (with skill installed)
```
Review my code changes
Check my code for issues
Run a code review on the auth module
```

### Direct request (always works)
```
Run the code review pipeline on src/auth/
Just review my code, don't fix anything
Review the feature/payments branch against main
```

## Requirements

- [Claude Code](https://docs.anthropic.com/en/docs/claude-code) CLI or VS Code extension
- A git repository with changes to review
