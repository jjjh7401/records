# Phase B — 음악 카탈로그 설계

상태: 🛠️ 구축 중 (2026-10-13)
근거 문서: 03_DOMAIN_MODEL.md, 04_MUSIC_DATA_ARCHITECTURE.md, 05_ARTWORK_AND_RIGHTS.md,
D-015~D-019, PHASE_A_DESIGN.md §9

## 1. 범위

Phase B = 음악 카탈로그 도메인 (정규화의 중심).
사용자 인터랙션 테이블(Walkie/Shop/Collection/Rating/Review/Follow/Delivery)은
별도 Phase에서 다룬다.

핵심 원칙 (03-1, 03-9):
- 음악 객체는 한 번만 존재한다. 모든 사용자 콘텐츠는 SONG 행을 참조만 한다.
- 곡 자체를 사용자별로 복제하는 것은 금지.

## 2. 테이블 (11개)

```text
artists          # MusicBrainz artist. mbid unique
albums           # 작품 단위 = MusicBrainz release-group. MVP UI는 Album 중심 (D-019 A-002)
album_artists    # 앨범 ↔ 아티스트 (복수 아티스트 지원)
releases         # 발매 버전 = MusicBrainz release (CD/Vinyl/digital/Japan edition)
songs            # 곡 = MusicBrainz recording. 정규화의 중심
song_artists     # 곡 ↔ 아티스트 (feat/작곡/작사 role)
tracks           # release ↔ song 조인 (디스크/트랙 순서)
external_ids     # 외부 식별자 (D-017, D-019 A-003)
media_assets     # 아트워크/권리 분리 (03-5)
genres           # 장르 마스터
artist_genres    # 아티스트 ↔ 장르
```

### ALBUM / RELEASE 분리 (D-019 A-002)

```text
albums (작품) 1 ── N releases (발매 버전) 1 ── N tracks N ── 1 songs (곡)
```

같은 곡이 여러 발매 버전에 수록돼도 songs 행은 하나다.

### 외부 식별자 (D-017, D-019 A-003)

`external_ids(entity_type, entity_id, provider, external_id, confidence, status)`:

- provider: MUSICBRAINZ / YOUTUBE / APPLE_MUSIC
- ISRC는 컬럼이 아니라 외부 식별자로만 저장 (D-019 A-003)
- YouTube 매칭: ingestion 시점 1회 매칭 → confidence 저장 →
  미달 시 PENDING_REVIEW(수동 검토 큐) → MANUAL(사용자 직접 입력 폴백) (D-017)

### 아트워크/권리 (03-5, 03-6, D-006, D-016)

`media_assets`에 source_url(참조용) + rights_type + status 분리 저장.
제3자 아트워크 자동 다운로드는 금지. Apple Music API는 fallback으로만 사용.

## 3. 검색 (D-019 I-001)

MVP 검색은 Postgres full-text. expression GIN 인덱스 사용
(drizzle 스키마와 드리프트 방지):

- artists: name + sort_name
- albums: title + artist_credit
- songs: title + artist_credit

사전은 `'simple'` (J-POP의 일본어/영어 혼합 타이틀에 영어 stemmer 부적합).
SQL: `supabase/music_search.sql`

## 4. RLS

- 카탈로그 10개 테이블: anon/authenticated에 SELECT 허용 (공개 데이터).
- media_assets: `status = 'ACTIVE'`만 공개 (권리 분쟁 시 즉시 비공개 가능).
- 쓰기는 service_role 전용 (ingestion은 서버에서만 수행, Phase C).
- SQL: `supabase/music_rls.sql`

## 5. 마이그레이션

- `drizzle/0001_loose_jubilee.sql` (drizzle-kit generate)
- `supabase/music_triggers.sql` (updated_at 트리거, Phase A 함수 재사용)
- 적용 순서: 0001 → triggers+search → rls

## 6. Phase B에 포함하지 않는 것

- Ingestion worker / AI 후보 생성 / 인간 검수 (Phase C)
- YouTube 임베드 플레이어 (Phase D)
- Walkie / Shop / Collection / Rating / Review / Follow / Delivery (후속 Phase)
- Spotify 관련 일체 (D-015)
