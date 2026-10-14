export type ErrorCode =
  | "UNAUTHORIZED"
  | "FORBIDDEN"
  | "NOT_FOUND"
  | "VALIDATION_ERROR"
  | "AUTH_FAILED"
  | "RATE_LIMITED"
  | "CONFLICT"
  | "INTERNAL_ERROR";

/**
 * 애플리케이션 에러. API Route Handler에서는 toErrorResponse()로 변환한다.
 * message에는 내부 구현 세부사항(스택, 쿼리 등)을 절대 포함하지 않는다.
 */
export class AppError extends Error {
  readonly code: ErrorCode;
  readonly status: number;
  readonly details?: unknown;

  constructor(code: ErrorCode, message: string, status: number, details?: unknown) {
    super(message);
    this.name = "AppError";
    this.code = code;
    this.status = status;
    this.details = details;
  }
}

export const unauthorized = (message = "로그인이 필요합니다.") =>
  new AppError("UNAUTHORIZED", message, 401);

export const forbidden = (message = "권한이 없습니다.") =>
  new AppError("FORBIDDEN", message, 403);

export const notFound = (message = "리소스를 찾을 수 없습니다.") =>
  new AppError("NOT_FOUND", message, 404);

export const validationError = (message = "입력값이 올바르지 않습니다.", details?: unknown) =>
  new AppError("VALIDATION_ERROR", message, 400, details);

export const authFailed = (message = "인증에 실패했습니다.") =>
  new AppError("AUTH_FAILED", message, 401);

export const conflict = (message = "이미 존재하는 리소스입니다.") =>
  new AppError("CONFLICT", message, 409);

export const internalError = (message = "일시적인 오류가 발생했습니다.") =>
  new AppError("INTERNAL_ERROR", message, 500);

/**
 * Route Handler용 에러 → JSON 응답 변환.
 * 5xx에서는 내부 메시지를 숨기고 고정 메시지를 반환한다.
 */
export function toErrorPayload(err: unknown): { code: ErrorCode; message: string; status: number } {
  if (err instanceof AppError) {
    const message = err.status >= 500 ? "일시적인 오류가 발생했습니다." : err.message;
    const code = err.status >= 500 ? ("INTERNAL_ERROR" as const) : err.code;
    return { code, message, status: err.status };
  }
  return { code: "INTERNAL_ERROR", message: "일시적인 오류가 발생했습니다.", status: 500 };
}
