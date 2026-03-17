# Performance Review

A performance-focused code review agent that analyzes code for algorithmic complexity, query performance, memory usage, and optimization opportunities with Big O notation and estimated impact levels.

## How It Works

```
┌─────────────────────────────────────────────────────┐
│  Step 1: Identify Scope                             │
│  Auto-detect changes or full audit mode             │
├─────────────────────────────────────────────────────┤
│  Step 2: Detect Tech Stack                          │
│  Language, framework, DB, frontend/backend          │
├─────────────────────────────────────────────────────┤
│  Step 3: Analyze Performance Dimensions             │
│  Algorithms, queries, memory, caching, concurrency  │
├─────────────────────────────────────────────────────┤
│  Step 4: Classify by Impact                         │
│  High / Medium / Low with "Worth it?" assessment    │
├─────────────────────────────────────────────────────┤
│  Step 5: Produce Report                             │
│  Big O notation, code snippets, impact estimation   │
└─────────────────────────────────────────────────────┘
```

## Agent

| Agent | Model | Role |
|-------|-------|------|
| `perf-review` | Sonnet | Single-pass performance analysis — fast and cost-effective |

## What It Analyzes

| Dimension | Examples |
|-----------|---------|
| **Algorithmic Complexity** | Nested loops (O(n²) → O(n)), linear searches, redundant iterations, missing memoization |
| **Database & Queries** | N+1 queries, missing indexes, over-fetching, missing pagination, unnecessary round-trips |
| **Memory & Allocation** | Large objects in loops, unbounded arrays, missing cleanup, string concat in loops |
| **Frontend Performance** | Unnecessary re-renders, large imports, layout thrashing, missing virtualization |
| **Caching** | Repeated expensive computations, uncached API calls, missing HTTP caching |
| **Concurrency & I/O** | Sequential async that could be parallel, blocking I/O, missing connection pooling |

## Impact Levels

Every finding includes an estimated impact and "Worth it?" assessment:

| Level | Meaning | Example |
|-------|---------|---------|
| **High** | Significant measurable improvement, clearly worth fixing | O(n²) → O(n) on 10k items, N+1 on high-traffic endpoint |
| **Medium** | Noticeable in some scenarios, worth considering | Unnecessary re-renders, redundant API calls |
| **Low** | Minor optimization, may not be worth the complexity | Micro-optimizations, rarely-hit code paths |

## Installation

### 1. Install the agent (required)

```bash
mkdir -p ~/.claude/agents/perf
cp perf-review.md ~/.claude/agents/perf/
```

### 2. Install the slash command (optional)

```bash
cp extras/perf-review-command.md ~/.claude/commands/perf-review.md
```

### 3. Install the skill (optional)

```bash
mkdir -p ~/.claude/skills/perf-review
cp extras/SKILL.md ~/.claude/skills/perf-review/SKILL.md
```

Then restart Claude Code.

## Usage

### Slash command
```
/perf-review
/perf-review src/api/
/perf-review --full
```

### Natural language (with skill installed)
```
Check my code for performance issues
Run a performance audit
Find bottlenecks in the API layer
```

### Direct request (always works)
```
Run a performance review on my recent changes
Do a full performance audit of this project
Check src/data/ for query performance
```

## Requirements

- [Claude Code](https://docs.anthropic.com/en/docs/claude-code) CLI or VS Code extension
- A git repository
