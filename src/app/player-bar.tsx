"use client";

import { usePlayer } from "./player-context";

/**
 * 하단 고정 플레이어 (DOCK WALKIE).
 * - YouTube 공식 임베드를 그대로 보여준다: 플레이어를 가리거나
 *   YouTube 컨트롤을 RECORDS UI로 대체하지 않는다 (06 §2).
 * - Root layout에 있어 페이지 전환에도 재생 상태가 유지된다 (06 §3).
 */
export function PlayerBar() {
  const { nowPlaying, close } = usePlayer();
  if (!nowPlaying) return null;

  return (
    <div className="fixed inset-x-0 bottom-0 z-50 border-t border-neutral-200 bg-white/95 backdrop-blur">
      <div className="mx-auto flex max-w-2xl items-center gap-3 px-4 py-2">
        <div className="w-40 shrink-0 overflow-hidden rounded-lg bg-black sm:w-56">
          <iframe
            key={nowPlaying.videoId}
            src={`https://www.youtube.com/embed/${nowPlaying.videoId}?autoplay=1&rel=0`}
            title={`${nowPlaying.title} - ${nowPlaying.artist}`}
            allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
            allowFullScreen
            className="aspect-video w-full"
          />
        </div>
        <div className="min-w-0 flex-1">
          <p className="truncate text-sm font-medium">{nowPlaying.title}</p>
          {nowPlaying.artist && (
            <p className="truncate text-xs text-neutral-500">
              {nowPlaying.artist}
            </p>
          )}
          <a
            href={`https://www.youtube.com/watch?v=${nowPlaying.videoId}`}
            target="_blank"
            rel="noopener noreferrer"
            className="text-xs text-neutral-400 underline"
          >
            YouTube에서 보기
          </a>
        </div>
        <button
          type="button"
          onClick={close}
          aria-label="플레이어 닫기"
          className="shrink-0 rounded-full px-2 py-1 text-lg text-neutral-400 hover:bg-neutral-100 hover:text-neutral-900"
        >
          ×
        </button>
      </div>
    </div>
  );
}
