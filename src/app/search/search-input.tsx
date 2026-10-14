"use client";

import { useEffect, useRef, useState } from "react";
import { useRouter } from "next/navigation";

/**
 * 디바운스 검색 입력.
 * - 입력이 400ms 멈추면 /search?q=... 로 이동한다.
 * - IME 조합 중(한글/일본어 입력)에는 검색을 트리거하지 않고,
 *   조합이 끝난 뒤에 실행한다.
 */
export function SearchInput({ initialQuery }: { initialQuery: string }) {
  const router = useRouter();
  const [value, setValue] = useState(initialQuery);
  const [commit, setCommit] = useState(0);
  const composing = useRef(false);

  // 검색 실행 후 서버에서 내려온 q와 동기화 (같은 값이면 변화 없음)
  useEffect(() => {
    setValue(initialQuery);
  }, [initialQuery]);

  useEffect(() => {
    if (composing.current) return;
    const t = setTimeout(() => {
      const q = value.trim();
      router.push(q ? `/search?q=${encodeURIComponent(q)}` : "/search");
    }, 400);
    return () => clearTimeout(t);
  }, [value, commit, router]);

  return (
    <form
      role="search"
      onSubmit={(e) => {
        e.preventDefault();
        const q = value.trim();
        router.push(q ? `/search?q=${encodeURIComponent(q)}` : "/search");
      }}
    >
      <input
        type="search"
        value={value}
        onChange={(e) => setValue(e.target.value)}
        onCompositionStart={() => {
          composing.current = true;
        }}
        onCompositionEnd={() => {
          composing.current = false;
          // 같은 값이면 effect가 재실행되지 않으므로 토큰으로 깨운다
          setCommit((c) => c + 1);
        }}
        placeholder="곡, 아티스트, 앨범 검색"
        autoComplete="off"
        aria-label="음악 검색"
        className="w-full rounded-xl border border-neutral-300 bg-white px-4 py-3 text-base outline-none placeholder:text-neutral-400 focus:border-neutral-900"
      />
    </form>
  );
}
