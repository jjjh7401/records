/**
 * YouTube 매칭 (D-017).
 * - 재생 시점에 lazy 매칭: 곡에 YOUTUBE external_id가 없으면 search.list 1회 호출 후 저장.
 * - 공식 아티스트/레이블 채널 우선, confidence + 상태(MATCHED/PENDING_REVIEW/FAILED) 기록.
 * - 서버 전용. API 키는 절대 브라우저에 노출하지 않는다.
 */

const YT_API = "https://www.googleapis.com/youtube/v3";

export interface YTMatch {
  videoId: string;
  title: string;
  channelTitle: string;
  url: string;
  confidence: number;
  status: "MATCHED" | "PENDING_REVIEW";
}

interface YTSearchItem {
  id: { videoId: string };
  snippet: { title: string; channelTitle: string };
}

function normalize(s: string): string {
  return s
    .toLowerCase()
    .replace(/[\s　・\-_–—()（）\[\]「」『』"']/g, "");
}

/** 공식 채널처럼 보이는지 휴리스틱. */
function looksOfficial(channelTitle: string, artistCredit: string): boolean {
  const ch = channelTitle.toLowerCase();
  const artist = artistCredit.toLowerCase();
  if (ch.includes(artist) || artist.includes(ch.replace(/vevo|official|music|records/g, "").trim())) {
    return true;
  }
  return /official|vevo|records|music$/.test(ch);
}

export async function searchYouTube(
  artistCredit: string,
  songTitle: string,
): Promise<YTMatch | null> {
  const key = process.env.YOUTUBE_API_KEY;
  if (!key) return null;

  const q = `${artistCredit} ${songTitle}`.slice(0, 100);
  const url =
    `${YT_API}/search?part=snippet&type=video&maxResults=5&videoEmbeddable=true` +
    `&q=${encodeURIComponent(q)}&key=${encodeURIComponent(key)}`;

  let res: Response;
  try {
    res = await fetch(url, { next: { revalidate: 0 } });
  } catch {
    return null;
  }
  if (!res.ok) return null;

  const data = (await res.json()) as { items?: YTSearchItem[] };
  const items = data.items ?? [];
  if (items.length === 0) return null;

  // 제목에 곡명이 들어간 후보 중 공식 채널 우선.
  const normTitle = normalize(songTitle);
  const withTitle = items.filter((it) =>
    normalize(it.snippet.title).includes(normTitle),
  );
  const pool = withTitle.length > 0 ? withTitle : items;
  const official = pool.find((it) =>
    looksOfficial(it.snippet.channelTitle, artistCredit),
  );
  const pick = official ?? pool[0];

  const confidence = official ? 0.9 : 0.55;
  return {
    videoId: pick.id.videoId,
    title: pick.snippet.title,
    channelTitle: pick.snippet.channelTitle,
    url: `https://www.youtube.com/watch?v=${pick.id.videoId}`,
    confidence,
    status: confidence >= 0.8 ? "MATCHED" : "PENDING_REVIEW",
  };
}
