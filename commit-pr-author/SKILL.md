---
name: commit-pr-author
description: Write a clean commit message or PR description from the actual diff — grouping the change, inferring type/scope, and matching the repo's existing style. Use when the user asks to commit, write a commit message, open a PR, or draft a PR description.
---

You turn a real diff into a well-formed commit message or PR description. Read the change first; never write a message from the conversation alone.

## Step 1 — Read the change and the repo's style

- **Commit:** use the staged diff (`git diff --cached`) if anything is staged, otherwise the working diff (`git diff`). If nothing is uncommitted, ask what to describe.
- **PR:** diff the branch against its base (`git diff $(git merge-base main HEAD)...HEAD`) and list its commits (`git log <base>..HEAD --oneline`).
- **Match the house style:** read the last ~15 messages (`git log --oneline -15`). Detect whether the repo uses Conventional Commits (`feat:`/`fix:`), plain imperative, or an emoji/prefix style, and whether it uses trailers (co-author, `Closes #`). Match what's there — do not impose Conventional Commits on a repo that doesn't use it.

## Step 2 — Author

**Commit message:**
- Subject: imperative mood, ≤ ~72 chars, no trailing period. Conventional `type(scope): subject` only if the repo uses it.
- Body (when the change isn't trivial): explain **why**, not a restatement of the diff. Wrap ~72 cols.
- Footer: `BREAKING CHANGE:` and issue refs **only** if real and the repo uses them.

**PR description:** Title (same rules) + body with: **Summary** (why), **Changes** (the notable ones, grouped), **Testing** (what you ran / how to verify), **Risks / rollout** (migrations, flags, rollback). Link issues only if the user gave real numbers.

## Step 3 — Present, then act on confirmation

Show the drafted message/PR and stop. On approval, run `git commit` (with the message) or `gh pr create` (title + body). Never commit or open a PR without explicit confirmation.

## Rules

- Match the repo's existing convention; consistency beats your personal preference.
- Never fabricate issue numbers, co-authors, or trailers — include them only if real and conventional here.
- One logical change per commit. If the diff spans unrelated changes, say so and offer to split (`git add -p`) instead of writing a grab-bag message.
- If the diff contains anything secret-looking, flag it rather than committing it.
- Keep it honest: if tests weren't run, the Testing section says so.
