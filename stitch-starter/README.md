# Stitch Starter

Minimal local starter for the official `@google/stitch-sdk`.

If your agent client exposes native Stitch MCP tools, prefer those tools for generation and variants. Use this local starter as the portable fallback path and artifact downloader.

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

## Codex MCP setup

Codex can call Stitch directly when the MCP server is configured. Add the server to `~/.codex/config.toml` and restart Codex:

```toml
[mcp_servers.stitch]
url = "https://stitch.googleapis.com/mcp"
enabled = true

[mcp_servers.stitch.http_headers]
"X-Goog-Api-Key" = "<your Stitch API key>"
```

After restart, Codex should expose Stitch tools such as `create_project`, `generate_screen_from_text`, `generate_variants`, and `get_screen`.

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
