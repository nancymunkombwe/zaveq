-- Run after 001_schema.sql in the dedicated ZAVÉQ project only.
begin;
create table public.zaveq_admins(user_id uuid primary key references auth.users(id) on delete cascade);
alter table public.zaveq_admins enable row level security;
revoke all on public.zaveq_admins from anon,authenticated;
create function public.is_zaveq_admin() returns boolean language sql stable security definer set search_path='' as $$ select exists(select 1 from public.zaveq_admins where user_id=(select auth.uid())) $$;
revoke all on function public.is_zaveq_admin() from public;
grant execute on function public.is_zaveq_admin() to authenticated;
create table public.delivery_providers(id text primary key, name text not null check(char_length(trim(name)) between 1 and 100), enabled boolean not null default false, fee numeric(12,2) not null check(fee between 0 and 100000), scope text not null check(scope in ('same-city','nationwide','pickup')), eta text not null check(char_length(trim(eta)) between 1 and 100), check(scope<>'pickup' or fee=0));
alter table public.delivery_providers enable row level security;
revoke all on public.delivery_providers from anon,authenticated;
grant select on public.delivery_providers to anon,authenticated;
grant insert,update on public.delivery_providers to authenticated;
create policy public_enabled_providers on public.delivery_providers for select to anon,authenticated using(enabled);
create policy admin_read_providers on public.delivery_providers for select to authenticated using((select public.is_zaveq_admin()));
create policy admin_create_providers on public.delivery_providers for insert to authenticated with check((select public.is_zaveq_admin()));
create policy admin_update_providers on public.delivery_providers for update to authenticated using((select public.is_zaveq_admin())) with check((select public.is_zaveq_admin()));
insert into public.delivery_providers values ('local','Manual local courier',true,35,'same-city','1–2 days'),('national','Manual intercity courier',true,90,'nationwide','2–5 days'),('pickup','Click & Collect',true,0,'pickup','When ready');
commit;
-- To authorize your own confirmed Auth account, use its exact UUID from Authentication > Users:
-- insert into public.zaveq_admins(user_id) values ('YOUR-USER-UUID');
