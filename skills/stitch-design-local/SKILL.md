---
name: stitch-design-local
description: Use the local Stitch starter toolkit to turn briefs into generated screens, targeted edits, and variants with the official @google/stitch-sdk. Use when the user wants design generation via Stitch, HTML/screenshots saved locally, or iterative UI exploration from a brief or existing project context.
---

# Stitch Design Local

Use this skill when the user wants to design or iterate UI through Stitch.

This skill is adapted from the official Stitch workflow patterns, but it uses the local toolkit at `${CODEX_HOME:-$HOME/.codex}/stitch-starter` instead of a Stitch MCP tool.

## Local setup

- Toolkit root: `${CODEX_HOME:-$HOME/.codex}/stitch-starter`
- API key is expected in `${CODEX_HOME:-$HOME/.codex}/stitch-starter/.env`
- Outputs are saved to `${CODEX_HOME:-$HOME/.codex}/stitch-starter/runs`
- The latest single-screen result is tracked in `${CODEX_HOME:-$HOME/.codex}/stitch-starter/runs/latest-screen.json`

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

## Output expectations

After running Stitch, report:

- the command used at a high level, not the secret env
- the project and screen ids
- the output folder under `${CODEX_HOME:-$HOME/.codex}/stitch-starter/runs`
- the HTML and image artifact paths if they were downloaded
- a brief design assessment and the best next step

## References

- [cli-usage](references/cli-usage.md)
- [prompt-keywords](references/prompt-keywords.md)
