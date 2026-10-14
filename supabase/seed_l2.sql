-- Phase C seed batch LEAN: J-POP artists core tables only (idempotent)
-- artists/albums/releases/songs/tracks + link tables.
-- Source: MusicBrainz (canonical).
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = 'eefdc3f3-c020-4688-8a7e-365d5ca07d23' AND ar.mbid = '6f500293-7396-4903-b4fd-118127d06f9e'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '0e45dadc-3707-49fb-9bb0-75e6689b1ecd', r.id, s.id, 3, 1, NULL, 378133
FROM public.releases r, public.songs s WHERE r.mbid = '845e7a50-3064-44cd-a319-5ee7403d9222' AND s.mbid = 'eefdc3f3-c020-4688-8a7e-365d5ca07d23'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('d1a37ab3-a340-4ac5-a8b3-ebd8d0e12ae0', '53bc784d-d219-4c5a-a8ec-df1774aaf561', 'もしも「みんな一緒に」バージョン', 'RADWIMPS', 338000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '53bc784d-d219-4c5a-a8ec-df1774aaf561' AND ar.mbid = '6f500293-7396-4903-b4fd-118127d06f9e'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '18dfadf2-edb1-4f9c-8f46-edbf789e81f8', r.id, s.id, 4, 1, NULL, 338293
FROM public.releases r, public.songs s WHERE r.mbid = '845e7a50-3064-44cd-a319-5ee7403d9222' AND s.mbid = '53bc784d-d219-4c5a-a8ec-df1774aaf561'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('9a3e33f9-1183-472b-9e86-4bdf6db52ef3', '9a660578-4b97-4199-872b-e03ea42ae136', 'さみしい僕', 'RADWIMPS', 260000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '9a660578-4b97-4199-872b-e03ea42ae136' AND ar.mbid = '6f500293-7396-4903-b4fd-118127d06f9e'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '72278af7-7fc5-4345-b102-a3d40e8d5794', r.id, s.id, 5, 1, NULL, 260573
FROM public.releases r, public.songs s WHERE r.mbid = '845e7a50-3064-44cd-a319-5ee7403d9222' AND s.mbid = '9a660578-4b97-4199-872b-e03ea42ae136'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('90d0d066-97f5-4a91-a2f7-f40cd463f553', 'cd842018-2291-497d-b5c4-da931d00ef71', 'コンドーム', 'RADWIMPS', 294000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = 'cd842018-2291-497d-b5c4-da931d00ef71' AND ar.mbid = '6f500293-7396-4903-b4fd-118127d06f9e'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '296ea58c-2304-4752-ae95-9af8f133aaa2', r.id, s.id, 6, 1, NULL, 294200
FROM public.releases r, public.songs s WHERE r.mbid = '845e7a50-3064-44cd-a319-5ee7403d9222' AND s.mbid = 'cd842018-2291-497d-b5c4-da931d00ef71'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('7cae80b6-efc1-47e2-a2f2-a1f221d4daa1', '75b815ea-2ce2-4c88-a8aa-ab8fe9d6da40', '青い春', 'RADWIMPS', 246000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '75b815ea-2ce2-4c88-a8aa-ab8fe9d6da40' AND ar.mbid = '6f500293-7396-4903-b4fd-118127d06f9e'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT 'c68c4a21-659b-4c95-aeab-b6f576e49ba9', r.id, s.id, 7, 1, NULL, 246600
FROM public.releases r, public.songs s WHERE r.mbid = '845e7a50-3064-44cd-a319-5ee7403d9222' AND s.mbid = '75b815ea-2ce2-4c88-a8aa-ab8fe9d6da40'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('ef89cbfe-1c79-491b-9c4b-ed0a51b1f482', 'f5e37bd1-649b-4136-9217-d43d24d2f4ef', '「ぼく」と「僕」', 'RADWIMPS', 176333)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = 'f5e37bd1-649b-4136-9217-d43d24d2f4ef' AND ar.mbid = '6f500293-7396-4903-b4fd-118127d06f9e'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT 'c59b48df-edc5-4b3d-a9a1-f6862a2a2528', r.id, s.id, 8, 1, NULL, 176333
FROM public.releases r, public.songs s WHERE r.mbid = '845e7a50-3064-44cd-a319-5ee7403d9222' AND s.mbid = 'f5e37bd1-649b-4136-9217-d43d24d2f4ef'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('eddb0890-5132-45de-b9ca-a60a53076e5e', '22de2d09-9914-4f14-a240-959c7e9e3ccf', 'あいまい', 'RADWIMPS', 178000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '22de2d09-9914-4f14-a240-959c7e9e3ccf' AND ar.mbid = '6f500293-7396-4903-b4fd-118127d06f9e'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '74a95d81-3ff5-4f0d-bf25-a15ccb08ca4f', r.id, s.id, 9, 1, NULL, 178826
FROM public.releases r, public.songs s WHERE r.mbid = '845e7a50-3064-44cd-a319-5ee7403d9222' AND s.mbid = '22de2d09-9914-4f14-a240-959c7e9e3ccf'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('a2ad7fc2-047e-4518-887a-8a760152415e', '5aa68110-a0ae-4b41-bd3d-01cc82905d0e', '嫌ん', 'RADWIMPS', 357000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '5aa68110-a0ae-4b41-bd3d-01cc82905d0e' AND ar.mbid = '6f500293-7396-4903-b4fd-118127d06f9e'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT 'e848d341-c5a3-40c3-926d-cdd0af086743', r.id, s.id, 10, 1, NULL, 357066
FROM public.releases r, public.songs s WHERE r.mbid = '845e7a50-3064-44cd-a319-5ee7403d9222' AND s.mbid = '5aa68110-a0ae-4b41-bd3d-01cc82905d0e'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('0c7dcd74-a3d3-4894-830e-4b1d8ec9535d', '1685e0e5-c188-4bdb-8035-c70bf7b26c53', '「ずっと好きだよ」「ほんと?…」', 'RADWIMPS', 402000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '1685e0e5-c188-4bdb-8035-c70bf7b26c53' AND ar.mbid = '6f500293-7396-4903-b4fd-118127d06f9e'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT 'a4918bd4-870c-46b6-b134-4bdb3b5acf77', r.id, s.id, 11, 1, NULL, 402666
FROM public.releases r, public.songs s WHERE r.mbid = '845e7a50-3064-44cd-a319-5ee7403d9222' AND s.mbid = '1685e0e5-c188-4bdb-8035-c70bf7b26c53'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('d2382da9-6b88-4b6f-93e6-a49763694aeb', '04d21128-e8f7-469b-92cc-ab32e0fab9d8', '愛へ', 'RADWIMPS', 299000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '04d21128-e8f7-469b-92cc-ab32e0fab9d8' AND ar.mbid = '6f500293-7396-4903-b4fd-118127d06f9e'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '0e7b5be2-efaa-4700-9b88-d5a4dc3c21f8', r.id, s.id, 12, 1, NULL, 299600
FROM public.releases r, public.songs s WHERE r.mbid = '845e7a50-3064-44cd-a319-5ee7403d9222' AND s.mbid = '04d21128-e8f7-469b-92cc-ab32e0fab9d8'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('9d6ef3a6-e88b-40a7-b06c-39b45594946c', 'a9a4a670-4e3a-4e5c-b0d7-90bedd6966b5', 'あいラブユー', 'RADWIMPS', 181000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = 'a9a4a670-4e3a-4e5c-b0d7-90bedd6966b5' AND ar.mbid = '6f500293-7396-4903-b4fd-118127d06f9e'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT 'f0dc91e2-adab-48f5-b163-1e8792e7901a', r.id, s.id, 13, 1, NULL, 181733
FROM public.releases r, public.songs s WHERE r.mbid = '845e7a50-3064-44cd-a319-5ee7403d9222' AND s.mbid = 'a9a4a670-4e3a-4e5c-b0d7-90bedd6966b5'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.artists (id, mbid, name, sort_name, type, country, life_begin, life_end, disambiguation)
VALUES ('a3d9badb-cd55-461b-91f9-8703e1279011', 'f35bfbe2-d30e-402c-9ac1-fa5f90b72ec2', 'back number', 'back number', 'GROUP', 'JP', '2004', NULL, '')
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.albums (id, mbid, title, artist_credit, primary_type, first_release_date)
VALUES ('ba79221d-5ff0-4766-baa0-54b4cfefa41c', '79700a12-50e3-4544-ac12-ff58acc95c6e', 'あとのまつり', 'back number', 'Album', '2010-06-02')
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.album_artists (album_id, artist_id, position)
SELECT a.id, ar.id, 0 FROM public.albums a, public.artists ar
WHERE a.mbid = '79700a12-50e3-4544-ac12-ff58acc95c6e' AND ar.mbid = 'f35bfbe2-d30e-402c-9ac1-fa5f90b72ec2'
ON CONFLICT (album_id, artist_id) DO NOTHING;
INSERT INTO public.releases (id, mbid, album_id, title, status, country, release_date, release_date_precision, barcode, language, script)
SELECT '3e2905e6-5ab8-4f77-a0ba-41e3a0a3354a', '0e5535fc-714d-41a4-bc56-8e7856fd2748', albums.id, 'あとのまつり', 'Official', 'JP', '2010-06-02', 'day', NULL, 'jpn', 'Jpan'
FROM public.albums WHERE mbid = '79700a12-50e3-4544-ac12-ff58acc95c6e'
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('b0282762-1550-430d-b0a6-37b30f7c8a12', '9ad8602c-3dcb-4618-bb35-fffb3c0c9c51', 'stay with me', 'back number', 299626)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '9ad8602c-3dcb-4618-bb35-fffb3c0c9c51' AND ar.mbid = 'f35bfbe2-d30e-402c-9ac1-fa5f90b72ec2'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '9a67e4dc-d311-4523-8a59-6735d8a425e2', r.id, s.id, 1, 1, NULL, 299626
FROM public.releases r, public.songs s WHERE r.mbid = '0e5535fc-714d-41a4-bc56-8e7856fd2748' AND s.mbid = '9ad8602c-3dcb-4618-bb35-fffb3c0c9c51'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('917816d1-95de-45e9-bb82-476b1bc1dbf2', 'd24734f6-7e75-4504-9369-8d716e4ee0eb', 'あとのうた', 'back number', 305946)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = 'd24734f6-7e75-4504-9369-8d716e4ee0eb' AND ar.mbid = 'f35bfbe2-d30e-402c-9ac1-fa5f90b72ec2'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT 'bbfe5c27-4f33-4e8e-af86-d2195be95b7a', r.id, s.id, 2, 1, NULL, 305946
FROM public.releases r, public.songs s WHERE r.mbid = '0e5535fc-714d-41a4-bc56-8e7856fd2748' AND s.mbid = 'd24734f6-7e75-4504-9369-8d716e4ee0eb'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('c8a64519-8a8b-4430-b45e-f57d53727b28', '1073ce09-919f-46c0-b565-c53f25796abf', '浮ついた気持ち', 'back number', 285200)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '1073ce09-919f-46c0-b565-c53f25796abf' AND ar.mbid = 'f35bfbe2-d30e-402c-9ac1-fa5f90b72ec2'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '79d0af00-488c-4172-bb9d-dd7284834ce5', r.id, s.id, 3, 1, NULL, 285200
FROM public.releases r, public.songs s WHERE r.mbid = '0e5535fc-714d-41a4-bc56-8e7856fd2748' AND s.mbid = '1073ce09-919f-46c0-b565-c53f25796abf'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('51566206-3681-40d8-9a44-1f40fa363e09', '2171051a-177a-4ec3-9926-623d8497aaae', '風の強い日', 'back number', 315120)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '2171051a-177a-4ec3-9926-623d8497aaae' AND ar.mbid = 'f35bfbe2-d30e-402c-9ac1-fa5f90b72ec2'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT 'dbebb57a-ba39-4b29-86d2-4cbf69d43385', r.id, s.id, 4, 1, NULL, 315120
FROM public.releases r, public.songs s WHERE r.mbid = '0e5535fc-714d-41a4-bc56-8e7856fd2748' AND s.mbid = '2171051a-177a-4ec3-9926-623d8497aaae'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('39987e5b-8abb-4303-a30c-3f8f234c7334', '1b7ebdeb-811a-4393-ad06-b4b9c5dc6782', 'tender', 'back number', 210000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '1b7ebdeb-811a-4393-ad06-b4b9c5dc6782' AND ar.mbid = 'f35bfbe2-d30e-402c-9ac1-fa5f90b72ec2'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '746ce8e2-1b4f-4c71-9cdc-82e64a955a3d', r.id, s.id, 5, 1, NULL, 210000
FROM public.releases r, public.songs s WHERE r.mbid = '0e5535fc-714d-41a4-bc56-8e7856fd2748' AND s.mbid = '1b7ebdeb-811a-4393-ad06-b4b9c5dc6782'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('b8dc36b0-3db0-430e-af34-2ed33870c719', '2d41cea3-0610-41ee-8798-ff3c3f4d35c5', 'そのドレスちょっと待った', 'back number', 276466)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '2d41cea3-0610-41ee-8798-ff3c3f4d35c5' AND ar.mbid = 'f35bfbe2-d30e-402c-9ac1-fa5f90b72ec2'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT 'fdd00905-53ff-4a67-b771-f1f2403542d4', r.id, s.id, 6, 1, NULL, 276466
FROM public.releases r, public.songs s WHERE r.mbid = '0e5535fc-714d-41a4-bc56-8e7856fd2748' AND s.mbid = '2d41cea3-0610-41ee-8798-ff3c3f4d35c5'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('a17ba3cf-5c2a-46d1-89ad-382f29332974', '0b2881df-c574-4d16-a9db-117394e49d6c', 'おまえさん', 'back number', 290026)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '0b2881df-c574-4d16-a9db-117394e49d6c' AND ar.mbid = 'f35bfbe2-d30e-402c-9ac1-fa5f90b72ec2'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '0a3e053d-af5f-415a-8dfb-3b4e9ab231a9', r.id, s.id, 7, 1, NULL, 290026
FROM public.releases r, public.songs s WHERE r.mbid = '0e5535fc-714d-41a4-bc56-8e7856fd2748' AND s.mbid = '0b2881df-c574-4d16-a9db-117394e49d6c'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('07cd8c3b-8c8f-4d36-8422-1fb5dfc9c341', '11936b65-f29c-45fe-bdfd-e88a7987b69b', 'ハイスクールガール', 'back number', 315146)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '11936b65-f29c-45fe-bdfd-e88a7987b69b' AND ar.mbid = 'f35bfbe2-d30e-402c-9ac1-fa5f90b72ec2'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '6ac3f955-4d3b-4116-ab68-71ce7248d571', r.id, s.id, 8, 1, NULL, 315146
FROM public.releases r, public.songs s WHERE r.mbid = '0e5535fc-714d-41a4-bc56-8e7856fd2748' AND s.mbid = '11936b65-f29c-45fe-bdfd-e88a7987b69b'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('3d611082-28e9-408b-a351-11ece35fde2f', 'c16651b0-fd30-49c4-bdfe-59fe0c3db880', 'Life', 'back number', 181573)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = 'c16651b0-fd30-49c4-bdfe-59fe0c3db880' AND ar.mbid = 'f35bfbe2-d30e-402c-9ac1-fa5f90b72ec2'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '7a885152-45ff-4779-a638-790ec617a890', r.id, s.id, 9, 1, NULL, 181573
FROM public.releases r, public.songs s WHERE r.mbid = '0e5535fc-714d-41a4-bc56-8e7856fd2748' AND s.mbid = 'c16651b0-fd30-49c4-bdfe-59fe0c3db880'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('08c230b7-7c43-4e77-95b3-749c2c6d5192', '741b1e42-44a6-4712-9e42-2fa90a793374', 'fallman', 'back number', 228333)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '741b1e42-44a6-4712-9e42-2fa90a793374' AND ar.mbid = 'f35bfbe2-d30e-402c-9ac1-fa5f90b72ec2'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '69e0915e-be08-4060-bcc3-6b993a49b536', r.id, s.id, 10, 1, NULL, 228333
FROM public.releases r, public.songs s WHERE r.mbid = '0e5535fc-714d-41a4-bc56-8e7856fd2748' AND s.mbid = '741b1e42-44a6-4712-9e42-2fa90a793374'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('d58a2883-1f1d-4ae5-8f06-fec67d60384e', '19d41197-9b0f-4688-8529-affab85214e5', 'march', 'back number', 295280)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '19d41197-9b0f-4688-8529-affab85214e5' AND ar.mbid = 'f35bfbe2-d30e-402c-9ac1-fa5f90b72ec2'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT 'd40f8f25-1eed-424b-b408-e74f662bfe58', r.id, s.id, 11, 1, NULL, 295280
FROM public.releases r, public.songs s WHERE r.mbid = '0e5535fc-714d-41a4-bc56-8e7856fd2748' AND s.mbid = '19d41197-9b0f-4688-8529-affab85214e5'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('9002391e-dc3a-4a7e-826e-aa92411ed632', 'ef39bd26-ebf4-4f6d-b30b-6926c40e255b', 'いつか忘れてしまっても', 'back number', 333893)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = 'ef39bd26-ebf4-4f6d-b30b-6926c40e255b' AND ar.mbid = 'f35bfbe2-d30e-402c-9ac1-fa5f90b72ec2'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '708ac011-cc0b-4184-b3f4-eefe91aa5637', r.id, s.id, 12, 1, NULL, 333893
FROM public.releases r, public.songs s WHERE r.mbid = '0e5535fc-714d-41a4-bc56-8e7856fd2748' AND s.mbid = 'ef39bd26-ebf4-4f6d-b30b-6926c40e255b'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('a1cc60f5-e7ed-40a0-a7d8-6216ff0cad38', 'f9f99305-2c71-4c05-9e8e-203dfcc651c6', 'blank', 'back number', 70053)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = 'f9f99305-2c71-4c05-9e8e-203dfcc651c6' AND ar.mbid = 'f35bfbe2-d30e-402c-9ac1-fa5f90b72ec2'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '65baab43-df1d-40c3-b687-19cef82b3381', r.id, s.id, 13, 1, NULL, 70053
FROM public.releases r, public.songs s WHERE r.mbid = '0e5535fc-714d-41a4-bc56-8e7856fd2748' AND s.mbid = 'f9f99305-2c71-4c05-9e8e-203dfcc651c6'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('fb106f15-d412-4f79-8858-eec274d3ab5d', 'a8dd0bd7-c07b-4d27-a928-eca3a57cb560', 'Extra Track', 'back number', 474106)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = 'a8dd0bd7-c07b-4d27-a928-eca3a57cb560' AND ar.mbid = 'f35bfbe2-d30e-402c-9ac1-fa5f90b72ec2'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT 'eda49a53-b977-4329-b2ce-b2d52368f0d2', r.id, s.id, 14, 1, NULL, 474106
FROM public.releases r, public.songs s WHERE r.mbid = '0e5535fc-714d-41a4-bc56-8e7856fd2748' AND s.mbid = 'a8dd0bd7-c07b-4d27-a928-eca3a57cb560'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.artists (id, mbid, name, sort_name, type, country, life_begin, life_end, disambiguation)
VALUES ('21b7b710-f9e9-4c27-ae3f-07e474718578', 'c3a4aeca-8f02-4d22-b1ff-693434ab09a8', '藤井風', 'Fujii, Kaze', 'PERSON', 'JP', '1997-06-14', NULL, '')
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.albums (id, mbid, title, artist_credit, primary_type, first_release_date)
VALUES ('bf069b34-4771-4773-b02e-fd1df64969c4', '77b3bbd2-a07e-4580-b6c9-ac90c91078cc', 'HELP EVER HURT NEVER', '藤井風', 'Album', '2020-05-20')
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.album_artists (album_id, artist_id, position)
SELECT a.id, ar.id, 0 FROM public.albums a, public.artists ar
WHERE a.mbid = '77b3bbd2-a07e-4580-b6c9-ac90c91078cc' AND ar.mbid = 'c3a4aeca-8f02-4d22-b1ff-693434ab09a8'
ON CONFLICT (album_id, artist_id) DO NOTHING;
INSERT INTO public.releases (id, mbid, album_id, title, status, country, release_date, release_date_precision, barcode, language, script)
SELECT 'a6279636-e248-49e4-9560-db2889057678', '7c94b24c-cdf1-47c5-81cb-453025b4a17b', albums.id, 'HELP EVER HURT NEVER', 'Official', 'JP', '2020-05-20', 'day', '00602508898655', 'jpn', 'Jpan'
FROM public.albums WHERE mbid = '77b3bbd2-a07e-4580-b6c9-ac90c91078cc'
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('25ad8bcd-730f-47ab-9ca7-529f3fc6268d', 'd820812d-1bda-4177-bb68-5bd562ecfb60', '何なんw', '藤井風', 320640)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = 'd820812d-1bda-4177-bb68-5bd562ecfb60' AND ar.mbid = 'c3a4aeca-8f02-4d22-b1ff-693434ab09a8'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '565529f9-c573-46fa-85a9-2ab9649e55cc', r.id, s.id, 1, 1, NULL, 320640
FROM public.releases r, public.songs s WHERE r.mbid = '7c94b24c-cdf1-47c5-81cb-453025b4a17b' AND s.mbid = 'd820812d-1bda-4177-bb68-5bd562ecfb60'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('0b3ee9fc-50dc-43ee-96f4-35ef640605c2', 'bf658ff4-b1b7-43c6-9261-c07dbb687c38', 'もうええわ', '藤井風', 301933)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = 'bf658ff4-b1b7-43c6-9261-c07dbb687c38' AND ar.mbid = 'c3a4aeca-8f02-4d22-b1ff-693434ab09a8'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '1c2e9d4c-5c6e-44b2-9437-a1de3e2bd8bc', r.id, s.id, 2, 1, NULL, 301933
FROM public.releases r, public.songs s WHERE r.mbid = '7c94b24c-cdf1-47c5-81cb-453025b4a17b' AND s.mbid = 'bf658ff4-b1b7-43c6-9261-c07dbb687c38'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('ece34005-3b5b-4c22-a0f9-0b66ada98c2d', '9eba2bb3-7519-4a22-b46e-5c225ec2f401', '優しさ', '藤井風', 240080)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '9eba2bb3-7519-4a22-b46e-5c225ec2f401' AND ar.mbid = 'c3a4aeca-8f02-4d22-b1ff-693434ab09a8'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT 'eaedd503-a89f-4494-b164-3a7ad67a86be', r.id, s.id, 3, 1, NULL, 240080
FROM public.releases r, public.songs s WHERE r.mbid = '7c94b24c-cdf1-47c5-81cb-453025b4a17b' AND s.mbid = '9eba2bb3-7519-4a22-b46e-5c225ec2f401'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('7f3c8ff2-3451-4708-9ec8-541e77551039', '667da965-0609-44c8-91b4-571c4b87a81a', 'キリがないから', '藤井風', 217613)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '667da965-0609-44c8-91b4-571c4b87a81a' AND ar.mbid = 'c3a4aeca-8f02-4d22-b1ff-693434ab09a8'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '7deec476-9364-404e-abc9-1f25d1f73993', r.id, s.id, 4, 1, NULL, 217613
FROM public.releases r, public.songs s WHERE r.mbid = '7c94b24c-cdf1-47c5-81cb-453025b4a17b' AND s.mbid = '667da965-0609-44c8-91b4-571c4b87a81a'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('3b7b0374-a620-487c-825b-0eab502308e4', '355928bf-e5ed-4843-afe9-25a218016ffd', '罪の香り', '藤井風', 214200)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '355928bf-e5ed-4843-afe9-25a218016ffd' AND ar.mbid = 'c3a4aeca-8f02-4d22-b1ff-693434ab09a8'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT 'f97f5a35-13d1-4da1-a8e9-5b930377a7ed', r.id, s.id, 5, 1, NULL, 214200
FROM public.releases r, public.songs s WHERE r.mbid = '7c94b24c-cdf1-47c5-81cb-453025b4a17b' AND s.mbid = '355928bf-e5ed-4843-afe9-25a218016ffd'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('2ed0ee35-4ee8-4c5a-aa70-9784b04694cf', 'c3dd4e6d-68c1-407c-86e7-1750b43b601a', '調子のっちゃって', '藤井風', 282240)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = 'c3dd4e6d-68c1-407c-86e7-1750b43b601a' AND ar.mbid = 'c3a4aeca-8f02-4d22-b1ff-693434ab09a8'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT 'aa03b93f-b1c1-41f6-8dbc-6da9d6acb803', r.id, s.id, 6, 1, NULL, 282240
FROM public.releases r, public.songs s WHERE r.mbid = '7c94b24c-cdf1-47c5-81cb-453025b4a17b' AND s.mbid = 'c3dd4e6d-68c1-407c-86e7-1750b43b601a'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('c067ca3b-7e5b-4d70-a91b-b108ec145c48', 'd0754339-ee3d-41e0-a54e-c4c7f0a37885', '特にない', '藤井風', 205253)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = 'd0754339-ee3d-41e0-a54e-c4c7f0a37885' AND ar.mbid = 'c3a4aeca-8f02-4d22-b1ff-693434ab09a8'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '1262004d-e771-44a7-9d7f-f7c4c3a7eb4b', r.id, s.id, 7, 1, NULL, 205253
FROM public.releases r, public.songs s WHERE r.mbid = '7c94b24c-cdf1-47c5-81cb-453025b4a17b' AND s.mbid = 'd0754339-ee3d-41e0-a54e-c4c7f0a37885'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('a285688d-c81a-4e9f-9394-4a272f66da86', 'a97992ca-5d3d-4ce9-bab1-e631360c618b', '死ぬのがいいわ', '藤井風', 185573)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = 'a97992ca-5d3d-4ce9-bab1-e631360c618b' AND ar.mbid = 'c3a4aeca-8f02-4d22-b1ff-693434ab09a8'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT 'e6af13b5-20ff-4271-a225-a2c6308f0126', r.id, s.id, 8, 1, NULL, 185573
FROM public.releases r, public.songs s WHERE r.mbid = '7c94b24c-cdf1-47c5-81cb-453025b4a17b' AND s.mbid = 'a97992ca-5d3d-4ce9-bab1-e631360c618b'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('5fbbb562-36f9-4bf0-bfe4-cae69d935cad', 'd96668c1-0d05-4ff2-bbfa-a16710157292', '風よ', '藤井風', 284520)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = 'd96668c1-0d05-4ff2-bbfa-a16710157292' AND ar.mbid = 'c3a4aeca-8f02-4d22-b1ff-693434ab09a8'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '8acc3c5b-96a1-4c78-bf9d-3edd86e69335', r.id, s.id, 9, 1, NULL, 284520
FROM public.releases r, public.songs s WHERE r.mbid = '7c94b24c-cdf1-47c5-81cb-453025b4a17b' AND s.mbid = 'd96668c1-0d05-4ff2-bbfa-a16710157292'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('664c3476-64c0-4568-8cfa-b32dfeb620bc', '9c5da2f1-4fc8-4dcf-b25d-001e8afd8e03', 'さよならべいべ', '藤井風', 260533)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '9c5da2f1-4fc8-4dcf-b25d-001e8afd8e03' AND ar.mbid = 'c3a4aeca-8f02-4d22-b1ff-693434ab09a8'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '2f5f50de-6f2e-422b-a195-cc865b0e4af7', r.id, s.id, 10, 1, NULL, 260533
FROM public.releases r, public.songs s WHERE r.mbid = '7c94b24c-cdf1-47c5-81cb-453025b4a17b' AND s.mbid = '9c5da2f1-4fc8-4dcf-b25d-001e8afd8e03'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('425eaee9-3f12-4864-b642-3629fcdf92a8', '36304f25-263a-4d48-af5d-6c0623b7ed52', '帰ろう', '藤井風', 284480)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '36304f25-263a-4d48-af5d-6c0623b7ed52' AND ar.mbid = 'c3a4aeca-8f02-4d22-b1ff-693434ab09a8'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '4b074423-3805-4fef-858b-315a72f66392', r.id, s.id, 11, 1, NULL, 284480
FROM public.releases r, public.songs s WHERE r.mbid = '7c94b24c-cdf1-47c5-81cb-453025b4a17b' AND s.mbid = '36304f25-263a-4d48-af5d-6c0623b7ed52'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.artists (id, mbid, name, sort_name, type, country, life_begin, life_end, disambiguation)
VALUES ('20d9175c-bdd9-4a60-af97-d5ac4e22f003', 'e134b52f-2e9e-4734-9bc3-bea9648d1fa1', 'Ado', 'Ado', 'PERSON', 'JP', '2002-10-24', NULL, 'Japanese vocalist')
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.albums (id, mbid, title, artist_credit, primary_type, first_release_date)
VALUES ('ed681031-1048-481c-ba25-9bb50681e4a3', '000b747c-a83b-4b00-aa47-a839f6527a92', '狂言', 'Ado', 'Album', '2022-01-26')
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.album_artists (album_id, artist_id, position)
SELECT a.id, ar.id, 0 FROM public.albums a, public.artists ar
WHERE a.mbid = '000b747c-a83b-4b00-aa47-a839f6527a92' AND ar.mbid = 'e134b52f-2e9e-4734-9bc3-bea9648d1fa1'
ON CONFLICT (album_id, artist_id) DO NOTHING;
INSERT INTO public.releases (id, mbid, album_id, title, status, country, release_date, release_date_precision, barcode, language, script)
SELECT 'a189a4d7-27e3-432e-9d19-672d313d8ca1', '652831c6-04d2-4571-bdbe-4a6af088547a', albums.id, '狂言', 'Official', 'JP', '2022-01-26', 'day', '4988031471678', 'jpn', 'Jpan'
FROM public.albums WHERE mbid = '000b747c-a83b-4b00-aa47-a839f6527a92'
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('22f9468e-bec5-46ee-a53b-7f1ccf333926', '5e7a3676-dbdb-48f9-b916-ddee65d015c8', 'レディメイド', 'Ado', 244320)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '5e7a3676-dbdb-48f9-b916-ddee65d015c8' AND ar.mbid = 'e134b52f-2e9e-4734-9bc3-bea9648d1fa1'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '2aef3bb0-4c0f-45ce-90c8-7828db7089d2', r.id, s.id, 1, 1, NULL, 243186
FROM public.releases r, public.songs s WHERE r.mbid = '652831c6-04d2-4571-bdbe-4a6af088547a' AND s.mbid = '5e7a3676-dbdb-48f9-b916-ddee65d015c8'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('cf3847ab-3a5d-486b-bcf3-2a6c7d27ded3', 'edb6736a-50b3-4815-ba46-e453807f0835', '踊', 'Ado', 210347)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = 'edb6736a-50b3-4815-ba46-e453807f0835' AND ar.mbid = 'e134b52f-2e9e-4734-9bc3-bea9648d1fa1'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT 'a5f901b2-8800-4907-b22a-eb3f8905232b', r.id, s.id, 2, 1, NULL, 210346
FROM public.releases r, public.songs s WHERE r.mbid = '652831c6-04d2-4571-bdbe-4a6af088547a' AND s.mbid = 'edb6736a-50b3-4815-ba46-e453807f0835'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('48cbb7aa-e122-4fed-876f-62e262236242', '2b886020-c7e7-4da7-8c04-46d2daabd88e', 'ドメスティックでバイオレンス', 'Ado', 158480)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '2b886020-c7e7-4da7-8c04-46d2daabd88e' AND ar.mbid = 'e134b52f-2e9e-4734-9bc3-bea9648d1fa1'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '6f5f4774-6d52-4155-8dd8-69b4fb56bd9f', r.id, s.id, 3, 1, NULL, 158480
FROM public.releases r, public.songs s WHERE r.mbid = '652831c6-04d2-4571-bdbe-4a6af088547a' AND s.mbid = '2b886020-c7e7-4da7-8c04-46d2daabd88e'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('21ae26f6-fd9f-4ce4-90b8-8c7ec48add16', 'e85a1656-1d91-45d8-b028-2a98b33af9bd', 'FREEDOM', 'Ado', 186106)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = 'e85a1656-1d91-45d8-b028-2a98b33af9bd' AND ar.mbid = 'e134b52f-2e9e-4734-9bc3-bea9648d1fa1'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '077c7f45-ac7a-4ae0-8302-74a92065daf0', r.id, s.id, 4, 1, NULL, 186106
FROM public.releases r, public.songs s WHERE r.mbid = '652831c6-04d2-4571-bdbe-4a6af088547a' AND s.mbid = 'e85a1656-1d91-45d8-b028-2a98b33af9bd'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('e8084032-9aa6-4cf9-a7a6-954256f51358', '9eacbbd7-65ca-4154-ae76-9a1866ff6bcd', '花火', 'Ado', 212373)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '9eacbbd7-65ca-4154-ae76-9a1866ff6bcd' AND ar.mbid = 'e134b52f-2e9e-4734-9bc3-bea9648d1fa1'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '0de5b9b4-b9dc-4cd6-83db-cc9bec90e399', r.id, s.id, 5, 1, NULL, 212373
FROM public.releases r, public.songs s WHERE r.mbid = '652831c6-04d2-4571-bdbe-4a6af088547a' AND s.mbid = '9eacbbd7-65ca-4154-ae76-9a1866ff6bcd'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('b5588437-4849-423a-9167-69a7ce9dec12', 'ab7a42e2-c477-44e6-8cc7-056f8f8b10a5', '会いたくて', 'Ado', 294040)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = 'ab7a42e2-c477-44e6-8cc7-056f8f8b10a5' AND ar.mbid = 'e134b52f-2e9e-4734-9bc3-bea9648d1fa1'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT 'ca636993-3e93-42f0-aa65-5a5c93bbeb79', r.id, s.id, 6, 1, NULL, 295146
FROM public.releases r, public.songs s WHERE r.mbid = '652831c6-04d2-4571-bdbe-4a6af088547a' AND s.mbid = 'ab7a42e2-c477-44e6-8cc7-056f8f8b10a5'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('1edd8224-9373-45e6-93e7-56060e82542f', '058d99f7-2770-4a65-86c0-19f92f9fcea3', 'ラッキー・ブルート', 'Ado', 209600)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '058d99f7-2770-4a65-86c0-19f92f9fcea3' AND ar.mbid = 'e134b52f-2e9e-4734-9bc3-bea9648d1fa1'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT 'b4e4cbe0-16a2-4649-bd00-1e6ddedb23ca', r.id, s.id, 7, 1, NULL, 209613
FROM public.releases r, public.songs s WHERE r.mbid = '652831c6-04d2-4571-bdbe-4a6af088547a' AND s.mbid = '058d99f7-2770-4a65-86c0-19f92f9fcea3'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('594e1486-44e5-4ba4-a2f3-1f451277d184', 'd7e4646b-e831-4d85-a740-647ad9e1e37d', 'ギラギラ', 'Ado', 276066)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = 'd7e4646b-e831-4d85-a740-647ad9e1e37d' AND ar.mbid = 'e134b52f-2e9e-4734-9bc3-bea9648d1fa1'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT 'e1b1e91c-77f3-41d0-9ac5-ec274089724e', r.id, s.id, 8, 1, NULL, 276080
FROM public.releases r, public.songs s WHERE r.mbid = '652831c6-04d2-4571-bdbe-4a6af088547a' AND s.mbid = 'd7e4646b-e831-4d85-a740-647ad9e1e37d'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('bd1648ed-a6ce-4c31-8854-a3c9254531f2', '8dc671a4-3ee1-4f3e-9b3b-00d4a2e980ed', '阿修羅ちゃん', 'Ado', 196000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '8dc671a4-3ee1-4f3e-9b3b-00d4a2e980ed' AND ar.mbid = 'e134b52f-2e9e-4734-9bc3-bea9648d1fa1'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '51492490-7031-431f-ae2e-30076c06bc96', r.id, s.id, 9, 1, NULL, 195080
FROM public.releases r, public.songs s WHERE r.mbid = '652831c6-04d2-4571-bdbe-4a6af088547a' AND s.mbid = '8dc671a4-3ee1-4f3e-9b3b-00d4a2e980ed'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('31780b68-a7f6-48e0-9261-9f1ac11fbb4c', 'ab14c6ef-be4f-440a-9c4a-fd1a067c2c52', '心という名の不可解', 'Ado', 269893)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = 'ab14c6ef-be4f-440a-9c4a-fd1a067c2c52' AND ar.mbid = 'e134b52f-2e9e-4734-9bc3-bea9648d1fa1'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '16dc64b7-71df-4e30-a388-11bbf1961dd1', r.id, s.id, 10, 1, NULL, 269893
FROM public.releases r, public.songs s WHERE r.mbid = '652831c6-04d2-4571-bdbe-4a6af088547a' AND s.mbid = 'ab14c6ef-be4f-440a-9c4a-fd1a067c2c52'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('4d47ba31-3ea0-4e55-b986-62e320b10f69', '5d992918-e00d-420a-85cd-04dd6e262a00', 'うっせぇわ', 'Ado', 205520)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '5d992918-e00d-420a-85cd-04dd6e262a00' AND ar.mbid = 'e134b52f-2e9e-4734-9bc3-bea9648d1fa1'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT 'c3441297-3b78-4bec-9e4b-c252341eb055', r.id, s.id, 11, 1, NULL, 206893
FROM public.releases r, public.songs s WHERE r.mbid = '652831c6-04d2-4571-bdbe-4a6af088547a' AND s.mbid = '5d992918-e00d-420a-85cd-04dd6e262a00'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('7a1141b8-9326-4121-a5a8-206564b8291a', '079df479-7a6a-4e6b-b3b2-df911006e670', 'マザーランド', 'Ado', 261105)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '079df479-7a6a-4e6b-b3b2-df911006e670' AND ar.mbid = 'e134b52f-2e9e-4734-9bc3-bea9648d1fa1'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT 'd5629ccd-1842-48f5-a72c-49060abd4a81', r.id, s.id, 12, 1, NULL, 260066
FROM public.releases r, public.songs s WHERE r.mbid = '652831c6-04d2-4571-bdbe-4a6af088547a' AND s.mbid = '079df479-7a6a-4e6b-b3b2-df911006e670'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('dd18fb63-1b93-49a6-b773-04a50f44600d', '0394cf8e-14a4-4eb2-9816-8ddef32ed94d', '過学習', 'Ado', 215866)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '0394cf8e-14a4-4eb2-9816-8ddef32ed94d' AND ar.mbid = 'e134b52f-2e9e-4734-9bc3-bea9648d1fa1'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT 'd3bf2cf1-870c-4f7e-b450-920c0fc1237e', r.id, s.id, 13, 1, NULL, 215853
FROM public.releases r, public.songs s WHERE r.mbid = '652831c6-04d2-4571-bdbe-4a6af088547a' AND s.mbid = '0394cf8e-14a4-4eb2-9816-8ddef32ed94d'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('14a45fb3-8b35-4333-bf19-ec77a0286501', '7334cbd8-5104-4a04-b931-cce1889f920f', '夜のピエロ', 'Ado', 200053)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '7334cbd8-5104-4a04-b931-cce1889f920f' AND ar.mbid = 'e134b52f-2e9e-4734-9bc3-bea9648d1fa1'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '3aa4f92c-f681-42b5-9fbe-44158627c9ef', r.id, s.id, 14, 1, NULL, 200733
FROM public.releases r, public.songs s WHERE r.mbid = '652831c6-04d2-4571-bdbe-4a6af088547a' AND s.mbid = '7334cbd8-5104-4a04-b931-cce1889f920f'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('7218c87c-4043-4ea1-bc13-65a925458b57', 'a5fe5a8c-60b7-426a-9a5d-cb8cb929060a', 'うっせぇわ', 'Ado', 204000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = 'a5fe5a8c-60b7-426a-9a5d-cb8cb929060a' AND ar.mbid = 'e134b52f-2e9e-4734-9bc3-bea9648d1fa1'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '7ae37057-dec6-4257-b246-aaebbd07201d', r.id, s.id, 1, 2, '「うっせぇわ」(Movie:WOOMA)', 204000
FROM public.releases r, public.songs s WHERE r.mbid = '652831c6-04d2-4571-bdbe-4a6af088547a' AND s.mbid = 'a5fe5a8c-60b7-426a-9a5d-cb8cb929060a'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('5ea8b8ed-8af1-4daa-9c5e-b0c488877fb9', 'b48df14d-ae6d-4dfa-9cc3-f6f542cd1dad', 'レディメイド', 'Ado', 243000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = 'b48df14d-ae6d-4dfa-9cc3-f6f542cd1dad' AND ar.mbid = 'e134b52f-2e9e-4734-9bc3-bea9648d1fa1'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '451b0764-615d-43af-a969-1db4111619ad', r.id, s.id, 2, 2, '「レディメイド」(Movie:ヤスタツ)', 243000
FROM public.releases r, public.songs s WHERE r.mbid = '652831c6-04d2-4571-bdbe-4a6af088547a' AND s.mbid = 'b48df14d-ae6d-4dfa-9cc3-f6f542cd1dad'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('4e37fa25-f2b4-495a-bf42-e46b5757a57d', 'de3305d0-43ee-4ad9-b31e-67615d48d73a', 'ギラギラ', 'Ado', 276000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = 'de3305d0-43ee-4ad9-b31e-67615d48d73a' AND ar.mbid = 'e134b52f-2e9e-4734-9bc3-bea9648d1fa1'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '059d0c61-bc70-44bd-a36d-12ed69eb19cf', r.id, s.id, 3, 2, '「ギラギラ」(Movie:沼田ゾンビ)', 276000
FROM public.releases r, public.songs s WHERE r.mbid = '652831c6-04d2-4571-bdbe-4a6af088547a' AND s.mbid = 'de3305d0-43ee-4ad9-b31e-67615d48d73a'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('39734173-1929-4704-afa0-005459c2e68a', 'ea155ea1-97e6-47c5-9b6a-fd782756b46d', '踊', 'Ado', 210000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = 'ea155ea1-97e6-47c5-9b6a-fd782756b46d' AND ar.mbid = 'e134b52f-2e9e-4734-9bc3-bea9648d1fa1'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '37dcb053-b3d4-4533-b1e7-b3084914f67b', r.id, s.id, 4, 2, '「踊」(Illust:かゆか、Movie:藍瀬まなみ)', 210000
FROM public.releases r, public.songs s WHERE r.mbid = '652831c6-04d2-4571-bdbe-4a6af088547a' AND s.mbid = 'ea155ea1-97e6-47c5-9b6a-fd782756b46d'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('db039843-54cc-41de-a525-a34120d841cc', '1fb433ec-a3f3-40a6-91bf-b1e467e86a19', '夜のピエロ', 'Ado', 201000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '1fb433ec-a3f3-40a6-91bf-b1e467e86a19' AND ar.mbid = 'e134b52f-2e9e-4734-9bc3-bea9648d1fa1'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '80444d62-03a6-4410-842e-c3df16854721', r.id, s.id, 5, 2, '「夜のピエロ」(Illust:ケイゴイノウエ、Movie:神宮司)', 201000
FROM public.releases r, public.songs s WHERE r.mbid = '652831c6-04d2-4571-bdbe-4a6af088547a' AND s.mbid = '1fb433ec-a3f3-40a6-91bf-b1e467e86a19'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('25bf2336-1376-469e-93eb-959df13d68c4', 'f947884b-5d84-47c2-827f-3396e0f590ad', '会いたくて', 'Ado', 288000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = 'f947884b-5d84-47c2-827f-3396e0f590ad' AND ar.mbid = 'e134b52f-2e9e-4734-9bc3-bea9648d1fa1'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT 'efc4f9c0-ab71-4804-b62f-1db784ff207f', r.id, s.id, 6, 2, '「会いたくて」(Illust:チェリ子、Movie Director:イノウエマナ)', 288000
FROM public.releases r, public.songs s WHERE r.mbid = '652831c6-04d2-4571-bdbe-4a6af088547a' AND s.mbid = 'f947884b-5d84-47c2-827f-3396e0f590ad'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('eb5dc6ea-7d73-411e-88a1-910050974708', '6433d8b3-102f-4e10-9ccc-1a1bd8d4b16f', '阿修羅ちゃん', 'Ado', 211000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '6433d8b3-102f-4e10-9ccc-1a1bd8d4b16f' AND ar.mbid = 'e134b52f-2e9e-4734-9bc3-bea9648d1fa1'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '82707ee5-7126-4e50-88eb-9d4308d08425', r.id, s.id, 7, 2, '「阿修羅ちゃん」(Illust:寺田てら、Movie:MONO-Devoid)', 211000
FROM public.releases r, public.songs s WHERE r.mbid = '652831c6-04d2-4571-bdbe-4a6af088547a' AND s.mbid = '6433d8b3-102f-4e10-9ccc-1a1bd8d4b16f'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.artists (id, mbid, name, sort_name, type, country, life_begin, life_end, disambiguation)
VALUES ('743db912-0a46-452b-8f7f-dc969b85751f', '14d2a235-30e2-489f-b490-f9dc7d2c0861', 'ずっと真夜中でいいのに。', 'Zutto Mayonaka de Iinoni.', 'GROUP', 'JP', '2018', NULL, 'Japanese pop band')
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.albums (id, mbid, title, artist_credit, primary_type, first_release_date)
VALUES ('ea3fa42a-3276-4182-885a-8e94f40fe024', 'd2d39dbf-c69e-4c87-b005-b77dde88f1f4', '潜潜話', 'ずっと真夜中でいいのに。', 'Album', '2019-10-29')
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.album_artists (album_id, artist_id, position)
SELECT a.id, ar.id, 0 FROM public.albums a, public.artists ar
WHERE a.mbid = 'd2d39dbf-c69e-4c87-b005-b77dde88f1f4' AND ar.mbid = '14d2a235-30e2-489f-b490-f9dc7d2c0861'
ON CONFLICT (album_id, artist_id) DO NOTHING;
INSERT INTO public.releases (id, mbid, album_id, title, status, country, release_date, release_date_precision, barcode, language, script)
SELECT 'a60ef70d-93c5-4536-b4ec-b7665107a266', 'e19070dd-09f6-4b15-b93a-a77bcd265595', albums.id, '潜潜話', 'Official', 'JP', '2019-10-30', 'day', '4988031350942', 'jpn', 'Jpan'
FROM public.albums WHERE mbid = 'd2d39dbf-c69e-4c87-b005-b77dde88f1f4'
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('fefdb594-982c-4301-9004-98fe949251b0', '1c598bd9-3c3b-4bec-94c4-fb6c61b4d2fe', '脳裏上のクラッカー', 'ずっと真夜中でいいのに。', 270000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '1c598bd9-3c3b-4bec-94c4-fb6c61b4d2fe' AND ar.mbid = '14d2a235-30e2-489f-b490-f9dc7d2c0861'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT 'd7c87fd7-1bb5-4e47-8ec2-8e2e296c716b', r.id, s.id, 1, 1, NULL, 270000
FROM public.releases r, public.songs s WHERE r.mbid = 'e19070dd-09f6-4b15-b93a-a77bcd265595' AND s.mbid = '1c598bd9-3c3b-4bec-94c4-fb6c61b4d2fe'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('b8fa6b36-f638-487c-9cc5-3e93256d81bf', 'a7fdf939-161c-4136-ae9f-e2231bd00587', '勘冴えて悔しいわ', 'ずっと真夜中でいいのに。', 237000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = 'a7fdf939-161c-4136-ae9f-e2231bd00587' AND ar.mbid = '14d2a235-30e2-489f-b490-f9dc7d2c0861'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '93a4a536-f4cf-4cd6-9a96-b0512ce4e1f5', r.id, s.id, 2, 1, NULL, 236960
FROM public.releases r, public.songs s WHERE r.mbid = 'e19070dd-09f6-4b15-b93a-a77bcd265595' AND s.mbid = 'a7fdf939-161c-4136-ae9f-e2231bd00587'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('b3c97970-1e91-4e53-a439-338ae2c37c47', '15c8db70-9b11-45f8-a369-6430385d6877', '居眠り遠征隊', 'ずっと真夜中でいいのに。', 218333)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '15c8db70-9b11-45f8-a369-6430385d6877' AND ar.mbid = '14d2a235-30e2-489f-b490-f9dc7d2c0861'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT 'c6925f05-66c9-472b-93c1-5dd22641979f', r.id, s.id, 3, 1, NULL, 218333
FROM public.releases r, public.songs s WHERE r.mbid = 'e19070dd-09f6-4b15-b93a-a77bcd265595' AND s.mbid = '15c8db70-9b11-45f8-a369-6430385d6877'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('d5bf4133-5c09-4ab6-8369-39ca30c22277', 'e33f99a9-e6e5-4fb9-b6bd-a97fb03950e2', 'ハゼ馳せる果てるまで', 'ずっと真夜中でいいのに。', 244706)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = 'e33f99a9-e6e5-4fb9-b6bd-a97fb03950e2' AND ar.mbid = '14d2a235-30e2-489f-b490-f9dc7d2c0861'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '7f2436df-5ac4-4b7d-a0ca-155f673e63b0', r.id, s.id, 4, 1, NULL, 244706
FROM public.releases r, public.songs s WHERE r.mbid = 'e19070dd-09f6-4b15-b93a-a77bcd265595' AND s.mbid = 'e33f99a9-e6e5-4fb9-b6bd-a97fb03950e2'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('51184aa2-23f2-4f8b-beae-eed90de9237b', 'bcad4052-f2a1-4468-b478-4c5fcb9efdd0', '蹴っ飛ばした毛布', 'ずっと真夜中でいいのに。', 266426)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = 'bcad4052-f2a1-4468-b478-4c5fcb9efdd0' AND ar.mbid = '14d2a235-30e2-489f-b490-f9dc7d2c0861'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT 'fb8bd91c-e529-4ae9-b3fd-6b392eba2962', r.id, s.id, 5, 1, NULL, 266426
FROM public.releases r, public.songs s WHERE r.mbid = 'e19070dd-09f6-4b15-b93a-a77bcd265595' AND s.mbid = 'bcad4052-f2a1-4468-b478-4c5fcb9efdd0'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('0cb3af6a-6262-4485-979f-e4a03350dafa', '2f26f12f-a800-490c-bb7c-45752ef0289f', 'Dear Mr「F」', 'ずっと真夜中でいいのに。', 326266)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '2f26f12f-a800-490c-bb7c-45752ef0289f' AND ar.mbid = '14d2a235-30e2-489f-b490-f9dc7d2c0861'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '37ed74a5-6eb5-4e7c-abf2-402bc9d11d6e', r.id, s.id, 6, 1, 'Dear Mr 「F」', 326266
FROM public.releases r, public.songs s WHERE r.mbid = 'e19070dd-09f6-4b15-b93a-a77bcd265595' AND s.mbid = '2f26f12f-a800-490c-bb7c-45752ef0289f'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('4b18a370-0f0a-4eec-a57a-f7f1ff42484d', '2de69e2f-f43d-40ab-b080-d0cb3e5c9af4', 'こんなこと騒動', 'ずっと真夜中でいいのに。', 297866)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '2de69e2f-f43d-40ab-b080-d0cb3e5c9af4' AND ar.mbid = '14d2a235-30e2-489f-b490-f9dc7d2c0861'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '3ba61e4a-43ba-47fe-afa1-868c6d077be3', r.id, s.id, 7, 1, NULL, 297866
FROM public.releases r, public.songs s WHERE r.mbid = 'e19070dd-09f6-4b15-b93a-a77bcd265595' AND s.mbid = '2de69e2f-f43d-40ab-b080-d0cb3e5c9af4'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('709a35f8-ec23-4b00-8f41-06ae783e9d6a', '77b9cd2a-ad12-43f3-ae16-29fef840998e', '眩しいDNAだけ', 'ずっと真夜中でいいのに。', 227666)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '77b9cd2a-ad12-43f3-ae16-29fef840998e' AND ar.mbid = '14d2a235-30e2-489f-b490-f9dc7d2c0861'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT 'c91009f0-1b3e-49f9-9357-4b1652c6371b', r.id, s.id, 8, 1, NULL, 227666
FROM public.releases r, public.songs s WHERE r.mbid = 'e19070dd-09f6-4b15-b93a-a77bcd265595' AND s.mbid = '77b9cd2a-ad12-43f3-ae16-29fef840998e'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('8e82079b-719c-479e-88d2-b0f9929a1e60', '20aba62e-9f13-45b3-820d-b92391646855', 'ヒューマノイド', 'ずっと真夜中でいいのに。', 259416)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '20aba62e-9f13-45b3-820d-b92391646855' AND ar.mbid = '14d2a235-30e2-489f-b490-f9dc7d2c0861'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '6738f2d6-6e09-4e2a-8c00-0d3a832bac3f', r.id, s.id, 9, 1, NULL, 259866
FROM public.releases r, public.songs s WHERE r.mbid = 'e19070dd-09f6-4b15-b93a-a77bcd265595' AND s.mbid = '20aba62e-9f13-45b3-820d-b92391646855'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('7964439c-80aa-469f-9cba-f6b50a09feca', '50b0a04d-8c3c-45d8-8013-bc3422310995', 'グラスとラムレーズン', 'ずっと真夜中でいいのに。', 234093)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '50b0a04d-8c3c-45d8-8013-bc3422310995' AND ar.mbid = '14d2a235-30e2-489f-b490-f9dc7d2c0861'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '0961a044-da52-4711-87c1-459423126b24', r.id, s.id, 10, 1, NULL, 234093
FROM public.releases r, public.songs s WHERE r.mbid = 'e19070dd-09f6-4b15-b93a-a77bcd265595' AND s.mbid = '50b0a04d-8c3c-45d8-8013-bc3422310995'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('d14cbb27-55d4-422e-8665-a347c8a8a871', 'c28a100b-6f5e-4d66-ae78-2234dbea0230', '正義', 'ずっと真夜中でいいのに。', 271000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = 'c28a100b-6f5e-4d66-ae78-2234dbea0230' AND ar.mbid = '14d2a235-30e2-489f-b490-f9dc7d2c0861'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT 'c61b2995-c901-44e5-b5af-5ad3402c9c6c', r.id, s.id, 11, 1, NULL, 271573
FROM public.releases r, public.songs s WHERE r.mbid = 'e19070dd-09f6-4b15-b93a-a77bcd265595' AND s.mbid = 'c28a100b-6f5e-4d66-ae78-2234dbea0230'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('31880988-b595-49bd-a9e8-2edb5b6456ce', '5b70f171-8657-4883-9292-5afd7b13fd31', '優しくLAST SMILE', 'ずっと真夜中でいいのに。', 245773)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '5b70f171-8657-4883-9292-5afd7b13fd31' AND ar.mbid = '14d2a235-30e2-489f-b490-f9dc7d2c0861'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '2d7b95d4-0340-46c5-994f-660e0f633789', r.id, s.id, 12, 1, NULL, 245773
FROM public.releases r, public.songs s WHERE r.mbid = 'e19070dd-09f6-4b15-b93a-a77bcd265595' AND s.mbid = '5b70f171-8657-4883-9292-5afd7b13fd31'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('16a78898-168a-401f-b14a-2000664e546b', '7911ec46-1d48-44d8-9a79-81d23cf9291e', '秒針を噛む', 'ずっと真夜中でいいのに。', 259000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '7911ec46-1d48-44d8-9a79-81d23cf9291e' AND ar.mbid = '14d2a235-30e2-489f-b490-f9dc7d2c0861'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '0e4c370d-d9d4-4c4f-adcb-8770d338e39f', r.id, s.id, 13, 1, NULL, 260800
FROM public.releases r, public.songs s WHERE r.mbid = 'e19070dd-09f6-4b15-b93a-a77bcd265595' AND s.mbid = '7911ec46-1d48-44d8-9a79-81d23cf9291e'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('060ebdaf-4be3-4281-a385-6a78885c55f2', 'dfa1d6ed-fcdd-46ab-a560-3add1e6c98be', '脳裏上のクラッカー (Instrumental)', 'ずっと真夜中でいいのに。', 270000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = 'dfa1d6ed-fcdd-46ab-a560-3add1e6c98be' AND ar.mbid = '14d2a235-30e2-489f-b490-f9dc7d2c0861'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '5ae92c31-58cd-42d7-ab06-7eece170428a', r.id, s.id, 1, 2, NULL, 270000
FROM public.releases r, public.songs s WHERE r.mbid = 'e19070dd-09f6-4b15-b93a-a77bcd265595' AND s.mbid = 'dfa1d6ed-fcdd-46ab-a560-3add1e6c98be'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('a292cafd-538f-411c-a12d-1ab3c3c115a6', '644353a9-f78d-4f2e-a21a-ee262a583350', '勘冴えて悔しいわ (Instrumental)', 'ずっと真夜中でいいのに。', 238333)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '644353a9-f78d-4f2e-a21a-ee262a583350' AND ar.mbid = '14d2a235-30e2-489f-b490-f9dc7d2c0861'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '35d89c59-ac79-4ad2-9d49-b4ea6a38faba', r.id, s.id, 2, 2, NULL, 236000
FROM public.releases r, public.songs s WHERE r.mbid = 'e19070dd-09f6-4b15-b93a-a77bcd265595' AND s.mbid = '644353a9-f78d-4f2e-a21a-ee262a583350'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('fdae01a3-b7e9-4f21-893b-388d93d736ec', '8c7a48a6-d491-4776-8566-88d1650c082c', '居眠り遠征隊 (Instrumental)', 'ずっと真夜中でいいのに。', 218000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '8c7a48a6-d491-4776-8566-88d1650c082c' AND ar.mbid = '14d2a235-30e2-489f-b490-f9dc7d2c0861'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '8dd0d01e-10c8-4f5e-8401-571504e2284a', r.id, s.id, 3, 2, NULL, 218000
FROM public.releases r, public.songs s WHERE r.mbid = 'e19070dd-09f6-4b15-b93a-a77bcd265595' AND s.mbid = '8c7a48a6-d491-4776-8566-88d1650c082c'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('42754e6c-9447-4a87-a357-5269221d88a2', '58c44d56-136e-432e-a4e5-65ee81d4f783', 'ハゼ馳せる果てるまで (Instrumental)', 'ずっと真夜中でいいのに。', 244000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '58c44d56-136e-432e-a4e5-65ee81d4f783' AND ar.mbid = '14d2a235-30e2-489f-b490-f9dc7d2c0861'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '2adab672-e7e7-4703-b854-f8d48d5e8fab', r.id, s.id, 4, 2, NULL, 244000
FROM public.releases r, public.songs s WHERE r.mbid = 'e19070dd-09f6-4b15-b93a-a77bcd265595' AND s.mbid = '58c44d56-136e-432e-a4e5-65ee81d4f783'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('e10a3eaf-da16-4350-991e-0da2561e4dbf', '6beb041b-665a-429e-8d5f-4a15d53fb85e', '蹴っ飛ばした毛布 (Instrumental)', 'ずっと真夜中でいいのに。', 266000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '6beb041b-665a-429e-8d5f-4a15d53fb85e' AND ar.mbid = '14d2a235-30e2-489f-b490-f9dc7d2c0861'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '0996ff44-6f1b-447e-9ad7-7a0b3fb9fad3', r.id, s.id, 5, 2, NULL, 266000
FROM public.releases r, public.songs s WHERE r.mbid = 'e19070dd-09f6-4b15-b93a-a77bcd265595' AND s.mbid = '6beb041b-665a-429e-8d5f-4a15d53fb85e'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('440038e2-cb1f-42b3-98d5-047075651582', '36a36ccd-1352-48e1-974a-bfea6cf057ae', 'Dear Mr「F」 (Instrumental)', 'ずっと真夜中でいいのに。', 326000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '36a36ccd-1352-48e1-974a-bfea6cf057ae' AND ar.mbid = '14d2a235-30e2-489f-b490-f9dc7d2c0861'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '662cea87-dc76-4475-814f-51c843797d14', r.id, s.id, 6, 2, 'Dear Mr 「F」 (Instrumental)', 326000
FROM public.releases r, public.songs s WHERE r.mbid = 'e19070dd-09f6-4b15-b93a-a77bcd265595' AND s.mbid = '36a36ccd-1352-48e1-974a-bfea6cf057ae'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('76217e04-de9b-4302-a504-6742bad9ed14', '21c5aba7-bf9d-4118-8382-a160cc59d658', 'こんなこと騒動 (Instrumental)', 'ずっと真夜中でいいのに。', 297000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = '21c5aba7-bf9d-4118-8382-a160cc59d658' AND ar.mbid = '14d2a235-30e2-489f-b490-f9dc7d2c0861'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT 'd347b846-d554-40fb-9474-a3849bbda5a6', r.id, s.id, 7, 2, NULL, 297000
FROM public.releases r, public.songs s WHERE r.mbid = 'e19070dd-09f6-4b15-b93a-a77bcd265595' AND s.mbid = '21c5aba7-bf9d-4118-8382-a160cc59d658'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('596849b5-0149-45f0-b5c2-32ccd12bcca9', 'b352dbaa-099c-4945-9b4c-a5e5b8e2904b', '眩しいDNAだけ (Instrumental)', 'ずっと真夜中でいいのに。', 229693)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = 'b352dbaa-099c-4945-9b4c-a5e5b8e2904b' AND ar.mbid = '14d2a235-30e2-489f-b490-f9dc7d2c0861'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT 'e6cbc449-df6e-494c-8ef6-5b1bb6aa1ed5', r.id, s.id, 8, 2, NULL, 227000
FROM public.releases r, public.songs s WHERE r.mbid = 'e19070dd-09f6-4b15-b93a-a77bcd265595' AND s.mbid = 'b352dbaa-099c-4945-9b4c-a5e5b8e2904b'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('2a69178c-a44b-481a-8414-dd39dd79d14d', 'f973dfc2-2a31-48e3-a7df-99fbb19f0343', 'ヒューマノイド (Instrumental)', 'ずっと真夜中でいいのに。', 259000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = 'f973dfc2-2a31-48e3-a7df-99fbb19f0343' AND ar.mbid = '14d2a235-30e2-489f-b490-f9dc7d2c0861'
ON CONFLICT (song_id, artist_id) DO NOTHING;
INSERT INTO public.tracks (id, release_id, song_id, position, disc_number, title, length_ms)
SELECT '21f0b3d8-e3e7-442d-8a7b-fec840744557', r.id, s.id, 9, 2, NULL, 259000
FROM public.releases r, public.songs s WHERE r.mbid = 'e19070dd-09f6-4b15-b93a-a77bcd265595' AND s.mbid = 'f973dfc2-2a31-48e3-a7df-99fbb19f0343'
ON CONFLICT (release_id, disc_number, position) DO NOTHING;
INSERT INTO public.songs (id, mbid, title, artist_credit, length_ms)
VALUES ('11c591d7-b0c9-4d08-9753-86dc61dc5779', 'e5a07684-d5de-4850-86d8-eb36b334be7b', 'グラスとラムレーズン (Instrumental)', 'ずっと真夜中でいいのに。', 234000)
ON CONFLICT (mbid) DO NOTHING;
INSERT INTO public.song_artists (song_id, artist_id, role, position)
SELECT s.id, ar.id, 'primary', 0 FROM public.songs s, public.artists ar
WHERE s.mbid = 'e5a07684-d5de-4850-86d8-eb36b334be7b' AND ar.mbid = '14d2a235-30e2-489f-b490-f9dc7d2c0861'
ON CONFLICT (song_id, artist_id) DO NOTHING;
