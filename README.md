# Claude Code Agents

A collection of custom [Claude Code](https://docs.anthropic.com/en/docs/claude-code)
agents, skills, and slash commands for automating software-engineering workflows.

Each folder is a self-contained package with its own README. Install everything
with `./install.sh` (version-pinned), or copy the pieces you want into `~/.claude/`.

## Available packages

| Package | What it does |
|---------|--------------|
| [code-review](code-review/) | Multi-model review: **parallel** breadth + performance + security reviewers, an Opus deep-dive, **adversarial verification** that cuts false positives, structured findings, an approval gate, and a mandatory doc-drift check before finishing |
| [perf-review](perf-review/) | Performance review — Big O, impact estimates, honest "worth it?" calls. Emits structured findings; runs standalone or as a stage of code-review |
| [security-review](security-review/) | Security review — auto-detects project type, applies the right OWASP framework, and **runs real scanners (gitleaks / osv-scanner / semgrep) when available** instead of recalling CVEs. Standalone or a stage of code-review |
| [doc-drift-detector](doc-drift-detector/) | Finds stale, missing, inconsistent, or obsolete docs by auto-discovering all project documentation and cross-referencing it against code changes |
| [first-principles](first-principles/) | Deconstructs any problem from first principles — strips assumptions, finds foundational truths, rebuilds from scratch |
| [pre-mortem](pre-mortem/) | Assumes a plan/release already failed and reasons backward — ranks risks by likelihood × impact and guards the top ones. The destructive complement to first-principles |
| [project-hygiene](project-hygiene/) | Bootstraps release hygiene in any project: semver, CHANGELOG, a pre-commit hook enforcing version + docs coupling, git tags, and a docs workflow |
| [release](release/) | Runs a release against a hygiene setup — bump, CHANGELOG entry, tag, push (the RELEASE half of project-hygiene) |
| [commit-pr-author](commit-pr-author/) | Writes a commit message or PR description from the actual diff, matching the repo's existing style |
| [skill-linter](skill-linter/) | Lints skills, subagents, and commands for correct frontmatter, quality descriptions, and dead references |

Each review package ships three ways: a **subagent** (spawned via `Task`), an
auto-triggering **skill**, and a **`/…-jimmy` slash command**.

### Relationship to built-in Claude Code tools

Recent Claude Code ships first-party `/code-review` (incl. an `ultra` multi-agent
cloud mode), `/security-review`, `/simplify`, and `/verify`. This suite is the
**always-available, version-pinned** variant with an integrated doc-drift stage and
a fixed output format. For the single deepest review, prefer the built-in
`/code-review ultra`; for everyday local runs, use these.

## Installation

```bash
git clone https://github.com/jimmyfnc/agents.git
cd agents
./install.sh            # install the latest tagged release into ~/.claude
./install.sh v1.2.0     # or a specific version
./install.sh --check    # verify installed files match the pinned version
```

Then restart Claude Code. Prefer `install.sh` over manual copying — it pins to a
tag and can detect drift. Per-package manual steps live in each package's README.

## Structure

```
agents/
├── README.md · CHANGELOG.md · LICENSE · install.sh
├── code-review/
│   ├── code-review.md          # orchestrator (parallel fan-out → depth → verify → gate → fix → doc-drift)
│   ├── sonnet-reviewer.md      # breadth first pass
│   ├── opus-reviewer.md        # depth second pass
│   ├── review-verifier.md      # adversarial verifier (drops false positives)
│   ├── finding-schema.md       # shared structured-findings spec
│   └── extras/ (SKILL.md, code-review-jimmy-command.md)
├── perf-review/         · perf-review.md         + extras/
├── security-review/     · security-review.md     + extras/
├── doc-drift-detector/  · doc-drift-detector.md  + extras/
├── first-principles/    · first-principles.md    + extras/
├── pre-mortem/          · pre-mortem.md           + extras/
├── project-hygiene/     · SKILL.md + templates/
├── release/             · SKILL.md + extras/
├── commit-pr-author/    · SKILL.md + extras/
└── skill-linter/        · SKILL.md + extras/
```

## Contributing

Each package lives in its own folder with a README and all files needed to run.
Run `skill-linter` against the repo before opening a PR to catch frontmatter and
reference issues.

## License

MIT
