# Changelog

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
