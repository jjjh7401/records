import "server-only";
import { drizzle } from "drizzle-orm/postgres-js";
import postgres from "postgres";
import { getEnv } from "@/server/lib/env";
import * as schema from "./schema";

/**
 * Drizzle 직접 연결 클라이언트 (migration, worker, 배치 작업용).
 * DB role(postgres)로 직접 연결되므로 RLS를 우회한다.
 * 브라우저/클라이언트 컴포넌트에서 절대 import하지 않는다.
 */
let db: ReturnType<typeof drizzle<typeof schema>> | null = null;

export function getDb() {
  if (!db) {
    const { SUPABASE_DB_URL } = getEnv();
    const client = postgres(SUPABASE_DB_URL, { prepare: false, max: 1 });
    db = drizzle(client, { schema });
  }
  return db;
}

export type Database = ReturnType<typeof getDb>;
