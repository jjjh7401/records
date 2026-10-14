-- Phase B 전문검색 인덱스 (D-019 I-001: MVP 검색은 Postgres full-text로 시작).
-- generated 컬럼 대신 expression GIN 인덱스를 사용해 drizzle 스키마와 드리프트를 방지한다.
-- 쿼리 시 동일한 expression으로 to_tsvector('simple', ...)를 사용한다.
-- 'simple' 사전을 쓰는 이유: J-POP(일본어/영어 혼합) 타이틀에 영어 stemmer가 부적합.

-- 아티스트: 이름 + 정렬용 이름
CREATE INDEX IF NOT EXISTS artists_search_idx ON public.artists
  USING gin (to_tsvector('simple', coalesce(name, '') || ' ' || coalesce(sort_name, '')));

-- 앨범: 타이틀 + 아티스트 크레딧
CREATE INDEX IF NOT EXISTS albums_search_idx ON public.albums
  USING gin (to_tsvector('simple', coalesce(title, '') || ' ' || coalesce(artist_credit, '')));

-- 곡: 타이틀 + 아티스트 크레딧
CREATE INDEX IF NOT EXISTS songs_search_idx ON public.songs
  USING gin (to_tsvector('simple', coalesce(title, '') || ' ' || coalesce(artist_credit, '')));
