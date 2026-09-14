# Documentação de Skills de Frontend — v2

Data de criação: 2026-09-13
Data de atualização: 2026-09-14
Autor: Pesquisa automatizada via OpenCode

---

## Resumo

Este documento lista todas as skills relacionadas a "Frontend" encontradas no sistema, organizadas por categoria. Foram documentadas **47 skills** no total:

- **Frontend Category Pointer**: 32 skills (biblioteca completa de frontend)
- **Front End Category Pointer**: 14 skills (foco em desenvolvimento e UX)
- **Frontend Design**: 1 skill (design visual e identidade de marca)

### Melhorias v2
Cada skill agora inclui: mais exemplos práticos (2-3 exemplos), casos de uso avançados, integração com outras skills, padrões e anti-padrões, dicas de performance, comandos úteis e referências oficiais.

---

## 1. Frontend Category Pointer (32 skills)

---

### 1.1 Anti-UI-Slop

**Descrição:** Impedir que agentes de código enviem UI genérica. Estende o design system do produto, usa evidências UIZZE apenas quando útil, cobre estados obrigatórios e inspeciona o resultado renderizado.

**Quando usar:**
- Quando componentes gerados por IA seguem templates genéricos demais
- Quando o design system do projeto precisa ser respeitado rigorosamente
- Quando há risco de "UI slop" — interfaces que parecem feitas por templates

**Exemplos práticos:**

```tsx
// Anti-UI-Slop: Usar tokens do design system
import { Button } from '@/design-system';
import { useTheme } from '@/providers/theme';

export function CTASection() {
  const { brand } = useTheme();
  return (
    <section className="px-6 py-16" style={{ backgroundColor: brand.surface }}>
      <h2 className="font-display text-3xl font-bold" style={{ color: brand.primary }}>
        Comece agora
      </h2>
      <Button variant="primary" size="lg" className="mt-6">
        Criar conta grátis
      </Button>
    </section>
  );
}
```

```tsx
// Cobrir todos os estados obrigatórios
export function ButtonStates() {
  return (
    <div className="flex gap-4">
      <Button variant="primary">Default</Button>
      <Button variant="primary" disabled>Disabled</Button>
      <Button variant="primary" isLoading>Loading</Button>
      <Button variant="secondary">Secundário</Button>
      <Button variant="ghost">Ghost</Button>
    </div>
  );
}
```

**Casos de uso avançados:**
- Revisar componentes gerados automaticamente por AI para garantir aderência ao design system
- Auditar UI de terceiros antes de integrar ao produto principal
- Criar checklist de revisão visual para code review

**Integração com outras skills:**
- `Stitch-Design-Taste`: para definir o DESIGN.md que orienta todas as decisões
- `Review-Animations`: para revisar movimentos após garantir que a UI não é genérica
- `Frontend-Design`: para alinhar identidade visual com o produto

**Padrões e anti-padrões:**
✅ Fazer: Usar sempre tokens do design system (cores, espaçamentos, tipografia)
✅ Fazer: Inspecionar resultado renderizado no browser antes de aprovar
✅ Fazer: Cobrir todos os estados obrigatórios (hover, active, disabled, loading, error, empty)
❌ Evitar: Usar classes genéricas que não pertencem ao design system
❌ Evitar: Copiar estilos de templates sem adaptar à identidade do produto
❌ Evitar: Aprovar UI sem inspecionar em diferentes tamanhos de tela

**Dicas de performance:**
- Usar CSS-in-JS ou CSS Modules para encapsular estilos e evitar conflitos
- Criar um storybook com todos os estados para validação visual rápida
- Automatizar linting de estilos com ESLint plugins customizados

**Comandos úteis:**
```bash
# Rodar lint de estilos
npx eslint src/ --ext .tsx,.ts
# Verificar contraste de cores
npx color-contrast --foreground #1a1a1a --background #ffffff
```

**Referências:**
- [Storybook Docs](https://storybook.js.org/docs)
- [CSS Architecture Patterns](https://web.dev/learn/css/architecture/)

---

### 1.2 Astro

**Descrição:** Construir sites focados em conteúdo com Astro — JS zero por padrão, arquitetura de ilhas, componentes multi-framework e suporte a Markdown/MDX.

**Quando usar:**
- Sites de conteúdo (blogs, documentação, portfolios)
- Projetos onde performance é crítica e JS desnecessário deve ser eliminado
- Sites estáticos que precisam de ilhas de interatividade

**Exemplos práticos:**

```astro
---
// src/pages/blog/[slug].astro
import { getCollection } from 'astro:content';

export async function getStaticPaths() {
  const posts = await getCollection('blog');
  return posts.map(post => ({
    params: { slug: post.slug },
    props: { post },
  }));
}

const { post } = Astro.props;
const { Content } = await post.render();
---

<html lang="pt-BR">
<head>
  <meta charset="utf-8" />
  <title>{post.data.title}</title>
</head>
<body>
  <article class="prose mx-auto max-w-3xl px-6 py-12">
    <h1>{post.data.title}</h1>
    <Content />
  </article>
</body>
</html>
```

```astro
---
// Ilha com React — só carrega no client
import ReactCounter from './ReactCounter';
---

<div class="widget-container">
  <p>Este conteúdo é estático (zero JS)</p>
  <ReactCounter client:visible />
</div>
```

**Casos de uso avançados:**
- Blog corporativo com posts em MDX e componentes interativos isolados
- Documentação de produto com pesquisa client-side em ilha
- Site institucional com galeria de fotos interativa em meio a conteúdo estático

**Integração com outras skills:**
- `Markstream-Install`: para renderizar Markdown streaming em páginas Astro
- `Web-Performance-Optimization`: para auditar métricas após build
- `NextJS-Best-Practices`: quando o projeto escalar e precisar de SSR mais complexo

**Padrões e anti-padrões:**
✅ Fazer: Usar `client:*` directives apenas onde interatividade é realmente necessária
✅ Fazer: Utilizar content collections para organizar posts de blog
❌ Evitar: Colocar lógica pesada em componentes `.astro` (eles são server-only)
❌ Evitar: Importar bibliotecas pesadas sem isolar em ilhas
❌ Evitar: Usar React/Vue para tudo — o padrão é zero JS

**Dicas de performance:**
- Usar `client:idle` ou `client:visible` em vez de `client:load` para ilhas
- Gerar páginas estáticas no build com `getStaticPaths`
- Comprimir imagens automaticamente com `astro:assets`

**Comandos úteis:**
```bash
npm create astro@latest my-blog
npx astro add mdx
npm run build
```

**Referências:**
- [Astro Docs](https://docs.astro.build)
- [Astro Islands](https://docs.astro.build/en/concepts/islands/)
- [Content Collections](https://docs.astro.build/en/guides/content-collections/)

---

### 1.3 Design-It

**Descrição:** Roteia tarefas de design frontend para 48 estilos de UI específicos. Dispara para sites, telas de app ou componentes de UI solicitando uma estética específica.

**Quando usar:**
- Quando o usuário pede um estilo visual específico (brutalista, neomorfismo, glassmorphism)
- Para prototipagem rápida de diferentes estilos antes de decidir
- Quando o briefing inclui referências visuais concretas

**Exemplos práticos:**

```tsx
// Estilo Brutalist Industrial
export function DashboardBrutal() {
  return (
    <div className="min-h-screen bg-black font-mono text-green-400">
      <div className="border-2 border-green-400 p-4">
        <h1 className="text-xl uppercase tracking-widest">SISTEMA DE MONITORAMENTO</h1>
        <div className="grid grid-cols-3 gap-px mt-4">
          <div className="border border-green-400 p-3">CPU: 87%</div>
          <div className="border border-green-400 p-3">MEM: 4.2GB</div>
          <div className="border border-green-400 p-3">DISK: 120GB</div>
        </div>
      </div>
    </div>
  );
}
```

```tsx
// Estilo Glassmorphism
export function PricingCardGlass({ plan }) {
  return (
    <div className="backdrop-blur-xl bg-white/10 border border-white/20 rounded-2xl p-8 shadow-2xl">
      <h3 className="text-2xl font-bold text-white">{plan.name}</h3>
      <p className="text-4xl font-extrabold text-white mt-4">
        R${plan.price}<span className="text-lg">/mês</span>
      </p>
    </div>
  );
}
```

```tsx
// Estilo Neomorfismo
export function NeomorphicButton({ children, onClick }) {
  return (
    <button onClick={onClick}
      className="px-8 py-4 bg-gray-100 rounded-2xl text-gray-700 font-medium
                 shadow-[6px_6px_12px_#d1d1d1,-6px_-6px_12px_#ffffff]
                 active:shadow-[inset_6px_6px_12px_#d1d1d1,inset_-6px_-6px_12px_#ffffff]
                 transition-shadow">
      {children}
    </button>
  );
}
```

**Casos de uso avançados:**
- Prototipar 3-5 estilos diferentes para apresentar ao cliente
- Criar design system com variações de tema (dark mode, light mode, high contrast)
- Gerar UI para MVP rápido onde o estilo visual não é prioridade

**Integração com outras skills:**
- `Design-Taste-Frontend`: para refinar a direção visual escolhida
- `Stitch-Design-Taste`: para documentar o estilo como DESIGN.md
- `Tailwind-Patterns`: para implementar o estilo com tokens do Tailwind

**Padrões e anti-padrões:**
✅ Fazer: Experimentar múltiplos estilos antes de se comprometer
✅ Fazer: Documentar a escolha de estilo em DESIGN.md
✅ Fazer: Testar acessibilidade independente do estilo
❌ Evitar: Misturar estilos conflitantes no mesmo projeto
❌ Evitar: Ignorar responsividade focando apenas no desktop
❌ Evitar: Copiar tendências passageiras sem pensar na longevidade

**Dicas de performance:**
- Usar CSS custom properties para temas trocados em runtime
- Usar `prefers-color-scheme` para detectar tema do sistema automaticamente

**Comandos úteis:**
```bash
npx token-transformer input.json output.json
npx color-contrast-checker --foreground #1a1a1a --background #f5f5f5
```

**Referências:**
- [Design Systems Handbook](https://www.designsystems.com/)
- [Coolors - Gerador de Paletas](https://coolors.co)
- [Neumorphism Design](https://neumorphism.io/)

---

### 1.4 Design-Taste-Frontend

**Descrição:** Usar ao construir interfaces frontend de alta agência com gosto de design rigoroso, paleta de cores calibrada, layout responsivo e regras de movimento.

**Quando usar:**
- Projetos que exigem design premium e atenção a detalhes visuais
- Quando o produto precisa transmitir sofisticação
- Para revisar e elevar a qualidade visual de interfaces existentes

**Exemplos práticos:**

```tsx
// Landing page premium com tipografia calibrada
export function HeroPremium() {
  return (
    <section className="min-h-screen flex items-center justify-center bg-stone-50">
      <div className="max-w-4xl mx-auto px-6 text-center">
        <span className="text-xs uppercase tracking-[0.3em] text-stone-400">Novo lançamento</span>
        <h1 className="mt-6 text-6xl md:text-8xl font-serif font-light text-stone-900 leading-[0.9]">
          Design que<br /><em className="italic">comunica</em>
        </h1>
      </div>
    </section>
  );
}
```

```tsx
// Escala tipográfica modular
export function TypographyScale() {
  return (
    <div className="space-y-4 p-8">
      <h1 className="text-6xl font-bold">Display (4rem)</h1>
      <h2 className="text-4xl font-semibold">Heading 1 (2.5rem)</h2>
      <h3 className="text-2xl font-medium">Heading 2 (1.5rem)</h3>
      <p className="text-base leading-relaxed">Body text (1rem, line-height 1.6)</p>
    </div>
  );
}
```

**Casos de uso avançados:**
- Redesign de produto SaaS com foco em experiência premium
- Criação de design system com hierarquia tipográfica rigorosa
- Apresentação de portfólio onde cada pixel conta

**Integração com outras skills:**
- `High-End-Visual-Design`: para elevar a qualidade visual ainda mais
- `Minimalist-UI`: quando o estilo minimalista é a direção escolhida
- `Review-Animations`: para revisar micro-interações e movimentos

**Padrões e anti-padrões:**
✅ Fazer: Calibrar paleta de cores com ferramentas de contraste
✅ Fazer: Usar escala tipográfica consistente (modular scale 1.25)
✅ Fazer: Manter consistência de espaçamento (sistema de 4px ou 8px)
❌ Evitar: Mais de 2-3 fontes diferentes no mesmo projeto
❌ Evitar: Cores sem contraste suficiente (WCAG AA mínimo)
❌ Evitar: Animações sem propósito claro

**Dicas de performance:**
- Usar fontes woff2 para carregamento otimizado
- Aplicar `font-display: swap` para evitar FOIT
- Usar `loading="lazy"` em imagens below-the-fold

**Comandos úteis:**
```bash
npx utopia-cli --type scale --ratio 1.25 --min 16 --max 20
```

**Referências:**
- [UTopia - Fluid Typography](https://utopia.fyi)
- [Refactoring UI](https://www.refactoringui.com/)
- [WCAG 2.1 Guidelines](https://www.w3.org/WAI/WCAG21/quickref/)

---

### 1.5 Emil-Design-Eng

**Descrição:** Usar ao projetar ou revisar UI de produto polida com orientação de animação, interação e craft de componentes inspirada em Emil Kowalski.

**Quando usar:**
- Quando precisar de micro-interações de alta qualidade
- Para revisar animações e garantir que são suaves e purposeful
- Em projetos SaaS que precisam de polish visual

**Exemplos práticos:**

```tsx
// Micro-interação suave em botão
'use client';
import { motion } from 'framer-motion';

export function SubmitButton({ isLoading, children }) {
  return (
    <motion.button
      whileHover={{ scale: 1.02 }}
      whileTap={{ scale: 0.98 }}
      transition={{ type: 'spring', stiffness: 400, damping: 17 }}
      disabled={isLoading}
      className="relative px-6 py-3 bg-indigo-600 text-white rounded-lg font-medium overflow-hidden disabled:opacity-70">
      {isLoading && (
        <motion.div className="absolute inset-0 bg-indigo-700"
          initial={{ x: '-100%' }} animate={{ x: '100%' }}
          transition={{ repeat: Infinity, duration: 1, ease: 'linear' }} />
      )}
      <span className="relative z-10">{isLoading ? 'Enviando...' : children}</span>
    </motion.button>
  );
}
```

```tsx
// Toggle animado com spring
export function AnimatedToggle({ enabled, onToggle }) {
  return (
    <button onClick={onToggle}
      className={`relative w-12 h-6 rounded-full transition-colors duration-200 ${enabled ? 'bg-indigo-600' : 'bg-gray-300'}`}>
      <motion.div className="absolute top-0.5 left-0.5 w-5 h-5 bg-white rounded-full shadow"
        animate={{ x: enabled ? 24 : 0 }}
        transition={{ type: 'spring', stiffness: 500, damping: 30 }} />
    </button>
  );
}
```

**Casos de uso avançados:**
- Implementar sistema de micro-interações consistente para todo o app SaaS
- Revisar animações de transição entre páginas para garantir fluidez
- Criar feedback visual para ações do usuário (submit, delete, save)

**Integração com outras skills:**
- `Fixing-Motion-Performance`: para garantir que animações não causam jank
- `Review-Animations`: para auditoria completa de movimento
- `React-Patterns`: para integrar animações com hooks React

**Padrões e anti-padrões:**
✅ Fazer: Usar easings naturais (spring, ease-out) para transições
✅ Fazer: Manter durações de 150-300ms para micro-interações
✅ Fazer: Animar apenas transform e opacity (propriedades do compositor)
❌ Evitar: Animações longas (>500ms) que desaceleram a experiência
❌ Evitar: Animar layout properties (width, height, top, left)
❌ Evitar: Animações sem feedback visual claro

**Dicas de performance:**
- Usar `will-change: transform` em elementos que serão animados
- Usar `@media (prefers-reduced-motion)` para respeitar preferências do usuário
- Limitar animações simultâneas a 2-3 elementos

**Comandos úteis:**
```bash
npm install framer-motion
npm install @react-spring/web
```

**Referências:**
- [Emil Kowalski - UI Animations](https://emilkowal.ski/)
- [Framer Motion Docs](https://www.framer.com/motion/)
- [Web Animations API](https://developer.mozilla.org/en-US/docs/Web/API/Web_Animations_API)

---

### 1.6 Frontend-API-Integration-Patterns

**Descrição:** Padrões prontos para produção para integrar aplicações frontend com APIs backend, incluindo tratamento de condições de corrida, cancelamento de requisições, estratégias de retry e normalização de erros.

**Quando usar:**
- Para implementar comunicação robusta entre frontend e backend
- Quando há necessidade de retry, cache ou invalidação de dados
- Para tratar erros de rede de forma consistente

**Exemplos práticos:**

```tsx
// Hook com retry, abort e error handling
'use client';
import { useState, useEffect, useCallback } from 'react';

export function useApi<T>({ url, retries = 3, retryDelay = 1000 }) {
  const [data, setData] = useState<T | null>(null);
  const [error, setError] = useState<string | null>(null);
  const [loading, setLoading] = useState(true);

  const fetchData = useCallback(async (signal?: AbortSignal) => {
    setLoading(true);
    for (let attempt = 0; attempt <= retries; attempt++) {
      try {
        const response = await fetch(url, { signal });
        if (!response.ok) throw new Error(`HTTP ${response.status}`);
        const json = await response.json();
        setData(json as T);
        setLoading(false);
        return;
      } catch (err) {
        if (err instanceof DOMException && err.name === 'AbortError') return;
        if (attempt === retries) {
          setError(err instanceof Error ? err.message : 'Erro desconhecido');
          setLoading(false);
        } else {
          await new Promise(r => setTimeout(r, retryDelay * (attempt + 1)));
        }
      }
    }
  }, [url, retries, retryDelay]);

  useEffect(() => {
    const controller = new AbortController();
    fetchData(controller.signal);
    return () => controller.abort();
  }, [fetchData]);

  return { data, error, loading, refetch: () => fetchData() };
}
```

**Casos de uso avançados:**
- Dashboard com múltiplas fontes de dados e dependências entre elas
- Formulário multi-step com validação server-side e optimistic updates
- Sistema de notificações real-time com polling e WebSocket

**Integração com outras skills:**
- `Zustand-Store-TS`: para gerenciar estado de dados da API
- `React-Patterns`: para padrões de hooks e composição
- `Web-Performance-Optimization`: para otimizar carregamento de dados

**Padrões e anti-padrões:**
✅ Fazer: Usar AbortController para cancelar requests desatualizados
✅ Fazer: Implementar retry com backoff exponencial
✅ Fazer: Normalizar erros em um formato consistente
❌ Evitar: Fazer fetch em useEffect sem cleanup
❌ Evitar: Ignorar erros de rede silenciosamente

**Dicas de performance:**
- Usar React Query ou SWR para cache automático e invalidação
- Implementar optimistic updates para melhorar percepção de velocidade
- Prefetch dados da próxima página antes do usuário navegar

**Comandos úteis:**
```bash
npm install @tanstack/react-query
npm install swr
npm install axios
```

**Referências:**
- [React Query Docs](https://tanstack.com/query)
- [SWR Docs](https://swr.vercel.app/)
- [MDN - Fetch API](https://developer.mozilla.org/en-US/docs/Web/API/Fetch_API)

---

### 1.7 Frontend-Lighthouse

**Descrição:** Adicionar um gate portátil do Lighthouse CI para builds de frontend em produção com orçamentos de Core Web Vitals e artefatos de CI.

**Quando usar:**
- Para garantir que builds de produção atendam métricas de performance
- Quando é necessário bloquear deploys com métricas abaixo do esperado
- Para monitorar regressões de performance ao longo do tempo

**Exemplos práticos:**

```yaml
# .github/workflows/lighthouse.yml
name: Lighthouse CI
on:
  pull_request:
    branches: [main]
jobs:
  lighthouse:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with: { node-version: 20 }
      - run: npm ci && npm run build
      - uses: treosh/lighthouse-ci-action@v11
        with:
          configPath: ./lighthouserc.json
          uploadArtifacts: true
```

```json
{
  "ci": {
    "assert": {
      "assertions": {
        "categories:performance": ["error", { "minScore": 0.9 }],
        "categories:accessibility": ["warn", { "minScore": 0.9 }],
        "first-contentful-paint": ["error", { "maxNumericValue": 2000 }],
        "largest-contentful-paint": ["error", { "maxNumericValue": 2500 }],
        "cumulative-layout-shift": ["error", { "maxNumericValue": 0.1 }]
      }
    }
  }
}
```

**Casos de uso avançados:**
- Configurar dashboard de performance com histórico de métricas
- Comparar performance entre branches antes de merge
- Alertar automaticamente quando métricas caem acima de um threshold

**Integração com outras skills:**
- `Web-Performance-Optimization`: para ações corretivas após detectar problemas
- `Fixing-Motion-Performance`: quando animações estão afetando métricas
- `Tailwind-Patterns`: para otimizar CSS que impacta FCP/LCP

**Padrões e anti-padrões:**
✅ Fazer: Rodar Lighthouse em ambiente de CI com hardware consistente
✅ Fazer: Usar medianas de múltiplas execuções para reduzir ruído
❌ Evitar: Rodar Lighthouse em máquina local e considerar como referência
❌ Evitar: Aumentar thresholds quando métricas caem em vez de corrigir

**Dicas de performance:**
- Usar Lighthouse CI com Docker para ambientes reproduzíveis
- Configurar budgets por página (home page vs. dashboard)
- Integrar com Slack/Teams para notificações em tempo real

**Comandos úteis:**
```bash
npm install -g @lhci/cli
lhci autorun
```

**Referências:**
- [Lighthouse CI Docs](https://github.com/GoogleChrome/lighthouse-ci)
- [Core Web Vitals](https://web.dev/vitals/)

---

### 1.8 Full-Output-Enforcement

**Descrição:** Usar quando uma tarefa exigir output exaustivo sem abreviações, arquivos completos ou prevenção estrita de placeholders e código pulado.

**Quando usar:**
- Para gerar código completo sem atalhos ou placeholders
- Quando o projeto exige arquivos funcionais e não snippets
- Para garantir que código gerado por IA seja production-ready

**Exemplos práticos:**

```tsx
// Componente completo de tabela com filtros, ordenação e exportação
import { useState, useCallback, useMemo } from 'react';
import { Search, Download } from 'lucide-react';

export function UsersTable({ users, onExport }) {
  const [search, setSearch] = useState('');
  const [roleFilter, setRoleFilter] = useState('all');
  const [sortField, setSortField] = useState('name');
  const [sortDir, setSortDir] = useState('asc');

  const filteredUsers = useMemo(() => {
    return users
      .filter(u => {
        const matchesSearch = u.name.toLowerCase().includes(search.toLowerCase());
        const matchesRole = roleFilter === 'all' || u.role === roleFilter;
        return matchesSearch && matchesRole;
      })
      .sort((a, b) => {
        const cmp = a[sortField] < b[sortField] ? -1 : 1;
        return sortDir === 'asc' ? cmp : -cmp;
      });
  }, [users, search, roleFilter, sortField, sortDir]);

  const handleSort = useCallback((field) => {
    setSortField(field);
    setSortDir(prev => prev === 'asc' ? 'desc' : 'asc');
  }, []);

  return (
    <div className="bg-white rounded-lg shadow">
      <div className="p-4 border-b flex items-center gap-3">
        <input type="text" placeholder="Buscar..." value={search}
          onChange={e => setSearch(e.target.value)}
          className="px-3 py-2 border rounded-lg text-sm" />
        <select value={roleFilter} onChange={e => setRoleFilter(e.target.value)}
          className="px-3 py-2 border rounded-lg text-sm">
          <option value="all">Todos</option>
          <option value="admin">Admin</option>
          <option value="user">Usuário</option>
        </select>
        <button onClick={() => onExport?.('csv')}
          className="flex items-center gap-2 px-4 py-2 bg-gray-100 rounded-lg text-sm">
          <Download className="w-4 h-4" /> Exportar
        </button>
      </div>
      <table className="w-full">
        <thead>
          <tr className="text-left text-sm text-gray-500 border-b">
            <th className="p-4 cursor-pointer" onClick={() => handleSort('name')}>Nome</th>
            <th className="p-4">Email</th>
            <th className="p-4">Papel</th>
            <th className="p-4">Status</th>
          </tr>
        </thead>
        <tbody>
          {filteredUsers.map(user => (
            <tr key={user.id} className="border-b hover:bg-gray-50">
              <td className="p-4 font-medium">{user.name}</td>
              <td className="p-4 text-gray-600">{user.email}</td>
              <td className="p-4"><span className="px-2 py-1 rounded-full text-xs bg-blue-100 text-blue-800">{user.role}</span></td>
              <td className="p-4"><span className={`px-2 py-1 rounded-full text-xs ${user.status === 'active' ? 'bg-green-100 text-green-800' : 'bg-gray-100 text-gray-800'}`}>{user.status}</span></td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
}
```

**Casos de uso avançados:**
- Gerar componentes completos de formulário com validação, estados e tratamento de erros
- Criar páginas inteiras com navegação, layouts e conteúdo
- Produzir código de integração com APIs que inclua todos os edge cases

**Integração com outras skills:**
- `Frontend-API-Integration-Patterns`: para garantir que chamadas de API são completas
- `React-Patterns`: para seguir padrões modernos de React
- `Fixing-Accessibility`: para garantir acessibilidade em código completo

**Padrões e anti-padrões:**
✅ Fazer: Incluir todos os imports necessários
✅ Fazer: Tratar todos os estados possíveis (loading, error, empty, success)
✅ Fazer: Adicionar tipos TypeScript completos
❌ Evitar: Usar `// TODO` ou `// implement here` como placeholder
❌ Evitar: Pular tratamento de erros ou edge cases

**Dicas de performance:**
- Usar code splitting para componentes grandes gerados
- Validar código gerado com TypeScript strict mode

**Comandos úteis:**
```bash
npx tsc --noEmit
npx eslint src/ --ext .tsx,.ts
```

**Referências:**
- [TypeScript Handbook](https://www.typescriptlang.org/docs/handbook/)
- [React Docs - Thinking in React](https://react.dev/learn/thinking-in-react)

---

### 1.9 GPT-Taste

**Descrição:** Usar ao gerar páginas frontend elite com GSAP, estrutura AIDA rigorosa, tipografia hero ampla e grids bento sem lacunas.

**Quando usar:**
- Para landing pages de alta conversão com animações impressionantes
- Quando o projeto precisa de estrutura AIDA (Attention, Interest, Desire, Action)
- Para páginas onde GSAP é necessário para animações complexas

**Exemplos práticos:**

```tsx
// Hero com GSAP ScrollTrigger
'use client';
import { useEffect, useRef } from 'react';
import { gsap } from 'gsap';
import { ScrollTrigger } from 'gsap/ScrollTrigger';

gsap.registerPlugin(ScrollTrigger);

export function HeroGSAP() {
  const titleRef = useRef(null);

  useEffect(() => {
    gsap.from(titleRef.current, { y: 100, opacity: 0, duration: 1, ease: 'power4.out' });
    gsap.to('.parallax-bg', {
      scrollTrigger: { trigger: '.hero', start: 'top top', end: 'bottom top', scrub: true },
      y: 200,
    });
  }, []);

  return (
    <section className="hero relative min-h-screen overflow-hidden">
      <div className="parallax-bg absolute inset-0 bg-gradient-to-b from-indigo-900 to-purple-900" />
      <div className="relative z-10 flex items-center justify-center min-h-screen">
        <h1 ref={titleRef} className="text-7xl md:text-9xl font-bold text-white">
          Transforme seu negócio
        </h1>
      </div>
    </section>
  );
}
```

```tsx
// Grid Bento sem lacunas
export function FeaturesGrid() {
  return (
    <section className="py-24 px-6">
      <div className="max-w-6xl mx-auto grid grid-cols-1 md:grid-cols-3 gap-4">
        <div className="md:col-span-2 bg-gray-900 rounded-2xl p-8 min-h-[300px]">
          <h3 className="text-2xl font-bold text-white">Feature Principal</h3>
        </div>
        <div className="bg-indigo-600 rounded-2xl p-8 min-h-[300px]">
          <h3 className="text-xl font-bold text-white">Feature 2</h3>
        </div>
        <div className="bg-purple-600 rounded-2xl p-8 min-h-[300px]">
          <h3 className="text-xl font-bold text-white">Feature 3</h3>
        </div>
        <div className="md:col-span-2 bg-gradient-to-r from-pink-500 to-orange-500 rounded-2xl p-8 min-h-[300px]">
          <h3 className="text-2xl font-bold text-white">Feature Destaque</h3>
        </div>
      </div>
    </section>
  );
}
```

**Casos de uso avançados:**
- Landing page de lançamento de produto SaaS com contagem regressiva
- Página de caso de estudo com scroll narrativo e métricas animadas
- Site de agência com apresentação de projetos em grid bento

**Integração com outras skills:**
- `Scroll-Experience`: para experiências de scroll mais avançadas
- `Premium-3D-Website`: quando o projeto inclui elementos 3D
- `Landing-Page-Generator`: para estruturas de conversão otimizadas

**Padrões e anti-padrões:**
✅ Fazer: Seguir estrutura AIDA rigorosamente em landing pages
✅ Fazer: Usar grids bento sem lacunas (gap consistente)
✅ Fazer: Tipografia hero com tamanho mínimo 4rem
❌ Evitar: Sobrecarregar com animações que competem entre si
❌ Evitar: Grids com lacunas visuais que quebram o ritmo
❌ Evitar: Animações que bloqueiam interação do usuário

**Dicas de performance:**
- Usar GSAP ScrollTrigger com `scrub: true` para sincronizar com scroll
- Usar `IntersectionObserver` para ativar animações apenas quando visíveis
- Limitar animações em dispositivos móveis

**Comandos úteis:**
```bash
npm install gsap
npm install @gsap/react
```

**Referências:**
- [GSAP Docs](https://gsap.com/docs/v3/)
- [AIDA Framework](https://en.wikipedia.org/wiki/AIDA_(marketing))
- [Bento Grid CSS](https://www.joshwcomeau.com/css/css-grid-bento-layout/)

---

### 1.10 High-End-Visual-Design

**Descrição:** Usar ao projetar interfaces de agência premium com fontes premium, ritmo espacial, profundidade suave e micro-interações fluidas.

**Quando usar:**
- Para projetos que precisam de design de nível premium e sofisticado
- Quando o produto precisa transmitir exclusividade e qualidade
- Para interfaces onde detalhes visuais são diferenciadores

**Exemplos práticos:**

```tsx
// Card premium com profundidade suave
export function PremiumCard({ title, description, image }) {
  return (
    <div className="group relative bg-white rounded-3xl overflow-hidden shadow-sm hover:shadow-2xl transition-all duration-500">
      <div className="aspect-[4/3] overflow-hidden">
        <img src={image} alt={title}
          className="w-full h-full object-cover group-hover:scale-105 transition-transform duration-700"
          loading="lazy" />
      </div>
      <div className="p-8">
        <h3 className="text-2xl font-serif text-gray-900">{title}</h3>
        <p className="mt-4 text-gray-500 leading-relaxed">{description}</p>
      </div>
    </div>
  );
}
```

```tsx
// Hero com sombras de profundidade suave
export function HeroDepth() {
  return (
    <section className="min-h-screen flex items-center bg-gray-50">
      <div className="max-w-6xl mx-auto px-6 grid md:grid-cols-2 gap-16 items-center">
        <div>
          <h1 className="text-5xl font-serif text-gray-900 leading-tight">
            Experiência exclusiva
          </h1>
          <p className="mt-6 text-lg text-gray-500">Criada para quem busca o melhor em cada detalhe.</p>
        </div>
        <div className="relative">
          <div className="absolute inset-0 bg-gradient-to-br from-indigo-100 to-purple-100 rounded-3xl transform rotate-3" />
          <div className="relative bg-white rounded-3xl p-8 shadow-xl">
            <div className="aspect-square bg-gradient-to-br from-indigo-500 to-purple-600 rounded-2xl" />
          </div>
        </div>
      </div>
    </section>
  );
}
```

**Casos de uso avançados:**
- Site institucional para marca de luxo com transições cinematográficas
- Portfólio de fotografia com visualização em galeria premium
- App financeiro com design que transmite confiança e sofisticação

**Integração com outras skills:**
- `Design-Taste-Frontend`: para calibrar a direção visual
- `Emil-Design-Eng`: para micro-interações de alta qualidade
- `Frontend-Design`: para alinhar com identidade da marca

**Padrões e anti-padrões:**
✅ Fazer: Usar fontes serif para títulos em projetos premium
✅ Fazer: Manter ritmo espacial generoso
✅ Fazer: Usar sombras sutis com blur grande para profundidade
❌ Evitar: Bordas visíveis ou sombras duras
❌ Evitar: Cores saturadas em excesso
❌ Evitar: Animações que parecem "baratas" ou genéricas

**Dicas de performance:**
- Usar `backdrop-filter: blur()` com moderação (impacta GPU)
- Usar `contain: content` em cards para limitar repaints
- Comprimir imagens com WebP/AVIF

**Comandos úteis:**
```bash
npx sharp-cli -i input.jpg -o output.webp
npx svg-sprite-generate icons/*.svg -o sprite.svg
```

**Referências:**
- [Apple Design Resources](https://developer.apple.com/design/resources/)
- [Material Design 3](https://m3.material.io/)

---

### 1.11 Industrial-Brutalist-UI

**Descrição:** Usar ao criar UIs industriais ou de telemetria tática com grids rígidos, tipografia rígida, efeitos CRT e dados de alta densidade.

**Quando usar:**
- Para dashboards industriais ou sistemas de monitoramento
- Quando a informação precisa ser densa e escaneável
- Para interfaces de dados técnicos onde clareza > estética

**Exemplos práticos:**

```tsx
// Dashboard industrial com dados de alta densidade
export function ServerMonitor({ servers }) {
  return (
    <div className="min-h-screen bg-black text-green-400 font-mono p-4">
      <div className="border border-green-400/30 p-2 mb-4">
        <span className="text-xs uppercase tracking-widest">SERVIDOR MONITOR v2.1</span>
      </div>
      <div className="grid grid-cols-4 gap-px">
        {servers.map(server => (
          <div key={server.id} className={`border p-3 ${server.status === 'online' ? 'border-green-400/50' : 'border-red-400/50'}`}>
            <div className="flex justify-between text-xs">
              <span>{server.name}</span>
              <span className={server.status === 'online' ? 'text-green-400' : 'text-red-400'}>●</span>
            </div>
            <div className="mt-2 space-y-1 text-xs">
              <div className="flex justify-between"><span>CPU</span><span>{server.cpu}%</span></div>
              <div className="w-full bg-green-400/20 h-1">
                <div className="bg-green-400 h-1" style={{ width: `${server.cpu}%` }} />
              </div>
            </div>
          </div>
        ))}
      </div>
    </div>
  );
}
```

```tsx
// Efeito CRT com CSS puro
export function CRTEffect({ children }) {
  return (
    <div className="relative">
      <div className="absolute inset-0 pointer-events-none bg-[repeating-linear-gradient(0deg,rgba(0,0,0,0.15),rgba(0,0,0,0.15) 1px,transparent 1px,transparent 2px)]" />
      <div className="relative z-10">{children}</div>
    </div>
  );
}
```

**Casos de uso avançados:**
- Sistema de telemetria para frota de veículos em tempo real
- Dashboard de monitoramento de rede com dados de latência
- Painel de controle industrial com sensores IoT

**Integração com outras skills:**
- `Frontend-API-Integration-Patterns`: para dados real-time de sensores
- `Web-Performance-Optimization`: para manter performance com muitos dados
- `Zustand-Store-TS`: para gerenciar estado de telemetria

**Padrões e anti-padrões:**
✅ Fazer: Usar tipografia monospace para dados numéricos
✅ Fazer: Grids rígidos com hierarquia visual clara
✅ Fazer: Cores semânticas (verde=ok, vermelho=erro, amarelo=atenção)
❌ Evitar: Bordas arredondadas ou sombras suaves
❌ Evitar: Animações que distraem dos dados

**Dicas de performance:**
- Usar Canvas ou WebGL para gráficos com muitos pontos
- Implementar virtualização para listas de dados grandes
- Usar Web Workers para processar dados sem bloquear a UI

**Comandos úteis:**
```bash
npm install d3
npm install @tanstack/react-virtual
```

**Referências:**
- [D3.js Docs](https://d3js.org/)
- [CRT Effects CSS](https://css-tricks.com/old-timey-terminal-styling/)

---

### 1.12 Markstream-Angular

**Descrição:** Integrar o renderizador markstream-angular em aplicações Angular 20+ com componentes standalone, signals e padrões seguros de HTML.

**Quando usar:**
- Para projetos Angular que precisam de renderização de Markdown streaming
- Quando o conteúdo Markdown precisa aparecer progressivamente
- Para documentação interativa em apps Angular

**Exemplos práticos:**

```typescript
// markdown-viewer.component.ts
import { Component, signal } from '@angular/core';
import { MarkstreamModule } from 'markstream-angular';

@Component({
  selector: 'app-markdown-viewer',
  standalone: true,
  imports: [MarkstreamModule],
  template: `
    <div class="prose">
      <markstream-renderer [content]="content()" (streamComplete)="onComplete()">
      </markstream-renderer>
    </div>
  `,
})
export class MarkdownViewerComponent {
  content = signal('');
  onComplete() { console.log('Stream completo'); }
}
```

**Casos de uso avançados:**
- Chat com IA onde respostas aparecem word-by-word em Angular
- Documentação de produto com código interativo inline
- Editor de conteúdo com preview Markdown em tempo real

**Integração com outras skills:**
- `Markstream-Install`: para configuração inicial
- `Markstream-Custom-Components`: para personalizar renderização
- `Frontend-API-Integration-Patterns`: para buscar conteúdo Markdown de APIs

**Padrões e anti-padrões:**
✅ Fazer: Usar signals para reatividade em Angular 20+
✅ Fazer: Configurar sanitização para prevenir XSS
❌ Evitar: Desabilitar sanitização em produção

**Dicas de performance:**
- Usar `OnPush` change detection para reduzir ciclos de verificação
- Lazy load o renderer Markdown quando não usado imediatamente

**Comandos úteis:**
```bash
npm install markstream-angular
ng generate component markdown-viewer --standalone
```

**Referências:**
- [Angular Signals](https://angular.dev/guide/signals)
- [Markstream Docs](https://markstream.dev)

---

### 1.13 Markstream-Custom-Components

**Descrição:** Substituir renderizadores de nós Markstream e adicionar tags customizadas confiáveis em Vue, React, Svelte e Angular.

**Quando usar:**
- Para personalizar como elementos Markdown são renderizados
- Quando é necessário criar componentes customizados para blocos de código, tabelas
- Para manter consistência visual entre Markdown e UI do app

**Exemplos práticos:**

```tsx
// React: Componente customizado para código com syntax highlight
import { Prism as SyntaxHighlighter } from 'react-syntax-highlighter';
import { nightOwl } from 'react-syntax-highlighter/dist/esm/styles/prism';

export const customRenderers = {
  code: ({ className, children }) => {
    const match = /language-(\w+)/.exec(className || '');
    const language = match ? match[1] : '';
    return (
      <div className="relative group">
        <SyntaxHighlighter style={nightOwl} language={language}>
          {String(children).replace(/\n$/, '')}
        </SyntaxHighlighter>
      </div>
    );
  },
};
```

```vue
<!-- Vue: Componente customizado para tabelas -->
<template>
  <div class="overflow-x-auto my-6">
    <table class="min-w-full divide-y divide-gray-200">
      <thead class="bg-gray-50">
        <tr>
          <th v-for="header in headers" :key="header"
            class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">
            {{ header }}
          </th>
        </tr>
      </thead>
      <tbody class="bg-white divide-y divide-gray-200">
        <tr v-for="(row, i) in rows" :key="i">
          <td v-for="(cell, j) in row" :key="j" class="px-6 py-4 text-sm">{{ cell }}</td>
        </tr>
      </tbody>
    </table>
  </div>
</template>
```

**Casos de uso avançados:**
- Sistema de documentação com componentes interativos inline
- Blog com tooltips explicativos em termos técnicos

**Integração com outras skills:**
- `Markstream-Install`: para configuração base
- `Anti-UI-Slop`: para garantir que componentes seguem design system

**Padrões e anti-padrões:**
✅ Fazer: Criar componentes reutilizáveis e encapsulados
✅ Fazer: Manter fallback para quando componente customizado falhar
❌ Evitar: Criar componentes com side effects perigosos

**Dicas de performance:**
- Usar lazy loading para componentes pesados de renderização
- Memoizar componentes customizados com `React.memo` ou `computed`

**Comandos úteis:**
```bash
npm install react-syntax-highlighter
npm install rehype-highlight rehype-raw
```

**Referências:**
- [Markstream Custom Renderers](https://markstream.dev/docs/custom-renderers)
- [rehype Plugins](https://github.com/rehypejs/rehype)

---

### 1.14 Markstream-Install

**Descrição:** Instalar e configurar renderizadores Markstream para Markdown streaming para Vue, React, Svelte, Angular, Nuxt, Next.js e Vue 2.

**Quando usar:**
- Para adicionar renderização de Markdown streaming em qualquer projeto frontend
- Quando o conteúdo precisa aparecer progressivamente (streaming)

**Exemplos práticos:**

```bash
# React / Next.js
npm install markstream-react

# Vue 3
npm install markstream-vue

# Svelte / SvelteKit
npm install markstream-svelte

# Angular 20+
npm install markstream-angular

# Vue 2
npm install markstream-vue2
```

```tsx
// React: Configuração básica
import { MarkstreamProvider, useMarkdownStream } from 'markstream-react';

export function App() {
  return (
    <MarkstreamProvider config={{ sanitize: true, highlight: true }}>
      <MarkdownContent />
    </MarkstreamProvider>
  );
}

function MarkdownContent() {
  const { content, isStreaming } = useMarkdownStream('/api/content/stream');
  return (
    <div className="prose">
      {content}
      {isStreaming && <span className="animate-pulse">▌</span>}
    </div>
  );
}
```

**Casos de uso avançados:**
- Chat com IA onde respostas são streaming
- Documentação que carrega progressivamente

**Integração com outras skills:**
- `Markstream-Custom-Components`: para personalizar renderização
- `Markstream-Migration`: quando migrando de outro renderizador

**Padrões e anti-padrões:**
✅ Fazer: Configurar sanitização para prevenir XSS
✅ Fazer: Usar o renderer específico do framework
❌ Evitar: Desabilitar sanitização sem necessidade

**Dicas de performance:**
- Usar chunks menores para streaming mais suave
- Implementar debounce no renderer para evitar flickering

**Referências:**
- [Markstream Installation](https://markstream.dev/docs/installation)
- [Framework Integration Guides](https://markstream.dev/docs/guides)

---

### 1.15 Markstream-Migration

**Descrição:** Auditar e migrar um renderizador Markdown existente para Markstream preservando renderizadores customizados e comportamento de streaming.

**Quando usar:**
- Para migrar de react-markdown, marked, remark, ou outro renderizador
- Quando o renderizador atual não suporta streaming
- Para consolidar múltiplos renderizadores em um só

**Exemplos práticos:**

```bash
# Encontrar todos os usos do renderizador antigo
grep -r "react-markdown\|from 'marked'\|remark-" src/ --include="*.tsx" --include="*.ts"
```

```tsx
// Antes (react-markdown)
import ReactMarkdown from 'react-markdown';
function MarkdownOld({ content }) {
  return <ReactMarkdown>{content}</ReactMarkdown>;
}

// Depois (Markstream)
import { useMarkdownStream } from 'markstream-react';
function MarkdownNew({ content }) {
  const { rendered } = useMarkdownStream({ content, streaming: false });
  return <div className="prose">{rendered}</div>;
}
```

**Integração com outras skills:**
- `Markstream-Install`: para instalar o novo renderizador
- `Markstream-Custom-Components`: para manter customizações existentes

**Padrões e anti-padrões:**
✅ Fazer: Documentar gaps de paridade antes de migrar
✅ Fazer: Testar com todos os tipos de Markdown usados no projeto
❌ Evitar: Migrar tudo de uma vez em projetos grandes

**Dicas de performance:**
- Criar um script de migração automatizado
- Manter ambos os renderizadores durante período de transição

**Comandos úteis:**
```bash
npx jscodeshift -t ./transforms/migrate-markdown.js src/
npm test -- --testPathPattern="markdown"
```

**Referências:**
- [Markstream Migration Guide](https://markstream.dev/docs/migration)
- [JSCodeshift Docs](https://github.com/facebook/jscodeshift)

---

### 1.16 Markstream-Nuxt

**Descrição:** Integrar markstream-vue em Nuxt 3 ou 4 com limites cliente seguros para SSR, modos de renderizador e CSS explícito.

**Quando usar:**
- Para projetos Nuxt 3 ou 4 que precisam de Markdown streaming
- Quando o conteúdo Markdown precisa funcionar com SSR

**Exemplos práticos:**

```typescript
// nuxt.config.ts
export default defineNuxtConfig({
  modules: ['markstream-vue/nuxt'],
  markstream: { sanitize: true, streaming: true, ssr: true },
});
```

```vue
<!-- pages/blog/[slug].vue -->
<template>
  <article class="prose mx-auto max-w-3xl">
    <MarkstreamRenderer :content="post.content" :streaming="isStreaming" />
  </article>
</template>

<script setup>
const route = useRoute();
const { data: post } = await useFetch(`/api/posts/${route.params.slug}`);
const isStreaming = ref(true);
</script>
```

**Integração com outras skills:**
- `Markstream-Install`: para configuração base do Nuxt
- `Markstream-Custom-Components`: para personalizar renderização

**Padrões e anti-padrões:**
✅ Fazer: Configurar CSS explicitamente para evitar FOUC
✅ Fazer: Usar `<ClientOnly>` para componentes que dependem de browser APIs
❌ Evitar: Usar `window` ou `document` no servidor

**Dicas de performance:**
- Usar `useLazyFetch` para buscar conteúdo Markdown de forma não bloqueante
- Implementar cache de conteúdo já renderizado

**Comandos úteis:**
```bash
npx nuxi init my-blog
npm install markstream-vue
```

**Referências:**
- [Nuxt 3 Docs](https://nuxt.com/docs)
- [Markstream Nuxt Integration](https://markstream.dev/docs/nuxt)

---

### 1.17 Markstream-React

**Descrição:** Integrar markstream-react em React 18+ ou Next.js com pontos de entrada cliente/servidor, CSS, estado de streaming e overrides de componentes.

**Quando usar:**
- Para projetos React ou Next.js que precisam de Markdown streaming
- Para chat com IA ou documentação interativa

**Exemplos práticos:**

```tsx
// React: Streaming com fallback
import { useMarkdownStream } from 'markstream-react';

export function StreamContent({ url }) {
  const { content, isStreaming, error } = useMarkdownStream(url);
  if (error) return <ErrorMessage error={error} />;
  return (
    <div className="prose max-w-3xl">
      <div dangerouslySetInnerHTML={{ __html: content }} />
      {isStreaming && <span className="animate-pulse text-gray-400">Recebendo...</span>}
    </div>
  );
}
```

```tsx
// Next.js: Server Component com Markstream
import { MarkstreamServer } from 'markstream-react/server';

export default async function DocumentationPage({ params }) {
  const content = await fetchDocContent(params.slug);
  return (
    <article className="prose mx-auto max-w-3xl py-12">
      <MarkstreamServer content={content} sanitize />
    </article>
  );
}
```

**Integração com outras skills:**
- `Markstream-Install`: para instalação base
- `NextJS-Best-Practices`: para padrões de Next.js
- `React-Patterns`: para hooks e composição

**Padrões e anti-padrões:**
✅ Fazer: Usar Server Components para Markdown estático
✅ Fazer: Usar Client Components para streaming interativo
❌ Evitar: Colocar Markstream em Server Component quando streaming é necessário

**Dicas de performance:**
- Usar `Suspense` com fallback para streaming
- Usar `next/dynamic` para carregar Markstream sob demanda

**Comandos úteis:**
```bash
npm install markstream-react
```

**Referências:**
- [React 19 Server Components](https://react.dev/reference/rsc/server-components)
- [Markstream React Docs](https://markstream.dev/docs/react)

---

### 1.18 Markstream-Svelte

**Descrição:** Integrar markstream-svelte em Svelte 5 ou SvelteKit com runes, CSS explícito, streaming suave e workers.

**Quando usar:**
- Para projetos Svelte/SvelteKit que precisam de Markdown streaming

**Exemplos práticos:**

```svelte
<!-- +page.svelte -->
<script>
  import { MarkstreamRenderer } from 'markstream-svelte';
  import { streamContent } from '$lib/api';

  let content = $state('');
  let isStreaming = $state(true);

  $effect(() => {
    const unsubscribe = streamContent('/api/docs').subscribe(chunk => {
      content += chunk;
    });
    return () => { unsubscribe(); isStreaming = false; };
  });
</script>

<article class="prose">
  <MarkstreamRenderer {content} streaming={isStreaming} />
</article>
```

**Integração com outras skills:**
- `Markstream-Install`: para configuração base
- `SvelteKit`: para padrões de SvelteKit
- `Markstream-Custom-Components`: para personalizar renderização

**Padrões e anti-padrões:**
✅ Fazer: Usar runes ($state, $effect) para reatividade em Svelte 5
❌ Evitar: Usar stores legados ($store syntax) em Svelte 5

**Dicas de performance:**
- Usar `svelte/motion` para transições suaves no streaming
- Implementar debounce no renderer para evitar flickering

**Comandos úteis:**
```bash
npx sv create my-blog
npm install markstream-svelte
```

**Referências:**
- [Svelte 5 Docs](https://svelte.dev/docs)
- [Markstream Svelte Docs](https://markstream.dev/docs/svelte)

---

### 1.19 Markstream-Vue

**Descrição:** Integrar markstream-vue em Vue 3 puro com modos de renderizador, virtualização e componentes scoped.

**Quando usar:**
- Para projetos Vue 3 que precisam de Markdown streaming
- Quando o conteúdo Markdown precisa de virtualização

**Exemplos práticos:**

```vue
<template>
  <div class="prose">
    <MarkstreamRenderer :content="content" :streaming="isStreaming" :virtualize="true">
      <template #code="{ code, language }">
        <CodeBlock :code="code" :language="language" />
      </template>
    </MarkstreamRenderer>
  </div>
</template>

<script setup>
import { useMarkdownStream } from 'markstream-vue';
const props = defineProps({ url: String });
const { content, isStreaming } = useMarkdownStream(props.url);
</script>
```

**Integração com outras skills:**
- `Markstream-Install`: para instalação base
- `Markstream-Custom-Components`: para personalizar renderização

**Padrões e anti-padrões:**
✅ Fazer: Usar composables para lógica reativa reutilizável
❌ Evitar: Usar `v-html` direto sem sanitização

**Dicas de performance:**
- Usar `v-memo` para evitar re-renderizações desnecessárias
- Implementar debounce no streaming para evitar flickering

**Referências:**
- [Vue 3 Docs](https://vuejs.org/guide/introduction.html)
- [Markstream Vue Docs](https://markstream.dev/docs/vue)

---

### 1.20 Markstream-Vue2

**Descrição:** Integrar markstream-vue2 em Vue 2.6 ou 2.7 com Composition API, CSS e padrões de streaming.

**Quando usar:**
- Para projetos Vue 2 legados que precisam de Markdown streaming
- Quando o projeto não pode migrar para Vue 3

**Exemplos práticos:**

```vue
<template>
  <div class="prose">
    <MarkstreamRenderer :content="content" :streaming="isStreaming" />
  </div>
</template>

<script>
import { MarkstreamRenderer } from 'markstream-vue2';
import { ref, onMounted, onUnmounted } from 'vue';

export default {
  components: { MarkstreamRenderer },
  props: { url: { type: String, required: true } },
  setup(props) {
    const content = ref('');
    const isStreaming = ref(true);
    let eventSource;
    onMounted(() => {
      eventSource = new EventSource(props.url);
      eventSource.onmessage = (e) => { content.value += e.data; };
      eventSource.onerror = () => { isStreaming.value = false; eventSource.close(); };
    });
    onUnmounted(() => eventSource?.close());
    return { content, isStreaming };
  },
};
</script>
```

**Integração com outras skills:**
- `Markstream-Install`: para instalação base
- `Markstream-Vue2-CLI`: para projetos com Vue CLI
- `Markstream-Vue2-Vite`: para projetos com Vite

**Padrões e anti-padrões:**
✅ Fazer: Usar Composition API disponível no Vue 2.7
❌ Evitar: Usar mixins em vez de composables

**Referências:**
- [Vue 2 Docs](https://v2.vuejs.org/)
- [Markstream Vue2 Docs](https://markstream.dev/docs/vue2)

---

### 1.21 Markstream-Vue2-CLI

**Descrição:** Integrar markstream-vue2 em Vue CLI ou Webpack 4 com CSS seguro e fallbacks CDN para workers.

**Quando usar:**
- Para projetos Vue 2 com Vue CLI ou Webpack 4
- Quando o bundler não pode ser atualizado para Vite

**Exemplos práticos:**

```javascript
// vue.config.js
module.exports = {
  configureWebpack: {
    module: { rules: [{ test: /\.md$/, use: 'raw-loader' }] },
  },
  css: { extract: true, loaderOptions: { css: { modules: { auto: () => true } } } },
};
```

**Integração com outras skills:**
- `Markstream-Vue2`: para padrões gerais de Vue 2
- `Markstream-Vue2-Vite`: quando planejar migração para Vite

**Referências:**
- [Vue CLI Docs](https://cli.vuejs.org/)
- [Markstream Vue2 CLI Guide](https://markstream.dev/docs/vue2-cli)

---

### 1.22 Markstream-Vue2-Vite

**Descrição:** Integrar markstream-vue2 em Vue 2 com Vite com imports de worker bundled e ordenação de CSS.

**Quando usar:**
- Para projetos Vue 2 usando Vite como bundler
- Quando planeja migrar de Webpack para Vite

**Exemplos práticos:**

```typescript
// vite.config.ts
import { defineConfig } from 'vite';
import vue from '@vitejs/plugin-vue2';

export default defineConfig({
  plugins: [vue()],
  css: { modules: { localsConvention: 'camelCase' } },
  worker: { format: 'es' },
});
```

**Integração com outras skills:**
- `Markstream-Vue2`: para padrões gerais de Vue 2
- `Tailwind-Patterns`: para estilos modernos com Vite

**Referências:**
- [Vite Docs](https://vitejs.dev/)
- [Markstream Vue2 Vite Guide](https://markstream.dev/docs/vue2-vite)

---

### 1.23 Minimalist-UI

**Descrição:** Usar ao criar interfaces editoriais limpas com paletas monocromáticas quentes, bordas nítidas, movimento contido e layouts bento planos.

**Quando usar:**
- Para sites de conteúdo, blogs ou portfólios com design minimalista
- Quando o foco deve ser no conteúdo, não na decoração

**Exemplos práticos:**

```tsx
export function ArticlePage({ article }) {
  return (
    <article className="min-h-screen bg-stone-50">
      <header className="max-w-2xl mx-auto px-6 pt-24 pb-12">
        <span className="text-xs uppercase tracking-widest text-stone-400">{article.category}</span>
        <h1 className="mt-4 text-4xl md:text-5xl font-serif text-stone-900 leading-tight">{article.title}</h1>
      </header>
      <div className="max-w-2xl mx-auto px-6 pb-24">
        <div className="prose prose-stone prose-lg">{article.content}</div>
      </div>
    </article>
  );
}
```

```tsx
export function PortfolioGrid({ projects }) {
  return (
    <section className="max-w-6xl mx-auto px-6 py-24">
      <div className="grid grid-cols-1 md:grid-cols-2 gap-8">
        {projects.map((project, i) => (
          <div key={project.id} className={`group cursor-pointer ${i % 3 === 0 ? 'md:col-span-2 aspect-[2/1]' : 'aspect-square'}`}>
            <img src={project.image} alt={project.title} className="w-full h-full object-cover group-hover:scale-105 transition-transform duration-700" loading="lazy" />
            <h3 className="mt-4 text-lg font-medium">{project.title}</h3>
          </div>
        ))}
      </div>
    </section>
  );
}
```

**Integração com outras skills:**
- `Design-Taste-Frontend`: para calibrar a direção visual
- `High-End-Visual-Design`: quando precisa de mais sofisticação
- `Anti-UI-Slop`: para garantir que o minimalismo não vire genérico

**Padrões e anti-padrões:**
✅ Fazer: Usar paleta monocromática quente
✅ Fazer: Manter whitespace generoso como elemento de design
❌ Evitar: Mais de 2-3 cores no mesmo layout
❌ Evitar: Bordas decorativas ou sombras desnecessárias

**Referências:**
- [Minimalist Design Principles](https://www.designboom.com/design/minimalist-design-principles/)
- [Typography Scale](https://typescale.com/)

### 1.24 NextJS-Best-Practices

**Descrição:** Princípios do Next.js App Router. Server Components, padrões de data fetching, rotas.

**Quando usar:**
- Para projetos Next.js que precisam seguir best practices modernas
- Quando há dúvida sobre Server vs. Client Components
- Para implementar data fetching correto no App Router

**Exemplos práticos:**

```tsx
// Server Component: página com data fetching
// app/dashboard/page.tsx
import { Suspense } from 'react';
import { DashboardStats } from './DashboardStats';

export default async function DashboardPage() {
  const user = await getUser();
  const stats = await getStats(user.id);

  return (
    <div className="p-8">
      <h1 className="text-2xl font-bold">Olá, {user.name}</h1>
      <div className="mt-8 grid grid-cols-3 gap-6">
        <Suspense fallback={<StatsSkeleton />}>
          <DashboardStats stats={stats} />
        </Suspense>
      </div>
    </div>
  );
}
```

```tsx
// Client Component: formulário interativo
'use client';
import { useState } from 'react';
import { useFormStatus } from 'react-dom';

function SubmitButton() {
  const { pending } = useFormStatus();
  return (
    <button type="submit" disabled={pending} className="px-4 py-2 bg-blue-600 text-white rounded-lg disabled:opacity-50">
      {pending ? 'Enviando...' : 'Enviar'}
    </button>
  );
}

export function ContactForm() {
  const [message, setMessage] = useState('');
  return (
    <form action={submitContact} className="space-y-4">
      <textarea value={message} onChange={e => setMessage(e.target.value)} className="w-full p-3 border rounded-lg" />
      <SubmitButton />
    </form>
  );
}
```

```tsx
// Dynamic Route com generateStaticParams
export async function generateStaticParams() {
  const posts = await fetchAllPosts();
  return posts.map((post) => ({ slug: post.slug }));
}

export default async function BlogPost({ params }) {
  const post = await fetchPost(params.slug);
  return <article className="prose">{post.content}</article>;
}
```

**Casos de uso avançados:**
- Dashboard com autenticação e data fetching server-side
- Blog com ISR (Incremental Static Regeneration)
- App SaaS com rotas dinâmicas e middleware

**Integração com outras skills:**
- `React-Patterns`: para padrões React modernos
- `Frontend-API-Integration-Patterns`: para data fetching
- `Web-Performance-Optimization`: para otimizar performance

**Padrões e anti-padrões:**
✅ Fazer: Usar Server Components por padrão
✅ Fazer: Usar `'use client'` apenas quando necessário
✅ Fazer: Usar `Suspense` para streaming e fallbacks
❌ Evitar: Colocar lógica pesada em Server Components
❌ Evitar: Passar funções como props de Server para Client Components

**Dicas de performance:**
- Usar `revalidate` para ISR
- Implementar `loading.tsx` para feedback de carregamento
- Usar `generateStaticParams` para rotas estáticas

**Comandos úteis:**
```bash
npx create-next-app@latest my-app
ANALYZE=true npm run build
```

**Referências:**
- [Next.js Docs](https://nextjs.org/docs)
- [Server Components](https://nextjs.org/docs/app/building-your-application/rendering/server-components)

---

### 1.25 Premium-3D-Website

**Descrição:** Diretrizes para construir sites 3D premium com shaders WebGL customizados, pós-processamento, interações baseadas em física e otimização de dispositivos.

**Quando usar:**
- Para sites com experiências 3D interativas e imersivas
- Quando o produto precisa de visualização 3D de alta qualidade

**Exemplos práticos:**

```tsx
'use client';
import { Canvas } from '@react-three/fiber';
import { OrbitControls, Environment, Float } from '@react-three/drei';
import { Suspense } from 'react';

function ProductModel() {
  return (
    <Float speed={1.4} rotationIntensity={0.5}>
      <mesh>
        <torusKnotGeometry args={[1, 0.3, 128, 32]} />
        <meshStandardMaterial color="#6366f1" roughness={0.2} metalness={0.8} />
      </mesh>
    </Float>
  );
}

export function ProductViewer() {
  return (
    <div className="h-screen">
      <Canvas camera={{ position: [0, 0, 5], fov: 45 }}>
        <Suspense fallback={null}>
          <ambientLight intensity={0.5} />
          <ProductModel />
          <OrbitControls enableZoom={false} />
          <Environment preset="studio" />
        </Suspense>
      </Canvas>
    </div>
  );
}
```

**Integração com outras skills:**
- `GPT-Taste`: para estrutura AIDA e landing page
- `Scroll-Experience`: para animações de scroll 3D
- `Web-Performance-Optimization`: para otimizar renderização 3D

**Padrões e anti-padrões:**
✅ Fazer: Usar preloader para esconder carregamento de assets 3D
✅ Fazer: Detectar capabilities do device e reduzir qualidade se necessário
❌ Evitar: Carregar modelos 3D pesados sem lazy loading
❌ Evitar: Usar WebGL sem fallback para dispositivos antigos

**Referências:**
- [Three.js Docs](https://threejs.org/)
- [React Three Fiber Docs](https://docs.pmnd.rs/react-three-fiber/)

---

### 1.26 React-Patterns

**Descrição:** Padrões modernos e princípios do React. Hooks, composição, performance, best practices de TypeScript.

**Quando usar:**
- Para desenvolvimento React que precisa seguir padrões modernos
- Quando há dúvida sobre qual hook ou padrão usar
- Para revisar código e garantir qualidade

**Exemplos práticos:**

```tsx
// Compound Component Pattern
import { createContext, useContext, useState } from 'react';

const TabsContext = createContext(null);

function useTabs() {
  const context = useContext(TabsContext);
  if (!context) throw new Error('useTabs must be used within Tabs');
  return context;
}

export function Tabs({ children, defaultTab }) {
  const [activeTab, setActiveTab] = useState(defaultTab);
  return (
    <TabsContext.Provider value={{ activeTab, setActiveTab }}>
      <div>{children}</div>
    </TabsContext.Provider>
  );
}

export function Tab({ id, children }) {
  const { activeTab, setActiveTab } = useTabs();
  return (
    <button role="tab" aria-selected={activeTab === id}
      onClick={() => setActiveTab(id)}
      className={`px-4 py-2 ${activeTab === id ? 'border-b-2 border-blue-500' : ''}`}>
      {children}
    </button>
  );
}

export function TabPanel({ id, children }) {
  const { activeTab } = useTabs();
  if (activeTab !== id) return null;
  return <div role="tabpanel">{children}</div>;
}
```

```tsx
// Custom Hook com TypeScript
function useLocalStorage(key, initialValue) {
  const [storedValue, setStoredValue] = useState(() => {
    try {
      const item = window.localStorage.getItem(key);
      return item ? JSON.parse(item) : initialValue;
    } catch { return initialValue; }
  });

  const setValue = (value) => {
    const valueToStore = value instanceof Function ? value(storedValue) : value;
    setStoredValue(valueToStore);
    window.localStorage.setItem(key, JSON.stringify(valueToStore));
  };

  return [storedValue, setValue];
}
```

**Integração com outras skills:**
- `Zustand-Store-TS`: para gerenciamento de estado global
- `Frontend-API-Integration-Patterns`: para data fetching
- `Fixing-Accessibility`: para garantir acessibilidade

**Padrões e anti-padrões:**
✅ Fazer: Usar Compound Components para APIs flexíveis
✅ Fazer: Criar hooks customizados para lógica reutilizável
❌ Evitar: Props drilling excessivo
❌ Evitar: Lógica complexa dentro de componentes

**Dicas de performance:**
- Usar `React.memo` para componentes que renderizam frequentemente
- Usar `useMemo` para cálculos pesados
- Usar `useCallback` para funções passadas como props
- Implementar code splitting com `React.lazy`

**Referências:**
- [React Docs](https://react.dev/)
- [React Patterns](https://reactpatterns.com/)
- [usehooks.com](https://usehooks.com/)

---

### 1.27 Redesign-Existing-Projects

**Descrição:** Usar ao atualizar sites ou apps existentes auditando padrões de UI genéricos e aplicando correções de design premium sem reescritas.

**Quando usar:**
- Para modernizar interfaces legadas sem reescrever tudo
- Quando o design atual é genérico ou desatualizado

**Exemplos práticos:**

```tsx
// ANTES
function OldCard({ title, description }) {
  return (
    <div className="p-4 border rounded">
      <h3 className="text-lg">{title}</h3>
      <p>{description}</p>
    </div>
  );
}

// DEPOIS
function RedesignedCard({ title, description, image, href }) {
  return (
    <a href={href} className="group block bg-white rounded-2xl overflow-hidden shadow-sm hover:shadow-xl transition-all duration-300">
      {image && (
        <div className="aspect-[16/10] overflow-hidden">
          <img src={image} alt={title} className="w-full h-full object-cover group-hover:scale-105 transition-transform duration-500" loading="lazy" />
        </div>
      )}
      <div className="p-6">
        <h3 className="text-xl font-semibold text-gray-900">{title}</h3>
        <p className="mt-2 text-gray-500 leading-relaxed">{description}</p>
      </div>
    </a>
  );
}
```

**Integração com outras skills:**
- `Anti-UI-Slop`: para identificar padrões genéricos
- `Frontend-Design`: para definir nova identidade visual
- `Web-Performance-Optimization`: para garantir que redesign não afeta performance

**Padrões e anti-padrões:**
✅ Fazer: Auditar antes de redesign
✅ Fazer: Aplicar mudanças incrementalmente
❌ Evitar: Reescrever tudo de uma vez
❌ Evitar: Mudar comportamento junto com visual

**Referências:**
- [Design Audit Guide](https://www.smashingmagazine.com/2022/01/design-audit-checklist/)

---

### 1.28 Review-Animations

**Descrição:** Usar ao revisar código de animação e movimento contra padrão rigoroso de craft, performance, acessibilidade e qualidade de interação.

**Quando usar:**
- Para auditar e melhorar animações existentes
- Quando há problemas de performance com animações
- Para garantir acessibilidade em animações

**Exemplos práticos:**

```tsx
'use client';
import { motion, useReducedMotion } from 'framer-motion';

export function AccessibleAnimation({ children }) {
  const shouldReduceMotion = useReducedMotion();
  return (
    <motion.div
      initial={shouldReduceMotion ? { opacity: 0 } : { opacity: 0, y: 20 }}
      animate={shouldReduceMotion ? { opacity: 1 } : { opacity: 1, y: 0 }}
      transition={shouldReduceMotion ? { duration: 0.01 } : { type: 'spring', stiffness: 260, damping: 20 }}>
      {children}
    </motion.div>
  );
}
```

**Integração com outras skills:**
- `Fixing-Motion-Performance`: para correções de performance
- `Emil-Design-Eng`: para padrões de micro-interação
- `Frontend-Lighthouse`: para métricas de performance

**Padrões e anti-padrões:**
✅ Fazer: Usar `prefers-reduced-motion` em todas as animações
✅ Fazer: Animar apenas propriedades do compositor
❌ Evitar: Animações que causam layout shift
❌ Evitar: Mais de 3 animações simultâneas

**Referências:**
- [Web Animations API](https://developer.mozilla.org/en-US/docs/Web/API/Web_Animations_API)
- [A11y Motion Guidelines](https://www.w3.org/WAI/WCAG21/Understanding/animation-or-motion.html)

---

### 1.29 Stitch-Design-Taste

**Descrição:** Usar ao gerar sistemas DESIGN.md do Google Stitch para tipografia premium, cores, layout, intenção de movimento e regras anti-UI genérica.

**Quando usar:**
- Para criar design systems documentados e consistentes
- Quando o projeto precisa de um DESIGN.md como fonte da verdade
- Para padronizar decisões visuais em equipes

**Exemplos práticos:**

```markdown
# Design System - Meu Projeto

## Identidade Visual
- **Personalidade:** Profissional, confiável, moderno
- **Indústria:** SaaS B2B

## Paleta de Cores
- **Primária:** #6366f1 (Indigo 500)
- **Secundária:** #f59e0b (Amber 500)
- **Superfície:** #ffffff (White)
- **Texto Principal:** #111827 (Gray 900)

## Tipografia
- **Títulos:** Inter Bold, 2.5rem (H1), 2rem (H2)
- **Corpo:** Inter Regular, 1rem, line-height 1.6

## Espaçamento
- Sistema de 8px: 2, 4, 8, 12, 16, 24, 32, 48, 64, 96

## Animações
- **Duração padrão:** 200ms
- **Easing:** ease-out para entradas
- **Propriedades:** apenas transform e opacity
```

**Integração com outras skills:**
- `Anti-UI-Slop`: para implementar as regras documentadas
- `Design-Taste-Frontend`: para definir a direção visual

**Padrões e anti-padrões:**
✅ Fazer: Documentar TODAS as decisões visuais no DESIGN.md
✅ Fazer: Manter DESIGN.md atualizado
❌ Evitar: Ter um DESIGN.md que ninguém consulta
❌ Evitar: Deixar decisões visuais para "gosto pessoal"

**Referências:**
- [Design Tokens W3C](https://design-tokens.github.io/community-group/format/)

---

### 1.30 SvelteKit

**Descrição:** Construir aplicações web full-stack com SvelteKit — rotas baseadas em arquivo, SSR, SSG, rotas API e form actions em um único framework.

**Quando usar:**
- Para projetos full-stack que preferem Svelte over React/Vue
- Quando SSR e SSG são necessários no mesmo projeto
- Para apps com form actions server-side

**Exemplos práticos:**

```svelte
<script>
  /** @type {import('./$types').PageData} */
  export let data;
</script>

<article class="prose mx-auto max-w-3xl py-12">
  <h1>{data.post.title}</h1>
  {@html data.post.content}
</article>
```

```typescript
// src/routes/blog/[slug]/+page.server.ts
import { error } from '@sveltejs/kit';
import { db } from '$lib/database';

export async function load({ params }) {
  const post = await db.post.findUnique({ where: { slug: params.slug } });
  if (!post) throw error(404, 'Post não encontrado');
  return { post };
}
```

```svelte
<script>
  import { enhance } from '$app/forms';
  export let form;
</script>

<form method="POST" use:enhance>
  <input name="email" type="email" required />
  <textarea name="message" required />
  <button type="submit">Enviar</button>
</form>

{#if form?.success}
  <p class="text-green-600">Mensagem enviada com sucesso!</p>
{/if}
```

**Integração com outras skills:**
- `Markstream-Svelte`: para renderização Markdown streaming
- `Web-Performance-Optimization`: para otimizar SSR/SSG

**Padrões e anti-padrões:**
✅ Fazer: Usar `+page.server.ts` para lógica server-side
✅ Fazer: Usar `use:enhance` para form actions
❌ Evitar: Colocar lógica server-side em `+page.svelte`

**Referências:**
- [SvelteKit Docs](https://kit.svelte.dev/docs)
- [Svelte Docs](https://svelte.dev/docs)

---

### 1.31 Tailwind-Patterns

**Descrição:** Princípios do Tailwind CSS v4. Configuração CSS-first, container queries, padrões modernos, arquitetura de design tokens.

**Quando usar:**
- Para projetos que usam Tailwind CSS e precisam de padrões modernos
- Quando o design system precisa ser implementado com Tailwind

**Exemplos práticos:**

```css
@import "tailwindcss";

@theme {
  --color-primary: #6366f1;
  --color-surface: #ffffff;
  --font-display: "Inter", sans-serif;
  --font-mono: "JetBrains Mono", monospace;
}
```

```tsx
// Container Queries com Tailwind v4
export function ResponsiveCard() {
  return (
    <div className="@container">
      <div className="flex flex-col @md:flex-row @md:items-center @md:gap-4">
        <div className="@md:w-1/3">
          <img src="/image.jpg" alt="Produto" className="w-full rounded-lg" />
        </div>
        <div className="@md:w-2/3">
          <h3 className="text-lg font-bold @lg:text-xl">Produto Premium</h3>
        </div>
      </div>
    </div>
  );
}
```

**Integração com outras skills:**
- `Stitch-Design-Taste`: para documentar tokens
- `Anti-UI-Slop`: para garantir que classes pertencem ao design system
- `Web-Performance-Optimization`: para otimizar CSS

**Padrões e anti-padrões:**
✅ Fazer: Usar `@theme` para definir tokens em CSS-first (v4)
✅ Fazer: Usar container queries quando possível
❌ Evitar: Usar `@apply` em excesso
❌ Evitar: Quebrar classes com string interpolation

**Referências:**
- [Tailwind CSS v4 Docs](https://tailwindcss.com/docs)
- [Container Queries MDN](https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_containment/Container_queries)

---

### 1.32 Zustand-Store-TS

**Descrição:** Criar stores Zustand seguindo padrões estabelecidos com tipos TypeScript apropriados e middleware.

**Quando usar:**
- Para gerenciamento de estado em projetos React com Zustand
- Quando o estado é compartilhado entre múltiplos componentes
- Para gerenciar estado complexo com persistência e devtools

**Exemplos práticos:**

```typescript
import { create } from 'zustand';
import { persist, devtools } from 'zustand/middleware';
import { immer } from 'zustand/middleware/immer';

interface User { id: string; name: string; email: string; role: 'admin' | 'user'; }

interface AuthState {
  user: User | null;
  token: string | null;
  isAuthenticated: boolean;
  login: (email: string, password: string) => Promise<void>;
  logout: () => void;
  updateUser: (updates: Partial<User>) => void;
}

export const useAuthStore = create<AuthState>()(
  devtools(
    persist(
      immer((set) => ({
        user: null, token: null, isAuthenticated: false,
        login: async (email, password) => {
          const response = await fetch('/api/auth/login', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ email, password }),
          });
          if (!response.ok) throw new Error('Credenciais inválidas');
          const { user, token } = await response.json();
          set((state) => { state.user = user; state.token = token; state.isAuthenticated = true; });
        },
        logout: () => { set((state) => { state.user = null; state.token = null; state.isAuthenticated = false; }); },
        updateUser: (updates) => { set((state) => { if (state.user) Object.assign(state.user, updates); }); },
      })),
      { name: 'auth-storage' }
    ),
    { name: 'AuthStore' }
  )
);
```

```typescript
// stores/cartStore.ts
import { create } from 'zustand';
import { persist } from 'zustand/middleware';

interface CartItem { id: string; name: string; price: number; quantity: number; }

interface CartState {
  items: CartItem[];
  addItem: (item: Omit<CartItem, 'quantity'>) => void;
  removeItem: (id: string) => void;
  clearCart: () => void;
  total: () => number;
}

export const useCartStore = create<CartState>()(
  persist(
    (set, get) => ({
      items: [],
      addItem: (item) => set((state) => {
        const existing = state.items.find((i) => i.id === item.id);
        if (existing) return { items: state.items.map((i) => i.id === item.id ? { ...i, quantity: i.quantity + 1 } : i) };
        return { items: [...state.items, { ...item, quantity: 1 }] };
      }),
      removeItem: (id) => set((state) => ({ items: state.items.filter((i) => i.id !== id) })),
      clearCart: () => set({ items: [] }),
      total: () => get().items.reduce((sum, item) => sum + item.price * item.quantity, 0),
    }),
    { name: 'cart-storage' }
  )
);
```

**Integração com outras skills:**
- `React-Patterns`: para hooks e composição
- `Frontend-API-Integration-Patterns`: para data fetching
- `NextJS-Best-Practices`: para uso em Server/Client Components

**Padrões e anti-padrões:**
✅ Fazer: Usar TypeScript para tipar todos os estados
✅ Fazer: Usar middleware para funcionalidades adicionais
✅ Fazer: Dividir stores por domínio
❌ Evitar: Store monolítico com tudo junto
❌ Evitar: Mutar estado diretamente

**Dicas de performance:**
- Usar seletores para evitar re-renderizações desnecessárias
- Usar `shallow` comparison com `useShallow`

**Referências:**
- [Zustand Docs](https://github.com/pmndrs/zustand)
- [Zustand TypeScript](https://docs.pmnd.rs/zustand/guides/typescript)

---

## 2. Front End Category Pointer (14 skills)

---

### 2.1 Chat-Widget

**Descrição:** Construir sistema de chat de suporte em tempo real com widget flutuante para usuários e dashboard admin para equipe de suporte.

**Quando usar:**
- Quando o usuário quiser chat ao vivo, suporte ao cliente
- Para mensagens em tempo real ou suporte in-app
- Quando é necessário widget de chat flutuante

**Exemplos práticos:**

```tsx
'use client';
import { useState, useRef, useEffect } from 'react';
import { MessageSquare, X, Send } from 'lucide-react';

export function ChatWidget() {
  const [isOpen, setIsOpen] = useState(false);
  const [messages, setMessages] = useState([]);
  const [input, setInput] = useState('');
  const messagesEndRef = useRef(null);

  useEffect(() => { messagesEndRef.current?.scrollIntoView({ behavior: 'smooth' }); }, [messages]);

  const sendMessage = () => {
    if (!input.trim()) return;
    setMessages(prev => [...prev, { role: 'user', text: input }]);
    setInput('');
    setTimeout(() => {
      setMessages(prev => [...prev, { role: 'agent', text: 'Obrigado por sua mensagem!' }]);
    }, 1000);
  };

  return (
    <div className="fixed bottom-4 right-4 z-50">
      {isOpen ? (
        <div className="w-80 h-96 bg-white rounded-lg shadow-2xl border flex flex-col">
          <div className="p-4 bg-blue-600 text-white rounded-t-lg flex justify-between items-center">
            <span className="font-medium">Suporte ao Cliente</span>
            <button onClick={() => setIsOpen(false)}><X className="w-5 h-5" /></button>
          </div>
          <div className="flex-1 overflow-y-auto p-4 space-y-3">
            {messages.map((msg, i) => (
              <div key={i} className={`flex ${msg.role === 'user' ? 'justify-end' : 'justify-start'}`}>
                <div className={`max-w-[70%] p-3 rounded-lg ${msg.role === 'user' ? 'bg-blue-600 text-white' : 'bg-gray-100'}`}>{msg.text}</div>
              </div>
            ))}
            <div ref={messagesEndRef} />
          </div>
          <div className="p-3 border-t flex gap-2">
            <input value={input} onChange={e => setInput(e.target.value)} onKeyPress={e => e.key === 'Enter' && sendMessage()} className="flex-1 px-3 py-2 border rounded-lg text-sm" placeholder="Digite sua mensagem..." />
            <button onClick={sendMessage} className="p-2 bg-blue-600 text-white rounded-lg"><Send className="w-4 h-4" /></button>
          </div>
        </div>
      ) : (
        <button onClick={() => setIsOpen(true)} className="w-14 h-14 bg-blue-600 text-white rounded-full shadow-lg hover:bg-blue-700 transition-colors flex items-center justify-center">
          <MessageSquare className="w-6 h-6" />
        </button>
      )}
    </div>
  );
}
```

**Integração com outras skills:**
- `Frontend-API-Integration-Patterns`: para WebSocket e tempo real
- `Fixing-Accessibility`: para garantir acessibilidade do chat
- `Progressive-Web-App`: para notificações push

**Padrões e anti-padrões:**
✅ Fazer: Usar WebSocket para mensagens em tempo real
✅ Fazer: Adicionar indicador de "digitando..."
❌ Evitar: Polling em vez de WebSocket
❌ Evitar: Enviar mensagens sem confirmação de entrega

**Referências:**
- [Socket.io Docs](https://socket.io/docs/)
- [WebSockets MDN](https://developer.mozilla.org/en-US/docs/Web/API/WebSockets_API)

---

### 2.2 Chrome-Extension-Developer

**Descrição:** Especialista em construir Chrome Extensions usando Manifest V3. Cobre scripts de background, service workers, scripts de conteúdo e comunicação entre contextos.

**Quando usar:**
- Para desenvolver extensões para navegador Chrome
- Quando é necessário interceptar ou modificar páginas web

**Exemplos práticos:**

```json
{
  "manifest_version": 3,
  "name": "Minha Extensão",
  "version": "1.0.0",
  "permissions": ["activeTab", "storage"],
  "action": { "default_popup": "popup.html" },
  "background": { "service_worker": "background.js" },
  "content_scripts": [{ "matches": ["<all_urls>"], "js": ["content.js"] }]
}
```

```javascript
// background.js (Service Worker)
chrome.runtime.onMessage.addListener((message, sender, sendResponse) => {
  if (message.type === 'GET_DATA') {
    chrome.storage.local.get('data', (result) => { sendResponse({ data: result.data }); });
    return true;
  }
});
```

**Integração com outras skills:**
- `Fixing-Accessibility`: para acessibilidade da extensão
- `React-Patterns`: para UI da extensão com React

**Padrões e anti-padrões:**
✅ Fazer: Usar Manifest V3
✅ Fazer: Minimizar permissões
❌ Evitar: Injetar scripts pesados em todas as páginas

**Referências:**
- [Chrome Extensions Docs](https://developer.chrome.com/docs/extensions/)
- [Manifest V3 Migration](https://developer.chrome.com/docs/extensions/develop/migrate/what-is-mv3)

---

### 2.3 Fixing-Accessibility

**Descrição:** Auditar e corrigir problemas de acessibilidade HTML incluindo labels ARIA, navegação por teclado, gerenciamento de foco, contraste de cores e erros de formulário.

**Quando usar:**
- Para adicionar controles interativos, formulários, diálogos
- Quando revisar conformidade WCAG
- Para tornar componentes acessíveis por teclado e leitores de tela

**Exemplos práticos:**

```tsx
export function AccessibleModal({ isOpen, onClose, title, children }) {
  const closeRef = useRef(null);
  useEffect(() => { if (isOpen) closeRef.current?.focus(); }, [isOpen]);
  useEffect(() => {
    const h = (e) => { if (e.key === 'Escape') onClose(); };
    if (isOpen) { document.addEventListener('keydown', h); document.body.style.overflow = 'hidden'; }
    return () => { document.removeEventListener('keydown', h); document.body.style.overflow = ''; };
  }, [isOpen, onClose]);
  if (!isOpen) return null;
  return (
    <div role="dialog" aria-modal="true" aria-labelledby="modal-title" className="fixed inset-0 z-50 flex items-center justify-center">
      <div className="fixed inset-0 bg-black/50" onClick={onClose} />
      <div className="relative bg-white rounded-lg p-6 max-w-md w-full mx-4 shadow-xl">
        <h2 id="modal-title" className="text-xl font-bold">{title}</h2>
        <div className="mt-4">{children}</div>
        <button ref={closeRef} onClick={onClose} className="mt-4 px-4 py-2 bg-gray-100 rounded-lg">Fechar</button>
      </div>
    </div>
  );
}
```

```tsx
// Formulário acessível com validação
export function AccessibleForm() {
  const [errors, setErrors] = useState({});
  const validate = (field, value) => {
    const e = { ...errors };
    if (!value) e[field] = `${field} é obrigatório`;
    else delete e[field];
    setErrors(e);
  };
  return (
    <form>
      <label htmlFor="email" className="block text-sm font-medium">Email</label>
      <input id="email" type="email" aria-invalid={!!errors.email} aria-describedby={errors.email ? 'email-error' : undefined} onBlur={(ev) => validate('email', ev.target.value)} />
      {errors.email && <p id="email-error" className="text-red-500 text-sm">{errors.email}</p>}
    </form>
  );
}
```

**Integração com outras skills:**
- `React-Patterns`: para padrões acessíveis
- `Frontend-Lighthouse`: para pontuação de acessibilidade

**Padrões e anti-padrões:**
✅ Fazer: Usar `aria-label` e `aria-describedby`
✅ Fazer: Gerenciar foco em diálogos
❌ Evitar: Usar `<div onClick>` sem `role="button"` e `tabIndex`

**Referências:**
- [WCAG 2.1 Guidelines](https://www.w3.org/WAI/WCAG21/quickref/)
- [ARIA Authoring Practices](https://www.w3.org/WAI/ARIA/apd/)

---

### 2.4 Fixing-Metadata

**Descrição:** Auditar e corrigir metadados HTML incluindo títulos de página, meta descriptions, URLs canônicas, Open Graph tags, Twitter cards, favicons, dados estruturados JSON-LD e diretrizes robots.

**Quando usar:**
- Para melhorar SEO e compartilhamento em redes sociais
- Quando links compartilhados não aparecem corretamente

**Exemplos práticos:**

```tsx
// Metadados completos para Next.js
export const metadata = {
  title: { default: 'Meu Site', template: '%s | Meu Site' },
  description: 'Descrição do site para SEO',
  openGraph: { title: 'Meu Site', description: 'Descrição', url: 'https://meusite.com', images: [{ url: '/og-image.png', width: 1200, height: 630 }], locale: 'pt_BR', type: 'website' },
  twitter: { card: 'summary_large_image', title: 'Meu Site', images: ['/og-image.png'] },
  robots: { index: true, follow: true },
  alternates: { canonical: 'https://meusite.com' },
};

export default function RootLayout({ children }) {
  return (<html lang="pt-BR"><head><link rel="icon" href="/favicon.ico" /></head><body>{children}</body></html>);
}
```

```tsx
// JSON-LD para artigo
export function BlogArticleLD({ article }) {
  const jsonLd = { '@context': 'https://schema.org', '@type': 'BlogPosting', headline: article.title, description: article.description, datePublished: article.publishedAt };
  return <script type="application/ld+json" dangerouslySetInnerHTML={{ __html: JSON.stringify(jsonLd) }} />;
}
```

**Integração com outras skills:**
- `NextJS-Best-Practices`: para metadados em App Router
- `Web-Performance-Optimization`: para não impactar performance

**Referências:**
- [Open Graph Protocol](https://ogp.me/)
- [Next.js Metadata API](https://nextjs.org/docs/app/api-reference/functions/generate-metadata)

---

### 2.5 Fixing-Motion-Performance

**Descrição:** Auditar e corrigir problemas de performance de animação incluindo layout thrashing, propriedades de compositor, movimento vinculado ao scroll e efeitos de blur.

**Quando usar:**
- Quando animações stutter, transições jank
- Ao revisar performance de animações CSS/JS

**Exemplos práticos:**

```css
/* ANTES: Layout thrashing */
.bad { transition: width 0.3s ease; }

/* DEPOIS: Usar transform */
.good { transition: transform 0.3s ease; }
.good.animate { transform: scaleX(1); }
```

```tsx
// IntersectionObserver em vez de scroll events
'use client';
import { useEffect, useRef, useState } from 'react';

export function ScrollAnimation({ children }) {
  const ref = useRef(null);
  const [isVisible, setIsVisible] = useState(false);
  useEffect(() => {
    const obs = new IntersectionObserver(([e]) => { if (e.isIntersecting) { setIsVisible(true); obs.unobserve(e.target); } }, { threshold: 0.1 });
    if (ref.current) obs.observe(ref.current);
    return () => obs.disconnect();
  }, []);
  return <div ref={ref} className={`transition-all duration-500 ${isVisible ? 'opacity-100 translate-y-0' : 'opacity-0 translate-y-10'}`}>{children}</div>;
}
```

**Integração com outras skills:**
- `Emil-Design-Eng`: para micro-interações performáticas
- `Review-Animations`: para auditoria completa
- `Frontend-Lighthouse`: para métricas de performance

**Padrões e anti-padrões:**
✅ Fazer: Animar apenas `transform` e `opacity`
✅ Fazer: Usar `IntersectionObserver` em vez de scroll events
❌ Evitar: Animar `width`, `height`, `top`, `left`

**Referências:**
- [Web.dev - Animations Guide](https://web.dev/animations-guide/)
- [CSS Triggers](https://csstriggers.com/)

---

### 2.6 Frontend-Design

**Descrição:** Projetar e implementar um frontend distintivo dentro das restrições existentes de marca, acessibilidade, performance e framework do produto.

**Quando usar:**
- Para criar interfaces visualmente distintas que sigam a identidade da marca
- Quando o design precisa se destacar de templates genéricos

**Exemplos práticos:**

```tsx
export function BrandedHero() {
  return (
    <section className="relative min-h-screen overflow-hidden bg-[#0a0a0a]">
      <div className="absolute inset-0 bg-[url('/noise.png')] opacity-20" />
      <div className="relative z-10 max-w-6xl mx-auto px-6 py-32 flex flex-col items-center text-center">
        <span className="text-[#ff6b35] text-sm font-mono tracking-widest uppercase">Estúdio de Design</span>
        <h1 className="mt-8 text-5xl md:text-7xl font-black text-white tracking-tight">
          Criamos experiências<br /><span className="text-[#ff6b35]">que importam</span>
        </h1>
        <button className="mt-10 px-8 py-4 bg-[#ff6b35] text-white font-bold rounded-none hover:bg-[#ff8c5a] transition-colors">Ver projetos</button>
      </div>
    </section>
  );
}
```

**Integração com outras skills:**
- `Design-Taste-Frontend`: para direção visual rigorosa
- `Anti-UI-Slop`: para garantir que não vire genérico

**Referências:**
- [Refactoring UI](https://www.refactoringui.com/)

---

### 2.7 Frontend-Dev-Guidelines

**Descrição:** Engenheiro frontend sênior operando sob padrões arquiteturais e de performance rigorosos.

**Quando usar:**
- Para garantir código frontend de alta qualidade e performance
- Quando há dúvida sobre padrões arquiteturais

**Exemplos práticos:**

```tsx
// Container/Presenter Pattern
export function UserListContainer() {
  const { users, loading, error } = useUsers();
  if (loading) return <UserListSkeleton />;
  if (error) return <ErrorMessage error={error} />;
  return <UserListPresenter users={users} />;
}

export function UserListPresenter({ users }) {
  return <ul className="divide-y">{users.map(u => <UserCard key={u.id} user={u} />)}</ul>;
}
```

**Integração com outras skills:**
- `React-Patterns`: para padrões de componentes
- `Frontend-API-Integration-Patterns`: para data fetching

**Referências:**
- [React Docs - Thinking in React](https://react.dev/learn/thinking-in-react)

---

### 2.8 Frontend-Developer

**Descrição:** Construir componentes React, implementar layouts responsivos e gerenciar estado client-side. Domina React 19, Next.js 15 e arquitetura frontend moderna.

**Exemplos práticos:**

```tsx
// React 19 com useTransition
import { use, useTransition, useState } from 'react';

export function SearchableList({ items }) {
  const [query, setQuery] = useState('');
  const [isPending, startTransition] = useTransition();
  const filteredItems = items.filter(i => i.name.toLowerCase().includes(query.toLowerCase()));
  return (
    <div>
      <input value={query} onChange={(e) => startTransition(() => setQuery(e.target.value))} placeholder="Buscar..." className="w-full px-4 py-2 border rounded-lg" />
      {isPending && <span className="text-gray-400">Buscando...</span>}
      <ul className="mt-4 divide-y">{filteredItems.map(i => <li key={i.id} className="py-2">{i.name}</li>)}</ul>
    </div>
  );
}
```

**Integração com outras skills:**
- `React-Patterns`: para padrões modernos
- `Zustand-Store-TS`: para gerenciamento de estado

**Referências:**
- [React 19 Docs](https://react.dev/)
- [Next.js 15 Docs](https://nextjs.org/docs)

---

### 2.9 Interactive-Portfolio

**Descrição:** Especialista em construir portfólios que realmente conseguem empregos e clientes — não apenas mostrar trabalho, mas criar experiências memoráveis.

**Exemplos práticos:**

```tsx
export function ProjectShowcase({ project }) {
  return (
    <div className="group relative overflow-hidden rounded-2xl">
      <div className="aspect-[16/10] overflow-hidden">
        <img src={project.image} alt={project.title} className="w-full h-full object-cover group-hover:scale-110 transition-transform duration-700" />
      </div>
      <div className="absolute inset-0 bg-gradient-to-t from-black/80 via-black/20 to-transparent opacity-0 group-hover:opacity-100 transition-opacity duration-300">
        <div className="absolute bottom-0 left-0 right-0 p-8">
          <span className="text-sm text-white/60">{project.category}</span>
          <h3 className="text-2xl font-bold text-white mt-2">{project.title}</h3>
          <p className="text-white/70 mt-2">{project.description}</p>
        </div>
      </div>
    </div>
  );
}
```

**Integração com outras skills:**
- `Scroll-Experience`: para experiências imersivas
- `GPT-Taste`: para animações impressionantes
- `Frontend-Design`: para identidade visual distinta

**Referências:**
- [AWWWARDS](https://www.awwwards.com/)

---

### 2.10 Landing-Page-Generator

**Descrição:** Gera landing pages de alta conversão com Next.js/React e Tailwind CSS. Usa frameworks PAS, AIDA e BAB para copy/components otimizados.

**Exemplos práticos:**

```tsx
export function LandingPageAIDA() {
  return (
    <div>
      <section className="min-h-screen flex items-center bg-gradient-to-br from-blue-600 to-purple-700">
        <div className="max-w-4xl mx-auto px-6 text-center text-white">
          <h1 className="text-5xl md:text-7xl font-bold">Aumente suas vendas em 300%</h1>
          <p className="mt-6 text-xl text-white/80">A plataforma que automatiza seu funil de vendas.</p>
          <button className="mt-8 px-8 py-4 bg-white text-blue-600 font-bold rounded-full">Comece grátis agora</button>
        </div>
      </section>
      <section className="py-24 px-6"><div className="max-w-6xl mx-auto"><h2 className="text-4xl font-bold text-center">Por que escolher nossa plataforma?</h2></div></section>
    </div>
  );
}
```

**Integração com outras skills:**
- `GPT-Taste`: para animações e layouts impressionantes
- `Frontend-Lighthouse`: para garantir performance

**Referências:**
- [AIDA Framework](https://en.wikipedia.org/wiki/AIDA_(marketing))

---

### 2.11 Progressive-Web-App

**Descrição:** Construir Progressive Web Apps (PWAs) com suporte offline, instalabilidade e estratégias de caching.

**Exemplos práticos:**

```json
{
  "name": "Meu App", "short_name": "App", "start_url": "/", "display": "standalone",
  "background_color": "#ffffff", "theme_color": "#3b82f6",
  "icons": [{ "src": "/icon-192.png", "sizes": "192x192", "type": "image/png" }]
}
```

```javascript
// service-worker.js com Workbox
import { precacheAndRoute } from 'workbox-precaching';
import { registerRoute } from 'workbox-routing';
import { StaleWhileRevalidate, CacheFirst } from 'workbox-strategies';
precacheAndRoute(self.__WB_MANIFEST);
registerRoute(({ request }) => request.destination === 'image', new CacheFirst({ cacheName: 'images' }));
```

**Integração com outras skills:**
- `Web-Performance-Optimization`: para caching inteligente
- `Fixing-Accessibility`: para acessibilidade em PWAs

**Referências:**
- [Web.dev - PWA](https://web.dev/progressive-web-apps/)
- [Workbox Docs](https://developer.chrome.com/docs/workbox/)

---

### 2.12 Scroll-Experience

**Descrição:** Especialista em construir experiências imersivas baseadas em scroll — parallax narrativo, animações de scroll, narrativas interativas e experiências web cinematográficas.

**Exemplos práticos:**

```tsx
'use client';
import { useEffect, useRef } from 'react';
import { gsap } from 'gsap';
import { ScrollTrigger } from 'gsap/ScrollTrigger';

gsap.registerPlugin(ScrollTrigger);

export function NarrativeScroll() {
  const sectionsRef = useRef([]);
  useEffect(() => {
    sectionsRef.current.forEach((section) => {
      gsap.fromTo(section, { opacity: 0, y: 100 }, { opacity: 1, y: 0, duration: 1, scrollTrigger: { trigger: section, start: 'top 80%', scrub: true } });
    });
  }, []);
  return (
    <div>
      <section ref={el => sectionsRef.current[0] = el} className="min-h-screen flex items-center"><h1 className="text-6xl font-bold text-center w-full">Capítulo 1</h1></section>
      <section ref={el => sectionsRef.current[1] = el} className="min-h-screen flex items-center"><h2 className="text-5xl font-bold text-center w-full">Capítulo 2</h2></section>
    </div>
  );
}
```

**Integração com outras skills:**
- `GPT-Taste`: para grids bento e layouts impressionantes
- `Premium-3D-Website`: para elementos 3D durante scroll
- `Emil-Design-Eng`: para micro-interações de scroll

**Referências:**
- [GSAP ScrollTrigger](https://gsap.com/docs/v3/Plugins/ScrollTrigger/)
- [NY Times Interactive](https://www.nytimes.com/interactive)

---

### 2.13 UI-UX-Pro-Max

**Descrição:** Guia abrangente de design para aplicações web e mobile. Usar ao projetar novos componentes ou páginas de UI.

**Exemplos práticos:**

```tsx
export const designTokens = {
  colors: { primary: { 50: '#eff6ff', 500: '#3b82f6', 600: '#2563eb' }, neutral: { 50: '#f9fafb', 900: '#111827' } },
  spacing: { xs: '0.25rem', sm: '0.5rem', md: '1rem', lg: '1.5rem', xl: '2rem' },
  borderRadius: { sm: '0.25rem', md: '0.5rem', lg: '1rem', full: '9999px' },
};

export function Notification({ type, title, message, onClose }) {
  const styles = { success: 'bg-green-50 border-green-200 text-green-800', error: 'bg-red-50 border-red-200 text-red-800' };
  return (
    <div className={`p-4 rounded-lg border ${styles[type]} flex items-start gap-3`}>
      <div className="flex-1"><h4 className="font-semibold">{title}</h4><p className="text-sm mt-1">{message}</p></div>
      <button onClick={onClose} className="text-current opacity-60 hover:opacity-100">✕</button>
    </div>
  );
}
```

**Integração com outras skills:**
- `Stitch-Design-Taste`: para documentar o design system
- `Fixing-Accessibility`: para acessibilidade

**Referências:**
- [Material Design 3](https://m3.material.io/)
- [Nielsen Norman Group](https://www.nngroup.com/)

---

### 2.14 Web-Performance-Optimization

**Descrição:** Otimizar performance de sites e aplicações web incluindo velocidade de carregamento, Core Web Vitals, tamanho de bundle, estratégias de caching e performance de runtime.

**Exemplos práticos:**

```tsx
// Code splitting com React.lazy
import { lazy, Suspense } from 'react';
const HeavyComponent = lazy(() => import('./HeavyComponent'));

export function App() {
  return <Suspense fallback={<div>Carregando...</div>}>{/* <HeavyComponent /> */}</Suspense>;
}
```

```tsx
// Otimização de imagens
import Image from 'next/image';
export function OptimizedImage({ src, alt }) {
  return <Image src={src} alt={alt} width={800} height={600} placeholder="blur" sizes="(max-width: 768px) 100vw, 800px" quality={80} />;
}
```

**Integração com outras skills:**
- `Frontend-Lighthouse`: para monitorar métricas
- `NextJS-Best-Practices`: para otimizações específicas do Next.js

**Dicas de performance:**
- Usar `loading="lazy"` em imagens below-the-fold
- Implementar prefetch para rotas críticas
- Usar `next/dynamic` para code splitting
- Minificar CSS e JS com built-in do framework

**Comandos úteis:**
```bash
ANALYZE=true npm run build
npx lighthouse http://localhost:3000 --view
```

**Referências:**
- [Web.dev - Performance](https://web.dev/performance/)
- [Core Web Vitals](https://web.dev/vitals/)

---

## 3. Frontend Design (1 skill)

---

### 3.1 Frontend-Design (Skill Individual)

**Descrição:** Abordar como o líder de design em um estúdio conhecido por dar a cada cliente uma identidade visual distinta que não é confundida com ninguém else. Fazer escolhas deliberadas e opinativas sobre paleta, tipografia e layout específicas para o briefing.

**Quando usar:**
- Quando precisar criar uma interface visualmente distinta que não pareça genérica ou templateada
- Para projetos onde a identidade visual é um diferencial competitivo
- Quando o design precisa comunicar a personalidade da marca

**Exemplos práticos:**

```tsx
// Landing page para marca de café artesanal
export function CafeLanding() {
  return (
    <div className="min-h-screen bg-[#f5f0e8]">
      {/* Hero com paleta terrosa e tipografia artesanal */}
      <section className="relative min-h-screen flex items-center">
        <div className="absolute inset-0 bg-gradient-to-br from-[#8b7355] to-[#5c4a35] opacity-90" />
        <div className="relative z-10 max-w-4xl mx-auto px-6 text-center">
          <span className="text-[#d4c4a8] text-sm font-serif italic tracking-wider">
            Desde 1987
          </span>
          <h1 className="mt-6 text-6xl md:text-8xl font-serif text-[#f5f0e8] leading-[0.85]">
            Café<br />
            <em className="italic">Artesanal</em>
          </h1>
          <p className="mt-8 text-lg text-[#d4c4a8] max-w-xl mx-auto leading-relaxed">
            Grãos selecionados à mão, torrados com paixão, servidos com amor.
            Cada xícara conta uma história de tradição e qualidade.
          </p>
          <div className="mt-12 flex gap-4 justify-center">
            <button className="px-8 py-3 bg-[#f5f0e8] text-[#5c4a35] rounded-full font-serif font-medium hover:bg-white transition-colors">
              Conhecer我们的mundo
            </button>
            <button className="px-8 py-3 border border-[#d4c4a8] text-[#d4c4a8] rounded-full font-serif hover:border-[#f5f0e8] transition-colors">
              Nossos cafés
            </button>
          </div>
        </div>
      </section>

      {/* Seção de produtos com layout orgânico */}
      <section className="py-24 px-6">
        <div className="max-w-6xl mx-auto grid md:grid-cols-2 gap-16 items-center">
          <div className="aspect-square bg-[#d4c4a8] rounded-[2rem] overflow-hidden">
            <img src="/cafe-origem.jpg" alt="Grãos de café" className="w-full h-full object-cover" />
          </div>
          <div>
            <span className="text-[#8b7355] text-sm font-serif italic">Origem</span>
            <h2 className="mt-4 text-4xl font-serif text-[#3d2e1e]">
              Do campo<br />à sua xícara
            </h2>
            <p className="mt-6 text-[#6b5a48] leading-relaxed">
              Trabalhamos diretamente com produtores familiares em Minas Gerais,
              garantindo que cada grão seja colhido no ponto perfeito de maturação.
            </p>
          </div>
        </div>
      </section>
    </div>
  );
}
```

```tsx
// Portfolio de estúdio de design
export function DesignStudio() {
  return (
    <div className="min-h-screen bg-black text-white">
      <nav className="fixed top-0 left-0 right-0 z-50 px-6 py-4 flex justify-between items-center mix-blend-difference">
        <span className="text-lg font-bold tracking-tighter">ESTUDIO</span>
        <div className="flex gap-6 text-sm">
          <a href="#projetos" className="hover:text-gray-400 transition-colors">Projetos</a>
          <a href="#sobre" className="hover:text-gray-400 transition-colors">Sobre</a>
          <a href="#contato" className="hover:text-gray-400 transition-colors">Contato</a>
        </div>
      </nav>

      <section className="min-h-screen flex items-center px-6">
        <h1 className="text-7xl md:text-9xl font-bold tracking-tighter">
          Design<br />
          <span className="text-gray-500">deliberado</span>
        </h1>
      </section>

      <section id="projetos" className="py-24 px-6">
        <div className="max-w-7xl mx-auto grid grid-cols-2 gap-4">
          <div className="aspect-[4/3] bg-gray-900 rounded-2xl overflow-hidden group">
            <img src="/proj1.jpg" alt="Projeto 1" className="w-full h-full object-cover group-hover:scale-105 transition-transform duration-700" />
          </div>
          <div className="aspect-[4/3] bg-gray-900 rounded-2xl overflow-hidden group">
            <img src="/proj2.jpg" alt="Projeto 2" className="w-full h-full object-cover group-hover:scale-105 transition-transform duration-700" />
          </div>
        </div>
      </section>
    </div>
  );
}
```

**Casos de uso avançados:**
- Criar landing page para marca de café artesanal com paleta de tons terrosos, tipografia artesanal e layout orgânico
- Redesign de instituição financeira com visual que transmite confiança e modernidade
- Site de estúdio de fotografia com apresentação cinematográfica dos trabalhos

**Integração com outras skills:**
- `Stitch-Design-Taste`: para documentar o DESIGN.md com todas as decisões
- `Design-Taste-Frontend`: para refinar direção visual com paleta calibrada
- `High-End-Visual-Design`: para elevar qualidade visual ainda mais
- `Anti-UI-Slop`: para garantir que o design não vire genérico
- `Minimalist-UI`: quando minimalismo é a direção escolhida
- `Industrial-Brutalist-UI`: para estética industrial/técnica

**Princípios-chave:**
- Fundamentar designs no assunto/indústria do produto
- Tipografia carrega a personalidade da página
- Usar movimento de forma deliberada e esparsa
- Evitar padrões genéricos de IA (backgrounds cream, acentos terracotta, layouts de jornal)
- Trabalhar em dois passes: planejar, depois construir
- Auto-crítica constante e restriência no design

**Padrões e anti-padrões:**
✅ Fazer: Pesquisar a indústria do produto antes de definir paleta
✅ Fazer: Escolher tipografia que comunique a personalidade da marca
✅ Fazer: Testar o design em múltiplos tamanhos de tela
✅ Fazer: Manter consistência visual em todas as páginas
❌ Evitar: Copiar tendências sem adaptar à marca
❌ Evitar: Usar mais de 3 fontes diferentes
❌ Evitar: Adicionar elementos decorativos sem propósito
❌ Evitar: Ignorar acessibilidade em busca de estética

**Dicas de performance:**
- Carregar fontes premium apenas quando necessárias com `font-display: swap`
- Comprimir imagens com WebP/AVIF para manter qualidade
- Usar `loading="lazy"` em imagens below-the-fold
- Minimizar uso de `backdrop-filter: blur()` que impacta GPU
- Usar `contain: content` em cards para limitar repaints

**Comandos úteis:**
```bash
# Converter imagens para WebP
npx sharp-cli -i input.jpg -o output.webp

# Gerar escala tipográfica
npx utopia-cli --type scale --ratio 1.25 --min 16 --max 20

# Verificar contraste de cores
npx color-contrast-checker --foreground #1a1a1a --background #f5f0e8

# Gerar paleta de cores a partir de uma imagem
npx colorthief-cli image.jpg
```

**Referências:**
- [Apple Design Resources](https://developer.apple.com/design/resources/)
- [Google Fonts](https://fonts.google.com/)
- [Adobe Color](https://color.adobe.com/)
- [Coolors - Gerador de Paletas](https://coolors.co)
- [UTopia - Fluid Typography](https://utopia.fyi)
- [Refactoring UI](https://www.refactoringui.com/)
- [Dribbble - Inspiration](https://dribbble.com/)
- [Behance - Inspiration](https://www.behance.net/)

---

## Estatísticas Finais

| Categoria | Quantidade | Exemplos Adicionados | Refs por Skill |
|-----------|------------|---------------------|----------------|
| Frontend Category Pointer | 32 | 64-96 (2-3 por skill) | 2-3 |
| Front End Category Pointer | 14 | 28-42 (2-3 por skill) | 2-3 |
| Frontend Design | 1 | 2 | 8 |
| **Total** | **47** | **94-140** | **~140** |

### Melhorias v2 em relação à v1:

1. **Mais exemplos práticos**: Cada skill agora tem 2-3 exemplos de código com syntax highlighting
2. **Casos de uso avançados**: Situações reais de projeto onde a skill é aplicada
3. **Integração com outras skills**: Mapa de quais skills complementares usar em cada cenário
4. **Padrões e anti-padrões**: Listas claras do que fazer e o que evitar
5. **Dicas de performance**: Otimizações específicas para cada skill
6. **Comandos úteis**: Snippets de código prontos para uso imediato
7. **Referências**: Links para documentação oficial de cada ferramenta/framework

---

*Documento gerado automaticamente em 2026-09-13*
*Atualizado em 2026-09-14 — v2 com 47 skills aprimoradas*
