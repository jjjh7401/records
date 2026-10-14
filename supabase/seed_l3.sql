-- Phase C seed batch LEAN: J-POP artists core tables only (idempotent)
-- artists/albums/releases/songs/tracks + link tables.
-- Source: MusicBrainz (canonical).
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '38c8c526-fb14-47b0-995d-d9c80a36954d', r.id, s.id, 10, 2, NULL, 234000
FROM public.releases r, public.songs s WHERE r.mbid = 'e19070dd-09f6-4b15-b93a-a77bcd265595' AND s.mbid = 'e5a07684-d5de-4850-86d8-eb36b334be7b'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('fa1871a1-12e8-4ef2-b253-fc28319de3c3', '2b21a9b8-a087-4c26-9156-d89ab1e75194', '正義 (Instrumental)', 'ずっと真夜中でいいのに。', 271000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '2b21a9b8-a087-4c26-9156-d89ab1e75194' AND ar.mbid = '14d2a235-30e2-489f-b490-f9dc7d2c0861'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '399dede2-6150-4a71-a1de-726f38c9145b', r.id, s.id, 11, 2, NULL, 271000
FROM public.releases r, public.songs s WHERE r.mbid = 'e19070dd-09f6-4b15-b93a-a77bcd265595' AND s.mbid = '2b21a9b8-a087-4c26-9156-d89ab1e75194'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('80cb25df-610f-46b2-b485-15c80bd43976', '4837fff1-1be7-4c77-b904-782980352653', '優しくLAST SMILE (Instrumental)', 'ずっと真夜中でいいのに。', 245000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '4837fff1-1be7-4c77-b904-782980352653' AND ar.mbid = '14d2a235-30e2-489f-b490-f9dc7d2c0861'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '2c641c1a-0c04-433c-a0bf-3a1c6ca2a250', r.id, s.id, 12, 2, NULL, 245000
FROM public.releases r, public.songs s WHERE r.mbid = 'e19070dd-09f6-4b15-b93a-a77bcd265595' AND s.mbid = '4837fff1-1be7-4c77-b904-782980352653'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('d0128c71-b62a-4f51-bcbd-47e816148762', 'bcf60e1b-c24d-4824-a860-a508bf029680', '秒針を噛む (Instrumental)', 'ずっと真夜中でいいのに。', 258000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = 'bcf60e1b-c24d-4824-a860-a508bf029680' AND ar.mbid = '14d2a235-30e2-489f-b490-f9dc7d2c0861'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '8b00a7c4-c6cd-4225-b911-52511dbe5419', r.id, s.id, 13, 2, NULL, 260000
FROM public.releases r, public.songs s WHERE r.mbid = 'e19070dd-09f6-4b15-b93a-a77bcd265595' AND s.mbid = 'bcf60e1b-c24d-4824-a860-a508bf029680'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.artists (id, mbid, name, sort_name, type, country, life_begin, life_end, disambiguation)
VALUES ('894e170c-8aa9-4914-95ef-4cc5cb4a8fcd', 'dfc6a151-3792-4695-8fda-f64723eaa788', 'ヨルシカ', 'Yorushika', 'GROUP', 'JP', '2017-04', NULL, '')
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.albums (id, mbid, title, artist_credit, primary_type, first_release_date)
VALUES ('f4db8f71-bf5f-4abf-810a-3faa2147212a', 'ff5cc185-fd38-4d98-a06b-695688584c5c', 'だから僕は音楽を辞めた', 'ヨルシカ', 'Album', '2019-04-10')
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.album_artists (album_id, artist_id, position)
SELECT a.id, ar.id, 0 FROM public.albums a, public.artists ar
WHERE a.mbid = 'ff5cc185-fd38-4d98-a06b-695688584c5c' AND ar.mbid = 'dfc6a151-3792-4695-8fda-f64723eaa788'
ON CONFLICT (album_id, artist_id) DO NOTHING;
INSERT INTO public.releases (id, mbid, album_id, title, status, country, release_date, release_date_precision, barcode, language, script)
SELECT 'da1a939d-f18f-4f0c-b486-74b908b99e71', 'dc7d420d-3f43-4190-860b-1d5f1a42f016', albums.id, 'だから僕は音楽を辞めた', 'Official', 'JP', '2019-04-10', 'day', '4589686432184', 'jpn', 'Jpan'
FROM public.albums WHERE mbid = 'ff5cc185-fd38-4d98-a06b-695688584c5c'
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('2d064ddc-6ccf-46c0-a2bc-feee0b148540', 'af589e29-1787-4495-b024-5d89b09f7325', '8/31', 'ヨルシカ', 114000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = 'af589e29-1787-4495-b024-5d89b09f7325' AND ar.mbid = 'dfc6a151-3792-4695-8fda-f64723eaa788'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '9d61c857-f801-456b-81f6-6150c39cdcb2', r.id, s.id, 1, 1, NULL, 114000
FROM public.releases r, public.songs s WHERE r.mbid = 'dc7d420d-3f43-4190-860b-1d5f1a42f016' AND s.mbid = 'af589e29-1787-4495-b024-5d89b09f7325'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('1a6c0286-94e2-4b76-8b5e-f7464bd327e8', '0e3497ed-c83d-40da-94af-af9fbff2d4b3', '藍二乗', 'ヨルシカ', 245000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '0e3497ed-c83d-40da-94af-af9fbff2d4b3' AND ar.mbid = 'dfc6a151-3792-4695-8fda-f64723eaa788'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '88f0de05-37d6-4749-9367-8d9b1d5dd069', r.id, s.id, 2, 1, NULL, 245000
FROM public.releases r, public.songs s WHERE r.mbid = 'dc7d420d-3f43-4190-860b-1d5f1a42f016' AND s.mbid = '0e3497ed-c83d-40da-94af-af9fbff2d4b3'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('5d978c2f-5e10-4086-a9e2-0a1cc7ba6440', '1552eaa7-2f74-4c2b-9391-12845cbb7296', '八月、某、月明かり', 'ヨルシカ', 276000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '1552eaa7-2f74-4c2b-9391-12845cbb7296' AND ar.mbid = 'dfc6a151-3792-4695-8fda-f64723eaa788'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '42887279-00e6-4fe4-aed3-a46b08a255b0', r.id, s.id, 3, 1, NULL, 276000
FROM public.releases r, public.songs s WHERE r.mbid = 'dc7d420d-3f43-4190-860b-1d5f1a42f016' AND s.mbid = '1552eaa7-2f74-4c2b-9391-12845cbb7296'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('7222e092-8c4e-491a-bd2a-050694b46e98', 'b739c754-8f91-491d-b157-d5963fa9aff0', '詩書きとコーヒー', 'ヨルシカ', 247000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = 'b739c754-8f91-491d-b157-d5963fa9aff0' AND ar.mbid = 'dfc6a151-3792-4695-8fda-f64723eaa788'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT 'f1649b12-0fb5-43fe-8bc9-0e54113e8c81', r.id, s.id, 4, 1, NULL, 247000
FROM public.releases r, public.songs s WHERE r.mbid = 'dc7d420d-3f43-4190-860b-1d5f1a42f016' AND s.mbid = 'b739c754-8f91-491d-b157-d5963fa9aff0'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('b5810d01-02af-4d1e-9cde-4d162b205c17', 'f9ea2cde-d15c-41bd-be59-dba17e07ef9d', '7/13', 'ヨルシカ', 98000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = 'f9ea2cde-d15c-41bd-be59-dba17e07ef9d' AND ar.mbid = 'dfc6a151-3792-4695-8fda-f64723eaa788'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT 'f69b9090-6d38-4d3e-8759-723360f4938e', r.id, s.id, 5, 1, NULL, 98000
FROM public.releases r, public.songs s WHERE r.mbid = 'dc7d420d-3f43-4190-860b-1d5f1a42f016' AND s.mbid = 'f9ea2cde-d15c-41bd-be59-dba17e07ef9d'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('8b06b9b1-8dcf-49b9-827a-80af91a74717', '4c7178eb-ab83-4e1a-a99b-b2b17f3cc696', '踊ろうぜ', 'ヨルシカ', 253000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '4c7178eb-ab83-4e1a-a99b-b2b17f3cc696' AND ar.mbid = 'dfc6a151-3792-4695-8fda-f64723eaa788'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT 'f31e34aa-bb86-436f-a030-94575258b89c', r.id, s.id, 6, 1, NULL, 253000
FROM public.releases r, public.songs s WHERE r.mbid = 'dc7d420d-3f43-4190-860b-1d5f1a42f016' AND s.mbid = '4c7178eb-ab83-4e1a-a99b-b2b17f3cc696'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('1bd2297b-cc2d-4e9a-a3e4-905f17b71aa6', 'ab124ec3-16a6-45bf-89ff-6bd2544f1a9d', '六月は雨上がりの街を書く', 'ヨルシカ', 238000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = 'ab124ec3-16a6-45bf-89ff-6bd2544f1a9d' AND ar.mbid = 'dfc6a151-3792-4695-8fda-f64723eaa788'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '5ffd8620-3852-41d0-9b4c-cf1e540d41a8', r.id, s.id, 7, 1, NULL, 238000
FROM public.releases r, public.songs s WHERE r.mbid = 'dc7d420d-3f43-4190-860b-1d5f1a42f016' AND s.mbid = 'ab124ec3-16a6-45bf-89ff-6bd2544f1a9d'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('12224bc4-df9f-46fd-af6e-11a9a7d288d5', '8eb1279f-2066-47eb-8ab1-a12c312c8045', '五月は花緑青の窓辺から', 'ヨルシカ', 185000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '8eb1279f-2066-47eb-8ab1-a12c312c8045' AND ar.mbid = 'dfc6a151-3792-4695-8fda-f64723eaa788'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '392d8ddf-fe2b-4b00-a604-79649ec012f9', r.id, s.id, 8, 1, NULL, 185000
FROM public.releases r, public.songs s WHERE r.mbid = 'dc7d420d-3f43-4190-860b-1d5f1a42f016' AND s.mbid = '8eb1279f-2066-47eb-8ab1-a12c312c8045'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('10ae3799-78b1-4156-9f20-c010ee031048', 'b7717068-e7a4-42d4-b913-d73598a2548e', '夜紛い', 'ヨルシカ', 223000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = 'b7717068-e7a4-42d4-b913-d73598a2548e' AND ar.mbid = 'dfc6a151-3792-4695-8fda-f64723eaa788'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT 'b51a7e8b-59c1-43ce-9886-6c725e5fdf8c', r.id, s.id, 9, 1, NULL, 223000
FROM public.releases r, public.songs s WHERE r.mbid = 'dc7d420d-3f43-4190-860b-1d5f1a42f016' AND s.mbid = 'b7717068-e7a4-42d4-b913-d73598a2548e'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('5a5cabbe-8113-443c-b1bf-a73f41d91c5c', 'c15887d4-ddd1-4ce2-aa7c-2769e8df7c95', '5/6', 'ヨルシカ', 147000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = 'c15887d4-ddd1-4ce2-aa7c-2769e8df7c95' AND ar.mbid = 'dfc6a151-3792-4695-8fda-f64723eaa788'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT 'fb1fb735-4efc-4239-afd7-7c60b58226c8', r.id, s.id, 10, 1, NULL, 147000
FROM public.releases r, public.songs s WHERE r.mbid = 'dc7d420d-3f43-4190-860b-1d5f1a42f016' AND s.mbid = 'c15887d4-ddd1-4ce2-aa7c-2769e8df7c95'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('c8757188-011b-4b94-8a6a-abe01f51479f', 'ea99065d-a81a-4a9a-962c-f119d9398078', 'パレード', 'ヨルシカ', 299000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = 'ea99065d-a81a-4a9a-962c-f119d9398078' AND ar.mbid = 'dfc6a151-3792-4695-8fda-f64723eaa788'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '5cc64d3b-f025-433f-a946-20591ff741d7', r.id, s.id, 11, 1, NULL, 299000
FROM public.releases r, public.songs s WHERE r.mbid = 'dc7d420d-3f43-4190-860b-1d5f1a42f016' AND s.mbid = 'ea99065d-a81a-4a9a-962c-f119d9398078'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('d02a1f19-d9ab-4552-8d97-839ac764782f', '2d9ac248-02aa-4487-8227-4358289c6e00', 'エルマ', 'ヨルシカ', 219000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '2d9ac248-02aa-4487-8227-4358289c6e00' AND ar.mbid = 'dfc6a151-3792-4695-8fda-f64723eaa788'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT 'ca2d5c93-0a25-4881-bcb5-c1fae451d4a9', r.id, s.id, 12, 1, NULL, 219000
FROM public.releases r, public.songs s WHERE r.mbid = 'dc7d420d-3f43-4190-860b-1d5f1a42f016' AND s.mbid = '2d9ac248-02aa-4487-8227-4358289c6e00'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('32b1cf5f-d50a-4a6b-84f9-64e44b20c46f', 'e9f97674-d7f4-4864-bceb-9fba675a5278', '4/10', 'ヨルシカ', 170000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = 'e9f97674-d7f4-4864-bceb-9fba675a5278' AND ar.mbid = 'dfc6a151-3792-4695-8fda-f64723eaa788'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT 'a0c24ae0-182e-4b69-b00f-0a7b81eb1196', r.id, s.id, 13, 1, NULL, 170000
FROM public.releases r, public.songs s WHERE r.mbid = 'dc7d420d-3f43-4190-860b-1d5f1a42f016' AND s.mbid = 'e9f97674-d7f4-4864-bceb-9fba675a5278'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('b2c5ba12-0796-4fb4-b383-2aaeb5f39e16', '1fbacb09-3593-4e69-b4cb-7913975360a5', 'だから僕は音楽を辞めた', 'ヨルシカ', 242000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '1fbacb09-3593-4e69-b4cb-7913975360a5' AND ar.mbid = 'dfc6a151-3792-4695-8fda-f64723eaa788'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '18e55e25-96c2-4518-8a39-ea14c68dff5d', r.id, s.id, 14, 1, NULL, 242000
FROM public.releases r, public.songs s WHERE r.mbid = 'dc7d420d-3f43-4190-860b-1d5f1a42f016' AND s.mbid = '1fbacb09-3593-4e69-b4cb-7913975360a5'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.artists (id, mbid, name, sort_name, type, country, life_begin, life_end, disambiguation)
VALUES ('345aa5af-2826-48fd-aae0-53be39c4b28f', '0550993e-ddec-468e-b05f-da81bf6f7694', 'スピッツ', 'Spitz', 'GROUP', 'JP', '1987', NULL, '')
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.albums (id, mbid, title, artist_credit, primary_type, first_release_date)
VALUES ('4e412ee5-d931-47fa-81a1-33dfc3ad0947', 'ed9130bb-cb48-3591-9b3d-423186282b4c', 'ハッピーディ', 'スピッツ', 'Album', NULL)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.album_artists (album_id, artist_id, position)
SELECT a.id, ar.id, 0 FROM public.albums a, public.artists ar
WHERE a.mbid = 'ed9130bb-cb48-3591-9b3d-423186282b4c' AND ar.mbid = '0550993e-ddec-468e-b05f-da81bf6f7694'
ON CONFLICT (album_id, artist_id) DO NOTHING;
INSERT INTO public.releases (id, mbid, album_id, title, status, country, release_date, release_date_precision, barcode, language, script)
SELECT 'b8348b3e-672f-457f-aacd-5005e9d5901f', '5d284867-772d-4406-8dae-9803725cda60', albums.id, 'ハッピーディ', 'Promotion', 'JP', NULL, 'month', NULL, 'jpn', 'Jpan'
FROM public.albums WHERE mbid = 'ed9130bb-cb48-3591-9b3d-423186282b4c'
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('ab79f3d7-fc09-488e-8df4-ea5a69acd7f8', 'bf903e9f-908b-4ba0-94c5-9e30cd0e6809', '僕はジェット', 'スピッツ', 245000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = 'bf903e9f-908b-4ba0-94c5-9e30cd0e6809' AND ar.mbid = '0550993e-ddec-468e-b05f-da81bf6f7694'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '367295f2-5e94-4e9c-a540-4c46e636a36e', r.id, s.id, 1, 1, NULL, 245000
FROM public.releases r, public.songs s WHERE r.mbid = '5d284867-772d-4406-8dae-9803725cda60' AND s.mbid = 'bf903e9f-908b-4ba0-94c5-9e30cd0e6809'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('07baaca2-3b3c-4b83-9638-9b3e8ac503b7', '5e9bb63d-b9f5-44c0-abbe-af6ecb3158ae', '晴れの日はプカプカプー', 'スピッツ', 245000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '5e9bb63d-b9f5-44c0-abbe-af6ecb3158ae' AND ar.mbid = '0550993e-ddec-468e-b05f-da81bf6f7694'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT 'bcca284b-d084-49fe-a353-69780c93b3d2', r.id, s.id, 2, 1, NULL, 245000
FROM public.releases r, public.songs s WHERE r.mbid = '5d284867-772d-4406-8dae-9803725cda60' AND s.mbid = '5e9bb63d-b9f5-44c0-abbe-af6ecb3158ae'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('76fb53a0-e094-4450-9d10-b40d4cda2940', 'd5838d64-6f7e-42b0-a9e2-5dd6ecc141d6', 'クモ少年が走る', 'スピッツ', 250000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = 'd5838d64-6f7e-42b0-a9e2-5dd6ecc141d6' AND ar.mbid = '0550993e-ddec-468e-b05f-da81bf6f7694'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '52d774d8-a695-4051-892b-e0db001fa95e', r.id, s.id, 3, 1, NULL, 250000
FROM public.releases r, public.songs s WHERE r.mbid = '5d284867-772d-4406-8dae-9803725cda60' AND s.mbid = 'd5838d64-6f7e-42b0-a9e2-5dd6ecc141d6'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('06bb19f9-f553-472c-bb6f-f3ed307d9ccd', '5adaa9ce-9aa0-4951-9f85-2671c20838bb', 'ハッピーデイ', 'スピッツ', 272000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '5adaa9ce-9aa0-4951-9f85-2671c20838bb' AND ar.mbid = '0550993e-ddec-468e-b05f-da81bf6f7694'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '343b4045-9973-498c-a301-8a51d2420754', r.id, s.id, 4, 1, NULL, 272000
FROM public.releases r, public.songs s WHERE r.mbid = '5d284867-772d-4406-8dae-9803725cda60' AND s.mbid = '5adaa9ce-9aa0-4951-9f85-2671c20838bb'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.artists (id, mbid, name, sort_name, type, country, life_begin, life_end, disambiguation)
VALUES ('5129d47c-a155-459b-8e06-c8c2f8cbf37d', '27f0af0e-4d1f-4808-a58b-090e400dcc43', 'Mr.Children', 'Mr.Children', 'GROUP', 'JP', '1989', NULL, '')
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.albums (id, mbid, title, artist_credit, primary_type, first_release_date)
VALUES ('ad031bf3-d4c5-4e63-a720-4aa88603aa2a', 'ed1bdfe3-2a7a-32ef-b357-a6a8702781e7', 'Everything', 'Mr.Children', 'Album', '1992-05-10')
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.album_artists (album_id, artist_id, position)
SELECT a.id, ar.id, 0 FROM public.albums a, public.artists ar
WHERE a.mbid = 'ed1bdfe3-2a7a-32ef-b357-a6a8702781e7' AND ar.mbid = '27f0af0e-4d1f-4808-a58b-090e400dcc43'
ON CONFLICT (album_id, artist_id) DO NOTHING;
INSERT INTO public.releases (id, mbid, album_id, title, status, country, release_date, release_date_precision, barcode, language, script)
SELECT '05171e93-5ed5-4680-98c0-59a52f708507', 'd349dcbb-1ee1-429d-8357-fc1806512e31', albums.id, 'Everything', 'Official', 'JP', '1992-05-10', 'day', '4988061880204', 'jpn', 'Jpan'
FROM public.albums WHERE mbid = 'ed1bdfe3-2a7a-32ef-b357-a6a8702781e7'
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('a57ae9e2-c05a-42e0-8f8c-68a64a3a8325', '3244ecd9-9d23-47af-80f7-5f7dfe71b5aa', 'ロード・アイ・ミス・ユー', 'Mr.Children', 222000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '3244ecd9-9d23-47af-80f7-5f7dfe71b5aa' AND ar.mbid = '27f0af0e-4d1f-4808-a58b-090e400dcc43'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '2e480e1b-92e4-4656-9218-bc86a797dfc3', r.id, s.id, 1, 1, NULL, 222000
FROM public.releases r, public.songs s WHERE r.mbid = 'd349dcbb-1ee1-429d-8357-fc1806512e31' AND s.mbid = '3244ecd9-9d23-47af-80f7-5f7dfe71b5aa'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('c9e7f1ec-136e-4617-b3ae-228ea861011e', '21b54d22-98f2-414d-8e4f-3d9171a1e6d7', 'Mr.Shining Moon', 'Mr.Children', 263000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '21b54d22-98f2-414d-8e4f-3d9171a1e6d7' AND ar.mbid = '27f0af0e-4d1f-4808-a58b-090e400dcc43'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT 'e7ba97fb-a1da-4dd0-878c-6c47008f2439', r.id, s.id, 2, 1, NULL, 263000
FROM public.releases r, public.songs s WHERE r.mbid = 'd349dcbb-1ee1-429d-8357-fc1806512e31' AND s.mbid = '21b54d22-98f2-414d-8e4f-3d9171a1e6d7'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('a0043f62-51e8-44de-95f7-1acf2a5c12fb', '74e3469e-e0e4-4d4a-bf8a-19bf7585bafb', '君がいた夏', 'Mr.Children', 351875)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '74e3469e-e0e4-4d4a-bf8a-19bf7585bafb' AND ar.mbid = '27f0af0e-4d1f-4808-a58b-090e400dcc43'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '472336f0-2bb6-478a-a2f1-7c70408cea9f', r.id, s.id, 3, 1, NULL, 351000
FROM public.releases r, public.songs s WHERE r.mbid = 'd349dcbb-1ee1-429d-8357-fc1806512e31' AND s.mbid = '74e3469e-e0e4-4d4a-bf8a-19bf7585bafb'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('01846721-8672-43f7-9930-f9d0219512dc', 'fdf18835-c3cb-4d77-815c-c146a0ed2261', '風〜The wind knows how I feel〜', 'Mr.Children', 196000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = 'fdf18835-c3cb-4d77-815c-c146a0ed2261' AND ar.mbid = '27f0af0e-4d1f-4808-a58b-090e400dcc43'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT 'f8a2f410-a782-483d-b740-d21652b0c45a', r.id, s.id, 4, 1, NULL, 196000
FROM public.releases r, public.songs s WHERE r.mbid = 'd349dcbb-1ee1-429d-8357-fc1806512e31' AND s.mbid = 'fdf18835-c3cb-4d77-815c-c146a0ed2261'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('3af5888f-bc06-45c4-a637-b49a7e65f4f8', 'ccfc7a32-689a-429f-8b55-222605dabb0d', 'ためいきの日曜日', 'Mr.Children', 355000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = 'ccfc7a32-689a-429f-8b55-222605dabb0d' AND ar.mbid = '27f0af0e-4d1f-4808-a58b-090e400dcc43'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '68467947-8d59-4f97-b162-21570a25ec33', r.id, s.id, 5, 1, NULL, 355000
FROM public.releases r, public.songs s WHERE r.mbid = 'd349dcbb-1ee1-429d-8357-fc1806512e31' AND s.mbid = 'ccfc7a32-689a-429f-8b55-222605dabb0d'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('e7af6be5-20b8-41ce-96a5-ba7e11787d7b', 'b3adf84f-6fb5-4aae-b2ab-2766634deee9', '友達のままで', 'Mr.Children', 235000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = 'b3adf84f-6fb5-4aae-b2ab-2766634deee9' AND ar.mbid = '27f0af0e-4d1f-4808-a58b-090e400dcc43'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT 'eaa3693c-d339-48c1-9a41-72931f7a8cd1', r.id, s.id, 6, 1, NULL, 235000
FROM public.releases r, public.songs s WHERE r.mbid = 'd349dcbb-1ee1-429d-8357-fc1806512e31' AND s.mbid = 'b3adf84f-6fb5-4aae-b2ab-2766634deee9'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('8aba6dbb-7583-45b8-8f87-eb71e6d6292f', 'b549458d-2fb4-4733-9926-83484f8b3e4d', 'CHILDREN''S WORLD', 'Mr.Children', 307000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = 'b549458d-2fb4-4733-9926-83484f8b3e4d' AND ar.mbid = '27f0af0e-4d1f-4808-a58b-090e400dcc43'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT 'b6ad1a2e-1269-4628-9724-95f193c843f5', r.id, s.id, 7, 1, NULL, 307000
FROM public.releases r, public.songs s WHERE r.mbid = 'd349dcbb-1ee1-429d-8357-fc1806512e31' AND s.mbid = 'b549458d-2fb4-4733-9926-83484f8b3e4d'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.artists (id, mbid, name, sort_name, type, country, life_begin, life_end, disambiguation)
VALUES ('ae850e9a-98d2-40be-ab59-37652eac3b2b', '24d9e513-c215-4901-87ee-b66aa769ab9d', 'サザンオールスターズ', 'Southern All Stars', 'GROUP', 'JP', '1974', NULL, 'Japanese rock band')
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.albums (id, mbid, title, artist_credit, primary_type, first_release_date)
VALUES ('4fc58233-f959-4dcc-8af5-35823830a6e3', '7cfd25d8-c7fe-3847-af56-62e5677605b4', '熱い胸さわぎ', 'サザンオールスターズ', 'Album', '1978-08-25')
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.album_artists (album_id, artist_id, position)
SELECT a.id, ar.id, 0 FROM public.albums a, public.artists ar
WHERE a.mbid = '7cfd25d8-c7fe-3847-af56-62e5677605b4' AND ar.mbid = '24d9e513-c215-4901-87ee-b66aa769ab9d'
ON CONFLICT (album_id, artist_id) DO NOTHING;
INSERT INTO public.releases (id, mbid, album_id, title, status, country, release_date, release_date_precision, barcode, language, script)
SELECT '88a4a7b7-e684-48fb-afe5-08d37101def9', 'aafa08b8-3ad7-44b4-8f5a-ad29a2555892', albums.id, '熱い胸さわぎ', 'Official', 'JP', '1978-08-25', 'day', NULL, 'jpn', 'Jpan'
FROM public.albums WHERE mbid = '7cfd25d8-c7fe-3847-af56-62e5677605b4'
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('96ab4ee6-097a-4d0d-8c01-b1ae0d007792', '6ce606c5-d94a-4e22-94ad-f947c68f50a7', '勝手にシンドバッド', 'サザンオールスターズ', 238640)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '6ce606c5-d94a-4e22-94ad-f947c68f50a7' AND ar.mbid = '24d9e513-c215-4901-87ee-b66aa769ab9d'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '146ff486-1c56-4d43-b408-8745032f6c2f', r.id, s.id, 1, 1, NULL, 238640
FROM public.releases r, public.songs s WHERE r.mbid = 'aafa08b8-3ad7-44b4-8f5a-ad29a2555892' AND s.mbid = '6ce606c5-d94a-4e22-94ad-f947c68f50a7'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('a208f5e3-35b6-4a4d-9db6-efc5394c4540', 'a9fad559-d876-4683-8156-e2bedde35159', '別れ話は最後に', 'サザンオールスターズ', 276000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = 'a9fad559-d876-4683-8156-e2bedde35159' AND ar.mbid = '24d9e513-c215-4901-87ee-b66aa769ab9d'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT 'a5067a14-7ea4-4ec3-8eec-022fc615fa05', r.id, s.id, 2, 1, NULL, 276493
FROM public.releases r, public.songs s WHERE r.mbid = 'aafa08b8-3ad7-44b4-8f5a-ad29a2555892' AND s.mbid = 'a9fad559-d876-4683-8156-e2bedde35159'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('923411ed-11d3-43ad-bc3a-0a98e889f165', '0a882834-fe08-4593-bb50-6b59d9b3a7d2', '当って砕けろ', 'サザンオールスターズ', 229907)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '0a882834-fe08-4593-bb50-6b59d9b3a7d2' AND ar.mbid = '24d9e513-c215-4901-87ee-b66aa769ab9d'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT 'caa284ed-1641-4ead-8272-6a990dcff567', r.id, s.id, 3, 1, NULL, 229906
FROM public.releases r, public.songs s WHERE r.mbid = 'aafa08b8-3ad7-44b4-8f5a-ad29a2555892' AND s.mbid = '0a882834-fe08-4593-bb50-6b59d9b3a7d2'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('822d3e6b-0405-46a2-9e47-5ec9bff0d3ef', '9742db5b-348a-4fec-819f-9c19c8d032fc', '恋はお熱く', 'サザンオールスターズ', 269733)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '9742db5b-348a-4fec-819f-9c19c8d032fc' AND ar.mbid = '24d9e513-c215-4901-87ee-b66aa769ab9d'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT 'd3ddf263-f415-4bb7-b258-953cabebd4e8', r.id, s.id, 4, 1, NULL, 269733
FROM public.releases r, public.songs s WHERE r.mbid = 'aafa08b8-3ad7-44b4-8f5a-ad29a2555892' AND s.mbid = '9742db5b-348a-4fec-819f-9c19c8d032fc'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('81c928b8-fc2a-463c-89b5-4b2e7d6034ae', '4ad55c07-7abd-4d3a-bb8e-be22e995c870', '茅ヶ崎に背を向けて', 'サザンオールスターズ', 204000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '4ad55c07-7abd-4d3a-bb8e-be22e995c870' AND ar.mbid = '24d9e513-c215-4901-87ee-b66aa769ab9d'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '607386ee-656e-4a0a-94fb-168afbd84c6f', r.id, s.id, 5, 1, NULL, 203760
FROM public.releases r, public.songs s WHERE r.mbid = 'aafa08b8-3ad7-44b4-8f5a-ad29a2555892' AND s.mbid = '4ad55c07-7abd-4d3a-bb8e-be22e995c870'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('f1ddfad6-6f3e-4818-ac3f-109e7b312b53', 'e45883ff-3b57-4432-8575-270998e0df4c', '瞳の中にレインボウ', 'サザンオールスターズ', 291000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = 'e45883ff-3b57-4432-8575-270998e0df4c' AND ar.mbid = '24d9e513-c215-4901-87ee-b66aa769ab9d'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '4d743a8a-155f-4944-a2ae-f34693e422b3', r.id, s.id, 6, 1, NULL, 291240
FROM public.releases r, public.songs s WHERE r.mbid = 'aafa08b8-3ad7-44b4-8f5a-ad29a2555892' AND s.mbid = 'e45883ff-3b57-4432-8575-270998e0df4c'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('036ba84d-8f5f-4585-80b7-1032de0b236f', '76c12278-77ed-426e-9e1a-a1fe5a3ea2b0', '女呼んでブギ', 'サザンオールスターズ', 247000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '76c12278-77ed-426e-9e1a-a1fe5a3ea2b0' AND ar.mbid = '24d9e513-c215-4901-87ee-b66aa769ab9d'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT 'f93e6a20-c5eb-4fc7-beb6-1e75d9fe8044', r.id, s.id, 7, 1, NULL, 247400
FROM public.releases r, public.songs s WHERE r.mbid = 'aafa08b8-3ad7-44b4-8f5a-ad29a2555892' AND s.mbid = '76c12278-77ed-426e-9e1a-a1fe5a3ea2b0'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('c182abdc-067f-41f9-bf85-ad852475c209', 'c0727a74-07ab-427b-8386-ecab2aed99f4', 'レゲエに首ったけ', 'サザンオールスターズ', 243000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = 'c0727a74-07ab-427b-8386-ecab2aed99f4' AND ar.mbid = '24d9e513-c215-4901-87ee-b66aa769ab9d'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '501a8fd4-7634-42cc-8c2b-4d80fc51db6c', r.id, s.id, 8, 1, NULL, 243426
FROM public.releases r, public.songs s WHERE r.mbid = 'aafa08b8-3ad7-44b4-8f5a-ad29a2555892' AND s.mbid = 'c0727a74-07ab-427b-8386-ecab2aed99f4'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('bd12896b-39c8-469b-af2d-6c02c592e97e', '9f97faf7-b32c-49d8-b12c-d0af381bfb70', 'いとしのフィート', 'サザンオールスターズ', 302000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '9f97faf7-b32c-49d8-b12c-d0af381bfb70' AND ar.mbid = '24d9e513-c215-4901-87ee-b66aa769ab9d'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '9adc2a3e-dc52-476c-bd01-953a15bfde1d', r.id, s.id, 9, 1, NULL, 302133
FROM public.releases r, public.songs s WHERE r.mbid = 'aafa08b8-3ad7-44b4-8f5a-ad29a2555892' AND s.mbid = '9f97faf7-b32c-49d8-b12c-d0af381bfb70'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('55ec3681-20ea-47a4-b407-e25e1a41f32c', '6cf04ca6-bb4e-4b42-895f-b3c7a003f1bd', '今宵あなたに', 'サザンオールスターズ', 221000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '6cf04ca6-bb4e-4b42-895f-b3c7a003f1bd' AND ar.mbid = '24d9e513-c215-4901-87ee-b66aa769ab9d'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT 'c2c47607-21c2-4afb-a746-bdf43dac738b', r.id, s.id, 10, 1, NULL, 220774
FROM public.releases r, public.songs s WHERE r.mbid = 'aafa08b8-3ad7-44b4-8f5a-ad29a2555892' AND s.mbid = '6cf04ca6-bb4e-4b42-895f-b3c7a003f1bd'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.artists (id, mbid, name, sort_name, type, country, life_begin, life_end, disambiguation)
VALUES ('df707d66-7160-4cc7-8a07-9713381cb5d6', 'b3d0f168-cb34-47c6-8529-fc05d1fce3ee', '東京事変', 'Tokyo Jihen', 'GROUP', 'JP', '2003-07-18', NULL, '')
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.albums (id, mbid, title, artist_credit, primary_type, first_release_date)
VALUES ('9f89bd84-bda2-45fc-bea7-03cbe36a8a21', '3583d952-c5ec-3d69-b4e0-6f757d7480eb', '教育', '東京事変', 'Album', '2004-11-25')
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.album_artists (album_id, artist_id, position)
SELECT a.id, ar.id, 0 FROM public.albums a, public.artists ar
WHERE a.mbid = '3583d952-c5ec-3d69-b4e0-6f757d7480eb' AND ar.mbid = 'b3d0f168-cb34-47c6-8529-fc05d1fce3ee'
ON CONFLICT (album_id, artist_id) DO NOTHING;
INSERT INTO public.releases (id, mbid, album_id, title, status, country, release_date, release_date_precision, barcode, language, script)
SELECT '3768e009-b0dd-4674-b37d-336f4f55a483', 'b08eaad5-28f9-4404-b3b7-90067c092d1d', albums.id, '教育', 'Official', 'JP', '2004-11-25', 'day', '4988006193130', 'jpn', 'Jpan'
FROM public.albums WHERE mbid = '3583d952-c5ec-3d69-b4e0-6f757d7480eb'
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('814b0500-a7d7-4828-8c6b-b160a7869b6e', '76e48c55-3a16-4a81-8f72-c1e00c810d7b', '林檎の唄', '東京事変', 172333)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '76e48c55-3a16-4a81-8f72-c1e00c810d7b' AND ar.mbid = 'b3d0f168-cb34-47c6-8529-fc05d1fce3ee'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT 'f6bee653-f262-48a3-80a0-39776e0fc1b7', r.id, s.id, 1, 1, NULL, 172333
FROM public.releases r, public.songs s WHERE r.mbid = 'b08eaad5-28f9-4404-b3b7-90067c092d1d' AND s.mbid = '76e48c55-3a16-4a81-8f72-c1e00c810d7b'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('1592c594-4012-4b97-8f28-b151a626e72f', '4ee28893-2590-4b39-8625-7e25e4cde2fd', '群青日和', '東京事変', 213266)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '4ee28893-2590-4b39-8625-7e25e4cde2fd' AND ar.mbid = 'b3d0f168-cb34-47c6-8529-fc05d1fce3ee'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT 'f5110686-7895-4c85-9357-f4321768d5f8', r.id, s.id, 2, 1, NULL, 213266
FROM public.releases r, public.songs s WHERE r.mbid = 'b08eaad5-28f9-4404-b3b7-90067c092d1d' AND s.mbid = '4ee28893-2590-4b39-8625-7e25e4cde2fd'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('a79c5afb-b89d-4dc3-8030-3929fd6fed67', '95c7a503-e8cc-415b-bd1c-b276c7d8c289', '入水願い', '東京事変', 203226)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '95c7a503-e8cc-415b-bd1c-b276c7d8c289' AND ar.mbid = 'b3d0f168-cb34-47c6-8529-fc05d1fce3ee'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '5fd5d7a6-5b2e-42be-a58f-f2f2f7dba8a3', r.id, s.id, 3, 1, NULL, 203226
FROM public.releases r, public.songs s WHERE r.mbid = 'b08eaad5-28f9-4404-b3b7-90067c092d1d' AND s.mbid = '95c7a503-e8cc-415b-bd1c-b276c7d8c289'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('bab61299-91b9-462d-9ff6-d41acb21ff8b', '3b73ff87-70da-4a7e-8385-0830bdb04e85', '遭難', '東京事変', 203240)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '3b73ff87-70da-4a7e-8385-0830bdb04e85' AND ar.mbid = 'b3d0f168-cb34-47c6-8529-fc05d1fce3ee'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT 'f12e95cc-19b7-41af-b49f-6a251964c45b', r.id, s.id, 4, 1, NULL, 203240
FROM public.releases r, public.songs s WHERE r.mbid = 'b08eaad5-28f9-4404-b3b7-90067c092d1d' AND s.mbid = '3b73ff87-70da-4a7e-8385-0830bdb04e85'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('968da3c4-d14e-4f7e-a325-8224b43bb314', 'e8196648-87a2-4ebd-b4b4-38c82c740e83', 'クロール', '東京事変', 244226)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = 'e8196648-87a2-4ebd-b4b4-38c82c740e83' AND ar.mbid = 'b3d0f168-cb34-47c6-8529-fc05d1fce3ee'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT 'f0735858-4a4d-4f3d-b7da-d2905b74806a', r.id, s.id, 5, 1, NULL, 244226
FROM public.releases r, public.songs s WHERE r.mbid = 'b08eaad5-28f9-4404-b3b7-90067c092d1d' AND s.mbid = 'e8196648-87a2-4ebd-b4b4-38c82c740e83'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('5173eccd-5ec3-424f-849b-b7be83096b15', 'ca3dba02-2b03-4efb-878a-49b2c735ab74', '現実に於て', '東京事変', 71240)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = 'ca3dba02-2b03-4efb-878a-49b2c735ab74' AND ar.mbid = 'b3d0f168-cb34-47c6-8529-fc05d1fce3ee'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT 'd9e6e025-1480-4850-9466-2f937b09a5a1', r.id, s.id, 6, 1, NULL, 71240
FROM public.releases r, public.songs s WHERE r.mbid = 'b08eaad5-28f9-4404-b3b7-90067c092d1d' AND s.mbid = 'ca3dba02-2b03-4efb-878a-49b2c735ab74'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('6659c8d1-1d4a-42c4-9b2e-561301558811', '3b106c8f-2fa3-4f78-a971-6dee415cd367', '現実を嗤う', '東京事変', 264266)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '3b106c8f-2fa3-4f78-a971-6dee415cd367' AND ar.mbid = 'b3d0f168-cb34-47c6-8529-fc05d1fce3ee'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT 'a56f5b9d-0666-40b8-9a2c-43981abf53a4', r.id, s.id, 7, 1, NULL, 264266
FROM public.releases r, public.songs s WHERE r.mbid = 'b08eaad5-28f9-4404-b3b7-90067c092d1d' AND s.mbid = '3b106c8f-2fa3-4f78-a971-6dee415cd367'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('f21f216c-fdea-48f1-9733-59ad87537363', 'e348efcb-7ad5-42a9-81d7-896a25b2200f', 'サービス', '東京事変', 244266)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = 'e348efcb-7ad5-42a9-81d7-896a25b2200f' AND ar.mbid = 'b3d0f168-cb34-47c6-8529-fc05d1fce3ee'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '7b25d3b0-5883-4b38-99f2-60a5adab71c7', r.id, s.id, 8, 1, NULL, 244266
FROM public.releases r, public.songs s WHERE r.mbid = 'b08eaad5-28f9-4404-b3b7-90067c092d1d' AND s.mbid = 'e348efcb-7ad5-42a9-81d7-896a25b2200f'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('0219a47d-170a-44b5-903a-2b50849bf7bf', 'bd8b627e-6117-429b-a702-20f37245c702', '駅前', '東京事変', 233226)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = 'bd8b627e-6117-429b-a702-20f37245c702' AND ar.mbid = 'b3d0f168-cb34-47c6-8529-fc05d1fce3ee'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '455262ac-881f-4d3a-8adc-ee0c6ca5529a', r.id, s.id, 9, 1, NULL, 233226
FROM public.releases r, public.songs s WHERE r.mbid = 'b08eaad5-28f9-4404-b3b7-90067c092d1d' AND s.mbid = 'bd8b627e-6117-429b-a702-20f37245c702'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('a45f48fa-7f36-40b5-8c93-b65f6abf7291', '2998cb30-ee1c-4905-98fa-d1f93faa7693', '御祭騒ぎ', '東京事変', 213266)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '2998cb30-ee1c-4905-98fa-d1f93faa7693' AND ar.mbid = 'b3d0f168-cb34-47c6-8529-fc05d1fce3ee'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '72ca2ee6-1843-445b-afec-d9adf33b8534', r.id, s.id, 10, 1, NULL, 213266
FROM public.releases r, public.songs s WHERE r.mbid = 'b08eaad5-28f9-4404-b3b7-90067c092d1d' AND s.mbid = '2998cb30-ee1c-4905-98fa-d1f93faa7693'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('20e931d2-69b0-4532-bb0f-1169d50be783', 'a396a7b5-647f-481e-9baf-e94c84477c0c', '母国情緒', '東京事変', 183266)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = 'a396a7b5-647f-481e-9baf-e94c84477c0c' AND ar.mbid = 'b3d0f168-cb34-47c6-8529-fc05d1fce3ee'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '85389cea-ea95-483c-8095-007e7f67fb65', r.id, s.id, 11, 1, NULL, 183266
FROM public.releases r, public.songs s WHERE r.mbid = 'b08eaad5-28f9-4404-b3b7-90067c092d1d' AND s.mbid = 'a396a7b5-647f-481e-9baf-e94c84477c0c'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('23bb2c7f-c249-431f-8eef-486d21c09ef5', '692ec83e-5be1-40b8-aebf-f04bf6c1df72', '夢のあと', '東京事変', 284573)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '692ec83e-5be1-40b8-aebf-f04bf6c1df72' AND ar.mbid = 'b3d0f168-cb34-47c6-8529-fc05d1fce3ee'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT 'ec56c481-5d39-4c22-a89b-b6a891a72756', r.id, s.id, 12, 1, NULL, 284573
FROM public.releases r, public.songs s WHERE r.mbid = 'b08eaad5-28f9-4404-b3b7-90067c092d1d' AND s.mbid = '692ec83e-5be1-40b8-aebf-f04bf6c1df72'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.artists (id, mbid, name, sort_name, type, country, life_begin, life_end, disambiguation)
VALUES ('fbd2ffa7-fcd1-4ac8-84c2-9b565fedaa66', '264955bb-3412-4ab5-9ba5-4423a28b3641', '菅田将暉', 'Suda, Masaki', 'PERSON', 'JP', '1993-02-21', NULL, '')
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.albums (id, mbid, title, artist_credit, primary_type, first_release_date)
VALUES ('639a06b4-eb8d-440f-ac4a-f6f5548dcd26', 'bf4fb5a7-3e90-4c33-a64f-53b5f6d3f235', 'PLAY', '菅田将暉', 'Album', '2018-03-21')
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.album_artists (album_id, artist_id, position)
SELECT a.id, ar.id, 0 FROM public.albums a, public.artists ar
WHERE a.mbid = 'bf4fb5a7-3e90-4c33-a64f-53b5f6d3f235' AND ar.mbid = '264955bb-3412-4ab5-9ba5-4423a28b3641'
ON CONFLICT (album_id, artist_id) DO NOTHING;
INSERT INTO public.releases (id, mbid, album_id, title, status, country, release_date, release_date_precision, barcode, language, script)
SELECT 'db8a0bfb-d05e-4f1b-9f22-0b813a8d53e0', 'dd272163-c99e-4190-98dc-01a149926b71', albums.id, 'PLAY', 'Official', 'JP', '2018-03-21', 'day', '4547366347715', 'jpn', 'Jpan'
FROM public.albums WHERE mbid = 'bf4fb5a7-3e90-4c33-a64f-53b5f6d3f235'
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('34ca1a92-5674-4e6e-b7fc-a7e9e1d2a8ad', '73f2d1e1-7f73-4d49-b695-025885ad10c2', 'さよならエレジー', '菅田将暉', 257000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '73f2d1e1-7f73-4d49-b695-025885ad10c2' AND ar.mbid = '264955bb-3412-4ab5-9ba5-4423a28b3641'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT 'c8d86cf7-1d48-4f9b-9960-5a95ff7f483f', r.id, s.id, 1, 1, NULL, 257000
FROM public.releases r, public.songs s WHERE r.mbid = 'dd272163-c99e-4190-98dc-01a149926b71' AND s.mbid = '73f2d1e1-7f73-4d49-b695-025885ad10c2'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('b2dc40bc-b391-4c44-9704-b7eb58bcb4df', '05ede5b1-904e-4062-934e-db1658062b5a', 'いいんだよ、きっと', '菅田将暉', 363000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '05ede5b1-904e-4062-934e-db1658062b5a' AND ar.mbid = '264955bb-3412-4ab5-9ba5-4423a28b3641'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '09557070-684c-45cc-bded-e166af7344e4', r.id, s.id, 2, 1, NULL, 363000
FROM public.releases r, public.songs s WHERE r.mbid = 'dd272163-c99e-4190-98dc-01a149926b71' AND s.mbid = '05ede5b1-904e-4062-934e-db1658062b5a'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('0b30411f-9681-4925-ba36-a4a07b0a1487', 'a62bdb3e-ae1d-49e0-82a1-a2a44dd95a06', '見たこともない景色', '菅田将暉', 222000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = 'a62bdb3e-ae1d-49e0-82a1-a2a44dd95a06' AND ar.mbid = '264955bb-3412-4ab5-9ba5-4423a28b3641'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT 'c5223078-e39c-4f98-ad65-71cb2cceb047', r.id, s.id, 3, 1, NULL, 222000
FROM public.releases r, public.songs s WHERE r.mbid = 'dd272163-c99e-4190-98dc-01a149926b71' AND s.mbid = 'a62bdb3e-ae1d-49e0-82a1-a2a44dd95a06'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('bc6cfa01-e5fe-452b-b4cf-cd6ea7b188c0', '0d074f82-2c45-46a7-857a-683d9d92a9ff', 'ピンクのアフロにカザールかけて', '菅田将暉', 277000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '0d074f82-2c45-46a7-857a-683d9d92a9ff' AND ar.mbid = '264955bb-3412-4ab5-9ba5-4423a28b3641'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT 'b5c0906d-03bb-4f0b-a24f-8e6796964607', r.id, s.id, 4, 1, NULL, 277000
FROM public.releases r, public.songs s WHERE r.mbid = 'dd272163-c99e-4190-98dc-01a149926b71' AND s.mbid = '0d074f82-2c45-46a7-857a-683d9d92a9ff'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('9eb4397b-23d4-43a2-81df-ad5a735f155a', '9258243d-db6d-4087-94c3-d354642cba02', '風になってゆく', '菅田将暉', 237000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '9258243d-db6d-4087-94c3-d354642cba02' AND ar.mbid = '264955bb-3412-4ab5-9ba5-4423a28b3641'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '899162dd-10f5-462d-b4bf-4f98c819f080', r.id, s.id, 5, 1, NULL, 237000
FROM public.releases r, public.songs s WHERE r.mbid = 'dd272163-c99e-4190-98dc-01a149926b71' AND s.mbid = '9258243d-db6d-4087-94c3-d354642cba02'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('fe8ed5b4-6a39-4a61-81e0-d58331698a2b', '40860f9f-cd81-4a24-98d4-ccc512eeda41', '台詞', '菅田将暉', 302000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '40860f9f-cd81-4a24-98d4-ccc512eeda41' AND ar.mbid = '264955bb-3412-4ab5-9ba5-4423a28b3641'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT 'c1b2a293-fa36-46fd-9beb-c4a82eb3eadf', r.id, s.id, 6, 1, NULL, 302000
FROM public.releases r, public.songs s WHERE r.mbid = 'dd272163-c99e-4190-98dc-01a149926b71' AND s.mbid = '40860f9f-cd81-4a24-98d4-ccc512eeda41'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('9492adeb-94d2-4d5d-aa6c-9e94814ba675', 'f8cec5b9-cf19-475d-8170-bb8821b5404a', 'スプリンター', '菅田将暉', 336000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = 'f8cec5b9-cf19-475d-8170-bb8821b5404a' AND ar.mbid = '264955bb-3412-4ab5-9ba5-4423a28b3641'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '6800f143-810a-49f1-9ef2-c83f8597ff6f', r.id, s.id, 7, 1, NULL, 336000
FROM public.releases r, public.songs s WHERE r.mbid = 'dd272163-c99e-4190-98dc-01a149926b71' AND s.mbid = 'f8cec5b9-cf19-475d-8170-bb8821b5404a'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('3a311a8c-8563-4b32-baf4-7b5168275297', '50b02d6d-8dae-4dfb-bb2b-ac9fefaf24b2', 'ゆらゆら', '菅田将暉', 283000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '50b02d6d-8dae-4dfb-bb2b-ac9fefaf24b2' AND ar.mbid = '264955bb-3412-4ab5-9ba5-4423a28b3641'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT 'dfde2461-e54a-41be-8713-bc1b8a055aa0', r.id, s.id, 8, 1, NULL, 283000
FROM public.releases r, public.songs s WHERE r.mbid = 'dd272163-c99e-4190-98dc-01a149926b71' AND s.mbid = '50b02d6d-8dae-4dfb-bb2b-ac9fefaf24b2'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('1481d9ee-5dce-4243-a1a9-191ccf3d7ab3', '5099e3f1-135e-437c-8d88-3fb38a655c70', '呼吸', '菅田将暉', 249000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '5099e3f1-135e-437c-8d88-3fb38a655c70' AND ar.mbid = '264955bb-3412-4ab5-9ba5-4423a28b3641'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT 'db4df24d-4f2d-4183-8633-256ecef54b6c', r.id, s.id, 9, 1, NULL, 249000
FROM public.releases r, public.songs s WHERE r.mbid = 'dd272163-c99e-4190-98dc-01a149926b71' AND s.mbid = '5099e3f1-135e-437c-8d88-3fb38a655c70'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('992503fa-1695-48bc-b66f-0f4f4e568222', 'caee7a4c-125b-4cb5-b3bf-3faaab8e6281', '浅草キッド', '菅田将暉×桐谷健太', 244000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = 'caee7a4c-125b-4cb5-b3bf-3faaab8e6281' AND ar.mbid = '264955bb-3412-4ab5-9ba5-4423a28b3641'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.artists (id, mbid, name, sort_name, type, country, life_begin, life_end, disambiguation)
VALUES ('de0f0baf-5135-489e-b6c8-79848ad0e16c', '4b1bd965-ce3f-4d0b-9270-619495e25e79', '桐谷健太', 'Kiritani, Kenta', 'PERSON', 'JP', '1980-02-04', NULL, '')
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'featured', 1 FROM public.songs s, public.artists ar
WHERE s.mbid = 'caee7a4c-125b-4cb5-b3bf-3faaab8e6281' AND ar.mbid = '4b1bd965-ce3f-4d0b-9270-619495e25e79'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '11896571-6f13-4d6a-bfe9-426ef1f3d76e', r.id, s.id, 10, 1, NULL, 244000
FROM public.releases r, public.songs s WHERE r.mbid = 'dd272163-c99e-4190-98dc-01a149926b71' AND s.mbid = 'caee7a4c-125b-4cb5-b3bf-3faaab8e6281'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('b5bf2330-2a65-44e5-bfd0-f0f453e8bd0e', '6f58d52c-dd4d-456e-bd88-b1a5d4a1d51c', '灰色と青', '米津玄師 + 菅田将暉', 332186)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.artists (id, mbid, name, sort_name, type, country, life_begin, life_end, disambiguation)
VALUES ('e945c219-da75-4209-a1cc-66d40e7e2f97', '09d4a85c-4916-4b4e-bc96-c4cfcf371046', '米津玄師', 'Yonezu, Kenshi', 'PERSON', 'JP', '1991-03-10', NULL, '')
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '6f58d52c-dd4d-456e-bd88-b1a5d4a1d51c' AND ar.mbid = '09d4a85c-4916-4b4e-bc96-c4cfcf371046'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'featured', 1 FROM public.songs s, public.artists ar
WHERE s.mbid = '6f58d52c-dd4d-456e-bd88-b1a5d4a1d51c' AND ar.mbid = '264955bb-3412-4ab5-9ba5-4423a28b3641'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '973913ea-2d51-492a-abba-2a72fba1d608', r.id, s.id, 11, 1, NULL, 336000
FROM public.releases r, public.songs s WHERE r.mbid = 'dd272163-c99e-4190-98dc-01a149926b71' AND s.mbid = '6f58d52c-dd4d-456e-bd88-b1a5d4a1d51c'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('6f828224-d1ff-49b1-9c56-e85aa5e96063', '76d412d9-43c6-4f65-875c-ed2ca94ca8ab', '茜色の夕日', '菅田将暉', 324000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '76d412d9-43c6-4f65-875c-ed2ca94ca8ab' AND ar.mbid = '264955bb-3412-4ab5-9ba5-4423a28b3641'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '6c9791e2-1c9f-4c0e-a55a-9ae399cb7314', r.id, s.id, 12, 1, NULL, 324000
FROM public.releases r, public.songs s WHERE r.mbid = 'dd272163-c99e-4190-98dc-01a149926b71' AND s.mbid = '76d412d9-43c6-4f65-875c-ed2ca94ca8ab'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.artists (id, mbid, name, sort_name, type, country, life_begin, life_end, disambiguation)
VALUES ('8068524b-85db-4187-8952-3ffa3625fea6', '09d4a85c-4916-4b4e-bc96-c4cfcf371046', '米津玄師', 'Yonezu, Kenshi', 'PERSON', 'JP', '1991-03-10', NULL, '')
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.albums (id, mbid, title, artist_credit, primary_type, first_release_date)
VALUES ('6c36798b-a4af-4eca-9e9b-858e8896d541', '407206ec-76f5-4715-bce9-01f68abe47ff', 'diorama', '米津玄師', 'Album', '2012-05-16')
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.album_artists (album_id, artist_id, position)
SELECT a.id, ar.id, 0 FROM public.albums a, public.artists ar
WHERE a.mbid = '407206ec-76f5-4715-bce9-01f68abe47ff' AND ar.mbid = '09d4a85c-4916-4b4e-bc96-c4cfcf371046'
ON CONFLICT (album_id, artist_id) DO NOTHING;
INSERT INTO public.releases (id, mbid, album_id, title, status, country, release_date, release_date_precision, barcode, language, script)
SELECT '3bd63161-14d0-40ff-a7c6-a4b76d7a42fa', '2c0f7c17-4ac1-4b36-bb9c-1b951fca4513', albums.id, 'diorama', 'Official', 'JP', '2012-05-16', 'day', '4571192983229', 'jpn', 'Jpan'
FROM public.albums WHERE mbid = '407206ec-76f5-4715-bce9-01f68abe47ff'
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('d3ae0f65-829c-47fd-bacc-dbb81a9c4dea', '5cf220f3-6a9f-49cb-b332-e21b684f6f3e', '街', '米津玄師', 340320)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '5cf220f3-6a9f-49cb-b332-e21b684f6f3e' AND ar.mbid = '09d4a85c-4916-4b4e-bc96-c4cfcf371046'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '2ff913a7-20f3-42b8-b828-c1e344a26c5e', r.id, s.id, 1, 1, NULL, 340320
FROM public.releases r, public.songs s WHERE r.mbid = '2c0f7c17-4ac1-4b36-bb9c-1b951fca4513' AND s.mbid = '5cf220f3-6a9f-49cb-b332-e21b684f6f3e'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('b803d792-abd0-4145-864b-831a290342ea', '420d41b4-f2e4-459f-90dd-5c752b989eb4', 'ゴーゴー幽霊船', '米津玄師', 229640)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '420d41b4-f2e4-459f-90dd-5c752b989eb4' AND ar.mbid = '09d4a85c-4916-4b4e-bc96-c4cfcf371046'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '8b172476-bfa9-4dba-b503-aeb31ccf381d', r.id, s.id, 2, 1, NULL, 229640
FROM public.releases r, public.songs s WHERE r.mbid = '2c0f7c17-4ac1-4b36-bb9c-1b951fca4513' AND s.mbid = '420d41b4-f2e4-459f-90dd-5c752b989eb4'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('1a15646a-cd52-4654-a97c-102761037b89', 'e6c55047-9205-4ced-b413-1a37a5bd16cc', '駄菓子屋商売', '米津玄師', 274533)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = 'e6c55047-9205-4ced-b413-1a37a5bd16cc' AND ar.mbid = '09d4a85c-4916-4b4e-bc96-c4cfcf371046'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '3905725d-c728-4aed-a13d-20ce7850f565', r.id, s.id, 3, 1, NULL, 274533
FROM public.releases r, public.songs s WHERE r.mbid = '2c0f7c17-4ac1-4b36-bb9c-1b951fca4513' AND s.mbid = 'e6c55047-9205-4ced-b413-1a37a5bd16cc'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('d9401ff4-949e-4637-b75c-421ce2735fc4', '3299b7ec-da0d-4750-a94a-591eb68d9772', 'caribou', '米津玄師', 255480)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '3299b7ec-da0d-4750-a94a-591eb68d9772' AND ar.mbid = '09d4a85c-4916-4b4e-bc96-c4cfcf371046'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '775aabd1-e07c-4ea3-a71c-6a036ca4b52f', r.id, s.id, 4, 1, NULL, 255480
FROM public.releases r, public.songs s WHERE r.mbid = '2c0f7c17-4ac1-4b36-bb9c-1b951fca4513' AND s.mbid = '3299b7ec-da0d-4750-a94a-591eb68d9772'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('69c0c247-0842-4ea8-8071-dd219af78d78', '2d754163-7bfb-419f-ad16-3eefc1f327f0', 'あめふり婦人', '米津玄師', 179466)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '2d754163-7bfb-419f-ad16-3eefc1f327f0' AND ar.mbid = '09d4a85c-4916-4b4e-bc96-c4cfcf371046'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT 'edf119e3-c202-4c17-8bab-66873f53bd54', r.id, s.id, 5, 1, NULL, 179466
FROM public.releases r, public.songs s WHERE r.mbid = '2c0f7c17-4ac1-4b36-bb9c-1b951fca4513' AND s.mbid = '2d754163-7bfb-419f-ad16-3eefc1f327f0'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('854d1d77-bc75-4ee1-8244-c4a4efb99b93', 'a9dcc2be-b269-4674-b978-0f61a9b034de', 'ディスコバルーン', '米津玄師', 263680)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = 'a9dcc2be-b269-4674-b978-0f61a9b034de' AND ar.mbid = '09d4a85c-4916-4b4e-bc96-c4cfcf371046'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT 'a1afe0e1-727c-43d3-b6a4-3c5893e912f8', r.id, s.id, 6, 1, NULL, 263680
FROM public.releases r, public.songs s WHERE r.mbid = '2c0f7c17-4ac1-4b36-bb9c-1b951fca4513' AND s.mbid = 'a9dcc2be-b269-4674-b978-0f61a9b034de'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('63c099fc-a016-4e2b-87f9-6e13ba357a5b', '5d9a05a9-df8a-4500-80ec-acd6916e717a', 'vivi', '米津玄師', 270733)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '5d9a05a9-df8a-4500-80ec-acd6916e717a' AND ar.mbid = '09d4a85c-4916-4b4e-bc96-c4cfcf371046'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '9d6f308d-ae12-40fe-acee-b3d29b97dbd3', r.id, s.id, 7, 1, NULL, 270733
FROM public.releases r, public.songs s WHERE r.mbid = '2c0f7c17-4ac1-4b36-bb9c-1b951fca4513' AND s.mbid = '5d9a05a9-df8a-4500-80ec-acd6916e717a'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('fdc41999-e91a-419e-b6b5-d73ef381b6f9', 'f703b299-6acf-4486-8357-f095331b711e', 'トイパトリオット', '米津玄師', 253626)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = 'f703b299-6acf-4486-8357-f095331b711e' AND ar.mbid = '09d4a85c-4916-4b4e-bc96-c4cfcf371046'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '6cf219ba-9057-4c32-abb4-d94cbc4dead1', r.id, s.id, 8, 1, NULL, 253626
FROM public.releases r, public.songs s WHERE r.mbid = '2c0f7c17-4ac1-4b36-bb9c-1b951fca4513' AND s.mbid = 'f703b299-6acf-4486-8357-f095331b711e'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('423e229f-468a-4d1a-810f-cd13d636f55e', '17e4ffc6-2468-4aaf-8b2a-56dc45b6c900', '恋と病熱', '米津玄師', 262533)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '17e4ffc6-2468-4aaf-8b2a-56dc45b6c900' AND ar.mbid = '09d4a85c-4916-4b4e-bc96-c4cfcf371046'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT 'c2b9cb2b-2b19-4f94-8d53-38351dcdea3c', r.id, s.id, 9, 1, NULL, 262533
FROM public.releases r, public.songs s WHERE r.mbid = '2c0f7c17-4ac1-4b36-bb9c-1b951fca4513' AND s.mbid = '17e4ffc6-2468-4aaf-8b2a-56dc45b6c900'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('0fa203ba-63df-4d92-96d7-e9f2e6414abe', '5b67ec2a-f1a3-44c8-ba1c-f366005e25f6', 'Black Sheep', '米津玄師', 309826)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '5b67ec2a-f1a3-44c8-ba1c-f366005e25f6' AND ar.mbid = '09d4a85c-4916-4b4e-bc96-c4cfcf371046'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT 'ed293bec-9c04-48e0-981f-a922df5c27c8', r.id, s.id, 10, 1, NULL, 309826
FROM public.releases r, public.songs s WHERE r.mbid = '2c0f7c17-4ac1-4b36-bb9c-1b951fca4513' AND s.mbid = '5b67ec2a-f1a3-44c8-ba1c-f366005e25f6'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('c611929b-d655-4e06-907d-64d729d9056f', '8f045929-6142-4d1f-9797-8915ced2dbd9', '乾涸びたバスひとつ', '米津玄師', 308773)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '8f045929-6142-4d1f-9797-8915ced2dbd9' AND ar.mbid = '09d4a85c-4916-4b4e-bc96-c4cfcf371046'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '014ec7c0-81e3-4825-964f-7e9cdb286018', r.id, s.id, 11, 1, NULL, 308773
FROM public.releases r, public.songs s WHERE r.mbid = '2c0f7c17-4ac1-4b36-bb9c-1b951fca4513' AND s.mbid = '8f045929-6142-4d1f-9797-8915ced2dbd9'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('1b8e8991-20a9-40b0-af07-1f9fdf7d1640', 'f24f69cb-d8e6-43bc-bbd8-96162133f22b', '首なし閑古鳥', '米津玄師', 263706)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = 'f24f69cb-d8e6-43bc-bbd8-96162133f22b' AND ar.mbid = '09d4a85c-4916-4b4e-bc96-c4cfcf371046'
ON CONFLICT (song_id, artist_id) DO NOTHING;
