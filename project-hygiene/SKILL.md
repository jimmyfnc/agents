---
name: project-hygiene
description: Set up or run release hygiene in any project — semver x.x.x versioning, CHANGELOG discipline, pre-commit hooks that enforce version bumps and docs/roadmap coupling, git release tags, and ROADMAP/brainstorm docs workflow. Use when starting a new project, when asked to "set up versioning/changelog/hooks", or when shipping a release that needs a version bump + tag.
---

# Project Hygiene

Two modes. Detect which one applies from the user's request:
- **SETUP** — bootstrap the hygiene system in a project that lacks it
- **RELEASE** — ship a version correctly in a project that has it

## The system being enforced

1. **Semver `x.y.z`** (`0.MAJOR.MINOR` pre-release → `1.0.0` at launch). Every user-visible
   change gets its own version: features bump minor, fixes/polish bump patch. Never batch
   fixes into a future release.
2. **CHANGELOG.md** — every version gets a `## [x.y.z] — YYYY-MM-DD` entry, newest first,
   written for the user ("what changed for me"), not the developer.
3. **Pre-commit hook** enforcing both:
   - source change staged → version file + CHANGELOG must be staged too
   - brainstorm doc added/removed → ROADMAP/TODO must be staged too
4. **Git tags** — every released version gets an annotated tag `vX.Y.Z`, pushed. Tags give
   GitHub Releases, version-pinned installs, and rollback points.
5. **Docs workflow** — `docs/ROADMAP.md` (active ideas ranked by effort 🟢🟡🔴⚫),
   `docs/brainstorms/` (live ideas), `docs/archive/` (shipped — never delete docs).

## SETUP mode

1. **Detect the project type and version source.** Find where the version lives:
   - Android/Gradle: `app/build.gradle.kts` (`versionName` + `versionCode` — Code increments
     by 1 every release, Play Store requires monotonic)
   - Node: `package.json` `"version"` (add the field if missing)
   - Python: `pyproject.toml` `version`
   - Rust: `Cargo.toml` `version`
   - None found: create a `VERSION` file containing `0.1.0`
2. **Create CHANGELOG.md** if missing, with the format header and a first entry for the
   current state.
3. **Create the docs skeleton** if missing: `docs/ROADMAP.md` (effort-tier tables + a
   Maintenance section), `docs/brainstorms/`, `docs/archive/`. If the project already uses
   `docs/TODO.md` or similar, use that as the roadmap file instead of forcing a rename.
4. **Install the hook.** Copy `templates/pre-commit-hygiene.sh` to
   `scripts/pre-commit-hygiene.sh` and `templates/install-hooks.sh` to
   `scripts/install-hooks.sh`, then EDIT the config block at the top of the hook:
   - `SOURCE_PATTERNS` — regex for files that mean "code changed" (e.g. `^src/|^app/src/`)
   - `VERSION_FILE` — the file from step 1
   - `ROADMAP_FILE` — the roadmap/TODO path from step 3
   - `BRAINSTORM_DIR` — usually `docs/brainstorms/`
   Run `./scripts/install-hooks.sh`, then VERIFY by staging a dummy source change and
   confirming the commit is blocked (then clean up the dummy).

   **Pathing gotchas:** `.git/hooks/` is untracked — that's why the source lives in
   `scripts/` with an installer. On Windows, write the hook with LF line endings.
5. **Write the conventions into the project's CLAUDE.md** (create if missing): the
   versioning rules, the release checklist (below), and the docs workflow — so every
   future AI session follows them without being asked.
6. Commit the setup (the hook itself will pass — no source files changed).

## RELEASE mode (the checklist CLAUDE.md should carry)

When shipping a change:
1. Bump the version (patch for fixes, minor for features) + increment any build number
2. Add the `## [x.y.z] — YYYY-MM-DD` CHANGELOG entry
3. Update the "current version" reference in CLAUDE.md if it has one
4. If a roadmap item shipped: remove its ROADMAP row, `git mv` its brainstorm/plan to
   `docs/archive/`
5. Commit (hook verifies 1–2 automatically)
6. **Tag and push:**
   ```bash
   git tag -a vX.Y.Z -m "vX.Y.Z — one-line summary"
   git push origin main --follow-tags
   ```
7. If the repo has GitHub Releases discipline: `gh release create vX.Y.Z --generate-notes`
   (optional — ask the user once per project and record the answer in CLAUDE.md)

## Rules

- Never use `--no-verify` to dodge the hook except for docs-only/emergency commits, and say so.
- The hook blocks; it can't write. The version bump, changelog entry, and roadmap row are
  YOUR job when working in the project — do them without being asked.
- When uncertain whether a change is patch or minor, ask once, then record the precedent
  in CLAUDE.md.
