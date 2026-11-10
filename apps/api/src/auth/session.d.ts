import type { UserInfo } from "@pidejusto/shared";

declare module "express-session" {
  interface SessionData {
    user?: UserInfo;
    oauthState?: string;
  }
}
