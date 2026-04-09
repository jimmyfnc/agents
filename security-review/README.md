# Security Review

A security-focused code review agent that auto-detects your project type and applies the appropriate security framework (OWASP Web/Mobile Top 10, API Security Top 10, etc.) to find vulnerabilities, hardcoded secrets, auth issues, and insecure patterns.

## How It Works

```
┌─────────────────────────────────────────────────────┐
│  Step 1: Identify Scope                             │
│  Auto-detect changes or full audit mode             │
├─────────────────────────────────────────────────────┤
│  Step 2: Detect Project Type                        │
│  Web, mobile, API, CLI — apply right framework      │
├─────────────────────────────────────────────────────┤
│  Step 3: Analyze Security Dimensions                │
│  Secrets, injection, auth, data protection, deps    │
├─────────────────────────────────────────────────────┤
│  Step 4: Classify by Severity                       │
│  Critical / High / Medium / Low with OWASP mapping  │
├─────────────────────────────────────────────────────┤
│  Step 5: Produce Report                             │
│  Vulnerabilities, remediation, secrets scan         │
└─────────────────────────────────────────────────────┘
```

## Agent

| Agent | Model | Role |
|-------|-------|------|
| `security-review` | Sonnet | Single-pass security analysis — fast and cost-effective |

## What It Covers

The agent auto-detects your project type and applies the right security checklist:

| Project Type | Security Framework | Detection |
|---|---|---|
| Web apps | OWASP Web Top 10 | `package.json` + web framework, Rails, Django, etc. |
| Android | OWASP Mobile Top 10 | `build.gradle`, `AndroidManifest.xml` |
| iOS | OWASP Mobile Top 10 | `*.xcodeproj`, `Info.plist` |
| APIs/backends | OWASP API Security Top 10 | API routes, controllers, endpoints |
| CLI/Desktop | CLI-specific checklist | CLI argument parsing, no web server |

## Security Dimensions

| Dimension | Examples |
|-----------|---------|
| **Secrets & Credentials** | Hardcoded API keys, tokens in config, `.env` committed, secrets in logs |
| **Input Validation & Injection** | SQLi, XSS, command injection, path traversal, SSRF, XXE |
| **Authentication & Authorization** | Missing auth, broken access control, insecure sessions, CSRF, weak passwords |
| **Data Protection** | Unencrypted storage, PII in logs, missing TLS, overly broad API responses |
| **Platform-Specific** | Exported Android components, insecure IPC, missing security headers |
| **Dependency Security** | Known vulnerable packages, outdated deps with security patches |

## Severity Levels

| Level | Meaning |
|-------|---------|
| **CRITICAL** | Actively exploitable — data breach, unauthorized access, system compromise |
| **HIGH** | Significant weakness exploitable under realistic conditions |
| **MEDIUM** | Increases risk but requires specific conditions to exploit |
| **LOW** | Defense-in-depth improvement or best practice violation |
| **INFO** | Security observation or recommendation |

## Installation

### 1. Install the agent (required)

```bash
mkdir -p ~/.claude/agents/security
cp security-review.md ~/.claude/agents/security/
```

### 2. Install the slash command (optional)

```bash
cp extras/security-review-jimmy-command.md ~/.claude/commands/security-review-jimmy.md
```

### 3. Install the skill (optional)

```bash
mkdir -p ~/.claude/skills/security-review-jimmy
cp extras/SKILL.md ~/.claude/skills/security-review-jimmy/SKILL.md
```

Then restart Claude Code.

## Usage

### Slash command
```
/security-review-jimmy
/security-review-jimmy src/auth/
/security-review-jimmy --full
```

### Natural language (with skill installed)
```
Check my code for security issues
Run a security audit
Are there any vulnerabilities in my changes?
```

### Direct request (always works)
```
Run a security review on my recent changes
Do a full security audit of this project
Check the auth module for vulnerabilities
```

## Requirements

- [Claude Code](https://docs.anthropic.com/en/docs/claude-code) CLI or VS Code extension
- A git repository
