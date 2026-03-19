#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'EOF'
Usage: bash install.sh [--force] [--skip-npm] [--skip-smoke]

Options:
  --force       Overwrite existing installed skill/toolkit
  --skip-npm    Skip npm install in the toolkit
  --skip-smoke  Skip npm run list smoke test even if STITCH_API_KEY is set
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

FORCE=0
SKIP_NPM=0
SKIP_SMOKE=0
ENV_BACKUP=""

while [[ $# -gt 0 ]]; do
  case "$1" in
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

require_cmd node
require_cmd npm

NODE_MAJOR="$(node -p 'process.versions.node.split(".")[0]')"
if [[ "$NODE_MAJOR" -lt 22 ]]; then
  echo "Node.js 22+ is required. Current version: $(node -v)" >&2
  exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$SCRIPT_DIR"
CODEX_HOME="${CODEX_HOME:-$HOME/.codex}"

SKILL_SRC="$REPO_ROOT/skills/stitch-design-local"
TOOLKIT_SRC="$REPO_ROOT/stitch-starter"
SKILL_DEST="$CODEX_HOME/skills/stitch-design-local"
TOOLKIT_DEST="$CODEX_HOME/stitch-starter"

if [[ ! -d "$SKILL_SRC" || ! -d "$TOOLKIT_SRC" ]]; then
  echo "Repository layout is invalid. Missing skill or toolkit source directory." >&2
  exit 1
fi

mkdir -p "$CODEX_HOME/skills"

if [[ -e "$SKILL_DEST" || -e "$TOOLKIT_DEST" ]]; then
  if [[ "$FORCE" -ne 1 ]]; then
    echo "Destination already exists." >&2
    echo "Use --force to overwrite:" >&2
    echo "  $SKILL_DEST" >&2
    echo "  $TOOLKIT_DEST" >&2
    exit 1
  fi
  if [[ -f "$TOOLKIT_DEST/.env" ]]; then
    ENV_BACKUP="$(mktemp)"
    cp "$TOOLKIT_DEST/.env" "$ENV_BACKUP"
  fi
  rm -rf "$SKILL_DEST" "$TOOLKIT_DEST"
fi

copy_dir "$SKILL_SRC" "$SKILL_DEST"
copy_dir "$TOOLKIT_SRC" "$TOOLKIT_DEST"

if [[ -n "$ENV_BACKUP" ]]; then
  cp "$ENV_BACKUP" "$TOOLKIT_DEST/.env"
  rm -f "$ENV_BACKUP"
elif [[ ! -f "$TOOLKIT_DEST/.env" ]]; then
  cp "$TOOLKIT_DEST/.env.example" "$TOOLKIT_DEST/.env"
fi

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

CODEX_HOME: $CODEX_HOME
Skill: $SKILL_DEST
Toolkit: $TOOLKIT_DEST
Node: $(node -v)
NPM: $(npm -v)
Smoke test: $SMOKE_STATUS

Next steps:
1. Add STITCH_API_KEY to $TOOLKIT_DEST/.env if it is empty.
2. Restart Codex to pick up the new skill.
3. Use the toolkit from:
   cd "$TOOLKIT_DEST"
EOF
