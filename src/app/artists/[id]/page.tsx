import Link from "next/link";
import { notFound } from "next/navigation";
import { createClient } from "@/lib/supabase/server";
import { getArtistDetail } from "@/server/modules/catalog/queries";

// 아티스트 ID에 따라 렌더링되므로 서버에서 블로킹 렌더링
export const instant = false;

export default async function ArtistPage({
  params,
}: {
  params: Promise<{ id: string }>;
}) {
  const { id } = await params;

  let artist = null;
  try {
    const supabase = await createClient();
    artist = await getArtistDetail(supabase, id);
  } catch {
    artist = null;
  }
  if (!artist) notFound();

  const meta = [
    artist.type,
    artist.country,
    [artist.lifeBegin, artist.lifeEnd].filter(Boolean).join(" – ") || null,
  ].filter(Boolean);

  return (
    <main className="mx-auto min-h-screen w-full max-w-2xl px-6 py-10">
      <Link
        href="/search"
        className="text-sm text-neutral-500 hover:text-neutral-900"
      >
        ← 검색으로 돌아가기
      </Link>

      <div className="mt-6">
        <h1 className="text-2xl font-bold tracking-tight">{artist.name}</h1>
        {meta.length > 0 && (
          <p className="mt-1 text-sm text-neutral-500">{meta.join(" · ")}</p>
        )}
        {artist.disambiguation && (
          <p className="mt-1 text-sm text-neutral-400">
            {artist.disambiguation}
          </p>
        )}
      </div>

      <section aria-label="앨범 목록" className="mt-8">
        <h2 className="mb-3 text-sm font-semibold tracking-wide text-neutral-500">
          앨범 {artist.albums.length}
        </h2>
        {artist.albums.length > 0 ? (
          <ul className="flex flex-col gap-3">
            {artist.albums.map((a) => (
              <li
                key={a.id}
                className="rounded-xl border border-neutral-200 last:border-neutral-200"
              >
                <Link
                  href={`/albums/${a.id}`}
                  className="flex gap-4 p-4 hover:bg-neutral-50"
                >
                  {a.coverUrl ? (
                    <img
                      src={a.coverUrl}
                      alt={`${a.title} 커버 아트`}
                      loading="lazy"
                      className="h-16 w-16 shrink-0 rounded-lg border border-neutral-100 bg-neutral-50 object-cover"
                    />
                  ) : (
                    <div className="flex h-16 w-16 shrink-0 items-center justify-center rounded-lg border border-neutral-200 bg-neutral-50 text-[10px] text-neutral-400">
                      검토 중
                    </div>
                  )}
                  <div className="flex min-w-0 flex-col justify-center">
                    <p className="truncate font-medium">{a.title}</p>
                    <p className="mt-0.5 text-sm text-neutral-500">
                      {[
                        a.firstReleaseDate?.slice(0, 4),
                        a.primaryType,
                      ]
                        .filter(Boolean)
                        .join(" · ")}
                    </p>
                  </div>
                </Link>
              </li>
            ))}
          </ul>
        ) : (
          <p className="text-sm text-neutral-500">
            앨범 정보를 불러오지 못했어요.
          </p>
        )}
      </section>
    </main>
  );
}
