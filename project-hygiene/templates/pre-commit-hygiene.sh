#!/bin/bash
# Pre-commit hygiene hook — version-bump + docs-coupling enforcement.
# Source of truth lives in scripts/; install with ./scripts/install-hooks.sh
# (.git/hooks is untracked, so the hook can't be committed directly).
#
# ── CONFIG: adapt these four lines per project ──────────────────────────────
SOURCE_PATTERNS="^src/"                 # regex: files that count as "code changed"
VERSION_FILE="package.json"             # where the x.y.z version lives
ROADMAP_FILE="docs/ROADMAP.md"          # the effort-ranked backlog (or docs/TODO.md)
BRAINSTORM_DIR="docs/brainstorms/"      # live idea docs
# Files exempt from the version check even if they match SOURCE_PATTERNS:
EXEMPT_PATTERNS="\.md$|\.json$|\.yml$|\.yaml$|\.properties$|^\.claude/|^docs/|^scripts/"
# ────────────────────────────────────────────────────────────────────────────

STAGED_FILES=$(git diff --cached --name-only --diff-filter=ACMR)
[ -z "$STAGED_FILES" ] && exit 0

# ── Check 1: brainstorm docs must travel with a roadmap update ──────────────
BRAINSTORM_TOUCHED=$(git diff --cached --name-only --diff-filter=ADR | grep -E "^${BRAINSTORM_DIR}.*\.md$" || true)
ROADMAP_STAGED=$(git diff --cached --name-only | grep -cF "$ROADMAP_FILE" || true)
if [ -n "$BRAINSTORM_TOUCHED" ] && [ "$ROADMAP_STAGED" = "0" ]; then
  echo ""
  echo "DOCS CHECK FAILED"
  echo "  Brainstorm doc added/removed without updating $ROADMAP_FILE:"
  echo "$BRAINSTORM_TOUCHED" | sed 's/^/    /'
  echo "  New idea  -> add a row to $ROADMAP_FILE"
  echo "  Shipped   -> git mv the doc to docs/archive/ and remove its row"
  echo "  (skip: git commit --no-verify)"
  echo ""
  exit 1
fi

# ── Check 2: source changes require a version bump + changelog entry ────────
HAS_SOURCE_CHANGES=false
for file in $STAGED_FILES; do
  if echo "$file" | grep -qE "$SOURCE_PATTERNS"; then
    if ! echo "$file" | grep -qE "$EXEMPT_PATTERNS"; then
      HAS_SOURCE_CHANGES=true
      break
    fi
  fi
done
[ "$HAS_SOURCE_CHANGES" = false ] && exit 0

VERSION_STAGED=$(git diff --cached --name-only | grep -cF "$VERSION_FILE" || true)
CHANGELOG_STAGED=$(git diff --cached --name-only | grep -c "^CHANGELOG\.md$" || true)

if [ "$VERSION_STAGED" = "0" ] || [ "$CHANGELOG_STAGED" = "0" ]; then
  echo ""
  echo "VERSION CHECK FAILED — source changed but release files not staged."
  [ "$VERSION_STAGED" = "0" ]   && echo "  Missing: $VERSION_FILE (bump the x.y.z version)"
  [ "$CHANGELOG_STAGED" = "0" ] && echo "  Missing: CHANGELOG.md (add a ## [x.y.z] — YYYY-MM-DD entry)"
  echo "  Every fix or feature ships with its own version. Then:"
  echo "    git add $VERSION_FILE CHANGELOG.md"
  echo "  After committing, tag it: git tag -a vX.Y.Z -m \"...\" && git push --follow-tags"
  echo "  (skip, emergencies only: git commit --no-verify)"
  echo ""
  exit 1
fi

exit 0
