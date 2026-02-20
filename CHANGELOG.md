# Changelog

## 2026-02-20

### Code Review Pipeline

**Initial release**
- Added `code-review-pipeline` orchestrator agent (Sonnet)
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
- `/review` slash command for quick invocation
- Auto-trigger skill for natural language invocation ("review my code", "check my changes")

### Doc Drift Detector

**Initial release**
- Added `doc-drift-detector` agent (Sonnet) — auto-discovers and audits all project documentation
- Detects stale, missing, inconsistent, and incomplete documentation
- Auto-discovers all `.md` files, TODOs, CHANGELOGs, `docs/` folders, and more
- Cross-references code changes against documentation content
- Smart diff detection (shared pattern with code review pipeline)
- Full audit mode for checking docs against entire codebase
- TODO/task list drift detection (pending items already done in code)
- `/doc-drift` slash command for quick invocation
- Auto-trigger skill for natural language invocation ("check my docs", "documentation audit")
