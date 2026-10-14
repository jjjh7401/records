/**
 * Phase C MusicBrainz 인제스트 스크립트.
 *
 * MusicBrainz에서 아티스트/앨범/발매/곡 데이터를 가져와
 * 멱등한 SQL(INSERT ... ON CONFLICT DO NOTHING)로 출력한다.
 *
 * 직접 DB에 쓰지 않는 이유:
 * 1. 이 VM의 egress proxy가 POST를 막아 API 직접 쓰기가 불가 (환경 문제)
 * 2. "AI가 후보를 만들고 인간이 승인" 원칙 — SQL을 리뷰 후 적용
 *
 * 사용법:
 *   npx tsx scripts/ingest-mb.ts --release-group <MBID> --out seed.sql
 *   (또는 다른 스크립트에서 ingestReleaseGroup()을 import)
 *
 * MusicBrainz 예절: 초당 1요청, 의미 있는 User-Agent 필수.
 */

import { randomUUID } from "node:crypto";
import { writeFileSync } from "node:fs";

export const UA = "RECORDS-MVP/0.1 (J-POP discovery service; contact: records-app)";
const MB = "https://musicbrainz.org/ws/2";
const CAA = "https://coverartarchive.org";

export const sleep = (ms: number) => new Promise((r) => setTimeout(r, ms));

export async function mb(path: string): Promise<any> {
  await sleep(1100); // rate limit: 1 req/sec
  const res = await fetch(`${MB}${path}`, {
    headers: { "User-Agent": UA, Accept: "application/json" },
  });
  if (!res.ok) throw new Error(`MB ${res.status}: ${path}`);
  return res.json();
}

/** SQL text 이스케이프 */
function q(v: string | null | undefined): string {
  if (v === null || v === undefined) return "NULL";
  return `'${v.replace(/'/g, "''")}'`;
}
function qn(v: number | null | undefined): string {
  if (v === null || v === undefined) return "NULL";
  return String(v);
}
function qd(v: string | null | undefined): string {
  // 'YYYY-MM-DD'만 date로, 그 외(연도만 등)는 NULL
  if (v && /^\d{4}-\d{2}-\d{2}$/.test(v)) return `'${v}'`;
  return "NULL";
}
function datePrecision(v: string | null | undefined): string {
  if (!v) return "NULL";
  if (/^\d{4}-\d{2}-\d{2}$/.test(v)) return "'day'";
  if (/^\d{4}-\d{2}$/.test(v)) return "'month'";
  if (/^\d{4}$/.test(v)) return "'year'";
  return "NULL";
}

interface Credit {
  name: string;
  joinphrase?: string;
  artist?: { id: string; name: string; "sort-name"?: string; type?: string };
}
function creditString(credits: Credit[] | undefined): string | null {
  if (!credits?.length) return null;
  return credits.map((c) => c.name + (c.joinphrase ?? "")).join("");
}

function artistType(t: string | undefined): string {
  if (t === "Person") return "'PERSON'";
  if (t === "Group") return "'GROUP'";
  return "'OTHER'";
}

export interface IngestResult {
  title: string;
  trackCount: number;
  statements: string[];
}

/**
 * release-group MBID 하나로 아티스트/앨범/발매/전곡을 인제스트한다.
 * 반환된 statements를 순서대로 실행하면 된다 (멱등).
 */
export async function ingestReleaseGroup(
  rgMbid: string,
  opts: { lean?: boolean } = {},
): Promise<IngestResult> {
  const sql: string[] = [];
  const seen = new Set<string>();
  const emit = (key: string, stmt: string) => {
    if (seen.has(key)) return;
    seen.add(key);
    sql.push(stmt);
  };

  async function ingestArtist(mbid: string): Promise<string> {
    const a = await mb(`/artist/${mbid}?fmt=json&inc=aliases`);
    const id = randomUUID();
    emit(`artist:${mbid}`, `INSERT INTO public.artists (id, mbid, name, sort_name, type, country, life_begin, life_end, disambiguation)
VALUES ('${id}', '${mbid}', ${q(a.name)}, ${q(a["sort-name"])}, ${artistType(a.type)}, ${q(a.country)}, ${q(a["life-span"]?.begin)}, ${q(a["life-span"]?.end)}, ${q(a.disambiguation)})
ON CONFLICT (mbid) DO NOTHING;`);
    emit(`xid:artist:${mbid}`, `INSERT INTO public.external_ids (id, entity_type, entity_id, provider, external_id, url, status)
SELECT '${randomUUID()}', 'ARTIST', artists.id, 'MUSICBRAINZ', '${mbid}', 'https://musicbrainz.org/artist/${mbid}', 'MATCHED'
FROM public.artists WHERE mbid = '${mbid}'
ON CONFLICT (entity_type, entity_id, provider, external_id) DO NOTHING;`);
    return id;
  }

  // 1. release-group + artists + releases
  const rg: any = await mb(`/release-group/${rgMbid}?fmt=json&inc=artists+releases`);
  const rgId = randomUUID();
  const rgCredit = creditString(rg["artist-credit"]);
  const primaryArtist = rg["artist-credit"]?.[0]?.artist;

  // 2. 아티스트 (주 아티스트만; feat 등은 곡 레벨에서)
  if (primaryArtist) await ingestArtist(primaryArtist.id);

  // 3. 앨범 (release-group)
  emit(
    `album:${rgMbid}`,
    `INSERT INTO public.albums (id, mbid, title, artist_credit, primary_type, first_release_date)
VALUES ('${rgId}', '${rgMbid}', ${q(rg.title)}, ${q(rgCredit)}, ${q(rg["primary-type"])}, ${qd(rg["first-release-date"])})
ON CONFLICT (mbid) DO NOTHING;`,
  );
  if (primaryArtist) {
    emit(
      `albumartist:${rgMbid}:${primaryArtist.id}`,
      `INSERT INTO public.album_artists (album_id, artist_id, position)
SELECT a.id, ar.id, 0 FROM public.albums a, public.artists ar
WHERE a.mbid = '${rgMbid}' AND ar.mbid = '${primaryArtist.id}'
ON CONFLICT (album_id, artist_id) DO NOTHING;`,
    );
  }
  emit(`xid:album:${rgMbid}`, `INSERT INTO public.external_ids (id, entity_type, entity_id, provider, external_id, url, status)
SELECT '${randomUUID()}', 'ALBUM', albums.id, 'MUSICBRAINZ', '${rgMbid}', 'https://musicbrainz.org/release-group/${rgMbid}', 'MATCHED'
FROM public.albums WHERE mbid = '${rgMbid}'
ON CONFLICT (entity_type, entity_id, provider, external_id) DO NOTHING;`);

  // 4. Cover Art Archive 확인 → media_assets (NEEDS_REVIEW: 인간 승인 전)
  try {
    await sleep(1100);
    const caa = await fetch(`${CAA}/release-group/${rgMbid}`, {
      headers: { "User-Agent": UA },
      redirect: "manual",
    });
    if (caa.status === 307 || caa.status === 200) {
      emit(
        `caa:${rgMbid}`,
        `INSERT INTO public.media_assets (id, entity_type, entity_id, asset_type, source_type, source_url, rights_type, status)
SELECT '${randomUUID()}', 'ALBUM', albums.id, 'ALBUM_COVER', 'COVER_ART_ARCHIVE', '${CAA}/release-group/${rgMbid}/front', 'QUOTATION_ONLY', 'NEEDS_REVIEW'
FROM public.albums WHERE mbid = '${rgMbid}'
AND NOT EXISTS (SELECT 1 FROM public.media_assets ma JOIN public.albums a2 ON ma.entity_id = a2.id
  WHERE ma.entity_type = 'ALBUM' AND a2.mbid = '${rgMbid}' AND ma.source_url = '${CAA}/release-group/${rgMbid}/front');`,
      );
    }
  } catch {
    // CAA 확인 실패는 무시하고 계속
  }

  // 5. 발매 선택: Official + JP 우선, 날짜 가장 빠름
  const releases: any[] = rg.releases ?? [];
  const sorted = [...releases].sort((x, y) => {
    const score = (r: any) =>
      (r.status === "Official" ? 0 : 1) * 10 + (r.country === "JP" ? 0 : 1);
    return score(x) - score(y) || String(x.date).localeCompare(String(y.date));
  });
  const rel = sorted[0];
  if (!rel) throw new Error(`no releases found for ${rgMbid}`);

  const relId = randomUUID();
  const relDetail: any = await mb(`/release/${rel.id}?fmt=json&inc=recordings+artists+isrcs`);
  const relCredit = creditString(relDetail["artist-credit"]) ?? rgCredit;
  emit(
    `release:${rel.id}`,
    `INSERT INTO public.releases (id, mbid, album_id, title, status, country, release_date, release_date_precision, barcode, language, script)
SELECT '${relId}', '${rel.id}', albums.id, ${q(relDetail.title)}, ${q(relDetail.status)}, ${q(relDetail.country)}, ${qd(relDetail.date)}, ${datePrecision(relDetail.date)}, ${q(relDetail.barcode)}, ${q(relDetail["text-representation"]?.language)}, ${q(relDetail["text-representation"]?.script)}
FROM public.albums WHERE mbid = '${rgMbid}'
ON CONFLICT (mbid) DO NOTHING;`,
  );
  emit(`xid:release:${rel.id}`, `INSERT INTO public.external_ids (id, entity_type, entity_id, provider, external_id, url, status)
SELECT '${randomUUID()}', 'RELEASE', releases.id, 'MUSICBRAINZ', '${rel.id}', 'https://musicbrainz.org/release/${rel.id}', 'MATCHED'
FROM public.releases WHERE mbid = '${rel.id}'
ON CONFLICT (entity_type, entity_id, provider, external_id) DO NOTHING;`);

  // 6. 트랙 + 곡
  let trackCount = 0;
  for (const medium of relDetail.media ?? []) {
    for (const t of medium.tracks ?? []) {
      const rec = t.recording;
      if (!rec) continue;
      const songId = randomUUID();
      const songCredit = creditString(rec["artist-credit"]) ?? relCredit;
      emit(
        `song:${rec.id}`,
        `INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('${songId}', '${rec.id}', ${q(rec.title)}, ${q(songCredit)}, ${qn(rec.length)})
ON CONFLICT (mbid) DO NOTHING;`,
      );
      // 곡-아티스트
      let pos = 0;
      for (const c of rec["artist-credit"] ?? []) {
        if (!c.artist) continue;
        await ingestArtist(c.artist.id);
        emit(
          `songartist:${rec.id}:${c.artist.id}`,
          `INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, ${pos === 0 ? "'primary'" : "'featured'"}, ${pos} FROM public.songs s, public.artists ar
WHERE s.mbid = '${rec.id}' AND ar.mbid = '${c.artist.id}'
ON CONFLICT (song_id, artist_id) DO NOTHING;`,
        );
        pos++;
      }
      // ISRC → external_ids
      for (const isrc of rec.isrcs ?? []) {
        emit(
          `isrc:${rec.id}:${isrc}`,
          `INSERT INTO public.external_ids (id, entity_type, entity_id, provider, external_id, status, metadata)
SELECT '${randomUUID()}', 'SONG', songs.id, 'MUSICBRAINZ', '${isrc}', 'MATCHED', '{"kind":"isrc"}'
FROM public.songs WHERE mbid = '${rec.id}'
ON CONFLICT (entity_type, entity_id, provider, external_id) DO NOTHING;`,
        );
      }
      emit(`xid:song:${rec.id}`, `INSERT INTO public.external_ids (id, entity_type, entity_id, provider, external_id, url, status)
SELECT '${randomUUID()}', 'SONG', songs.id, 'MUSICBRAINZ', '${rec.id}', 'https://musicbrainz.org/recording/${rec.id}', 'MATCHED'
FROM public.songs WHERE mbid = '${rec.id}'
ON CONFLICT (entity_type, entity_id, provider, external_id) DO NOTHING;`);
      // 트랙
      emit(
        `track:${rel.id}:${medium.position}:${t.position}`,
        `INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '${randomUUID()}', r.id, s.id, ${t.position}, ${medium.position ?? 1}, ${q(t.title !== rec.title ? t.title : null)}, ${qn(t.length ?? rec.length)}
FROM public.releases r, public.songs s WHERE r.mbid = '${rel.id}' AND s.mbid = '${rec.id}'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;`,
      );
      trackCount++;
    }
  }

  return { title: `${rgCredit} - ${rg.title}`, trackCount, statements: sql };
}

async function main() {
  const args = process.argv.slice(2);
  const rgMbid = args[args.indexOf("--release-group") + 1];
  const out = args[args.indexOf("--out") + 1];
  if (!rgMbid || !out) {
    console.error("Usage: npx tsx scripts/ingest-mb.ts --release-group <MBID> --out <file.sql>");
    process.exit(1);
  }
  const { title, trackCount, statements } = await ingestReleaseGroup(rgMbid);
  const header = [
    "-- Phase C seed: generated by scripts/ingest-mb.ts (idempotent)",
    "-- Source: MusicBrainz (canonical). Review before applying.",
    "",
  ];
  writeFileSync(out, header.join("\n") + statements.join("\n") + "\n");
  console.log(`Done: ${title} — ${trackCount} tracks, ${statements.length} statements -> ${out}`);
}

// 직접 실행될 때만 main() 호출 (import 시에는 호출 안 함)
if (process.argv[1]?.endsWith("ingest-mb.ts")) {
  main().catch((e) => {
    console.error("FAILED:", e.message);
    process.exit(1);
  });
}
