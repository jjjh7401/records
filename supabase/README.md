# supabase/ — Supabase Dashboard에 수동 적용하는 SQL

이 폴더의 SQL은 `drizzle-kit migrate`로 적용하지 않는다.
(auth 스키마 트리거, RLS 정책 등 Supabase 고유 설정을 포함하기 때문)

## 적용 순서 (최초 1회)

1. Supabase 프로젝트 생성 (https://supabase.com/dashboard)
2. `.env.local`에 `SUPABASE_DB_URL` 설정 후 `npm run db:migrate` 실행
   (drizzle/ 마이그레이션으로 public 스키마 테이블 생성)
3. Dashboard > SQL Editor에서 `auth_trigger.sql` 실행
4. Dashboard > SQL Editor에서 `rls_policies.sql` 실행
5. Dashboard > Authentication > Providers에서 Google / Apple / Kakao 활성화
6. Dashboard > Authentication > URL Configuration에
   `APP_URL/auth/callback`을 Redirect URL로 등록

## 파일 설명

- `auth_trigger.sql` — `auth.users` INSERT 시 `public.users` / `user_profiles` /
  `user_privacy` 자동 생성 + `updated_at` 자동 갱신 트리거
- `rls_policies.sql` — 전 테이블 RLS 활성화 (Phase A는 기본 deny)

## D-006 / D-015 가드레일

- 이 폴더에 제3자 아트워크 저장 관련 SQL을 추가하지 않는다 (D-006).
- Spotify 관련 테이블/정책을 추가하지 않는다 (D-015).
