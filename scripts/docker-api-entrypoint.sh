#!/bin/sh
set -e
echo "Running migrations..."
npm run migrate -w @pidejusto/db
echo "Seeding if empty..."
node -e "
import { createDb, users } from '@pidejusto/db';
const db = createDb(process.env.DATABASE_URL);
const rows = await db.select().from(users).limit(1);
if (!rows.length) {
  console.log('DB empty — seeding');
  const { spawnSync } = await import('child_process');
  const r = spawnSync('npm', ['run', 'seed', '-w', '@pidejusto/db'], { stdio: 'inherit', shell: true });
  process.exit(r.status || 0);
} else {
  console.log('Seed skipped (users exist)');
  process.exit(0);
}
"
echo "Starting API..."
exec node apps/api/dist/index.js
