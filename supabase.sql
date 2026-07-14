-- =====================================================================
-- Calendário Vivo 2026 · Grupo BBDI
-- Rodar UMA vez no SQL Editor do Supabase (New query > colar > Run)
-- Cria a tabela de estado compartilhado do painel (checklist + nº participantes)
-- =====================================================================

create table if not exists public.endo_estado (
  id          int primary key,
  npart       int not null default 110,
  checks      jsonb not null default '[]'::jsonb,
  updated_at  timestamptz not null default now()
);

-- linha única do painel (o app sempre lê/atualiza id = 1)
insert into public.endo_estado (id) values (1)
on conflict (id) do nothing;

-- Segurança: RLS ligada, sem INSERT nem DELETE públicos.
-- Apenas SELECT e UPDATE da linha existente são permitidos ao público (chave anon).
alter table public.endo_estado enable row level security;

drop policy if exists "leitura publica" on public.endo_estado;
create policy "leitura publica"
  on public.endo_estado for select
  using (true);

drop policy if exists "atualizacao publica" on public.endo_estado;
create policy "atualizacao publica"
  on public.endo_estado for update
  using (true)
  with check (true);

-- OBS: qualquer pessoa com o link do site consegue marcar/desmarcar o checklist.
-- Para restringir a gestores logados no futuro (v2): trocar as policies acima por
-- "using (auth.role() = 'authenticated')" e adicionar login via supabase.auth.
