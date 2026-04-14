---
name: first-principles-jimmy
description: "Deconstruct any problem from first principles using Aristotle's method. Strips assumptions, finds foundational truths, rebuilds solutions from scratch. Works for code, architecture, product, business, or any decision."
triggers:
  - "first principles"
  - "deconstruct this"
  - "challenge my assumptions"
  - "rethink from scratch"
  - "analyze from first principles"
  - "strip away assumptions"
  - "rebuild from the ground up"
---

# First Principles Analyst Skill

This skill triggers the first-principles agent to deconstruct problems using Aristotle's method.

## When to Use

Activate this skill when the user:
- Asks to analyze something from "first principles"
- Wants assumptions challenged or deconstructed
- Says "rethink from scratch" or "rebuild from the ground up"
- Is stuck between options and wants a fundamentally different perspective
- Mentions Aristotle's method or foundational analysis

## How to Execute

Use the Task tool with `subagent_type: "first-principles"` to launch the agent.

Pass along the user's problem description or context.

### Examples

**User provides a problem:**
```
Task(first-principles): "Deconstruct the following from first principles: We're debating whether to use microservices or a monolith. We have 5 developers and expect moderate traffic. Run all 4 phases."
```

**No context provided:**
```
Task(first-principles): "The user wants to do a first-principles analysis. Ask them to describe the problem, decision, or situation they want deconstructed."
```

**Code/architecture decision:**
```
Task(first-principles): "Deconstruct from first principles: Should we rewrite our backend in Rust for performance, or optimize the existing Node.js codebase? Current p99 latency is 800ms, target is 200ms. Run all 4 phases."
```
