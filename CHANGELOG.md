# Changelog

## 2026-07-06 — v1.2.0

### Code review — modernized engine

- **Adversarial verification.** New `review-verifier` subagent independently tries
  to *refute* every finding before it reaches you; false positives are dropped and
  overstated severities are corrected. This is the biggest accuracy change.
- **Parallel fan-out.** The orchestrator now spawns breadth + performance +
  security reviewers in a single parallel batch (was strictly serial), then adds
  the Opus deep-dive, so a review is faster.
- **Structured findings.** All reviewers emit a machine-readable `findings` JSON
  block (`finding-schema.md`) so the orchestrator merges, dedupes, and verifies
  deterministically instead of parsing prose.

### Security — tool-backed

- `security-review` now runs real scanners when available — `gitleaks` /
  `trufflehog` for secrets, `osv-scanner` / `npm audit` / `pip-audit` / `cargo
  audit` / `govulncheck` for CVEs, `semgrep` for SAST — instead of recalling CVEs
  from memory.

### Fixed

- **Swapped skill/command frontmatter** across all packages: `SKILL.md` files
  carried command frontmatter (`allowed-tools`, `$ARGUMENTS`) and `*-command.md`
  files carried skill frontmatter (`triggers:`, no `allowed-tools`). Each now has
  the correct frontmatter for where it installs; commands gained `argument-hint`,
  and code-review's command delegates to its skill.

### Added — four new packages

- **pre-mortem** — assume a plan/release already failed; enumerate why, rank by
  likelihood × impact, and guard the top risks. Complements first-principles.
- **release** — run a release against a project-hygiene setup (bump → CHANGELOG →
  tag → push).
- **commit-pr-author** — commit message or PR description from the actual diff, in
  the repo's style.
- **skill-linter** — lint skills/subagents/commands for frontmatter, description
  quality, and dead references (catches the swap bug above).

`install.sh` and the README were updated for the new packages and integrity checks.

## 2026-06-11

### Project Hygiene (NEW)

**Initial release**
- Added `project-hygiene` skill — bootstraps release hygiene in any project
- SETUP mode: detects version source (Gradle/package.json/pyproject/Cargo/VERSION), creates CHANGELOG + docs/ROADMAP skeleton, installs a configurable pre-commit hook, writes conventions into the project's CLAUDE.md
- RELEASE mode: bump -> changelog -> commit -> annotated tag `vX.Y.Z` -> push --follow-tags checklist
- Hook templates (version-bump check + brainstorm<->roadmap coupling) usable standalone without Claude
- Wired into `install.sh`

## 2026-04-14

### First Principles Analyst (NEW)

**Initial release**
- Added `first-principles` standalone agent (Sonnet) — Aristotle's method for deconstructing problems
- 4-phase analysis: surface assumptions, establish first principles, rebuild 3 approaches, identify high-leverage move
- Assumption classification: convention, imitation, precedent, fear, unexamined default
- Works for any domain: code architecture, product decisions, business strategy, personal choices
- `/first-principles-jimmy` slash command and auto-trigger skill

## 2026-04-09

### Security Review (NEW)

**Initial release**
- Added `security-review` standalone agent (Sonnet) — dedicated security analysis
- Auto-detects project type: web, mobile (Android/iOS), API, CLI/desktop
- Applies appropriate security framework: OWASP Web Top 10, OWASP Mobile Top 10, API Security Top 10
- Scans for: secrets/credentials, injection, auth/authz, data protection, platform-specific issues, dependency vulnerabilities
- Severity levels: Critical / High / Medium / Low / Info with OWASP category mapping
- `/security-review` slash command and auto-trigger skill
- Also runs as Stage 2.75 inside the code-review pipeline

### Code Review

- **Security Review integrated** as Stage 2.75 — dedicated security-review agent runs as part of the full code review

## 2026-03-17

### Performance Review (NEW)

**Initial release**
- Added `perf-review` standalone agent (Sonnet) — dedicated performance analysis
- Analyzes: algorithmic complexity, N+1 queries, memory/allocation, frontend performance, caching, concurrency
- Big O notation for all findings (current vs proposed)
- Estimated impact (High/Medium/Low) with "Worth it?" assessment
- `/perf-review` slash command and auto-trigger skill
- Also runs as Stage 2.5 inside the code-review pipeline

### Code Review

- **Suggested Tests** — both reviewers now suggest a minimal set of fast, focused tests for changed code (only if tests exist in the project)
- **Performance Review integrated** as Stage 2.5 — dedicated perf-review agent runs as part of the full code review
- **Stage 4.5 doc-drift now mandatory** — same pattern as Stage 3.5 confirmation gate, cannot be skipped

## 2026-03-03

### Code Review (renamed from code-review-pipeline)

- **Renamed** from `code-review-pipeline` to `code-review` — simpler naming everywhere
- Slash command changed from `/review` to `/code-review`
- Skill renamed from `code-review-pipeline` to `code-review`
- **Performance review with impact estimation** — dedicated Performance Opportunities section in both reviewers
  - Estimated impact levels: High / Medium / Low with "worth it?" assessment
  - Big O notation required for all performance findings (current vs proposed complexity)
  - Helps users decide if an optimization is worth the code complexity trade-off
- **Mandatory confirmation gate** — Stage 3.5 can no longer be bypassed, even if the prompt says "fix"

## 2026-02-20

### Code Review

**Initial release**
- Added `code-review` orchestrator agent (Sonnet)
- Added `sonnet-reviewer` first-pass agent (Sonnet) — 10 review dimensions
- Added `opus-reviewer` deep-dive agent (Opus) — subtle issue detection

**Improvements**
- Smart diff detection: auto-detects uncommitted, staged, branch comparison, or user-specified scope
- Large changeset handling: warns at 20+ files, recommends scoping at 50+
- Confidence levels (high/medium/low) on all findings
- Code snippets included with every finding
- Dependency change auditing (package.json, requirements.txt, etc.)
- User confirmation gate before implementing fixes
- Review-only mode support
- 3 new review dimensions: test coverage, API contracts, error messages
- `/code-review` slash command for quick invocation
- Auto-trigger skill for natural language invocation ("review my code", "check my changes")
- Doc-drift-detector integrated as Stage 4.5 (runs after fixes to catch drift from both changes and fixes)

### Doc Drift Detector

**Initial release**
- Added `doc-drift-detector` agent (Sonnet) — auto-discovers and audits all project documentation
- Detects stale, missing, inconsistent, incomplete, and obsolete documentation
- Auto-discovers all `.md` files, TODOs, CHANGELOGs, `docs/` folders, and more
- Cross-references code changes against documentation content
- Smart diff detection (shared pattern with code review)
- Full audit mode for checking docs against entire codebase
- TODO/task list drift detection (pending items already done in code)
- `/doc-drift` slash command for quick invocation
- Auto-trigger skill for natural language invocation ("check my docs", "documentation audit")
- OBSOLETE detection: flags docs referencing deleted files, removed dependencies, or decommissioned code (requires concrete evidence, no false positives from age alone)
