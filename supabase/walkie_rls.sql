-- Walkie RLS.
-- 본인의 섹션/아이템만 CRUD 가능. anon은 접근 불가.

alter table public.walkie_sections enable row level security;
alter table public.walkie_items enable row level security;

-- 섹션: 본인 것만
create policy "own sections" on public.walkie_sections
  for all to authenticated
  using (user_id = auth.uid())
  with check (user_id = auth.uid());

-- 아이템: 본인 섹션에 속한 것만
create policy "own items" on public.walkie_items
  for all to authenticated
  using (
    exists (
      select 1 from public.walkie_sections s
      where s.id = walkie_items.section_id
        and s.user_id = auth.uid()
    )
  )
  with check (
    exists (
      select 1 from public.walkie_sections s
      where s.id = walkie_items.section_id
        and s.user_id = auth.uid()
    )
  );
