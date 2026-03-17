---
name: perf-review
description: "Run a performance-focused code review analyzing algorithmic complexity, queries, memory, and optimization opportunities with Big O notation and impact estimation. Use when the user wants to check performance, optimize code, or find bottlenecks."
triggers:
  - "performance review"
  - "perf review"
  - "check performance"
  - "optimize my code"
  - "find bottlenecks"
  - "performance audit"
  - "slow code"
---

# Performance Review Skill

This skill triggers the perf-review agent for a targeted performance analysis.

## When to Use

Activate this skill when the user:
- Asks about performance, speed, or optimization
- Mentions "slow", "bottleneck", "optimize", or "performance"
- Wants to audit code for efficiency
- Asks about Big O complexity or algorithmic improvements

## How to Execute

Use the Task tool with `subagent_type: "perf-review"` to launch the agent.

Pass along any scope the user mentioned (specific files, directories, branches).

### Examples

**No scope specified:**
```
Task(perf-review): "Run a performance review on this project's recent changes."
```

**Scoped to files/directory:**
```
Task(perf-review): "Run a performance review scoped to src/api/"
```

**Full audit:**
```
Task(perf-review): "Run a full performance audit of the entire codebase."
```
