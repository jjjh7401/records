import "server-only";
import { createServiceClient } from "@/lib/supabase/service";
import { getLogger } from "@/server/lib/logger";

export type LoginResult = "SUCCESS" | "FAILED";

interface LoginAttempt {
  userId?: string;
  ip?: string;
  userAgent?: string;
  result: LoginResult;
}

/**
 * 로그인 시도 기록 (service_role로 RLS 우회).
 * 감사 기록 실패가 인증 흐름을 깨뜨려서는 안 되므로 내부에서 예외를 삼킨다.
 * 네트워크가 멈춰도 인증이 무한정 대기하지 않도록 타임아웃을 둔다.
 */
const AUDIT_TIMEOUT_MS = 10_000;

async function withTimeout<T>(promise: PromiseLike<T>, label: string): Promise<T> {
  let timer: ReturnType<typeof setTimeout> | undefined;
  try {
    return await Promise.race([
      promise,
      new Promise<T>((_, reject) => {
        timer = setTimeout(() => reject(new Error(`${label} timed out`)), AUDIT_TIMEOUT_MS);
      }),
    ]);
  } finally {
    if (timer) clearTimeout(timer);
  }
}
export async function recordLoginAttempt(attempt: LoginAttempt): Promise<void> {
  try {
    const svc = createServiceClient();
    const { error } = await withTimeout(
      svc.from("login_logs").insert({
        user_id: attempt.userId ?? null,
        ip: attempt.ip ?? null,
        user_agent: attempt.userAgent ?? null,
        result: attempt.result,
      }),
      "login_logs insert",
    );
    if (error) {
      getLogger().warn({ err: error.message }, "failed to write login_logs");
    }
  } catch (err) {
    getLogger().warn(
      { err: err instanceof Error ? err.message : String(err) },
      "failed to write login_logs",
    );
  }
}

export type SecurityEventType =
  | "LOGIN"
  | "FAILED_LOGIN"
  | "PASSWORD_RESET"
  | "MFA"
  | "PASSKEY"
  | "SUSPICIOUS_LOGIN"
  | "AUTHORIZATION_DENIED"
  | "ADMIN_ACCESS"
  | "EXPORT"
  | "DELETE"
  | "API_ABUSE"
  | "CONTENT_TAKEDOWN";

export async function recordSecurityEvent(input: {
  userId?: string;
  type: SecurityEventType;
  detail?: Record<string, unknown>;
}): Promise<void> {
  try {
    const svc = createServiceClient();
    const { error } = await withTimeout(
      svc.from("security_events").insert({
        user_id: input.userId ?? null,
        type: input.type,
        detail: input.detail ?? null,
      }),
      "security_events insert",
    );
    if (error) {
      getLogger().warn({ err: error.message }, "failed to write security_events");
    }
  } catch (err) {
    getLogger().warn(
      { err: err instanceof Error ? err.message : String(err) },
      "failed to write security_events",
    );
  }
}
