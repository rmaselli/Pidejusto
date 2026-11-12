FROM node:22-alpine AS deps
WORKDIR /app
COPY package.json package-lock.json ./
COPY packages/shared/package.json ./packages/shared/
COPY packages/db/package.json ./packages/db/
COPY apps/api/package.json ./apps/api/
COPY apps/web/package.json ./apps/web/
# Workspaces hoist deps to /app/node_modules — nested folders may not exist
RUN npm ci

FROM node:22-alpine AS build
WORKDIR /app
COPY --from=deps /app/node_modules ./node_modules
COPY --from=deps /app/package.json ./package.json
COPY --from=deps /app/package-lock.json ./package-lock.json
COPY --from=deps /app/packages/shared/package.json ./packages/shared/package.json
COPY --from=deps /app/packages/db/package.json ./packages/db/package.json
COPY --from=deps /app/apps/api/package.json ./apps/api/package.json
COPY tsconfig.base.json ./
COPY packages/shared ./packages/shared
COPY packages/db ./packages/db
COPY apps/api ./apps/api
RUN npm run build -w @pidejusto/shared \
 && npm run build -w @pidejusto/db \
 && npm run build -w @pidejusto/api

FROM node:22-alpine AS runner
WORKDIR /app
ENV NODE_ENV=production
COPY --from=build /app/package.json ./package.json
COPY --from=build /app/package-lock.json ./package-lock.json
COPY --from=build /app/node_modules ./node_modules
COPY --from=build /app/packages/shared ./packages/shared
COPY --from=build /app/packages/db ./packages/db
COPY --from=build /app/apps/api ./apps/api
COPY scripts/docker-api-entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh \
 && sed -i 's/\r$//' /entrypoint.sh
EXPOSE 4000
ENTRYPOINT ["/entrypoint.sh"]
