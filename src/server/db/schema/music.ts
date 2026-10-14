import {
  pgTable,
  pgEnum,
  uuid,
  text,
  timestamp,
  integer,
  numeric,
  boolean,
  date,
  jsonb,
  index,
  uniqueIndex,
  primaryKey,
} from "drizzle-orm/pg-core";

/**
 * Phase B 음악 카탈로그 도메인 스키마.
 *
 * 핵심 원칙 (03_DOMAIN_MODEL.md):
 * - 음악 객체는 한 번만 존재한다. Walkie/Shop/Collection/Rating 등은
 *   SONG 행을 참조만 하고 절대 복제하지 않는다.
 * - ALBUM(작품 단위)과 RELEASE(발매 버전)는 분리한다 (D-019 A-002).
 *   MVP UI는 Album 중심.
 * - MusicBrainz가 canonical 메타데이터 소스. MBID는 uuid로 저장.
 * - 외부 식별자(ISRC 포함, D-019 A-003)는 external_ids에 provider별로 저장.
 *   SONG 테이블에 provider 종속 컬럼을 두지 않는다.
 * - 아트워크/권리는 MEDIA_ASSET으로 분리 (03-5). 제3자 아트워크
 *   자동 저장은 금지 (D-006).
 * - YouTube 매칭 결과는 external_ids에 저장 (D-017):
 *   ingestion 시점 1회 매칭 + confidence + 수동 검토 큐 + 사용자 직접 입력 폴백.
 */

export const artistTypeEnum = pgEnum("artist_type", ["PERSON", "GROUP", "OTHER"]);

export const externalProviderEnum = pgEnum("external_provider", [
  "MUSICBRAINZ",
  "YOUTUBE",
  "APPLE_MUSIC",
]);

export const externalEntityEnum = pgEnum("external_entity", [
  "ARTIST",
  "ALBUM",
  "RELEASE",
  "SONG",
]);

/** D-017: YouTube 매칭 상태. PENDING_REVIEW = 수동 검토 큐, MANUAL = 사용자 직접 입력. */
export const externalIdStatusEnum = pgEnum("external_id_status", [
  "MATCHED",
  "PENDING_REVIEW",
  "MANUAL",
  "FAILED",
]);

export const assetTypeEnum = pgEnum("asset_type", [
  "ALBUM_COVER",
  "ARTIST_IMAGE",
  "SONG_THUMBNAIL",
  "USER_UPLOAD",
  "SHOP_IMAGE",
]);

export const assetSourceEnum = pgEnum("asset_source", [
  "COVER_ART_ARCHIVE",
  "APPLE_MUSIC",
  "OFFICIAL",
  "USER_UPLOAD",
]);

/** 03-6 권리 상태. */
export const rightsTypeEnum = pgEnum("rights_type", [
  "LICENSED",
  "QUOTATION_ONLY",
  "USER_PRIVATE",
  "UNAVAILABLE",
]);

/** 03-5/03-8 Asset 상태. */
export const assetStatusEnum = pgEnum("asset_status", [
  "ACTIVE",
  "BLOCKED",
  "REMOVED",
  "NEEDS_REVIEW",
]);

const timestamps = {
  createdAt: timestamp("created_at", { withTimezone: true }).notNull().defaultNow(),
  updatedAt: timestamp("updated_at", { withTimezone: true }).notNull().defaultNow(),
};

/** 부분 날짜(연도만 등) 저장을 위해 text로 둔다. 예: "1999", "1999-05-21". */
const lifeSpan = {
  lifeBegin: text("life_begin"),
  lifeEnd: text("life_end"),
};

export const artists = pgTable(
  "artists",
  {
    id: uuid("id").primaryKey().defaultRandom(),
    /** MusicBrainz artist MBID. */
    mbid: uuid("mbid").unique(),
    name: text("name").notNull(),
    sortName: text("sort_name"),
    type: artistTypeEnum("type"),
    country: text("country"),
    ...lifeSpan,
    disambiguation: text("disambiguation"),
    ...timestamps,
  },
  (t) => [
    index("artists_name_idx").on(t.name),
    uniqueIndex("artists_mbid_uidx").on(t.mbid),
  ],
);

/**
 * ALBUM = 작품 단위 (MusicBrainz release-group).
 * D-019 A-002: MVP UI는 Album 중심.
 */
export const albums = pgTable(
  "albums",
  {
    id: uuid("id").primaryKey().defaultRandom(),
    /** MusicBrainz release-group MBID. */
    mbid: uuid("mbid").unique(),
    title: text("title").notNull(),
    /** 화면 표시용 아티스트 크레딧. 예: "Vaundy". */
    artistCredit: text("artist_credit"),
    primaryType: text("primary_type"),
    secondaryTypes: text("secondary_types").array(),
    firstReleaseDate: date("first_release_date"),
    ...timestamps,
  },
  (t) => [
    index("albums_title_idx").on(t.title),
    uniqueIndex("albums_mbid_uidx").on(t.mbid),
  ],
);

export const albumArtists = pgTable(
  "album_artists",
  {
    albumId: uuid("album_id")
      .notNull()
      .references(() => albums.id, { onDelete: "cascade" }),
    artistId: uuid("artist_id")
      .notNull()
      .references(() => artists.id, { onDelete: "cascade" }),
    position: integer("position").notNull().default(0),
    joinPhrase: text("join_phrase"),
  },
  (t) => [primaryKey({ columns: [t.albumId, t.artistId] })],
);

/**
 * RELEASE = 발매 버전 (MusicBrainz release).
 * 같은 앨범의 CD / Vinyl / digital / Japan edition 등을 구분한다.
 */
export const releases = pgTable(
  "releases",
  {
    id: uuid("id").primaryKey().defaultRandom(),
    /** MusicBrainz release MBID. */
    mbid: uuid("mbid").unique(),
    albumId: uuid("album_id")
      .notNull()
      .references(() => albums.id, { onDelete: "cascade" }),
    title: text("title").notNull(),
    status: text("status"),
    country: text("country"),
    releaseDate: date("release_date"),
    releaseDatePrecision: text("release_date_precision"),
    barcode: text("barcode"),
    language: text("language"),
    script: text("script"),
    ...timestamps,
  },
  (t) => [
    index("releases_album_idx").on(t.albumId),
    uniqueIndex("releases_mbid_uidx").on(t.mbid),
  ],
);

/**
 * SONG = 곡 (MusicBrainz recording). 정규화의 중심.
 * 모든 사용자 콘텐츠(Walkie/Shop/Collection/Rating/Review)는 이 행을 참조한다.
 */
export const songs = pgTable(
  "songs",
  {
    id: uuid("id").primaryKey().defaultRandom(),
    /** MusicBrainz recording MBID. */
    mbid: uuid("mbid").unique(),
    title: text("title").notNull(),
    /** 화면 표시용 아티스트 크레딧. */
    artistCredit: text("artist_credit"),
    lengthMs: integer("length_ms"),
    ...timestamps,
  },
  (t) => [
    index("songs_title_idx").on(t.title),
    uniqueIndex("songs_mbid_uidx").on(t.mbid),
  ],
);

export const songArtists = pgTable(
  "song_artists",
  {
    songId: uuid("song_id")
      .notNull()
      .references(() => songs.id, { onDelete: "cascade" }),
    artistId: uuid("artist_id")
      .notNull()
      .references(() => artists.id, { onDelete: "cascade" }),
    /** 예: "feat", "composer", "lyricist". */
    role: text("role"),
    position: integer("position").notNull().default(0),
  },
  (t) => [primaryKey({ columns: [t.songId, t.artistId] })],
);

/** RELEASE ↔ SONG 조인. 트랙 순서/디스크 번호를 가진다. */
export const tracks = pgTable(
  "tracks",
  {
    id: uuid("id").primaryKey().defaultRandom(),
    releaseId: uuid("release_id")
      .notNull()
      .references(() => releases.id, { onDelete: "cascade" }),
    songId: uuid("song_id")
      .notNull()
      .references(() => songs.id),
    position: integer("position").notNull(),
    discNumber: integer("disc_number").notNull().default(1),
    /** 트랙 레벨 타이틀 오버라이드 (없으면 songs.title 사용). */
    title: text("title"),
    lengthMs: integer("length_ms"),
  },
  (t) => [
    index("tracks_release_idx").on(t.releaseId),
    index("tracks_song_idx").on(t.songId),
    uniqueIndex("tracks_release_disc_pos_uidx").on(t.releaseId, t.discNumber, t.position),
  ],
);

/**
 * 외부 식별자 (03-4, D-017, D-019 A-003).
 * - MusicBrainz: MBID 미러 (조회 편의용)
 * - YouTube: video id / channel id + confidence + 매칭 상태
 * - Apple Music: catalog id (D-016 fallback)
 * - ISRC: provider='MUSICBRAINZ' 또는 별도 provider 없이 external_id에 저장
 */
export const externalIds = pgTable(
  "external_ids",
  {
    id: uuid("id").primaryKey().defaultRandom(),
    entityType: externalEntityEnum("entity_type").notNull(),
    entityId: uuid("entity_id").notNull(),
    provider: externalProviderEnum("provider").notNull(),
    externalId: text("external_id").notNull(),
    url: text("url"),
    /** D-017: YouTube 매칭 confidence (0~1). */
    confidence: numeric("confidence", { precision: 3, scale: 2 }),
    status: externalIdStatusEnum("status").notNull().default("MATCHED"),
    metadata: jsonb("metadata"),
    retrievedAt: timestamp("retrieved_at", { withTimezone: true }),
    ...timestamps,
  },
  (t) => [
    index("external_ids_entity_idx").on(t.entityType, t.entityId),
    index("external_ids_provider_idx").on(t.provider, t.externalId),
    uniqueIndex("external_ids_entity_provider_uidx").on(
      t.entityType,
      t.entityId,
      t.provider,
      t.externalId,
    ),
  ],
);

/**
 * MEDIA_ASSET (03-5). 아트워크와 권리를 엔티티와 분리해 관리한다.
 * - source_url은 참조용. 제3자 아트워크 자동 다운로드는 금지 (D-006).
 */
export const mediaAssets = pgTable(
  "media_assets",
  {
    id: uuid("id").primaryKey().defaultRandom(),
    entityType: externalEntityEnum("entity_type").notNull(),
    entityId: uuid("entity_id").notNull(),
    assetType: assetTypeEnum("asset_type").notNull(),
    sourceType: assetSourceEnum("source_type").notNull(),
    sourceUrl: text("source_url").notNull(),
    rightsType: rightsTypeEnum("rights_type"),
    rightsOwner: text("rights_owner"),
    licenseType: text("license_type"),
    attributionRequired: boolean("attribution_required").notNull().default(false),
    attributionText: text("attribution_text"),
    status: assetStatusEnum("status").notNull().default("NEEDS_REVIEW"),
    ...timestamps,
  },
  (t) => [
    index("media_assets_entity_idx").on(t.entityType, t.entityId),
    index("media_assets_status_idx").on(t.status),
  ],
);

export const genres = pgTable("genres", {
  id: uuid("id").primaryKey().defaultRandom(),
  name: text("name").notNull().unique(),
  description: text("description"),
});

export const artistGenres = pgTable(
  "artist_genres",
  {
    artistId: uuid("artist_id")
      .notNull()
      .references(() => artists.id, { onDelete: "cascade" }),
    genreId: uuid("genre_id")
      .notNull()
      .references(() => genres.id, { onDelete: "cascade" }),
  },
  (t) => [primaryKey({ columns: [t.artistId, t.genreId] })],
);
