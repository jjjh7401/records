import "server-only";
import type { SupabaseClient } from "@supabase/supabase-js";

/**
 * 카탈로그 검색 모듈.
 *
 * - 공개 카탈로그(songs/artists/albums)에 대한 읽기 전용 검색.
 * - 호출자는 RLS가 적용되는 Supabase 서버 클라이언트를 전달한다.
 * - 일본어/한국어 텍스트가 섞여 있어 full-text 대신 ILIKE 부분 일치를 사용한다.
 *   카탈로그가 커지면 pg_trgm 인덱스 추가를 검토한다.
 */

export interface SongHit {
  id: string;
  title: string;
  artistCredit: string | null;
}

export interface ArtistHit {
  id: string;
  name: string;
  type: string | null;
}

export interface AlbumHit {
  id: string;
  title: string;
  artistCredit: string | null;
  firstReleaseDate: string | null;
}

export interface SearchResults {
  songs: SongHit[];
  artists: ArtistHit[];
  albums: AlbumHit[];
}

/** ILIKE 와일드카드(%, _)와 이스케이프(\)를 리터럴로 처리한다. */
function escapeIlike(raw: string): string {
  return raw.replace(/[\\%_]/g, (m) => `\\${m}`);
}

const SONG_LIMIT = 20;
const ARTIST_LIMIT = 10;
const ALBUM_LIMIT = 10;

export async function searchCatalog(
  db: SupabaseClient,
  query: string,
): Promise<SearchResults> {
  const q = query.trim();
  if (!q) {
    return { songs: [], artists: [], albums: [] };
  }
  const pattern = `%${escapeIlike(q)}%`;

  // 곡: 제목 또는 아티스트 크레딧에 검색어 포함 (2개 쿼리 후 합침)
  const [songsByTitle, songsByArtist, artistsRes, albumsRes] = await Promise.all([
    db
      .from("songs")
      .select("id, title, artist_credit")
      .ilike("title", pattern)
      .order("title")
      .limit(SONG_LIMIT),
    db
      .from("songs")
      .select("id, title, artist_credit")
      .ilike("artist_credit", pattern)
      .order("title")
      .limit(SONG_LIMIT),
    db
      .from("artists")
      .select("id, name, type")
      .ilike("name", pattern)
      .order("name")
      .limit(ARTIST_LIMIT),
    db
      .from("albums")
      .select("id, title, artist_credit, first_release_date")
      .ilike("title", pattern)
      .order("title")
      .limit(ALBUM_LIMIT),
  ]);

  // Supabase 장애 시에도 페이지는 렌더링한다 (D-014). 에러는 빈 결과로 처리.
  // 곡은 제목/아티스트 매칭 결과를 합치고 중복 제거
  const songMap = new Map<string, SongHit>();
  for (const r of [...(songsByTitle.data ?? []), ...(songsByArtist.data ?? [])]) {
    if (!songMap.has(r.id)) {
      songMap.set(r.id, {
        id: r.id,
        title: r.title,
        artistCredit: r.artist_credit,
      });
    }
  }
  const songs = [...songMap.values()]
    .sort((a, b) => a.title.localeCompare(b.title))
    .slice(0, SONG_LIMIT);

  return {
    songs,
    artists: (artistsRes.data ?? []).map((r) => ({
      id: r.id,
      name: r.name,
      type: r.type,
    })),
    albums: (albumsRes.data ?? []).map((r) => ({
      id: r.id,
      title: r.title,
      artistCredit: r.artist_credit,
      firstReleaseDate: r.first_release_date,
    })),
  };
}

/** 검색어 없이 들어왔을 때 보여줄 아티스트 둘러보기. */
export async function listArtists(db: SupabaseClient): Promise<ArtistHit[]> {
  const { data } = await db
    .from("artists")
    .select("id, name, type")
    .order("name")
    .limit(50);
  return (data ?? []).map((r) => ({
    id: r.id,
    name: r.name,
    type: r.type,
  }));
}
