"use client";

import { useActionState, useState } from "react";
import {
  rateWalkieItem,
  removeFromWalkie,
  type WalkieActionState,
} from "@/server/modules/walkie/actions";
import type { WalkieItem } from "@/server/modules/walkie/queries";

const empty: WalkieActionState = {};

function RatingSlider({ item }: { item: WalkieItem }) {
  const [state, formAction] = useActionState(rateWalkieItem, empty);
  const [value, setValue] = useState<number>(item.rating ?? 0);
  return (
    <form action={formAction} className="flex items-center gap-2">
      <input type="hidden" name="itemId" value={item.id} />
      <input
        type="range"
        name="rating"
        min={0}
        max={5}
        step={0.5}
        value={value}
        onChange={(e) => setValue(Number(e.target.value))}
        aria-label={`${item.title} 평점`}
        className="w-28 accent-amber-500"
      />
      <span className="w-8 text-sm text-neutral-500">{value}</span>
      <button
        type="submit"
        className="rounded-lg border border-neutral-300 px-2 py-1 text-xs hover:bg-neutral-50"
      >
        평점
      </button>
      {state.error && (
        <span className="text-xs text-red-600" role="alert">
          {state.error}
        </span>
      )}
    </form>
  );
}

function RemoveButton({ itemId }: { itemId: string }) {
  const [state, formAction] = useActionState(removeFromWalkie, empty);
  return (
    <form action={formAction}>
      <input type="hidden" name="itemId" value={itemId} />
      <button
        type="submit"
        className="text-xs text-neutral-400 hover:text-red-600"
      >
        빼기
      </button>
      {state.error && (
        <span className="ml-2 text-xs text-red-600" role="alert">
          {state.error}
        </span>
      )}
    </form>
  );
}

/** 아이템별 평점 + 빼기. */
export function ItemActions({ item }: { item: WalkieItem }) {
  return (
    <div className="mt-3 flex items-center justify-between border-t border-neutral-100 pt-3">
      <RatingSlider item={item} />
      <RemoveButton itemId={item.id} />
    </div>
  );
}
