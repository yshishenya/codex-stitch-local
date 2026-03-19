import path from "node:path";
import {
  createRunDir,
  ensureApiKey,
  normalizeDeviceType,
  parseArgs,
  resolveTarget,
  saveArtifacts,
  saveLatestScreen,
  writeJson
} from "./_common.mjs";

ensureApiKey();

const args = parseArgs(process.argv.slice(2));
const prompt = args.prompt;

if (!prompt) {
  console.error('Usage: npm run edit -- --prompt "Make it darker and more premium" [--project-id 123 --screen-id 456] [--device DESKTOP]');
  process.exit(1);
}

const deviceType = normalizeDeviceType(args.device, "DESKTOP");
const { project, screen } = await resolveTarget(args);

console.log(`Project: ${project.id}`);
console.log(`Editing screen: ${screen.id}`);

const edited = await screen.edit(prompt, deviceType);
const htmlUrl = await edited.getHtml();
const imageUrl = await edited.getImage();

const outDir = await createRunDir("edit", prompt);
const metadata = {
  operation: "edit",
  createdAt: new Date().toISOString(),
  projectId: project.id,
  baseScreenId: screen.id,
  screenId: edited.id,
  prompt,
  deviceType,
  htmlUrl,
  imageUrl,
  outDir
};

await writeJson(path.join(outDir, "result.json"), metadata);
await saveArtifacts({ outDir, htmlUrl, imageUrl });
await saveLatestScreen(metadata);

console.log(`Edited screen: ${edited.id}`);
console.log(`Saved to: ${outDir}`);
console.log(`HTML URL: ${htmlUrl || "n/a"}`);
console.log(`Image URL: ${imageUrl || "n/a"}`);
