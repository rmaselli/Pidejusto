import type { NextConfig } from "next";

const nextConfig: NextConfig = {
  output: "standalone",
  transpilePackages: ["@pidejusto/shared"],
  // Microsoft (Entra ID) vuelve a WEB_URL/auth/callback; se reenvía a la API,
  // que crea la sesión y redirige a la página principal.
  async rewrites() {
    const api = process.env.API_INTERNAL_URL || process.env.NEXT_PUBLIC_API_URL || "http://localhost:4000";
    return [{ source: "/auth/callback", destination: `${api}/auth/callback` }];
  },
};

export default nextConfig;
