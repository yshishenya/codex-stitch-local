# StitchFlow for Gemini CLI

Use this extension when the user wants to turn a product brief, mockup, or UI idea into a generated screen, a refined screen edit, or a set of visual variants with local HTML and screenshots.

The repository ships a canonical agent skill at `skills/stitchflow/`, keeps `skills/stitch-design-local/` as a legacy alias, and includes a local toolkit at `stitch-starter/`.

## When to use StitchFlow

- The user wants UI exploration before implementation
- The user wants prompt-to-HTML output
- The user wants multiple visual directions for the same screen
- The user wants local screenshots and artifacts saved on disk

## Local setup

1. Clone the repository.
2. Run `bash install.sh --target all` for the canonical local install.
3. Add `STITCH_API_KEY` to `${STITCH_STARTER_ROOT:-$HOME/.agents/stitch-starter}/.env`.
4. Restart Gemini CLI if needed.

## Working rules

1. Rewrite vague UI requests into a stronger design prompt before running Stitch.
2. Prefer desktop web unless the user clearly asks for mobile or tablet.
3. For first-pass exploration, prefer one generated screen and then three variants.
4. If the user already has a close screen, prefer targeted edits over regeneration.
5. Always report where HTML, screenshots, and run metadata were saved.
6. Never print or expose `STITCH_API_KEY` or `.env` contents.

## Toolkit commands

Run commands inside `${STITCH_STARTER_ROOT:-$HOME/.agents/stitch-starter}`.

Generate a new screen:

```bash
npm run generate -- --prompt "A premium desktop analytics dashboard for a product team"
```

Edit the latest screen:

```bash
npm run edit -- --prompt "Make it more premium and improve typography hierarchy"
```

Create variants:

```bash
npm run variants -- --prompt "Explore three stronger visual directions" --variant-count 3
```

List projects and screens:

```bash
npm run list
```

## Output paths

- Runs are saved under `${STITCH_STARTER_ROOT:-$HOME/.agents/stitch-starter}/runs/`
- Latest single-screen pointer: `${STITCH_STARTER_ROOT:-$HOME/.agents/stitch-starter}/runs/latest-screen.json`

For deeper workflow detail, reuse the canonical instructions in `skills/stitchflow/SKILL.md`.
