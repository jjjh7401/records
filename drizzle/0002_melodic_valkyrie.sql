CREATE TYPE "public"."walkie_entity" AS ENUM('SONG', 'ALBUM');--> statement-breakpoint
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
--> statement-breakpoint
CREATE TABLE "walkie_sections" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"user_id" uuid NOT NULL,
	"name" text NOT NULL,
	"position" integer DEFAULT 0 NOT NULL,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);
--> statement-breakpoint
ALTER TABLE "walkie_items" ADD CONSTRAINT "walkie_items_section_id_walkie_sections_id_fk" FOREIGN KEY ("section_id") REFERENCES "public"."walkie_sections"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "walkie_sections" ADD CONSTRAINT "walkie_sections_user_id_users_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
CREATE INDEX "walkie_items_section_idx" ON "walkie_items" USING btree ("section_id");--> statement-breakpoint
CREATE UNIQUE INDEX "walkie_items_section_entity_uidx" ON "walkie_items" USING btree ("section_id","entity_type","entity_id");--> statement-breakpoint
CREATE INDEX "walkie_sections_user_idx" ON "walkie_sections" USING btree ("user_id");--> statement-breakpoint
CREATE UNIQUE INDEX "walkie_sections_user_name_uidx" ON "walkie_sections" USING btree ("user_id","name");