import type { NextConfig } from "next";

const nextConfig: NextConfig = {
  output: "standalone",
  transpilePackages: ["@pidejusto/shared"],
};

export default nextConfig;
