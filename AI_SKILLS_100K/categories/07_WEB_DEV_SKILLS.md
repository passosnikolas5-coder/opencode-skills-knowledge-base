# 🌐 Web Development Skills - 8.000 Skills

> **Todas as habilidades de desenvolvimento web documentadas**

---

## 📊 Visão Geral

| Subcategoria | Skills | Nível |
|--------------|--------|-------|
| HTML/CSS | 1.000 | Básico → Expert |
| JavaScript | 1.500 | Básico → Expert |
| React | 1.200 | Básico → Expert |
| Vue | 800 | Básico → Expert |
| Angular | 800 | Básico → Expert |
| Svelte | 600 | Básico → Expert |
| Backend | 1.000 | Básico → Expert |
| Full-Stack | 600 | Intermediário → Expert |
| Performance | 500 | Intermediário → Expert |
| Accessibility | 400 | Intermediário → Expert |

---

## 📄 HTML/CSS Skills (1.000)

### HTML5 (300)

#### HTML001: Semantic HTML
```lua
-- SKILL: Semantic HTML
-- Nível: Básico → Expert
-- Contexto: Estrutura web acessível

-- ELEMENTOS:
-- 1. Structure: header, nav, main, footer, section, article, aside
-- 2. Forms: form, fieldset, input types, datalist, output
-- 3. Media: picture, source, video, audio, track
-- 4. Meta: Open Graph, Twitter Cards, JSON-LD

-- MELHORIA:
-- ERRADO: <div> para tudo
-- CERTO: Elementos semânticos + ARIA
```

#### HTML002: HTML Forms Mastery
```lua
-- SKILL: HTML Forms Mastery
-- Nível: Básico → Expert
-- Contexto: Formulários profissionais

-- CONCEITOS:
-- 1. Input Types: text, email, tel, url, number, range, date
-- 2. Validation: required, pattern, min, max
-- 3. Accessibility: Labels, aria-describedby
-- 4. UX: Placeholder, Autocomplete, Input masks

-- MELHORIA:
-- ERRADO: Apenas validação client-side
-- CERTO: Client + server validation
```

### CSS3 (400)

#### CSS001: Modern Layout
```lua
-- SKILL: Modern CSS Layout
-- Nível: Básico → Expert
-- Contexto: Layouts modernos

-- CONCEITOS:
-- 1. Flexbox: Container, Item, Alignment
-- 2. Grid: Template, Area, Auto-fill, Minmax()
-- 3. Container Queries: @container, Component-level
-- 4. Logical Properties: margin-inline, padding-block, RTL

-- MELHORIA:
-- ERRADO: Floats para layout
-- CERTO: Grid + Flexbox + Container Queries
```

#### CSS002: CSS Animations
```lua
-- SKILL: CSS Animations
-- Nível: Intermediário → Expert
-- Contexto: Animações CSS

-- CONCEITOS:
-- 1. Transitions: property, duration, timing-function
-- 2. Keyframes: @keyframes, animation properties
-- 3. Scroll Animations: scroll-timeline, view-timeline
-- 4. New Features: @starting-style, anchor positioning, popover
```

#### CSS003: Tailwind CSS
```lua
-- SKILL: Tailwind CSS
-- Nível: Intermediário → Expert
-- Contexto: Utility-first CSS

-- CONCEITOS:
-- 1. Utilities: spacing, colors, typography
-- 2. Components: @apply, custom utilities
-- 3. Responsive: sm, md, lg, xl
-- 4. Dark Mode: dark: prefix
-- 5. Animation: transition, transform

-- MELHORIA:
-- ERRADO: CSS classes excessivas
-- CERTO: Utility-first + component extraction
```

### Responsive Design (300)

#### RD001: Responsive Web Design
```lua
-- SKILL: Responsive Web Design
-- Nível: Básico → Expert
-- Contexto: Sites responsivos

-- CONCEITOS:
-- 1. Breakpoints: mobile-first approach
-- 2. Fluid Typography: clamp(), vw units
-- 3. Responsive Images: srcset, picture element
-- 4. Container Queries: component-level responsive

-- BEST PRACTICES:
-- - Mobile-first design
-- - Relative units (rem, em, %)
-- - Flexible images
-- - CSS Grid + Flexbox
```

---

## ⚡ JavaScript Skills (1.500)

### ES6+ (300)

#### JS001: Modern JavaScript
```lua
-- SKILL: Modern JavaScript (ES6+)
-- Nível: Básico → Expert
-- Contexto: JavaScript moderno

-- CONCEITOS:
-- 1. Variables: let, const
-- 2. Arrow Functions: () => {}
-- 3. Destructuring: const {a, b} = obj
-- 4. Spread/Rest: ...operator
-- 5. Template Literals: `string ${var}`
-- 6. Modules: import/export
-- 7. Optional Chaining: obj?.prop
-- 8. Nullish Coalescing: ?? operator
```

### Async JavaScript (300)

#### JS002: Async Patterns
```lua
-- SKILL: Async JavaScript Patterns
-- Nível: Intermediário → Expert
-- Contexto: Programação assíncrona

-- PADRÕES:
-- 1. Callbacks (legado)
-- 2. Promises: .then()/.catch()
-- 3. Async/Await: try/catch
-- 4. Promise.all: parallel execution
-- 5. Promise.race: first wins
-- 6. Generators: function*
-- 7. Iterators: for...of

-- MELHORIA:
-- ERRADO: Callback hell
-- CERTO: Async/Await + error handling
```

### TypeScript (400)

#### TS001: TypeScript Mastery
```lua
-- SKILL: TypeScript Mastery
-- Nível: Básico → Expert
-- Contexto: Tipagem estática para JavaScript

-- CONCEITOS:
-- 1. Types: string, number, boolean, any, unknown
-- 2. Interfaces: object shapes
-- 3. Generics: Type parameters
-- 4. Utility Types: Partial, Required, Pick, Omit
-- 5. Type Guards: typeof, instanceof, in
-- 6. Enums: numeric, string, const
-- 7. Declaration Files: .d.ts
-- 8. Strict Mode: strictNullChecks, noImplicitAny

-- MELHORIA:
-- ERRADO: any everywhere
-- CERTO: Strict types + utility types
```

### Testing (300)

#### JS003: JavaScript Testing
```lua
-- SKILL: JavaScript Testing
-- Nível: Intermediário → Expert
-- Contexto: Testes em JavaScript

-- FRAMEWORKS:
-- 1. Jest: Unit testing, snapshots
-- 2. Vitest: Fast, ESM-native
-- 3. Cypress: E2E testing
-- 4. Playwright: Cross-browser E2E
-- 5. Testing Library: Component testing

-- PADRÕES:
-- - AAA (Arrange, Act, Assert)
-- - Mock external dependencies
-- - Test behavior not implementation
-- - Coverage targets
```

### Performance (200)

#### JS004: JavaScript Performance
```lua
-- SKILL: JavaScript Performance
-- Nível: Intermediário → Expert
-- Contexto: Otimizar JavaScript

-- TÉCNICAS:
-- 1. Code Splitting: dynamic import
-- 2. Tree Shaking: unused code elimination
-- 3. Memoization: useMemo, useCallback
-- 4. Web Workers: offload CPU-intensive
-- 5. Service Workers: caching, offline
-- 6. Lazy Loading: images, components
-- 7. Debounce/Throttle: event handlers

-- MELHORIA:
-- ERRADO: Processamento síncrono pesado
-- CERTO: Async + Web Workers + chunking
```

---

## ⚛️ React Skills (1.200)

### Core (300)

#### REACT001: React Fundamentals
```lua
-- SKILL: React Fundamentals
-- Nível: Básico → Expert
-- Contexto: Biblioteca de UI

-- CONCEITOS:
-- 1. Components: function components
-- 2. JSX: HTML-like syntax
-- 3. Props: data passing
-- 4. State: useState, useReducer
-- 5. Effects: useEffect, cleanup
-- 6. Context: useContext
-- 7. Refs: useRef
-- 8. Fragments: <>...</>

-- MELHORIA:
-- ERRADO: Class components
-- CERTO: Functional components + hooks
```

### Hooks (300)

#### REACT002: React Hooks Mastery
```lua
-- SKILL: React Hooks Mastery
-- Nível: Intermediário → Expert
-- Contexto: Hooks avançados

-- HOOKS:
-- 1. useState: local state
-- 2. useEffect: side effects
-- 3. useContext: context consumption
-- 4. useReducer: complex state
-- 5. useMemo: expensive calculations
-- 6. useCallback: stable functions
-- 7. useRef: DOM references
-- 8. Custom Hooks: reusable logic

-- MELHORIA:
-- ERRADO: useState em excesso
-- CERTO: useReducer + custom hooks
```

### State Management (200)

#### REACT003: React State Management
```lua
-- SKILL: React State Management
-- Nível: Intermediário → Expert
-- Contexto: Gerenciar estado

-- OPÇÕES:
-- 1. Zustand: simples, performático
-- 2. Jotai: atômico, granular
-- 3. TanStack Query: server state
-- 4. Redux Toolkit: enterprise
-- 5. XState: state machines

-- DECISÃO:
-- Simples → Zustand
-- Server → TanStack Query
-- Complexo → Redux Toolkit
```

### Performance (200)

#### REACT004: React Performance
```lua
-- SKILL: React Performance Optimization
-- Nível: Avançado → Expert
-- Contexto: Otimizar React

-- TÉCNICAS:
-- 1. React.memo: prevent re-renders
-- 2. useMemo: cache calculations
-- 3. useCallback: stable references
-- 4. Code Splitting: lazy + Suspense
-- 5. Virtualization: react-window
-- 6. Bundle Analysis: webpack-bundle-analyzer

-- MÉTRICAS:
-- - FCP < 1.5s
-- - LCP < 2.5s
-- - CLS < 0.1
-- - TTI < 3.5s
```

### Next.js (200)

#### REACT005: Next.js App Router
```lua
-- SKILL: Next.js App Router
-- Nível: Intermediário → Expert
-- Contexto: Full-stack React

-- CONCEITOS:
-- 1. Server Components: default
-- 2. Client Components: 'use client'
-- 3. Server Actions: mutations
-- 4. Parallel Routes: complex layouts
-- 5. Intercepting Routes: modals
-- 6. Streaming: Suspense
-- 7. ISR: incremental static

-- MELHORIA:
-- ERRADO: 'use client' em tudo
-- CERTO: Server Components + minimal Client
```

---

## 💚 Vue Skills (800)

### Core (300)

#### VUE001: Vue 3 Fundamentals
```lua
-- SKILL: Vue 3 Fundamentals
-- Nível: Básico → Expert
-- Contexto: Framework progressivo

-- CONCEITOS:
-- 1. Composition API: setup(), ref, reactive
-- 2. Template Syntax: directives, mustache
-- 3. Components: props, emits, slots
-- 4. Lifecycle: onMounted, onUnmounted
-- 5. Watchers: watch, watchEffect
-- 6. Composables: reusable logic

-- MELHORIA:
-- ERRADO: Options API em novos projetos
-- CERTO: Composition API + <script setup>
```

### Advanced (300)

#### VUE002: Vue 3 Advanced
```lua
-- SKILL: Vue 3 Advanced Patterns
-- Nível: Intermediário → Expert
-- Contexto: Vue avançado

-- PADRÕES:
-- 1. Composables: useFetch, useStorage
-- 2. Provide/Inject: dependency injection
-- 3. Teleport: portals
-- 4. Suspense: async components
-- 5. KeepAlive: component caching
-- 6. Transition: animations

-- MELHORIA:
-- ERRADO: Lógica duplicada
-- CERTO: Composables reutilizáveis
```

### Nuxt (200)

#### VUE003: Nuxt 3 Full Stack
```lua
-- SKILL: Nuxt 3 Full Stack
-- Nível: Intermediário → Expert
-- Contexto: Full-stack Vue

-- FEATURES:
-- 1. Auto-imports: composables, components
-- 2. Server Routes: APIs
-- 3. Nitro: universal engine
-- 4. Middleware: auth, guards
-- 5. Plugins: extensions
-- 6. Layouts: page structure
-- 7. Pages: file-based routing
```

---

## 🅰️ Angular Skills (800)

### Core (300)

#### NG001: Angular Fundamentals
```lua
-- SKILL: Angular Fundamentals
-- Nível: Básico → Expert
-- Contexto: Framework enterprise

-- CONCEITOS:
-- 1. Components: template, class, metadata
-- 2. Modules: NgModule, feature modules
-- 3. Services: dependency injection
-- 4. Routing: router, guards, resolvers
-- 5. Forms: reactive, template-driven
-- 6. HTTP: HttpClient, interceptors

-- MELHORIA:
-- ERRADO: Modules para tudo
-- CERTO: Standalone components (Angular 14+)
```

### Advanced (300)

#### NG002: Angular Advanced
```lua
-- SKILL: Angular Advanced Patterns
-- Nível: Intermediário → Expert
-- Contexto: Angular avançado

-- PADRÕES:
-- 1. Signals: reactive state
-- 2. RxJS: observables, operators
-- 3. State Management: NgRx, NGXS
-- 4. Lazy Loading: loadChildren
-- 5. Micro Frontends: Module Federation
-- 6. SSR: Angular Universal
```

### Signals (200)

#### NG003: Angular Signals
```lua
-- SKILL: Angular Signals
-- Nível: Intermediário → Expert
-- Contexto: Reactividade granular

-- CONCEITOS:
-- 1. signal(): reactive state
-- 2. computed(): derived state
-- 3. effect(): side effects
-- 4. input(): signal inputs
-- 5. output(): signal outputs
-- 6. model(): two-way binding
-- 7. linkedSignal(): derived state
-- 8. resource(): async data

-- MELHORIA:
-- ERRADO: RxJS para tudo
-- CERTO: Signals + RxJS quando necessário
```

---

## 🔶 Svelte Skills (600)

### Core (300)

#### SV001: Svelte Fundamentals
```lua
-- SKILL: Svelte Fundamentals
-- Nível: Básico → Expert
-- Contexto: Compiler-based UI

-- CONCEITOS:
-- 1. Reactivity: $: reactive declarations
-- 2. Components: props, events, slots
-- 3. Stores: writable, readable, derived
-- 4. Animations: transitions, animations
-- 5. Actions: use: directive
-- 6. Bindings: bind: directive

-- MELHORIA:
-- ERRADO: Virtual DOM thinking
-- CERTO: Compile-time reactivity
```

### SvelteKit (300)

#### SV002: SvelteKit Full Stack
```lua
-- SKILL: SvelteKit Full Stack
-- Nível: Intermediário → Expert
-- Contexto: Full-stack Svelte

-- FEATURES:
-- 1. File-based Routing: +page.svelte
-- 2. Load Functions: data fetching
-- 3. Form Actions: mutations
-- 4. Server Routes: +server.ts
-- 5. Prerendering: static generation
-- 6. SSR: server-side rendering
-- 7. Adapters: vercel, netlify, node
```

---

## ⚙️ Backend Skills (1.000)

### Node.js (300)

#### BE001: Node.js Production
```lua
-- SKILL: Node.js Production
-- Nível: Intermediário → Expert
-- Contexto: Backend Node.js

-- FRAMEWORKS:
-- 1. Express: classic, middleware
-- 2. Fastify: performance, schema
-- 3. NestJS: enterprise, TypeScript
-- 4. Hono: edge, lightweight

-- BEST PRACTICES:
-- - Error handling middleware
-- - Rate limiting
-- - Request validation
-- - Logging
-- - Graceful shutdown
```

### Python (300)

#### BE002: Python Backend
```lua
-- SKILL: Python Backend Development
-- Nível: Intermediário → Expert
-- Contexto: Backend Python

-- FRAMEWORKS:
-- 1. FastAPI: async, type-safe
-- 2. Django: full-stack, batteries included
-- 3. Flask: minimal, flexible
-- 4. Litestar: performance, DI

-- BEST PRACTICES:
-- - Type hints
-- - Async/await
-- - Dependency injection
-- - OpenAPI docs
```

### Go (200)

#### BE003: Go Backend
```lua
-- SKILL: Go Backend Development
-- Nível: Intermediário → Expert
-- Contexto: Backend Go

-- FRAMEWORKS:
-- 1. Gin: HTTP framework
-- 2. Echo: minimalist
-- 3. Fiber: express-inspired
-- 4. stdlib: net/http

-- BEST PRACTICES:
-- - Error handling
-- - Concurrency patterns
-- - Testing
-- - Benchmarks
```

### Rust (200)

#### BE004: Rust Backend
```lua
-- SKILL: Rust Backend Development
-- Nível: Avançado → Expert
-- Contexto: Backend Rust

-- FRAMEWORKS:
-- 1. Actix Web:高性能
-- 2. Axum: Tokio ecosystem
-- 3. Rocket: easy to use
-- 4. Warp: composable

-- BEST PRACTICES:
-- - Ownership system
-- - Error handling
-- - Async runtime
-- - Zero-cost abstractions
```

---

## 🔗 Full-Stack Skills (600)

### MERN Stack (200)

#### FS001: MERN Stack
```lua
-- SKILL: MERN Stack
-- Nível: Intermediário → Expert
-- Contexto: MongoDB, Express, React, Node

-- CONCEITOS:
-- 1. MongoDB: schemas, queries, aggregation
-- 2. Express: routes, middleware, error handling
-- 3. React: components, state, hooks
-- 4. Node.js: API, authentication, file upload

-- BEST PRACTICES:
-- - MVC architecture
-- - JWT authentication
-- - Input validation
-- - Error handling
```

### JAMstack (200)

#### FS002: JAMstack
```lua
-- SKILL: JAMstack Development
-- Nível: Intermediário → Expert
-- Contexto: JavaScript, APIs, Markup

-- CONCEITOS:
-- 1. Static Generation: Next.js, Nuxt, SvelteKit
-- 2. Headless CMS: Strapi, Contentful, Sanity
-- 3. Serverless: Vercel, Netlify, Cloudflare
-- 4. CDN: edge deployment

-- MELHORIA:
-- ERRADO: Traditional hosting
-- CERTO: JAMstack + edge functions
```

### Serverless (200)

#### FS003: Serverless Architecture
```lua
-- SKILL: Serverless Architecture
-- Nível: Intermediário → Expert
-- Contexto: Serverless applications

-- PLATFORMS:
-- 1. Vercel: Next.js, edge functions
-- 2. Netlify: JAMstack, functions
-- 3. AWS Lambda: serverless compute
-- 4. Cloudflare Workers: edge

-- PATTERNS:
-- - API Gateway + Lambda
-- - Event-driven
-- - FaaS (Function as a Service)
-- - BaaS (Backend as a Service)
```

---

## ⚡ Performance Skills (500)

### Core Web Vitals (200)

#### PERF001: Core Web Vitals
```lua
-- SKILL: Core Web Vitals
-- Nível: Intermediário → Expert
-- Contexto: Performance web

-- MÉTRICAS:
-- 1. LCP (Largest Contentful Paint): < 2.5s
-- 2. FID (First Input Delay): < 100ms
-- 3. CLS (Cumulative Layout Shift): < 0.1
-- 4. INP (Interaction to Next Paint): < 200ms

-- OTIMIZAÇÕES:
-- - Optimize images
-- - Lazy load
-- - Code splitting
-- - Preload critical resources
-- - Minimize third-party scripts
```

### Bundle Optimization (150)

#### PERF002: Bundle Optimization
```lua
-- SKILL: Bundle Optimization
-- Nível: Intermediário → Expert
-- Contexto: Reduzir tamanho do bundle

-- TÉCNICAS:
-- 1. Tree Shaking: remove unused code
-- 2. Code Splitting: dynamic imports
-- 3. Compression: gzip, brotli
-- 4. Minification: terser, esbuild
-- 5. Analyze: webpack-bundle-analyzer

-- FERRAMENTAS:
-- - Webpack Bundle Analyzer
-- - Source Map Explorer
-- - Bundlephobia
```

### Image Optimization (150)

#### PERF003: Image Optimization
```lua
-- SKILL: Image Optimization
-- Nível: Básico → Expert
-- Contexto: Otimizar imagens

-- FORMATOS:
-- - WebP: melhor compressão
-- - AVIF: qualidade superior
-- - SVG: vetores
-- - JPEG: fotos
-- - PNG: transparência

-- TÉCNICAS:
-- - Responsive images (srcset)
-- - Lazy loading
-- - CDN delivery
-- - Art direction
-- - Modern formats
```

---

## ♿ Accessibility Skills (400)

### WCAG (200)

#### A11Y001: WCAG Guidelines
```lua
-- SKILL: WCAG Guidelines
-- Nível: Intermediário → Expert
-- Contexto: Acessibilidade web

-- PRINCÍPIOS (POUR):
-- 1. Perceivable: text alternatives, captions
-- 2. Operable: keyboard, no traps
-- 3. Understandable: readable, predictable
-- 4. Robust: valid HTML, ARIA

-- NÍVEIS:
-- A: mínimo
-- AA: recomendado
-- AAA: mais alto

-- FERRAMENTAS:
-- - axe-core
-- - Lighthouse
-- - WAVE
-- - NVDA/VoiceOver
```

### ARIA (200)

#### A11Y002: ARIA Patterns
```lua
-- SKILL: ARIA Patterns
-- Nível: Intermediário → Expert
-- Contexto: Componentes acessíveis

-- PATTERNS:
-- 1. Landmarks: role="banner", "navigation"
-- 2. Widgets: role="button", "dialog"
-- 3. Live Regions: aria-live="polite"
-- 4. States: aria-expanded, aria-selected

-- BEST PRACTICES:
-- - Use native HTML first
-- - ARIA when necessary
-- - Test with screen readers
-- - Keyboard navigation
```

---

*Web Development Skills v1.0 - Setembro 2026*