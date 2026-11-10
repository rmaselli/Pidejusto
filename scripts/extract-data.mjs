import fs from "fs";
import path from "path";

const html = fs.readFileSync("PideJusto_Equipo1.html", "utf8");
const marker = "window.__PJ_DATA__=";
const i = html.indexOf(marker);
if (i < 0) throw new Error("marker not found");
const start = i + marker.length;

let depth = 0;
let inStr = false;
let esc = false;
let end = -1;
for (let p = start; p < html.length; p++) {
  const c = html[p];
  if (inStr) {
    if (esc) {
      esc = false;
      continue;
    }
    if (c === "\\") {
      esc = true;
      continue;
    }
    if (c === '"') {
      inStr = false;
      continue;
    }
    continue;
  }
  if (c === '"') {
    inStr = true;
    continue;
  }
  if (c === "{") depth++;
  else if (c === "}") {
    depth--;
    if (depth === 0) {
      end = p + 1;
      break;
    }
  }
}

const raw = html.slice(start, end);
const data = JSON.parse(raw);
const outDir = path.join("packages", "db", "seed");
fs.mkdirSync(outDir, { recursive: true });
fs.writeFileSync(path.join(outDir, "pj-data.json"), JSON.stringify(data));
console.log("OK", Object.keys(data).join(","));
console.log({
  art: data.art.length,
  usr: data.usr.length,
  emp: data.emp.length,
  exi: data.exi.length,
  con: data.con.length,
  mcx: data.mcx.length,
  cta: data.cta.length,
  mat: data.mat.length,
  catcta: data.catcta.length,
  eje: data.eje.length,
});
console.log("users", data.usr);
