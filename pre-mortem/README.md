# pre-mortem

A red-team / pre-mortem analyst. It assumes your plan, feature, or release has
**already failed**, then reasons backward to the causes — ranked by likelihood ×
impact — and names the cheapest guard or early-warning signal for each top risk.

It's the destructive complement to [first-principles](../first-principles/):
first-principles builds the plan up from foundational truths; pre-mortem tries to
tear it down before reality does.

## What it does

1. **Frame** — restates what's shipping and what "success" concretely means.
2. **Imagine the failure** — "it's N weeks later and this failed badly" across technical, product, ops, security/abuse, people, and external dimensions.
3. **Rank** — likelihood × impact, worst first.
4. **Guard** — the cheapest mitigation or detection signal for each top risk.
5. **Verdict** — is any risk severe enough to change or delay the plan?

## Install

Installed by the repo `install.sh`. Manually:

```bash
mkdir -p ~/.claude/agents/pre-mortem
cp pre-mortem/pre-mortem.md ~/.claude/agents/pre-mortem/

# Slash command + auto-trigger skill
cp pre-mortem/extras/pre-mortem-jimmy-command.md ~/.claude/commands/pre-mortem-jimmy.md
mkdir -p ~/.claude/skills/pre-mortem-jimmy
cp pre-mortem/extras/SKILL.md ~/.claude/skills/pre-mortem-jimmy/SKILL.md
```

## Use

- `/pre-mortem-jimmy We're about to run a live migration renaming users.email`
- Or just: "Pre-mortem this launch plan…" and the skill triggers.
