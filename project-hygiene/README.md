# project-hygiene

A Claude Code **skill** that sets up and runs release hygiene in any project:

- **Semver `x.y.z`** versioning with a per-project version source (Gradle, package.json, pyproject, Cargo, or a `VERSION` file)
- **CHANGELOG.md** discipline — every shipped change gets its own version + entry
- **Pre-commit hook** (template included) enforcing two couplings:
  - source change staged → version file + CHANGELOG staged
  - brainstorm doc added/removed → ROADMAP/TODO updated
- **Git release tags** — annotated `vX.Y.Z` pushed with `--follow-tags` (GitHub Releases, pinned installs, rollback points)
- **Docs workflow** — `docs/ROADMAP.md` ranked by effort, `docs/brainstorms/` for live ideas, `docs/archive/` for shipped ones

Born in the discipline-app project, where the hook + workflow keep the roadmap honest.

## Install

```bash
mkdir -p ~/.claude/skills/project-hygiene/templates
cp project-hygiene/SKILL.md ~/.claude/skills/project-hygiene/
cp project-hygiene/templates/* ~/.claude/skills/project-hygiene/templates/
```

(or run the repo's `./install.sh`)

## Use

In any project, ask Claude: *"set up project hygiene"* (SETUP mode — bootstraps everything,
adapts the hook's config block to the project type) or rely on it during normal work —
the skill's RELEASE checklist makes Claude bump/changelog/tag correctly when shipping.

The hook templates are also usable standalone without Claude: copy `templates/` into
`scripts/`, edit the four config lines at the top, run `./scripts/install-hooks.sh`.
