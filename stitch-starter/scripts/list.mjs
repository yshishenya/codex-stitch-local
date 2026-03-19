import { stitch } from "@google/stitch-sdk";
import { ensureApiKey } from "./_common.mjs";

ensureApiKey();

const projects = await stitch.projects();

if (projects.length === 0) {
  console.log("No Stitch projects found.");
  process.exit(0);
}

for (const project of projects) {
  console.log(`Project ${project.id}`);
  const screens = await project.screens();
  if (screens.length === 0) {
    console.log("  (no screens)");
    continue;
  }
  for (const screen of screens) {
    console.log(`  Screen ${screen.id}`);
  }
}
