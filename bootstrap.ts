#!/usr/bin/env npx ts-node
// Bootstrap verification script.
// Compiles watnot, runs it on its own source, and verifies
// that source comments appear in the annotated WAT output.

import { execSync } from "node:child_process";
import { readFileSync, writeFileSync } from "node:fs";
import { join } from "node:path";

const WASM2WAT: string = join(
  process.env.HOME!,
  "Personal/wabt/build/wasm2wat",
);
const WASMTIME: string = join(process.env.HOME!, ".wasmtime/bin/wasmtime");

const SOURCE_FILES: string[] = [
  "src/index.ts",
  "src/comments.ts",
  "src/sourcemap.ts",
  "src/offsetmap.ts",
  "src/injector.ts",
];

function run(cmd: string): void {
  console.log(`$ ${cmd}`);
  execSync(cmd, { stdio: "inherit" });
}

function runCapture(cmd: string): string {
  console.log(`$ ${cmd}`);
  return execSync(cmd, { encoding: "utf8" });
}

// Extract comment bodies from source text, matching
// how injector.ts converts them to WAT comments.
function extractCommentBodies(source: string): string[] {
  const bodies: string[] = [];
  let i = 0;
  const len = source.length;

  while (i < len) {
    const ch = source[i];

    // Skip string literals
    if (ch === '"' || ch === "'" || ch === "`") {
      i++;
      while (i < len && source[i] !== ch) {
        if (source[i] === "\\") i++;
        i++;
      }
      i++; // skip closing quote
      continue;
    }

    if (ch === "/" && i + 1 < len) {
      if (source[i + 1] === "/") {
        // Single-line comment: // ...
        i += 2;
        const start = i;
        while (i < len && source[i] !== "\n") i++;
        // body is the text after //, becomes ";;<body>"
        bodies.push(";;" + source.slice(start, i));
        continue;
      }
      if (source[i + 1] === "*") {
        // Multi-line comment: /* ... */
        i += 2;
        const start = i;
        while (i + 1 < len) {
          if (source[i] === "*" && source[i + 1] === "/") {
            break;
          }
          i++;
        }
        // body is inner text trimmed, becomes ";; <inner>"
        const inner = source.slice(start, i).trim();
        bodies.push(";; " + inner);
        i += 2; // skip */
        continue;
      }
    }

    i++;
  }

  return bodies;
}

// --- Step 1: Build ---
console.log("\n=== Step 1: Build watnot ===\n");
run("npm run build");

// --- Step 2: Disassemble ---
console.log("\n=== Step 2: Disassemble with offset map ===\n");
run(
  `${WASM2WAT} build/watnot.wasm --fold-exprs` +
    ` --output build/watnot.wat` +
    ` --offset-map build/watnot.offsets.json`,
);

// --- Step 3: Run watnot on its own source ---
console.log("\n=== Step 3: Run watnot (bootstrap) ===\n");
const sourceArgs: string = SOURCE_FILES.join(" ");
const annotated: string = runCapture(
  `${WASMTIME} --dir . build/watnot.wasm` +
    ` build/watnot.wasm.map build/watnot.wat build/watnot.offsets.json` +
    ` ${sourceArgs}`,
);

writeFileSync("build/watnot-annotated.wat", annotated);

// --- Step 4: Verify comments ---
console.log("\n=== Step 4: Verify comments ===\n");

let totalComments = 0;
let foundComments = 0;
const missing: { file: string; body: string }[] = [];

for (const file of SOURCE_FILES) {
  const source: string = readFileSync(file, "utf8");
  const bodies: string[] = extractCommentBodies(source);

  for (const body of bodies) {
    totalComments++;
    if (annotated.includes(body)) {
      foundComments++;
    } else {
      missing.push({ file, body });
    }
  }
}

console.log(`Total source comments: ${totalComments}`);
console.log(`Found in annotated WAT: ${foundComments}`);
console.log(`Missing: ${missing.length}`);

if (missing.length > 0) {
  console.log("\nMissing comments:");
  for (const { file, body } of missing) {
    console.log(`  ${file}: ${body}`);
  }
}

if (missing.length === 0) {
  console.log("\nBootstrap verification PASSED");
} else {
  console.log(
    `\nBootstrap verification: ${foundComments}/${totalComments} comments found`,
  );
  process.exit(1);
}
