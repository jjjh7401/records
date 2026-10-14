-- Phase C seed batch LEAN: J-POP artists core tables only (idempotent)
-- artists/albums/releases/songs/tracks + link tables.
-- Source: MusicBrainz (canonical).
INSERT INTO public.artists (id, mbid, name, sort_name, type, country, life_begin, life_end, disambiguation)
VALUES ('199af9bc-e114-453d-87fb-c07872d6d501', '6dddd7a2-5583-49d0-a8b2-9ee46d04f27e', 'Official髭男dism', 'Official HIGE DANdism', 'GROUP', 'JP', '2012-06-07', NULL, '')
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.albums (id, mbid, title, artist_credit, primary_type, first_release_date)
VALUES ('f257cba7-a966-4318-9fb0-bac2813c23bf', 'b5b77c44-1b13-4dca-8e8a-b9bac5f174a5', 'ラブとピースは君の中', 'Official髭男dism', 'Album', '2015-04-22')
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.album_artists (album_id, artist_id, position)
SELECT a.id, ar.id, 0 FROM public.albums a, public.artists ar
WHERE a.mbid = 'b5b77c44-1b13-4dca-8e8a-b9bac5f174a5' AND ar.mbid = '6dddd7a2-5583-49d0-a8b2-9ee46d04f27e'
ON CONFLICT (album_id, artist_id) DO NOTHING;
INSERT INTO public.releases (id, mbid, album_id, title, status, country, release_date, release_date_precision, barcode, language, script)
SELECT '92e70037-c73d-4ee8-8c26-2c84e1d0d21e', 'ae958c0e-1854-426e-b1ba-3b6ef0203df3', albums.id, 'ラブとピースは君の中', 'Official', 'JP', '2015-04-22', 'day', '4519552003804', 'jpn', 'Latn'
FROM public.albums WHERE mbid = 'b5b77c44-1b13-4dca-8e8a-b9bac5f174a5'
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('5a7532c5-1d86-412a-bcbc-d933f5eebcf5', '9eeeba36-5a19-4b14-a9fa-4c75058fc827', 'SWEET TWEET', 'Official髭男dism', 295373)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '9eeeba36-5a19-4b14-a9fa-4c75058fc827' AND ar.mbid = '6dddd7a2-5583-49d0-a8b2-9ee46d04f27e'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT 'c11cc276-afe1-48fc-a9e2-99226bf9cb43', r.id, s.id, 1, 1, NULL, 295373
FROM public.releases r, public.songs s WHERE r.mbid = 'ae958c0e-1854-426e-b1ba-3b6ef0203df3' AND s.mbid = '9eeeba36-5a19-4b14-a9fa-4c75058fc827'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('8d05d4d4-7e2c-4fd7-abac-9f0ce35af9d2', '41571111-584e-4294-b200-ceba094f5c8a', '恋の前ならえ', 'Official髭男dism', 209427)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '41571111-584e-4294-b200-ceba094f5c8a' AND ar.mbid = '6dddd7a2-5583-49d0-a8b2-9ee46d04f27e'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '548e0f66-9c88-4a1b-a47d-153081003fd3', r.id, s.id, 2, 1, NULL, 209427
FROM public.releases r, public.songs s WHERE r.mbid = 'ae958c0e-1854-426e-b1ba-3b6ef0203df3' AND s.mbid = '41571111-584e-4294-b200-ceba094f5c8a'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('731e1ce1-f3f6-4d3c-b797-af4bfe3ce0fe', '77bac955-1e89-4f1a-b276-d5254bbeea35', '夕暮れ沿い', 'Official髭男dism', 246267)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '77bac955-1e89-4f1a-b276-d5254bbeea35' AND ar.mbid = '6dddd7a2-5583-49d0-a8b2-9ee46d04f27e'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '26371f04-531f-4f17-a488-258aca15ffc2', r.id, s.id, 3, 1, NULL, 246267
FROM public.releases r, public.songs s WHERE r.mbid = 'ae958c0e-1854-426e-b1ba-3b6ef0203df3' AND s.mbid = '77bac955-1e89-4f1a-b276-d5254bbeea35'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('230728b8-3ef3-4eb6-aa31-1718128d1e2e', '9fdf28c4-861f-46b5-ae01-9bccaaa270ef', '雪急く朝が来る', 'Official髭男dism', 197213)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '9fdf28c4-861f-46b5-ae01-9bccaaa270ef' AND ar.mbid = '6dddd7a2-5583-49d0-a8b2-9ee46d04f27e'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT 'ad9a964d-ec62-4d62-9988-46923aa97eb9', r.id, s.id, 4, 1, NULL, 197213
FROM public.releases r, public.songs s WHERE r.mbid = 'ae958c0e-1854-426e-b1ba-3b6ef0203df3' AND s.mbid = '9fdf28c4-861f-46b5-ae01-9bccaaa270ef'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('90ea214d-3b7f-4bbe-b5e7-71bac6d2527d', '28e6ab57-5b4a-4b67-b9e0-b51c3221b056', '始発が導く幸福論', 'Official髭男dism', 298133)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '28e6ab57-5b4a-4b67-b9e0-b51c3221b056' AND ar.mbid = '6dddd7a2-5583-49d0-a8b2-9ee46d04f27e'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT 'cba63288-8069-4aee-a363-ebb71913308c', r.id, s.id, 5, 1, NULL, 298133
FROM public.releases r, public.songs s WHERE r.mbid = 'ae958c0e-1854-426e-b1ba-3b6ef0203df3' AND s.mbid = '28e6ab57-5b4a-4b67-b9e0-b51c3221b056'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('149ba85f-580b-45f0-bb24-3bd8bfbe6a30', 'e6b738b7-6542-4a16-9e9d-2e37ef7e471d', '愛なんだが…', 'Official髭男dism', 259000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = 'e6b738b7-6542-4a16-9e9d-2e37ef7e471d' AND ar.mbid = '6dddd7a2-5583-49d0-a8b2-9ee46d04f27e'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '281c0de0-f4dc-4c06-8e0d-c1da6c83d3f9', r.id, s.id, 6, 1, NULL, 259000
FROM public.releases r, public.songs s WHERE r.mbid = 'ae958c0e-1854-426e-b1ba-3b6ef0203df3' AND s.mbid = 'e6b738b7-6542-4a16-9e9d-2e37ef7e471d'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('f02aed37-11b3-4c39-8c2c-8c170e2a1e92', 'dff2bcf8-dc5a-4557-9a3c-1eae6c39fee1', 'parade', 'Official髭男dism', 280320)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = 'dff2bcf8-dc5a-4557-9a3c-1eae6c39fee1' AND ar.mbid = '6dddd7a2-5583-49d0-a8b2-9ee46d04f27e'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT 'f1d7ded3-fb75-47f7-ba0f-4a44a5ad25ab', r.id, s.id, 7, 1, NULL, 280320
FROM public.releases r, public.songs s WHERE r.mbid = 'ae958c0e-1854-426e-b1ba-3b6ef0203df3' AND s.mbid = 'dff2bcf8-dc5a-4557-9a3c-1eae6c39fee1'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('4243aa2b-32e3-44bb-b3de-ea027e673d41', 'b9b9a14d-9c40-44e3-9717-82585c009ea0', 'ダーリン。', 'Official髭男dism', 314240)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = 'b9b9a14d-9c40-44e3-9717-82585c009ea0' AND ar.mbid = '6dddd7a2-5583-49d0-a8b2-9ee46d04f27e'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT 'a3c100d2-9c2d-4e22-95c4-5ace8c08ea6b', r.id, s.id, 8, 1, NULL, 314240
FROM public.releases r, public.songs s WHERE r.mbid = 'ae958c0e-1854-426e-b1ba-3b6ef0203df3' AND s.mbid = 'b9b9a14d-9c40-44e3-9717-82585c009ea0'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.artists (id, mbid, name, sort_name, type, country, life_begin, life_end, disambiguation)
VALUES ('50f7970a-1fa6-40b1-b945-8fe918fa3521', '338f5d97-3133-4bf8-a58e-068ff9b5405d', 'King Gnu', 'King Gnu', 'GROUP', 'JP', '2013', NULL, 'fka Srv.Vinci')
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.albums (id, mbid, title, artist_credit, primary_type, first_release_date)
VALUES ('b580c27e-496c-478b-a252-84cebef591b7', 'e1b66382-821e-4b81-a900-4d001dc45c92', 'Mad Me More Softly', 'Srv.Vinci', 'Album', '2015-09-16')
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.album_artists (album_id, artist_id, position)
SELECT a.id, ar.id, 0 FROM public.albums a, public.artists ar
WHERE a.mbid = 'e1b66382-821e-4b81-a900-4d001dc45c92' AND ar.mbid = '338f5d97-3133-4bf8-a58e-068ff9b5405d'
ON CONFLICT (album_id, artist_id) DO NOTHING;
INSERT INTO public.releases (id, mbid, album_id, title, status, country, release_date, release_date_precision, barcode, language, script)
SELECT 'a6628c8b-1a16-4ff5-9961-c7d855d81b35', 'f4f63818-5665-41ea-b142-be29a1c4b740', albums.id, 'Mad Me More Softly', 'Official', 'JP', '2015-09-16', 'day', '4582169615876', 'jpn', 'Jpan'
FROM public.albums WHERE mbid = 'e1b66382-821e-4b81-a900-4d001dc45c92'
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('b2a2a9cd-cdfc-41de-ae62-acbba5f87476', 'e8e27d38-c419-4528-9bfc-c26bd6ed38b9', 'Devil''s MC', 'Srv.Vinci', 79400)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = 'e8e27d38-c419-4528-9bfc-c26bd6ed38b9' AND ar.mbid = '338f5d97-3133-4bf8-a58e-068ff9b5405d'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '6a7dea02-53b5-4085-878c-ba26f1381632', r.id, s.id, 1, 1, NULL, 79400
FROM public.releases r, public.songs s WHERE r.mbid = 'f4f63818-5665-41ea-b142-be29a1c4b740' AND s.mbid = 'e8e27d38-c419-4528-9bfc-c26bd6ed38b9'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('57ff1417-7672-4955-a529-ac19a337b1a2', 'b70314e0-36be-4e64-8c53-8b56a76ba8f2', 'PPL', 'Srv.Vinci', 192840)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = 'b70314e0-36be-4e64-8c53-8b56a76ba8f2' AND ar.mbid = '338f5d97-3133-4bf8-a58e-068ff9b5405d'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '9ab739f6-e493-47bf-a42b-1d9867196fbd', r.id, s.id, 2, 1, NULL, 192840
FROM public.releases r, public.songs s WHERE r.mbid = 'f4f63818-5665-41ea-b142-be29a1c4b740' AND s.mbid = 'b70314e0-36be-4e64-8c53-8b56a76ba8f2'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('b000e2c5-1fff-44cb-b731-4117b8e4d651', '44b645e6-d79a-4048-bd55-d4e75e27f110', 'Heroine', 'Srv.Vinci', 142867)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '44b645e6-d79a-4048-bd55-d4e75e27f110' AND ar.mbid = '338f5d97-3133-4bf8-a58e-068ff9b5405d'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '66b6e81b-00a2-4123-9613-d5cbd41b98f2', r.id, s.id, 3, 1, NULL, 142867
FROM public.releases r, public.songs s WHERE r.mbid = 'f4f63818-5665-41ea-b142-be29a1c4b740' AND s.mbid = '44b645e6-d79a-4048-bd55-d4e75e27f110'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('c54d1f9c-88a7-4da9-9339-4414bae06c06', '6f796ea7-df3f-4a64-a5ac-43d9ff345268', 'Those Sunny Smiles', 'Srv.Vinci', 231120)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '6f796ea7-df3f-4a64-a5ac-43d9ff345268' AND ar.mbid = '338f5d97-3133-4bf8-a58e-068ff9b5405d'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '290fc497-7891-43bf-a38d-910665243f34', r.id, s.id, 4, 1, NULL, 231120
FROM public.releases r, public.songs s WHERE r.mbid = 'f4f63818-5665-41ea-b142-be29a1c4b740' AND s.mbid = '6f796ea7-df3f-4a64-a5ac-43d9ff345268'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('f39f6135-369f-4b0b-9997-6fe2eb45eb5b', '293af842-cbe8-4100-89f2-b0c97876ee34', 'Mommy''s Tummy', 'Srv.Vinci', 155613)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '293af842-cbe8-4100-89f2-b0c97876ee34' AND ar.mbid = '338f5d97-3133-4bf8-a58e-068ff9b5405d'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '69895af5-fd67-4d8a-985f-f3232f307e51', r.id, s.id, 5, 1, NULL, 155613
FROM public.releases r, public.songs s WHERE r.mbid = 'f4f63818-5665-41ea-b142-be29a1c4b740' AND s.mbid = '293af842-cbe8-4100-89f2-b0c97876ee34'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('47d8ad95-b477-4c69-989d-e08fc012db11', '0bf85cd7-63a3-45fd-9459-8f3cc95e3a46', 'Zero Gravity Toilet', 'Srv.Vinci', 152400)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '0bf85cd7-63a3-45fd-9459-8f3cc95e3a46' AND ar.mbid = '338f5d97-3133-4bf8-a58e-068ff9b5405d'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT 'd6fa79e3-a645-48a9-bd49-52d3eb04a8a9', r.id, s.id, 6, 1, NULL, 152400
FROM public.releases r, public.songs s WHERE r.mbid = 'f4f63818-5665-41ea-b142-be29a1c4b740' AND s.mbid = '0bf85cd7-63a3-45fd-9459-8f3cc95e3a46'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('4b08c8d7-c35f-4331-ba80-42dde9c1f2ba', '013e6bc2-513c-4868-905d-5c49b6c9cb0a', 'Diving To You', 'Srv.Vinci', 181080)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '013e6bc2-513c-4868-905d-5c49b6c9cb0a' AND ar.mbid = '338f5d97-3133-4bf8-a58e-068ff9b5405d'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '65f660cb-76d3-4115-b90f-1f444173d790', r.id, s.id, 7, 1, NULL, 181080
FROM public.releases r, public.songs s WHERE r.mbid = 'f4f63818-5665-41ea-b142-be29a1c4b740' AND s.mbid = '013e6bc2-513c-4868-905d-5c49b6c9cb0a'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('aa1dbf8b-88be-40b2-b3bb-68b81c730b55', '0a1f2704-4237-4cb2-8e78-721af87bfa16', 'Abnormal Pressure', 'Srv.Vinci', 291560)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '0a1f2704-4237-4cb2-8e78-721af87bfa16' AND ar.mbid = '338f5d97-3133-4bf8-a58e-068ff9b5405d'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT 'ef333e96-f2c8-455e-b5a5-6482e0d66df7', r.id, s.id, 8, 1, NULL, 291560
FROM public.releases r, public.songs s WHERE r.mbid = 'f4f63818-5665-41ea-b142-be29a1c4b740' AND s.mbid = '0a1f2704-4237-4cb2-8e78-721af87bfa16'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('04477cbf-871c-423f-ba2b-2bc11bb9b6a5', '521fc747-bf44-4d93-a29c-bea82e2326c8', 'Plastic Rain', 'Srv.Vinci', 265293)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '521fc747-bf44-4d93-a29c-bea82e2326c8' AND ar.mbid = '338f5d97-3133-4bf8-a58e-068ff9b5405d'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '3a02f442-743a-4534-a735-4264f57a9dc0', r.id, s.id, 9, 1, NULL, 265293
FROM public.releases r, public.songs s WHERE r.mbid = 'f4f63818-5665-41ea-b142-be29a1c4b740' AND s.mbid = '521fc747-bf44-4d93-a29c-bea82e2326c8'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('5301cc14-393e-4bb4-a0d2-7e5ae0fd000c', 'a84ab026-8563-4998-9262-3ea547744f32', '"I''m Outta Here"', 'Srv.Vinci', 77507)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = 'a84ab026-8563-4998-9262-3ea547744f32' AND ar.mbid = '338f5d97-3133-4bf8-a58e-068ff9b5405d'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT 'ee775897-02d3-4a9b-9ce5-c0fe529affea', r.id, s.id, 10, 1, NULL, 77507
FROM public.releases r, public.songs s WHERE r.mbid = 'f4f63818-5665-41ea-b142-be29a1c4b740' AND s.mbid = 'a84ab026-8563-4998-9262-3ea547744f32'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.artists (id, mbid, name, sort_name, type, country, life_begin, life_end, disambiguation)
VALUES ('37a60304-d539-4cb5-946c-dac4d47293b7', '9ce674b7-5180-41f7-9ac2-95dc0d8a0ed2', 'Mrs. GREEN APPLE', 'Mrs. GREEN APPLE', 'GROUP', 'JP', '2013', NULL, '')
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.albums (id, mbid, title, artist_credit, primary_type, first_release_date)
VALUES ('717ce5e5-4dba-486c-b9f7-adf255de495e', 'fa8b4100-c899-4738-af3c-35f42d1f6f6a', 'TWELVE', 'Mrs. GREEN APPLE', 'Album', '2016-01-13')
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.album_artists (album_id, artist_id, position)
SELECT a.id, ar.id, 0 FROM public.albums a, public.artists ar
WHERE a.mbid = 'fa8b4100-c899-4738-af3c-35f42d1f6f6a' AND ar.mbid = '9ce674b7-5180-41f7-9ac2-95dc0d8a0ed2'
ON CONFLICT (album_id, artist_id) DO NOTHING;
INSERT INTO public.releases (id, mbid, album_id, title, status, country, release_date, release_date_precision, barcode, language, script)
SELECT '85d48db9-7930-4ffd-ba88-1fdd7a204fb8', 'aee17129-c737-4710-ac7f-bddb9cdd3bb2', albums.id, 'TWELVE', 'Official', 'JP', '2016-01-13', 'day', '4988031129166', 'jpn', 'Jpan'
FROM public.albums WHERE mbid = 'fa8b4100-c899-4738-af3c-35f42d1f6f6a'
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('b9aaf4db-171b-40c4-b4f2-5d5a0705f562', '4f924048-2707-4647-b047-43cd95efbf78', '愛情と矛先', 'Mrs. GREEN APPLE', 235000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '4f924048-2707-4647-b047-43cd95efbf78' AND ar.mbid = '9ce674b7-5180-41f7-9ac2-95dc0d8a0ed2'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '42587dd6-2b2c-4580-85a8-f01c7483acdc', r.id, s.id, 1, 1, NULL, 235000
FROM public.releases r, public.songs s WHERE r.mbid = 'aee17129-c737-4710-ac7f-bddb9cdd3bb2' AND s.mbid = '4f924048-2707-4647-b047-43cd95efbf78'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('4adc0045-6c16-4f8e-9573-6db2d783a88c', '38652258-0b40-4af6-91d7-33d4d554fbb4', 'Speaking', 'Mrs. GREEN APPLE', 229160)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '38652258-0b40-4af6-91d7-33d4d554fbb4' AND ar.mbid = '9ce674b7-5180-41f7-9ac2-95dc0d8a0ed2'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT 'ffbb89d7-3865-461f-85dd-5ccd06037889', r.id, s.id, 2, 1, NULL, 230000
FROM public.releases r, public.songs s WHERE r.mbid = 'aee17129-c737-4710-ac7f-bddb9cdd3bb2' AND s.mbid = '38652258-0b40-4af6-91d7-33d4d554fbb4'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('c26f835a-c46d-4162-8211-6dabb0bee61f', 'b655051a-87c2-4750-b1d6-8534ffa45c1d', 'パブリック', 'Mrs. GREEN APPLE', 225533)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = 'b655051a-87c2-4750-b1d6-8534ffa45c1d' AND ar.mbid = '9ce674b7-5180-41f7-9ac2-95dc0d8a0ed2'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT 'e19d27fc-9f22-496e-b054-87817800d5e5', r.id, s.id, 3, 1, NULL, 226000
FROM public.releases r, public.songs s WHERE r.mbid = 'aee17129-c737-4710-ac7f-bddb9cdd3bb2' AND s.mbid = 'b655051a-87c2-4750-b1d6-8534ffa45c1d'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('d2c2376f-2ea4-4a44-aadf-be1d7c2b89ea', '5fc173de-b9af-4659-9af7-9db888ebac04', '藍', 'Mrs. GREEN APPLE', 241000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '5fc173de-b9af-4659-9af7-9db888ebac04' AND ar.mbid = '9ce674b7-5180-41f7-9ac2-95dc0d8a0ed2'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '7751f307-1b90-4b67-bfb0-de2db81a155c', r.id, s.id, 4, 1, '藍(あお)', 241000
FROM public.releases r, public.songs s WHERE r.mbid = 'aee17129-c737-4710-ac7f-bddb9cdd3bb2' AND s.mbid = '5fc173de-b9af-4659-9af7-9db888ebac04'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('1d757181-ba2a-4b3b-b8f2-840abe62d8ca', '37eb728e-1dc1-45b2-81de-2138acca5d47', 'キコリ時計', 'Mrs. GREEN APPLE', 215000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '37eb728e-1dc1-45b2-81de-2138acca5d47' AND ar.mbid = '9ce674b7-5180-41f7-9ac2-95dc0d8a0ed2'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '628fb504-d75d-483c-94b6-9978185734ff', r.id, s.id, 5, 1, NULL, 215000
FROM public.releases r, public.songs s WHERE r.mbid = 'aee17129-c737-4710-ac7f-bddb9cdd3bb2' AND s.mbid = '37eb728e-1dc1-45b2-81de-2138acca5d47'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('b52a637a-9f47-4533-8ce6-a2caf267bb90', '53843d47-25e3-4c77-8f74-de98d7c53abf', '私', 'Mrs. GREEN APPLE', 369000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '53843d47-25e3-4c77-8f74-de98d7c53abf' AND ar.mbid = '9ce674b7-5180-41f7-9ac2-95dc0d8a0ed2'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT 'ece82cff-5f8f-42ae-9384-07d87a2ae597', r.id, s.id, 6, 1, NULL, 369000
FROM public.releases r, public.songs s WHERE r.mbid = 'aee17129-c737-4710-ac7f-bddb9cdd3bb2' AND s.mbid = '53843d47-25e3-4c77-8f74-de98d7c53abf'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('c040326f-8be7-46e4-a7e8-9f5c83acfcaf', '13305a6c-f36c-4bfa-b2b2-fa68548e474f', 'No.7', 'Mrs. GREEN APPLE', 271000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '13305a6c-f36c-4bfa-b2b2-fa68548e474f' AND ar.mbid = '9ce674b7-5180-41f7-9ac2-95dc0d8a0ed2'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '8fc8f751-31a0-41d4-9d70-fe8eecf53d03', r.id, s.id, 7, 1, NULL, 271000
FROM public.releases r, public.songs s WHERE r.mbid = 'aee17129-c737-4710-ac7f-bddb9cdd3bb2' AND s.mbid = '13305a6c-f36c-4bfa-b2b2-fa68548e474f'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('22bdaff2-b2a8-4649-a89b-9b70bcb0e405', '74bf9a1e-3cdf-4a8c-a8a4-11c55f96b37e', 'ミスカサズ', 'Mrs. GREEN APPLE', 262000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '74bf9a1e-3cdf-4a8c-a8a4-11c55f96b37e' AND ar.mbid = '9ce674b7-5180-41f7-9ac2-95dc0d8a0ed2'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT 'ec4474cb-527d-43b3-b69e-82f593bd266e', r.id, s.id, 8, 1, NULL, 262000
FROM public.releases r, public.songs s WHERE r.mbid = 'aee17129-c737-4710-ac7f-bddb9cdd3bb2' AND s.mbid = '74bf9a1e-3cdf-4a8c-a8a4-11c55f96b37e'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('eef0269b-a1b6-45cc-820f-1754fe7366f4', '38eb99cb-245d-4654-bec0-0b533beb9a92', 'SimPle', 'Mrs. GREEN APPLE', 227000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '38eb99cb-245d-4654-bec0-0b533beb9a92' AND ar.mbid = '9ce674b7-5180-41f7-9ac2-95dc0d8a0ed2'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '8e9c43bf-8b3c-4866-944e-3c35f5f129ed', r.id, s.id, 9, 1, NULL, 227000
FROM public.releases r, public.songs s WHERE r.mbid = 'aee17129-c737-4710-ac7f-bddb9cdd3bb2' AND s.mbid = '38eb99cb-245d-4654-bec0-0b533beb9a92'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('8991157f-eb83-4129-9424-e33f1f6ea144', '8f27e5c4-db0d-4e27-9528-90e01ba7ffaf', 'InTerLuDe 〜白い朝〜', 'Mrs. GREEN APPLE', 33000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '8f27e5c4-db0d-4e27-9528-90e01ba7ffaf' AND ar.mbid = '9ce674b7-5180-41f7-9ac2-95dc0d8a0ed2'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '85ff0a34-0b9b-4e46-97a0-0470dcc29053', r.id, s.id, 10, 1, NULL, 33000
FROM public.releases r, public.songs s WHERE r.mbid = 'aee17129-c737-4710-ac7f-bddb9cdd3bb2' AND s.mbid = '8f27e5c4-db0d-4e27-9528-90e01ba7ffaf'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('6afa614a-6dc3-43e1-9f59-de1e334329e5', '6fd85545-c94a-4562-a5e1-c67528dc4177', 'Hug', 'Mrs. GREEN APPLE', 193000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '6fd85545-c94a-4562-a5e1-c67528dc4177' AND ar.mbid = '9ce674b7-5180-41f7-9ac2-95dc0d8a0ed2'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '0bff3436-5dc9-4262-b3b1-7076c33a8acb', r.id, s.id, 11, 1, NULL, 193000
FROM public.releases r, public.songs s WHERE r.mbid = 'aee17129-c737-4710-ac7f-bddb9cdd3bb2' AND s.mbid = '6fd85545-c94a-4562-a5e1-c67528dc4177'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('10290fca-aedf-4ae0-89f0-05595aee6110', '05f1df3d-6d77-48b0-99c8-da0055cf9146', 'HeLLo', 'Mrs. GREEN APPLE', 193000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '05f1df3d-6d77-48b0-99c8-da0055cf9146' AND ar.mbid = '9ce674b7-5180-41f7-9ac2-95dc0d8a0ed2'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '0498c64b-d1d9-476c-8273-5527e4618fad', r.id, s.id, 12, 1, NULL, 193000
FROM public.releases r, public.songs s WHERE r.mbid = 'aee17129-c737-4710-ac7f-bddb9cdd3bb2' AND s.mbid = '05f1df3d-6d77-48b0-99c8-da0055cf9146'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('976bbeab-0828-4c90-8405-7d2445e1682f', 'e86e7b9c-2f30-4afe-abb0-36e46d3a7e1e', '庶幾の唄', 'Mrs. GREEN APPLE', 247000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = 'e86e7b9c-2f30-4afe-abb0-36e46d3a7e1e' AND ar.mbid = '9ce674b7-5180-41f7-9ac2-95dc0d8a0ed2'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT 'bca97546-829a-4bbc-ac68-09ac9bc59898', r.id, s.id, 13, 1, NULL, 247000
FROM public.releases r, public.songs s WHERE r.mbid = 'aee17129-c737-4710-ac7f-bddb9cdd3bb2' AND s.mbid = 'e86e7b9c-2f30-4afe-abb0-36e46d3a7e1e'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.artists (id, mbid, name, sort_name, type, country, life_begin, life_end, disambiguation)
VALUES ('7a6689bd-08d9-4441-b112-9dbf0e324ba0', '2c6c53ea-09d4-4d98-b174-c9aa83d4fecf', '星野源', 'Hoshino, Gen', 'PERSON', 'JP', '1981-01-28', NULL, '')
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.albums (id, mbid, title, artist_credit, primary_type, first_release_date)
VALUES ('c1205a5a-7e34-4354-aa84-72d46f4b6490', '25d11ecf-30c1-447a-9ec5-cddecd112519', 'ばかのうた', '星野源', 'Album', '2010-06-23')
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.album_artists (album_id, artist_id, position)
SELECT a.id, ar.id, 0 FROM public.albums a, public.artists ar
WHERE a.mbid = '25d11ecf-30c1-447a-9ec5-cddecd112519' AND ar.mbid = '2c6c53ea-09d4-4d98-b174-c9aa83d4fecf'
ON CONFLICT (album_id, artist_id) DO NOTHING;
INSERT INTO public.releases (id, mbid, album_id, title, status, country, release_date, release_date_precision, barcode, language, script)
SELECT 'e76fb38e-2aea-47fc-8bb0-76427f330aef', '0d10a7bb-218f-4d00-af9e-09615f9b5bc0', albums.id, 'ばかのうた', 'Official', 'JP', '2010-06-23', 'day', NULL, 'jpn', 'Jpan'
FROM public.albums WHERE mbid = '25d11ecf-30c1-447a-9ec5-cddecd112519'
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('5043da5b-038f-47de-a42c-57119c880609', 'af750102-d03c-43c0-82c7-049b01779c6e', 'ばらばら', '星野源', 202000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = 'af750102-d03c-43c0-82c7-049b01779c6e' AND ar.mbid = '2c6c53ea-09d4-4d98-b174-c9aa83d4fecf'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '2470cdca-a7e9-4bce-9ff7-883e37e234f3', r.id, s.id, 1, 1, NULL, 202000
FROM public.releases r, public.songs s WHERE r.mbid = '0d10a7bb-218f-4d00-af9e-09615f9b5bc0' AND s.mbid = 'af750102-d03c-43c0-82c7-049b01779c6e'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('7a72ba5e-2acc-4fb7-92b3-cddee73be8e0', 'd862568b-adb2-47d5-80d1-92566320df0f', 'グー', '星野源', 213000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = 'd862568b-adb2-47d5-80d1-92566320df0f' AND ar.mbid = '2c6c53ea-09d4-4d98-b174-c9aa83d4fecf'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '9bc9b4ed-a4a2-4628-b6ba-608b390942e2', r.id, s.id, 2, 1, NULL, 213000
FROM public.releases r, public.songs s WHERE r.mbid = '0d10a7bb-218f-4d00-af9e-09615f9b5bc0' AND s.mbid = 'd862568b-adb2-47d5-80d1-92566320df0f'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('2b786288-2048-4773-9ace-73d43359a595', '0df11718-0d9b-4f56-937f-be243682de74', 'キッチン', '星野源', 256000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '0df11718-0d9b-4f56-937f-be243682de74' AND ar.mbid = '2c6c53ea-09d4-4d98-b174-c9aa83d4fecf'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '4635668c-5e3b-4ccc-aefa-0d564cddbc4f', r.id, s.id, 3, 1, NULL, 256000
FROM public.releases r, public.songs s WHERE r.mbid = '0d10a7bb-218f-4d00-af9e-09615f9b5bc0' AND s.mbid = '0df11718-0d9b-4f56-937f-be243682de74'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('0f1b08c4-f847-44ad-a0f1-d939e1808aa0', '9e2ef2ec-d650-45eb-881d-0e08c0ba1699', '茶碗', '星野源', 232000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '9e2ef2ec-d650-45eb-881d-0e08c0ba1699' AND ar.mbid = '2c6c53ea-09d4-4d98-b174-c9aa83d4fecf'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '5a98d959-caa1-42c6-8fbc-827d637bcb6a', r.id, s.id, 4, 1, NULL, 232000
FROM public.releases r, public.songs s WHERE r.mbid = '0d10a7bb-218f-4d00-af9e-09615f9b5bc0' AND s.mbid = '9e2ef2ec-d650-45eb-881d-0e08c0ba1699'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('f021968b-6f9b-4594-8cb1-0c4360b87858', '89d1879d-4071-44ac-9b13-13b70c6ea120', 'デイジーお味噌汁 (instrumental)', '星野源', 90000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '89d1879d-4071-44ac-9b13-13b70c6ea120' AND ar.mbid = '2c6c53ea-09d4-4d98-b174-c9aa83d4fecf'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '4254a6a0-7c78-4f3b-b85c-cc57dd5e3c70', r.id, s.id, 5, 1, 'デイジーお味噌汁 (Instrumental)', 90000
FROM public.releases r, public.songs s WHERE r.mbid = '0d10a7bb-218f-4d00-af9e-09615f9b5bc0' AND s.mbid = '89d1879d-4071-44ac-9b13-13b70c6ea120'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('5e8b9788-767c-4425-a76f-1f1c31fc7ac7', 'e7105313-4c28-4b2c-bfd3-8a415207e780', '夜中唄', '星野源', 230000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = 'e7105313-4c28-4b2c-bfd3-8a415207e780' AND ar.mbid = '2c6c53ea-09d4-4d98-b174-c9aa83d4fecf'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '0314906d-bb15-4976-9217-d14b9a8a7e80', r.id, s.id, 6, 1, NULL, 230000
FROM public.releases r, public.songs s WHERE r.mbid = '0d10a7bb-218f-4d00-af9e-09615f9b5bc0' AND s.mbid = 'e7105313-4c28-4b2c-bfd3-8a415207e780'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('a67dc1f5-162a-4e65-9d7f-b31b8cf03abd', '6005caa1-5294-429a-b961-13874044ff8a', '老夫婦', '星野源', 121000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '6005caa1-5294-429a-b961-13874044ff8a' AND ar.mbid = '2c6c53ea-09d4-4d98-b174-c9aa83d4fecf'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT 'b1921a8a-d2a3-411b-a108-8e5f0bcf885b', r.id, s.id, 7, 1, NULL, 121000
FROM public.releases r, public.songs s WHERE r.mbid = '0d10a7bb-218f-4d00-af9e-09615f9b5bc0' AND s.mbid = '6005caa1-5294-429a-b961-13874044ff8a'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('eef50b83-1199-4862-9c70-b38e8fc7db15', 'bdac17a6-2651-4ed6-b1ef-9d28a8ed8f13', 'くせのうた', '星野源', 284000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = 'bdac17a6-2651-4ed6-b1ef-9d28a8ed8f13' AND ar.mbid = '2c6c53ea-09d4-4d98-b174-c9aa83d4fecf'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '62f60766-4eaf-4d5c-87f3-a6df84c239a3', r.id, s.id, 8, 1, NULL, 284000
FROM public.releases r, public.songs s WHERE r.mbid = '0d10a7bb-218f-4d00-af9e-09615f9b5bc0' AND s.mbid = 'bdac17a6-2651-4ed6-b1ef-9d28a8ed8f13'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('25805eae-383f-46f2-affa-ad7eee5f456e', 'a4ac2f23-9ed7-4cbc-bd7b-574b37a05e7f', '兄妹', '星野源', 168000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = 'a4ac2f23-9ed7-4cbc-bd7b-574b37a05e7f' AND ar.mbid = '2c6c53ea-09d4-4d98-b174-c9aa83d4fecf'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '27065d11-0157-4b55-b87f-fe58c4c732cb', r.id, s.id, 9, 1, NULL, 168000
FROM public.releases r, public.songs s WHERE r.mbid = '0d10a7bb-218f-4d00-af9e-09615f9b5bc0' AND s.mbid = 'a4ac2f23-9ed7-4cbc-bd7b-574b37a05e7f'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('0a458290-bfc3-4e30-83ff-189b348c19da', '487c0d94-d334-4e7d-a69f-39e3116c5641', '子供', '星野源', 203000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '487c0d94-d334-4e7d-a69f-39e3116c5641' AND ar.mbid = '2c6c53ea-09d4-4d98-b174-c9aa83d4fecf'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT 'b21ec594-27c5-48d3-bb40-99d48ed6d866', r.id, s.id, 10, 1, NULL, 203000
FROM public.releases r, public.songs s WHERE r.mbid = '0d10a7bb-218f-4d00-af9e-09615f9b5bc0' AND s.mbid = '487c0d94-d334-4e7d-a69f-39e3116c5641'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('0bfd7223-963c-4530-8f48-6842cbdda470', 'da8d93af-4324-4797-b399-abd33e864fc6', 'さようならのうみ (instrumental)', '星野源', 141000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = 'da8d93af-4324-4797-b399-abd33e864fc6' AND ar.mbid = '2c6c53ea-09d4-4d98-b174-c9aa83d4fecf'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT 'eff67a50-c1a3-4419-aec5-26ead84fe2da', r.id, s.id, 11, 1, 'さようならのうみ (Instrumental)', 141000
FROM public.releases r, public.songs s WHERE r.mbid = '0d10a7bb-218f-4d00-af9e-09615f9b5bc0' AND s.mbid = 'da8d93af-4324-4797-b399-abd33e864fc6'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('70ae232f-b0fd-477d-8ce7-a0be30ef27ea', '939743e4-6f99-4aff-a8f5-4826e1a6431d', '穴を掘る', '星野源', 167000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '939743e4-6f99-4aff-a8f5-4826e1a6431d' AND ar.mbid = '2c6c53ea-09d4-4d98-b174-c9aa83d4fecf'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT 'fb9c963b-58e4-4da9-94cc-65a0058439f1', r.id, s.id, 12, 1, NULL, 167000
FROM public.releases r, public.songs s WHERE r.mbid = '0d10a7bb-218f-4d00-af9e-09615f9b5bc0' AND s.mbid = '939743e4-6f99-4aff-a8f5-4826e1a6431d'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('6a7648ff-0b30-4357-872d-655c4fc56f2f', 'd85e9720-cfa2-491d-b9dd-667bf1901d61', 'ただいま', '星野源', 204000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = 'd85e9720-cfa2-491d-b9dd-667bf1901d61' AND ar.mbid = '2c6c53ea-09d4-4d98-b174-c9aa83d4fecf'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '5b798da9-ea71-43b9-aafa-3596ea6a59b1', r.id, s.id, 13, 1, NULL, 204000
FROM public.releases r, public.songs s WHERE r.mbid = '0d10a7bb-218f-4d00-af9e-09615f9b5bc0' AND s.mbid = 'd85e9720-cfa2-491d-b9dd-667bf1901d61'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('3637e7fb-ff66-4dcb-89c9-57219f38f878', 'c38969d1-40d8-47a8-83ac-66cb6d53d3ab', 'ひらめき', '星野源', 162000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = 'c38969d1-40d8-47a8-83ac-66cb6d53d3ab' AND ar.mbid = '2c6c53ea-09d4-4d98-b174-c9aa83d4fecf'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '49d48a79-b322-4ec5-8a91-bb4a33d67400', r.id, s.id, 14, 1, NULL, 162000
FROM public.releases r, public.songs s WHERE r.mbid = '0d10a7bb-218f-4d00-af9e-09615f9b5bc0' AND s.mbid = 'c38969d1-40d8-47a8-83ac-66cb6d53d3ab'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('10117421-2f1d-4e96-8a90-a2d313eb6a95', 'e4862d5b-38e5-4bbd-9339-6893b323ad10', 'ばかのうた', '星野源', 205000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = 'e4862d5b-38e5-4bbd-9339-6893b323ad10' AND ar.mbid = '2c6c53ea-09d4-4d98-b174-c9aa83d4fecf'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '76224c20-9f01-4538-95fc-4da930a7f62b', r.id, s.id, 15, 1, NULL, 205000
FROM public.releases r, public.songs s WHERE r.mbid = '0d10a7bb-218f-4d00-af9e-09615f9b5bc0' AND s.mbid = 'e4862d5b-38e5-4bbd-9339-6893b323ad10'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.artists (id, mbid, name, sort_name, type, country, life_begin, life_end, disambiguation)
VALUES ('386c2493-2771-4fa0-8d1d-a1a204d4f029', 'b539e453-c4fe-47e3-8a07-8517eac74429', '宇多田ヒカル', 'Utada, Hikaru', 'PERSON', 'JP', '1983-01-19', NULL, 'Japanese-American singer-songwriter')
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.albums (id, mbid, title, artist_credit, primary_type, first_release_date)
VALUES ('18ad3c0e-0fae-4b18-94e3-33c05f4402e8', 'a166ef97-5540-3faa-b556-c6ecf812faa4', 'Precious', 'Cubic U', 'Album', '1998-01-28')
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.album_artists (album_id, artist_id, position)
SELECT a.id, ar.id, 0 FROM public.albums a, public.artists ar
WHERE a.mbid = 'a166ef97-5540-3faa-b556-c6ecf812faa4' AND ar.mbid = 'b539e453-c4fe-47e3-8a07-8517eac74429'
ON CONFLICT (album_id, artist_id) DO NOTHING;
INSERT INTO public.releases (id, mbid, album_id, title, status, country, release_date, release_date_precision, barcode, language, script)
SELECT '88bcc905-2986-48c2-b5cd-5ce47fa3cc7a', 'c5235d52-147d-329a-a700-4a3bb4fa25f9', albums.id, 'Precious', 'Official', 'JP', '1999-03-31', 'day', '4988006159709', 'eng', 'Latn'
FROM public.albums WHERE mbid = 'a166ef97-5540-3faa-b556-c6ecf812faa4'
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('8476448c-9c48-4c9b-8137-6939a61d4e76', 'a570b272-fe03-4246-9bc9-b717220494af', 'My Little Lover Boy', 'Cubic U', 269560)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = 'a570b272-fe03-4246-9bc9-b717220494af' AND ar.mbid = 'b539e453-c4fe-47e3-8a07-8517eac74429'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '42532a1d-7d01-4ce2-8ae2-66ab0521986b', r.id, s.id, 1, 1, NULL, 269560
FROM public.releases r, public.songs s WHERE r.mbid = 'c5235d52-147d-329a-a700-4a3bb4fa25f9' AND s.mbid = 'a570b272-fe03-4246-9bc9-b717220494af'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('7a6f9f2f-9e46-4488-b806-a18092b6dfff', 'f695bccf-78d9-441a-9fdc-d54f6e62518a', 'Lullaby', 'Cubic U', 278773)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = 'f695bccf-78d9-441a-9fdc-d54f6e62518a' AND ar.mbid = 'b539e453-c4fe-47e3-8a07-8517eac74429'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT 'b8b362af-e4ec-4f19-9cc6-606b1405ee29', r.id, s.id, 2, 1, NULL, 278773
FROM public.releases r, public.songs s WHERE r.mbid = 'c5235d52-147d-329a-a700-4a3bb4fa25f9' AND s.mbid = 'f695bccf-78d9-441a-9fdc-d54f6e62518a'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('ce8d9fe6-65a4-4e02-910f-9801cd51c67f', '7d4d1aaf-3cda-46af-bb60-594b029b8b24', 'How Ya Doin''', 'Cubic U', 186826)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '7d4d1aaf-3cda-46af-bb60-594b029b8b24' AND ar.mbid = 'b539e453-c4fe-47e3-8a07-8517eac74429'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '5cad91c1-ae4d-45a9-93c0-9c988643fe10', r.id, s.id, 3, 1, 'How Ya Doin’', 186826
FROM public.releases r, public.songs s WHERE r.mbid = 'c5235d52-147d-329a-a700-4a3bb4fa25f9' AND s.mbid = '7d4d1aaf-3cda-46af-bb60-594b029b8b24'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('acc420e0-7dd6-462e-91d3-031d666172e4', '14d51b7a-5583-4fea-b418-3ca229bf2966', 'I Don''t Love You', 'Cubic U', 291173)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '14d51b7a-5583-4fea-b418-3ca229bf2966' AND ar.mbid = 'b539e453-c4fe-47e3-8a07-8517eac74429'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT 'efe03b47-6128-44f9-99fb-1cb6a68ba2a5', r.id, s.id, 4, 1, 'I Don’t Love You', 291173
FROM public.releases r, public.songs s WHERE r.mbid = 'c5235d52-147d-329a-a700-4a3bb4fa25f9' AND s.mbid = '14d51b7a-5583-4fea-b418-3ca229bf2966'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('8c9469fb-7ad9-464e-ac06-5904020bd1dc', 'adae9409-cbc3-4ed4-82f1-6694d1ad394f', 'Promise', 'Cubic U', 325093)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = 'adae9409-cbc3-4ed4-82f1-6694d1ad394f' AND ar.mbid = 'b539e453-c4fe-47e3-8a07-8517eac74429'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT 'b2118f4b-6c87-462b-8e19-277a01289add', r.id, s.id, 5, 1, NULL, 325093
FROM public.releases r, public.songs s WHERE r.mbid = 'c5235d52-147d-329a-a700-4a3bb4fa25f9' AND s.mbid = 'adae9409-cbc3-4ed4-82f1-6694d1ad394f'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('d99f9f52-68de-49b3-8413-2f174e82ea87', '74c43d42-a263-43f9-923b-c0c49d7e6a1a', 'Ticket 4 Two', 'Cubic U', 324466)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '74c43d42-a263-43f9-923b-c0c49d7e6a1a' AND ar.mbid = 'b539e453-c4fe-47e3-8a07-8517eac74429'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '433e17cc-3bc8-47cb-8f92-753e9561556e', r.id, s.id, 6, 1, NULL, 324466
FROM public.releases r, public.songs s WHERE r.mbid = 'c5235d52-147d-329a-a700-4a3bb4fa25f9' AND s.mbid = '74c43d42-a263-43f9-923b-c0c49d7e6a1a'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('bd64128c-d03d-47bf-ab07-feddec3518c5', '7e8ea5bb-4205-4668-9a01-792b3b454236', 'Take a Little While', 'Cubic U', 232040)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '7e8ea5bb-4205-4668-9a01-792b3b454236' AND ar.mbid = 'b539e453-c4fe-47e3-8a07-8517eac74429'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT 'ce3fef34-5b5f-467a-9304-77c7e2d6b60b', r.id, s.id, 7, 1, NULL, 232040
FROM public.releases r, public.songs s WHERE r.mbid = 'c5235d52-147d-329a-a700-4a3bb4fa25f9' AND s.mbid = '7e8ea5bb-4205-4668-9a01-792b3b454236'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('36ce9797-bf3d-4912-afd3-58937dd4e328', 'fc9d28b8-2345-4c50-a6e8-9064199e68c7', '100 Reasons Why', 'Cubic U', 272360)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = 'fc9d28b8-2345-4c50-a6e8-9064199e68c7' AND ar.mbid = 'b539e453-c4fe-47e3-8a07-8517eac74429'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '1e09153c-8dc8-4e54-b357-afbc6c8def97', r.id, s.id, 8, 1, NULL, 272360
FROM public.releases r, public.songs s WHERE r.mbid = 'c5235d52-147d-329a-a700-4a3bb4fa25f9' AND s.mbid = 'fc9d28b8-2345-4c50-a6e8-9064199e68c7'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('2c244ff2-9052-4b5f-ace0-208065a917d5', '429f8fd8-7143-4cb1-b01b-4fe099d3a5d2', 'Work Things Out', 'Cubic U', 272373)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '429f8fd8-7143-4cb1-b01b-4fe099d3a5d2' AND ar.mbid = 'b539e453-c4fe-47e3-8a07-8517eac74429'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT 'dd23c945-b057-4f19-9277-bcb642b38f47', r.id, s.id, 9, 1, NULL, 272373
FROM public.releases r, public.songs s WHERE r.mbid = 'c5235d52-147d-329a-a700-4a3bb4fa25f9' AND s.mbid = '429f8fd8-7143-4cb1-b01b-4fe099d3a5d2'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('32b56e5f-558f-4ffb-ba55-d72ffb27e8e8', '289d70c1-3c52-4296-ac4e-d2980e3df0c9', 'Close to You', 'Cubic U', 280160)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '289d70c1-3c52-4296-ac4e-d2980e3df0c9' AND ar.mbid = 'b539e453-c4fe-47e3-8a07-8517eac74429'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT 'e1bb3d0d-42c4-4461-a6dc-f1080c8986ce', r.id, s.id, 10, 1, NULL, 280160
FROM public.releases r, public.songs s WHERE r.mbid = 'c5235d52-147d-329a-a700-4a3bb4fa25f9' AND s.mbid = '289d70c1-3c52-4296-ac4e-d2980e3df0c9'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('3a1067b3-ced6-414f-9ae9-1f8c62d3980a', 'd93e061c-5f7b-42c0-9671-1bf919af981d', 'Precious Love', 'Cubic U', 322773)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = 'd93e061c-5f7b-42c0-9671-1bf919af981d' AND ar.mbid = 'b539e453-c4fe-47e3-8a07-8517eac74429'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT 'c28df3b9-7616-44c1-99d2-2ddbcc422c42', r.id, s.id, 11, 1, NULL, 322773
FROM public.releases r, public.songs s WHERE r.mbid = 'c5235d52-147d-329a-a700-4a3bb4fa25f9' AND s.mbid = 'd93e061c-5f7b-42c0-9671-1bf919af981d'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('8028edf1-33ac-4ccc-a238-ac92d0c3d9e0', 'c1f4e35f-2766-4e78-800e-2e0a4653b17a', 'How Ya Doin’ (rap version)', 'Cubic U', 226800)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = 'c1f4e35f-2766-4e78-800e-2e0a4653b17a' AND ar.mbid = 'b539e453-c4fe-47e3-8a07-8517eac74429'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT 'f36d559d-1bed-49fe-8086-07c7b2737b47', r.id, s.id, 12, 1, NULL, 226800
FROM public.releases r, public.songs s WHERE r.mbid = 'c5235d52-147d-329a-a700-4a3bb4fa25f9' AND s.mbid = 'c1f4e35f-2766-4e78-800e-2e0a4653b17a'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.artists (id, mbid, name, sort_name, type, country, life_begin, life_end, disambiguation)
VALUES ('52d61d38-eb99-41d0-ac1f-0aa94bdcaea5', '9e414497-23b7-4ab7-9ec6-8ea9864c9e87', '椎名林檎', 'Sheena, Ringo', 'PERSON', 'JP', '1978-11-25', NULL, '')
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.albums (id, mbid, title, artist_credit, primary_type, first_release_date)
VALUES ('c13ae270-21d9-4c48-b783-285de45e25b9', '8a7d7df9-90c4-4022-b7a5-95e42a281824', '虚栄ブランコ', '椎名林檎', 'Album', NULL)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.album_artists (album_id, artist_id, position)
SELECT a.id, ar.id, 0 FROM public.albums a, public.artists ar
WHERE a.mbid = '8a7d7df9-90c4-4022-b7a5-95e42a281824' AND ar.mbid = '9e414497-23b7-4ab7-9ec6-8ea9864c9e87'
ON CONFLICT (album_id, artist_id) DO NOTHING;
INSERT INTO public.releases (id, mbid, album_id, title, status, country, release_date, release_date_precision, barcode, language, script)
SELECT '1ee6ac41-625f-4af9-9ea2-a36c0835267f', '047457eb-7d6c-47af-b569-8fbeef2da595', albums.id, '虚栄ブランコ', 'Bootleg', NULL, NULL, 'year', NULL, NULL, NULL
FROM public.albums WHERE mbid = '8a7d7df9-90c4-4022-b7a5-95e42a281824'
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('2e9afb57-b278-45cf-8017-b789ce54413a', '7677d87c-2714-4226-9ee2-d6bcb7b414f3', 'Se (southpaw)', '椎名林檎', 152275)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '7677d87c-2714-4226-9ee2-d6bcb7b414f3' AND ar.mbid = '9e414497-23b7-4ab7-9ec6-8ea9864c9e87'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '49273c4c-f08a-4575-819d-dacad33acbe3', r.id, s.id, 1, 1, NULL, 152275
FROM public.releases r, public.songs s WHERE r.mbid = '047457eb-7d6c-47af-b569-8fbeef2da595' AND s.mbid = '7677d87c-2714-4226-9ee2-d6bcb7b414f3'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('0fb8a76a-cc9a-43ab-a4fe-d7339b5d29dd', '67e6f14c-f2b3-41d9-8932-baf8ea1f38f0', 'intro', '椎名林檎', 37119)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '67e6f14c-f2b3-41d9-8932-baf8ea1f38f0' AND ar.mbid = '9e414497-23b7-4ab7-9ec6-8ea9864c9e87'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT 'f3358cd5-4a71-4cee-b47e-939597c8fe79', r.id, s.id, 2, 1, NULL, 37119
FROM public.releases r, public.songs s WHERE r.mbid = '047457eb-7d6c-47af-b569-8fbeef2da595' AND s.mbid = '67e6f14c-f2b3-41d9-8932-baf8ea1f38f0'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('1f8229e4-4677-486d-bc7a-b234d0185838', 'c26c02a1-c594-4261-97df-c96b90cb1355', 'あおぞら', '椎名林檎', 181707)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = 'c26c02a1-c594-4261-97df-c96b90cb1355' AND ar.mbid = '9e414497-23b7-4ab7-9ec6-8ea9864c9e87'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT 'e055d005-66d6-4512-a8f5-dbf0e9e8fe1c', r.id, s.id, 3, 1, NULL, 181707
FROM public.releases r, public.songs s WHERE r.mbid = '047457eb-7d6c-47af-b569-8fbeef2da595' AND s.mbid = 'c26c02a1-c594-4261-97df-c96b90cb1355'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('8a922b12-791a-4b20-bad3-3be7705b7fa9', 'e2f6154f-08eb-46de-bbc3-edd466a9013e', 'Member Introduction', '椎名林檎', 49031)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = 'e2f6154f-08eb-46de-bbc3-edd466a9013e' AND ar.mbid = '9e414497-23b7-4ab7-9ec6-8ea9864c9e87'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT 'eb745284-df3c-480d-b09f-57d399824a0f', r.id, s.id, 4, 1, NULL, 49031
FROM public.releases r, public.songs s WHERE r.mbid = '047457eb-7d6c-47af-b569-8fbeef2da595' AND s.mbid = 'e2f6154f-08eb-46de-bbc3-edd466a9013e'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('c10810f2-0279-45ae-8225-55f499dadadb', 'f72f467f-70cb-464d-b641-79860c7665c7', '歌舞伎町の女王', '椎名林檎', 169090)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = 'f72f467f-70cb-464d-b641-79860c7665c7' AND ar.mbid = '9e414497-23b7-4ab7-9ec6-8ea9864c9e87'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT 'a16eba0c-2af9-4e41-8c66-16d57981d939', r.id, s.id, 5, 1, NULL, 169090
FROM public.releases r, public.songs s WHERE r.mbid = '047457eb-7d6c-47af-b569-8fbeef2da595' AND s.mbid = 'f72f467f-70cb-464d-b641-79860c7665c7'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('a48d46c1-efcd-48cf-abd3-ad9490e1fb84', '49821226-a747-4015-8d12-ab673863a449', '幸福論（悦楽編）', '椎名林檎', 138684)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '49821226-a747-4015-8d12-ab673863a449' AND ar.mbid = '9e414497-23b7-4ab7-9ec6-8ea9864c9e87'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '101c917c-a190-4644-8ef5-8578d0b5e42e', r.id, s.id, 6, 1, NULL, 138684
FROM public.releases r, public.songs s WHERE r.mbid = '047457eb-7d6c-47af-b569-8fbeef2da595' AND s.mbid = '49821226-a747-4015-8d12-ab673863a449'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('89d77dc9-7988-4805-ba34-e136495bfc00', '876fa7db-7440-4d70-95d9-9039f2615819', '果物の部屋', '椎名林檎', 285727)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '876fa7db-7440-4d70-95d9-9039f2615819' AND ar.mbid = '9e414497-23b7-4ab7-9ec6-8ea9864c9e87'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '718a82c2-1c1c-4b5c-aadc-381c2ed402ac', r.id, s.id, 7, 1, NULL, 285727
FROM public.releases r, public.songs s WHERE r.mbid = '047457eb-7d6c-47af-b569-8fbeef2da595' AND s.mbid = '876fa7db-7440-4d70-95d9-9039f2615819'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('227e1016-73fc-4bf3-ab63-029011f66fb9', 'bc2b0e36-8c08-4a44-baff-cbf977afa140', 'MC', '椎名林檎', 31686)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = 'bc2b0e36-8c08-4a44-baff-cbf977afa140' AND ar.mbid = '9e414497-23b7-4ab7-9ec6-8ea9864c9e87'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT 'a3546fde-c4de-42c5-b090-2639c16c0417', r.id, s.id, 8, 1, NULL, 31686
FROM public.releases r, public.songs s WHERE r.mbid = '047457eb-7d6c-47af-b569-8fbeef2da595' AND s.mbid = 'bc2b0e36-8c08-4a44-baff-cbf977afa140'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('f07828b7-7f5b-4df3-bf19-0bdb7b95dbe6', '6f2e30e3-657b-4626-a905-25ff74ddbf4a', '不幸自慢', '椎名林檎', 138448)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '6f2e30e3-657b-4626-a905-25ff74ddbf4a' AND ar.mbid = '9e414497-23b7-4ab7-9ec6-8ea9864c9e87'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '48b825f0-77ae-4ec4-8ecc-0f61a1264368', r.id, s.id, 9, 1, NULL, 138448
FROM public.releases r, public.songs s WHERE r.mbid = '047457eb-7d6c-47af-b569-8fbeef2da595' AND s.mbid = '6f2e30e3-657b-4626-a905-25ff74ddbf4a'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('7f43ff58-68c8-40ba-930f-2fadbb4154f9', '34794e37-5faa-42f6-93b1-d09d1cf88307', 'MC', '椎名林檎', 64861)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '34794e37-5faa-42f6-93b1-d09d1cf88307' AND ar.mbid = '9e414497-23b7-4ab7-9ec6-8ea9864c9e87'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '6bcb8ab1-be37-471b-bce5-3af9b2d2679f', r.id, s.id, 10, 1, NULL, 64861
FROM public.releases r, public.songs s WHERE r.mbid = '047457eb-7d6c-47af-b569-8fbeef2da595' AND s.mbid = '34794e37-5faa-42f6-93b1-d09d1cf88307'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('38473908-280d-4876-8d49-3a966a0f0417', '3cbba979-0fe2-44c9-9376-c2e3950cb4cf', '喪興瑠怒', '椎名林檎', 198034)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '3cbba979-0fe2-44c9-9376-c2e3950cb4cf' AND ar.mbid = '9e414497-23b7-4ab7-9ec6-8ea9864c9e87'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '863ac4ac-045f-460a-990c-a2c375902944', r.id, s.id, 11, 1, NULL, 198034
FROM public.releases r, public.songs s WHERE r.mbid = '047457eb-7d6c-47af-b569-8fbeef2da595' AND s.mbid = '3cbba979-0fe2-44c9-9376-c2e3950cb4cf'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('906891cc-0d87-4f6f-aa6e-1791036e1a29', 'eb98666b-2cb5-465e-b963-cc4620ed47f4', 'メロウ', '椎名林檎', 387345)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = 'eb98666b-2cb5-465e-b963-cc4620ed47f4' AND ar.mbid = '9e414497-23b7-4ab7-9ec6-8ea9864c9e87'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '43a0fcab-6d86-4dc5-a829-37121d75e03a', r.id, s.id, 12, 1, NULL, 387345
FROM public.releases r, public.songs s WHERE r.mbid = '047457eb-7d6c-47af-b569-8fbeef2da595' AND s.mbid = 'eb98666b-2cb5-465e-b963-cc4620ed47f4'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('e443b27a-5463-415e-b89f-767ff166ccb1', '685cd278-656e-4f50-88aa-00afedf0ea86', 'Crowd', '椎名林檎', 248398)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '685cd278-656e-4f50-88aa-00afedf0ea86' AND ar.mbid = '9e414497-23b7-4ab7-9ec6-8ea9864c9e87'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT 'a4a0d4bc-7ccd-469a-82f1-ffef563c81c3', r.id, s.id, 13, 1, NULL, 248398
FROM public.releases r, public.songs s WHERE r.mbid = '047457eb-7d6c-47af-b569-8fbeef2da595' AND s.mbid = '685cd278-656e-4f50-88aa-00afedf0ea86'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('997cbbbd-8e6a-475b-a947-67c14aa768ef', '7bbcf8cb-5d35-403c-94ec-c43bd9641286', 'UFO', '椎名林檎', 188429)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '7bbcf8cb-5d35-403c-94ec-c43bd9641286' AND ar.mbid = '9e414497-23b7-4ab7-9ec6-8ea9864c9e87'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT 'a1761681-045e-4fb4-bffe-b252ade62c8b', r.id, s.id, 14, 1, NULL, 188429
FROM public.releases r, public.songs s WHERE r.mbid = '047457eb-7d6c-47af-b569-8fbeef2da595' AND s.mbid = '7bbcf8cb-5d35-403c-94ec-c43bd9641286'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('d2f5d4db-5f2d-401c-9b08-00a30f6c42dd', '71649c1d-99a0-4947-8cdb-cc58b214939a', 'Creep', '椎名林檎', 273162)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '71649c1d-99a0-4947-8cdb-cc58b214939a' AND ar.mbid = '9e414497-23b7-4ab7-9ec6-8ea9864c9e87'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '36fa040b-a13c-4681-bfa4-0fe8c3db570c', r.id, s.id, 15, 1, NULL, 273162
FROM public.releases r, public.songs s WHERE r.mbid = '047457eb-7d6c-47af-b569-8fbeef2da595' AND s.mbid = '71649c1d-99a0-4947-8cdb-cc58b214939a'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.artists (id, mbid, name, sort_name, type, country, life_begin, life_end, disambiguation)
VALUES ('cd77435c-f665-4218-93e9-ee69a2a39575', '6f500293-7396-4903-b4fd-118127d06f9e', 'RADWIMPS', 'RADWIMPS', 'GROUP', 'JP', '2001', NULL, '')
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.albums (id, mbid, title, artist_credit, primary_type, first_release_date)
VALUES ('bda47c9a-1ff9-4a67-b59f-e05e4153ff6c', 'beef969a-f211-3c70-a9d4-1e6efb51fa71', 'RADWIMPS', 'RADWIMPS', 'Album', '2003-07-02')
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.album_artists (album_id, artist_id, position)
SELECT a.id, ar.id, 0 FROM public.albums a, public.artists ar
WHERE a.mbid = 'beef969a-f211-3c70-a9d4-1e6efb51fa71' AND ar.mbid = '6f500293-7396-4903-b4fd-118127d06f9e'
ON CONFLICT (album_id, artist_id) DO NOTHING;
INSERT INTO public.releases (id, mbid, album_id, title, status, country, release_date, release_date_precision, barcode, language, script)
SELECT '06e30308-6187-480e-8e02-7cdc5a07ad27', '845e7a50-3064-44cd-a319-5ee7403d9222', albums.id, 'RADWIMPS', 'Official', 'JP', '2003-07-02', 'day', '4562134570027', 'jpn', 'Jpan'
FROM public.albums WHERE mbid = 'beef969a-f211-3c70-a9d4-1e6efb51fa71'
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('94b2a707-bf79-4cac-851e-3b9157be2eaa', '3d696376-398b-4b5c-8fc0-8e0e2302fe84', '人生 出会い', 'RADWIMPS', 341000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '3d696376-398b-4b5c-8fc0-8e0e2302fe84' AND ar.mbid = '6f500293-7396-4903-b4fd-118127d06f9e'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '7a86c5ae-e731-4820-98ee-81c06e924ab4', r.id, s.id, 1, 1, NULL, 341826
FROM public.releases r, public.songs s WHERE r.mbid = '845e7a50-3064-44cd-a319-5ee7403d9222' AND s.mbid = '3d696376-398b-4b5c-8fc0-8e0e2302fe84'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('1f7741a9-79ad-483f-826e-86f9e2a0247d', '26e668ad-6690-494c-b663-20172e62d141', '自暴自棄自己中心的(思春期)自己依存症の少年', 'RADWIMPS', 277000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '26e668ad-6690-494c-b663-20172e62d141' AND ar.mbid = '6f500293-7396-4903-b4fd-118127d06f9e'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '8ab5140c-86b3-406e-979f-9ad8d943e049', r.id, s.id, 2, 1, NULL, 277373
FROM public.releases r, public.songs s WHERE r.mbid = '845e7a50-3064-44cd-a319-5ee7403d9222' AND s.mbid = '26e668ad-6690-494c-b663-20172e62d141'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('3fc53fa6-109a-483a-a8da-a65452fa2446', 'eefdc3f3-c020-4688-8a7e-365d5ca07d23', '心臓', 'RADWIMPS', 378000)
ON CONFLICT (mbid) DO NOTHING;
