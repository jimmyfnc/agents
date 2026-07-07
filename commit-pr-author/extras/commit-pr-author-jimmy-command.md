---
allowed-tools: Skill, Bash, Read, Grep, Glob
argument-hint: [commit | pr]
description: Draft a commit message or PR description from the actual diff, in the repo's style
---

Run the `commit-pr-author` skill.

`$ARGUMENTS` selects the mode: `pr` drafts a pull-request description from the branch vs its base; anything else (or empty) drafts a commit message from the staged/working diff.

Invoke the skill via the Skill tool (`commit-pr-author`). Read the diff and recent history first, present the draft, and only commit / open the PR after the user confirms.
