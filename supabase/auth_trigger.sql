-- ============================================================================
-- RECORDS Phase A — auth.users 생성 시 public 스키마 행 자동 생성 트리거
-- ============================================================================
-- 적용 방법: Supabase Dashboard > SQL Editor에 이 파일 내용을 붙여넣고 실행.
-- (drizzle migration이 아닌 별도 SQL로 관리 — auth 스키마를 건드리기 때문)
--
-- 동작:
--   auth.users INSERT
--     → public.users (id, email, status=ACTIVE)
--     → public.user_profiles (handle 자동 생성, 이메일 prefix 기반 + 중복 시 suffix)
--     → public.user_privacy (기본값)
--   user_regions는 가입 시 입력받지 않으므로 생성하지 않는다 (사용자가 나중에 설정).
-- ============================================================================

-- updated_at 자동 갱신 함수
create or replace function public.set_updated_at()
returns trigger
language plpgsql
as $$
begin
  new.updated_at = now();
  return new;
end;
$$;

-- 신규 유저 public 행 생성 함수
create or replace function public.handle_new_user()
returns trigger
language plpgsql
security definer set search_path = public
as $$
declare
  base_handle text;
  final_handle text;
  suffix int := 0;
begin
  insert into public.users (id, email, status)
  values (new.id, new.email, 'ACTIVE')
  on conflict (id) do nothing;

  -- handle: 이메일 앞부분에서 영숫자/_만 추출, 중복 시 _1, _2 ... suffix
  base_handle := coalesce(
    nullif(regexp_replace(split_part(new.email, '@', 1), '[^a-zA-Z0-9_]', '', 'g'), ''),
    'user'
  );
  final_handle := base_handle;
  while exists (select 1 from public.user_profiles where handle = final_handle) loop
    suffix := suffix + 1;
    final_handle := base_handle || '_' || suffix::text;
  end loop;

  insert into public.user_profiles (user_id, handle, display_name)
  values (
    new.id,
    final_handle,
    coalesce(
      new.raw_user_meta_data ->> 'full_name',
      new.raw_user_meta_data ->> 'name',
      new.raw_user_meta_data ->> 'user_name'
    )
  )
  on conflict (user_id) do nothing;

  insert into public.user_privacy (user_id)
  values (new.id)
  on conflict (user_id) do nothing;

  return new;
end;
$$;

-- 기존 트리거가 있으면 교체
drop trigger if exists on_auth_user_created on auth.users;
create trigger on_auth_user_created
  after insert on auth.users
  for each row execute function public.handle_new_user();

-- updated_at 트리거 적용
drop trigger if exists set_users_updated_at on public.users;
create trigger set_users_updated_at
  before update on public.users
  for each row execute function public.set_updated_at();

drop trigger if exists set_user_profiles_updated_at on public.user_profiles;
create trigger set_user_profiles_updated_at
  before update on public.user_profiles
  for each row execute function public.set_updated_at();

drop trigger if exists set_user_privacy_updated_at on public.user_privacy;
create trigger set_user_privacy_updated_at
  before update on public.user_privacy
  for each row execute function public.set_updated_at();

drop trigger if exists set_user_regions_updated_at on public.user_regions;
create trigger set_user_regions_updated_at
  before update on public.user_regions
  for each row execute function public.set_updated_at();
