#!/bin/sh
set -e

echo "Running migrations..."
node packages/db/dist/migrate.js

echo "Checking seed..."
node --input-type=module -e "
import { createDb, users } from '@pidejusto/db';
const db = createDb(process.env.DATABASE_URL);
const rows = await db.select().from(users).limit(1);
if (!rows.length) {
  console.log('DB empty — seeding');
  const { spawnSync } = await import('node:child_process');
  const r = spawnSync(process.execPath, ['packages/db/dist/seed.js'], {
    stdio: 'inherit',
    env: process.env,
  });
  process.exit(r.status ?? 1);
}
console.log('Seed skipped (users exist)');
"

echo "Starting API..."
exec node apps/api/dist/index.js
