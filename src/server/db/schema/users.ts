import {
  pgTable,
  pgEnum,
  uuid,
  text,
  timestamp,
  index,
} from "drizzle-orm/pg-core";

/**
 * Phase A 사용자 도메인 스키마.
 *
 * public.users.id는 auth.users(id)를 논리적으로 참조한다.
 * (Drizzle에서 auth 스키마를 직접 참조하지 않고, 생성은 auth_trigger.sql의
 *  DB trigger가 담당한다.)
 */

export const userStatusEnum = pgEnum("user_status", ["ACTIVE", "SUSPENDED", "DELETED"]);

export const visibilityEnum = pgEnum("visibility", ["public", "followers", "private"]);

export const adminRoleEnum = pgEnum("admin_role", ["SUPER_ADMIN", "MODERATOR"]);

const timestamps = {
  createdAt: timestamp("created_at", { withTimezone: true }).notNull().defaultNow(),
  updatedAt: timestamp("updated_at", { withTimezone: true }).notNull().defaultNow(),
};

export const users = pgTable(
  "users",
  {
    id: uuid("id").primaryKey(),
    email: text("email").notNull().unique(),
    status: userStatusEnum("status").notNull().default("ACTIVE"),
    ...timestamps,
    deletedAt: timestamp("deleted_at", { withTimezone: true }),
  },
  (t) => [index("users_email_idx").on(t.email)],
);

export const userProfiles = pgTable("user_profiles", {
  userId: uuid("user_id")
    .primaryKey()
    .references(() => users.id, { onDelete: "cascade" }),
  handle: text("handle").notNull().unique(),
  displayName: text("display_name"),
  // Phase F MEDIA_ASSET과 연결 예정. Phase A에서는 FK 없이 nullable로 둔다.
  avatarAssetId: uuid("avatar_asset_id"),
  bio: text("bio"),
  ...timestamps,
});

export const userPrivacy = pgTable("user_privacy", {
  userId: uuid("user_id")
    .primaryKey()
    .references(() => users.id, { onDelete: "cascade" }),
  // D-018: Shop 공개 기본값은 Public. 프로필 자체의 기본값도 public.
  profileVisibility: visibilityEnum("profile_visibility").notNull().default("public"),
  updatedAt: timestamp("updated_at", { withTimezone: true }).notNull().defaultNow(),
});

export const userRegions = pgTable("user_regions", {
  userId: uuid("user_id")
    .primaryKey()
    .references(() => users.id, { onDelete: "cascade" }),
  // D-012: 광역시/도, 시/군/구까지만 저장. 정밀 위치 수집 금지.
  sido: text("sido"),
  sigungu: text("sigungu"),
  visibility: visibilityEnum("visibility").notNull().default("followers"),
  updatedAt: timestamp("updated_at", { withTimezone: true }).notNull().defaultNow(),
});

export const adminRoles = pgTable("admin_roles", {
  userId: uuid("user_id")
    .primaryKey()
    .references(() => users.id, { onDelete: "cascade" }),
  role: adminRoleEnum("role").notNull(),
  grantedAt: timestamp("granted_at", { withTimezone: true }).notNull().defaultNow(),
  grantedBy: uuid("granted_by"),
});
