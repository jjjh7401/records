-- Phase C seed batch LEAN: J-POP artists core tables only (idempotent)
-- artists/albums/releases/songs/tracks + link tables.
-- Source: MusicBrainz (canonical).
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '3ee83b2d-a54e-4caf-99e5-44731c380b6e', r.id, s.id, 12, 1, NULL, 263706
FROM public.releases r, public.songs s WHERE r.mbid = '2c0f7c17-4ac1-4b36-bb9c-1b951fca4513' AND s.mbid = 'f24f69cb-d8e6-43bc-bbd8-96162133f22b'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('099530de-bdf3-4a23-8bfb-66c8dead8556', 'f2ebaa82-7784-431f-a9ab-321083d99fc2', '心像放映', '米津玄師', 244000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = 'f2ebaa82-7784-431f-a9ab-321083d99fc2' AND ar.mbid = '09d4a85c-4916-4b4e-bc96-c4cfcf371046'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT 'e513980d-e4b0-4eaa-baca-52266cf99f85', r.id, s.id, 13, 1, NULL, 244000
FROM public.releases r, public.songs s WHERE r.mbid = '2c0f7c17-4ac1-4b36-bb9c-1b951fca4513' AND s.mbid = 'f2ebaa82-7784-431f-a9ab-321083d99fc2'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('b341c995-eedf-4b25-b861-7645e10782ae', '35d02cde-b4df-43a7-a718-06119121238c', '抄本', '米津玄師', 244653)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '35d02cde-b4df-43a7-a718-06119121238c' AND ar.mbid = '09d4a85c-4916-4b4e-bc96-c4cfcf371046'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT 'f9618e0d-fa23-4f0f-ae7f-3e8fdd522da0', r.id, s.id, 14, 1, NULL, 244653
FROM public.releases r, public.songs s WHERE r.mbid = '2c0f7c17-4ac1-4b36-bb9c-1b951fca4513' AND s.mbid = '35d02cde-b4df-43a7-a718-06119121238c'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('412d91c8-9b1e-4fd9-9400-0ea94dd6848b', '58ee8e31-5920-4ed5-8d1b-aecfdb2fb31d', '恋と病熱', '米津玄師', 270000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '58ee8e31-5920-4ed5-8d1b-aecfdb2fb31d' AND ar.mbid = '09d4a85c-4916-4b4e-bc96-c4cfcf371046'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '48f3aad8-4f6c-4356-b1d4-9cb68665ecde', r.id, s.id, 1, 2, NULL, 270000
FROM public.releases r, public.songs s WHERE r.mbid = '2c0f7c17-4ac1-4b36-bb9c-1b951fca4513' AND s.mbid = '58ee8e31-5920-4ed5-8d1b-aecfdb2fb31d'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.artists (id, mbid, name, sort_name, type, country, life_begin, life_end, disambiguation)
VALUES ('5dc4f695-37a2-49f1-92c1-acb7f5c04404', '908d9ac2-5187-4b9e-b281-601c6afb0791', 'あいみょん', 'Aimyon', 'PERSON', 'JP', '1995-03-06', NULL, 'Japanese singer-songwriter')
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.albums (id, mbid, title, artist_credit, primary_type, first_release_date)
VALUES ('8e21c8d2-d64d-4740-a2e0-ffc366ecac67', '413d3b68-6a32-4d0a-a6c9-0e19e129be96', '青春のエキサイトメント', 'あいみょん', 'Album', '2017-09-12')
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.album_artists (album_id, artist_id, position)
SELECT a.id, ar.id, 0 FROM public.albums a, public.artists ar
WHERE a.mbid = '413d3b68-6a32-4d0a-a6c9-0e19e129be96' AND ar.mbid = '908d9ac2-5187-4b9e-b281-601c6afb0791'
ON CONFLICT (album_id, artist_id) DO NOTHING;
INSERT INTO public.releases (id, mbid, album_id, title, status, country, release_date, release_date_precision, barcode, language, script)
SELECT '4a703773-74aa-4780-a6a7-324ec285c613', '5918f7f1-3c74-4723-9167-f55aee2f4043', albums.id, '青春のエキサイトメント', 'Official', 'JP', '2017-09-12', 'day', '190295747138', 'jpn', 'Jpan'
FROM public.albums WHERE mbid = '413d3b68-6a32-4d0a-a6c9-0e19e129be96'
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('6708a703-e9a1-4b8d-b917-0731722ad99d', '82ac33c6-413c-4829-a19a-9b9bb22137f9', '憧れてきたんだ', 'あいみょん', 146000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '82ac33c6-413c-4829-a19a-9b9bb22137f9' AND ar.mbid = '908d9ac2-5187-4b9e-b281-601c6afb0791'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '0a383391-eb54-48dc-8133-2c9dcf9d375d', r.id, s.id, 1, 1, NULL, 145000
FROM public.releases r, public.songs s WHERE r.mbid = '5918f7f1-3c74-4723-9167-f55aee2f4043' AND s.mbid = '82ac33c6-413c-4829-a19a-9b9bb22137f9'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('5e587e02-3996-44bd-8bfc-ea8e36dafa8b', '1f9b74e8-a67a-482a-9c65-2dcada1e1346', '生きていたんだよな', 'あいみょん', 194000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '1f9b74e8-a67a-482a-9c65-2dcada1e1346' AND ar.mbid = '908d9ac2-5187-4b9e-b281-601c6afb0791'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '74ca8546-4b4d-44a7-8bd6-a95016b5845e', r.id, s.id, 2, 1, NULL, 194000
FROM public.releases r, public.songs s WHERE r.mbid = '5918f7f1-3c74-4723-9167-f55aee2f4043' AND s.mbid = '1f9b74e8-a67a-482a-9c65-2dcada1e1346'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('c8a6cb1e-fa8e-4ba8-9683-4e6c1937497c', 'e4e09575-a997-4fcf-bc65-b4233194682a', '君はロックを聴かない', 'あいみょん', 246000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = 'e4e09575-a997-4fcf-bc65-b4233194682a' AND ar.mbid = '908d9ac2-5187-4b9e-b281-601c6afb0791'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '3a4fa925-7429-44c6-b090-d048f7f86f30', r.id, s.id, 3, 1, NULL, 246000
FROM public.releases r, public.songs s WHERE r.mbid = '5918f7f1-3c74-4723-9167-f55aee2f4043' AND s.mbid = 'e4e09575-a997-4fcf-bc65-b4233194682a'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('30deae8b-d6b7-4ec5-93ed-3e61bfc3625f', '82b4e2f0-5761-4c25-a432-6b818e2c9f4f', 'マトリョーシカ', 'あいみょん', 223000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '82b4e2f0-5761-4c25-a432-6b818e2c9f4f' AND ar.mbid = '908d9ac2-5187-4b9e-b281-601c6afb0791'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT 'f540a1a9-0049-4b3f-8245-409e3c42f585', r.id, s.id, 4, 1, NULL, 222000
FROM public.releases r, public.songs s WHERE r.mbid = '5918f7f1-3c74-4723-9167-f55aee2f4043' AND s.mbid = '82b4e2f0-5761-4c25-a432-6b818e2c9f4f'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('b70e542d-f5be-444d-859b-5815e8b2da34', 'ecbbf5ed-6c28-4462-8a74-4d51e3ee423f', 'ふたりの世界', 'あいみょん', 288000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = 'ecbbf5ed-6c28-4462-8a74-4d51e3ee423f' AND ar.mbid = '908d9ac2-5187-4b9e-b281-601c6afb0791'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '61108191-8068-45eb-9067-2f101e52e630', r.id, s.id, 5, 1, NULL, 287000
FROM public.releases r, public.songs s WHERE r.mbid = '5918f7f1-3c74-4723-9167-f55aee2f4043' AND s.mbid = 'ecbbf5ed-6c28-4462-8a74-4d51e3ee423f'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('2ee0ef26-34b5-4338-982d-68f4fd1676ab', '26534138-63e4-4092-967e-334aacc121e4', 'いつまでも', 'あいみょん', 183000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '26534138-63e4-4092-967e-334aacc121e4' AND ar.mbid = '908d9ac2-5187-4b9e-b281-601c6afb0791'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT 'd4acb6e5-6c9d-4597-99aa-c7b7f61e4764', r.id, s.id, 6, 1, NULL, 183000
FROM public.releases r, public.songs s WHERE r.mbid = '5918f7f1-3c74-4723-9167-f55aee2f4043' AND s.mbid = '26534138-63e4-4092-967e-334aacc121e4'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('b673806c-5084-433a-b22a-d96ed34a7a11', 'a01b4aa9-4223-43c3-80f0-57ac830be08f', '愛を伝えたいだとか', 'あいみょん', 235000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = 'a01b4aa9-4223-43c3-80f0-57ac830be08f' AND ar.mbid = '908d9ac2-5187-4b9e-b281-601c6afb0791'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT 'b047dbb6-fc01-440d-85e1-ccf6469897bd', r.id, s.id, 7, 1, NULL, 235000
FROM public.releases r, public.songs s WHERE r.mbid = '5918f7f1-3c74-4723-9167-f55aee2f4043' AND s.mbid = 'a01b4aa9-4223-43c3-80f0-57ac830be08f'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('e469de97-65cb-4855-b61f-224355f4fdca', '7b53870a-526c-4106-8779-82cf196c4e00', '風のささやき', 'あいみょん', 233000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '7b53870a-526c-4106-8779-82cf196c4e00' AND ar.mbid = '908d9ac2-5187-4b9e-b281-601c6afb0791'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT 'bbec0271-6c56-4d48-8ae3-5b86092924d6', r.id, s.id, 8, 1, NULL, 233000
FROM public.releases r, public.songs s WHERE r.mbid = '5918f7f1-3c74-4723-9167-f55aee2f4043' AND s.mbid = '7b53870a-526c-4106-8779-82cf196c4e00'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('6ec290f0-99e1-4062-9c1c-a2bb5840eadd', 'd774f900-8623-47ee-9f5b-056ca14a3903', 'RING DING', 'あいみょん', 236000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = 'd774f900-8623-47ee-9f5b-056ca14a3903' AND ar.mbid = '908d9ac2-5187-4b9e-b281-601c6afb0791'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '2b116e71-5835-4b32-a3e7-39fe2a3a22b2', r.id, s.id, 9, 1, NULL, 235000
FROM public.releases r, public.songs s WHERE r.mbid = '5918f7f1-3c74-4723-9167-f55aee2f4043' AND s.mbid = 'd774f900-8623-47ee-9f5b-056ca14a3903'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('6545f764-0916-40ca-820c-5517f70886da', '70e38a16-a373-465b-9182-f5ca195437c9', 'ジェニファー', 'あいみょん', 224000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '70e38a16-a373-465b-9182-f5ca195437c9' AND ar.mbid = '908d9ac2-5187-4b9e-b281-601c6afb0791'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '901be897-49dd-4300-91ef-fb20b0e2db27', r.id, s.id, 10, 1, NULL, 223000
FROM public.releases r, public.songs s WHERE r.mbid = '5918f7f1-3c74-4723-9167-f55aee2f4043' AND s.mbid = '70e38a16-a373-465b-9182-f5ca195437c9'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('d72028b0-2728-498a-ae50-f8108f56529d', '8a63a39b-9691-44f2-8243-b8d07ebcef07', '漂白', 'あいみょん', 291000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '8a63a39b-9691-44f2-8243-b8d07ebcef07' AND ar.mbid = '908d9ac2-5187-4b9e-b281-601c6afb0791'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT 'c8d50677-72ca-49da-85bb-609ae5b2099a', r.id, s.id, 11, 1, NULL, 291000
FROM public.releases r, public.songs s WHERE r.mbid = '5918f7f1-3c74-4723-9167-f55aee2f4043' AND s.mbid = '8a63a39b-9691-44f2-8243-b8d07ebcef07'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.artists (id, mbid, name, sort_name, type, country, life_begin, life_end, disambiguation)
VALUES ('55b722a8-7fa0-44a0-8be6-cd1847c7db47', '6ef00829-fa94-4fee-a5a6-b28e1208e96a', 'ONE OK ROCK', 'ONE OK ROCK', 'GROUP', 'JP', '2005-04', NULL, '')
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.albums (id, mbid, title, artist_credit, primary_type, first_release_date)
VALUES ('2f114727-a700-4a0b-be47-84bdd418736b', '3fd59d8f-bb35-3275-a536-d4f8e598184a', 'ゼイタクビョウ', 'ONE OK ROCK', 'Album', '2007-11-21')
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.album_artists (album_id, artist_id, position)
SELECT a.id, ar.id, 0 FROM public.albums a, public.artists ar
WHERE a.mbid = '3fd59d8f-bb35-3275-a536-d4f8e598184a' AND ar.mbid = '6ef00829-fa94-4fee-a5a6-b28e1208e96a'
ON CONFLICT (album_id, artist_id) DO NOTHING;
INSERT INTO public.releases (id, mbid, album_id, title, status, country, release_date, release_date_precision, barcode, language, script)
SELECT 'b984a89b-2c41-4d61-938e-9a16863e79b0', '1e887266-e410-4ef6-b148-93752aa542da', albums.id, 'ゼイタクビョウ', 'Official', 'JP', '2007-11-21', 'day', '4943566220535', 'jpn', 'Jpan'
FROM public.albums WHERE mbid = '3fd59d8f-bb35-3275-a536-d4f8e598184a'
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('c1d88654-2617-4006-b9bf-2092a6697de6', 'c4f52f2b-26d0-469e-8ed6-b67c3d95c7a6', '内秘心書', 'ONE OK ROCK', 228506)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = 'c4f52f2b-26d0-469e-8ed6-b67c3d95c7a6' AND ar.mbid = '6ef00829-fa94-4fee-a5a6-b28e1208e96a'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT 'f71df343-e61f-4226-b451-5cb8c7d2e272', r.id, s.id, 1, 1, NULL, 228506
FROM public.releases r, public.songs s WHERE r.mbid = '1e887266-e410-4ef6-b148-93752aa542da' AND s.mbid = 'c4f52f2b-26d0-469e-8ed6-b67c3d95c7a6'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('f105052a-9905-4478-8739-b2a8ebbb0958', 'e03e60d2-16d4-4e30-a0d2-6d49e9d2af76', 'Borderline', 'ONE OK ROCK', 222426)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = 'e03e60d2-16d4-4e30-a0d2-6d49e9d2af76' AND ar.mbid = '6ef00829-fa94-4fee-a5a6-b28e1208e96a'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '28f43897-e055-490e-b0c2-4485f7ade0f0', r.id, s.id, 2, 1, NULL, 222426
FROM public.releases r, public.songs s WHERE r.mbid = '1e887266-e410-4ef6-b148-93752aa542da' AND s.mbid = 'e03e60d2-16d4-4e30-a0d2-6d49e9d2af76'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('b0b48947-f207-43f3-9484-6f96138b140e', 'c6523127-5972-4e55-bbf2-22698241acef', '(you can do) everything', 'ONE OK ROCK', 218173)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = 'c6523127-5972-4e55-bbf2-22698241acef' AND ar.mbid = '6ef00829-fa94-4fee-a5a6-b28e1208e96a'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '7441bbab-77db-439d-81ad-61c0310cbf1f', r.id, s.id, 3, 1, NULL, 218173
FROM public.releases r, public.songs s WHERE r.mbid = '1e887266-e410-4ef6-b148-93752aa542da' AND s.mbid = 'c6523127-5972-4e55-bbf2-22698241acef'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('9d348a20-88be-486e-9e77-0950f3ec179f', '2853b7f3-403f-4131-a6cb-3b55954c547a', '夜にしか咲かない満月', 'ONE OK ROCK', 240226)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '2853b7f3-403f-4131-a6cb-3b55954c547a' AND ar.mbid = '6ef00829-fa94-4fee-a5a6-b28e1208e96a'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT 'd1819066-4bcd-4106-ac97-abe18345f742', r.id, s.id, 4, 1, NULL, 240226
FROM public.releases r, public.songs s WHERE r.mbid = '1e887266-e410-4ef6-b148-93752aa542da' AND s.mbid = '2853b7f3-403f-4131-a6cb-3b55954c547a'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('a44df94d-2235-4d41-b831-a2cba90c8e17', '1ff09eef-8632-47fd-83f6-732804b704f5', '努努-ゆめゆめ-', 'ONE OK ROCK', 195666)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '1ff09eef-8632-47fd-83f6-732804b704f5' AND ar.mbid = '6ef00829-fa94-4fee-a5a6-b28e1208e96a'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT 'c7c50e2a-38e7-4c6c-9d9e-2e5accec217e', r.id, s.id, 5, 1, NULL, 195666
FROM public.releases r, public.songs s WHERE r.mbid = '1e887266-e410-4ef6-b148-93752aa542da' AND s.mbid = '1ff09eef-8632-47fd-83f6-732804b704f5'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('6c244d31-25c1-4e67-b60e-c3461d088831', '48630db1-b8e1-44dc-bb1d-b1cc89ab6980', 'カゲロウ', 'ONE OK ROCK', 248000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '48630db1-b8e1-44dc-bb1d-b1cc89ab6980' AND ar.mbid = '6ef00829-fa94-4fee-a5a6-b28e1208e96a'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '895b2e10-1ca4-4101-8774-9dd49c23a62b', r.id, s.id, 6, 1, NULL, 248000
FROM public.releases r, public.songs s WHERE r.mbid = '1e887266-e410-4ef6-b148-93752aa542da' AND s.mbid = '48630db1-b8e1-44dc-bb1d-b1cc89ab6980'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('e12adc1c-b5b1-49b6-a436-c0d9c3701ef2', 'ca206f2c-393a-47d2-9c05-a17755b9c6c1', 'Lujo', 'ONE OK ROCK', 248000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = 'ca206f2c-393a-47d2-9c05-a17755b9c6c1' AND ar.mbid = '6ef00829-fa94-4fee-a5a6-b28e1208e96a'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '5126f4a6-b1e1-4469-9ede-8bc29eec702a', r.id, s.id, 7, 1, NULL, 248000
FROM public.releases r, public.songs s WHERE r.mbid = '1e887266-e410-4ef6-b148-93752aa542da' AND s.mbid = 'ca206f2c-393a-47d2-9c05-a17755b9c6c1'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('e62f13ac-8990-4394-97a2-ed41dab473b0', 'b5a9fb88-7c0e-4e7f-9e91-384945a9ac7e', 'ケムリ', 'ONE OK ROCK', 262800)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = 'b5a9fb88-7c0e-4e7f-9e91-384945a9ac7e' AND ar.mbid = '6ef00829-fa94-4fee-a5a6-b28e1208e96a'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '2e469d87-de02-44f2-81a7-088a8ac46a3e', r.id, s.id, 8, 1, NULL, 262800
FROM public.releases r, public.songs s WHERE r.mbid = '1e887266-e410-4ef6-b148-93752aa542da' AND s.mbid = 'b5a9fb88-7c0e-4e7f-9e91-384945a9ac7e'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('4564b796-f598-4fa7-9ebd-a05e1134ff00', 'c05759e0-84bb-4e50-a19b-eb8523cc68f7', '欲望に満ちた青年団', 'ONE OK ROCK', 202200)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = 'c05759e0-84bb-4e50-a19b-eb8523cc68f7' AND ar.mbid = '6ef00829-fa94-4fee-a5a6-b28e1208e96a'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT 'd5ed27cb-41ef-4dcf-a5ce-eae32d263567', r.id, s.id, 9, 1, NULL, 202200
FROM public.releases r, public.songs s WHERE r.mbid = '1e887266-e410-4ef6-b148-93752aa542da' AND s.mbid = 'c05759e0-84bb-4e50-a19b-eb8523cc68f7'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('09b390cd-850a-4d54-ba16-79da2645d6dd', '119b5b79-9eb7-43cb-8d32-0dcfc561f69c', 'エトセトラ', 'ONE OK ROCK', 274000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '119b5b79-9eb7-43cb-8d32-0dcfc561f69c' AND ar.mbid = '6ef00829-fa94-4fee-a5a6-b28e1208e96a'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT 'ecfd36f5-2c1c-411b-a795-ee1f20179606', r.id, s.id, 10, 1, NULL, 274000
FROM public.releases r, public.songs s WHERE r.mbid = '1e887266-e410-4ef6-b148-93752aa542da' AND s.mbid = '119b5b79-9eb7-43cb-8d32-0dcfc561f69c'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('3c47adce-eb6a-47c5-8a35-95945609b724', '6b184763-9eb5-42cb-99d9-afd7b42ae006', 'A new one for all, All for the new one', 'ONE OK ROCK', 285933)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '6b184763-9eb5-42cb-99d9-afd7b42ae006' AND ar.mbid = '6ef00829-fa94-4fee-a5a6-b28e1208e96a'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '73eab273-6251-445f-b25f-acc46f040712', r.id, s.id, 11, 1, NULL, 285933
FROM public.releases r, public.songs s WHERE r.mbid = '1e887266-e410-4ef6-b148-93752aa542da' AND s.mbid = '6b184763-9eb5-42cb-99d9-afd7b42ae006'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.artists (id, mbid, name, sort_name, type, country, life_begin, life_end, disambiguation)
VALUES ('0c3887a6-d880-43dc-974a-2d9bfeeba5e3', 'd9dbfe6a-8346-4337-8614-fe96aab63927', 'SEKAI NO OWARI', 'SEKAI NO OWARI', 'GROUP', 'JP', '2007', NULL, '')
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.albums (id, mbid, title, artist_credit, primary_type, first_release_date)
VALUES ('55cc9276-01df-4727-8e61-bb9134d75cef', '08d85e21-b5b9-4a30-8942-40cfdd239ec5', 'EARTH', '世界の終わり', 'Album', '2010-04-07')
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.album_artists (album_id, artist_id, position)
SELECT a.id, ar.id, 0 FROM public.albums a, public.artists ar
WHERE a.mbid = '08d85e21-b5b9-4a30-8942-40cfdd239ec5' AND ar.mbid = 'd9dbfe6a-8346-4337-8614-fe96aab63927'
ON CONFLICT (album_id, artist_id) DO NOTHING;
INSERT INTO public.releases (id, mbid, album_id, title, status, country, release_date, release_date_precision, barcode, language, script)
SELECT '78e71d88-ecfc-462c-901e-84468b0f7e72', '4a373d16-c52f-47ee-9a18-de47f363b48b', albums.id, 'EARTH', 'Official', 'JP', '2010-04-07', 'day', '4519552002920', 'jpn', 'Jpan'
FROM public.albums WHERE mbid = '08d85e21-b5b9-4a30-8942-40cfdd239ec5'
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('17fad87d-538d-4472-aabe-ff5f6100b20c', '89dbdd82-2cd3-415b-bd23-0c9f1908f20d', '幻の命', '世界の終わり', 310466)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '89dbdd82-2cd3-415b-bd23-0c9f1908f20d' AND ar.mbid = 'd9dbfe6a-8346-4337-8614-fe96aab63927'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '364b5a49-865a-4390-867e-eaf5c505ec1d', r.id, s.id, 1, 1, NULL, 310466
FROM public.releases r, public.songs s WHERE r.mbid = '4a373d16-c52f-47ee-9a18-de47f363b48b' AND s.mbid = '89dbdd82-2cd3-415b-bd23-0c9f1908f20d'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('ef2b3cfb-0ba3-4422-a3a0-124fe07fc856', '34c5adbb-7e43-4042-aad6-c45b866fd719', '虹色の戦争', '世界の終わり', 337000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '34c5adbb-7e43-4042-aad6-c45b866fd719' AND ar.mbid = 'd9dbfe6a-8346-4337-8614-fe96aab63927'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '2c942a42-1142-4251-8fd3-c6f889143e71', r.id, s.id, 2, 1, NULL, 337133
FROM public.releases r, public.songs s WHERE r.mbid = '4a373d16-c52f-47ee-9a18-de47f363b48b' AND s.mbid = '34c5adbb-7e43-4042-aad6-c45b866fd719'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('6e5b07bb-4f8e-421f-86bc-3c343d7f75c4', '32fe427c-100a-4d85-bc16-7ce343336c84', 'インスタントラジオ', '世界の終わり', 248000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '32fe427c-100a-4d85-bc16-7ce343336c84' AND ar.mbid = 'd9dbfe6a-8346-4337-8614-fe96aab63927'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '9bd04ad3-e959-4d49-ade9-bdb7b3476d1c', r.id, s.id, 3, 1, NULL, 248333
FROM public.releases r, public.songs s WHERE r.mbid = '4a373d16-c52f-47ee-9a18-de47f363b48b' AND s.mbid = '32fe427c-100a-4d85-bc16-7ce343336c84'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('e6a59acb-8164-482c-a342-a9a0b1c71873', '4a3bedc9-7889-4202-8f9a-5c1fb2d950f1', '青い太陽', '世界の終わり', 311000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '4a3bedc9-7889-4202-8f9a-5c1fb2d950f1' AND ar.mbid = 'd9dbfe6a-8346-4337-8614-fe96aab63927'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT 'f6fada3c-ea53-4ca2-b8f0-12e33734e968', r.id, s.id, 4, 1, NULL, 311866
FROM public.releases r, public.songs s WHERE r.mbid = '4a373d16-c52f-47ee-9a18-de47f363b48b' AND s.mbid = '4a3bedc9-7889-4202-8f9a-5c1fb2d950f1'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('de8351d6-c279-4b3a-a8cb-97c635243b9b', 'd9a85b53-f114-4339-a7be-0beead7e076f', '死の魔法', '世界の終わり', 364000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = 'd9a85b53-f114-4339-a7be-0beead7e076f' AND ar.mbid = 'd9dbfe6a-8346-4337-8614-fe96aab63927'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '9caf96a7-ac00-45e9-aac3-e6c0d80c637c', r.id, s.id, 5, 1, NULL, 364466
FROM public.releases r, public.songs s WHERE r.mbid = '4a373d16-c52f-47ee-9a18-de47f363b48b' AND s.mbid = 'd9a85b53-f114-4339-a7be-0beead7e076f'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('63013b63-8b0e-43e2-87ff-cd4f6eac2764', '1dd39690-ee87-48a5-aeef-62fd93690568', '世界平和', '世界の終わり', 299000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '1dd39690-ee87-48a5-aeef-62fd93690568' AND ar.mbid = 'd9dbfe6a-8346-4337-8614-fe96aab63927'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '5635a56a-2578-455f-92a4-22c3076337e3', r.id, s.id, 6, 1, NULL, 299266
FROM public.releases r, public.songs s WHERE r.mbid = '4a373d16-c52f-47ee-9a18-de47f363b48b' AND s.mbid = '1dd39690-ee87-48a5-aeef-62fd93690568'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('71ea795a-1239-4f4c-937a-75e1c3eb4cf5', '0a04fb3e-1ec7-449a-9e83-5ed35ed679f6', '白昼の夢', '世界の終わり', 408000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '0a04fb3e-1ec7-449a-9e83-5ed35ed679f6' AND ar.mbid = 'd9dbfe6a-8346-4337-8614-fe96aab63927'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT 'e45d0a42-a445-4d24-8db2-c7f2c40fdd28', r.id, s.id, 7, 1, NULL, 408800
FROM public.releases r, public.songs s WHERE r.mbid = '4a373d16-c52f-47ee-9a18-de47f363b48b' AND s.mbid = '0a04fb3e-1ec7-449a-9e83-5ed35ed679f6'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.artists (id, mbid, name, sort_name, type, country, life_begin, life_end, disambiguation)
VALUES ('089f358b-8399-4ba2-be0a-0e9ff58e8007', '4337f1a5-9e02-4b46-98c3-e3c28683a9b5', '優里', 'Yuuri', 'PERSON', 'JP', '1994-03-23', NULL, '')
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.albums (id, mbid, title, artist_credit, primary_type, first_release_date)
VALUES ('8fb61d22-c840-4fed-96b8-7d2e7c5820ad', 'da1c8f98-c48d-48d7-904c-db6fb1683554', '壱', '優里', 'Album', '2022-01-12')
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.album_artists (album_id, artist_id, position)
SELECT a.id, ar.id, 0 FROM public.albums a, public.artists ar
WHERE a.mbid = 'da1c8f98-c48d-48d7-904c-db6fb1683554' AND ar.mbid = '4337f1a5-9e02-4b46-98c3-e3c28683a9b5'
ON CONFLICT (album_id, artist_id) DO NOTHING;
INSERT INTO public.releases (id, mbid, album_id, title, status, country, release_date, release_date_precision, barcode, language, script)
SELECT '9488f6e2-c5c0-4541-8f3e-a37ed267ab6a', '42d00fe4-84e7-4157-9317-2c09c67cc86a', albums.id, '壱', 'Official', 'JP', '2022-01-12', 'day', '4547366536270', 'jpn', 'Jpan'
FROM public.albums WHERE mbid = 'da1c8f98-c48d-48d7-904c-db6fb1683554'
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('1b10fa00-fb6d-488a-a5e4-73efbb84872b', 'fc739bd1-d01c-4c9e-aa95-5369bd749913', 'ベテルギウス', '優里', 231000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = 'fc739bd1-d01c-4c9e-aa95-5369bd749913' AND ar.mbid = '4337f1a5-9e02-4b46-98c3-e3c28683a9b5'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '374c8ae6-47ba-40b0-b610-f1ccba20cddd', r.id, s.id, 1, 1, NULL, 231000
FROM public.releases r, public.songs s WHERE r.mbid = '42d00fe4-84e7-4157-9317-2c09c67cc86a' AND s.mbid = 'fc739bd1-d01c-4c9e-aa95-5369bd749913'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('ddc20387-a40f-49bb-9129-894d170db388', '908f012d-22c9-4778-af6e-2738482bdf50', 'ドライフラワー', '優里', 286000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '908f012d-22c9-4778-af6e-2738482bdf50' AND ar.mbid = '4337f1a5-9e02-4b46-98c3-e3c28683a9b5'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT 'ec7cce1a-1d97-41eb-8e6d-6d4800d1ae16', r.id, s.id, 2, 1, NULL, 286000
FROM public.releases r, public.songs s WHERE r.mbid = '42d00fe4-84e7-4157-9317-2c09c67cc86a' AND s.mbid = '908f012d-22c9-4778-af6e-2738482bdf50'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('fc04f3e6-c7cf-4955-a7ac-49d99706d4eb', 'c6b199f0-0de9-415d-bb93-a8055fed4be0', '花鳥風月', '優里', 206000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = 'c6b199f0-0de9-415d-bb93-a8055fed4be0' AND ar.mbid = '4337f1a5-9e02-4b46-98c3-e3c28683a9b5'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '7f59a2d3-9cbe-4c00-bc6f-da3b3c411e1b', r.id, s.id, 3, 1, NULL, 206000
FROM public.releases r, public.songs s WHERE r.mbid = '42d00fe4-84e7-4157-9317-2c09c67cc86a' AND s.mbid = 'c6b199f0-0de9-415d-bb93-a8055fed4be0'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('7dc3fad0-58a7-47ed-b3d1-f098bef26309', 'a31be040-8f3c-432a-825d-9ebd2dbf5be2', 'ミズキリ', '優里', 208000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = 'a31be040-8f3c-432a-825d-9ebd2dbf5be2' AND ar.mbid = '4337f1a5-9e02-4b46-98c3-e3c28683a9b5'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '4eb04569-8047-4f74-a62f-ae76bcd2925f', r.id, s.id, 4, 1, NULL, 208000
FROM public.releases r, public.songs s WHERE r.mbid = '42d00fe4-84e7-4157-9317-2c09c67cc86a' AND s.mbid = 'a31be040-8f3c-432a-825d-9ebd2dbf5be2'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('652bd21c-4d09-4ebf-8d28-196601d1bd6e', 'faf08152-2542-4d2e-8989-a19308237215', 'シャッター', '優里', 249000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = 'faf08152-2542-4d2e-8989-a19308237215' AND ar.mbid = '4337f1a5-9e02-4b46-98c3-e3c28683a9b5'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '666dcc1e-aaf5-48c6-b28e-345bbfd225be', r.id, s.id, 5, 1, NULL, 249000
FROM public.releases r, public.songs s WHERE r.mbid = '42d00fe4-84e7-4157-9317-2c09c67cc86a' AND s.mbid = 'faf08152-2542-4d2e-8989-a19308237215'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('15c693c1-80f3-40fa-be67-9f20bc749a75', 'cf17d3eb-f7cd-455f-9f04-d7570812b6f5', 'ミザリー', '優里', 242000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = 'cf17d3eb-f7cd-455f-9f04-d7570812b6f5' AND ar.mbid = '4337f1a5-9e02-4b46-98c3-e3c28683a9b5'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT 'e3808803-6865-49fa-a866-63cef8aee389', r.id, s.id, 6, 1, NULL, 242000
FROM public.releases r, public.songs s WHERE r.mbid = '42d00fe4-84e7-4157-9317-2c09c67cc86a' AND s.mbid = 'cf17d3eb-f7cd-455f-9f04-d7570812b6f5'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('d4e7b77f-099d-4d4b-8b8b-420b9e9235ef', '060d4c27-9741-4d77-af88-3d27bbdce8b3', 'レオ', '優里', 239000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '060d4c27-9741-4d77-af88-3d27bbdce8b3' AND ar.mbid = '4337f1a5-9e02-4b46-98c3-e3c28683a9b5'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT 'f8b561e3-715c-4e81-b98f-3185406f6499', r.id, s.id, 7, 1, NULL, 239000
FROM public.releases r, public.songs s WHERE r.mbid = '42d00fe4-84e7-4157-9317-2c09c67cc86a' AND s.mbid = '060d4c27-9741-4d77-af88-3d27bbdce8b3'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('2692cb19-229b-49c5-b0b9-a996d4e1cc26', 'b8b272fb-0d2d-4c4d-9d62-155312dcb1bd', 'ピーターパン', '優里', 215000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = 'b8b272fb-0d2d-4c4d-9d62-155312dcb1bd' AND ar.mbid = '4337f1a5-9e02-4b46-98c3-e3c28683a9b5'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '3c4d6d1d-4ffe-4238-89a9-5f52b9931001', r.id, s.id, 8, 1, NULL, 215000
FROM public.releases r, public.songs s WHERE r.mbid = '42d00fe4-84e7-4157-9317-2c09c67cc86a' AND s.mbid = 'b8b272fb-0d2d-4c4d-9d62-155312dcb1bd'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('daa0c620-7bbd-457c-a98c-a63c77773767', '88f2ee58-fcde-44ee-991a-a7fd149b85a1', 'スマホウォーズ', '優里', 229000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '88f2ee58-fcde-44ee-991a-a7fd149b85a1' AND ar.mbid = '4337f1a5-9e02-4b46-98c3-e3c28683a9b5'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '78a045d1-1138-4560-9329-52799b7efeb2', r.id, s.id, 9, 1, NULL, 229000
FROM public.releases r, public.songs s WHERE r.mbid = '42d00fe4-84e7-4157-9317-2c09c67cc86a' AND s.mbid = '88f2ee58-fcde-44ee-991a-a7fd149b85a1'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('86481b6d-eed4-404e-83c9-896f65ca66a3', 'b8155a31-883b-4133-a916-50784e0141f2', '夏音', '優里', 239000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = 'b8155a31-883b-4133-a916-50784e0141f2' AND ar.mbid = '4337f1a5-9e02-4b46-98c3-e3c28683a9b5'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT 'dae197ed-fc07-466c-a101-bb4cc3b7ea3c', r.id, s.id, 10, 1, NULL, 239000
FROM public.releases r, public.songs s WHERE r.mbid = '42d00fe4-84e7-4157-9317-2c09c67cc86a' AND s.mbid = 'b8155a31-883b-4133-a916-50784e0141f2'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('2b152f70-3764-4995-8a82-b68885a01a00', '096b405c-41f7-498a-b062-9303fce46847', '背中', '優里', 238000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '096b405c-41f7-498a-b062-9303fce46847' AND ar.mbid = '4337f1a5-9e02-4b46-98c3-e3c28683a9b5'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '79b42ff5-35e2-403c-b86e-f8530a9fe761', r.id, s.id, 11, 1, NULL, 238000
FROM public.releases r, public.songs s WHERE r.mbid = '42d00fe4-84e7-4157-9317-2c09c67cc86a' AND s.mbid = '096b405c-41f7-498a-b062-9303fce46847'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('8b269cef-b104-4f10-9654-0b091e409a64', 'f7832dfe-4a97-4adf-93db-ba2f7ec4031f', 'かごめ', '優里', 272000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = 'f7832dfe-4a97-4adf-93db-ba2f7ec4031f' AND ar.mbid = '4337f1a5-9e02-4b46-98c3-e3c28683a9b5'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '403f06e8-cceb-427b-8cd9-ffc4edc019ac', r.id, s.id, 12, 1, NULL, 272000
FROM public.releases r, public.songs s WHERE r.mbid = '42d00fe4-84e7-4157-9317-2c09c67cc86a' AND s.mbid = 'f7832dfe-4a97-4adf-93db-ba2f7ec4031f'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('5007a8e5-7430-4ac1-8030-5d9a19feb570', '1f66d924-459e-4495-8013-5e3f8272cc11', '桜晴', '優里', 238000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '1f66d924-459e-4495-8013-5e3f8272cc11' AND ar.mbid = '4337f1a5-9e02-4b46-98c3-e3c28683a9b5'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '49d92504-6e20-4f86-9f04-9cb33f4ff330', r.id, s.id, 13, 1, NULL, 238000
FROM public.releases r, public.songs s WHERE r.mbid = '42d00fe4-84e7-4157-9317-2c09c67cc86a' AND s.mbid = '1f66d924-459e-4495-8013-5e3f8272cc11'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('66026f65-ab2f-461f-9957-c2da16d1a8ed', 'cd7fa1a1-8732-4985-a2ec-8fed7be0e025', 'インフィニティ', '優里', 245000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = 'cd7fa1a1-8732-4985-a2ec-8fed7be0e025' AND ar.mbid = '4337f1a5-9e02-4b46-98c3-e3c28683a9b5'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '50aeecd4-2184-45f6-a124-a4a02d39f210', r.id, s.id, 14, 1, NULL, 245000
FROM public.releases r, public.songs s WHERE r.mbid = '42d00fe4-84e7-4157-9317-2c09c67cc86a' AND s.mbid = 'cd7fa1a1-8732-4985-a2ec-8fed7be0e025'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('d4b9e173-0364-42be-9d33-971963f1690c', 'bf964e51-db93-442c-9a8f-fc124745ebf2', '飛行船', '優里', 196000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = 'bf964e51-db93-442c-9a8f-fc124745ebf2' AND ar.mbid = '4337f1a5-9e02-4b46-98c3-e3c28683a9b5'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT 'a3867986-5a63-4604-a705-bc7f495b2a7e', r.id, s.id, 15, 1, NULL, 196000
FROM public.releases r, public.songs s WHERE r.mbid = '42d00fe4-84e7-4157-9317-2c09c67cc86a' AND s.mbid = 'bf964e51-db93-442c-9a8f-fc124745ebf2'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('d39e2889-f448-4383-9694-11525ea74623', 'd7576a59-7fff-4b4f-bc8c-1da33cf173c3', 'かくれんぼ', '優里', 271000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = 'd7576a59-7fff-4b4f-bc8c-1da33cf173c3' AND ar.mbid = '4337f1a5-9e02-4b46-98c3-e3c28683a9b5'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT 'd4ed687a-c898-4f78-af39-6c6fc2008505', r.id, s.id, 16, 1, NULL, 271000
FROM public.releases r, public.songs s WHERE r.mbid = '42d00fe4-84e7-4157-9317-2c09c67cc86a' AND s.mbid = 'd7576a59-7fff-4b4f-bc8c-1da33cf173c3'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.artists (id, mbid, name, sort_name, type, country, life_begin, life_end, disambiguation)
VALUES ('f0bb7ea9-5494-47a2-8e30-8661914f9958', '66bdd1c9-d1c5-40b7-a487-5061fffbd87d', 'Eve', 'Eve', 'PERSON', 'JP', '1995-05-23', NULL, 'Japanese singer-songwriter, utaite, and Vocaloid producer')
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.albums (id, mbid, title, artist_credit, primary_type, first_release_date)
VALUES ('662d31ba-3382-4b77-9da3-f941030aa533', '104c0cd9-2f3b-4072-b20b-fd345fae38a1', 'Wonder Word', 'Eve', 'Album', '2014-08-17')
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.album_artists (album_id, artist_id, position)
SELECT a.id, ar.id, 0 FROM public.albums a, public.artists ar
WHERE a.mbid = '104c0cd9-2f3b-4072-b20b-fd345fae38a1' AND ar.mbid = '66bdd1c9-d1c5-40b7-a487-5061fffbd87d'
ON CONFLICT (album_id, artist_id) DO NOTHING;
INSERT INTO public.releases (id, mbid, album_id, title, status, country, release_date, release_date_precision, barcode, language, script)
SELECT '973661c5-eefb-4d32-97fb-edf4d65896dc', '01ed8341-6562-4a94-af1a-f4a0e9950a20', albums.id, 'Wonder Word', 'Official', 'JP', '2014-08-17', 'day', '4562251593107', 'jpn', NULL
FROM public.albums WHERE mbid = '104c0cd9-2f3b-4072-b20b-fd345fae38a1'
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('7b3af7f0-98fd-4f57-babc-1b74fe31be1b', '70eb4511-169a-4cab-82d0-3fda40f0ec49', 'よるのゆめ', 'Eve', 224906)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '70eb4511-169a-4cab-82d0-3fda40f0ec49' AND ar.mbid = '66bdd1c9-d1c5-40b7-a487-5061fffbd87d'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT 'ad3c1a80-f314-4d53-80ce-f15452530e4e', r.id, s.id, 1, 1, NULL, 224906
FROM public.releases r, public.songs s WHERE r.mbid = '01ed8341-6562-4a94-af1a-f4a0e9950a20' AND s.mbid = '70eb4511-169a-4cab-82d0-3fda40f0ec49'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('5d1d96a1-e2e2-45e3-ade2-d9c80d43c584', 'ce128e46-f941-4b84-a991-28301f04d158', 'アルカリ成人', 'Eve', 228346)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = 'ce128e46-f941-4b84-a991-28301f04d158' AND ar.mbid = '66bdd1c9-d1c5-40b7-a487-5061fffbd87d'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '9d0d34c5-e757-47e0-b598-50656bed223f', r.id, s.id, 2, 1, NULL, 228346
FROM public.releases r, public.songs s WHERE r.mbid = '01ed8341-6562-4a94-af1a-f4a0e9950a20' AND s.mbid = 'ce128e46-f941-4b84-a991-28301f04d158'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('ca429f40-24a0-488b-b1df-838252620055', 'af0bb2bf-c765-45aa-a095-083673bd270b', '線香花火', 'Eve', 253960)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = 'af0bb2bf-c765-45aa-a095-083673bd270b' AND ar.mbid = '66bdd1c9-d1c5-40b7-a487-5061fffbd87d'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT 'e79bbd19-1f5e-4568-88eb-d18d3670049a', r.id, s.id, 3, 1, NULL, 253960
FROM public.releases r, public.songs s WHERE r.mbid = '01ed8341-6562-4a94-af1a-f4a0e9950a20' AND s.mbid = 'af0bb2bf-c765-45aa-a095-083673bd270b'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('377999a7-7b90-4126-84fd-496ac0be716f', '9d363ba3-026f-4722-a076-e869682b4aea', 'ヘロウメロウ', 'Eve', 216893)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '9d363ba3-026f-4722-a076-e869682b4aea' AND ar.mbid = '66bdd1c9-d1c5-40b7-a487-5061fffbd87d'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT 'bd51dea1-ae1f-405d-ab57-5dabb37acec6', r.id, s.id, 4, 1, NULL, 216893
FROM public.releases r, public.songs s WHERE r.mbid = '01ed8341-6562-4a94-af1a-f4a0e9950a20' AND s.mbid = '9d363ba3-026f-4722-a076-e869682b4aea'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('c7b02a89-16dc-44bb-9bd7-064c1f985b00', '48a6e263-1293-431f-bd14-345e956e745f', '蜃気楼', 'Eve', 222440)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '48a6e263-1293-431f-bd14-345e956e745f' AND ar.mbid = '66bdd1c9-d1c5-40b7-a487-5061fffbd87d'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT 'e4060830-ba6f-4036-9b1d-550f2963036e', r.id, s.id, 5, 1, NULL, 222440
FROM public.releases r, public.songs s WHERE r.mbid = '01ed8341-6562-4a94-af1a-f4a0e9950a20' AND s.mbid = '48a6e263-1293-431f-bd14-345e956e745f'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('55c03f20-9350-49ab-abc7-ee00493f0319', 'fd196f3c-b155-429e-bd26-3588ce7555f1', 'またあした', 'Eve', 193346)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = 'fd196f3c-b155-429e-bd26-3588ce7555f1' AND ar.mbid = '66bdd1c9-d1c5-40b7-a487-5061fffbd87d'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '0a5b7019-3555-4f4b-89be-d10e8e9f28b6', r.id, s.id, 6, 1, NULL, 193346
FROM public.releases r, public.songs s WHERE r.mbid = '01ed8341-6562-4a94-af1a-f4a0e9950a20' AND s.mbid = 'fd196f3c-b155-429e-bd26-3588ce7555f1'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('4eb271a4-1941-41cb-b36b-7354aad6c8f1', '64eef38e-10f3-4c60-80d4-efa05c6a4b07', '夜を超えろ', 'Eve', 199146)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '64eef38e-10f3-4c60-80d4-efa05c6a4b07' AND ar.mbid = '66bdd1c9-d1c5-40b7-a487-5061fffbd87d'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '0c3ea125-02d5-493b-a50c-b7ddc2c2f49a', r.id, s.id, 7, 1, NULL, 199146
FROM public.releases r, public.songs s WHERE r.mbid = '01ed8341-6562-4a94-af1a-f4a0e9950a20' AND s.mbid = '64eef38e-10f3-4c60-80d4-efa05c6a4b07'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.artists (id, mbid, name, sort_name, type, country, life_begin, life_end, disambiguation)
VALUES ('d5ddedb6-c696-4806-8876-5488611b2e1f', '0e8b86c5-68b0-4ddd-9abc-9898cba7bfb4', 'バルーン', 'balloon', 'PERSON', 'JP', '1993-01-20', NULL, 'Vocaloid producer')
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.albums (id, mbid, title, artist_credit, primary_type, first_release_date)
VALUES ('20144246-781d-40a3-9d8c-6c50f67f560a', '01598355-6fa9-41e3-9df5-6c1e37879c51', 'apartment', 'バルーン', 'Album', '2015-04-26')
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.album_artists (album_id, artist_id, position)
SELECT a.id, ar.id, 0 FROM public.albums a, public.artists ar
WHERE a.mbid = '01598355-6fa9-41e3-9df5-6c1e37879c51' AND ar.mbid = '0e8b86c5-68b0-4ddd-9abc-9898cba7bfb4'
ON CONFLICT (album_id, artist_id) DO NOTHING;
INSERT INTO public.releases (id, mbid, album_id, title, status, country, release_date, release_date_precision, barcode, language, script)
SELECT '82ab368b-46c2-4f15-b977-9deac8ef87f3', '7603e6d9-b3b3-48d4-86b9-f2da77ae5c02', albums.id, 'apartment', 'Official', 'JP', '2015-04-26', 'day', '859753978063', NULL, NULL
FROM public.albums WHERE mbid = '01598355-6fa9-41e3-9df5-6c1e37879c51'
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('2c621f66-6aef-45aa-92b6-b51815004310', 'd023855d-6837-4b5a-b909-4fb87d326adc', 'アルコーブ', 'バルーン', 232453)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = 'd023855d-6837-4b5a-b909-4fb87d326adc' AND ar.mbid = '0e8b86c5-68b0-4ddd-9abc-9898cba7bfb4'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '14e2daee-ef65-4016-9d2a-21d2e9b74379', r.id, s.id, 1, 1, NULL, 232453
FROM public.releases r, public.songs s WHERE r.mbid = '7603e6d9-b3b3-48d4-86b9-f2da77ae5c02' AND s.mbid = 'd023855d-6837-4b5a-b909-4fb87d326adc'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('ff3925da-448c-47b3-8ba0-59f7def56171', 'ccfc74f7-627c-46ef-ac9d-8d38a92a3483', 'ポートレート', 'バルーン', 215600)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = 'ccfc74f7-627c-46ef-ac9d-8d38a92a3483' AND ar.mbid = '0e8b86c5-68b0-4ddd-9abc-9898cba7bfb4'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '95c0ad4c-e767-46e4-8909-97addc1cfe74', r.id, s.id, 2, 1, NULL, 215600
FROM public.releases r, public.songs s WHERE r.mbid = '7603e6d9-b3b3-48d4-86b9-f2da77ae5c02' AND s.mbid = 'ccfc74f7-627c-46ef-ac9d-8d38a92a3483'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('ec41fc7d-833e-4e1c-826e-0aced6774271', 'cc9f2f62-3cf4-4303-b8c3-3d9d431a9ac1', '奇々怪々', 'バルーン', 205826)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = 'cc9f2f62-3cf4-4303-b8c3-3d9d431a9ac1' AND ar.mbid = '0e8b86c5-68b0-4ddd-9abc-9898cba7bfb4'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT 'ffdf00c9-e400-46b4-8938-ca24a337bd0a', r.id, s.id, 3, 1, NULL, 205826
FROM public.releases r, public.songs s WHERE r.mbid = '7603e6d9-b3b3-48d4-86b9-f2da77ae5c02' AND s.mbid = 'cc9f2f62-3cf4-4303-b8c3-3d9d431a9ac1'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('8ac4ea2f-c2f2-4483-9d09-1d30c242a443', '07302466-152e-4f6e-a50d-6c0fa3b1335c', '真夜中の引力', 'バルーン', 266240)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '07302466-152e-4f6e-a50d-6c0fa3b1335c' AND ar.mbid = '0e8b86c5-68b0-4ddd-9abc-9898cba7bfb4'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '2684707e-69c5-46dd-9e2b-7acee3c8ff1f', r.id, s.id, 4, 1, NULL, 266240
FROM public.releases r, public.songs s WHERE r.mbid = '7603e6d9-b3b3-48d4-86b9-f2da77ae5c02' AND s.mbid = '07302466-152e-4f6e-a50d-6c0fa3b1335c'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('ad3fd143-c619-4d3a-8403-8527ec22c2cf', '5c2a2bbb-78a1-4374-9380-5cb05008702e', 'モーダル', 'バルーン', 231560)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '5c2a2bbb-78a1-4374-9380-5cb05008702e' AND ar.mbid = '0e8b86c5-68b0-4ddd-9abc-9898cba7bfb4'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT 'b55ca2ca-8714-4edc-a654-f3dcc4dbf6b3', r.id, s.id, 5, 1, NULL, 231560
FROM public.releases r, public.songs s WHERE r.mbid = '7603e6d9-b3b3-48d4-86b9-f2da77ae5c02' AND s.mbid = '5c2a2bbb-78a1-4374-9380-5cb05008702e'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('a98b1a69-eb2d-4038-813d-b0c8f8fb7ae1', 'ee1cf891-027f-420b-8280-cd7b1ca9e47d', '生活感', 'バルーン', 230093)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = 'ee1cf891-027f-420b-8280-cd7b1ca9e47d' AND ar.mbid = '0e8b86c5-68b0-4ddd-9abc-9898cba7bfb4'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '78c6f3e9-7b8c-4115-a2d3-32ec794e17c2', r.id, s.id, 6, 1, NULL, 230093
FROM public.releases r, public.songs s WHERE r.mbid = '7603e6d9-b3b3-48d4-86b9-f2da77ae5c02' AND s.mbid = 'ee1cf891-027f-420b-8280-cd7b1ca9e47d'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('a6dfdb03-abd6-4ce1-995a-dad320a039e6', 'b635c653-87ea-4d4f-85a0-7d39642e19cc', '愛及屋烏', 'バルーン', 247520)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = 'b635c653-87ea-4d4f-85a0-7d39642e19cc' AND ar.mbid = '0e8b86c5-68b0-4ddd-9abc-9898cba7bfb4'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT 'ba18ab91-9ad3-4345-9b6e-74d78d8a1443', r.id, s.id, 7, 1, NULL, 247520
FROM public.releases r, public.songs s WHERE r.mbid = '7603e6d9-b3b3-48d4-86b9-f2da77ae5c02' AND s.mbid = 'b635c653-87ea-4d4f-85a0-7d39642e19cc'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('9a6131ea-c522-4d52-a5fe-ebb26c55f607', 'd4ad7e09-87e7-4f2a-b5ba-e281c52cba6a', 'カフス', 'バルーン', 215653)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = 'd4ad7e09-87e7-4f2a-b5ba-e281c52cba6a' AND ar.mbid = '0e8b86c5-68b0-4ddd-9abc-9898cba7bfb4'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '969c9822-5f26-4dbc-a031-3acc4f39c4b3', r.id, s.id, 8, 1, NULL, 215653
FROM public.releases r, public.songs s WHERE r.mbid = '7603e6d9-b3b3-48d4-86b9-f2da77ae5c02' AND s.mbid = 'd4ad7e09-87e7-4f2a-b5ba-e281c52cba6a'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('6d05ed44-f39a-4274-8f50-ee191a57863e', '02d86730-b99f-4d5c-b1e2-391559ecf012', '夜の帳が落ちる', 'バルーン', 227106)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '02d86730-b99f-4d5c-b1e2-391559ecf012' AND ar.mbid = '0e8b86c5-68b0-4ddd-9abc-9898cba7bfb4'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '240410f1-4047-4922-ae35-5fcf188e0cd2', r.id, s.id, 9, 1, NULL, 227106
FROM public.releases r, public.songs s WHERE r.mbid = '7603e6d9-b3b3-48d4-86b9-f2da77ae5c02' AND s.mbid = '02d86730-b99f-4d5c-b1e2-391559ecf012'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('764764e0-a95c-4e65-a91f-d43020b5daeb', 'a201d824-789b-42b4-b829-173ad6ae69de', '秋は暮れて疎ら', 'バルーン', 243680)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = 'a201d824-789b-42b4-b829-173ad6ae69de' AND ar.mbid = '0e8b86c5-68b0-4ddd-9abc-9898cba7bfb4'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '99b20449-b271-4e69-81b7-018acad8a9e6', r.id, s.id, 10, 1, NULL, 243680
FROM public.releases r, public.songs s WHERE r.mbid = '7603e6d9-b3b3-48d4-86b9-f2da77ae5c02' AND s.mbid = 'a201d824-789b-42b4-b829-173ad6ae69de'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('b32aa4ba-bd62-4a43-9ba1-eb3c36e13bad', 'ab6fa89d-5046-4b7e-8550-1665cc66523a', 'アパートメント', 'バルーン', 345000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = 'ab6fa89d-5046-4b7e-8550-1665cc66523a' AND ar.mbid = '0e8b86c5-68b0-4ddd-9abc-9898cba7bfb4'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '9149271b-8196-4087-b20b-3710b05bc8fb', r.id, s.id, 11, 1, NULL, 345000
FROM public.releases r, public.songs s WHERE r.mbid = '7603e6d9-b3b3-48d4-86b9-f2da77ae5c02' AND s.mbid = 'ab6fa89d-5046-4b7e-8550-1665cc66523a'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.artists (id, mbid, name, sort_name, type, country, life_begin, life_end, disambiguation)
VALUES ('609a915c-03af-4c45-8bf3-956b4ff4d47d', 'df6c619f-4334-43e2-8b6a-4a32af1e4f85', 'YOASOBI', 'YOASOBI', 'GROUP', 'JP', '2019-09-30', NULL, '')
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.albums (id, mbid, title, artist_credit, primary_type, first_release_date)
VALUES ('937517bc-27c1-47e1-a493-332a17474257', '6ddc7e3d-6fc7-4859-9e35-b666e49b40f5', 'THE BOOK', 'YOASOBI', 'EP', '2021-01-06')
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.album_artists (album_id, artist_id, position)
SELECT a.id, ar.id, 0 FROM public.albums a, public.artists ar
WHERE a.mbid = '6ddc7e3d-6fc7-4859-9e35-b666e49b40f5' AND ar.mbid = 'df6c619f-4334-43e2-8b6a-4a32af1e4f85'
ON CONFLICT (album_id, artist_id) DO NOTHING;
INSERT INTO public.releases (id, mbid, album_id, title, status, country, release_date, release_date_precision, barcode, language, script)
SELECT '3147fb35-5a2a-41ad-b2ac-2644cfdc85d5', 'b369422a-f73b-451f-b0a6-696621cf591f', albums.id, 'THE BOOK', 'Official', 'JP', '2021-01-06', 'day', '4538182931059', 'jpn', 'Jpan'
FROM public.albums WHERE mbid = '6ddc7e3d-6fc7-4859-9e35-b666e49b40f5'
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('dadeda67-b4cc-424b-a235-d17035d15027', '25519c7d-89a2-4eba-ba68-da406eb5607f', 'Epilogue', 'YOASOBI', 50000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '25519c7d-89a2-4eba-ba68-da406eb5607f' AND ar.mbid = 'df6c619f-4334-43e2-8b6a-4a32af1e4f85'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '9730aa92-98a0-4caa-b746-55b9ec059ba1', r.id, s.id, 1, 1, NULL, 50000
FROM public.releases r, public.songs s WHERE r.mbid = 'b369422a-f73b-451f-b0a6-696621cf591f' AND s.mbid = '25519c7d-89a2-4eba-ba68-da406eb5607f'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('43e681dd-0be7-45b8-b036-c4109625e188', 'e81364cf-8184-4533-8778-91cf582bfabf', 'アンコール', 'YOASOBI', 271440)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = 'e81364cf-8184-4533-8778-91cf582bfabf' AND ar.mbid = 'df6c619f-4334-43e2-8b6a-4a32af1e4f85'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT 'f0ad1b3b-77df-44e5-884f-846a6e127f0b', r.id, s.id, 2, 1, NULL, 271000
FROM public.releases r, public.songs s WHERE r.mbid = 'b369422a-f73b-451f-b0a6-696621cf591f' AND s.mbid = 'e81364cf-8184-4533-8778-91cf582bfabf'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('f867fd7b-1229-4d93-a78d-a650108e431a', '98ff893e-796b-4dfd-9930-c8efb784c2f1', 'ハルジオン', 'YOASOBI', 198000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '98ff893e-796b-4dfd-9930-c8efb784c2f1' AND ar.mbid = 'df6c619f-4334-43e2-8b6a-4a32af1e4f85'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT 'afedc514-c060-454f-8d31-d91cdcba0b31', r.id, s.id, 3, 1, NULL, 198000
FROM public.releases r, public.songs s WHERE r.mbid = 'b369422a-f73b-451f-b0a6-696621cf591f' AND s.mbid = '98ff893e-796b-4dfd-9930-c8efb784c2f1'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('f2a66a28-52b4-4ba4-b8dc-8bd414fe4d38', '781c2bb5-df1b-444e-8e0b-4c5ddff7fc2a', 'あの夢をなぞって', 'YOASOBI', 240746)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '781c2bb5-df1b-444e-8e0b-4c5ddff7fc2a' AND ar.mbid = 'df6c619f-4334-43e2-8b6a-4a32af1e4f85'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '0a465679-09fc-4316-950b-98fd4cb83cb5', r.id, s.id, 4, 1, NULL, 240000
FROM public.releases r, public.songs s WHERE r.mbid = 'b369422a-f73b-451f-b0a6-696621cf591f' AND s.mbid = '781c2bb5-df1b-444e-8e0b-4c5ddff7fc2a'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('e5d092c2-e4e7-4f1d-9958-1cb0d77d0490', '498f8986-5e5f-4327-bf72-f2f4ddf8d848', 'たぶん', 'YOASOBI', 256773)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '498f8986-5e5f-4327-bf72-f2f4ddf8d848' AND ar.mbid = 'df6c619f-4334-43e2-8b6a-4a32af1e4f85'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT 'ccc7fb51-91da-43b0-81ce-be2a44a3a649', r.id, s.id, 5, 1, NULL, 256000
FROM public.releases r, public.songs s WHERE r.mbid = 'b369422a-f73b-451f-b0a6-696621cf591f' AND s.mbid = '498f8986-5e5f-4327-bf72-f2f4ddf8d848'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('c1404df7-8e0b-4899-8adc-493d40fb60dc', '7c9374ac-0d6d-47c7-a7ee-544b5bd70475', '群青', 'YOASOBI', 248000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '7c9374ac-0d6d-47c7-a7ee-544b5bd70475' AND ar.mbid = 'df6c619f-4334-43e2-8b6a-4a32af1e4f85'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '1b537c2a-79e2-47c2-be16-f6bda8296dfd', r.id, s.id, 6, 1, NULL, 248000
FROM public.releases r, public.songs s WHERE r.mbid = 'b369422a-f73b-451f-b0a6-696621cf591f' AND s.mbid = '7c9374ac-0d6d-47c7-a7ee-544b5bd70475'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('f0c6705c-d9f1-49f0-a9a1-a49116811af0', 'dab7ebd0-765e-4949-9909-80af4dc09592', 'ハルカ', 'YOASOBI', 243613)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = 'dab7ebd0-765e-4949-9909-80af4dc09592' AND ar.mbid = 'df6c619f-4334-43e2-8b6a-4a32af1e4f85'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '987d960d-dea2-46ce-8ecd-752f8a9a909b', r.id, s.id, 7, 1, NULL, 243000
FROM public.releases r, public.songs s WHERE r.mbid = 'b369422a-f73b-451f-b0a6-696621cf591f' AND s.mbid = 'dab7ebd0-765e-4949-9909-80af4dc09592'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('aaa661e5-b917-47b3-9e46-8414b5b1642b', '57a6dff3-daee-4e63-bc82-6bd6f5df2957', '夜に駆ける', 'YOASOBI', 258839)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '57a6dff3-daee-4e63-bc82-6bd6f5df2957' AND ar.mbid = 'df6c619f-4334-43e2-8b6a-4a32af1e4f85'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '301be99b-aec1-4693-a059-e23283c19b82', r.id, s.id, 8, 1, NULL, 258000
FROM public.releases r, public.songs s WHERE r.mbid = 'b369422a-f73b-451f-b0a6-696621cf591f' AND s.mbid = '57a6dff3-daee-4e63-bc82-6bd6f5df2957'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('64d9c117-00b7-49eb-8777-be904cfed6c9', '0eeadd64-fe58-432f-aa39-ae952cdbd7f6', 'Prologue', 'YOASOBI', 35000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '0eeadd64-fe58-432f-aa39-ae952cdbd7f6' AND ar.mbid = 'df6c619f-4334-43e2-8b6a-4a32af1e4f85'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '77409be8-4d4e-4d14-b4f5-f4f84dad686d', r.id, s.id, 9, 1, NULL, 35000
FROM public.releases r, public.songs s WHERE r.mbid = 'b369422a-f73b-451f-b0a6-696621cf591f' AND s.mbid = '0eeadd64-fe58-432f-aa39-ae952cdbd7f6'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
