# Claude Code Agents

A collection of custom [Claude Code](https://docs.anthropic.com/en/docs/claude-code) agents for automating software engineering workflows.

Each folder contains a self-contained agent pipeline with its own README, ready to drop into your `~/.claude/agents/` directory.

## Available Agents

| Agent | Description |
|-------|-------------|
| [code-review-pipeline](code-review-pipeline/) | Multi-stage code review using Sonnet (breadth) + Opus (depth) with smart diff detection, confidence levels, and optional auto-fix |

## Installation

1. Clone this repo:
   ```bash
   git clone https://github.com/jimmyfnc/agents.git
   ```

2. Copy the agent files you want into your global Claude config:
   ```bash
   # Example: install the code review pipeline
   mkdir -p ~/.claude/agents/review
   cp agents/code-review-pipeline/{code-review-pipeline,sonnet-reviewer,opus-reviewer}.md ~/.claude/agents/review/
   ```

3. Optionally install the slash command and/or skill:
   ```bash
   # /review slash command
   cp agents/code-review-pipeline/extras/review-command.md ~/.claude/commands/review.md

   # Auto-trigger skill
   mkdir -p ~/.claude/skills/code-review-pipeline
   cp agents/code-review-pipeline/extras/SKILL.md ~/.claude/skills/code-review-pipeline/SKILL.md
   ```

4. Restart Claude Code. The agents will be available automatically.

## Structure

```
agents/
├── README.md
├── CHANGELOG.md
└── code-review-pipeline/
    ├── README.md
    ├── code-review-pipeline.md   # Orchestrator agent
    ├── sonnet-reviewer.md        # First-pass reviewer (Sonnet)
    ├── opus-reviewer.md          # Deep-dive reviewer (Opus)
    └── extras/
        ├── review-command.md     # /review slash command
        └── SKILL.md              # Auto-trigger skill
```

## Contributing

Feel free to open issues or PRs. Each agent pipeline should:
- Live in its own folder
- Include a README explaining what it does, how to install, and how to use it
- Include all `.md` agent files needed to run

## License

MIT
