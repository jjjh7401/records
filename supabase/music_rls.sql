-- Phase B RLS.
-- 음악 카탈로그는 공개 데이터이므로 anon/authenticated에 SELECT를 허용한다.
-- 쓰기(ingestion)는 서버에서만 수행하므로 service_role 전용. 별도 정책 없음 (default deny).
-- media_assets는 권리 이슈에 대비해 ACTIVE 상태만 공개한다.

alter table public.artists enable row level security;
alter table public.albums enable row level security;
alter table public.album_artists enable row level security;
alter table public.releases enable row level security;
alter table public.songs enable row level security;
alter table public.song_artists enable row level security;
alter table public.tracks enable row level security;
alter table public.external_ids enable row level security;
alter table public.media_assets enable row level security;
alter table public.genres enable row level security;
alter table public.artist_genres enable row level security;

-- 공개 카탈로그 SELECT 정책
create policy "public catalog read" on public.artists
  for select to anon, authenticated using (true);
create policy "public catalog read" on public.albums
  for select to anon, authenticated using (true);
create policy "public catalog read" on public.album_artists
  for select to anon, authenticated using (true);
create policy "public catalog read" on public.releases
  for select to anon, authenticated using (true);
create policy "public catalog read" on public.songs
  for select to anon, authenticated using (true);
create policy "public catalog read" on public.song_artists
  for select to anon, authenticated using (true);
create policy "public catalog read" on public.tracks
  for select to anon, authenticated using (true);
create policy "public catalog read" on public.external_ids
  for select to anon, authenticated using (true);
create policy "public catalog read" on public.genres
  for select to anon, authenticated using (true);
create policy "public catalog read" on public.artist_genres
  for select to anon, authenticated using (true);

-- 아트워크는 ACTIVE만 공개 (권리 분쟁 시 BLOCKED/REMOVED로 즉시 비공개 가능)
create policy "active assets read" on public.media_assets
  for select to anon, authenticated using (status = 'ACTIVE');
