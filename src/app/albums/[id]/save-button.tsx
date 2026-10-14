"use client";

import { useActionState } from "react";
import {
  saveToWalkie,
  type WalkieActionState,
} from "@/server/modules/walkie/actions";

const empty: WalkieActionState = {};

/** 앨범 페이지의 담기 버튼. 이미 담겨 있으면 비활성화. */
export function SaveAlbumButton({
  albumId,
  initiallySaved,
}: {
  albumId: string;
  initiallySaved: boolean;
}) {
  const [state, formAction, pending] = useActionState(saveToWalkie, empty);
  const saved = initiallySaved || state.done === true;

  if (saved) {
    return (
      <span className="rounded-lg border border-neutral-300 px-4 py-2 text-sm text-neutral-500">
        Walkie에 있음
      </span>
    );
  }

  return (
    <form action={formAction} className="flex flex-col gap-1">
      <input type="hidden" name="entityType" value="ALBUM" />
      <input type="hidden" name="entityId" value={albumId} />
      <button
        type="submit"
        disabled={pending}
        className="rounded-lg bg-neutral-900 px-4 py-2 text-sm font-medium text-white hover:bg-neutral-700 disabled:opacity-50"
      >
        {pending ? "담는 중…" : "Walkie에 담기"}
      </button>
      {state.error && (
        <span className="text-xs text-red-600" role="alert">
          {state.error}
        </span>
      )}
    </form>
  );
}
