import Link from "next/link";
import { notFound } from "next/navigation";
import { createClient } from "@/lib/supabase/server";
import {
  formatDuration,
  getAlbumDetail,
} from "@/server/modules/catalog/queries";
import { isAlbumSaved } from "@/server/modules/walkie/queries";
import { SaveAlbumButton } from "./save-button";
import { PlayButton } from "../../play-button";

// 앨범 ID에 따라 렌더링되므로 서버에서 블로킹 렌더링
export const instant = false;

export default async function AlbumPage({
  params,
}: {
  params: Promise<{ id: string }>;
}) {
  const { id } = await params;

  // Supabase 장애 시에도 404가 아닌 빈 화면으로 (D-014)
  let album = null;
  let saved = false;
  try {
    const supabase = await createClient();
    album = await getAlbumDetail(supabase, id);
    if (album) {
      const { data } = await supabase.auth.getUser();
      if (data.user) saved = await isAlbumSaved(supabase, id);
    }
  } catch {
    album = null;
  }
  if (!album) notFound();

  const year = album.firstReleaseDate?.slice(0, 4);

  return (
    <main className="mx-auto min-h-screen w-full max-w-2xl px-6 py-10">
      <Link
        href="/search"
        className="text-sm text-neutral-500 hover:text-neutral-900"
      >
        ← 검색으로 돌아가기
      </Link>

      <div className="mt-6 flex gap-5">
        {album.coverUrl ? (
          // 제3자 아트워크는 자가 호스팅하지 않고 원본 URL을 참조만 한다 (D-006)
          <img
            src={album.coverUrl}
            alt={`${album.title} 커버 아트`}
            className="h-36 w-36 shrink-0 rounded-xl border border-neutral-100 bg-neutral-50 object-cover"
          />
        ) : (
          <div className="flex h-36 w-36 shrink-0 items-center justify-center rounded-xl border border-neutral-200 bg-neutral-50 text-xs text-neutral-400">
            커버 검토 중
          </div>
        )}
        <div className="flex min-w-0 flex-col justify-center">
          <h1 className="text-2xl font-bold tracking-tight">{album.title}</h1>
          {album.artistCredit && (
            <p className="mt-1 text-neutral-600">{album.artistCredit}</p>
          )}
          <p className="mt-1 text-sm text-neutral-400">
            {[year, album.primaryType].filter(Boolean).join(" · ")}
          </p>
          <div className="mt-3">
            <SaveAlbumButton albumId={album.id} initiallySaved={saved} />
          </div>
        </div>
      </div>

      <section aria-label="트랙리스트" className="mt-8">
        <h2 className="mb-3 text-sm font-semibold tracking-wide text-neutral-500">
          트랙 {album.tracks.length}
        </h2>
        {album.tracks.length > 0 ? (
          <ol>
            {album.tracks.map((t) => (
              <li
                key={`${t.discNumber}-${t.position}`}
                className="flex items-baseline gap-3 border-b border-neutral-100 py-3 last:border-0"
              >
                <span className="w-6 shrink-0 text-sm text-neutral-400">
                  {t.position}
                </span>
                <div className="min-w-0 flex-1">
                  <p className="truncate font-medium">{t.title}</p>
                  {t.artistCredit && (
                    <p className="mt-0.5 truncate text-sm text-neutral-500">
                      {t.artistCredit}
                    </p>
                  )}
                </div>
                <span className="shrink-0 text-sm text-neutral-400">
                  {formatDuration(t.lengthMs)}
                </span>
                <PlayButton
                  songId={t.songId}
                  title={t.title}
                  artist={t.artistCredit ?? ""}
                />
              </li>
            ))}
          </ol>
        ) : (
          <p className="text-sm text-neutral-500">
            트랙 정보를 불러오지 못했어요.
          </p>
        )}
      </section>
    </main>
  );
}
