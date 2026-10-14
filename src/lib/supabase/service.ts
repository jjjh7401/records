import "server-only";
import { createClient } from "@supabase/supabase-js";
import { getEnv } from "@/server/lib/env";

/**
 * 서버 전용 service_role 클라이언트.
 * RLS를 우회하므로 감사 로그 기록 등 신뢰할 수 있는 서버 코드에서만 사용한다.
 *
 * ⚠️ 절대 클라이언트 컴포넌트/브라우저 번들에 포함시키지 않는다.
 */
export function createServiceClient() {
  const { NEXT_PUBLIC_SUPABASE_URL, SUPABASE_SERVICE_ROLE_KEY } = getEnv();

  return createClient(NEXT_PUBLIC_SUPABASE_URL, SUPABASE_SERVICE_ROLE_KEY, {
    auth: {
      autoRefreshToken: false,
      persistSession: false,
    },
  });
}
