# Calendário Vivo 2026 · Grupo BBDI

🌐 **Produção:** https://calendario-vivo-bbdi.netlify.app · 📱 **Avaliação (QR):** https://calendario-vivo-bbdi.netlify.app/avaliar.html

Site de endomarketing com todos os feriados 2026 (nacionais, RS e Porto Alegre),
campanhas de integração entre setores, calculadora de custos e checklist do RH.

Arquitetura: `index.html` único · Netlify (publish = ".", sem build) · Supabase (anon key + RLS).

---

## PASSO 1 — GitHub (2 min)
1. github.com > **New repository** > nome: `calendario-vivo-2026` > Public > Create.
2. **Add file > Upload files** > arraste `index.html`, `avaliar.html`, `netlify.toml`, `supabase.sql`, `supabase-avaliacoes.sql`, `README.md`.
3. **Commit changes**.

## PASSO 2 — Netlify (2 min)
1. app.netlify.com > **Add new site > Import an existing project > GitHub**.
2. Selecione o repositório `calendario-vivo-2026`.
3. Build command: **(vazio)** · Publish directory: **.** (o netlify.toml já garante isso).
4. **Deploy**. O site já fica no ar e 100% funcional (salvamento local por navegador).
5. Site no ar em: **https://calendario-vivo-bbdi.netlify.app**

## PASSO 3 — Supabase (5 min) — ativa o checklist COMPARTILHADO
1. supabase.com > **New project** (nome: `bbdi-endomarketing`) > aguarde provisionar.
2. **SQL Editor > New query** > cole todo o conteúdo de `supabase.sql` > **Run**.
3. **Settings (engrenagem) > API** > copie:
   - `Project URL`
   - `anon public` key
4. No GitHub, abra `index.html` > lápis (Edit) > **Ctrl+F** por `SUPABASE_URL` (fica no
   início do bloco `<script>` principal, seção "persistência") e preencha:
   ```js
   const SUPABASE_URL = "https://SEU-PROJETO.supabase.co";
   const SUPABASE_ANON_KEY = "SUA-CHAVE-ANON";
   ```
5. **Commit changes** — o Netlify redeploya sozinho em ~30s.

## Validação (checklist de aceite)
- [ ] Site abre no link do Netlify com logos e 19 cards
- [ ] Slider de participantes recalcula os custos
- [ ] Marcar um item do checklist, abrir o link em OUTRO navegador/celular → item aparece marcado (Supabase OK)
- [ ] Supabase > Table Editor > `endo_estado` → coluna `checks` atualizando

## Segurança (estado atual — adequado para painel informativo)
- Chave **anon** exposta no HTML: é o desenho padrão do Supabase; a RLS limita o que ela pode fazer.
- Público pode apenas **ler** e **atualizar** a linha 1 (checklist/participantes). Sem INSERT/DELETE.
- Nada sensível é armazenado. Para exigir login de gestores (v2), ver observação no fim do `supabase.sql`.
