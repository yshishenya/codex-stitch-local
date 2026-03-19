# Catalog Submissions

This file turns distribution into an execution checklist instead of a vague launch idea.

## Goal

Maximize discoverability for `StitchFlow` across:

- official registries
- official plugin and extension install flows
- community discovery catalogs
- high-signal GitHub collections with existing traffic

## Canonical metadata

Use these values everywhere unless a catalog forces a different format.

- Project name: `StitchFlow`
- Canonical skill slug: `stitchflow`
- Legacy alias slug: `stitch-design-local`
- GitHub Copilot plugin slug: `stitchflow`
- Gemini CLI extension id: `stitchflow`
- Repository: `https://github.com/yshishenya/stitchflow`
- Tagline: `Turn product briefs into UI screens, variants, Tailwind-ready HTML, and screenshots in minutes.`
- One-line value prop: `StitchFlow turns Google Stitch SDK into a reusable local workflow for agent clients.`

## Tier 1: Official distribution channels

### OpenClaw ClawHub

Why it matters:

- official public registry for OpenClaw skills
- has search, stars, comments, version history, and downloads
- closest thing to a native marketplace for this repo today

Submission path:

```bash
clawhub login
clawhub publish ./skills/stitchflow \
  --slug stitchflow \
  --name "StitchFlow" \
  --version 1.3.0 \
  --tags latest,design,ui,stitch
```

Status:

- repo is ready for publishable metadata
- still needs an authenticated publish from a maintainer account

### GitHub Copilot

Why it matters:

- official plugin install flow from a GitHub repository
- natural audience overlap with devtools, AI coding, and prompt-to-code creators
- can later be submitted to GitHub's `awesome-copilot` marketplace collection

Repo assets used:

- `.github/plugin/plugin.json`
- `skills/stitchflow/`

Install path for users:

```bash
copilot plugin install yshishenya/stitchflow
```

Status:

- repository packaging is now ready
- next manual step is a PR into `github/awesome-copilot`

### Gemini CLI

Why it matters:

- official extension install from a GitHub URL
- good fit for design-generation workflows because the install friction is low
- gives a second native distribution entrypoint outside the agent-skills ecosystem

Repo assets used:

- `gemini-extension.json`
- `GEMINI.md`

Install path for users:

```bash
gemini extensions install https://github.com/yshishenya/stitchflow
```

Status:

- repository packaging is now ready
- next step is validation on a machine with Gemini CLI installed

## Tier 2: High-signal community catalogs

### github/awesome-copilot

Why it matters:

- very large existing audience
- plugin collection is already consumable via Copilot CLI marketplace commands
- strong SEO and internal GitHub discovery

Submission angle:

- add StitchFlow under `plugins/` and possibly `skills/`
- lead with `prompt -> screen -> HTML + screenshot`

Status:

- ready for PR after Copilot install flow is smoke-tested

### askill.sh

Why it matters:

- purpose-built skill registry with GitHub-based install references
- good match for agent-skill discovery across tools

Submission angle:

- publish using the GitHub repo as the canonical source
- reference the canonical skill slug `stitchflow`

Status:

- likely ready, but submission path should be verified from the maintainer side before announcement

## Tier 3: Curated lists and outbound channels

- `awesome-llm-skills`
- agent-skills ecosystem lists and examples
- X / Twitter launch thread
- Reddit posts for AI coding and design engineering communities
- Hacker News launch once demo assets are strong enough

These are not native install channels, but they matter for stars.

## Submission assets checklist

- strong repo tagline in the first screenful of the README
- one static hero screenshot
- one 5 to 15 second GIF: prompt -> screen -> HTML
- one copy-paste install command per platform
- one concrete example prompt
- short maintainer bio and repository link

## Star-growth heuristics

- sell the outcome, not the packaging format
- show local HTML and screenshots immediately
- keep the promise narrow: `brief -> UI -> artifacts`
- every catalog description should mention at least two supported clients
- do not lead with interoperability; lead with visible output

## Weekly operating loop

1. Add one fresh example or screenshot.
2. Publish or update one catalog listing.
3. Post one short clip showing prompt to result.
4. Improve one install friction point from user feedback.
5. Track GitHub stars, installs, and inbound issues.
