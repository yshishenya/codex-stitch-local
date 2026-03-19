# codex-stitch-local

> Cross-agent Stitch skill bundle for Codex, Claude Code, and OpenClaw.
> Canonical repository: https://github.com/yshishenya/codex-stitch-local

This repository contains a reusable skill and local toolkit for generating and iterating UI screens with the official `@google/stitch-sdk`.

Core value:

- turn natural-language briefs into UI screens
- iterate with edits and variants
- save clean HTML and screenshots locally
- reuse the same workflow across Codex, Claude Code, and OpenClaw

## Installation

Canonical install:

```bash
git clone https://github.com/yshishenya/codex-stitch-local.git
cd codex-stitch-local
bash install.sh --target all
```

Targeted installs:

```bash
bash install.sh --target codex
bash install.sh --target claude
bash install.sh --target openclaw
bash install.sh --target universal
```

## How to use

- Use the skill when the task is UI generation, UI exploration, design variants, or iterative visual refinement.
- Prefer explicit invocation if your client supports it.
- Rewrite vague UI requests into structured design prompts before running Stitch.
- Use the toolkit under `${STITCH_STARTER_ROOT:-$HOME/.agents/stitch-starter}`.

## Available skills

<available_skills>

<skill>
<name>stitch-design-local</name>
<description>Generate and refine local Stitch UI screens with the official @google/stitch-sdk. Use when the user wants desktop or mobile UI exploration, design variants, HTML exports, screenshot exports, or iterative screen edits from a brief, mockup, or product context.</description>
<location>skills/stitch-design-local</location>
<install>bash install.sh --target all</install>
</skill>

</available_skills>

## Native platform notes

- Codex: installs a compatibility link into `~/.codex/skills/stitch-design-local`
- Claude Code: installs a compatibility link into `~/.claude/skills/stitch-design-local`
- OpenClaw: installs a compatibility link into `~/.openclaw/skills/stitch-design-local`
- Universal canonical skill path: `~/.agents/skills/stitch-design-local`
