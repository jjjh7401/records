-- ============================================================================
-- RECORDS Phase A — RLS (Row Level Security) 정책
-- ============================================================================
-- 적용 방법: Supabase Dashboard > SQL Editor에 이 파일 내용을 붙여넣고 실행.
-- (drizzle migration 이후에 적용. 순서를 바꾸면 안 된다.)
--
-- Phase A 원칙 (문서 07-1):
--   - 모든 테이블 RLS 활성화, 기본 deny (permissive policy 없음).
--   - 서버는 service_role 키(createServiceClient) 또는 직접 DB 연결(getDb)로
--     접근하므로 RLS를 우회한다.
--   - 브라우저(anon key)에서는 어떤 행도 읽거나 쓸 수 없다.
--   - Phase B부터 테이블별 세밀 정책 추가 (예: 본인 프로필 수정 허용).
--
-- 로그 테이블(login_logs, security_events, admin_audit_logs)은
-- append-only 운용: UPDATE/DELETE policy를 절대 추가하지 않는다.
-- ============================================================================

alter table public.users enable row level security;
alter table public.user_profiles enable row level security;
alter table public.user_privacy enable row level security;
alter table public.user_regions enable row level security;
alter table public.admin_roles enable row level security;
alter table public.login_logs enable row level security;
alter table public.security_events enable row level security;
alter table public.admin_audit_logs enable row level security;

-- Phase A에서는 permissive policy를 추가하지 않는다 (기본 deny).
-- 아래는 Phase B 이후 추가될 정책의 자리 표시자이다. 지금은 실행하지 않는다.

-- 예시 (Phase B):
-- create policy "users_select_own"
--   on public.users for select
--   using (auth.uid() = id);
--
-- create policy "user_profiles_update_own"
--   on public.user_profiles for update
--   using (auth.uid() = user_id)
--   with check (auth.uid() = user_id);
