---
name: stitch-design-local
description: Generate and refine local Stitch UI screens with the official @google/stitch-sdk. Use when the user wants desktop or mobile UI exploration, design variants, HTML exports, screenshot exports, or iterative screen edits from a brief, mockup, or product context.
compatibility: Requires Node.js 22+, a configured STITCH_API_KEY, and the local stitch-starter toolkit installed by this repository.
metadata: {"homepage":"https://github.com/yshishenya/codex-stitch-local","category":"design","platforms":"codex,claude-code,openclaw","install":"bash install.sh --target all","toolkit_root":"${STITCH_STARTER_ROOT:-$HOME/.agents/stitch-starter}"}
---

# Stitch Design Local

Use this skill when the user wants to create or iterate UI through Stitch.

It uses the local toolkit at `${STITCH_STARTER_ROOT:-$HOME/.agents/stitch-starter}` instead of a Stitch MCP tool.

## Local setup

- Toolkit root: `${STITCH_STARTER_ROOT:-$HOME/.agents/stitch-starter}`
- API key is expected in `${STITCH_STARTER_ROOT:-$HOME/.agents/stitch-starter}/.env`
- Outputs are saved to `${STITCH_STARTER_ROOT:-$HOME/.agents/stitch-starter}/runs`
- The latest single-screen result is tracked in `${STITCH_STARTER_ROOT:-$HOME/.agents/stitch-starter}/runs/latest-screen.json`

## When to use

- The user says to use Stitch
- The user wants a screen generated from a brief, spec, or rough idea
- The user wants design variants before implementation
- The user wants targeted visual edits to a generated screen
- The user wants HTML and screenshots exported locally for review

## Workflow routing

- New screen from a prompt or brief:
  Read [text-to-design](workflows/text-to-design.md)
- Targeted changes to an existing Stitch screen:
  Read [edit-design](workflows/edit-design.md)
- Multiple directions from one base screen:
  Read [variants](workflows/variants.md)

## Core rules

1. Before any Stitch command, rewrite the user request into a stronger design prompt.
2. If the user already has a codebase or UI context, inspect it first and carry that context into the prompt.
3. Prefer `DESKTOP` by default unless the user clearly asks for mobile or tablet.
4. For first-pass exploration, prefer one generated screen plus `3` variants.
5. If a screen is already close, prefer `edit` over full regeneration.
6. Always tell the user where the resulting files were saved.
7. Never print or expose `STITCH_API_KEY` or `.env` contents.

## Prompt shaping

Use [prompt-keywords](references/prompt-keywords.md) to translate vague requests into design language Stitch understands better.

Structure prompts like this:

```md
[overall vibe, product intent, and audience]

Platform: [web/mobile], [desktop/mobile]-first

Page goal:
- what the screen is for
- what primary action matters most

Page structure:
1. Header / navigation
2. Main content / hero / dashboard body
3. Secondary content
4. Footer / actions / supporting detail

Visual direction:
- palette roles
- typography tone
- spacing density
- component style
```

## After running Stitch

Report:

- the command used at a high level, not the secret env
- the project and screen ids
- the output folder under `${STITCH_STARTER_ROOT:-$HOME/.agents/stitch-starter}/runs`
- the HTML and image artifact paths if they were downloaded
- a short design assessment and the best next step

## References

- [cli-usage](references/cli-usage.md)
- [prompt-keywords](references/prompt-keywords.md)
