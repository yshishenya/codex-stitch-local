import path from "node:path";
import { stitch } from "@google/stitch-sdk";
import {
  createRunDir,
  ensureApiKey,
  normalizeDeviceType,
  parseArgs,
  saveArtifacts,
  saveLatestScreen,
  writeJson
} from "./_common.mjs";

ensureApiKey();

const args = parseArgs(process.argv.slice(2));
const prompt = args.prompt;

if (!prompt) {
  console.error('Usage: npm run generate -- --prompt "A modern SaaS dashboard" [--title "My App"] [--project-id 123] [--device DESKTOP]');
  process.exit(1);
}

const deviceType = normalizeDeviceType(args.device, "DESKTOP");
const projectTitle = args.title || "Stitch Starter";

const project = args["project-id"]
  ? stitch.project(args["project-id"])
  : await stitch.createProject(projectTitle);

console.log(`Project: ${project.id}`);
console.log(`Generating screen for ${deviceType}...`);

const screen = await project.generate(prompt, deviceType);
const htmlUrl = await screen.getHtml();
const imageUrl = await screen.getImage();

const outDir = await createRunDir("generate", prompt);
const metadata = {
  operation: "generate",
  createdAt: new Date().toISOString(),
  projectId: project.id,
  projectTitle,
  screenId: screen.id,
  prompt,
  deviceType,
  htmlUrl,
  imageUrl,
  outDir
};

await writeJson(path.join(outDir, "result.json"), metadata);
await saveArtifacts({ outDir, htmlUrl, imageUrl });
await saveLatestScreen(metadata);

console.log(`Screen: ${screen.id}`);
console.log(`Saved to: ${outDir}`);
console.log(`HTML URL: ${htmlUrl || "n/a"}`);
console.log(`Image URL: ${imageUrl || "n/a"}`);
