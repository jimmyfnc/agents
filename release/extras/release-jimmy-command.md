---
allowed-tools: Skill, Read, Edit, Write, Bash, Grep, Glob
argument-hint: [patch | minor | major]
description: Cut a versioned release — bump semver, update CHANGELOG, commit, tag, and push
---

Run the `release` skill to cut a release for this project.

If `$ARGUMENTS` names a bump level (`patch` / `minor` / `major`), use it; otherwise infer the level from what changed since the last release.

Invoke the skill via the Skill tool (`release`) and follow its steps: detect the version source, bump, update the CHANGELOG (and roadmap/docs if an item shipped), commit, tag `vX.Y.Z`, and push with `--follow-tags`.
