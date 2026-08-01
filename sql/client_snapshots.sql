-- Execute uma única vez no Supabase > SQL Editor.
create table if not exists public.client_snapshots (
  analysis_date date not null,
  cnpj text not null,
  cliente text,
  vendedor text,
  filial text,
  venda numeric not null default 0,
  quantidade numeric not null default 0,
  margem numeric,
  dias_sem_venda integer,
  importado_em timestamptz not null default now(),
  primary key (analysis_date, cnpj)
);

alter table public.client_snapshots enable row level security;

drop policy if exists "leitura de historico de clientes" on public.client_snapshots;
create policy "leitura de historico de clientes"
on public.client_snapshots for select to anon using (true);

drop policy if exists "gravacao de historico de clientes" on public.client_snapshots;
create policy "gravacao de historico de clientes"
on public.client_snapshots for insert to anon with check (true);

drop policy if exists "atualizacao de historico de clientes" on public.client_snapshots;
create policy "atualizacao de historico de clientes"
on public.client_snapshots for update to anon using (true) with check (true);
