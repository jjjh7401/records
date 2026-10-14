import Link from "next/link";
import { createClient } from "@/lib/supabase/server";
import {
  listArtists,
  searchCatalog,
  type AlbumHit,
  type ArtistHit,
  type SongHit,
} from "@/server/modules/search/queries";
import {
  getWalkieSections,
  type WalkieSection,
} from "@/server/modules/walkie/queries";
import { SearchInput } from "./search-input";
import { SaveSongButton } from "./save-song-button";
import { PlayButton } from "../play-button";

// 검색어에 따라 렌더링되므로 서버에서 블로킹 렌더링 (Next.js 16 instant navigation opt-out)
export const instant = false;

function SectionTitle({ children }: { children: React.ReactNode }) {
  return (
    <h2 className="mt-8 mb-3 text-sm font-semibold tracking-wide text-neutral-500">
      {children}
    </h2>
  );
}

function SongRow({
  song,
  sections,
  loggedIn,
}: {
  song: SongHit;
  sections: WalkieSection[];
  loggedIn: boolean;
}) {
  return (
    <li className="border-b border-neutral-100 py-3 last:border-0">
      <div className="flex items-center gap-3">
        <div className="min-w-0 flex-1">
          <p className="truncate font-medium">{song.title}</p>
          {song.artistCredit && (
            <p className="mt-0.5 truncate text-sm text-neutral-500">
              {song.artistCredit}
            </p>
          )}
        </div>
        <SaveSongButton
          songId={song.id}
          sections={sections}
          loggedIn={loggedIn}
        />
        <PlayButton
          songId={song.id}
          title={song.title}
          artist={song.artistCredit ?? ""}
        />
      </div>
    </li>
  );
}

function ArtistRow({ artist }: { artist: ArtistHit }) {
  return (
    <li className="border-b border-neutral-100 last:border-0">
      <Link href={`/artists/${artist.id}`} className="block py-3 hover:bg-neutral-50">
        <p className="font-medium">{artist.name}</p>
        {artist.type && (
          <p className="mt-0.5 text-sm text-neutral-500">{artist.type}</p>
        )}
      </Link>
    </li>
  );
}

function AlbumRow({ album }: { album: AlbumHit }) {
  const year = album.firstReleaseDate?.slice(0, 4);
  return (
    <li className="border-b border-neutral-100 last:border-0">
      <Link href={`/albums/${album.id}`} className="block py-3 hover:bg-neutral-50">
        <p className="font-medium">{album.title}</p>
        <p className="mt-0.5 text-sm text-neutral-500">
          {[album.artistCredit, year].filter(Boolean).join(" · ")}
        </p>
      </Link>
    </li>
  );
}

export default async function SearchPage({
  searchParams,
}: {
  searchParams: Promise<{ q?: string }>;
}) {
  const { q } = await searchParams;
  const query = (q ?? "").trim();

  // Supabase 장애 시에도 페이지는 렌더링한다 (D-014).
  let songs: SongHit[] = [];
  let artists: ArtistHit[] = [];
  let albums: AlbumHit[] = [];
  let browseArtists: ArtistHit[] = [];
  let sections: WalkieSection[] = [];
  let loggedIn = false;
  try {
    const supabase = await createClient();
    const { data: userData } = await supabase.auth.getUser();
    loggedIn = !!userData.user;
    if (loggedIn) sections = await getWalkieSections(supabase);
    if (query) {
      const results = await searchCatalog(supabase, query);
      songs = results.songs;
      artists = results.artists;
      albums = results.albums;
    } else {
      browseArtists = await listArtists(supabase);
    }
  } catch {
    // 빈 결과로 렌더링
  }

  const totalHits = songs.length + artists.length + albums.length;

  return (
    <main className="mx-auto min-h-screen w-full max-w-2xl px-6 py-10">
      <div className="mb-6 flex items-center justify-between">
        <Link href="/" className="text-xl font-bold tracking-tight">
          RECORDS
        </Link>
        <div className="flex gap-4 text-xs text-neutral-400">
          <Link href="/walkie" className="hover:text-neutral-900">
            Walkie
          </Link>
          <span>검색</span>
        </div>
      </div>

      <SearchInput initialQuery={query} />

      {query ? (
        totalHits > 0 ? (
          <>
            {songs.length > 0 && (
              <section aria-label="곡 검색 결과">
                <SectionTitle>곡 {songs.length}</SectionTitle>
                <ul>
                  {songs.map((s) => (
                    <SongRow
                      key={s.id}
                      song={s}
                      sections={sections}
                      loggedIn={loggedIn}
                    />
                  ))}
                </ul>
              </section>
            )}
            {artists.length > 0 && (
              <section aria-label="아티스트 검색 결과">
                <SectionTitle>아티스트 {artists.length}</SectionTitle>
                <ul>
                  {artists.map((a) => (
                    <ArtistRow key={a.id} artist={a} />
                  ))}
                </ul>
              </section>
            )}
            {albums.length > 0 && (
              <section aria-label="앨범 검색 결과">
                <SectionTitle>앨범 {albums.length}</SectionTitle>
                <ul>
                  {albums.map((a) => (
                    <AlbumRow key={a.id} album={a} />
                  ))}
                </ul>
              </section>
            )}
          </>
        ) : (
          <p className="mt-12 text-center text-sm text-neutral-500">
            &ldquo;{query}&rdquo;에 대한 결과가 없어요.
          </p>
        )
      ) : (
        <section aria-label="아티스트 둘러보기">
          <SectionTitle>아티스트 둘러보기</SectionTitle>
          {browseArtists.length > 0 ? (
            <ul>
              {browseArtists.map((a) => (
                <ArtistRow key={a.id} artist={a} />
              ))}
            </ul>
          ) : (
            <p className="text-sm text-neutral-500">
              카탈로그를 불러오지 못했어요. 잠시 후 다시 시도해 주세요.
            </p>
          )}
        </section>
      )}
    </main>
  );
}
