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
