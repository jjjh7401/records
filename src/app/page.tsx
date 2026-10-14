import Link from "next/link";
import { createClient } from "@/lib/supabase/server";
import { signOut } from "@/server/modules/auth/actions";
import {
  getFeaturedAlbums,
  type FeaturedAlbum,
} from "@/server/modules/catalog/queries";
import { SearchInput } from "./search/search-input";

// 세션에 따라 렌더링되므로 서버에서 블로킹 렌더링 (Next.js 16 instant navigation opt-out)
export const instant = false;

function AlbumCard({ album }: { album: FeaturedAlbum }) {
  return (
    <Link
      href={`/albums/${album.id}`}
      className="group flex flex-col gap-2"
    >
      {album.coverUrl ? (
        <img
          src={album.coverUrl}
          alt={`${album.title} 커버 아트`}
          loading="lazy"
          className="aspect-square w-full rounded-xl border border-neutral-100 bg-neutral-50 object-cover"
        />
      ) : (
        <div className="flex aspect-square w-full items-center justify-center rounded-xl border border-neutral-200 bg-neutral-50 p-2 text-center text-xs text-neutral-400">
          {album.title}
        </div>
      )}
      <div className="min-w-0">
        <p className="truncate text-sm font-medium group-hover:underline">
          {album.title}
        </p>
        {album.artistCredit && (
          <p className="truncate text-xs text-neutral-500">
            {album.artistCredit}
          </p>
        )}
      </div>
    </Link>
  );
}

export default async function Home() {
  // Supabase 장애/설정 오류 시에도 랜딩은 렌더링한다 (D-014).
  let user = null;
  let featured: FeaturedAlbum[] = [];
  try {
    const supabase = await createClient();
    const { data } = await supabase.auth.getUser();
    user = data.user;
    featured = await getFeaturedAlbums(supabase, 6);
  } catch {
    user = null;
  }

  return (
    <main className="mx-auto min-h-screen w-full max-w-2xl px-6 pb-16">
      <header className="flex items-center justify-between py-6">
        <span className="text-xl font-bold tracking-tight">RECORDS</span>
        <nav className="flex items-center gap-4 text-sm">
          <Link href="/search" className="text-neutral-600 hover:text-neutral-900">
            검색
          </Link>
          <Link href="/walkie" className="text-neutral-600 hover:text-neutral-900">
            Walkie
          </Link>
          {user ? (
            <form action={signOut}>
              <button
                type="submit"
                className="text-neutral-600 hover:text-neutral-900"
              >
                로그아웃
              </button>
            </form>
          ) : (
            <Link
              href="/login"
              className="rounded-lg bg-neutral-900 px-3 py-1.5 font-medium text-white"
            >
              로그인
            </Link>
          )}
        </nav>
      </header>

      <section aria-label="소개" className="mt-8">
        <h1 className="text-3xl font-bold tracking-tight">
          좋아하는 음악을
          <br />
          모으고, 나누고, 기록하는 곳.
        </h1>
        <p className="mt-3 text-neutral-500">
          J-POP 발견 · 기록 · 큐레이션 플랫폼
        </p>
        <div className="mt-6">
          <SearchInput initialQuery="" />
        </div>
      </section>

      {featured.length > 0 && (
        <section aria-label="추천 앨범" className="mt-12">
          <div className="mb-4 flex items-baseline justify-between">
            <h2 className="text-sm font-semibold tracking-wide text-neutral-500">
              추천 앨범
            </h2>
            <Link
              href="/search"
              className="text-xs text-neutral-400 hover:text-neutral-900"
            >
              더 보기 →
            </Link>
          </div>
          <div className="grid grid-cols-2 gap-4 sm:grid-cols-3">
            {featured.map((a) => (
              <AlbumCard key={a.id} album={a} />
            ))}
          </div>
        </section>
      )}

      <section aria-label="바로가기" className="mt-12 grid grid-cols-2 gap-3">
        <Link
          href="/search"
          className="rounded-xl border border-neutral-200 p-5 hover:bg-neutral-50"
        >
          <p className="font-medium">카탈로그 검색</p>
          <p className="mt-1 text-sm text-neutral-500">
            27팀 · 315곡 둘러보기
          </p>
        </Link>
        <Link
          href="/walkie"
          className="rounded-xl border border-neutral-200 p-5 hover:bg-neutral-50"
        >
          <p className="font-medium">Walkie</p>
          <p className="mt-1 text-sm text-neutral-500">
            담고, 평점 매기고, 분류하기
          </p>
        </Link>
      </section>

      <footer className="mt-16 text-center text-xs text-neutral-400">
        RECORDS — J-POP 음악 도시
      </footer>
    </main>
  );
}
