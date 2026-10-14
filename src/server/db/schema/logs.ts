import {
  pgTable,
  pgEnum,
  uuid,
  text,
  timestamp,
  jsonb,
  index,
} from "drizzle-orm/pg-core";
import { users } from "./users";

/**
 * Phase A 감사/보안 로그 스키마 (문서 07-7, 07-8).
 * 로그 테이블은 UPDATE/DELETE를 허용하지 않는 append-only 운용을 권장한다
 * (RLS 정책은 supabase/rls_policies.sql 참조).
 */

export const loginResultEnum = pgEnum("login_result", ["SUCCESS", "FAILED"]);

export const securityEventTypeEnum = pgEnum("security_event_type", [
  "LOGIN",
  "FAILED_LOGIN",
  "PASSWORD_RESET",
  "MFA",
  "PASSKEY",
  "SUSPICIOUS_LOGIN",
  "AUTHORIZATION_DENIED",
  "ADMIN_ACCESS",
  "EXPORT",
  "DELETE",
  "API_ABUSE",
  "CONTENT_TAKEDOWN",
]);

const occurredAt = timestamp("occurred_at", { withTimezone: true }).notNull().defaultNow();

export const loginLogs = pgTable(
  "login_logs",
  {
    id: uuid("id").primaryKey().defaultRandom(),
    userId: uuid("user_id").references(() => users.id, { onDelete: "set null" }),
    occurredAt,
    ip: text("ip"),
    userAgent: text("user_agent"),
    result: loginResultEnum("result").notNull(),
  },
  (t) => [
    index("login_logs_user_occurred_idx").on(t.userId, t.occurredAt),
    index("login_logs_occurred_idx").on(t.occurredAt),
  ],
);

export const securityEvents = pgTable(
  "security_events",
  {
    id: uuid("id").primaryKey().defaultRandom(),
    userId: uuid("user_id").references(() => users.id, { onDelete: "set null" }),
    type: securityEventTypeEnum("type").notNull(),
    detail: jsonb("detail"),
    occurredAt,
  },
  (t) => [
    index("security_events_type_occurred_idx").on(t.type, t.occurredAt),
    index("security_events_user_idx").on(t.userId),
  ],
);

export const adminAuditLogs = pgTable(
  "admin_audit_logs",
  {
    id: uuid("id").primaryKey().defaultRandom(),
    adminUserId: uuid("admin_user_id").references(() => users.id, { onDelete: "set null" }),
    action: text("action").notNull(),
    targetType: text("target_type"),
    targetId: text("target_id"),
    detail: jsonb("detail"),
    occurredAt,
  },
  (t) => [index("admin_audit_logs_admin_occurred_idx").on(t.adminUserId, t.occurredAt)],
);
