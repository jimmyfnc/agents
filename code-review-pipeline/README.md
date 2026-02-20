# Code Review Pipeline

A multi-stage code review pipeline using two specialized Claude agents (Sonnet + Opus) that work together for thorough, layered code analysis with automatic fixes.

## Agents

| Agent | Model | Role |
|-------|-------|------|
| `code-review-pipeline` | Sonnet | Orchestrator — coordinates the two reviewers, presents findings, and implements fixes |
| `sonnet-reviewer` | Sonnet | Stage 1 — fast, broad first-pass review across 7 dimensions |
| `opus-reviewer` | Opus | Stage 2 — deep-dive second-pass catching subtle issues the first pass missed |

## Pipeline Flow

1. **Sonnet First-Pass** — Broad sweep for correctness, security, performance, code quality, architecture, edge cases, and type safety
2. **Opus Deep-Dive** — Receives the Sonnet report, then independently analyzes the code for subtle logic flaws, concurrency issues, cross-file interactions, and implicit assumptions
3. **Present Combined Findings** — Unified summary of both stages
4. **Implement Fixes** — Automatically fixes issues by priority: critical > warnings > suggestions
5. **Verify** — Runs tests and presents a final summary

## Installation

Copy the three `.md` files into your global Claude agents directory:

```
~/.claude/agents/review/
```

## Usage

Invoke from Claude Code by using the `code-review-pipeline` agent, or let it be triggered automatically when a thorough code review is needed.
