# 🔧 Coding & Development Skills - 10.000 Skills

> **Todas as habilidades de programação documentadas e melhoradas**

---

## 📊 Visão Geral

| Subcategoria | Skills | Nível |
|--------------|--------|-------|
| Frontend | 1.500 | Básico → Expert |
| Backend | 1.500 | Básico → Expert |
| Mobile | 1.000 | Básico → Expert |
| DevOps | 800 | Intermediário → Expert |
| Database | 700 | Básico → Expert |
| API Design | 500 | Intermediário → Expert |
| Testing | 1.000 | Intermediário → Expert |
| Security | 800 | Avançado → Expert |
| Performance | 700 | Intermediário → Expert |
| Architecture | 500 | Avançado → Expert |

---

## 🎨 Frontend Skills (1.500)

### React Skills (300)

#### R001: React Hooks Mastery
```lua
-- SKILL: React Hooks Mastery
-- Nível: Intermediário → Expert
-- Contexto: Qualquer app React

-- HABILIDADES:
-- 1. useState para estado local
-- 2. useEffect para side effects
-- 3. useContext para contexto global
-- 4. useReducer para estado complexo
-- 5. useMemo para memoização
-- 6. useCallback para callbacks
-- 7. useRef para referências
-- 8. Custom Hooks para lógica reutilizável

-- PADRÃO MELHORADO:
-- ERRADO: useState em excesso, props drilling
-- CERTO: useReducer + Context, Custom Hooks

-- EXEMPLO DE CUSTOM HOOK:
-- useLocalStorage(key, initialValue)
-- useFetch(url, options)
-- useDebounce(value, delay)
-- useMediaQuery(query)
-- useIntersectionObserver(ref, options)
```

#### R002: Next.js App Router
```lua
-- SKILL: Next.js App Router Mastery
-- Nível: Intermediário → Expert
-- Contexto: Apps Next.js 13+

-- PADRÕES:
-- 1. Server Components por padrão
-- 2. Client Components apenas quando necessário
-- 3. Server Actions para mutações
-- 4. Parallel Routes para layouts complexos
-- 5. Intercepting Routes para modais
-- 6. Streaming com Suspense
-- 7. ISR para performance
-- 8. Edge Runtime para APIs

-- MELHORIA:
-- ERRADO: 'use client' em tudo
-- CERTO: Server Components + minimal Client
```

#### R003: State Management Patterns
```lua
-- SKILL: State Management Patterns
-- Nível: Intermediário → Expert
-- Contexto: Apps com estado complexo

-- OPÇÕES:
-- 1. Zustand (simples, performático)
-- 2. Jotai (átomos, granular)
-- 3. Recoil (Facebook, atômico)
-- 4. Redux Toolkit (enterprise)
-- 5. MobX (reactivo, observable)
-- 6. XState (máquinas de estado)
-- 7. TanStack Query (server state)
-- 8. SWR (stale-while-revalidate)

-- DECISÃO:
-- App pequeno → Zustand ou Jotai
-- App médio → TanStack Query + Zustand
-- App grande → Redux Toolkit + TanStack Query
```

#### R004: Performance Optimization
```lua
-- SKILL: React Performance Optimization
-- Nível: Avançado → Expert
-- Contexto: Apps com problemas de performance

-- TÉCNICAS:
-- 1. React.memo() para componentes puros
-- 2. useMemo() para cálculos pesados
-- 3. useCallback() para funções estáveis
-- 4. Code Splitting com React.lazy
-- 5. Virtualização com react-window
-- 6. Immer para imutabilidade
-- 7. Web Workers para CPU-intensive
-- 8. Service Workers para caching

-- MÉTRICAS:
-- - First Contentful Paint < 1.5s
-- - Largest Contentful Paint < 2.5s
-- - Time to Interactive < 3.5s
-- - Cumulative Layout Shift < 0.1
```

#### R005: Testing Strategies
```lua
-- SKILL: React Testing Strategies
-- Nível: Intermediário → Expert
-- Contexto: Qualquer app React

-- PIRÂMIDE:
-- 1. Unit Tests (70%) - Jest + React Testing Library
-- 2. Integration Tests (20%) - Cypress + Testing Library
-- 3. E2E Tests (10%) - Playwright ou Cypress

-- PADRÕES:
-- 1. Test behavior, not implementation
-- 2. Use screen queries by role/text
-- 3. Mock apenas o necessário
-- 4. Test hooks com renderHook
-- 5. Teste acessibilidade
```

### Vue Skills (200)

#### V001: Composition API Mastery
```lua
-- SKILL: Vue 3 Composition API
-- Nível: Intermediário → Expert
-- Contexto: Apps Vue 3

-- PADRÕES:
-- 1. <script setup> por padrão
-- 2. Composables para lógica reutilizável
-- 3. Reactivity Transform (ref sugar)
-- 4. provide/injeção para dependências
-- 5. watchEffect vs watch
-- 6. toRef vs toRefs
-- 7. shallowRef para performance
-- 8. triggerRef para updates forçados

-- MELHORIA:
-- ERRADO: Options API em novos projetos
-- CERTO: Composition API + <script setup>
```

#### V002: Nuxt 3 Full Stack
```lua
-- SKILL: Nuxt 3 Full Stack Development
-- Nível: Intermediário → Expert
-- Contexto: Apps Nuxt 3

-- FEATURES:
-- 1. Auto-imports (composables, components)
-- 2. Server Routes para APIs
-- 3. Nitro para deploy universal
-- 4. Middleware para autenticação
-- 5. Plugins para extensions
-- 6. Layouts para estrutura
-- 7. Pages para rotas
-- 8. Layers para reutilização
```

### Angular Skills (200)

#### A001: Signals & Modern Angular
```lua
-- SKILL: Angular Signals & Modern Patterns
-- Nível: Intermediário → Expert
-- Contexto: Angular 16+

-- NOVOS CONCEITOS:
-- 1. Signals para reatividade granular
-- 2. Computed signals para derivação
-- 3. Effects para side effects
-- 4. Signal Inputs/Outputs
-- 5. LinkedSignal para state derivado
-- 6. Resource API para async
-- 7. DestroyRef para limpeza
-- 8. afterNextRender para DOM

-- MELHORIA:
-- ERRADO: RxJS para tudo
-- CERTO: Signals + RxJS quando necessário
```

### CSS Skills (300)

#### C001: Modern CSS Layout
```lua
-- SKILL: Modern CSS Layout Mastery
-- Nível: Básico → Expert
-- Contexto: Qualquer site

-- TÉCNICAS:
-- 1. CSS Grid para layouts 2D
-- 2. Flexbox para layouts 1D
-- 3. Container Queries para componentes
-- 4. Subgrid para grids aninhados
-- 5. Aspect Ratio para proporções
-- 6. Clamp() para responsividade
-- 7. Logical Properties para RTL
-- 8. CSS Layers para especificidade

-- MELHORIA:
-- ERRADO: Bootstrap, floats,clearfix
-- CERTO: CSS Grid + Flexbox + Container Queries
```

#### C002: CSS Animation & Transitions
```lua
-- SKILL: CSS Animation & Transitions
-- Nível: Intermediário → Expert
-- Contexto: UIs interativas

-- TÉCNICAS:
-- 1. Transform para movimento
-- 2. Transition para interpolação
-- 3. @keyframes para animações complexas
-- 4. scroll-timeline para scroll-driven
-- 5. view-timeline para intersection
-- 6. @starting-style para animações de entrada
-- 7. transition-behavior: allow-discrete
-- 8. popover para modais nativos

-- PERFORMANCE:
-- - Animar apenas transform e opacity
-- - Usar will-change com moderação
-- - Preferir CSS over JavaScript
```

---

## ⚙️ Backend Skills (1.500)

### Node.js Skills (300)

#### N001: Express.js Production Patterns
```lua
-- SKILL: Express.js Production Patterns
-- Nível: Intermediário → Expert
-- Contexto: APIs Express em produção

-- PADRÕES:
-- 1. Error handling centralizado
-- 2. Rate limiting por endpoint
-- 3. Request validation com Zod/Joi
-- 4. Logging estruturado (pino/winston)
-- 5. Graceful shutdown
-- 6. Health checks
-- 7. API versioning
-- 8. Response compression

-- MELHORIA:
-- ERRADO: app.use(express.json()) sem config
-- CERTO: Validação + Rate Limit + Logging
```

#### N002: Fastify High Performance
```lua
-- SKILL: Fastify High Performance
-- Nível: Intermediário → Expert
-- Contexto: APIs de alta performance

-- VANTAGENS:
-- 1. 2x mais rápido que Express
-- 2. Schema-based validation
-- 3. Encapsulation por rota
-- 4. Logging estruturado built-in
-- 5. Plugin system
-- 6. TypeScript first-class
-- 7. Request/response decoration
-- 8. WebSocket support

-- QUANDO USAR:
-- - APIs com muitas requisições
-- - Microserviços de alta performance
-- - WebSocket servers
```

#### N003: NestJS Enterprise
```lua
-- SKILL: NestJS Enterprise Architecture
-- Nível: Avançado → Expert
-- Contexto: Apps enterprise

-- CONCEITOS:
-- 1. Modules para organização
-- 2. Controllers para rotas
-- 3. Services para lógica
-- 4. Providers para dependências
-- 5. Guards para autenticação
-- 6. Interceptors para cross-cutting
-- 7. Pipes para validação
-- 8. Filters para erros

-- MELHORIA:
-- ERRADO: MVC tradicional
-- CERTO: Arquitetura hexagonal com NestJS
```

### Python Skills (300)

#### P001: FastAPI Modern Python
```lua
-- SKILL: FastAPI Modern Python
-- Nível: Intermediário → Expert
-- Contexto: APIs Python modernas

-- FEATURES:
-- 1. Type hints para validação
-- 2. Async/await nativo
-- 3. OpenAPI automático
-- 4. Dependency injection
-- 5. Background tasks
-- 6. WebSocket support
-- 7. Middleware customizado
-- 8. SQLAlchemy 2.0 integration

-- MELHORIA:
-- ERRADO: Flask/Django para APIs
-- CERTO: FastAPI para performance + type safety
```

#### P002: Django Full Stack
```lua
-- SKILL: Django Full Stack Development
-- Nível: Intermediário → Expert
-- Contexto: Apps web completas

-- FEATURES:
-- 1. ORM poderoso
-- 2. Admin automático
-- 3. Forms e validation
-- 4. Authentication built-in
-- 5. CSRF protection
-- 6. Template engine
-- 7. Celery para tasks
-- 8. Django REST Framework

-- MELHORIA:
-- ERRADO: Django sem DRF para APIs
-- CERTO: Django + DRF + Celery
```

### Go Skills (200)

#### G001: Go Concurrency Patterns
```lua
-- SKILL: Go Concurrency Mastery
-- Nível: Avançado → Expert
-- Contexto: Apps de alta concorrência

-- PADRÕES:
-- 1. Goroutines para concorrência
-- 2. Channels para comunicação
-- 3. Select para múltiplos canais
-- 4. Sync primitives (Mutex, WaitGroup)
-- 5. Context para cancelamento
-- 6. Worker pools
-- 7. Fan-out/fan-in
-- 8. Pipeline patterns

-- MELHORIA:
-- ERRADO: Threads tradicionais
-- CERTO: Goroutines + Channels + Context
```

### Rust Skills (200)

#### R001: Rust Ownership & Borrowing
```lua
-- SKILL: Rust Ownership System
-- Nível: Intermediário → Expert
-- Contexto: Qualquer projeto Rust

-- CONCEITOS:
-- 1. Ownership rules
-- 2. Borrowing (& e &mut)
-- 3. Lifetimes ('a)
-- 4. Move semantics
-- 5. Clone vs Copy
-- 6. Arc/Mutex para shared state
-- 7. Pin para self-referential
-- 8. PhantomData para phantom types

-- MELHORIA:
-- ERRADO: Lutar contra o borrow checker
-- CERTO: Entender e usar ao seu favor
```

---

## 📱 Mobile Skills (1.000)

### React Native Skills (300)

#### RN001: React Native Architecture
```lua
-- SKILL: React Native Modern Architecture
-- Nível: Intermediário → Expert
-- Contexto: Apps React Native

-- CONCEITOS:
-- 1. New Architecture (JSI, TurboModules, Fabric)
-- 2. Hermes engine
-- 3. Reanimated para animações
-- 4. Gesture Handler para gestures
-- 5. Navigation para rotas
-- 6. Expo para desenvolvimento rápido
-- 7. Native Modules para funcionalidades nativas
-- 8. Code Push para updates OTA

-- MELHORIA:
-- ERRADO: Class components, Redux boilerplate
-- CERTO: Hooks, Zustand, Expo Router
```

### Flutter Skills (300)

#### F001: Flutter State Management
```lua
-- SKILL: Flutter State Management
-- Nível: Intermediário → Expert
-- Contexto: Apps Flutter

-- OPÇÕES:
-- 1. Provider (simples)
-- 2. Riverpod (type-safe, moderno)
-- 3. BLoC (enterprise)
-- 4. Cubit (simplified BLoC)
-- 5. GetX (all-in-one)
-- 6. MobX (reactive)
-- 7. Redux (predictable)
-- 8. Signals (granular)

-- DECISÃO:
-- App simples → Provider ou Signals
-- App médio → Riverpod
-- App grande → BLoC
```

### iOS Skills (200)

#### I001: SwiftUI Modern iOS
```lua
-- SKILL: SwiftUI Modern iOS Development
-- Nível: Intermediário → Expert
-- Contexto: Apps iOS modernos

-- FEATURES:
-- 1. Declarative UI
-- 2. @State, @Binding, @ObservedObject
-- 3. @Environment para dependency injection
-- 4. NavigationStack para rotas
-- 5. Animations built-in
-- 6. Core Data integration
-- 7. WidgetKit para widgets
-- 8. App Intents para Siri/Shortcuts

-- MELHORIA:
-- ERRADO: UIKit em novos projetos
-- CERTO: SwiftUI + UIKit quando necessário
```

### Android Skills (200)

#### A001: Jetpack Compose Modern Android
```lua
-- SKILL: Jetpack Compose Modern Android
-- Nível: Intermediário → Expert
-- Contexto: Apps Android modernos

-- FEATURES:
-- 1. Declarative UI
-- 2. State management com remember
-- 3. Compose Navigation
-- 4. Material Design 3
-- 5. Animation APIs
-- 6. Hilt para DI
-- 7. Room para persistência
-- 8. WorkManager para background

-- MELHORIA:
-- ERRADO: XML layouts em novos projetos
-- CERTO: Jetpack Compose + Kotlin
```

---

## 🧪 Testing Skills (1.000)

### Unit Testing (300)

#### UT001: Testing Pyramid
```lua
-- SKILL: Testing Pyramid Mastery
-- Nível: Intermediário → Expert
-- Contexto: Qualquer projeto

-- PIRÂMIDE:
-- 1. Unit Tests (70%)
--    - Rápidos, isolados, muitos
--    - Testam funções/métodos individuais
--    - Mock externo mínimo
--
-- 2. Integration Tests (20%)
--    - Testam componentes juntos
--    - Database, API, UI
--    - Menos que unit, mais que E2E
--
-- 3. E2E Tests (10%)
--    - Testam fluxo completo
--    - Usuário real
--    - lentos, frágeis, poucos

-- MELHORIA:
-- ERRADO: 100% E2E tests
-- CERTO: 70/20/10 pyramid
```

### Integration Testing (300)

#### IT001: API Testing Strategies
```lua
-- SKILL: API Testing Strategies
-- Nível: Intermediário → Expert
-- Contexto: APIs REST/GraphQL

-- NÍVEIS:
-- 1. Contract Testing (Pact)
--    - Valida contratos entre serviços
--    - Garante compatibilidade
--
-- 2. Integration Testing
--    - Testa com database real
--    - Testa com serviços reais
--
-- 3. Load Testing (k6, Artillery)
--    - Testa performance
--    - Testa stress
--
-- 4. Security Testing (OWASP ZAP)
--    - Testa vulnerabilidades
--    - Testa autenticação

-- FERRAMENTAS:
-- - Postman/Newman para collection testing
-- - Supertest para Node.js
-- - pytest para Python
-- - Go testing para Go
```

### E2E Testing (200)

#### E2E001: Playwright Mastery
```lua
-- SKILL: Playwright E2E Testing
-- Nível: Intermediário → Expert
-- Contexto: Apps web

-- FEATURES:
-- 1. Cross-browser (Chrome, Firefox, Safari)
-- 2. Auto-wait intelligente
-- 3. Network interception
-- 4. Mobile emulation
-- 5. Visual comparisons
-- 6. Trace viewer
-- 7. Codegen para gravar testes
-- 8. Parallel execution

-- PADRÕES:
-- 1. Page Object Model
-- 2. Data-testid selectors
-- 3. Custom fixtures
-- 4. API testing integrado
-- 5. Visual regression
-- 6. Accessibility testing
```

### Performance Testing (200)

#### PT001: Load Testing Strategies
```lua
-- SKILL: Load Testing Strategies
-- Nível: Avançado → Expert
-- Contexto: APIs e aplicações web

-- MÉTRICAS:
-- 1. Response Time (p50, p95, p99)
-- 2. Throughput (requests/second)
-- 3. Error Rate
-- 4. Apdex Score
-- 5. Concurrent Users
-- 6. Time to First Byte (TTFB)

-- FERRAMENTAS:
-- 1. k6 (moderno, JavaScript)
-- 2. Artillery (YAML config)
-- 3. JMeter (clássico, Java)
-- 4. Locust (Python, distributed)
-- 5. wrk (simples, C)

-- PADRÕES:
-- 1. Baseline Testing
-- 2. Stress Testing
-- 3. Spike Testing
-- 4. Soak Testing
-- 5. Breakpoint Testing
```

---

## 🔒 Security Skills (800)

### Application Security (300)

#### AS001: OWASP Top 10
```lua
-- SKILL: OWASP Top 10 Mitigation
-- Nível: Avançado → Expert
-- Contexto: Qualquer aplicação web

-- TOP 10:
-- 1. Broken Access Control
--    - Mitigation: RBAC, ABAC, deny by default
--
-- 2. Cryptographic Failures
--    - Mitigation: AES-256, TLS 1.3, key rotation
--
-- 3. Injection
--    - Mitigation: Parameterized queries, ORM
--
-- 4. Insecure Design
--    - Mitigation: Threat modeling, secure design
--
-- 5. Security Misconfiguration
--    - Mitigation: Hardening, least privilege
--
-- 6. Vulnerable Components
--    - Mitigation: SCA, dependency scanning
--
-- 7. Authentication Failures
--    - Mitigation: MFA, rate limiting, session mgmt
--
-- 8. Software/Data Integrity
--    - Mitigation: CI/CD security, SBOM
--
-- 9. Logging Failures
--    - Mitigation: Audit logging, monitoring
--
-- 10. SSRF
--     - Mitigation: Input validation, allowlists
```

### Network Security (200)

#### NS001: Zero Trust Architecture
```lua
-- SKILL: Zero Trust Architecture
-- Nível: Avançado → Expert
-- Contexto: Enterprise networks

-- PRINCÍPIOS:
-- 1. Never trust, always verify
-- 2. Least privilege access
-- 3. Micro-segmentation
-- 4. Continuous monitoring
-- 5. Multi-factor authentication
-- 6. Device verification
-- 7. Encrypted communications
-- 8. Regular auditing

-- COMPONENTES:
-- 1. Identity Provider (IdP)
-- 2. Policy Engine
-- 3. Policy Enforcement Point
-- 4. Device Trust
-- 5. Network Segmentation
-- 6. SIEM/SOAR
```

### Cryptography (200)

#### C001: Modern Cryptography
```lua
-- SKILL: Modern Cryptography Patterns
-- Nível: Avançado → Expert
-- Contexto: Qualquer sistema que lida com dados sensíveis

-- ALGORITMOS:
-- 1. Symmetric: AES-256-GCM
-- 2. Asymmetric: RSA-4096, ECC P-384
-- 3. Hashing: SHA-3, Argon2id
-- 4. Key Exchange: X25519, ECDH
-- 5. Digital Signatures: Ed25519

-- PADRÕES:
-- 1. Envelope Encryption
-- 2. Key Rotation
-- 3. HSM/KMS Integration
-- 4. Certificate Management
-- 5. TLS 1.3 Only

-- ERROS COMUNS:
-- - MD5, SHA-1 para hashing
-- - ECB mode para encryption
-- - Hardcoded keys
-- - IV/nonce reuse
-- - Weak random generators
```

---

## 📊 Database Skills (700)

### SQL Skills (300)

#### SQL001: Query Optimization
```lua
-- SKILL: SQL Query Optimization
-- Nível: Intermediário → Expert
-- Contexto: Bancos SQL em produção

-- TÉCNICAS:
-- 1. EXPLAIN ANALYZE para entender queries
-- 2. Indexes estratégicos (B-tree, Hash, GIN)
-- 3. Query plans e hints
-- 4. Partitioning para tabelas grandes
-- 5. Materialized Views para read-heavy
-- 6. Connection pooling
-- 7. Batch operations
-- 8. Proper data types

-- MÉTRICAS:
-- - Query time < 100ms
-- - Index usage > 80%
-- - Cache hit ratio > 99%
-- - Connection pool utilization < 80%
```

### NoSQL Skills (200)

#### NOSQL001: Document Database Patterns
```lua
-- SKILL: MongoDB/Document DB Patterns
-- Nível: Intermediário → Expert
-- Contexto: Apps com dados semi-estruturados

-- PADRÕES:
-- 1. Embedded vs Referenced documents
-- 2. Polymorphic schemas
-- 3. Bucket pattern para time series
-- 4. Outlier pattern
-- 5. Schema versioning
-- 6. Change streams
-- 7. Aggregation pipelines
-- 8. Read/Write proxies

-- QUANDO USAR:
-- - Dados flexíveis
-- - Schema evolui rápido
-- - Read/write heavy
-- - Horizontal scaling
```

### Graph Database Skills (200)

#### GRAPH001: Neo4j Patterns
```lua
-- SKILL: Neo4j Graph Database Patterns
-- Nível: Intermediário → Expert
-- Contexto: Dados relacionais complexos

-- PADRÕES:
-- 1. Node-RED relationship modeling
-- 2. Graph algorithms (PageRank, Community)
-- 3. Cypher query optimization
-- 4. Indexes e constraints
-- 5. APOC procedures
-- 6. Graph Data Science library
-- 7. Causal clustering
-- 8. Bloom para visualização

-- QUANDO USAR:
-- - Rede social
-- - Recomendação
-- - Fraude detection
-- - Knowledge graph
-- - Master data management
```

---

## 🏗️ Architecture Skills (500)

### Microservices (200)

#### MS001: Microservices Patterns
```lua
-- SKILL: Microservices Architecture Patterns
-- Nível: Avançado → Expert
-- Contexto: Sistemas distribuídos

-- PADRÕES:
-- 1. API Gateway (Kong, AWS API Gateway)
-- 2. Service Discovery (Consul, Eureka)
-- 3. Circuit Breaker (Hystrix, Resilience4j)
-- 4. Saga Pattern (orchestration/choreography)
-- 5. CQRS (Command Query Responsibility Segregation)
-- 6. Event Sourcing
-- 7. Strangler Fig (migração)
-- 8. Sidecar Pattern (service mesh)

-- ANTI-PATTERNS:
-- - Distributed monolith
-- - Nano services
-- - Shared database
-- - Synchronous everything
```

### Domain-Driven Design (200)

#### DDD001: DDD Strategic Patterns
```lua
-- SKILL: Domain-Driven Design Strategic Patterns
-- Nível: Avançado → Expert
-- Contexto: Complex business domains

-- CONCEITOS:
-- 1. Bounded Contexts
-- 2. Context Maps
-- 3. Ubiquitous Language
-- 4. Core Domain vs Supporting
-- 5. Domain Events
-- 6. Anti-Corruption Layer
-- 7. Open Host Service
-- 8. Published Language

-- MÉTRICAS:
-- - Aligns code with business
-- - Reduces complexity
-- - Improves communication
-- - Enables autonomy
```

### Event-Driven (100)

#### ED001: Event-Driven Architecture
```lua
-- SKILL: Event-Driven Architecture
-- Nível: Avançado → Expert
-- Contexto: Sistemas reativos

-- PADRÕES:
-- 1. Event Notification
-- 2. Event-Carried State Transfer
-- 3. Event Sourcing
-- 4. CQRS
-- 5. Saga Pattern
-- 6. Transactional Outbox
-- 7. Dead Letter Queue
-- 8. Event Replay

-- TECNOLOGIAS:
-- 1. Apache Kafka
-- 2. RabbitMQ
-- 3. AWS EventBridge
-- 4. Azure Event Hubs
-- 5. Google Pub/Sub
-- 6. Redis Streams
-- 7. NATS
-- 8. Pulsar
```

---

*Coding Skills v1.0 - Setembro 2026*