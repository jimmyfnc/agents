# First Principles Analyst

A thinking tool modeled on Aristotle's method: strip away assumptions, find foundational truths, and rebuild solutions from scratch. Works for any problem — code architecture, product decisions, business strategy, or personal choices.

## How It Works

```
┌─────────────────────────────────────────────────────┐
│  Phase 1: Surface the Assumptions                   │
│  Find hidden assumptions, classify their origin     │
├─────────────────────────────────────────────────────┤
│  Phase 2: Establish First Principles                │
│  What's verifiably true independent of convention?  │
├─────────────────────────────────────────────────────┤
│  Phase 3: Rebuild from the Foundation               │
│  3 approaches: speed, impact, simplicity            │
├─────────────────────────────────────────────────────┤
│  Phase 4: The High-Leverage Move                    │
│  One concrete action invisible to conventional view │
└─────────────────────────────────────────────────────┘
```

## Agent

| Agent | Model | Role |
|-------|-------|------|
| `first-principles` | Sonnet | 4-phase analysis: assumptions, first principles, rebuild, high-leverage move |

## What It Does

### Phase 1: Surface the Assumptions
Identifies hidden assumptions in your framing. Classifies each by origin:

| Origin | Meaning |
|--------|---------|
| **Convention** | "This is how the industry does it" |
| **Imitation** | "Competitors do it this way" |
| **Precedent** | "It worked before" |
| **Fear** | "We'd lose X if we changed" |
| **Unexamined default** | "Nobody questioned this" |

Each assumption is rated by how load-bearing it is (High / Medium / Low).

### Phase 2: Establish First Principles
Strips away all assumptions and finds what's verifiably true. Each candidate truth must pass 3 tests:
1. True even if every competitor disappeared
2. True even if you'd never tried any prior approach
3. Can be stated without referencing any industry norm

### Phase 3: Rebuild from the Foundation
Constructs 3 distinct approaches using ONLY first principles:
- **Approach A** — Optimized for speed
- **Approach B** — Optimized for impact
- **Approach C** — Optimized for simplicity

### Phase 4: The High-Leverage Move
Identifies the single action that has disproportionate impact, is invisible to conventional thinking, and can begin within 1-2 weeks.

## Installation

### 1. Install the agent (required)

```bash
mkdir -p ~/.claude/agents/thinking
cp first-principles.md ~/.claude/agents/thinking/
```

### 2. Install the slash command (optional)

```bash
cp extras/first-principles-jimmy-command.md ~/.claude/commands/first-principles-jimmy.md
```

### 3. Install the skill (optional)

```bash
mkdir -p ~/.claude/skills/first-principles-jimmy
cp extras/SKILL.md ~/.claude/skills/first-principles-jimmy/SKILL.md
```

Then restart Claude Code.

## Usage

### Slash command
```
/first-principles-jimmy
/first-principles-jimmy Should we rewrite our backend in Rust or optimize Node.js?
```

### Natural language (with skill installed)
```
Analyze this from first principles
Challenge my assumptions about our architecture
Deconstruct this problem from scratch
```

### Direct request (always works)
```
Use first principles to analyze whether we should build or buy
Rethink our deployment strategy from the ground up
Strip away assumptions about our pricing model
```

## Requirements

- [Claude Code](https://docs.anthropic.com/en/docs/claude-code) CLI or VS Code extension
