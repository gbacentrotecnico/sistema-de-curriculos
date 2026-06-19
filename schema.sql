-- Habilita extensão para gerar UUIDs
create extension if not exists "uuid-ossp";

-- 1. Criação da tabela Cidades
create table if not exists public.cidades (
  id uuid default uuid_generate_v4() primary key,
  created_at timestamp with time zone default timezone('utc'::text, now()) not null,
  nome text not null
);

-- 2. Criação da tabela Cargos (Vagas)
create table if not exists public.cargos (
  id uuid default uuid_generate_v4() primary key,
  created_at timestamp with time zone default timezone('utc'::text, now()) not null,
  nome text not null,
  requisitos text
);

-- 3. Criação da tabela Candidatos (Banco de Currículos)
create table if not exists public.candidatos (
  id uuid default uuid_generate_v4() primary key,
  created_at timestamp with time zone default timezone('utc'::text, now()) not null,
  nome text not null,
  email text not null,
  telefone text not null,
  cidade text,
  vaga_interesse text,
  resumo text,
  curriculo_url text not null,
  avaliacao_ia text
);

-- 4. Criação da tabela Pesquisas (Clima / Engajamento)
create table if not exists public.pesquisas (
  id uuid default uuid_generate_v4() primary key,
  created_at timestamp with time zone default timezone('utc'::text, now()) not null,
  slug text unique not null,
  titulo text not null,
  descricao text,
  is_active boolean default true,
  perguntas jsonb not null default '[]'::jsonb
);

-- 5. Criação da tabela Respostas (Respostas das pesquisas)
create table if not exists public.respostas (
  id uuid default uuid_generate_v4() primary key,
  created_at timestamp with time zone default timezone('utc'::text, now()) not null,
  pesquisa_id uuid references public.pesquisas(id) on delete cascade not null,
  respostas_json jsonb not null default '{}'::jsonb
);


-- ==========================================
-- HABILITAR SEGURANÇA POR LINHA (RLS)
-- ==========================================
alter table public.cidades enable row level security;
alter table public.cargos enable row level security;
alter table public.candidatos enable row level security;
alter table public.pesquisas enable row level security;
alter table public.respostas enable row level security;


-- ==========================================
-- POLÍTICAS DE ACESSO (POLICIES)
-- ==========================================

-- A. Políticas para o PÚBLICO (Anônimos - visitantes do site)

-- Visitantes podem VER (SELECT) cidades e cargos para preencher formulários
create policy "Público pode ver cidades" on public.cidades for select to anon using (true);
create policy "Público pode ver cargos" on public.cargos for select to anon using (true);
-- Visitantes podem VER pesquisas que estejam ativas
create policy "Público pode ver pesquisas ativas" on public.pesquisas for select to anon using (is_active = true);

-- Visitantes podem ENVIAR (INSERT) currículos e respostas
create policy "Público pode inserir candidato" on public.candidatos for insert to anon with check (true);
create policy "Público pode inserir respostas" on public.respostas for insert to anon with check (true);


-- B. Políticas para o RH (Autenticados - admin do dashboard)

-- O RH tem acesso TOTAL (SELECT, INSERT, UPDATE, DELETE) a tudo
create policy "RH acesso total cidades" on public.cidades for all to authenticated using (true);
create policy "RH acesso total cargos" on public.cargos for all to authenticated using (true);
create policy "RH acesso total candidatos" on public.candidatos for all to authenticated using (true);
create policy "RH acesso total pesquisas" on public.pesquisas for all to authenticated using (true);
create policy "RH acesso total respostas" on public.respostas for all to authenticated using (true);
