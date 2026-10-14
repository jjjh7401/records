import "server-only";
import type { SupabaseClient } from "@supabase/supabase-js";

/**
 * 앨범 상세 조회 모듈 (공개 카탈로그, RLS 경유 읽기).
 *
 * - 앨범 → 첫 번째 릴리스 → 트랙 → 곡 순서로 조회한다.
 *   (MVP는 Album 중심 UI. D-019 A-002)
 * - 커버 아트워크는 승인된(ACTIVE) 것만 RLS로 노출된다.
 *   미승인 상태면 null을 반환하고 UI에서 플레이스홀더를 보여준다.
 */

export interface TrackHit {
  position: number;
  discNumber: number;
  songId: string;
  title: string;
  artistCredit: string | null;
  lengthMs: number | null;
}

export interface AlbumDetail {
  id: string;
  title: string;
  artistCredit: string | null;
  firstReleaseDate: string | null;
  primaryType: string | null;
  coverUrl: string | null;
  tracks: TrackHit[];
}

const UUID_RE =
  /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i;

export async function getAlbumDetail(
  db: SupabaseClient,
  albumId: string,
): Promise<AlbumDetail | null> {
  if (!UUID_RE.test(albumId)) return null;

  const { data: album } = await db
    .from("albums")
    .select("id, title, artist_credit, first_release_date, primary_type")
    .eq("id", albumId)
    .single();
  if (!album) return null;

  // 앨범의 첫 번째 릴리스를 대표로 사용
  const { data: releases } = await db
    .from("releases")
    .select("id")
    .eq("album_id", albumId)
    .order("release_date", { ascending: true, nullsFirst: false })
    .limit(1);
  const releaseId = releases?.[0]?.id as string | undefined;

  let tracks: TrackHit[] = [];
  if (releaseId) {
    const { data: trackRows } = await db
      .from("tracks")
      .select(
        "position, disc_number, song_id, songs(id, title, artist_credit, length_ms)",
      )
      .eq("release_id", releaseId)
      .order("disc_number", { ascending: true })
      .order("position", { ascending: true });
    tracks = (trackRows ?? []).map((t) => {
      // tracks → songs는 다대일 조인이라 Supabase가 배열로 타이핑한다
      const rawSong = t.songs as unknown;
      const song = (Array.isArray(rawSong) ? rawSong[0] : rawSong) as {
        id: string;
        title: string;
        artist_credit: string | null;
        length_ms: number | null;
      } | null;
      return {
        position: t.position as number,
        discNumber: t.disc_number as number,
        songId: (song?.id ?? t.song_id) as string,
        title: (song?.title ?? "") as string,
        artistCredit: (song?.artist_credit ?? null) as string | null,
        lengthMs: (song?.length_ms ?? null) as number | null,
      };
    });
  }

  // 승인된 커버만 RLS로 읽힌다
  const { data: assets } = await db
    .from("media_assets")
    .select("source_url")
    .eq("entity_type", "ALBUM")
    .eq("entity_id", albumId)
    .eq("asset_type", "ALBUM_COVER")
    .limit(1);
  const coverUrl = (assets?.[0]?.source_url as string | undefined) ?? null;

  return {
    id: album.id as string,
    title: album.title as string,
    artistCredit: (album.artist_credit as string | null) ?? null,
    firstReleaseDate: (album.first_release_date as string | null) ?? null,
    primaryType: (album.primary_type as string | null) ?? null,
    coverUrl,
    tracks,
  };
}

/** 밀리초를 m:ss 형식으로. */
export function formatDuration(lengthMs: number | null): string {
  if (lengthMs == null || lengthMs < 0) return "";
  const totalSec = Math.round(lengthMs / 1000);
  const m = Math.floor(totalSec / 60);
  const s = totalSec % 60;
  return `${m}:${String(s).padStart(2, "0")}`;
}

export interface FeaturedAlbum {
  id: string;
  title: string;
  artistCredit: string | null;
  coverUrl: string | null;
}

/** 홈에 보여줄 추천 앨범 (발매일 내림차순). */
export async function getFeaturedAlbums(
  db: SupabaseClient,
  limit = 6,
): Promise<FeaturedAlbum[]> {
  const { data: albums } = await db
    .from("albums")
    .select("id, title, artist_credit")
    .order("first_release_date", { ascending: false, nullsFirst: false })
    .limit(limit);
  if (!albums || albums.length === 0) return [];

  const ids = albums.map((a) => a.id as string);
  const { data: assets } = await db
    .from("media_assets")
    .select("entity_id, source_url")
    .eq("entity_type", "ALBUM")
    .eq("asset_type", "ALBUM_COVER")
    .in("entity_id", ids);
  const coverById = new Map(
    (assets ?? []).map((r) => [r.entity_id as string, r.source_url as string]),
  );

  return albums.map((a) => ({
    id: a.id as string,
    title: a.title as string,
    artistCredit: (a.artist_credit as string | null) ?? null,
    coverUrl: coverById.get(a.id as string) ?? null,
  }));
}

export interface ArtistAlbumHit {
  id: string;
  title: string;
  firstReleaseDate: string | null;
  primaryType: string | null;
  coverUrl: string | null;
}

export interface ArtistDetail {
  id: string;
  name: string;
  type: string | null;
  country: string | null;
  lifeBegin: string | null;
  lifeEnd: string | null;
  disambiguation: string | null;
  albums: ArtistAlbumHit[];
}

/** 아티스트 상세 + 앨범 목록 (발매일 내림차순). */
export async function getArtistDetail(
  db: SupabaseClient,
  artistId: string,
): Promise<ArtistDetail | null> {
  if (!UUID_RE.test(artistId)) return null;

  const { data: artist } = await db
    .from("artists")
    .select("id, name, type, country, life_begin, life_end, disambiguation")
    .eq("id", artistId)
    .single();
  if (!artist) return null;

  const { data: links } = await db
    .from("album_artists")
    .select("albums(id, title, first_release_date, primary_type)")
    .eq("artist_id", artistId);
  const albumsRaw = (links ?? [])
    .map((l) => l.albums as unknown)
    .map((a) => (Array.isArray(a) ? a[0] : a))
    .filter(Boolean) as {
    id: string;
    title: string;
    first_release_date: string | null;
    primary_type: string | null;
  }[];
  // 발매일 내림차순 (날짜 없으면 뒤로)
  albumsRaw.sort((a, b) =>
    (b.first_release_date ?? "").localeCompare(a.first_release_date ?? ""),
  );

  // 승인된 커버만 RLS로 읽힌다
  const albumIds = albumsRaw.map((a) => a.id);
  let coverByAlbum = new Map<string, string>();
  if (albumIds.length > 0) {
    const { data: assets } = await db
      .from("media_assets")
      .select("entity_id, source_url")
      .eq("entity_type", "ALBUM")
      .eq("asset_type", "ALBUM_COVER")
      .in("entity_id", albumIds);
    coverByAlbum = new Map(
      (assets ?? []).map((r) => [
        r.entity_id as string,
        r.source_url as string,
      ]),
    );
  }

  return {
    id: artist.id as string,
    name: artist.name as string,
    type: (artist.type as string | null) ?? null,
    country: (artist.country as string | null) ?? null,
    lifeBegin: (artist.life_begin as string | null) ?? null,
    lifeEnd: (artist.life_end as string | null) ?? null,
    disambiguation: (artist.disambiguation as string | null) ?? null,
    albums: albumsRaw.map((a) => ({
      id: a.id,
      title: a.title,
      firstReleaseDate: a.first_release_date,
      primaryType: a.primary_type,
      coverUrl: coverByAlbum.get(a.id) ?? null,
    })),
  };
}
