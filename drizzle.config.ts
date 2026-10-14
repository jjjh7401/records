import { defineConfig } from "drizzle-kit";

export default defineConfig({
  schema: "./src/server/db/schema/index.ts",
  out: "./drizzle",
  dialect: "postgresql",
  dbCredentials: {
    // generate는 DB 연결 없이 동작한다. migrate 실행 시 실제 URL 필요.
    url:
      process.env.SUPABASE_DB_URL ??
      "postgresql://postgres:postgres@localhost:5432/postgres",
  },
});
