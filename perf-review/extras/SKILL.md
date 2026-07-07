---
name: perf-review-jimmy
description: Run a performance-focused code review analyzing algorithmic complexity, queries, memory, and optimization opportunities with Big O notation and impact estimation. Use when the user wants to check performance, optimize code, find bottlenecks, or mentions slow code, speed, or Big O.
---

Spawn the `perf-review` subagent (Task tool, `subagent_type: "perf-review"`) for a targeted performance analysis. Pass along any scope the user mentioned (files, directory, branch, or a full audit):

- No scope → "Run a performance review on this project's recent changes."
- Scoped → "Run a performance review scoped to `<path>`."
- Full → "Run a full performance audit of the entire codebase."

The subagent returns a report plus a structured findings block (`source: "perf"`).
