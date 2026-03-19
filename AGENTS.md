# StitchFlow

Cross-agent Stitch skill bundle for Codex, Claude Code, OpenClaw, GitHub Copilot, and Gemini CLI.

Repository:

- https://github.com/yshishenya/stitchflow

## What this skill is for

Use `stitchflow` when the task is:

- design generation from a brief or mockup
- UI prototyping from product context
- prompt-to-HTML workflows
- screen edits and visual iteration
- design variants before implementation
- local screenshots and Tailwind-friendly HTML exports

## Install

```bash
git clone https://github.com/yshishenya/stitchflow.git
cd stitchflow
bash install.sh --target all
```

Canonical install layout:

- skill: `~/.agents/skills/stitchflow`
- toolkit: `~/.agents/stitch-starter`

Native compatibility links:

- Codex: `~/.codex/skills/stitchflow`
- Claude Code: `~/.claude/skills/stitchflow`
- OpenClaw: `~/.openclaw/skills/stitchflow`
- GitHub Copilot: `~/.copilot/skills/stitchflow`
- legacy alias still installed: `stitch-design-local`

Native extension / plugin packaging:

- GitHub Copilot plugin manifest: `.github/plugin/plugin.json`
- Gemini CLI extension manifest: `gemini-extension.json`

## How to use

- explicit invocation: `Use $stitchflow ...`
- common jobs: generate a new screen, edit an existing screen, create variants, export local artifacts
- toolkit root: `${STITCH_STARTER_ROOT:-$HOME/.agents/stitch-starter}`
- brand: `StitchFlow`
- legacy alias: `stitch-design-local`

## Skill

- name: `stitchflow`
- location: `skills/stitchflow`
- install command: `bash install.sh --target all`

## Metadata files

- root discovery: [README.md](./README.md)
- agent bundle: [skills/stitchflow/SKILL.md](./skills/stitchflow/SKILL.md)
- Codex metadata: [skills/stitchflow/agents/openai.yaml](./skills/stitchflow/agents/openai.yaml)
- Claude metadata: [.claude-plugin/plugin.json](./.claude-plugin/plugin.json)
- GitHub Copilot metadata: [.github/plugin/plugin.json](./.github/plugin/plugin.json)
- Gemini CLI metadata: [gemini-extension.json](./gemini-extension.json)
