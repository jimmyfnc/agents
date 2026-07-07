# commit-pr-author

Turns a real diff into a clean commit message or PR description — grouped,
correctly typed/scoped, and matching the repo's existing style (Conventional
Commits, plain imperative, or whatever the last commits used).

Pairs with [project-hygiene](../project-hygiene/) and [release](../release/):
those handle versioning and tagging; this writes the message that goes with the change.

## What it does

- Reads the staged/working diff (commit) or branch-vs-base (PR) — never writes from the conversation alone.
- Detects and matches the repo's commit convention and trailer usage.
- Drafts an imperative subject + "why" body, or a full PR description (Summary / Changes / Testing / Risks).
- Presents the draft and only commits / opens the PR after you confirm.

## Install

Installed by the repo `install.sh`. Manually:

```bash
mkdir -p ~/.claude/skills/commit-pr-author
cp commit-pr-author/SKILL.md ~/.claude/skills/commit-pr-author/SKILL.md
cp commit-pr-author/extras/commit-pr-author-jimmy-command.md ~/.claude/commands/commit-pr-author-jimmy.md
```

## Use

- `/commit-pr-author-jimmy` — draft a commit message from the current diff.
- `/commit-pr-author-jimmy pr` — draft a PR description for the branch.
- Or: "write me a commit message" / "draft the PR".
