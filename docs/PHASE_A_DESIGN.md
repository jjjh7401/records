# Phase A — Foundation 설계

상태: ✅ 제이님 승인 완료 (2026-10-12) → Phase A 구축 완료 (같은 날)
근거 문서: 09_TECHNICAL_ARCHITECTURE.md, 07_SECURITY_PRIVACY.md,
03_DOMAIN_MODEL.md, 11_CODEX_CLAUDE_HANDOFF.md, D-015~D-019

## 1. 스택 결정

| 영역 | 선택 | 근거 |
|---|---|---|
| Frontend + API Server | Next.js (App Router, TypeScript) | 문서의 "API/Application Server" 역할을 Route Handler로 수행. 단일 배포 단위로 MVP 속도 확보 |
| Database | Supabase Postgres | 기획 문서가 Supabase Storage를 전제. RLS로 브라우저 직접 접근 통제 가능 |
| Auth | Supabase Auth | 문서 07의 검토 대상(Google/Apple/Kakao/Email)을 OAuth provider로 지원 |
| Storage | Supabase Storage | Phase A에서는 사용자 업로드(아바타) 용도. 제3자 아트워크 저장은 D-006에 따라 금지 |
| ORM / Migration | Drizzle ORM + drizzle-kit | 타입 안전 스키마, SQL migration 파일로 버전 관리 |
| Validation | zod | API 입력 검증 |
| Logging | pino (JSON) | request id 포함 구조화 로그 |
| Error tracking | Sentry | 서버/클라이언트 에러 수집 |
| Hosting | Vercel | CDN/WAF → App Server 구조(문서 07-1)와 일치, Next.js 네이티브 |

단일 Next.js 앱으로 시작한다. 문서 09-7의 backend separation
(auth/music/walkie/shop/...)은 `src/server/modules/*` 디렉토리 경계로 논리 분리하고,
Phase C에서 ingestion worker를 별도 런타임으로 분리한다.

## 2. 레포 구조

```text
records/
├─ app/                          # Next.js App Router
│  ├─ (auth)/login/page.tsx
│  ├─ (auth)/signup/page.tsx
│  ├─ auth/callback/route.ts      # OAuth 콜백
│  └─ api/                        # API Route Handlers (추후 modules로 이동)
├─ src/
│  ├─ server/
│  │  ├─ modules/
│  │  │  └─ auth/                 # Phase A: auth만
│  │  ├─ db/
│  │  │  ├─ schema/               # Drizzle 테이블 정의 (도메인별 파일 분리)
│  │  │  └─ client.ts             # pooled client (server-only)
│  │  └─ lib/
│  │     ├─ env.ts                # 환경변수 검증 (zod)
│  │     ├─ logger.ts             # pino
│  │     └─ errors.ts             # 에러 타입/코드
│  ├─ components/                 # UI 컴포넌트
│  └─ lib/                        # 클라이언트 공용
├─ drizzle/                       # migration SQL 파일 (버전 관리)
├─ docs/                          # records_analysis 문서 이관
└─ .env.example
```

## 3. DB 스키마 (Phase A 범위)

원본 도메인 모델(03-3)에서 Phase A에 필요한 것만:

```text
users              # public.users, auth.users(id) 참조
user_profiles      # display_name, handle(unique), avatar, bio
user_privacy       # profile_visibility 등
user_regions       # sido, sigungu (D-012: 광역시/도, 시/군/구까지만)
login_logs         # 문서 07-8 LOGIN / FAILED_LOGIN
security_events    # 문서 07-8 전체 이벤트 타입
admin_audit_logs   # 문서 07-7
```

핵심 필드:

```sql
users
  id            uuid PK (auth.users 참조)
  email         text unique
  status        text  -- ACTIVE / SUSPENDED / DELETED
  created_at / updated_at / deleted_at

user_profiles
  user_id       uuid PK/FK
  handle        text unique not null   -- @haru
  display_name  text
  avatar_asset_id uuid nullable        -- Phase F MEDIA_ASSET과 연결 예정
  bio           text

user_privacy
  user_id            uuid PK/FK
  profile_visibility text default 'public'  -- public / followers / private

user_regions
  user_id    uuid PK/FK
  sido       text      -- 예: 서울특별시
  sigungu    text      -- 예: 마포구 (nullable)
  visibility text default 'followers'  -- public / followers / private

login_logs
  id, user_id, occurred_at, ip, user_agent, result  -- SUCCESS / FAILED

security_events
  id, user_id nullable, type, detail jsonb, occurred_at
  -- type: LOGIN, FAILED_LOGIN, PASSWORD_RESET, MFA, PASSKEY,
  --       SUSPICIOUS_LOGIN, AUTHORIZATION_DENIED, ADMIN_ACCESS,
  --       EXPORT, DELETE, API_ABUSE, CONTENT_TAKEDOWN

admin_audit_logs
  id, admin_user_id, action, target_type, target_id, detail jsonb, occurred_at
```

### RLS 정책 (Phase A)

- 모든 테이블 RLS 활성화, 기본 deny.
- Phase A에서는 서버 전용 `service_role` 클라이언트로만 접근하고,
  anon 키로는 직접 조회가 차단되는 것을 테스트로 확인한다.
- Phase B부터 테이블별 세밀 정책 추가 (예: 본인 profile 수정만 허용).

### 회원가입 흐름

```text
Supabase Auth 회원가입 (Email/Google/Apple/Kakao)
  ↓ auth.users 생성
  ↓ DB trigger: on_auth_user_created
  ↓ public.users + user_profiles(handle 자동 생성) + user_privacy(기본값) 행 생성
  ↓ login_logs에 SUCCESS 기록
```

## 4. Auth 설계

- Supabase Auth(GoTrue) 사용. Email(비밀번호/매직링크) + Google/Apple/Kakao OAuth.
- 세션: HttpOnly + Secure 쿠키 (Supabase SSR 기본 동작).
- MFA/Passkey: Phase A 범위 밖. 스키마와 Auth 설정은 확장 가능하게 유지
  (문서 07-2의 권장사항으로 별도 Phase에 편입).
- 관리자 권한: `users.status`와 별개로 `admin_roles(user_id, role)` 테이블을
  Phase A에 추가하거나, 최소한 `is_admin` 플래그 + admin_audit_logs로 시작.
  → 권장: `admin_roles` 테이블 (role: SUPER_ADMIN / MODERATOR), 일반 권한과 분리 (문서 07-7).

## 5. 환경변수

```bash
# .env.example
NEXT_PUBLIC_SUPABASE_URL=
NEXT_PUBLIC_SUPABASE_ANON_KEY=
SUPABASE_SERVICE_ROLE_KEY=        # 서버 전용. 절대 브라우저/클라이언트에 노출 금지
SUPABASE_DB_URL=                  # migration용 (direct connection)
APP_URL=http://localhost:3000
LOG_LEVEL=info
SENTRY_DSN=                        # 선택
```

`src/server/lib/env.ts`에서 zod로 시작 시점에 검증. 누락 시 서버 시작 실패.

## 6. 로깅 / 관찰 (Phase A)

- pino JSON 로그, 모든 요청에 request id 부여.
- 기록 대상: API 요청/응답(민감정보 마스킹), auth 성공/실패, DB 에러.
- Sentry: unhandled error + API 5xx.
- Phase A 관측 지표: auth 실패율, API latency (Vercel Analytics).

## 7. 마이그레이션 / 환경 분리

- `drizzle-kit generate` → `drizzle/` 에 SQL 파일 생성 → 코드 리뷰 → `drizzle-kit migrate`.
- 환경 분리 (문서 07-10): local(Supabase CLI) / staging / production.
- 운영 DB 접근은 최소 권한 + 감사. 개발자의 로컬은 anon 키만 사용.

## 8. Definition of Done (Phase A)

- [ ] Email + Google 로그인/로그아웃 동작
- [ ] OAuth 콜백 후 users/profile/privacy 행 자동 생성
- [ ] 빈 DB에서 `drizzle-kit migrate`만으로 스키마 재현 가능
- [ ] 환경변수 3환경 분리 + zod 검증
- [ ] pino 구조화 로그 + Sentry 연동
- [ ] anon 키로 테이블 직접 조회 차단 확인 (RLS 테스트)
- [ ] login_logs / security_events 기록 확인
- [ ] 관리자/일반 권한 분리 (admin_roles)

## 9. Phase A에 포함하지 않는 것

- 음악 도메인 테이블 (Phase B)
- Ingestion / AI / 인간 검수 (Phase C)
- YouTube 플레이어 (Phase D)
- MFA / Passkey (후순위 Phase)
- Spotify 관련 일체 (D-015)
