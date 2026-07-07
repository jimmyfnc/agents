---
name: security-review-jimmy
description: Run a security-focused code review that auto-detects project type, applies the right OWASP framework, and runs real scanners (gitleaks, osv-scanner, semgrep) when available. Use when the user wants a security audit, mentions vulnerabilities, secrets, auth/authz, or OWASP.
---

Spawn the `security-review` subagent (Task tool, `subagent_type: "security-review"`) for a targeted security analysis. Pass along any scope the user mentioned:

- No scope → "Run a security review on this project's recent changes."
- Scoped → "Run a security review scoped to `<path>`."
- Full → "Run a full security audit of the entire codebase."

The subagent prefers real scanners over recalling CVEs and returns a report plus a structured findings block (`source: "security"`).
