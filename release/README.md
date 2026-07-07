# release

Ship a versioned release in one pass: bump semver, write the CHANGELOG entry,
reconcile roadmap/docs, commit, tag `vX.Y.Z`, and push.

This is the RELEASE half of [project-hygiene](../project-hygiene/). project-hygiene
**sets up** the system (version source, CHANGELOG, pre-commit hook, docs workflow);
`release` **runs** a release against it. If no hygiene system exists yet, it says so
and offers to run project-hygiene SETUP first.

## Steps

1. Detect the version source (`package.json`, `pyproject.toml`, `Cargo.toml`, Gradle, `VERSION`, or git tags).
2. Decide the bump (patch/minor/major) from what changed.
3. Bump the version, add the `## [x.y.z] — YYYY-MM-DD` CHANGELOG entry, reconcile roadmap/docs.
4. Commit (the hygiene hook, if present, verifies version + changelog were staged).
5. Tag `vX.Y.Z` and push `--follow-tags`.
6. Optionally `gh release create`.

## Install

Installed by the repo `install.sh`. Manually:

```bash
mkdir -p ~/.claude/skills/release
cp release/SKILL.md ~/.claude/skills/release/SKILL.md
cp release/extras/release-jimmy-command.md ~/.claude/commands/release-jimmy.md
```

## Use

- `/release-jimmy minor`
- Or: "cut a release" / "ship it" / "bump the version and tag it".
