#!/usr/bin/env bash
set -euo pipefail

# Claude Code Agents Installer
# Usage:
#   ./install.sh              Install latest tagged release
#   ./install.sh v1.0.0       Install a specific version
#   ./install.sh --check      Check if installed files match a version

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
CLAUDE_DIR="$HOME/.claude"

# Colors (skip if not a terminal)
if [ -t 1 ]; then
  GREEN='\033[0;32m'
  YELLOW='\033[0;33m'
  RED='\033[0;31m'
  BOLD='\033[1m'
  NC='\033[0m'
else
  GREEN='' YELLOW='' RED='' BOLD='' NC=''
fi

print_ok()   { echo -e "${GREEN}[OK]${NC} $1"; }
print_warn() { echo -e "${YELLOW}[!!]${NC} $1"; }
print_err()  { echo -e "${RED}[ERR]${NC} $1"; }
print_info() { echo -e "${BOLD}$1${NC}"; }

# Get the latest tag in the repo
get_latest_tag() {
  git -C "$REPO_DIR" describe --tags --abbrev=0 2>/dev/null || echo ""
}

# Get the tag for a specific commit
get_tag_for_head() {
  git -C "$REPO_DIR" describe --tags --exact-match HEAD 2>/dev/null || echo ""
}

# Install agents, commands, and skills
do_install() {
  local version="$1"

  print_info "Installing Claude Code agents $version"
  echo ""

  # Checkout the requested version
  local current_branch
  current_branch=$(git -C "$REPO_DIR" branch --show-current)
  git -C "$REPO_DIR" checkout "$version" --quiet 2>/dev/null || {
    print_err "Version '$version' not found. Available tags:"
    git -C "$REPO_DIR" tag -l | sort -V
    exit 1
  }

  # --- Agents ---
  print_info "Installing agents..."

  mkdir -p "$CLAUDE_DIR/agents/review"
  cp "$REPO_DIR/code-review/code-review.md" "$CLAUDE_DIR/agents/review/"
  cp "$REPO_DIR/code-review/sonnet-reviewer.md" "$CLAUDE_DIR/agents/review/"
  cp "$REPO_DIR/code-review/opus-reviewer.md" "$CLAUDE_DIR/agents/review/"
  print_ok "code-review (code-review.md, sonnet-reviewer.md, opus-reviewer.md)"

  mkdir -p "$CLAUDE_DIR/agents/perf"
  cp "$REPO_DIR/perf-review/perf-review.md" "$CLAUDE_DIR/agents/perf/"
  print_ok "perf-review"

  mkdir -p "$CLAUDE_DIR/agents/security"
  cp "$REPO_DIR/security-review/security-review.md" "$CLAUDE_DIR/agents/security/"
  print_ok "security-review"

  mkdir -p "$CLAUDE_DIR/agents/docs"
  cp "$REPO_DIR/doc-drift-detector/doc-drift-detector.md" "$CLAUDE_DIR/agents/docs/"
  print_ok "doc-drift-detector"

  mkdir -p "$CLAUDE_DIR/agents/first-principles"
  cp "$REPO_DIR/first-principles/first-principles.md" "$CLAUDE_DIR/agents/first-principles/"
  print_ok "first-principles"

  # --- Commands ---
  echo ""
  print_info "Installing slash commands..."

  mkdir -p "$CLAUDE_DIR/commands"
  cp "$REPO_DIR/code-review/extras/code-review-jimmy-command.md" "$CLAUDE_DIR/commands/code-review-jimmy.md"
  print_ok "/code-review-jimmy"

  cp "$REPO_DIR/perf-review/extras/perf-review-jimmy-command.md" "$CLAUDE_DIR/commands/perf-review-jimmy.md"
  print_ok "/perf-review-jimmy"

  cp "$REPO_DIR/security-review/extras/security-review-jimmy-command.md" "$CLAUDE_DIR/commands/security-review-jimmy.md"
  print_ok "/security-review-jimmy"

  cp "$REPO_DIR/doc-drift-detector/extras/doc-drift-jimmy-command.md" "$CLAUDE_DIR/commands/doc-drift-jimmy.md"
  print_ok "/doc-drift-jimmy"

  cp "$REPO_DIR/first-principles/extras/first-principles-jimmy-command.md" "$CLAUDE_DIR/commands/first-principles-jimmy.md"
  print_ok "/first-principles-jimmy"

  # --- Skills ---
  echo ""
  print_info "Installing skills..."

  mkdir -p "$CLAUDE_DIR/skills/code-review-jimmy"
  cp "$REPO_DIR/code-review/extras/SKILL.md" "$CLAUDE_DIR/skills/code-review-jimmy/SKILL.md"
  print_ok "code-review-jimmy"

  mkdir -p "$CLAUDE_DIR/skills/perf-review-jimmy"
  cp "$REPO_DIR/perf-review/extras/SKILL.md" "$CLAUDE_DIR/skills/perf-review-jimmy/SKILL.md"
  print_ok "perf-review-jimmy"

  mkdir -p "$CLAUDE_DIR/skills/security-review-jimmy"
  cp "$REPO_DIR/security-review/extras/SKILL.md" "$CLAUDE_DIR/skills/security-review-jimmy/SKILL.md"
  print_ok "security-review-jimmy"

  mkdir -p "$CLAUDE_DIR/skills/doc-drift-jimmy"
  cp "$REPO_DIR/doc-drift-detector/extras/SKILL.md" "$CLAUDE_DIR/skills/doc-drift-jimmy/SKILL.md"
  print_ok "doc-drift-jimmy"

  mkdir -p "$CLAUDE_DIR/skills/first-principles-jimmy"
  cp "$REPO_DIR/first-principles/extras/SKILL.md" "$CLAUDE_DIR/skills/first-principles-jimmy/SKILL.md"
  print_ok "first-principles-jimmy"

  mkdir -p "$CLAUDE_DIR/skills/project-hygiene/templates"
  cp "$REPO_DIR/project-hygiene/SKILL.md" "$CLAUDE_DIR/skills/project-hygiene/SKILL.md"
  cp "$REPO_DIR"/project-hygiene/templates/*.sh "$CLAUDE_DIR/skills/project-hygiene/templates/"
  print_ok "project-hygiene"

  # Return to original branch
  git -C "$REPO_DIR" checkout "$current_branch" --quiet 2>/dev/null

  # Write version marker
  echo "$version" > "$CLAUDE_DIR/.agents-version"

  echo ""
  print_info "============================================"
  print_ok "Installed $version"
  print_info "============================================"
  echo ""
  echo "Restart Claude Code to activate the changes."
}

# Check installed version against repo
do_check() {
  local version_file="$CLAUDE_DIR/.agents-version"

  if [ ! -f "$version_file" ]; then
    print_warn "No version marker found. Run ./install.sh to install."
    return 1
  fi

  local installed_version
  installed_version=$(cat "$version_file")
  local latest_tag
  latest_tag=$(get_latest_tag)

  print_info "Installed version: $installed_version"
  print_info "Latest tag:        $latest_tag"
  echo ""

  if [ "$installed_version" = "$latest_tag" ]; then
    print_ok "You're on the latest version."
  else
    print_warn "Update available: $installed_version -> $latest_tag"
    echo "  Run: ./install.sh $latest_tag"
  fi

  # Check if any installed files differ from the version
  echo ""
  print_info "Checking file integrity..."
  local current_branch
  current_branch=$(git -C "$REPO_DIR" branch --show-current)
  git -C "$REPO_DIR" checkout "$installed_version" --quiet 2>/dev/null

  local drift=0
  local files_to_check=(
    "code-review/code-review.md:agents/review/code-review.md"
    "code-review/sonnet-reviewer.md:agents/review/sonnet-reviewer.md"
    "code-review/opus-reviewer.md:agents/review/opus-reviewer.md"
    "perf-review/perf-review.md:agents/perf/perf-review.md"
    "security-review/security-review.md:agents/security/security-review.md"
    "doc-drift-detector/doc-drift-detector.md:agents/docs/doc-drift-detector.md"
    "first-principles/first-principles.md:agents/first-principles/first-principles.md"
  )

  for entry in "${files_to_check[@]}"; do
    local src="${entry%%:*}"
    local dst="${entry##*:}"
    local src_path="$REPO_DIR/$src"
    local dst_path="$CLAUDE_DIR/$dst"

    if [ ! -f "$dst_path" ]; then
      print_err "Missing: $dst"
      drift=1
    elif ! diff -q "$src_path" "$dst_path" > /dev/null 2>&1; then
      print_warn "Modified: $dst (differs from $installed_version)"
      drift=1
    else
      print_ok "$dst"
    fi
  done

  git -C "$REPO_DIR" checkout "$current_branch" --quiet 2>/dev/null

  echo ""
  if [ "$drift" -eq 0 ]; then
    print_ok "All installed files match $installed_version"
  else
    print_warn "Some files have drifted from $installed_version"
    echo "  Run: ./install.sh $installed_version   (to restore)"
    echo "  Run: ./install.sh $latest_tag          (to update)"
  fi
}

# --- Main ---

case "${1:-}" in
  --check|-c)
    do_check
    ;;
  --help|-h)
    echo "Claude Code Agents Installer"
    echo ""
    echo "Usage:"
    echo "  ./install.sh              Install latest tagged release"
    echo "  ./install.sh v1.0.0       Install a specific version"
    echo "  ./install.sh --check      Check installed version and file integrity"
    echo "  ./install.sh --help       Show this help"
    ;;
  "")
    # No version specified — use latest tag
    latest=$(get_latest_tag)
    if [ -z "$latest" ]; then
      print_err "No tags found in this repo. Create one first:"
      echo "  git tag -a v1.0.0 -m 'Initial release'"
      exit 1
    fi
    do_install "$latest"
    ;;
  *)
    do_install "$1"
    ;;
esac
