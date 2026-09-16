# 🍉 Watermelon Platform - UI Component System (Skills)

> **Fonte: https://github.com/WatermelonCorp/watermelon-platform**
> **Skills extraídas e aprimoradas para o knowledge base**

---

## 📋 Visão Geral

**Watermelon Platform** é uma plataforma open-source de componentes UI com React 19, TypeScript, Vite, Tailwind CSS 4 e Motion. Inclui MCP server, CLI, e 850+ exemplos de componentes animated.

---

## 🔧 Skills de Frontend

### 1. Arquitetura React 19 + TypeScript

```typescript
// SKILL: Arquitetura Moderna React 19
// Nível: Expert
// Contexto: Desenvolvimento de componentes UI

// STACK:
// - React 19: Server Components, Actions
// - TypeScript 5: Type safety
// - Vite: Build tool rápido
// - Tailwind CSS 4: Utility-first CSS
// - Motion: Animações
// - React Router: Routing

// PADRÕES:
// 1. Component Composition: composição flexível
// 2. Server Components: renderização no servidor
// 3. Streaming: carregamento progressivo
// 4. Islands: ilhas de interatividade
// 5. Content Collections: MDX para conteúdo

// MELHORIA:
// ERRADO: React class components
// CORRECT: React 19 com Server Components
```

### 2. Sistema de Design Tokens

```typescript
// SKILL: Design Tokens para Consistência
// Nível: Expert
// Contexto: Sistema de design escalável

// CATEGORIAS:
// 1. Colors: paleta de cores
// 2. Typography: fontes e escalas
// 3. Spacing: escala de espaçamento
// 4. Shadows: níveis de sombra
// 5. Borders: raio e largura
// 6. Motion: timing e easing

// IMPLEMENTAÇÃO:
// CSS Custom Properties
// :root {
//   --color-primary: #6366f1;
//   --color-secondary: #8b5cf6;
//   --font-sans: 'Inter', sans-serif;
//   --space-4: 1rem;
//   --radius-lg: 0.5rem;
//   --shadow-md: 0 4px 6px -1px rgb(0 0 0 / 0.1);
// }

// MELHORIA:
// ERRADO: Valores hardcoded
// CORRECT: Design tokens consistentes
```

### 3. MCP Server para AI Integration

```typescript
// SKILL: MCP Server para Descoberta de Componentes
// Nível: Expert
// Contexto: Integração com ferramentas de IA

// FUNCIONALIDADES:
// 1. Search: busca de componentes
// 2. Retrieval: detalhes de componentes
// 3. Inspiration: exemplos de uso
// 4. Category: navegação por categoria
// 5. Composition: composição de páginas

// ENDPOINTS:
// - /api/catalog/summary
// - /api/catalog/entries?kind=blocks
// - /openapi.json
// - /llms.txt

// CLI SETUP:
// npx @watermelon-ui/cli init --client codex
// npx @watermelon-ui/cli init --client claude
// npx @watermelon-ui/cli init --client cursor

// MELHORIA:
// ERRADO: Documentação estática
// CORRECT: MCP server para IA dinâmica
```

### 4. Installable Components (shadcn)

```bash
# SKILL: Componentes Copy-Paste
# Nível: Intermediário → Expert
# Contexto: Distribuição de componentes

# INSTALAÇÃO:
npx shadcn@latest add https://registry.watermelon.sh/r/card-split-accordian.json

# VANTAGENS:
# - Código no projeto do usuário
# - Editável completamente
# - Sem dependência externa
# - Versionamento local
# - Customização total

# COMPONENTES DISPONÍVEIS:
# - Animated Components
# - Blocks
# - Dashboards
# - Templates
# - Showcases

# MELHORIA:
// ERRADO: Bibliotecas com dependência
// CORRECT: Copy-paste components
```

### 5. Content-Driven Architecture

```typescript
// SKILL: Arquitetura Baseada em Conteúdo
// Nível: Expert
// Contexto: CMS headless para componentes

// ESTRUTURA:
// src/data/contents/
// ├── animated-components/
// ├── registry/
// ├── components/
// ├── blocks/
// ├── showcases/
// ├── dashboards/
// └── templates/

// FUNCIONALIDADES:
// 1. MDX: conteúdo rich-text
// 2. Colocated Source: fonte junto ao conteúdo
// 3. Auto-generation: sitemap automático
// 4. SEO: otimização para buscas
// 5. Preview: visualização em tempo real

// MELHORIA:
// ERRADO: CMS externo
// CORRECT: Content collections integradas
```

---

## 🎨 Componentes Disponíveis

### Animated Components
```
- Card Split Accordion
- Animated Menu
- Morphing Navigation
- Glassmorphism Cards
- Gradient Animations
- Particle Effects
```

### Blocks
```
- Hero Sections
- Feature Sections
- Pricing Tables
- Testimonials
- CTAs
- FAQs
```

### Dashboards
```
- Analytics Dashboard
- E-commerce Dashboard
- Admin Panel
- Metrics Dashboard
```

### Templates
```
- Landing Page
- SaaS Template
- Portfolio Template
- Blog Template
```

---

## 🚀 Deploy e CI/CD

### Build Process
```bash
# Development
bun run dev

# Production Build
bun run build

# Lint
bun run lint

# Preview
bun run preview

# Deploy
bun run deploy
```

### MCP Deployment
```bash
# Local MCP Server
bun run mcp

# Dev MCP Worker
bun run mcp:dev

# Deploy MCP Worker
bun run mcp:deploy
```

---

## 📊 Métricas

| Métrica | Valor |
|---------|-------|
| Stars | 511 |
| Components | 850+ |
| Framework | React 19 |
| CSS | Tailwind 4 |
| Build | Vite |
| Package Manager | Bun |
| MCP Tools | 10+ |
| Registry Items | 100+ |

---

## 🎯 Casos de Uso

### 1. SaaS Landing Page
```typescript
// Componentes para landing page:
import { Hero } from '@/components/blocks/hero';
import { Features } from '@/components/blocks/features';
import { Pricing } from '@/components/blocks/pricing';
import { Testimonials } from '@/components/blocks/testimonials';
import { CTA } from '@/components/blocks/cta';
```

### 2. Dashboard
```typescript
// Dashboard components:
import { MetricsCard } from '@/components/dashboards/metrics';
import { Chart } from '@/components/dashboards/charts';
import { Table } from '@/components/dashboards/table';
import { Sidebar } from '@/components/dashboards/sidebar';
```

### 3. Portfolio
```typescript
// Portfolio components:
import { ProjectGrid } from '@/components/portfolio/grid';
import { ProjectCard } from '@/components/portfolio/card';
import { Gallery } from '@/components/portfolio/gallery';
import { Contact } from '@/components/portfolio/contact';
```

---

*Watermelon Platform Skills v1.0 — Setembro 2026*
*Fonte: https://github.com/WatermelonCorp/watermelon-platform*