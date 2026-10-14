"use client";

import { useState } from "react";
import { resolveVideoId } from "@/server/modules/playback/actions";
import { usePlayer } from "./player-context";

/** 곡 재생 버튼. 클릭 시 YouTube video ID를 resolve하고 하단 플레이어에서 재생. */
export function PlayButton({
  songId,
  title,
  artist,
}: {
  songId: string;
  title: string;
  artist: string;
}) {
  const { play } = usePlayer();
  const [state, setState] = useState<"idle" | "loading" | "failed">("idle");

  async function handlePlay() {
    if (state === "loading") return;
    setState("loading");
    try {
      const result = await resolveVideoId(songId);
      if (result.videoId) {
        play({
          videoId: result.videoId,
          title: result.title || title,
          artist: result.artist || artist,
        });
        setState("idle");
      } else {
        setState("failed");
      }
    } catch {
      setState("failed");
    }
  }

  if (state === "failed") {
    return (
      <span className="text-xs text-neutral-400" title="재생할 영상을 찾지 못했어요">
        —
      </span>
    );
  }

  return (
    <button
      type="button"
      onClick={handlePlay}
      disabled={state === "loading"}
      aria-label={`${title} 재생`}
      className="flex h-8 w-8 shrink-0 items-center justify-center rounded-full border border-neutral-200 text-sm hover:bg-neutral-900 hover:text-white disabled:opacity-50"
    >
      {state === "loading" ? "…" : "▶"}
    </button>
  );
}
