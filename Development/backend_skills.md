# Documentação Completa: Skills de Backend (40 Skills)

**Data de Criação:** 13 de Setembro de 2026  
**Total de Skills:** 40 especializadas  
**Categoria:** Backend Development

---

## Sumário

| # | Skill | Descrição | Uso Principal |
|---|-------|-----------|---------------|
| 1 | api-analyzer | Validação de requisições API | Debug e verificação de chamadas API |
| 2 | api-and-interface-design | Design de APIs e interfaces estáveis | Criação de contratos e endpoints |
| 3 | api-design-principles | Princípios de design REST/GraphQL | Definição de padrões de API |
| 4 | api-designer | Geração de especificações REST completas | Criação de endpoints production-ready |
| 5 | api-documentation-generator | Geração de documentação API | Documentação interativa e completa |
| 6 | api-documenter | Documentação com OpenAPI 3.1 e IA | Portais de desenvolvedor e SDKs |
| 7 | api-fuzzing-bug-bounty | Testes de segurança API | Bug bounty e pentest |
| 8 | api-integration | Arquiteturas event-driven e webhooks | Integração entre serviços |
| 9 | api-onboarding | Redução de TTFAC (Time to First Call) | Onboarding de desenvolvedores |
| 10 | api-patterns | Padrões REST vs GraphQL vs tRPC | Decisões de design de API |
| 11 | api-sdk-generator | Geração de SDKs client | Bibliotecas de cliente multi-linguagem |
| 12 | api-security | Testes de segurança de APIs | Avaliação autorizada de segurança |
| 13 | api-security-best-practices | Padrões seguros de design de API | Implementação de autenticação/autorização |
| 14 | api-testing-observability-api-mock | Mock services realistas | Desenvolvimento e testes paralelos |
| 15 | appdeploy | Deploy de aplicações web | Publicação com URL pública |
| 16 | atlas-contract | Governança de integridade de objetivos | Backend/API com preservação de estado |
| 17 | backend-architect | Arquiteto backend escalável | Arquitetura de microserviços |
| 18 | backend-dev-guidelines | Diretrizes de backend Node.js | Desenvolvimento production-grade |
| 19 | backend-development-feature-development | Orquestração de features end-to-end | Coordenação multi-equipe |
| 20 | backend-security-coder | Código seguro de backend | Implementação de segurança |
| 21 | cohesivity | Backend headless para agentes IA | Provisionamento de infraestrutura |
| 22 | comfyui-gateway | API gateway para ComfyUI | Geração de imagens com IA |
| 23 | copilot-sdk | SDK do GitHub Copilot | Interação programática com Copilot |
| 24 | django-access-review | Revisão de controle de acesso Django | Auditoria de autorização IDOR |
| 25 | django-perf-review | Revisão de performance Django | Otimização de queries N+1 |
| 26 | dotnet-backend | ASP.NET Core 8+ | Backend enterprise .NET |
| 27 | dotnet-backend-patterns | Padrões C#/.NET modernos | APIs production-grade .NET |
| 28 | fastapi-router-py | Routers FastAPI Python | API Python com autenticação |
| 29 | graphql | GraphQL completo | Schema, resolvers, federation |
| 30 | hono | Framework web ultra-rápido | APIs edge/serverless |
| 31 | junta-leiloeiros | Dados de leiloeiros brasileiros | Scraper de Juntas Comerciais |
| 32 | neon-postgres | Neon Serverless Postgres | Database serverless |
| 33 | nodejs-backend-patterns | Padrões Node.js escaláveis | Microserviços e APIs |
| 34 | pubmed-database | Acesso PubMed via REST | Literatura biomédica |
| 35 | telegram | Integração Telegram Bot API | Chatbots e mensagens |
| 36 | uniprot-database | Acesso UniProt via REST | Dados de proteínas |
| 37 | upstash-ratelimit | Rate limiting distribuído | Controle de abuso em APIs |
| 38 | upstash-redis | Cliente HTTP Redis | Cache e sessões serverless |
| 39 | whatsapp-cloud-api | WhatsApp Business Cloud API | Mensagens e automação |
| 40 | x402-express-wrapper | Wrapper de pagamentos x402 | Monetização máquina-a-máquina |

---

## 1. api-analyzer

**Descrição:** Valida se uma requisição API está correta baseada em inputs fornecidos (método, URL, headers, body, auth, query params).

**Quando usar:**
- Verificar, validar, debugar ou verificar uma chamada API
- Usuário cola um comando curl ou mostra detalhes de endpoint
- Pergunta "isso está correto?" sobre uma requisição

**Exemplo prático:**
```bash
# Entrada do usuário:
GET /users/123 — Header: Authorization: Bearer abc123

# Resposta da skill:
Looks correct.

# Entrada com erro:
POST /checkout — no body, no headers

# Resposta:
Is there a request body? POST to /checkout typically requires one.
```

---

## 2. api-and-interface-design

**Descrição:** Guia design estável de APIs e interfaces. Aplicável a REST, GraphQL, schemas de componentes e contratos entre módulos.

**Quando usar:**
- Projetando novos endpoints de API
- Definindo limites de módulos ou contratos entre equipes
- Criando interfaces de props de componentes
- Estabelecendo schemas de banco de dados que informam a forma da API

**Exemplo prático:**
```typescript
// Definir contrato primeiro
interface TaskAPI {
  createTask(input: CreateTaskInput): Promise<Task>;
  listTasks(params: ListTasksParams): Promise<PaginatedResult<Task>>;
  getTask(id: string): Promise<Task>;
  updateTask(id: string, input: UpdateTaskInput): Promise<Task>;
  deleteTask(id: string): Promise<void>;
}

// Validação na fronteira da API
app.post('/api/tasks', async (req, res) => {
  const result = CreateTaskSchema.safeParse(req.body);
  if (!result.success) {
    return res.status(422).json({
      error: { code: 'VALIDATION_ERROR', details: result.error.flatten() }
    });
  }
  const task = await taskService.create(result.data);
  return res.status(201).json(task);
});
```

---

## 3. api-design-principles

**Descrição:** Domine princípios de design de APIs REST e GraphQL para construir APIs intuitivas, escaláveis e maintainable.

**Quando usar:**
- Projetando novas APIs REST ou GraphQL
- Refatorando APIs existentes
- Estabelecendo padrões de design para a equipe
- Revisando especificações antes da implementação
- Migrando entre paradigmas (REST para GraphQL)

**Exemplo prático:**
1. Definir consumidores, casos de uso e restrições
2. Escolher estilo do API e modelar recursos
3. Especificar erros, versionamento, paginação e estratégia de auth
4. Validar com exemplos e revisar consistência

---

## 4. api-designer

**Descrição:** Gera especificações completas e production-ready de endpoints REST para qualquer sistema ou domínio.

**Quando usar:**
- Usuário pergunta sobre design de API, endpoints, REST APIs
- "Quais endpoints eu preciso para..."
- "Projete uma API para..."

**Exemplo prático:**
```
RESOURCE: Users
METHOD: POST /api/v1/users
Descrição: Cria um novo usuário

Headers:
| Header | Value | Required |
|--------|-------|----------|
| Content-Type | application/json | Yes |
| Authorization | Bearer <token> | Yes |

Request Body:
{
  "name": "string — nome completo",
  "email": "string — email válido",
  "password": "string — mínimo 8 caracteres"
}

Success Response — 201 Created:
{
  "id": "usr_1234567890",
  "name": "João Silva",
  "email": "joao@example.com",
  "createdAt": "2026-01-20T10:30:00Z"
}
```

---

## 5. api-documentation-generator

**Descrição:** Gera documentação abrangente e amigável para desenvolvedores a partir do código, incluindo endpoints, parâmetros, exemplos e melhores práticas.

**Quando usar:**
- Documentar uma nova API
- Atualizar documentação existente
- Preparar documentação para usuários externos
- Criar especificações OpenAPI/Swagger

**Exemplo prático:**
```markdown
## Criar Usuário
Cria uma nova conta de usuário.

**Endpoint:** `POST /api/v1/users`
**Autenticação:** Obrigatória (Bearer token)

**Request Body:**
{
  "email": "user@example.com",     // Obrigatório
  "password": "SecurePass123!",    // Obrigatório
  "name": "João Silva"             // Obrigatório
}

**Exemplo (cURL):**
curl -X POST https://api.example.com/api/v1/users \
  -H "Authorization: Bearer YOUR_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"email":"user@example.com","password":"SecurePass123!","name":"João Silva"}'
```

---

## 6. api-documenter

**Descrição:** Especialista em documentação de APIs moderna usando OpenAPI 3.1+, ferramentas IA e práticas de DX.

**Quando usar:**
- Criar ou atualizar especificações OpenAPI/AsyncAPI
- Construir portais de desenvolvedor
- Gerar SDKs a partir de specs
- Melhorar qualidade da documentação

**Capacidades:**
- OpenAPI 3.1+ com recursos avançados
- Ferramentas de IA (Mintlify, ReadMe AI)
- Swagger UI e Redoc customizados
- Geração de SDK multi-linguagem
- Autenticação OAuth 2.0/OpenID Connect

---

## 7. api-fuzzing-bug-bounty

**Descrição:** Técnicas abrangentes para testar APIs REST, SOAP e GraphQL durante bug bounty e pentest.

**⚠️ USO AUTORIZADO APENAS** — Requer permissão explícita por escrito.

**Quando usar:**
- Assessment de segurança autorizado
- Testing de autenticação/autorização
- Exploração de IDOR/BOLA
- Fuzzing de endpoints

**Exemplo prático:**
```bash
# Teste IDOR básico
GET /api/users/1234 → GET /api/users/1235

# SQL Injection em JSON
{"id":"56456 AND 1=1#"} → OK
{"id":"56456 AND 1=2#"} → ERROR (vulnerável!)

# GraphQL Introspection
{__schema{queryType{name},types{name,fields{name}}}}
```

---

## 8. api-integration

**Descrição:** Projeta arquiteturas event-driven, sistemas de webhooks, fluxos de API chaining, ETL e padrões de integração entre serviços.

**Quando usar:**
- Webhooks, event streaming, composição de APIs
- Conectando duas ou mais APIs
- Construindo pipelines, Pub/Sub, Kafka topics
- ETL e processamento de dados

**Exemplo prático:**
```json
// Padrão Webhook
POST {subscriber_url}
Headers:
  X-Webhook-Signature: hmac-sha256=<sig>
  X-Webhook-Event: order.created

// Saga Pattern (transação distribuída)
1. orders-svc emite order.created
2. inventory-svc reserva estoque → emite inventory.reserved
3. payments-svc cobra cartão → emite payment.completed
4. orders-svc emite order.confirmed
```

---

## 9. api-onboarding

**Descrição:** Reduz o Time-to-First-API-Call (TTFAC) otimizando cada etapa da jornada de onboarding do desenvolvedor.

**Quando usar:**
- Otimizar experiência do desenvolvedor ao usar sua API
- Reduzir fricção no onboarding
- Melhorar métricas de adoção

**Benchmark TTFAC:**
| Classificação | TTFAC | Experiência |
|---------------|-------|-------------|
| Excelente | < 5 min | "Isso é incrível" |
| Bom | 5-15 min | "Bem direto" |
| Aceitável | 15-30 min | "Consegui no fim" |
| Ruim | 30-60 min | "Frustrante" |

---

## 10. api-patterns

**Descrição:** Princípios de design de API e tomada de decisão. Seleção REST vs GraphQL vs tRPC, formatos de resposta, versionamento, paginação.

**Quando usar:**
- Definindo contrato de novo endpoint
- Selecionando REST/GraphQL/tRPC para consumidores conhecidos
- Mudando paginação, erros, autenticação ou comportamento de compatibilidade

**Checklist de decisão:**
- [ ] Perguntou sobre consumidores da API?
- [ ] Escolheu estilo de API para ESTE contexto?
- [ ] Definiu formato de resposta consistente?
- [ ] Planejou estratégia de versionamento?
- [ ] Considerou necessidades de autenticação?
- [ ] Planejou rate limiting?
- [ ] Definiu abordagem de documentação?

---

## 11. api-sdk-generator

**Descrição:** Gera código de SDK client, bibliotecas wrapper de API, modelos de request/response e padrões de uso específicos para cada linguagem.

**Quando usar:**
- "Gere um SDK"
- "Escreva uma biblioteca client"
- "Crie wrappers de API"
- "Gere tipos TypeScript da minha API"

**Exemplo prático (Python):**
```python
class APIClient:
    def __init__(self, api_key: str, base_url: str = "https://api.example.com/v1"):
        self._headers = {
            "Authorization": f"Bearer {api_key}",
            "Content-Type": "application/json",
        }

class UsersResource:
    def list(self, page: int = 1, limit: int = 20) -> List[User]:
        data = self._client._request("GET", f"/users?page={page}&limit={limit}")
        return [User(**u) for u in data["data"]]
```

---

## 12. api-security

**Descrição:** Assessment de segurança autorizado de APIs REST, GraphQL, WebSocket e SOAP: discovery, flaws de autenticação/autorização, testes de rate-limit.

**⚠️ USO AUTORIZADO APENAS**

**Quando usar:**
- Assessment de segurança autorizado
- Testes de autenticação, autorização ou rate-limiting
- Escopo aprovado definido

**Fluxo de 10 fases:**
1. API Discovery e Reconhecimento
2. Testes de Autenticação (JWT, OAuth)
3. Testes de Autorização (BOLA/IDOR/BFLA)
4. GraphQL Específico
5. Validação de Input REST
6. Lógica de Negócio e Testes Diferenciais
7. Testes WebSocket
8. Rate Limit e DoS
9. Exposição de Dados
10. Integração CI/CD

---

## 13. api-security-best-practices

**Descrição:** Implemente padrões seguros de design de API incluindo autenticação, autorização, validação de input, rate limiting e proteção contra vulnerabilidades.

**Quando usar:**
- Adicionando endpoint protegido
- Revisando acesso a objetos
- Substituindo parsing permissivo
- Investigando caminho de abuso

**5 áreas principais:**
1. Autenticar contrato exato do token
2. Autorizar recurso e operação
3. Parse uma vez, usar valor validado
4. Controlar abuso sem proteção DDoS
5. Senhas, segredos e logging

---

## 14. api-testing-observability-api-mock

**Descrição:** Expert em mocking de APIs realistas para desenvolvimento, testes e demonstrações.

**Quando usar:**
- Construir mocks de API para testes frontend/integração
- Simular APIs de parceiros durante desenvolvimento
- Criar ambientes de demo com respostas realistas
- Validar contratos antes da conclusão do backend

**Exemplo prático:**
```yaml
# Definir rotas mock e cenários
routes:
  - path: /api/users
    method: GET
    response:
      status: 200
      body:
        - id: 1
          name: "Alice (Test)"
        - id: 2
          name: "Bob (Test)"
```

---

## 15. appdeploy

**Descrição:** Deploy de apps web com backend APIs, banco de dados e armazenamento de arquivos via HTTP API.

**Quando usar:**
- Usuário pede para "deployar", "publicar" ou "dar uma URL"
- Atualizar app já deployado
- Planejar ou construir apps web

**Workflow:**
1. `get_deploy_instructions` — entender restrições
2. `get_app_template` — obter template
3. `deploy_app` — fazer deploy
4. `get_app_status` — verificar status

---

## 16. atlas-contract

**Descrição:** Skill de integridade de objetivos. Use para backend/API/persistência, preserve/não-altere, testes/validação, mocks, rework.

**Quando usar:**
- Tarefas com risco de backend, preservação, dados, testes ou fidelidade
- Requer governança de fases (máximo 4 fases)
- Multi-requisitos com validação

**Critérios de risco:**
1. Backend — backend/API/database/persistência
2. Preserve — manter comportamento existente
3. Data — integridade de dados/schema/estado compartilhado
4. Tests — testes/validação/critérios de aceitação
5. Fidelity — imagem de referência/layout/estrutura

---

## 17. backend-architect

**Descrição:** Arquiteto backend especializado em design escalável de APIs, arquitetura de microserviços e sistemas distribuídos.

**Quando usar:**
- Projetando novos serviços ou APIs backend
- Definindo limites de serviços, contratos de dados
- Planejando resiliência, escalabilidade e observabilidade

**Capacidades:**
- RESTful APIs, GraphQL, gRPC, WebSocket, SSE
- Microserviços: service discovery, API gateway, service mesh
- Event-driven: RabbitMQ, Kafka, Kinesis, NATS
- Auth: OAuth 2.0, OpenID Connect, JWT, mTLS, RBAC
- Resiliência: circuit breaker, retry, timeout, bulkhead
- Observabilidade: logging, metrics, tracing, APM

---

## 18. backend-dev-guidelines

**Descrição:** Engenheiro backend sênior operando serviços production-grade com restrições arquiteturais e de confiabilidade estritas.

**Quando usar:**
- Routes, controllers, services, repositories
- Express middleware, Prisma database access
- Validação Zod, Sentry error tracking
- Refactors ou migrações backend

**Arquitetura em camadas (obrigatória):**
```
Routes → Controllers → Services → Repositories → Database
```

**Regras:**
- Routes apenas roteiam (zero lógica de negócio)
- Controllers coordenam, Services decidem
- Todos os errors vão para Sentry
- unifiedConfig é a única fonte de configuração
- Validar todo input externo com Zod

---

## 19. backend-development-feature-development

**Descrição:** Orquestre desenvolvimento end-to-end de features backend, desde requisitos até deploy em produção.

**Quando usar:**
- Coordenando entrega de features entre backend, frontend e dados
- Gerenciando requisitos, arquitetura, implementação, testes e rollout
- Planejando mudanças multi-serviço

**4 Fases:**
1. **Discovery & Requirements** — Análise de negócio, arquitetura técnica, avaliação de risco
2. **Implementation** — Backend services, frontend, data pipelines
3. **Testing** — Suite de testes, validação de segurança, otimização
4. **Deployment** — CI/CD, observabilidade, documentação

---

## 20. backend-security-coder

**Descrição:** Expert em práticas seguras de codificação backend, especializado em validação de input, autenticação e segurança de APIs.

**Quando usar:**
- Implementação de segurança backend
- Revisão de código de segurança
- Prevenção de vulnerabilidades

**Capacidades:**
- Validação e sanitização de input
- Prevenção de ataques de injeção (SQL, NoSQL, LDAP, command)
- Headers de segurança HTTP e cookies
- Proteção CSRF
- Segurança de banco de dados (queries parametrizadas)
- Segurança de APIs (autenticação, autorização, rate limiting)
- Logging e monitoramento de segurança

---

## 21. cohesivity

**Descrição:** Provisiona serviços backend headless para agentes IA via Cohesivity: hosting, databases, storage, LLMs e APIs de terceiros via uma HTTP API.

**Quando usar:**
- Usuário descreve novo app que precisa de backend
- Projeto precisa de serviço no meio do build
- Arquivo `.cohesivity` já existe e é confiável

**Recursos disponíveis:** postgres, redis, object-storage, vector-database, inbox, railway-hosting, cloudflare-workers, realtime, social-login, openai-api, ai-gateway, deepgram-api, exa-api, steel-browser

---

## 22. comfyui-gateway

**Descrição:** API gateway REST para servidores ComfyUI. Gestão de workflows, fila de jobs, webhooks, cache, auth, rate limiting e entrega de imagens.

**Quando usar:**
- Integrar com ComfyUI para geração de imagens
- Criar gateway seguro e escalável para Stable Diffusion
- Gerenciar filas de processamento de imagens

**Endpoints principais:**
```
GET    /workflows        → listar workflows
POST   /jobs             → criar job
GET    /jobs/:jobId      → status + progresso
GET    /outputs/:jobId   → arquivos gerados
```

---

## 23. copilot-sdk

**Descrição:** Construa apps que interagem programaticamente com o GitHub Copilot. SDK envolve CLI do Copilot via JSON-RPC.

**Quando usar:**
- Construir aplicações que utilizam GitHub Copilot
- Gerenciar sessões, tools customizadas e hooks
- Integração com MCP server

**Pré-requisitos:**
- GitHub Copilot CLI instalado e autenticado
- Assinatura GitHub Copilot
- Runtime: Node.js 18+ / Python 3.8+ / Go 1.21+ / .NET 8.0+

---

## 24. django-access-review

**Descrição:** Revisão de controle de acesso e IDOR em Django. Investigação de views, viewsets DRF, queries ORM.

**Quando usar:**
- Revisar código Django/DRF para gaps de controle de acesso
- Verificar se Usuário A pode acessar dados do Usuário B
- Auditoria de autorização a nível de objeto

**Abordagem:**
1. **Fase 1:** Entender modelo de autorização do codebase
2. **Fase 2:** Mapear superfície de ataque
3. **Fase 3:** Perguntar e investigar ("Se sou User A e conheço o ID do recurso de User B, posso acessá-lo?")
4. **Fase 4:** Rastrear fluxos específicos
5. **Fase 5:** Reportar achados com evidências

---

## 25. django-perf-review

**Descrição:** Revisão de performance de código Django. Foco em issues validadas de ORM e queries.

**Quando usar:**
- "Revise performance Django"
- "Encontre queries N+1"
- "Otimize Django"
- "Verifique performance de queryset"

**Prioridades:**
| Prioridade | Categoria | Impacto |
|------------|-----------|---------|
| 1 | N+1 Queries | CRÍTICO |
| 2 | Querysets Não Limitados | CRÍTICO |
| 3 | Índices Ausentes | ALTO |
| 4 | Loops de Escrita | ALTO |
| 5 | Padrões Ineficientes | BAIXO |

---

## 26. dotnet-backend

**Descrição:** Construa serviços backend ASP.NET Core 8+ com EF Core, auth, background jobs e padrões API de produção.

**Quando usar:**
- Construir ou refatorar APIs ASP.NET Core
- Implementar autenticação/autorização em .NET
- Projetar ou otimizar padrões de acesso a dados EF Core
- Adicionar workers, jobs agendados em C#

**Padrão Minimal API:**
```csharp
app.MapPost("/api/users", async (CreateUserRequest request, AppDbContext db) =>
{
    var user = new User { Email = request.Email, Name = request.Name };
    db.Users.Add(user);
    await db.SaveChangesAsync();
    return Results.Created($"/api/users/{user.Id}", new UserResponse(user));
});
```

---

## 27. dotnet-backend-patterns

**Descrição:** Domine padrões C#/.NET para construir APIs, MCP servers e backends enterprise com melhores práticas modernas.

**Quando usar:**
- Desenvolvendo novas .NET Web APIs ou MCP servers
- Revisando código C# para qualidade e performance
- Projetando arquiteturas com dependency injection
- Implementando caching com Redis
- Otimizando acesso a banco com EF Core ou Dapper

---

## 28. fastapi-router-py

**Descrição:** Crie routers FastAPI seguindo padrões estabelecidos com autenticação, response models e HTTP status codes.

**Quando usar:**
- Criar novos endpoints FastAPI
- Implementar autenticação em rotas Python
- Definir response models Pydantic

**Exemplo prático:**
```python
@router.get("/items/{item_id}", response_model=Item)
async def get_item(item_id: str) -> Item:
    ...

@router.post("/items", status_code=status.HTTP_201_CREATED)
async def create_item(item: CreateItem) -> Item:
    ...
```

---

## 29. graphql

**Descrição:** GraphQL fornece exatamente os dados que os clientes precisam — nem mais nem menos. Um endpoint, schema tipado, introspecção.

**Quando usar:**
- Relações complexas de dados e necessidades diversas de clientes
- Quando REST não atende a necessidade de dados flexíveis
- Construção de APIs com subscriptions em tempo real

**⚠️ Quando NÃO usar:**
- CRUD simples (REST é mais simples)
- APIs públicas de alta performance (REST com cache vence)

---

## 30. hono

**Descrição:** Construa APIs web ultra-rápidas e apps full-stack com Hono — roda em Cloudflare Workers, Deno, Bun, Node.js e qualquer runtime WinterCG.

**Quando usar:**
- Construir API REST ou RPC para edge
- BFF com requisitos de baixa latência
- Migrando do Express com melhor suporte TypeScript
- Apps serverless e edge

**Exemplo prático:**
```typescript
import { Hono } from 'hono';

const app = new Hono();

app.get('/users', c => c.json({ users: [] }));
app.post('/users', c => c.json({ created: true }, 201));

// Validação com Zod
app.post('/posts', zValidator('json', createPostSchema), async c => {
  const data = c.req.valid('json');
  return c.json(data, 201);
});
```

---

## 31. junta-leiloeiros

**Descrição:** Coleta e consulta dados de leiloeiros oficiais de todas as 27 Juntas Comerciais do Brasil. Scraper multi-UF, banco SQLite, API FastAPI.

**Quando usar:**
- Pesquisar leiloeiros oficiais por estado
- Consultar dados de Juntas Comerciais
- Exportar dados de leiloeiros em CSV/JSON

**Exemplo prático:**
```bash
# Coletar dados de todos os estados
python scripts/run_all.py

# API REST
GET /leiloeiros?estado=SP&situacao=ATIVO&nome=silva&limit=100
GET /busca?q=texto
GET /stats
```

---

## 32. neon-postgres

**Descrição:** Guias e melhores práticas para trabalhar com Neon Serverless Postgres. Setup, branching, autoscaling, scale-to-zero, read replicas.

**Quando usar:**
- Configurar Neon Serverless Postgres
- Trabalhar com branching de banco
- Otimizar custos com scale-to-zero
- Configurar read replicas
- Connection pooling em ambientes serverless

**Driver recomendado por runtime:**
- **Long-running/shared-runtime** → node-postgres (`pg`)
- **Serverless isolado (Lambda-style)** → `@neondatabase/serverless`

---

## 33. nodejs-backend-patterns

**Descrição:** Orientação abrangente para construir aplicações Node.js escaláveis, maintainable e production-ready com frameworks modernos.

**Quando usar:**
- Construir APIs REST ou servidores GraphQL
- Criar microserviços com Node.js
- Implementar autenticação e autorização
- Projetar arquiteturas escaláveis
- Configurar middleware e tratamento de erros
- Integrar bancos de dados SQL e NoSQL
- Aplicações real-time com WebSockets
- Processamento de jobs em background

---

## 34. pubmed-database

**Descrição:** Acesso direto REST ao PubMed. Consultas Boolean/MeSH avançadas, E-utilities API, processamento em lote, gerenciamento de citações.

**Quando usar:**
- Buscar artigos de pesquisa biomédica
- Construir consultas complexas com operadores Boolean
- Conducting systematic literature reviews
- Acessar dados PubMed programaticamente via API

**Exemplo prático:**
```python
import requests

# Buscar artigos
response = requests.get(
    "https://eutils.ncbi.nlm.nih.gov/entrez/eutils/esearch.fcgi",
    params={
        "db": "pubmed",
        "term": "diabetes[tiab] AND 2024[dp]",
        "retmax": 100,
        "retmode": "json"
    }
)
pmids = response.json()["esearchresult"]["idlist"]
```

---

## 35. telegram

**Descrição:** Integração completa com Telegram Bot API. Setup com BotFather, mensagens, webhooks, inline keyboards, grupos, canais.

**Quando usar:**
- Criar ou gerenciar bots Telegram
- Configurar webhooks para receber mensagens
- Enviar mensagens, inline keyboards
- Integrar com grupos e canais

---

## 36. uniprot-database

**Descrição:** Acesso direto REST ao UniProt. Busca de proteínas, recuperação FASTA, mapeamento de IDs, Swiss-Prot/TrEMBL.

**Quando usar:**
- Buscar entradas de proteínas por nome, gene ou accession
- Recuperar sequências em formato FASTA
- Mapear identificadores entre UniProt e bancos externos
- Acessar anotações de proteínas (GO terms, domínios)

**Exemplo prático:**
```python
# Buscar proteínas
query = "insulin AND organism_name:\"Homo sapiens\""
url = f"https://rest.uniprot.org/uniprotkb/search?query={query}&format=json"
```

---

## 37. upstash-ratelimit

**Descrição:** Adicione rate limiting a rotas API, middleware e edge functions com @upstash/ratelimit: sliding window, fixed window e token bucket.

**Quando usar:**
- Limitar requisições por IP, usuário, API key ou tenant
- Proteger endpoints de login, signup, formulário, webhook ou LLM
- Escolher entre fixed window, sliding window e token bucket

**Exemplo prático:**
```typescript
import { Ratelimit } from "@upstash/ratelimit";
import { Redis } from "@upstash/redis";

const ratelimit = new Ratelimit({
  redis: Redis.fromEnv(),
  limiter: Ratelimit.slidingWindow(10, "10 s"),
  prefix: "rl:api",
});

const { success, limit, remaining, reset } = await ratelimit.limit(userId);
```

---

## 38. upstash-redis

**Descrição:** Use o cliente HTTP @upstash/redis para caching, sessões, contadores e estruturas de dados Redis em runtimes serverless e edge.

**Quando usar:**
- Cache, session store, counter, leaderboard ou fila simples
- Runtime serverless (Vercel, Netlify, Cloudflare Workers)
- Migrar de ioredis/node-redis para runtimes sem TCP pooling

**Exemplo prático:**
```typescript
import { Redis } from "@upstash/redis";

const redis = Redis.fromEnv();

// Cache-aside com TTL
export async function getUser(id: string) {
  const cached = await redis.get<User>(`user:${id}`);
  if (cached) return cached;

  const user = await db.users.findById(id);
  await redis.set(`user:${id}`, user, { ex: 3600 });
  return user;
}
```

---

## 39. whatsapp-cloud-api

**Descrição:** Integração com WhatsApp Business Cloud API (Meta). Mensagens, templates, webhooks HMAC-SHA256, automação de atendimento.

**Quando usar:**
- Enviar/receber mensagens via WhatsApp Business
- Configurar webhooks com segurança HMAC
- Automatizar atendimento com chatbots
- Gerenciar templates aprovados

**Pricing 2026:**
| Categoria | Custo |
|-----------|-------|
| Marketing | $0.025-$0.1365 |
| Utility | $0.004-$0.0456 |
| Authentication | $0.004-$0.0456 |
| Service | GRATIS (24h window) |

**Exemplo prático:**
```typescript
async function sendText(to: string, message: string) {
  return axios.post(
    `${GRAPH_API}/${process.env.PHONE_NUMBER_ID}/messages`,
    {
      messaging_product: 'whatsapp',
      to,
      type: 'text',
      text: { body: message }
    },
    { headers: { Authorization: `Bearer ${process.env.WHATSAPP_TOKEN}` } }
  );
}
```

---

## 40. x402-express-wrapper

**Descrição:** Wrapper oficial M2MCent (Node.js) para injetar muros de pagamento x402 em APIs ou servidores Model Context Protocol (MCP).

**Quando usar:**
- Adicionar barreira de pagamento à API
- Monetizar servidor MCP
- Exigir micropagos em USDC por uso de endpoint

**Exemplo prático:**
```javascript
const x402 = new X402Wrapper({
    rpcUrl: "https://mainnet.base.org",
    privateKey: process.env.RELAYER_PRIVATE_KEY,
    recipient: process.env.MY_WALLET_ADDRESS
});

app.get('/api/premium', x402.requirePayment("20000"), (req, res) => {
    res.json({ data: "Informação Premium", receipt: req.paymentTx });
});
```

---

## Arquivos Consultados

- `C:\Users\Alendaviva007\.config\opencode\skills\backend-category-pointer\SKILL.md`
- `C:\Users\Alendaviva007\.config\opencode\skill-libraries\backend\{skill-name}\SKILL.md` (40 arquivos)

## Verificação Realizada

- Todos os 40 SKILL.md foram lidos e analisados
- Informações extraídas diretamente dos arquivos fonte
- Nenhuma informação foi inventada ou extrapolada
- Exemplos práticos foram selecionados dos próprios SKILL.md

## Limitações

- Alguns skills possuem referências internas (`resources/`, `references/`) que não foram lidas por kompleto
- Skills com `risk: offensive` requerem autorização explícita para uso
- Alguns skills são ponteiros para bibliotecas externas e possuem dependências específicas
- A documentação é baseada na versão dos skills disponível em 13/09/2026
