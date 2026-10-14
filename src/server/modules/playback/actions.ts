"use server";

import { createClient } from "@/lib/supabase/server";
import { searchYouTube } from "./youtube";

/**
 * 곡의 YouTube video ID를 resolve.
 * 1. external_ids에 YOUTUBE(MATCHED/MANUAL/PENDING_REVIEW)가 있으면 그대로 반환.
 * 2. 없으면 YouTube 검색 1회 → 저장 후 반환 (lazy 매칭, D-017 변형).
 * 3. 실패하면 FAILED 기록 후 null.
 */
export async function resolveVideoId(songId: string): Promise<{
  videoId: string | null;
  title: string;
  artist: string;
}> {
  const supabase = await createClient();

  const { data: song } = await supabase
    .from("songs")
    .select("id, title, artist_credit")
    .eq("id", songId)
    .single();
  if (!song) return { videoId: null, title: "", artist: "" };

  const title = song.title as string;
  const artist = (song.artist_credit as string | null) ?? "";

  // 1. 기존 매칭 확인 (service role 우회 없이 RLS 공개 읽기).
  const { data: existing } = await supabase
    .from("external_ids")
    .select("external_id")
    .eq("entity_type", "SONG")
    .eq("entity_id", songId)
    .eq("provider", "YOUTUBE")
    .in("status", ["MATCHED", "MANUAL", "PENDING_REVIEW"])
    .order("confidence", { ascending: false, nullsFirst: false })
    .limit(1)
    .maybeSingle();
  if (existing) {
    return { videoId: existing.external_id as string, title, artist };
  }

  // 2. lazy 매칭.
  const match = await searchYouTube(artist, title);
  if (match) {
    // 매칭 결과 저장 (service role이 있을 때만; 없으면 재생만 하고 저장은 생략).
    try {
      const { createServiceClient } = await import("@/lib/supabase/service");
      const admin = createServiceClient();
      await admin.from("external_ids").upsert(
        {
          entity_type: "SONG",
          entity_id: songId,
          provider: "YOUTUBE",
          external_id: match.videoId,
          url: match.url,
          confidence: match.confidence,
          status: match.status,
          metadata: {
            title: match.title,
            channel_title: match.channelTitle,
            matched_at: new Date().toISOString(),
          },
          retrieved_at: new Date().toISOString(),
        },
        { onConflict: "entity_type,entity_id,provider,external_id" },
      );
    } catch {
      // service role 미설정(로컬 더미 키 등)이면 저장 생략.
    }
    return { videoId: match.videoId, title, artist };
  }

  return { videoId: null, title, artist };
}
