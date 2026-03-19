#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'EOF'
Usage: bash install.sh [options]

Options:
  --target <name>   Install target: all | universal | codex | claude | openclaw
                    all: install canonical skill/toolkit plus links for Codex, Claude Code, and OpenClaw
                    universal: install only the canonical Agent Skills layout under ~/.agents
                    codex|claude|openclaw: install the canonical layout plus one native compatibility link
  --force           Overwrite existing installed skill/toolkit
  --skip-npm        Skip npm install / npm ci in the toolkit
  --skip-smoke      Skip npm run list smoke test even if STITCH_API_KEY is set
  -h, --help        Show this help
EOF
}

require_cmd() {
  if ! command -v "$1" >/dev/null 2>&1; then
    echo "Missing required command: $1" >&2
    exit 1
  fi
}

copy_dir() {
  local src="$1"
  local dest="$2"
  mkdir -p "$(dirname "$dest")"
  cp -R "$src" "$dest"
}

safe_remove() {
  local path="$1"
  if [[ -L "$path" || -e "$path" ]]; then
    rm -rf "$path"
  fi
}

create_link() {
  local src="$1"
  local dest="$2"
  mkdir -p "$(dirname "$dest")"
  ln -sfn "$src" "$dest"
}

FORCE=0
SKIP_NPM=0
SKIP_SMOKE=0
TARGET="all"
ENV_BACKUP=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --target)
      TARGET="${2:-}"
      shift
      ;;
    --force)
      FORCE=1
      ;;
    --skip-npm)
      SKIP_NPM=1
      ;;
    --skip-smoke)
      SKIP_SMOKE=1
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "Unknown argument: $1" >&2
      usage >&2
      exit 1
      ;;
  esac
  shift
done

case "$TARGET" in
  all|universal|codex|claude|openclaw)
    ;;
  *)
    echo "Invalid --target value: $TARGET" >&2
    usage >&2
    exit 1
    ;;
esac

require_cmd node
require_cmd npm

NODE_MAJOR="$(node -p 'process.versions.node.split(".")[0]')"
if [[ "$NODE_MAJOR" -lt 22 ]]; then
  echo "Node.js 22+ is required. Current version: $(node -v)" >&2
  exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$SCRIPT_DIR"

AGENT_SKILLS_HOME="${AGENT_SKILLS_HOME:-$HOME/.agents}"
STITCH_STARTER_ROOT="${STITCH_STARTER_ROOT:-$AGENT_SKILLS_HOME/stitch-starter}"
CODEX_HOME="${CODEX_HOME:-$HOME/.codex}"
CLAUDE_HOME="${CLAUDE_HOME:-$HOME/.claude}"
OPENCLAW_HOME="${OPENCLAW_HOME:-$HOME/.openclaw}"

SKILL_SRC="$REPO_ROOT/skills/stitch-design-local"
TOOLKIT_SRC="$REPO_ROOT/stitch-starter"
CANONICAL_SKILL_DEST="$AGENT_SKILLS_HOME/skills/stitch-design-local"
TOOLKIT_DEST="$STITCH_STARTER_ROOT"

CODEX_LINK="$CODEX_HOME/skills/stitch-design-local"
CLAUDE_LINK="$CLAUDE_HOME/skills/stitch-design-local"
OPENCLAW_LINK="$OPENCLAW_HOME/skills/stitch-design-local"

if [[ ! -d "$SKILL_SRC" || ! -d "$TOOLKIT_SRC" ]]; then
  echo "Repository layout is invalid. Missing skill or toolkit source directory." >&2
  exit 1
fi

declare -a LINK_DESTS=()
case "$TARGET" in
  all)
    LINK_DESTS+=("$CODEX_LINK" "$CLAUDE_LINK" "$OPENCLAW_LINK")
    ;;
  codex)
    LINK_DESTS+=("$CODEX_LINK")
    ;;
  claude)
    LINK_DESTS+=("$CLAUDE_LINK")
    ;;
  openclaw)
    LINK_DESTS+=("$OPENCLAW_LINK")
    ;;
  universal)
    ;;
esac

mkdir -p "$AGENT_SKILLS_HOME/skills"

if [[ -e "$CANONICAL_SKILL_DEST" || -e "$TOOLKIT_DEST" ]]; then
  if [[ "$FORCE" -ne 1 ]]; then
    echo "Destination already exists." >&2
    echo "Use --force to overwrite:" >&2
    echo "  $CANONICAL_SKILL_DEST" >&2
    echo "  $TOOLKIT_DEST" >&2
    exit 1
  fi
  if [[ -f "$TOOLKIT_DEST/.env" ]]; then
    ENV_BACKUP="$(mktemp)"
    cp "$TOOLKIT_DEST/.env" "$ENV_BACKUP"
  fi
  safe_remove "$CANONICAL_SKILL_DEST"
  safe_remove "$TOOLKIT_DEST"
fi

for link_dest in "${LINK_DESTS[@]}"; do
  if [[ -e "$link_dest" || -L "$link_dest" ]]; then
    if [[ "$FORCE" -ne 1 ]]; then
      echo "Compatibility link already exists: $link_dest" >&2
      echo "Use --force to overwrite existing compatibility links." >&2
      exit 1
    fi
    safe_remove "$link_dest"
  fi
done

copy_dir "$SKILL_SRC" "$CANONICAL_SKILL_DEST"
copy_dir "$TOOLKIT_SRC" "$TOOLKIT_DEST"

if [[ -n "$ENV_BACKUP" ]]; then
  cp "$ENV_BACKUP" "$TOOLKIT_DEST/.env"
  rm -f "$ENV_BACKUP"
elif [[ ! -f "$TOOLKIT_DEST/.env" ]]; then
  cp "$TOOLKIT_DEST/.env.example" "$TOOLKIT_DEST/.env"
fi

for link_dest in "${LINK_DESTS[@]}"; do
  create_link "$CANONICAL_SKILL_DEST" "$link_dest"
done

if [[ "$SKIP_NPM" -ne 1 ]]; then
  (
    cd "$TOOLKIT_DEST"
    if [[ -f package-lock.json ]]; then
      npm ci
    else
      npm install
    fi
  )
fi

SMOKE_STATUS="skipped"
if [[ "$SKIP_SMOKE" -ne 1 ]]; then
  if grep -Eq '^STITCH_API_KEY=.+$' "$TOOLKIT_DEST/.env"; then
    (
      cd "$TOOLKIT_DEST"
      npm run list
    )
    SMOKE_STATUS="passed"
  else
    SMOKE_STATUS="not-run-missing-key"
  fi
fi

cat <<EOF
Installed stitch local setup.

Target: $TARGET
Canonical skill: $CANONICAL_SKILL_DEST
Toolkit: $TOOLKIT_DEST
Node: $(node -v)
NPM: $(npm -v)
Smoke test: $SMOKE_STATUS

Compatibility links:
$(if [[ "${#LINK_DESTS[@]}" -eq 0 ]]; then
    echo "  (none)"
  else
    for link_dest in "${LINK_DESTS[@]}"; do
      echo "  $link_dest -> $CANONICAL_SKILL_DEST"
    done
  fi)

Next steps:
1. Add STITCH_API_KEY to $TOOLKIT_DEST/.env if it is empty.
2. Restart your agent client so it picks up the installed skill.
3. Use the toolkit from:
   cd "$TOOLKIT_DEST"
EOF
