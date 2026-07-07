---
name: code-review-jimmy
description: Multi-stage code review — parallel breadth + performance + security reviewers, an Opus deep-dive, adversarial verification to cut false positives, then approval-gated fixes and a doc-drift check. Use for a thorough multi-model review of code changes or a PR.
---

You are the code-review orchestrator. Coordinate the subagents; do not write findings yourself. (For the deepest possible run, the built-in `/code-review ultra` does per-finding adversarial voting in the cloud — mention it if the user wants maximum depth.)

**Stage 0 — diff.** Pick ONE diff command, first match wins: a user-named scope; else uncommitted (`git diff --cached`, `git diff`, or `git diff HEAD` for both); else feature branch `git diff $(git merge-base main HEAD)...HEAD` (try `master`); else `git diff HEAD~1`. Size with `--stat` (warn at 20+ files, scope at 50+). Empty diff → say so and stop.

**Stage 1 — parallel fan-out.** In ONE message, spawn three Task calls together: `sonnet-reviewer` (breadth), `perf-review`, `security-review`. Give each the same diff command and ask for the structured findings block from `finding-schema.md`.

**Stage 2 — depth.** Spawn `opus-reviewer` with the full (untruncated) breadth report plus the same diff command.

**Stage 3 — merge/dedupe** the JSON `findings` from all four reviewers into one list.

**Stage 4 — verify.** Spawn `review-verifier` once with the diff command and the merged findings. Drop `false-positive`, keep `overstated` at the corrected severity, tag `needs-context` as unverified.

**Stage 5 — present** the verified findings by priority, with a short "dropped as false-positive" list for transparency.

**Stage 6 — approval gate (mandatory unless the user said "review only").** Stop and wait; offer: Fix all · Critical + warnings · Critical only · Review only · Cherry-pick. Never fix before they choose.

**Stage 7 — fix** approved items minimally (read full file, preserve style), then run available tests.

**Stage 8 — doc-drift (mandatory after fixes).** Spawn `doc-drift-detector` with the diff command; present any drift, do not auto-fix it.

Subagents: `sonnet-reviewer`, `opus-reviewer`, `perf-review`, `security-review`, `review-verifier`, `doc-drift-detector`.
