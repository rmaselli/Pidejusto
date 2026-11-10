import express from "express";
import cors from "cors";
import helmet from "helmet";
import morgan from "morgan";
import cookieParser from "cookie-parser";
import session from "express-session";
import type { Db } from "@pidejusto/db";
import { config } from "./config.js";
import { authRoutes } from "./auth/routes.js";
import { apiRoutes } from "./routes/index.js";
import type { SapProvider } from "./sap/index.js";
import { SapUpstreamUnavailable } from "./sap/index.js";

export function createApp(db: Db, sap: SapProvider) {
  const app = express();
  app.set("trust proxy", 1);
  app.use(helmet({ contentSecurityPolicy: false }));
  app.use(
    cors({
      origin: config.webUrl,
      credentials: true,
    }),
  );
  app.use(morgan(config.nodeEnv === "production" ? "combined" : "dev"));
  app.use(express.json({ limit: "2mb" }));
  app.use(cookieParser());
  app.use(
    session({
      name: "pj.sid",
      secret: config.sessionSecret,
      resave: false,
      saveUninitialized: false,
      cookie: {
        httpOnly: true,
        sameSite: "lax",
        secure: config.nodeEnv === "production",
        maxAge: 1000 * 60 * 60 * 12,
      },
    }),
  );

  app.use("/auth", authRoutes(db));
  app.use("/api", apiRoutes(db, sap));

  app.use(
    (
      err: Error & { status?: number },
      _req: express.Request,
      res: express.Response,
      _next: express.NextFunction,
    ) => {
      if (err instanceof SapUpstreamUnavailable) {
        return res.status(503).json({ error: err.message, code: err.name });
      }
      const status = err.status || 500;
      console.error(err);
      res.status(status).json({ error: err.message || "Error interno" });
    },
  );

  return app;
}
