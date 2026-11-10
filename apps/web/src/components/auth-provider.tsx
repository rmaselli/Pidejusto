"use client";

import {
  createContext,
  useCallback,
  useContext,
  useEffect,
  useState,
} from "react";
import { api, type User } from "@/lib/api";

type AuthCtx = {
  user: User | null;
  loading: boolean;
  authMode: string;
  refresh: () => Promise<void>;
  logout: () => Promise<void>;
};

const Ctx = createContext<AuthCtx | null>(null);

export function AuthProvider({ children }: { children: React.ReactNode }) {
  const [user, setUser] = useState<User | null>(null);
  const [loading, setLoading] = useState(true);
  const [authMode, setAuthMode] = useState("demo");

  const refresh = useCallback(async () => {
    try {
      const me = await api.me();
      setUser(me.user);
      if (me.authMode) setAuthMode(me.authMode);
    } catch {
      setUser(null);
    } finally {
      setLoading(false);
    }
  }, []);

  useEffect(() => {
    void refresh();
  }, [refresh]);

  const logout = async () => {
    await api.logout();
    setUser(null);
  };

  return (
    <Ctx.Provider value={{ user, loading, authMode, refresh, logout }}>
      {children}
    </Ctx.Provider>
  );
}

export function useAuth() {
  const ctx = useContext(Ctx);
  if (!ctx) throw new Error("useAuth outside provider");
  return ctx;
}
