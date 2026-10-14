CREATE TYPE "public"."walkie_entity" AS ENUM('SONG', 'ALBUM');
CREATE TABLE "walkie_items" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"section_id" uuid NOT NULL,
	"entity_type" "walkie_entity" NOT NULL,
	"entity_id" uuid NOT NULL,
	"position" integer DEFAULT 0 NOT NULL,
	"rating" numeric(2, 1),
	"memo" text,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "walkie_sections" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"user_id" uuid NOT NULL,
	"name" text NOT NULL,
	"position" integer DEFAULT 0 NOT NULL,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);

ALTER TABLE "walkie_items" ADD CONSTRAINT "walkie_items_section_id_walkie_sections_id_fk" FOREIGN KEY ("section_id") REFERENCES "public"."walkie_sections"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "walkie_sections" ADD CONSTRAINT "walkie_sections_user_id_users_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE cascade ON UPDATE no action;
CREATE INDEX "walkie_items_section_idx" ON "walkie_items" USING btree ("section_id");
CREATE UNIQUE INDEX "walkie_items_section_entity_uidx" ON "walkie_items" USING btree ("section_id","entity_type","entity_id");
CREATE INDEX "walkie_sections_user_idx" ON "walkie_sections" USING btree ("user_id");
CREATE UNIQUE INDEX "walkie_sections_user_name_uidx" ON "walkie_sections" USING btree ("user_id","name");

-- Walkie RLS.
-- 본인의 섹션/아이템만 CRUD 가능. anon은 접근 불가.

alter table public.walkie_sections enable row level security;
alter table public.walkie_items enable row level security;

-- 섹션: 본인 것만
create policy "own sections" on public.walkie_sections
  for all to authenticated
  using (user_id = auth.uid())
  with check (user_id = auth.uid());

-- 아이템: 본인 섹션에 속한 것만
create policy "own items" on public.walkie_items
  for all to authenticated
  using (
    exists (
      select 1 from public.walkie_sections s
      where s.id = walkie_items.section_id
        and s.user_id = auth.uid()
    )
  )
  with check (
    exists (
      select 1 from public.walkie_sections s
      where s.id = walkie_items.section_id
        and s.user_id = auth.uid()
    )
  );
