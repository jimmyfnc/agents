---
name: first-principles-jimmy
description: Deconstruct any problem from first principles (Aristotle's method) — strip assumptions, find foundational truths, and rebuild solutions from scratch. Use for code, architecture, product, business, or personal decisions, or whenever the user wants their assumptions challenged or is stuck between options.
---

Spawn the `first-principles` subagent (Task tool, `subagent_type: "first-principles"`) and pass along the user's problem, decision, or situation:

- With context → "Deconstruct the following from first principles: `<context>`. Run all 4 phases (surface assumptions, establish first principles, rebuild 3 approaches, identify the high-leverage move)."
- No context → "The user wants a first-principles analysis. Ask them to describe the problem, decision, or situation they want deconstructed."

Pairs well with the `pre-mortem` skill: first-principles builds the plan, pre-mortem tries to break it.
