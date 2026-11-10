import type { UserInfo } from "@pidejusto/shared";

declare global {
  namespace Express {
    interface User extends UserInfo {}
    interface Request {
      user?: UserInfo;
    }
  }
}

export {};
