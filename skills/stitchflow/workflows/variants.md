---
description: Generate multiple visual directions from a base Stitch screen using the local starter toolkit.
---

# Workflow: Variants

## Steps

1. Identify the base screen.
- Prefer the latest generated screen unless the user specifies another one.

2. Turn the user's request into a variants prompt that clearly defines what should vary:
- layout
- color scheme
- imagery
- text tone
- typography

3. If native Stitch MCP tools are available in the current session, prefer `generate_variants`:
   - pass `projectId`, `selectedScreenIds`, prompt, device type, and variant options;
   - if the tool schema says `variantOptions` is a string but the first call fails with `invalid argument`, retry once with the same value as a JSON object;
   - save each returned variant into `runs/<timestamp>-variants-<slug>/variant-N/` with `result.json`, `html-url.txt`, `image-url.txt`, downloaded `screen.html`, and downloaded `screen.<image-ext>`;
   - write a parent `variants.json` file and update `runs/latest-screen.json` to the first returned variant.

4. If native Stitch MCP tools are not available, run:

```bash
cd "${STITCH_STARTER_ROOT:-$HOME/.agents/stitch-starter}"
npm run variants -- --prompt "..." --variant-count 3
```

Optional:

```bash
--creative-range REFINE|EXPLORE|REIMAGINE
--aspects LAYOUT,COLOR_SCHEME,IMAGES,TEXT_FONT,TEXT_CONTENT
```

5. Review the saved variant folders and summarize:
- what changed in each direction
- which variant is strongest
- which one should be edited next

## Default behavior

- Default variant count: `3`
- Default creative range: `EXPLORE`
- If the user explicitly wants only small polish differences, use `REFINE`
