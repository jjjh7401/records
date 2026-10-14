-- CAA 앨범 커버 에셋 시드 (NEEDS_REVIEW). 멱등 아님: 1회만 실행.
-- 21건

INSERT INTO public.media_assets (id, entity_type, entity_id, asset_type, source_type, source_url, rights_type, status)
SELECT 'b290e1af-7863-4d62-83e8-4e2db674714f', 'ALBUM', albums.id, 'ALBUM_COVER', 'COVER_ART_ARCHIVE', 'https://coverartarchive.org/release-group/b5b77c44-1b13-4dca-8e8a-b9bac5f174a5/front', 'QUOTATION_ONLY', 'NEEDS_REVIEW'
FROM public.albums WHERE mbid = 'b5b77c44-1b13-4dca-8e8a-b9bac5f174a5'
AND NOT EXISTS (SELECT 1 FROM public.media_assets ma JOIN public.albums a2 ON ma.entity_id = a2.id
  WHERE ma.entity_type = 'ALBUM' AND a2.mbid = 'b5b77c44-1b13-4dca-8e8a-b9bac5f174a5' AND ma.source_url = 'https://coverartarchive.org/release-group/b5b77c44-1b13-4dca-8e8a-b9bac5f174a5/front');
INSERT INTO public.media_assets (id, entity_type, entity_id, asset_type, source_type, source_url, rights_type, status)
SELECT '5a4140ee-dd3d-49b7-9f9c-2909d5c8e7d9', 'ALBUM', albums.id, 'ALBUM_COVER', 'COVER_ART_ARCHIVE', 'https://coverartarchive.org/release-group/e1b66382-821e-4b81-a900-4d001dc45c92/front', 'QUOTATION_ONLY', 'NEEDS_REVIEW'
FROM public.albums WHERE mbid = 'e1b66382-821e-4b81-a900-4d001dc45c92'
AND NOT EXISTS (SELECT 1 FROM public.media_assets ma JOIN public.albums a2 ON ma.entity_id = a2.id
  WHERE ma.entity_type = 'ALBUM' AND a2.mbid = 'e1b66382-821e-4b81-a900-4d001dc45c92' AND ma.source_url = 'https://coverartarchive.org/release-group/e1b66382-821e-4b81-a900-4d001dc45c92/front');
INSERT INTO public.media_assets (id, entity_type, entity_id, asset_type, source_type, source_url, rights_type, status)
SELECT 'd5215bd2-0256-4814-9f2c-cd97d61feb98', 'ALBUM', albums.id, 'ALBUM_COVER', 'COVER_ART_ARCHIVE', 'https://coverartarchive.org/release-group/fa8b4100-c899-4738-af3c-35f42d1f6f6a/front', 'QUOTATION_ONLY', 'NEEDS_REVIEW'
FROM public.albums WHERE mbid = 'fa8b4100-c899-4738-af3c-35f42d1f6f6a'
AND NOT EXISTS (SELECT 1 FROM public.media_assets ma JOIN public.albums a2 ON ma.entity_id = a2.id
  WHERE ma.entity_type = 'ALBUM' AND a2.mbid = 'fa8b4100-c899-4738-af3c-35f42d1f6f6a' AND ma.source_url = 'https://coverartarchive.org/release-group/fa8b4100-c899-4738-af3c-35f42d1f6f6a/front');
INSERT INTO public.media_assets (id, entity_type, entity_id, asset_type, source_type, source_url, rights_type, status)
SELECT 'bab7ee26-705d-4859-a059-d54be530dd7e', 'ALBUM', albums.id, 'ALBUM_COVER', 'COVER_ART_ARCHIVE', 'https://coverartarchive.org/release-group/25d11ecf-30c1-447a-9ec5-cddecd112519/front', 'QUOTATION_ONLY', 'NEEDS_REVIEW'
FROM public.albums WHERE mbid = '25d11ecf-30c1-447a-9ec5-cddecd112519'
AND NOT EXISTS (SELECT 1 FROM public.media_assets ma JOIN public.albums a2 ON ma.entity_id = a2.id
  WHERE ma.entity_type = 'ALBUM' AND a2.mbid = '25d11ecf-30c1-447a-9ec5-cddecd112519' AND ma.source_url = 'https://coverartarchive.org/release-group/25d11ecf-30c1-447a-9ec5-cddecd112519/front');
INSERT INTO public.media_assets (id, entity_type, entity_id, asset_type, source_type, source_url, rights_type, status)
SELECT 'b8c51a4f-4d63-408e-8f25-bb57116bfcf9', 'ALBUM', albums.id, 'ALBUM_COVER', 'COVER_ART_ARCHIVE', 'https://coverartarchive.org/release-group/a166ef97-5540-3faa-b556-c6ecf812faa4/front', 'QUOTATION_ONLY', 'NEEDS_REVIEW'
FROM public.albums WHERE mbid = 'a166ef97-5540-3faa-b556-c6ecf812faa4'
AND NOT EXISTS (SELECT 1 FROM public.media_assets ma JOIN public.albums a2 ON ma.entity_id = a2.id
  WHERE ma.entity_type = 'ALBUM' AND a2.mbid = 'a166ef97-5540-3faa-b556-c6ecf812faa4' AND ma.source_url = 'https://coverartarchive.org/release-group/a166ef97-5540-3faa-b556-c6ecf812faa4/front');
INSERT INTO public.media_assets (id, entity_type, entity_id, asset_type, source_type, source_url, rights_type, status)
SELECT '69f2ff9a-291b-4ee0-8c88-a8fb10dc9049', 'ALBUM', albums.id, 'ALBUM_COVER', 'COVER_ART_ARCHIVE', 'https://coverartarchive.org/release-group/beef969a-f211-3c70-a9d4-1e6efb51fa71/front', 'QUOTATION_ONLY', 'NEEDS_REVIEW'
FROM public.albums WHERE mbid = 'beef969a-f211-3c70-a9d4-1e6efb51fa71'
AND NOT EXISTS (SELECT 1 FROM public.media_assets ma JOIN public.albums a2 ON ma.entity_id = a2.id
  WHERE ma.entity_type = 'ALBUM' AND a2.mbid = 'beef969a-f211-3c70-a9d4-1e6efb51fa71' AND ma.source_url = 'https://coverartarchive.org/release-group/beef969a-f211-3c70-a9d4-1e6efb51fa71/front');
INSERT INTO public.media_assets (id, entity_type, entity_id, asset_type, source_type, source_url, rights_type, status)
SELECT 'bd493f84-27dd-4829-87c1-3be5e906f220', 'ALBUM', albums.id, 'ALBUM_COVER', 'COVER_ART_ARCHIVE', 'https://coverartarchive.org/release-group/79700a12-50e3-4544-ac12-ff58acc95c6e/front', 'QUOTATION_ONLY', 'NEEDS_REVIEW'
FROM public.albums WHERE mbid = '79700a12-50e3-4544-ac12-ff58acc95c6e'
AND NOT EXISTS (SELECT 1 FROM public.media_assets ma JOIN public.albums a2 ON ma.entity_id = a2.id
  WHERE ma.entity_type = 'ALBUM' AND a2.mbid = '79700a12-50e3-4544-ac12-ff58acc95c6e' AND ma.source_url = 'https://coverartarchive.org/release-group/79700a12-50e3-4544-ac12-ff58acc95c6e/front');
INSERT INTO public.media_assets (id, entity_type, entity_id, asset_type, source_type, source_url, rights_type, status)
SELECT 'aaec62e3-e1e0-4520-9ae1-5c26ff3fc560', 'ALBUM', albums.id, 'ALBUM_COVER', 'COVER_ART_ARCHIVE', 'https://coverartarchive.org/release-group/77b3bbd2-a07e-4580-b6c9-ac90c91078cc/front', 'QUOTATION_ONLY', 'NEEDS_REVIEW'
FROM public.albums WHERE mbid = '77b3bbd2-a07e-4580-b6c9-ac90c91078cc'
AND NOT EXISTS (SELECT 1 FROM public.media_assets ma JOIN public.albums a2 ON ma.entity_id = a2.id
  WHERE ma.entity_type = 'ALBUM' AND a2.mbid = '77b3bbd2-a07e-4580-b6c9-ac90c91078cc' AND ma.source_url = 'https://coverartarchive.org/release-group/77b3bbd2-a07e-4580-b6c9-ac90c91078cc/front');
INSERT INTO public.media_assets (id, entity_type, entity_id, asset_type, source_type, source_url, rights_type, status)
SELECT 'caca1b32-ea7c-483f-add0-8c710a6d72b0', 'ALBUM', albums.id, 'ALBUM_COVER', 'COVER_ART_ARCHIVE', 'https://coverartarchive.org/release-group/000b747c-a83b-4b00-aa47-a839f6527a92/front', 'QUOTATION_ONLY', 'NEEDS_REVIEW'
FROM public.albums WHERE mbid = '000b747c-a83b-4b00-aa47-a839f6527a92'
AND NOT EXISTS (SELECT 1 FROM public.media_assets ma JOIN public.albums a2 ON ma.entity_id = a2.id
  WHERE ma.entity_type = 'ALBUM' AND a2.mbid = '000b747c-a83b-4b00-aa47-a839f6527a92' AND ma.source_url = 'https://coverartarchive.org/release-group/000b747c-a83b-4b00-aa47-a839f6527a92/front');
INSERT INTO public.media_assets (id, entity_type, entity_id, asset_type, source_type, source_url, rights_type, status)
SELECT '44aea662-4be6-4fe2-8bf7-a64da83780bc', 'ALBUM', albums.id, 'ALBUM_COVER', 'COVER_ART_ARCHIVE', 'https://coverartarchive.org/release-group/d2d39dbf-c69e-4c87-b005-b77dde88f1f4/front', 'QUOTATION_ONLY', 'NEEDS_REVIEW'
FROM public.albums WHERE mbid = 'd2d39dbf-c69e-4c87-b005-b77dde88f1f4'
AND NOT EXISTS (SELECT 1 FROM public.media_assets ma JOIN public.albums a2 ON ma.entity_id = a2.id
  WHERE ma.entity_type = 'ALBUM' AND a2.mbid = 'd2d39dbf-c69e-4c87-b005-b77dde88f1f4' AND ma.source_url = 'https://coverartarchive.org/release-group/d2d39dbf-c69e-4c87-b005-b77dde88f1f4/front');
INSERT INTO public.media_assets (id, entity_type, entity_id, asset_type, source_type, source_url, rights_type, status)
SELECT '595c2c67-00b2-42ac-bdb3-680df3de58d1', 'ALBUM', albums.id, 'ALBUM_COVER', 'COVER_ART_ARCHIVE', 'https://coverartarchive.org/release-group/ff5cc185-fd38-4d98-a06b-695688584c5c/front', 'QUOTATION_ONLY', 'NEEDS_REVIEW'
FROM public.albums WHERE mbid = 'ff5cc185-fd38-4d98-a06b-695688584c5c'
AND NOT EXISTS (SELECT 1 FROM public.media_assets ma JOIN public.albums a2 ON ma.entity_id = a2.id
  WHERE ma.entity_type = 'ALBUM' AND a2.mbid = 'ff5cc185-fd38-4d98-a06b-695688584c5c' AND ma.source_url = 'https://coverartarchive.org/release-group/ff5cc185-fd38-4d98-a06b-695688584c5c/front');
INSERT INTO public.media_assets (id, entity_type, entity_id, asset_type, source_type, source_url, rights_type, status)
SELECT '7a7c0813-f307-4d7f-84cd-43dc186efbc7', 'ALBUM', albums.id, 'ALBUM_COVER', 'COVER_ART_ARCHIVE', 'https://coverartarchive.org/release-group/ed1bdfe3-2a7a-32ef-b357-a6a8702781e7/front', 'QUOTATION_ONLY', 'NEEDS_REVIEW'
FROM public.albums WHERE mbid = 'ed1bdfe3-2a7a-32ef-b357-a6a8702781e7'
AND NOT EXISTS (SELECT 1 FROM public.media_assets ma JOIN public.albums a2 ON ma.entity_id = a2.id
  WHERE ma.entity_type = 'ALBUM' AND a2.mbid = 'ed1bdfe3-2a7a-32ef-b357-a6a8702781e7' AND ma.source_url = 'https://coverartarchive.org/release-group/ed1bdfe3-2a7a-32ef-b357-a6a8702781e7/front');
INSERT INTO public.media_assets (id, entity_type, entity_id, asset_type, source_type, source_url, rights_type, status)
SELECT 'd2008227-018a-4af3-ae1f-942ed794dca0', 'ALBUM', albums.id, 'ALBUM_COVER', 'COVER_ART_ARCHIVE', 'https://coverartarchive.org/release-group/7cfd25d8-c7fe-3847-af56-62e5677605b4/front', 'QUOTATION_ONLY', 'NEEDS_REVIEW'
FROM public.albums WHERE mbid = '7cfd25d8-c7fe-3847-af56-62e5677605b4'
AND NOT EXISTS (SELECT 1 FROM public.media_assets ma JOIN public.albums a2 ON ma.entity_id = a2.id
  WHERE ma.entity_type = 'ALBUM' AND a2.mbid = '7cfd25d8-c7fe-3847-af56-62e5677605b4' AND ma.source_url = 'https://coverartarchive.org/release-group/7cfd25d8-c7fe-3847-af56-62e5677605b4/front');
INSERT INTO public.media_assets (id, entity_type, entity_id, asset_type, source_type, source_url, rights_type, status)
SELECT '8f301844-e255-4c2f-8349-82fc07a327cc', 'ALBUM', albums.id, 'ALBUM_COVER', 'COVER_ART_ARCHIVE', 'https://coverartarchive.org/release-group/3583d952-c5ec-3d69-b4e0-6f757d7480eb/front', 'QUOTATION_ONLY', 'NEEDS_REVIEW'
FROM public.albums WHERE mbid = '3583d952-c5ec-3d69-b4e0-6f757d7480eb'
AND NOT EXISTS (SELECT 1 FROM public.media_assets ma JOIN public.albums a2 ON ma.entity_id = a2.id
  WHERE ma.entity_type = 'ALBUM' AND a2.mbid = '3583d952-c5ec-3d69-b4e0-6f757d7480eb' AND ma.source_url = 'https://coverartarchive.org/release-group/3583d952-c5ec-3d69-b4e0-6f757d7480eb/front');
INSERT INTO public.media_assets (id, entity_type, entity_id, asset_type, source_type, source_url, rights_type, status)
SELECT '88cd1988-d8b4-48ae-adca-1b9c4c407a8f', 'ALBUM', albums.id, 'ALBUM_COVER', 'COVER_ART_ARCHIVE', 'https://coverartarchive.org/release-group/bf4fb5a7-3e90-4c33-a64f-53b5f6d3f235/front', 'QUOTATION_ONLY', 'NEEDS_REVIEW'
FROM public.albums WHERE mbid = 'bf4fb5a7-3e90-4c33-a64f-53b5f6d3f235'
AND NOT EXISTS (SELECT 1 FROM public.media_assets ma JOIN public.albums a2 ON ma.entity_id = a2.id
  WHERE ma.entity_type = 'ALBUM' AND a2.mbid = 'bf4fb5a7-3e90-4c33-a64f-53b5f6d3f235' AND ma.source_url = 'https://coverartarchive.org/release-group/bf4fb5a7-3e90-4c33-a64f-53b5f6d3f235/front');
INSERT INTO public.media_assets (id, entity_type, entity_id, asset_type, source_type, source_url, rights_type, status)
SELECT '8aea7adc-0ffe-43ec-a142-e6fd2964f3cf', 'ALBUM', albums.id, 'ALBUM_COVER', 'COVER_ART_ARCHIVE', 'https://coverartarchive.org/release-group/407206ec-76f5-4715-bce9-01f68abe47ff/front', 'QUOTATION_ONLY', 'NEEDS_REVIEW'
FROM public.albums WHERE mbid = '407206ec-76f5-4715-bce9-01f68abe47ff'
AND NOT EXISTS (SELECT 1 FROM public.media_assets ma JOIN public.albums a2 ON ma.entity_id = a2.id
  WHERE ma.entity_type = 'ALBUM' AND a2.mbid = '407206ec-76f5-4715-bce9-01f68abe47ff' AND ma.source_url = 'https://coverartarchive.org/release-group/407206ec-76f5-4715-bce9-01f68abe47ff/front');
INSERT INTO public.media_assets (id, entity_type, entity_id, asset_type, source_type, source_url, rights_type, status)
SELECT 'c9f79767-58c2-4f98-a4a8-65eb5a3dc1a9', 'ALBUM', albums.id, 'ALBUM_COVER', 'COVER_ART_ARCHIVE', 'https://coverartarchive.org/release-group/413d3b68-6a32-4d0a-a6c9-0e19e129be96/front', 'QUOTATION_ONLY', 'NEEDS_REVIEW'
FROM public.albums WHERE mbid = '413d3b68-6a32-4d0a-a6c9-0e19e129be96'
AND NOT EXISTS (SELECT 1 FROM public.media_assets ma JOIN public.albums a2 ON ma.entity_id = a2.id
  WHERE ma.entity_type = 'ALBUM' AND a2.mbid = '413d3b68-6a32-4d0a-a6c9-0e19e129be96' AND ma.source_url = 'https://coverartarchive.org/release-group/413d3b68-6a32-4d0a-a6c9-0e19e129be96/front');
INSERT INTO public.media_assets (id, entity_type, entity_id, asset_type, source_type, source_url, rights_type, status)
SELECT '03eb24bf-2c2e-4f7a-aace-1af65a442b4f', 'ALBUM', albums.id, 'ALBUM_COVER', 'COVER_ART_ARCHIVE', 'https://coverartarchive.org/release-group/3fd59d8f-bb35-3275-a536-d4f8e598184a/front', 'QUOTATION_ONLY', 'NEEDS_REVIEW'
FROM public.albums WHERE mbid = '3fd59d8f-bb35-3275-a536-d4f8e598184a'
AND NOT EXISTS (SELECT 1 FROM public.media_assets ma JOIN public.albums a2 ON ma.entity_id = a2.id
  WHERE ma.entity_type = 'ALBUM' AND a2.mbid = '3fd59d8f-bb35-3275-a536-d4f8e598184a' AND ma.source_url = 'https://coverartarchive.org/release-group/3fd59d8f-bb35-3275-a536-d4f8e598184a/front');
INSERT INTO public.media_assets (id, entity_type, entity_id, asset_type, source_type, source_url, rights_type, status)
SELECT 'e6500e15-57f8-4a94-a9ef-4e4bdea73b98', 'ALBUM', albums.id, 'ALBUM_COVER', 'COVER_ART_ARCHIVE', 'https://coverartarchive.org/release-group/08d85e21-b5b9-4a30-8942-40cfdd239ec5/front', 'QUOTATION_ONLY', 'NEEDS_REVIEW'
FROM public.albums WHERE mbid = '08d85e21-b5b9-4a30-8942-40cfdd239ec5'
AND NOT EXISTS (SELECT 1 FROM public.media_assets ma JOIN public.albums a2 ON ma.entity_id = a2.id
  WHERE ma.entity_type = 'ALBUM' AND a2.mbid = '08d85e21-b5b9-4a30-8942-40cfdd239ec5' AND ma.source_url = 'https://coverartarchive.org/release-group/08d85e21-b5b9-4a30-8942-40cfdd239ec5/front');
INSERT INTO public.media_assets (id, entity_type, entity_id, asset_type, source_type, source_url, rights_type, status)
SELECT '98aa4b31-9dfb-42b1-b273-e816886c82d3', 'ALBUM', albums.id, 'ALBUM_COVER', 'COVER_ART_ARCHIVE', 'https://coverartarchive.org/release-group/da1c8f98-c48d-48d7-904c-db6fb1683554/front', 'QUOTATION_ONLY', 'NEEDS_REVIEW'
FROM public.albums WHERE mbid = 'da1c8f98-c48d-48d7-904c-db6fb1683554'
AND NOT EXISTS (SELECT 1 FROM public.media_assets ma JOIN public.albums a2 ON ma.entity_id = a2.id
  WHERE ma.entity_type = 'ALBUM' AND a2.mbid = 'da1c8f98-c48d-48d7-904c-db6fb1683554' AND ma.source_url = 'https://coverartarchive.org/release-group/da1c8f98-c48d-48d7-904c-db6fb1683554/front');
INSERT INTO public.media_assets (id, entity_type, entity_id, asset_type, source_type, source_url, rights_type, status)
SELECT '831aa082-6f82-4265-b9f9-fc943bf9b086', 'ALBUM', albums.id, 'ALBUM_COVER', 'COVER_ART_ARCHIVE', 'https://coverartarchive.org/release-group/104c0cd9-2f3b-4072-b20b-fd345fae38a1/front', 'QUOTATION_ONLY', 'NEEDS_REVIEW'
FROM public.albums WHERE mbid = '104c0cd9-2f3b-4072-b20b-fd345fae38a1'
AND NOT EXISTS (SELECT 1 FROM public.media_assets ma JOIN public.albums a2 ON ma.entity_id = a2.id
  WHERE ma.entity_type = 'ALBUM' AND a2.mbid = '104c0cd9-2f3b-4072-b20b-fd345fae38a1' AND ma.source_url = 'https://coverartarchive.org/release-group/104c0cd9-2f3b-4072-b20b-fd345fae38a1/front');
