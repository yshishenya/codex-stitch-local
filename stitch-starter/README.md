# Stitch Starter

Minimal local starter for the official `@google/stitch-sdk`.

## Setup

```bash
cd "${STITCH_STARTER_ROOT:-$HOME/.agents/stitch-starter}"
cp .env.example .env
# add STITCH_API_KEY to .env
npm install
```

## Commands

Generate a new screen:

```bash
npm run generate -- --prompt "A modern SaaS dashboard with sidebar and stat cards"
```

Generate into an existing project:

```bash
npm run generate -- --project-id 123456789 --prompt "Pricing page with 3 plans"
```

Edit the latest generated screen:

```bash
npm run edit -- --prompt "Make it more premium and add stronger typography"
```

Generate variants from the latest screen:

```bash
npm run variants -- --prompt "Explore three different visual directions" --variant-count 3
```

List available projects and screens:

```bash
npm run list
```

## Output

Each run is saved under `runs/<timestamp>-<operation>/` with:

- `result.json` or `variants.json`
- `screen.html` / `screen.<image-ext>` when available
- `html-url.txt`
- `image-url.txt`

The latest single-screen result is also written to:

```bash
runs/latest-screen.json
```
