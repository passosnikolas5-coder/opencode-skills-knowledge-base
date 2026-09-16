# ⚡ ADVANCED SUPABASE - Skills Expandidas

> **Fonte:** https://github.com/supabase/supabase (80k+ stars)
> **Descrição:** Open-source Firebase alternative com suporte nativo a Vector/AI, PostgreSQL, Auth, Storage, Edge Functions e Realtime.

---

## 1. 🗄️ Database (PostgreSQL)

```sql
-- Criar tabela com tipos avançados
CREATE TABLE products (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  name TEXT NOT NULL,
  price DECIMAL(10,2) CHECK (price > 0),
  tags TEXT[] DEFAULT '{}',
  metadata JSONB DEFAULT '{}',
  created_at TIMESTAMPTZ DEFAULT now(),
  search_vector tsvector GENERATED ALWAYS AS (
    setweight(to_tsvector('portuguese', coalesce(name, '')), 'A') ||
    setweight(to_tsvector('portuguese', coalesce(tags::text, '')), 'B')
  ) STORED
);

-- Índice GIN para busca full-text
CREATE INDEX idx_products_search ON products USING GIN (search_vector);

-- Busca full-text
SELECT * FROM products
WHERE search_vector @@ plainto_tsquery('portuguese', 'camiseta algodão');
```

### MELHORIA

❌ ERRADO:
```sql
CREATE TABLE products (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  tags TEXT,
  metadata TEXT
);
-- Sem tipos nativos, sem JSONB, sem busca full-text
```

✅ CORRETO:
```sql
CREATE TABLE products (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  name TEXT NOT NULL,
  tags TEXT[] DEFAULT '{}',
  metadata JSONB DEFAULT '{}'
);
-- UUID nativo, arrays PostgreSQL, JSONB para queries indexadas
```

---

## 2. 🔐 Auth (Autenticação)

```typescript
import { createClient } from '@supabase/supabase-js'

const supabase = createClient(SUPABASE_URL, SUPABASE_ANON_KEY)

// Login com email/senha
const { data, error } = await supabase.auth.signInWithPassword({
  email: 'user@example.com',
  password: 'senha123'
})

// Login com OAuth (Google)
const { data, error } = await supabase.auth.signInWithOAuth({
  provider: 'google',
  options: {
    redirectTo: 'https://meuapp.com/auth/callback'
  }
})

// Magic Link
const { data, error } = await supabase.auth.signInWithOtp({
  email: 'user@example.com',
  options: {
    emailRedirectTo: 'https://meuapp.com/auth/confirm'
  }
})

// MFA (Multi-Factor Authentication)
const { data, error } = await supabase.auth.mfa.enroll({
  factorType: 'totp',
  friendlyName: 'Meu Celular'
})

// Verificar código MFA
const { data, error } = await supabase.auth.mfa.verify({
  factorId: factorId,
  code: '123456'
})
```

### MELHORIA

❌ ERRADO:
```typescript
// Não armazene senhas ou tokens manualmente
const { data } = await supabase
  .from('users')
  .select('*')
  .eq('email', email)
// NUNCA autentique manualmente consultando a tabela de usuários
```

✅ CORRETO:
```typescript
// Sempre use a API de Auth do Supabase
const { data, error } = await supabase.auth.signInWithPassword({
  email,
  password
})
// O Supabase gerencia JWT, refresh tokens e sessão automaticamente
```

---

## 3. 📁 Storage (Arquivos)

```typescript
// Upload de arquivo
const { data, error } = await supabase.storage
  .from('avatars')
  .upload(`public/${userId}.jpg`, file, {
    contentType: 'image/jpeg',
    upsert: true
  })

// Download com transformação
const { data } = await supabase.storage
  .from('avatars')
  .download('public/user123.jpg')

// URL pública com transformação (resize)
const { data } = supabase.storage
  .from('avatars')
  .getPublicUrl('public/user123.jpg', {
    transform: {
      width: 200,
      height: 200,
      resize: 'cover'
    }
  })

// Listar arquivos com paginação
const { data, error } = await supabase.storage
  .from('documents')
  .list('user-folder/', {
    limit: 10,
    offset: 0,
    sortBy: { column: 'created_at', order: 'desc' }
  })
```

### MELHORIA

❌ ERRADO:
```typescript
// Não faça upload sem validação de tipo
await supabase.storage.from('files').upload(path, file)
// Aceita qualquer arquivo — risco de segurança
```

✅ CORRETO:
```typescript
const ALLOWED_TYPES = ['image/jpeg', 'image/png', 'application/pdf']
const MAX_SIZE = 5 * 1024 * 1024 // 5MB

if (!ALLOWED_TYPES.includes(file.type) || file.size > MAX_SIZE) {
  throw new Error('Arquivo não permitido')
}

await supabase.storage.from('files').upload(path, file, {
  contentType: file.type
})
// Valide tipo e tamanho antes do upload
```

---

## 4. ⚔️ Edge Functions (Deno)

```typescript
// supabase/functions/process-payment/index.ts
import { serve } from 'https://deno.land/std@0.177.0/http/server.ts'
import { createClient } from 'https://esm.sh/@supabase/supabase-js@2'

serve(async (req) => {
  // CORS
  if (req.method === 'OPTIONS') {
    return new Response('ok', {
      headers: {
        'Access-Control-Allow-Origin': '*',
        'Access-Control-Allow-Methods': 'POST',
        'Access-Control-Allow-Headers': 'authorization, x-client-info, apikey, content-type'
      }
    })
  }

  const { amount, currency } = await req.json()

  const supabase = createClient(
    Deno.env.get('SUPABASE_URL')!,
    Deno.env.get('SUPABASE_SERVICE_ROLE_KEY')!
  )

  // Processar pagamento
  const { data, error } = await supabase
    .from('payments')
    .insert({ amount, currency, status: 'pending' })
    .select()
    .single()

  return new Response(
    JSON.stringify({ payment: data }),
    {
      headers: {
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*'
      }
    }
  )
})
```

### MELHORIA

❌ ERRADO:
```typescript
// Não exponha SERVICE_ROLE_KEY no cliente
const supabase = createClient(url, 'eyJ...service_role_key...')
// SERVICE_ROLE bypassa RLS — só use no servidor
```

✅ CORRETO:
```typescript
// Use ANON_KEY no cliente, SERVICE_ROLE apenas em Edge Functions
// No servidor (Edge Function):
const supabase = createClient(
  Deno.env.get('SUPABASE_URL')!,
  Deno.env.get('SUPABASE_SERVICE_ROLE_KEY')!
)
// No cliente:
const supabase = createClient(url, anonKey)
```

---

## 5. 🔴 Realtime (Subscriptions)

```typescript
// Escutar mudanças em tempo real
const channel = supabase
  .channel('orders-changes')
  .on('postgres_changes', {
    event: '*',       // INSERT, UPDATE, DELETE
    schema: 'public',
    table: 'orders'
  }, (payload) => {
    console.log('Mudança detectada:', payload)
  })
  .subscribe()

// Presence (quem está online)
const presenceChannel = supabase.channel('online-users', {
  config: { presence: { key: userId } }
})

presenceChannel.on('presence', { event: 'sync' }, () => {
  const state = presenceChannel.presenceState()
  console.log('Usuários online:', state)
})

presenceChannel.track({
  user_id: userId,
  online_at: new Date().toISOString()
})

// Broadcast (mensagens rápidas)
const broadcastChannel = supabase.channel('chat-room')

broadcastChannel.send({
  type: 'broadcast',
  event: 'new-message',
  payload: { text: 'Olá!', user: userId }
})

broadcastChannel.on('broadcast', { event: 'new-message' }, ({ payload }) => {
  console.log('Nova mensagem:', payload)
})
```

### MELHORIA

❌ ERRADO:
```typescript
// Não esqueça de remover o channel quando não precisar
supabase.channel('chat').subscribe()
// Memory leak — o channel permanece ativo para sempre
```

✅ CORRETO:
```typescript
const channel = supabase.channel('chat')
channel.subscribe()

// Ao desmontar o componente ou parar de usar:
supabase.removeChannel(channel)
// Sempre limpe os channels para evitar memory leaks
```

---

## 6. 🤖 Vector/AI (pgvector + Embeddings)

```sql
-- Habilitar pgvector
CREATE EXTENSION IF NOT EXISTS vector;

-- Tabela de embeddings
CREATE TABLE documents (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  content TEXT NOT NULL,
  embedding VECTOR(1536), -- OpenAI ada-002
  metadata JSONB DEFAULT '{}',
  created_at TIMESTAMPTZ DEFAULT now()
);

-- Índice para busca por similaridade
CREATE INDEX idx_documents_embedding
  ON documents
  USING ivfflat (embedding vector_cosine_ops)
  WITH (lists = 100);

-- Busca por similaridade (cosine)
SELECT content,
  1 - (embedding <=> $1) AS similarity
FROM documents
ORDER BY embedding <=> $1
LIMIT 5;
```

```typescript
// Gerar embedding e buscar (RAG)
import OpenAI from 'openai'

const openai = new OpenAI()

async function searchDocuments(query: string) {
  // Gerar embedding da query
  const response = await openai.embeddings.create({
    model: 'text-embedding-ada-002',
    input: query
  })
  const queryEmbedding = response.data[0].embedding

  // Buscar documentos similares
  const { data } = await supabase.rpc('match_documents', {
    query_embedding: queryEmbedding,
    match_count: 5,
    match_threshold: 0.7
  })

  return data
}

// Stored function para busca
```

```sql
CREATE OR REPLACE FUNCTION match_documents(
  query_embedding VECTOR(1536),
  match_count INT DEFAULT 5,
  match_threshold FLOAT DEFAULT 0.5
)
RETURNS TABLE (
  id UUID,
  content TEXT,
  similarity FLOAT
)
LANGUAGE plpgsql
AS $$
BEGIN
  RETURN QUERY
  SELECT
    d.id,
    d.content,
    1 - (d.embedding <=> query_embedding) AS similarity
  FROM documents d
  WHERE 1 - (d.embedding <=> query_embedding) > match_threshold
  ORDER BY d.embedding <=> query_embedding
  LIMIT match_count;
END;
$$;
```

### MELHORIA

❌ ERRADO:
```sql
-- Não faça busca sem índice em tabelas grandes
SELECT * FROM documents
ORDER BY embedding <=> $1
LIMIT 5;
-- FULL TABLE SCAN — extremamente lento com milhões de linhas
```

✅ CORRETO:
```sql
-- Crie índice IVFFlat ou HNSW
CREATE INDEX idx_docs_embedding
  ON documents USING hnsw (embedding vector_cosine_ops)
  WITH (m = 16, ef_construction = 200);
-- HNSW é mais rápido que IVFFlat para buscas
```

---

## 7. 🔒 Row Level Security (RLS)

```sql
-- Habilitar RLS
ALTER TABLE orders ENABLE ROW LEVEL SECURITY;

-- Policy: usuário só vê seus pedidos
CREATE POLICY "users_view_own_orders"
  ON orders FOR SELECT
  USING (auth.uid() = user_id);

-- Policy: usuário pode criar pedidos para si
CREATE POLICY "users_create_own_orders"
  ON orders FOR INSERT
  WITH CHECK (auth.uid() = user_id);

-- Policy: admin vê tudo
CREATE POLICY "admins_view_all_orders"
  ON orders FOR SELECT
  USING (
    EXISTS (
      SELECT 1 FROM profiles
      WHERE profiles.id = auth.uid()
      AND profiles.role = 'admin'
    )
  );

-- Policy composta: updater só pode alterar seus pedidos pendentes
CREATE POLICY "users_update_own_pending_orders"
  ON orders FOR UPDATE
  USING (auth.uid() = user_id AND status = 'pending')
  WITH CHECK (auth.uid() = user_id);
```

### MELHORIA

❌ ERRADO:
```sql
-- Não esqueça de habilitar RLS
ALTER TABLE orders ENABLE ROW LEVEL SECURITY;
-- Se esquecer, TODOS podem acessar todas as linhas
-- Use ALWAYS para forçar RLS mesmo para service_role:
ALTER TABLE orders FORCE ROW LEVEL SECURITY;
```

✅ CORRETO:
```sql
-- Sempre force RLS em tabelas sensíveis
ALTER TABLE orders FORCE ROW LEVEL SECURITY;
-- Crie policies para cada operação (SELECT, INSERT, UPDATE, DELETE)
CREATE POLICY "select_policy" ON orders FOR SELECT USING (...);
CREATE POLICY "insert_policy" ON orders FOR INSERT WITH CHECK (...);
CREATE POLICY "update_policy" ON orders FOR UPDATE USING (...) WITH CHECK (...);
CREATE POLICY "delete_policy" ON orders FOR DELETE USING (...);
```

---

## 8. 🪝 Webhooks

```typescript
// Edge Function para processar webhook do Stripe
// supabase/functions/stripe-webhook/index.ts
import { serve } from 'https://deno.land/std@0.177.0/http/server.ts'
import { createClient } from 'https://esm.sh/@supabase/supabase-js@2'
import Stripe from 'https://esm.sh/stripe@12'

const stripe = new Stripe(Deno.env.get('STRIPE_SECRET_KEY')!)

serve(async (req) => {
  const signature = req.headers.get('stripe-signature')!
  const body = await req.text()

  let event
  try {
    event = stripe.webhooks.constructEvent(
      body,
      signature,
      Deno.env.get('STRIPE_WEBHOOK_SECRET')!
    )
  } catch (err) {
    return new Response(`Webhook error: ${err.message}`, { status: 400 })
  }

  const supabase = createClient(
    Deno.env.get('SUPABASE_URL')!,
    Deno.env.get('SUPABASE_SERVICE_ROLE_KEY')!
  )

  if (event.type === 'checkout.session.completed') {
    const session = event.data.object
    await supabase.from('orders').update({
      status: 'paid',
      stripe_session_id: session.id
    }).eq('stripe_session_id', session.id)
  }

  return new Response('ok', { status: 200 })
})
```

### MELHORIA

❌ ERRADO:
```typescript
// Não aceite webhooks sem verificar assinatura
const event = JSON.parse(body)
// Qualquer pessoa pode enviar requisições falsas
```

✅ CORRETO:
```typescript
// Sempre verifique a assinatura do webhook
const event = stripe.webhooks.constructEvent(body, signature, webhookSecret)
// Valide o HMAC/assinatura para garantir autenticidade
```

---

## 9. ⏰ Cron Jobs (pg_cron)

```sql
-- Habilitar pg_cron
CREATE EXTENSION IF NOT EXISTS pg_cron;

-- Job diário: limpar sessões expiradas
SELECT cron.schedule(
  'cleanup-expired-sessions',
  '0 3 * * *', -- Todo dia às 3h
  $$DELETE FROM user_sessions WHERE expires_at < now()$$
);

-- Job a cada 5 minutos: processar fila
SELECT cron.schedule(
  'process-job-queue',
  '*/5 * * * *',
  $$UPDATE jobs SET status = 'processing'
    WHERE id IN (
      SELECT id FROM jobs
      WHERE status = 'queued'
      AND scheduled_at <= now()
      LIMIT 10
    ) FOR UPDATE SKIP LOCKED$$
);

-- Job semanal: gerar relatório
SELECT cron.schedule(
  'weekly-report',
  '0 8 * * 1', -- Segunda às 8h
  $$SELECT generate_weekly_report()$$
);
```

### MELHORIA

❌ ERRADO:
```sql
-- Não execute queries pesadas em horário de pico
SELECT cron.schedule(
  'heavy-query',
  '*/1 * * * *', -- A cada minuto
  $$SELECT * FROM large_table$$
);
-- Sobrecarrega o banco continuamente
```

✅ CORRETO:
```sql
-- Agende em horários de baixo uso e com frequência adequada
SELECT cron.schedule(
  'light-maintenance',
  '0 3 * * 0', -- Domingo às 3h
  $$VACUUM ANALYZE large_table$$
);
-- Manutenção pesada em horário de baixo tráfego
```

---

## 10. 🔧 RPC (Stored Functions)

```sql
-- Função para buscar pedidos com paginação e filtro
CREATE OR REPLACE FUNCTION get_orders(
  p_status TEXT DEFAULT NULL,
  p_page INT DEFAULT 1,
  p_per_page INT DEFAULT 20
)
RETURNS TABLE (
  id UUID,
  total DECIMAL,
  status TEXT,
  created_at TIMESTAMPTZ,
  total_count BIGINT
)
LANGUAGE plpgsql
AS $$
DECLARE
  v_offset INT := (p_page - 1) * p_per_page;
BEGIN
  RETURN QUERY
  SELECT o.id, o.total, o.status, o.created_at,
    COUNT(*) OVER() AS total_count
  FROM orders o
  WHERE (p_status IS NULL OR o.status = p_status)
  ORDER BY o.created_at DESC
  LIMIT p_per_page
  OFFSET v_offset;
END;
$$;
```

```typescript
// Chamar via cliente
const { data, error } = await supabase.rpc('get_orders', {
  p_status: 'pending',
  p_page: 1,
  p_per_page: 20
})
```

### MELHORIA

❌ ERRADO:
```typescript
// Não use RPC sem tipagem
const { data } = await supabase.rpc('get_orders', {
  p_status: 123, // Tipo errado
  p_page: 'abc'  // Tipo errado
})
```

✅ CORRETO:
```typescript
// Defina tipos para as respostas RPC
interface Order {
  id: string
  total: number
  status: string
  created_at: string
  total_count: number
}

const { data, error } = await supabase.rpc('get_orders', {
  p_status: 'pending',
  p_page: 1,
  p_per_page: 20
}).returns<Order[]>()
```

---

## 11. 🌐 Client Libraries

```typescript
// JavaScript/TypeScript
import { createClient } from '@supabase/supabase-js'

const supabase = createClient(url, anonKey, {
  auth: {
    autoRefreshToken: true,
    persistSession: true,
    detectSessionInUrl: true
  },
  realtime: {
    params: {
      eventsPerSecond: 10
    }
  }
})

// Python
// from supabase import create_client
// supabase = create_client(url, anon_key)
// data = supabase.table('products').select('*').execute()

// Flutter/Dart
// final supabase = SupabaseClient(url, anonKey);
// final data = await supabase.from('products').select();
```

### MELHORIA

❌ ERRADO:
```typescript
// Não crie cliente Supabase a cada render
function MyComponent() {
  const supabase = createClient(url, key) // Recria a cada render!
}
```

✅ CORRETO:
```typescript
// Use singleton ou lazy initialization
let supabase: SupabaseClient | null = null

function getSupabase() {
  if (!supabase) {
    supabase = createClient(url, key)
  }
  return supabase
}
```

---

## 12. 📊 Dashboard & CLI

```bash
# Instalar CLI
supabase init

# Login
supabase login

# Criar projeto local
supabase start

# Gerar tipos TypeScript
supabase gen types typescript --local > database.types.ts

# Migrar banco
supabase db diff --use-migra
supabase db push

# Deploy Edge Functions
supabase functions deploy process-payment

# Logs em tempo real
supabase functions logs process-payment --follow
```

### MELHORIA

❌ ERRADO:
```bash
# Não deploye sem testar localmente primeiro
supabase functions deploy my-function
# Pode quebrar produção se houver erro
```

✅ CORRETO:
```bash
# Sempre teste local antes de deploy
supabase start
supabase functions serve my-function
# Teste, depois deploy
supabase functions deploy my-function --no-verify-jwt
```

---

## 13. 🔄 Branching (Preview Branches)

```bash
# Criar branch de preview
supabase branches create feature/new-auth

# Listar branches
supabase branches list

# Promover branch para produção
supabase branches merge feature/new-auth

# Deletar branch
supabase branches delete feature/old-branch
```

### MELHORIA

❌ ERRADO:
```bash
# Não faça migration direto na produção
supabase db push --db-url $PRODUCTION_URL
# Sempre use branches para testar mudanças
```

✅ CORRETO:
```bash
# Crie branch, teste, depois merge para produção
supabase branches create fix/add-index
supabase db diff --use-migra
supabase branches merge fix/add-index
# Merge controlado com versionamento
```

---

## 14. 📡 PartiQL (SQL + NoSQL)

```typescript
// Inserir dados flexíveis
const { data, error } = await supabase
  .from('events')
  .insert({
    user_id: userId,
    event_type: 'click',
    properties: {
      page: '/home',
      element: 'hero-cta',
      coordinates: { x: 120, y: 340 },
      metadata: {
        browser: 'Chrome',
        os: 'macOS',
        custom: ['tag1', 'tag2']
      }
    }
  })

// Query com JSONB
const { data } = await supabase
  .from('events')
  .select('*')
  .eq('properties->>page', '/home')
  .contains('properties->metadata', { browser: 'Chrome' })
```

### MELHORIA

❌ ERRADO:
```typescript
// Não use JSONB para dados estruturados que precisam de joins
await supabase.from('orders').insert({
  items: JSON.stringify([{ id: 1, qty: 2 }]) // String, não JSONB
})
```

✅ CORRETO:
```typescript
// Use JSONB nativo para dados semiestruturados
await supabase.from('orders').insert({
  items: [{ id: 1, qty: 2 }] // JSONB nativo — indexável
})
// Para dados relacionais, use tabelas separadas com foreign keys
```

---

## 15. 💾 Point-in-Time Recovery (PITR)

```bash
# Habilitar PITR no Supabase Dashboard
# Settings > Database > Point-in-Time Recovery

# Restaurar para timestamp específico
supabase db restore --time "2024-01-15T10:30:00Z"
```

### MELHORIA

❌ ERRADO:
```sql
-- Não faça DROP TABLE sem backup
DROP TABLE orders;
-- Dados perdidos permanentemente se não tiver PITR
```

✅ CORRETO:
```bash
# Sempre tenha PITR habilitado em produção
# E teste o restore periodicamente
supabase db restore --time "$(date -d '1 hour ago' -Iseconds)"
# Backup + restore testado = segurança real
```

---

## 16. 🔗 Integração Next.js

```typescript
// lib/supabase/server.ts
import { createServerClient } from '@supabase/ssr'
import { cookies } from 'next/headers'

export async function createClient() {
  const cookieStore = await cookies()

  return createServerClient(
    process.env.NEXT_PUBLIC_SUPABASE_URL!,
    process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY!,
    {
      cookies: {
        getAll() {
          return cookieStore.getAll()
        },
        setAll(cookiesToSet) {
          cookiesToSet.forEach(({ name, value, options }) => {
            cookieStore.set(name, value, options)
          })
        }
      }
    }
  )
}

// App Router: Server Component
export default async function Dashboard() {
  const supabase = await createClient()
  const { data: { user } } = await supabase.auth.getUser()

  const { data: orders } = await supabase
    .from('orders')
    .select('*')
    .eq('user_id', user?.id)
    .order('created_at', { ascending: false })

  return <OrderList orders={orders} />
}
```

### MELHORIA

❌ ERRADO:
```typescript
// Não use createClient do supabase-js no servidor Next.js
import { createClient } from '@supabase/supabase-js'
const supabase = createClient(url, key) // Sem cookies, sem auth
```

✅ CORRETO:
```typescript
// Use @supabase/ssr para integração correta com cookies
import { createServerClient } from '@supabase/ssr'
// Gerencia sessão via cookies automaticamente
```

---

## 17. 🛡️ Segurança & Best Practices

```sql
-- Criar role específica para a aplicação
CREATE ROLE app_role NOLOGIN;

-- Conceder permissões mínimas
GRANT SELECT, INSERT, UPDATE ON orders TO app_role;
GRANT USAGE ON ALL SEQUENCES IN SCHEMA public TO app_role;

-- Usar search_path seguro
ALTER DATABASE postgres SET search_path TO public;

-- Habilitar audit logging
CREATE EXTENSION IF NOT EXISTS pgaudit;
ALTER SYSTEM SET pgaudit.log = 'write, ddl';
SELECT pg_reload_conf();
```

### MELHORIA

❌ ERRADO:
```sql
-- Não use superuser para a aplicação
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO postgres;
-- Acesso total ao banco — risco extremo
```

✅ CORRETO:
```sql
-- Use least privilege principle
CREATE ROLE app_reader NOLOGIN;
CREATE ROLE app_writer NOLOGIN;
GRANT SELECT ON products TO app_reader;
GRANT SELECT, INSERT, UPDATE ON orders TO app_writer;
-- Cada role com permissões mínimas necessárias
```

---

## 📋 Resumo das Skills

| # | Skill | Dificuldade |
|---|-------|-------------|
| 1 | Database (PostgreSQL) | ⭐⭐⭐ |
| 2 | Auth | ⭐⭐ |
| 3 | Storage | ⭐⭐ |
| 4 | Edge Functions | ⭐⭐⭐ |
| 5 | Realtime | ⭐⭐⭐ |
| 6 | Vector/AI (pgvector) | ⭐⭐⭐⭐ |
| 7 | RLS | ⭐⭐⭐ |
| 8 | Webhooks | ⭐⭐⭐ |
| 9 | Cron Jobs | ⭐⭐ |
| 10 | RPC | ⭐⭐ |
| 11 | Client Libraries | ⭐⭐ |
| 12 | Dashboard & CLI | ⭐ |
| 13 | Branching | ⭐⭐ |
| 14 | PartiQL | ⭐⭐⭐ |
| 15 | Point-in-Time Recovery | ⭐⭐ |
| 16 | Integração Next.js | ⭐⭐⭐ |
| 17 | Segurança & Best Practices | ⭐⭐⭐⭐ |
