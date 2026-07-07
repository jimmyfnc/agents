---
name: pre-mortem-jimmy
description: Stress-test a plan, feature, or release by assuming it already failed and reasoning backward — enumerate failure modes, rank by likelihood × impact, and name the cheapest guard for each top risk. Use before shipping something risky, launching, or committing to a plan, or when the user asks "what could go wrong?"
---

Spawn the `pre-mortem` subagent (Task tool, `subagent_type: "pre-mortem"`) and pass along the plan, change, or decision to stress-test:

- With context → "Pre-mortem the following — assume it already failed and work backward: `<context>`. Run all phases."
- No context → "The user wants a pre-mortem. Ask them to describe the plan, feature, or release to stress-test and what success would look like."

Pairs with `first-principles`: first-principles builds the plan, pre-mortem tries to break it before you ship.
