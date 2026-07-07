---
name: release
description: Ship a versioned release correctly in one pass — bump semver, add the CHANGELOG entry, reconcile roadmap/docs, commit, tag, and push. Use when the user says "cut a release", "ship it", "bump the version", "tag a release", or is finishing a change that needs to go out. Complements project-hygiene (which sets the system up); this runs the release.
---

You run a release end to end. This is the RELEASE half of [project-hygiene](../project-hygiene/) — assume the hygiene system already exists (a version source, `CHANGELOG.md`, optionally a pre-commit hook and `docs/`). If it doesn't, say so and offer to run project-hygiene SETUP first.

## Step 1 — Detect the version source

Find where the version lives: `package.json` (`version`), `pyproject.toml`, `Cargo.toml`, `build.gradle(.kts)` (`versionName` + `versionCode`), or a `VERSION` file. If the repo versions purely by git tag (no version file), the latest tag is the source.

## Step 2 — Decide the bump

Summarize what changed since the last release (`git log <lastTag>..HEAD --oneline` or the working diff). Then:

- **patch** (`x.y.Z`) — fixes, polish, docs-only-affecting-users.
- **minor** (`x.Y.0`) — a new user-visible feature or capability.
- **major** (`X.0.0`) — breaking change, or the pre-launch `0.x` → `1.0.0` graduation.

If it's genuinely ambiguous, ask once; otherwise state your choice and proceed. Increment any build number too (e.g. Android `versionCode` +1).

## Step 3 — Update release files

1. Bump the version in the version source.
2. Add a `## [x.y.z] — YYYY-MM-DD` entry at the top of `CHANGELOG.md`, written for the user ("what changed for me"), grouped Added / Changed / Fixed. Use today's real date.
3. If a roadmap item shipped: remove its `docs/ROADMAP.md` row and `git mv` its brainstorm to `docs/archive/`.
4. Update any "current version" reference in `CLAUDE.md`/README.

## Step 4 — Commit

Stage the changes and commit (`Release vX.Y.Z — <one-line summary>`). If a pre-commit hygiene hook is installed, it verifies the version + changelog were staged — do not use `--no-verify` to dodge it.

## Step 5 — Tag & push

```bash
git tag -a vX.Y.Z -m "vX.Y.Z — <one-line summary>"
git push origin <branch> --follow-tags
```

## Step 6 — GitHub release (optional)

If the repo uses GitHub Releases, offer: `gh release create vX.Y.Z --generate-notes` (or `--notes` from the CHANGELOG entry). Ask once per project whether to do this by default.

## Rules

- One user-visible change per version; never batch unrelated fixes under one bump "for later".
- The CHANGELOG entry and the tag are mandatory — a release without both is incomplete.
- Confirm the branch before pushing; never force-push a release.
- Show the user the planned bump + changelog entry before committing if the change set is large or the bump level is non-obvious.
