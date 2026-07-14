-- =====================================================================
-- Avaliação de eventos (QR code) · Calendário Vivo 2026 · Grupo BBDI
-- Rodar UMA vez no SQL Editor do Supabase (mesmo projeto do calendário)
-- =====================================================================

create table if not exists public.avaliacoes (
  id          bigint generated always as identity primary key,
  evento      text not null,
  setor       text,
  nota        int  not null check (nota between 0 and 10),
  comentario  text check (char_length(comentario) <= 300),
  criado_em   timestamptz not null default now()
);

alter table public.avaliacoes enable row level security;

-- Público pode INSERIR avaliações (é o objetivo do QR code)...
drop policy if exists "insercao publica" on public.avaliacoes;
create policy "insercao publica"
  on public.avaliacoes for insert
  with check (nota between 0 and 10);

-- ...e LER apenas as notas (para a média pós-envio). Sem UPDATE/DELETE públicos:
-- ninguém consegue alterar ou apagar avaliações já enviadas.
drop policy if exists "leitura publica" on public.avaliacoes;
create policy "leitura publica"
  on public.avaliacoes for select
  using (true);

-- Consulta pronta para o RH (Table Editor > SQL Editor):
-- select evento, round(avg(nota),1) as media, count(*) as respostas
-- from avaliacoes group by evento order by media desc;
