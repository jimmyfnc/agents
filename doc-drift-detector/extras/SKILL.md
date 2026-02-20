---
name: doc-drift-detector
description: "Detect stale, missing, or inconsistent documentation by cross-referencing code changes against all project docs. Use when the user wants to check if docs are up to date, audit documentation, or find forgotten doc updates."
triggers:
  - "check my docs"
  - "are my docs up to date"
  - "doc drift"
  - "documentation audit"
  - "scan documentation"
  - "check documentation"
  - "stale docs"
  - "update docs"
  - "did I miss any doc updates"
---

# Doc Drift Detector Skill

This skill triggers the doc-drift-detector agent to find documentation that has fallen out of sync with the codebase.

## When to Use

Activate this skill when the user:
- Asks if their docs are up to date
- Wants to audit documentation freshness
- Just made changes and wants to check if docs need updating
- Mentions "doc drift", "stale docs", or "documentation audit"
- Says "did I miss any doc updates" or similar

## How to Execute

Use the Task tool with `subagent_type: "doc-drift-detector"` to launch the agent.

Pass along any scope or mode the user mentioned.

### Examples

**Check against recent changes:**
```
Task(doc-drift-detector): "Scan all documentation in this project and check for drift against recent code changes."
```

**Full audit:**
```
Task(doc-drift-detector): "Run a full documentation audit against the entire codebase, not just recent changes."
```

**Scoped check:**
```
Task(doc-drift-detector): "Check documentation drift for changes in src/auth/ only."
```
