# SEED_ARTISTS_DRAFT.md

초기 카탈로그 확장용 시드 아티스트 25팀 드래프트 (2026-10-13 작성).
제이님이 승인하면 `scripts/ingest-mb.ts`로 릴리스 그룹 단위 인제스트 진행.

## 선정 기준
- J-POP "음악 도시" 플랫폼의 앵커 아티스트: 시대·장르를 대표하는 팀 우선
- MusicBrainz MBID 전수 검증 완료 (2026-10-13, score 100 매칭)
- Vaundy는 이미 시드 완료(strobo) — 제외
- 커버아트는 `NEEDS_REVIEW` 정책 유지 (자동 공개 안 함)

## 버킷 A — 현재 진행형 (스트리밍·발견 중심, 먼저 넣기 권장 ①)
| # | 아티스트 | MBID | 타입 |
|---|----------|------|------|
| 1 | 米津玄師 | 09d4a85c-4916-4b4e-bc96-c4cfcf371046 | Person |
| 2 | YOASOBI | df6c619f-4334-43e2-8b6a-4a32af1e4f85 | Group |
| 3 | Official髭男dism | 6dddd7a2-5583-49d0-a8b2-9ee46d04f27e | Group |
| 4 | King Gnu | 338f5d97-3133-4bf8-a58e-068ff9b5405d | Group (fka Srv.Vinci) |
| 5 | あいみょん | 908d9ac2-5187-4b9e-b281-601c6afb0791 | Person |

## 버킷 B — 2000~2010년대 앵커 ②
| # | 아티스트 | MBID | 타입 |
|---|----------|------|------|
| 6 | RADWIMPS | 6f500293-7396-4903-b4fd-118127d06f9e | Group |
| 7 | ONE OK ROCK | 6ef00829-fa94-4fee-a5a6-b28e1208e96a | Group |
| 8 | 椎名林檎 | 9e414497-23b7-4ab7-9ec6-8ea9864c9e87 | Person |
| 9 | 東京事変 | b3d0f168-cb34-47c6-8529-fc05d1fce3ee | Group |
| 10 | Perfume | 486067ad-56d6-48b5-957b-d6cfe3e1af73 | Group |
| 11 | きゃりーぱみゅぱみゅ | 10e2d18c-7a8c-4d26-bb4a-450bb6851cb2 | Person |
| 12 | SEKAI NO OWARI | d9dbfe6a-8346-4337-8614-fe96aab63927 | Group |
| 13 | サカナクション | 01830cc1-8a04-4dfb-9e4a-d557dfda6a93 | Group |
| 14 | 星野源 | 2c6c53ea-09d4-4d98-b174-c9aa83d4fecf | Person |
| 15 | フジファブリック | 8f026642-9e02-4f1b-880d-0ae7894a3e92 | Group |

## 버킷 C — 레전드 (시대를 만든 팀) ③
| # | 아티스트 | MBID | 타입 |
|---|----------|------|------|
| 16 | 宇多田ヒカル | b539e453-c4fe-47e3-8a07-8517eac74429 | Person |
| 17 | 浜崎あゆみ | 2b615bcf-baa0-4657-b9a5-1a5f34c386c4 | Person |
| 18 | Mr.Children | 27f0af0e-4d1f-4808-a58b-090e400dcc43 | Group |
| 19 | B'z | 20172e89-b8a5-4675-bd79-792d50d846a9 | Group (rock duo) |
| 20 | サザンオールスターズ | 24d9e513-c215-4901-87ee-b66aa769ab9d | Group |
| 21 | 松任谷由実 | 0d27f48b-c8d7-464b-85e5-5a2b823436c9 | Person |
| 22 | 中島みゆき | 75312493-4d98-498e-8d75-62f88ceaf55c | Person |
| 23 | 山下達郎 | ad62391d-ab7e-4ac9-9ce8-3704bc6746bb | Person |
| 24 | スピッツ | 0550993e-ddec-468e-b05f-da81bf6f7694 | Group |
| 25 | DREAMS COME TRUE | f984ebbf-8534-4163-9cb8-295c91535446 | Group |

## 다음 단계 (승인 후)
1. 각 아티스트의 대표 릴리스 그룹 MBID 선정 (베스트/대표작 우선)
2. `npx tsx scripts/ingest-mb.ts --release-group <MBID> --out seed_<artist>.sql` 실행 (초당 1요청 예절 유지)
3. SQL 리뷰 후 Supabase 적용 — 커버아트는 `NEEDS_REVIEW` 유지

## 주의
- B'z는 MusicBrainz 표기가 `B'z`(typographic apostrophe) — 위 MBID 사용
- King Gnu = 구 Srv.Vinci — 동일 MBID
- 米津玄師의 보컬로이드 명의(ハチ)는 별도 아티스트이므로 혼동 금지
