---
name: security-review-jimmy
description: "Run a security-focused code review that auto-detects project type and applies OWASP frameworks. Scans for vulnerabilities, secrets, auth issues, and insecure patterns. Use when the user wants a security audit or mentions vulnerabilities."
triggers:
  - "security review"
  - "security audit"
  - "check for vulnerabilities"
  - "check security"
  - "find security issues"
  - "are there any vulnerabilities"
  - "scan for secrets"
---

# Security Review Skill

This skill triggers the security-review agent for a targeted security analysis.

## When to Use

Activate this skill when the user:
- Asks about security, vulnerabilities, or exploits
- Mentions "security audit", "vulnerability scan", or "security review"
- Wants to check for hardcoded secrets or credentials
- Asks about auth/authz issues
- Mentions OWASP or security compliance

## How to Execute

Use the Task tool with `subagent_type: "security-review"` to launch the agent.

Pass along any scope the user mentioned (specific files, directories, branches).

### Examples

**No scope specified:**
```
Task(security-review): "Run a security review on this project's recent changes."
```

**Scoped to files/directory:**
```
Task(security-review): "Run a security review scoped to src/auth/"
```

**Full audit:**
```
Task(security-review): "Run a full security audit of the entire codebase."
```
