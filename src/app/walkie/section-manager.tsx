"use client";

import { useActionState, useRef } from "react";
import {
  createSection,
  deleteSection,
  type WalkieActionState,
} from "@/server/modules/walkie/actions";

const empty: WalkieActionState = {};

/** 새 섹션 만들기 폼. */
export function CreateSectionForm() {
  const [state, formAction, pending] = useActionState(createSection, empty);
  const inputRef = useRef<HTMLInputElement>(null);

  return (
    <form
      action={async (fd) => {
        await formAction(fd);
        if (inputRef.current) inputRef.current.value = "";
      }}
      className="flex gap-2"
    >
      <input
        ref={inputRef}
        type="text"
        name="name"
        placeholder="새 섹션 이름 (예: ANIME)"
        maxLength={30}
        aria-label="새 섹션 이름"
        className="min-w-0 flex-1 rounded-lg border border-neutral-300 px-3 py-2 text-sm outline-none placeholder:text-neutral-400 focus:border-neutral-900"
      />
      <button
        type="submit"
        disabled={pending}
        className="shrink-0 rounded-lg bg-neutral-900 px-4 py-2 text-sm font-medium text-white hover:bg-neutral-700 disabled:opacity-50"
      >
        {pending ? "만드는 중…" : "만들기"}
      </button>
      {state.error && (
        <span className="self-center text-xs text-red-600" role="alert">
          {state.error}
        </span>
      )}
    </form>
  );
}

/** 섹션 삭제 버튼. */
export function DeleteSectionButton({ sectionId }: { sectionId: string }) {
  const [state, formAction, pending] = useActionState(deleteSection, empty);
  return (
    <form action={formAction} className="inline">
      <input type="hidden" name="sectionId" value={sectionId} />
      <button
        type="submit"
        disabled={pending}
        onClick={(e) => {
          if (!window.confirm("섹션을 삭제할까요? 안의 음악도 함께 사라져요.")) {
            e.preventDefault();
          }
        }}
        className="text-xs text-neutral-400 hover:text-red-600"
      >
        삭제
      </button>
      {state.error && (
        <span className="ml-2 text-xs text-red-600" role="alert">
          {state.error}
        </span>
      )}
    </form>
  );
}
