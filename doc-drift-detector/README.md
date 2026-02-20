# Doc Drift Detector

Detects stale, missing, or inconsistent documentation by auto-discovering all project docs and cross-referencing them against code changes.

## How It Works

```
┌─────────────────────────────────────────────────────┐
│  Step 1: Discover All Documentation                 │
│  Auto-find: *.md, TODOs, CHANGELOGs, docs/, etc.   │
├─────────────────────────────────────────────────────┤
│  Step 2: Detect What Changed                        │
│  Smart diff detection (or full audit mode)          │
├─────────────────────────────────────────────────────┤
│  Step 3: Read & Map Documentation                   │
│  Understand what each doc covers                    │
├─────────────────────────────────────────────────────┤
│  Step 4: Cross-Reference & Detect Drift             │
│  Find stale, missing, inconsistent, incomplete docs │
├─────────────────────────────────────────────────────┤
│  Step 5: Produce Report                             │
│  Structured findings with suggested fixes           │
└─────────────────────────────────────────────────────┘
```

## Agent

| Agent | Model | Role |
|-------|-------|------|
| `doc-drift-detector` | Sonnet | Scans all project docs, cross-references against code changes, reports drift |

## What It Catches

| Category | Examples |
|----------|---------|
| **STALE** | README mentions old API, install instructions have wrong commands, architecture docs describe old structure |
| **MISSING** | New feature with no docs, new folder with no README, CHANGELOG missing entries |
| **INCONSISTENT** | Root README says one thing, sub-folder README says another |
| **INCOMPLETE** | File tree missing new files, feature list missing new features, install steps missing new options |
| **TODO Drift** | Tasks marked pending that are already done in code, or done items with lingering TODOs |

## Auto-Discovery

The agent automatically finds all documentation — no config needed:

- All `*.md` files anywhere in the project
- `TODO`, `CHANGELOG`, `CONTRIBUTING`, `LICENSE` files
- `docs/`, `wiki/`, `.github/` folders
- Package metadata (`package.json` description, etc.)
- Inline doc references in code comments

## Installation

### 1. Install the agent (required)

```bash
mkdir -p ~/.claude/agents/docs
cp doc-drift-detector.md ~/.claude/agents/docs/
```

### 2. Install the slash command (optional)

```bash
cp extras/doc-drift-command.md ~/.claude/commands/doc-drift.md
```

### 3. Install the skill (optional)

```bash
mkdir -p ~/.claude/skills/doc-drift-detector
cp extras/SKILL.md ~/.claude/skills/doc-drift-detector/SKILL.md
```

Then restart Claude Code.

## Usage

### Slash command
```
/doc-drift
/doc-drift --full
/doc-drift src/auth/
```

### Natural language (with skill installed)
```
Check if my docs are up to date
Are there any stale docs?
Did I miss any doc updates?
Run a documentation audit
```

### Direct request (always works)
```
Scan my documentation for drift
Run a full documentation audit
Check docs after my recent changes
```

### Scoping

| What you want | How to invoke |
|---|---|
| Check against recent changes | `/doc-drift` (auto-detected) |
| Full project audit | `/doc-drift --full` |
| Scoped to a folder | `/doc-drift src/auth/` |
| After a commit | `Did I miss any doc updates?` |

## Requirements

- [Claude Code](https://docs.anthropic.com/en/docs/claude-code) CLI or VS Code extension
- A git repository
