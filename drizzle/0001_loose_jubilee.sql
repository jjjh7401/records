CREATE TYPE "public"."artist_type" AS ENUM('PERSON', 'GROUP', 'OTHER');--> statement-breakpoint
CREATE TYPE "public"."asset_source" AS ENUM('COVER_ART_ARCHIVE', 'APPLE_MUSIC', 'OFFICIAL', 'USER_UPLOAD');--> statement-breakpoint
CREATE TYPE "public"."asset_status" AS ENUM('ACTIVE', 'BLOCKED', 'REMOVED', 'NEEDS_REVIEW');--> statement-breakpoint
CREATE TYPE "public"."asset_type" AS ENUM('ALBUM_COVER', 'ARTIST_IMAGE', 'SONG_THUMBNAIL', 'USER_UPLOAD', 'SHOP_IMAGE');--> statement-breakpoint
CREATE TYPE "public"."external_entity" AS ENUM('ARTIST', 'ALBUM', 'RELEASE', 'SONG');--> statement-breakpoint
CREATE TYPE "public"."external_id_status" AS ENUM('MATCHED', 'PENDING_REVIEW', 'MANUAL', 'FAILED');--> statement-breakpoint
CREATE TYPE "public"."external_provider" AS ENUM('MUSICBRAINZ', 'YOUTUBE', 'APPLE_MUSIC');--> statement-breakpoint
CREATE TYPE "public"."rights_type" AS ENUM('LICENSED', 'QUOTATION_ONLY', 'USER_PRIVATE', 'UNAVAILABLE');--> statement-breakpoint
CREATE TABLE "album_artists" (
	"album_id" uuid NOT NULL,
	"artist_id" uuid NOT NULL,
	"position" integer DEFAULT 0 NOT NULL,
	"join_phrase" text,
	CONSTRAINT "album_artists_album_id_artist_id_pk" PRIMARY KEY("album_id","artist_id")
);
--> statement-breakpoint
CREATE TABLE "albums" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"mbid" uuid,
	"title" text NOT NULL,
	"artist_credit" text,
	"primary_type" text,
	"secondary_types" text[],
	"first_release_date" date,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL,
	CONSTRAINT "albums_mbid_unique" UNIQUE("mbid")
);
--> statement-breakpoint
CREATE TABLE "artist_genres" (
	"artist_id" uuid NOT NULL,
	"genre_id" uuid NOT NULL,
	CONSTRAINT "artist_genres_artist_id_genre_id_pk" PRIMARY KEY("artist_id","genre_id")
);
--> statement-breakpoint
CREATE TABLE "artists" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"mbid" uuid,
	"name" text NOT NULL,
	"sort_name" text,
	"type" "artist_type",
	"country" text,
	"life_begin" text,
	"life_end" text,
	"disambiguation" text,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL,
	CONSTRAINT "artists_mbid_unique" UNIQUE("mbid")
);
--> statement-breakpoint
CREATE TABLE "external_ids" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"entity_type" "external_entity" NOT NULL,
	"entity_id" uuid NOT NULL,
	"provider" "external_provider" NOT NULL,
	"external_id" text NOT NULL,
	"url" text,
	"confidence" numeric(3, 2),
	"status" "external_id_status" DEFAULT 'MATCHED' NOT NULL,
	"metadata" jsonb,
	"retrieved_at" timestamp with time zone,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "genres" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"name" text NOT NULL,
	"description" text,
	CONSTRAINT "genres_name_unique" UNIQUE("name")
);
--> statement-breakpoint
CREATE TABLE "media_assets" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"entity_type" "external_entity" NOT NULL,
	"entity_id" uuid NOT NULL,
	"asset_type" "asset_type" NOT NULL,
	"source_type" "asset_source" NOT NULL,
	"source_url" text NOT NULL,
	"rights_type" "rights_type",
	"rights_owner" text,
	"license_type" text,
	"attribution_required" boolean DEFAULT false NOT NULL,
	"attribution_text" text,
	"status" "asset_status" DEFAULT 'NEEDS_REVIEW' NOT NULL,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "releases" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"mbid" uuid,
	"album_id" uuid NOT NULL,
	"title" text NOT NULL,
	"status" text,
	"country" text,
	"release_date" date,
	"release_date_precision" text,
	"barcode" text,
	"language" text,
	"script" text,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL,
	CONSTRAINT "releases_mbid_unique" UNIQUE("mbid")
);
--> statement-breakpoint
CREATE TABLE "song_artists" (
	"song_id" uuid NOT NULL,
	"artist_id" uuid NOT NULL,
	"role" text,
	"position" integer DEFAULT 0 NOT NULL,
	CONSTRAINT "song_artists_song_id_artist_id_pk" PRIMARY KEY("song_id","artist_id")
);
--> statement-breakpoint
CREATE TABLE "songs" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"mbid" uuid,
	"title" text NOT NULL,
	"artist_credit" text,
	"length_ms" integer,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL,
	CONSTRAINT "songs_mbid_unique" UNIQUE("mbid")
);
--> statement-breakpoint
CREATE TABLE "tracks" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"release_id" uuid NOT NULL,
	"song_id" uuid NOT NULL,
	"position" integer NOT NULL,
	"disc_number" integer DEFAULT 1 NOT NULL,
	"title" text,
	"length_ms" integer
);
--> statement-breakpoint
ALTER TABLE "album_artists" ADD CONSTRAINT "album_artists_album_id_albums_id_fk" FOREIGN KEY ("album_id") REFERENCES "public"."albums"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "album_artists" ADD CONSTRAINT "album_artists_artist_id_artists_id_fk" FOREIGN KEY ("artist_id") REFERENCES "public"."artists"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "artist_genres" ADD CONSTRAINT "artist_genres_artist_id_artists_id_fk" FOREIGN KEY ("artist_id") REFERENCES "public"."artists"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "artist_genres" ADD CONSTRAINT "artist_genres_genre_id_genres_id_fk" FOREIGN KEY ("genre_id") REFERENCES "public"."genres"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "releases" ADD CONSTRAINT "releases_album_id_albums_id_fk" FOREIGN KEY ("album_id") REFERENCES "public"."albums"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "song_artists" ADD CONSTRAINT "song_artists_song_id_songs_id_fk" FOREIGN KEY ("song_id") REFERENCES "public"."songs"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "song_artists" ADD CONSTRAINT "song_artists_artist_id_artists_id_fk" FOREIGN KEY ("artist_id") REFERENCES "public"."artists"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "tracks" ADD CONSTRAINT "tracks_release_id_releases_id_fk" FOREIGN KEY ("release_id") REFERENCES "public"."releases"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "tracks" ADD CONSTRAINT "tracks_song_id_songs_id_fk" FOREIGN KEY ("song_id") REFERENCES "public"."songs"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
CREATE INDEX "albums_title_idx" ON "albums" USING btree ("title");--> statement-breakpoint
CREATE UNIQUE INDEX "albums_mbid_uidx" ON "albums" USING btree ("mbid");--> statement-breakpoint
CREATE INDEX "artists_name_idx" ON "artists" USING btree ("name");--> statement-breakpoint
CREATE UNIQUE INDEX "artists_mbid_uidx" ON "artists" USING btree ("mbid");--> statement-breakpoint
CREATE INDEX "external_ids_entity_idx" ON "external_ids" USING btree ("entity_type","entity_id");--> statement-breakpoint
CREATE INDEX "external_ids_provider_idx" ON "external_ids" USING btree ("provider","external_id");--> statement-breakpoint
CREATE UNIQUE INDEX "external_ids_entity_provider_uidx" ON "external_ids" USING btree ("entity_type","entity_id","provider","external_id");--> statement-breakpoint
CREATE INDEX "media_assets_entity_idx" ON "media_assets" USING btree ("entity_type","entity_id");--> statement-breakpoint
CREATE INDEX "media_assets_status_idx" ON "media_assets" USING btree ("status");--> statement-breakpoint
CREATE INDEX "releases_album_idx" ON "releases" USING btree ("album_id");--> statement-breakpoint
CREATE UNIQUE INDEX "releases_mbid_uidx" ON "releases" USING btree ("mbid");--> statement-breakpoint
CREATE INDEX "songs_title_idx" ON "songs" USING btree ("title");--> statement-breakpoint
CREATE UNIQUE INDEX "songs_mbid_uidx" ON "songs" USING btree ("mbid");--> statement-breakpoint
CREATE INDEX "tracks_release_idx" ON "tracks" USING btree ("release_id");--> statement-breakpoint
CREATE INDEX "tracks_song_idx" ON "tracks" USING btree ("song_id");--> statement-breakpoint
CREATE UNIQUE INDEX "tracks_release_disc_pos_uidx" ON "tracks" USING btree ("release_id","disc_number","position");