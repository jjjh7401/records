import "server-only";
import pino from "pino";
import { getEnv } from "./env";
import { getRequestId } from "./request-context";

let base: pino.Logger | null = null;

function getBaseLogger(): pino.Logger {
  if (!base) {
    let level: pino.Level = "info";
    try {
      level = getEnv().LOG_LEVEL;
    } catch {
      // 빌드 시점 등 env 미설정 상태에서는 기본 레벨 사용
    }
    base = pino({ level });
  }
  return base;
}

/**
 * 요청 컨텍스트(requestId)를 자동으로 포함하는 로거.
 * 사용: getLogger().info({ ... }, "message")
 */
export function getLogger(bindings: Record<string, unknown> = {}): pino.Logger {
  const requestId = getRequestId();
  const merged = requestId ? { requestId, ...bindings } : bindings;
  const b = getBaseLogger();
  return Object.keys(merged).length > 0 ? b.child(merged) : b;
}
