-- Phase B updated_at 트리거.
-- public.set_updated_at() 함수는 Phase A(auth_trigger.sql)에서 이미 생성됨.

drop trigger if exists set_artists_updated_at on public.artists;
create trigger set_artists_updated_at
  before update on public.artists
  for each row execute function public.set_updated_at();

drop trigger if exists set_albums_updated_at on public.albums;
create trigger set_albums_updated_at
  before update on public.albums
  for each row execute function public.set_updated_at();

drop trigger if exists set_releases_updated_at on public.releases;
create trigger set_releases_updated_at
  before update on public.releases
  for each row execute function public.set_updated_at();

drop trigger if exists set_songs_updated_at on public.songs;
create trigger set_songs_updated_at
  before update on public.songs
  for each row execute function public.set_updated_at();

drop trigger if exists set_external_ids_updated_at on public.external_ids;
create trigger set_external_ids_updated_at
  before update on public.external_ids
  for each row execute function public.set_updated_at();

drop trigger if exists set_media_assets_updated_at on public.media_assets;
create trigger set_media_assets_updated_at
  before update on public.media_assets
  for each row execute function public.set_updated_at();
