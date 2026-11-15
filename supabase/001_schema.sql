-- Run only in a NEW dedicated ZAVÉQ Supabase project. One-time migration.
begin;
create table public.stores (
 id uuid primary key default gen_random_uuid(), name text not null check(char_length(name) between 1 and 120),
 kind text not null check(kind in ('retail','local')), city text not null, description text not null default '',
 status text not null default 'pending' check(status in ('pending','active','suspended')), created_at timestamptz not null default now()
);
create table public.products (
 id uuid primary key default gen_random_uuid(), store_id uuid not null references public.stores(id) on delete cascade,
 name text not null, category text not null check(category in ('Women','Men','Shoes','Accessories')),
 price numeric(12,2) not null check(price>=0), stock integer not null default 0 check(stock>=0), sizes text[] not null default array['One size'],
 color text not null default '', image text not null default '/products/blazer.svg', description text not null default '', active boolean not null default false,
 created_at timestamptz not null default now()
);
create index products_store_id_idx on public.products(store_id);
create table public.seller_applications (
 id uuid primary key default gen_random_uuid(), owner_id uuid not null references auth.users(id) on delete cascade,
 name text not null check(char_length(trim(name)) between 1 and 120), city text not null check(char_length(trim(city)) between 1 and 80),
 kind text not null check(kind in ('local','retail')), description text not null check(char_length(trim(description)) between 1 and 1000),
 email text not null check(char_length(email) between 3 and 254), status text not null default 'pending' check(status in ('pending','approved','rejected')),
 created_at timestamptz not null default now()
);
create unique index one_pending_application_per_user on public.seller_applications(owner_id) where status='pending';
-- Private membership foundation for future seller and admin dashboards. Not exposed to browser roles.
create table public.store_memberships (store_id uuid not null references public.stores(id) on delete cascade, user_id uuid not null references auth.users(id) on delete cascade, role text not null check(role in ('owner','manager','staff')), primary key(store_id,user_id));
alter table public.stores enable row level security;
alter table public.products enable row level security;
alter table public.seller_applications enable row level security;
alter table public.store_memberships enable row level security;
revoke all on public.stores,public.products,public.seller_applications,public.store_memberships from anon,authenticated;
grant select on public.stores,public.products to anon,authenticated;
grant select on public.seller_applications to authenticated;
grant insert(owner_id,name,city,kind,description,email) on public.seller_applications to authenticated;
create policy read_active_stores on public.stores for select to anon,authenticated using(status='active');
create policy read_active_products on public.products for select to anon,authenticated using(active and exists(select 1 from public.stores s where s.id=store_id and s.status='active'));
create policy read_own_applications on public.seller_applications for select to authenticated using(owner_id=(select auth.uid()));
create policy submit_own_applications on public.seller_applications for insert to authenticated with check(owner_id=(select auth.uid()) and status='pending');
commit;
