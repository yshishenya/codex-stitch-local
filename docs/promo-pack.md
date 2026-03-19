# StitchFlow Promo Pack

Use this file when posting StitchFlow to catalogs, social feeds, communities, and issue templates.

## Core positioning

- Product name: `StitchFlow`
- Canonical repo: `https://github.com/yshishenya/stitchflow`
- Canonical skill slug: `stitchflow`
- Legacy alias: `stitch-design-local`

## One-liners

- `StitchFlow turns product briefs and mockups into Stitch UI screens, design variants, Tailwind-friendly HTML, and screenshots.`
- `Cross-agent Stitch design workflow for Codex, Claude Code, OpenClaw, GitHub Copilot, and Gemini CLI.`
- `Turn a plain-language UI brief into a screen, three variants, and local HTML artifacts in one installable skill.`

## Short descriptions

- `StitchFlow wraps the Google Stitch SDK into a reusable local skill for agent clients. It converts briefs, mockups, and existing product context into generated screens, targeted edits, visual variants, Tailwind-friendly HTML, and screenshots.`
- `Install one skill, then use natural language to generate or refine UI screens through Stitch across Codex, Claude Code, OpenClaw, GitHub Copilot, and Gemini CLI.`

## Submission blurb

`StitchFlow is a cross-agent SKILL.md bundle for UI generation and iteration. It turns briefs, mockups, and product context into Stitch screens, variants, Tailwind-friendly HTML, and screenshots, with native install flows for Codex, Claude Code, OpenClaw, GitHub Copilot, and Gemini CLI.`

## Install blocks

### Universal install

```bash
git clone https://github.com/yshishenya/stitchflow.git
cd stitchflow
bash install.sh --target all
```

### Codex

```bash
git clone https://github.com/yshishenya/stitchflow.git
cd stitchflow
bash install.sh --target codex
```

### Claude Code

```bash
git clone https://github.com/yshishenya/stitchflow.git
cd stitchflow
bash install.sh --target claude
```

### OpenClaw

```bash
clawhub install stitchflow
```

### GitHub Copilot

```bash
copilot plugin install yshishenya/stitchflow
```

### Gemini CLI

```bash
gemini extensions install https://github.com/yshishenya/stitchflow
```

## Demo prompts

### Prompt 1

`Use $stitchflow to create a desktop SaaS analytics dashboard for a B2B revenue team. Emphasize weekly pipeline, forecast health, rep activity, and next-best actions. Generate one screen and 3 variants.`

### Prompt 2

`Use $stitchflow to redesign our pricing page into a sharper enterprise layout with clearer plan comparison, stronger trust signals, and a better annual billing call to action.`

### Prompt 3

`Use $stitchflow to take this brief for a fintech onboarding flow and turn it into a polished desktop screen plus local Tailwind-friendly HTML and a screenshot.`

## Demo flow

1. Start with a plain-language product brief.
2. Invoke `stitchflow`.
3. Generate one screen plus variants.
4. Show the saved HTML and screenshot artifacts.
5. Link the repo and install command.

## Good proof points

- Works across multiple agent ecosystems instead of one vendor silo.
- Produces both visual exploration and implementation-friendly HTML artifacts.
- Supports generate, edit, and variants workflows.
- Ships as a real installable skill bundle, not just a prompt snippet.

## X post

`StitchFlow turns a product brief into a Stitch UI screen, variants, Tailwind-friendly HTML, and screenshots.\n\nOne skill, multiple runtimes: Codex, Claude Code, OpenClaw, Copilot, Gemini CLI.\n\nRepo: https://github.com/yshishenya/stitchflow`

## Reddit / forum post

`Built a cross-agent Stitch skill called StitchFlow. It wraps the Google Stitch SDK into an installable local workflow that turns briefs and mockups into generated screens, variants, Tailwind-friendly HTML, and screenshots. It works across Codex, Claude Code, OpenClaw, Copilot, and Gemini CLI. Repo: https://github.com/yshishenya/stitchflow`

## Catalog note

`If your catalog supports external GitHub skills, please list StitchFlow under design / UI / frontend workflow. The canonical source is https://github.com/yshishenya/stitchflow and the canonical skill slug is stitchflow.`
