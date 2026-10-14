import Link from "next/link";
import { createClient } from "@/lib/supabase/server";
import {
  getWalkieItems,
  getWalkieSections,
  type WalkieItem,
} from "@/server/modules/walkie/queries";
import { ItemActions } from "./item-actions";
import { CreateSectionForm, DeleteSectionButton } from "./section-manager";
import { PlayButton } from "../play-button";

// 로그인 세션에 따라 렌더링되므로 서버에서 블로킹 렌더링
export const instant = false;

function WalkieRow({ item }: { item: WalkieItem }) {
  const body = (
    <>
      {item.coverUrl ? (
        <img
          src={item.coverUrl}
          alt=""
          loading="lazy"
          className="h-14 w-14 shrink-0 rounded-lg border border-neutral-100 bg-neutral-50 object-cover"
        />
      ) : (
        <div className="flex h-14 w-14 shrink-0 items-center justify-center rounded-lg border border-neutral-200 bg-neutral-50 text-[10px] text-neutral-400">
          {item.entityType === "ALBUM" ? "앨범" : "곡"}
        </div>
      )}
      <div className="min-w-0 flex-1">
        <p className="truncate font-medium">{item.title}</p>
        {item.subtitle && (
          <p className="mt-0.5 truncate text-sm text-neutral-500">
            {item.subtitle}
          </p>
        )}
        {item.rating != null && (
          <p className="mt-0.5 text-sm text-amber-500">
            {"★".repeat(Math.round(item.rating))}
            <span className="ml-1 text-neutral-400">{item.rating}</span>
          </p>
        )}
      </div>
    </>
  );

  return (
    <li className="rounded-xl border border-neutral-200 p-3">
      <div className="flex items-center gap-3">
        {item.albumId ? (
          <Link
            href={`/albums/${item.albumId}`}
            className="flex min-w-0 flex-1 items-center gap-3 hover:bg-neutral-50 rounded-lg"
          >
            {body}
          </Link>
        ) : (
          <div className="flex min-w-0 flex-1 items-center gap-3">{body}</div>
        )}
        {item.entityType === "SONG" && (
          <PlayButton
            songId={item.entityId}
            title={item.title}
            artist={item.subtitle ?? ""}
          />
        )}
      </div>
      <ItemActions item={item} />
    </li>
  );
}

export default async function WalkiePage() {
  const supabase = await createClient();
  const { data } = await supabase.auth.getUser();

  if (!data.user) {
    return (
      <main className="mx-auto flex min-h-screen w-full max-w-2xl flex-col justify-center px-6">
        <h1 className="text-2xl font-bold tracking-tight">Walkie</h1>
        <p className="mt-2 text-sm text-neutral-500">
          좋아하는 음악을 담으려면 로그인이 필요해요.
        </p>
        <div className="mt-6">
          <Link
            href="/login"
            className="rounded-lg bg-neutral-900 px-4 py-2 text-sm font-medium text-white"
          >
            로그인하기
          </Link>
        </div>
      </main>
    );
  }

  let sections: Awaited<ReturnType<typeof getWalkieSections>> = [];
  let itemsBySection = new Map<string, WalkieItem[]>();
  try {
    sections = await getWalkieSections(supabase);
    for (const s of sections) {
      itemsBySection.set(s.id, await getWalkieItems(supabase, s.id));
    }
  } catch {
    // 빈 상태로 렌더링
  }

  const totalItems = [...itemsBySection.values()].reduce(
    (n, items) => n + items.length,
    0,
  );

  return (
    <main className="mx-auto min-h-screen w-full max-w-2xl px-6 py-10">
      <div className="mb-6 flex items-center justify-between">
        <Link href="/" className="text-xl font-bold tracking-tight">
          RECORDS
        </Link>
        <span className="text-xs text-neutral-400">Walkie</span>
      </div>

      {totalItems === 0 ? (
        <div className="mt-16 text-center">
          <p className="font-medium">아직 담은 음악이 없어요</p>
          <p className="mt-1 text-sm text-neutral-500">
            검색 결과에서 곡을 담거나, 앨범 페이지에서 담기를 눌러 보세요.
          </p>
          <div className="mt-6">
            <Link
              href="/search"
              className="rounded-lg bg-neutral-900 px-4 py-2 text-sm font-medium text-white"
            >
              음악 찾으러 가기
            </Link>
          </div>
        </div>
      ) : (
        sections.map(
          (s) =>
            (itemsBySection.get(s.id)?.length ?? 0) > 0 && (
              <section key={s.id} aria-label={`${s.name} 섹션`} className="mb-8">
                <div className="mb-3 flex items-center justify-between">
                  <h2 className="text-sm font-semibold tracking-wide text-neutral-500">
                    {s.name} {s.itemCount}
                  </h2>
                  <DeleteSectionButton sectionId={s.id} />
                </div>
                <ul className="flex flex-col gap-3">
                  {itemsBySection.get(s.id)?.map((item) => (
                    <WalkieRow key={item.id} item={item} />
                  ))}
                </ul>
              </section>
            ),
        )
      )}

      <section aria-label="섹션 관리" className="mt-10 border-t border-neutral-200 pt-6">
        <h2 className="mb-3 text-sm font-semibold tracking-wide text-neutral-500">
          새 섹션 만들기
        </h2>
        <CreateSectionForm />
        <p className="mt-2 text-xs text-neutral-400">
          예: ANIME, CITY POP, ROCK — 취향대로 분류해 보세요.
        </p>
      </section>
    </main>
  );
}
