"use client";

import { useActionState } from "react";
import {
  approveAsset,
  rejectAsset,
  type ReviewActionState,
} from "@/server/modules/review/actions";

const initialState: ReviewActionState = {};

function DecisionForm({
  assetId,
  action,
  label,
  className,
}: {
  assetId: string;
  action: (
    prev: ReviewActionState,
    formData: FormData,
  ) => Promise<ReviewActionState>;
  label: string;
  className: string;
}) {
  const [state, formAction, pending] = useActionState(action, initialState);
  return (
    <form action={formAction} className="flex flex-col gap-1">
      <input type="hidden" name="assetId" value={assetId} />
      <button
        type="submit"
        disabled={pending}
        className={`rounded-lg px-4 py-2 text-sm font-medium disabled:opacity-50 ${className}`}
      >
        {pending ? "처리 중…" : label}
      </button>
      {state.error && (
        <p className="text-xs text-red-600" role="alert">
          {state.error}
        </p>
      )}
    </form>
  );
}

/** 승인/반려 버튼 쌍. 결정 후에는 revalidate로 목록에서 사라진다. */
export function DecisionButtons({ assetId }: { assetId: string }) {
  return (
    <div className="flex gap-2">
      <DecisionForm
        assetId={assetId}
        action={approveAsset}
        label="승인"
        className="bg-neutral-900 text-white hover:bg-neutral-700"
      />
      <DecisionForm
        assetId={assetId}
        action={rejectAsset}
        label="반려"
        className="border border-neutral-300 hover:bg-neutral-50"
      />
    </div>
  );
}
