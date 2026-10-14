import "server-only";
import type { SupabaseClient } from "@supabase/supabase-js";

/**
 * Walkie 조회 모듈.
 * RLS가 적용되는 사용자 세션 클라이언트를 사용한다.
 * (walkie_sections/walkie_items는 본인 것만 읽힌다)
 */

export interface WalkieSection {
  id: string;
  name: string;
  itemCount: number;
}

export interface WalkieItem {
  id: string;
  entityType: "SONG" | "ALBUM";
  entityId: string;
  rating: number | null;
  memo: string | null;
  title: string;
  subtitle: string | null;
  coverUrl: string | null;
  /** 앨범 아이템일 때 상세로 이동 */
  albumId: string | null;
}

const DEFAULT_SECTION = "FAVORITES";

/** 사용자의 섹션 목록 (아이템 수 포함). */
export async function getWalkieSections(
  db: SupabaseClient,
): Promise<WalkieSection[]> {
  const { data: sections } = await db
    .from("walkie_sections")
    .select("id, name")
    .order("position")
    .order("created_at");
  if (!sections) return [];

  const { data: items } = await db
    .from("walkie_items")
    .select("section_id");
  const countBy = new Map<string, number>();
  for (const it of items ?? []) {
    const sid = it.section_id as string;
    countBy.set(sid, (countBy.get(sid) ?? 0) + 1);
  }
  return sections.map((s) => ({
    id: s.id as string,
    name: s.name as string,
    itemCount: countBy.get(s.id as string) ?? 0,
  }));
}

/** 섹션의 아이템 목록 (앨범/곡 정보 resolve). */
export async function getWalkieItems(
  db: SupabaseClient,
  sectionId: string,
): Promise<WalkieItem[]> {
  const { data: rows } = await db
    .from("walkie_items")
    .select("id, entity_type, entity_id, rating, memo")
    .eq("section_id", sectionId)
    .order("created_at", { ascending: false });
  if (!rows || rows.length === 0) return [];

  const albumIds = rows
    .filter((r) => r.entity_type === "ALBUM")
    .map((r) => r.entity_id as string);
  const songIds = rows
    .filter((r) => r.entity_type === "SONG")
    .map((r) => r.entity_id as string);

  const albumById = new Map<string, { title: string; artist: string | null }>();
  if (albumIds.length > 0) {
    const { data } = await db
      .from("albums")
      .select("id, title, artist_credit")
      .in("id", albumIds);
    for (const a of data ?? []) {
      albumById.set(a.id as string, {
        title: a.title as string,
        artist: (a.artist_credit as string | null) ?? null,
      });
    }
  }

  const songById = new Map<string, { title: string; artist: string | null }>();
  if (songIds.length > 0) {
    const { data } = await db
      .from("songs")
      .select("id, title, artist_credit")
      .in("id", songIds);
    for (const s of data ?? []) {
      songById.set(s.id as string, {
        title: s.title as string,
        artist: (s.artist_credit as string | null) ?? null,
      });
    }
  }

  // 승인된 앨범 커버만
  const coverByAlbum = new Map<string, string>();
  if (albumIds.length > 0) {
    const { data } = await db
      .from("media_assets")
      .select("entity_id, source_url")
      .eq("entity_type", "ALBUM")
      .eq("asset_type", "ALBUM_COVER")
      .in("entity_id", albumIds);
    for (const r of data ?? []) {
      coverByAlbum.set(r.entity_id as string, r.source_url as string);
    }
  }

  return rows.map((r) => {
    const isAlbum = r.entity_type === "ALBUM";
    const info = isAlbum
      ? albumById.get(r.entity_id as string)
      : songById.get(r.entity_id as string);
    return {
      id: r.id as string,
      entityType: r.entity_type as "SONG" | "ALBUM",
      entityId: r.entity_id as string,
      rating: r.rating == null ? null : Number(r.rating),
      memo: (r.memo as string | null) ?? null,
      title: info?.title ?? "(삭제된 항목)",
      subtitle: info?.artist ?? null,
      coverUrl: isAlbum
        ? (coverByAlbum.get(r.entity_id as string) ?? null)
        : null,
      albumId: isAlbum ? (r.entity_id as string) : null,
    };
  });
}

/** 해당 앨범이 이미 Walkie에 있는지 (담기 버튼 상태용). */
export async function isAlbumSaved(
  db: SupabaseClient,
  albumId: string,
): Promise<boolean> {
  const { data: sections } = await db
    .from("walkie_sections")
    .select("id")
    .eq("name", DEFAULT_SECTION)
    .limit(1);
  const sectionId = sections?.[0]?.id as string | undefined;
  if (!sectionId) return false;
  const { data: items } = await db
    .from("walkie_items")
    .select("id")
    .eq("section_id", sectionId)
    .eq("entity_type", "ALBUM")
    .eq("entity_id", albumId)
    .limit(1);
  return (items?.length ?? 0) > 0;
}

export { DEFAULT_SECTION };
