---
name: doc-drift-jimmy
description: Detect stale, missing, inconsistent, incomplete, or obsolete documentation by auto-discovering all project docs and cross-referencing them against code changes. Use when the user asks whether docs are up to date, wants a documentation audit, or just changed code and might have missed a doc update.
---

> Naming: the skill is `doc-drift-jimmy` (short) while the subagent is `doc-drift-detector` (internal).

Spawn the `doc-drift-detector` subagent (Task tool, `subagent_type: "doc-drift-detector"`) and pass along any scope or mode:

- Recent changes → "Scan all documentation in this project and check for drift against recent code changes."
- Full → "Run a full documentation audit against the entire codebase, not just recent changes."
- Scoped → "Check documentation drift for changes in `<path>` only."
