"use client";

import Link from "next/link";
import { useActionState, useState } from "react";
import {
  saveToWalkie,
  type WalkieActionState,
} from "@/server/modules/walkie/actions";
import type { WalkieSection } from "@/server/modules/walkie/queries";

const empty: WalkieActionState = {};

/**
 * 검색 결과 곡의 담기 버튼.
 * - 비로그인: 로그인 페이지로 안내
 * - 로그인: 섹션 선택 후 저장 (섹션 없으면 FAVORITES 자동 생성)
 */
export function SaveSongButton({
  songId,
  sections,
  loggedIn,
}: {
  songId: string;
  sections: WalkieSection[];
  loggedIn: boolean;
}) {
  const [open, setOpen] = useState(false);
  const [state, formAction, pending] = useActionState(saveToWalkie, empty);

  if (!loggedIn) {
    return (
      <Link
        href="/login"
        className="shrink-0 rounded-lg border border-neutral-300 px-3 py-1 text-xs hover:bg-neutral-50"
      >
        담기
      </Link>
    );
  }

  if (state.done) {
    return (
      <span className="shrink-0 rounded-lg border border-neutral-300 px-3 py-1 text-xs text-neutral-500">
        담음
      </span>
    );
  }

  return (
    <div className="relative shrink-0">
      <button
        type="button"
        onClick={() => setOpen((v) => !v)}
        className="rounded-lg border border-neutral-300 px-3 py-1 text-xs hover:bg-neutral-50"
        aria-expanded={open}
      >
        담기
      </button>
      {open && (
        <form
          action={formAction}
          className="absolute right-0 z-10 mt-1 w-40 rounded-xl border border-neutral-200 bg-white p-1 shadow-lg"
        >
          <input type="hidden" name="entityType" value="SONG" />
          <input type="hidden" name="entityId" value={songId} />
          {sections.length > 0 ? (
            sections.map((s) => (
              <button
                key={s.id}
                type="submit"
                name="sectionId"
                value={s.id}
                disabled={pending}
                className="block w-full rounded-lg px-3 py-2 text-left text-sm hover:bg-neutral-50 disabled:opacity-50"
              >
                {s.name}
              </button>
            ))
          ) : (
            <button
              type="submit"
              disabled={pending}
              className="block w-full rounded-lg px-3 py-2 text-left text-sm hover:bg-neutral-50 disabled:opacity-50"
            >
              FAVORITES에 담기
            </button>
          )}
          {state.error && (
            <p className="px-3 py-1 text-xs text-red-600" role="alert">
              {state.error}
            </p>
          )}
        </form>
      )}
    </div>
  );
}
