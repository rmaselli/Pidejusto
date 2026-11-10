import {
  alerta,
  calcMinMax,
  nextEstadoAfterApprove,
  rutaDe,
  sugerida,
  type MatrizRegla,
  type Params,
} from "./index.js";

const params: Params = {
  Z: 1.65,
  meses: 3,
  ltStd: 15,
  ajuste: 0,
  margen: 0,
  periodo: "T4-2026",
  dias: 91,
};

const matriz: MatrizRegla[] = [
  {
    regla: "R1",
    desde: 0,
    hasta: 999999999,
    dentro: "SI",
    niveles: "AUTO",
    desc: "auto",
  },
  {
    regla: "R2",
    desde: 0,
    hasta: 10000,
    dentro: "NO",
    niveles: "N1",
    desc: "n1",
  },
  {
    regla: "R3",
    desde: 10000.01,
    hasta: 999999999,
    dentro: "NO",
    niveles: "N1+N2",
    desc: "n2",
  },
];

const mm = calcMinMax([10, 20, 15, 25], 15, 50, params);
console.assert(mm.clase === "Regular", "clase regular");
console.assert(sugerida(mm.max - 5, mm.min, mm.max) >= 0, "sugerida >= 0");

const al = alerta(mm.max - 1, 1000, mm);
console.assert(al.tipo === "Sobre máximo", "sobre max");

console.assert(rutaDe(matriz, 100, true).niveles === "AUTO", "R1 auto");
console.assert(rutaDe(matriz, 5000, false).regla === "R2", "R2");
console.assert(rutaDe(matriz, 12021, false).regla === "R3", "R3");
console.assert(
  nextEstadoAfterApprove("Pendiente N1", "N1+N2+N3") === "Pendiente N2",
  "n1 a n2",
);
console.assert(
  nextEstadoAfterApprove("Pendiente N2", "N1+N2+N3") === "Pendiente N3",
  "n2 a n3",
);
console.assert(
  nextEstadoAfterApprove("Pendiente N3", "N1+N2+N3") === "Aprobada",
  "n3 a aprobada",
);
console.assert(nextEstadoAfterApprove("Pendiente N1", "N1") === "Aprobada", "solo n1");

console.log("rules.test.ts OK");
