# codex-stitch-local

Portable repository for a local Codex Stitch setup:

- `skills/stitch-design-local`: the Codex skill
- `stitch-starter`: the local toolkit built on `@google/stitch-sdk`
- `install.sh`: installs both into `${CODEX_HOME:-$HOME/.codex}`

## What This Solves

The original local setup depended on machine-specific paths. This repository makes the setup reproducible on another server without hardcoded home directories.

## Install

Clone the repository anywhere, then run:

```bash
bash install.sh
```

The installer will:

1. Copy the skill to `${CODEX_HOME:-$HOME/.codex}/skills/stitch-design-local`
2. Copy the toolkit to `${CODEX_HOME:-$HOME/.codex}/stitch-starter`
3. Create `.env` from `.env.example` if needed
4. Run `npm install`
5. Run `npm run list` if `STITCH_API_KEY` is configured

## Installer Options

```bash
bash install.sh --force
bash install.sh --skip-smoke
bash install.sh --skip-npm
```

## Manual Usage

```bash
cd "${CODEX_HOME:-$HOME/.codex}/stitch-starter"
npm run list
npm run generate -- --prompt "A modern SaaS dashboard with sidebar and stat cards"
npm run edit -- --prompt "Make it more premium and add stronger typography"
npm run variants -- --prompt "Explore three different visual directions" --variant-count 3
```

## Publishing

This repository is safe to publish as long as `.env` is not committed. The included `.gitignore` files exclude local secrets, `node_modules`, and generated runs.
