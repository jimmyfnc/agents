# Claude Code Agents

A collection of custom [Claude Code](https://docs.anthropic.com/en/docs/claude-code) agents for automating software engineering workflows.

Each folder contains a self-contained agent pipeline with its own README, ready to drop into your `~/.claude/agents/` directory.

## Available Agents

| Agent | Description |
|-------|-------------|
| [code-review](code-review/) | Multi-stage code review using Sonnet (breadth) + Opus (depth) with smart diff detection, confidence levels, performance analysis with Big O notation, and user-approved fixes |
| [perf-review](perf-review/) | Performance-focused code review with Big O notation, impact estimation (high/medium/low), and "worth it?" assessment. Runs standalone or as Stage 2.5 of code-review |
| [security-review](security-review/) | Security-focused code review that auto-detects project type and applies OWASP frameworks. Scans for vulnerabilities, secrets, auth issues. Runs standalone or as Stage 2.75 of code-review |
| [first-principles](first-principles/) | First Principles Analyst — strips assumptions, finds foundational truths, rebuilds solutions from scratch. Works for any problem: code, product, business, personal |
| [doc-drift-detector](doc-drift-detector/) | Detects stale, missing, inconsistent, or obsolete documentation by auto-discovering all project docs and cross-referencing against code changes |

## Installation

1. Clone this repo:
   ```bash
   git clone https://github.com/jimmyfnc/agents.git
   ```

2. Copy the agent files you want into your global Claude config:
   ```bash
   # Example: install the code review
   mkdir -p ~/.claude/agents/review
   cp agents/code-review/{code-review,sonnet-reviewer,opus-reviewer}.md ~/.claude/agents/review/

   # For the full code review (including perf + security + doc drift), also install:
   mkdir -p ~/.claude/agents/perf
   cp agents/perf-review/perf-review.md ~/.claude/agents/perf/
   mkdir -p ~/.claude/agents/security
   cp agents/security-review/security-review.md ~/.claude/agents/security/
   mkdir -p ~/.claude/agents/docs
   cp agents/doc-drift-detector/doc-drift-detector.md ~/.claude/agents/docs/
   ```

3. Optionally install the slash command and/or skill:
   ```bash
   # /code-review-jimmy slash command
   cp agents/code-review/extras/code-review-jimmy-command.md ~/.claude/commands/code-review-jimmy.md

   # Auto-trigger skill
   mkdir -p ~/.claude/skills/code-review-jimmy
   cp agents/code-review/extras/SKILL.md ~/.claude/skills/code-review-jimmy/SKILL.md
   ```

4. Restart Claude Code. The agents will be available automatically.

## Structure

```
agents/
├── README.md
├── CHANGELOG.md
├── LICENSE
├── code-review/
│   ├── README.md
│   ├── code-review.md             # Orchestrator agent
│   ├── sonnet-reviewer.md         # First-pass reviewer (Sonnet)
│   ├── opus-reviewer.md           # Deep-dive reviewer (Opus)
│   └── extras/
│       ├── code-review-jimmy-command.md # /code-review-jimmy slash command
│       └── SKILL.md               # Auto-trigger skill
├── perf-review/
│   ├── README.md
│   ├── perf-review.md             # Performance review agent (Sonnet)
│   └── extras/
│       ├── perf-review-jimmy-command.md # /perf-review-jimmy slash command
│       └── SKILL.md               # Auto-trigger skill
├── first-principles/
│   ├── README.md
│   ├── first-principles.md        # First principles analyst (Sonnet)
│   └── extras/
│       ├── first-principles-jimmy-command.md # /first-principles-jimmy slash command
│       └── SKILL.md               # Auto-trigger skill
├── security-review/
│   ├── README.md
│   ├── security-review.md         # Security review agent (Sonnet)
│   └── extras/
│       ├── security-review-jimmy-command.md # /security-review-jimmy slash command
│       └── SKILL.md               # Auto-trigger skill
└── doc-drift-detector/
    ├── README.md
    ├── doc-drift-detector.md      # Doc drift agent (Sonnet)
    └── extras/
        ├── doc-drift-jimmy-command.md # /doc-drift-jimmy slash command
        └── SKILL.md               # Auto-trigger skill
```

## Contributing

Feel free to open issues or PRs. Each agent pipeline should:
- Live in its own folder
- Include a README explaining what it does, how to install, and how to use it
- Include all `.md` agent files needed to run

## License

MIT
