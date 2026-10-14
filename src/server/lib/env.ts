import { z } from "zod";

/**
 * 환경변수 스키마.
 *
 * lazy evaluation: 모듈 import 시점이 아니라 getEnv() 최초 호출 시점에 검증한다.
 * 빌드 시점(next build)에 env가 없어도 통과하고, 런타임에 실제 접근할 때 검증된다.
 */
const envSchema = z.object({
  NEXT_PUBLIC_SUPABASE_URL: z.string().url("NEXT_PUBLIC_SUPABASE_URL must be a URL"),
  NEXT_PUBLIC_SUPABASE_ANON_KEY: z.string().min(1, "NEXT_PUBLIC_SUPABASE_ANON_KEY is required"),
  SUPABASE_SERVICE_ROLE_KEY: z.string().min(1, "SUPABASE_SERVICE_ROLE_KEY is required"),
  SUPABASE_DB_URL: z.string().min(1, "SUPABASE_DB_URL is required"),
  APP_URL: z.string().url().default("http://localhost:3000"),
  LOG_LEVEL: z.enum(["debug", "info", "warn", "error"]).default("info"),
  SENTRY_DSN: z.string().optional(),
});

export type Env = z.infer<typeof envSchema>;

let cached: Env | null = null;

export function getEnv(): Env {
  if (!cached) {
    const parsed = envSchema.safeParse(process.env);
    if (!parsed.success) {
      throw new Error(`Invalid environment variables:\n${parsed.error.message}`);
    }
    cached = parsed.data;
  }
  return cached;
}

/** 테스트 등에서 캐시를 초기화할 때 사용 */
export function resetEnvCache(): void {
  cached = null;
}
