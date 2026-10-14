import {
  pgTable,
  pgEnum,
  uuid,
  text,
  timestamp,
  integer,
  numeric,
  uniqueIndex,
  index,
} from "drizzle-orm/pg-core";
import { users } from "./users";

/**
 * Walkie — RECORDS의 핵심 개인 공간 (02_UX_AND_CORE_LOOP.md).
 *
 * - 사용자가 직접 만드는 섹션 (예: FAVORITES, ANIME, CITY POP)에
 *   곡/앨범을 저장·분류한다.
 * - 음악 객체는 중앙 SONG/ALBUM에 한 번만 존재하고,
 *   Walkie 아이템은 참조만 한다 (entity_type + entity_id).
 * - 평점은 5점 만점, 0.5 단위 (D-019).
 */

export const walkieEntityEnum = pgEnum("walkie_entity", ["SONG", "ALBUM"]);

const timestamps = {
  createdAt: timestamp("created_at", { withTimezone: true }).notNull().defaultNow(),
  updatedAt: timestamp("updated_at", { withTimezone: true }).notNull().defaultNow(),
};

/** 사용자가 만드는 분류 섹션. 첫 저장 시 FAVORITES가 자동 생성된다. */
export const walkieSections = pgTable(
  "walkie_sections",
  {
    id: uuid("id").primaryKey().defaultRandom(),
    userId: uuid("user_id")
      .notNull()
      .references(() => users.id, { onDelete: "cascade" }),
    name: text("name").notNull(),
    position: integer("position").notNull().default(0),
    ...timestamps,
  },
  (t) => [
    index("walkie_sections_user_idx").on(t.userId),
    uniqueIndex("walkie_sections_user_name_uidx").on(t.userId, t.name),
  ],
);

/** 섹션에 담긴 곡/앨범. 평점과 짧은 메모를 가진다. */
export const walkieItems = pgTable(
  "walkie_items",
  {
    id: uuid("id").primaryKey().defaultRandom(),
    sectionId: uuid("section_id")
      .notNull()
      .references(() => walkieSections.id, { onDelete: "cascade" }),
    entityType: walkieEntityEnum("entity_type").notNull(),
    entityId: uuid("entity_id").notNull(),
    position: integer("position").notNull().default(0),
    /** 평점 0~5, 0.5 단위. null = 미평가. */
    rating: numeric("rating", { precision: 2, scale: 1 }),
    memo: text("memo"),
    ...timestamps,
  },
  (t) => [
    index("walkie_items_section_idx").on(t.sectionId),
    uniqueIndex("walkie_items_section_entity_uidx").on(
      t.sectionId,
      t.entityType,
      t.entityId,
    ),
  ],
);
