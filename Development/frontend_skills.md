# Documentação de Skills de Frontend

Data de criação: 2026-09-13
Autor: Pesquisa automatizada via OpenCode

---

## Resumo

Este documento lista todas as skills relacionadas a "Frontend" encontradas no sistema, organizadas por categoria. Foram documentadas **47 skills** no total:

- **Frontend Category Pointer**: 32 skills (biblioteca completa de frontend)
- **Front End Category Pointer**: 14 skills (foco em desenvolvimento e UX)
- **Frontend Design**: 1 skill (design visual e identidade de marca)

---

## 1. Frontend Category Pointer (32 skills)

### 1.1 Anti-UI-Slop
**Descrição:** Para impedir que agentes de código enviem UI genérica. Estende o design system do produto, usa evidências UIZZE apenas quando útil, cobre estados obrigatórios e inspeciona o resultado renderizado.

**Quando usar:** Quando precisar garantir que interfaces sigam padrões de qualidade e não sejam genéricas.

**Exemplo:** Revisar componentes gerados por IA para garantir que seguem o design system do projeto.

### 1.2 Astro
**Descrição:** Construir sites focados em conteúdo com Astro — JS zero por padrão, arquitetura de ilhas, componentes multi-framework e suporte a Markdown/MDX.

**Quando usar:** Para projetos de blogs, documentação, portfolios ou sites estáticos onde performance é crítica.

**Exemplo:** Criar um blog corporativo com posts em MDX e componentes interativos isolados.

### 1.3 Design-It
**Descrição:** Roteia tarefas de design frontend para 48 estilos de UI específicos. Dispara para sites, telas de app ou componentes de UI solicitando uma estética específica.

**Quando usar:** Quando precisar aplicar um estilo visual específico a uma interface.

**Exemplo:** Solicitar um estilo "brutalista industrial" para um dashboard de dados.

### 1.4 Design-Taste-Frontend
**Descrição:** Usar ao construir interfaces frontend de alta agência com gosto de design rigoroso, paleta de cores calibrada, layout responsivo e regras de movimento.

**Quando usar:** Para projetos que exigem design premium e atenção a detalhes visuais.

**Exemplo:** Criar uma landing page para produto de luxo com tipografia elegante e animações sutis.

### 1.5 Emil-Design-Eng
**Descrição:** Usar ao projetar ou revisar UI de produto polida com orientação de animação, interação e craft de componentes inspirada em Emil Kowalski.

**Quando usar:** Quando precisar de micro-interações e animações de alta qualidade.

**Exemplo:** Implementar transições suaves entre estados de formulário em um app SaaS.

### 1.6 Frontend-API-Integration-Patterns
**Descrição:** Padrões prontos para produção para integrar aplicações frontend com APIs backend, incluindo tratamento de condições de corrida, cancelamento de requisições, estratégias de retry, normalização de erros e gerenciamento de estado da UI.

**Quando usar:** Para implementar comunicação robusta entre frontend e backend.

**Exemplo:** Implementar uma lista de usuários com paginação infinita e tratamento de erros.

### 1.7 Frontend-Lighthouse
**Descrição:** Adicionar um gate portátil do Lighthouse CI para builds de frontend em produção com orçamentos de Core Web Vitals, pisos de categoria, medianas de execução e artefatos de CI.

**Quando usar:** Para garantir que builds de produção atendam métricas de performance.

**Exemplo:** Configurar pipeline CI que bloqueia deploy se Lighthouse score cair abaixo de 90.

### 1.8 Full-Output-Enforcement
**Descrição:** Usar quando uma tarefa exigir output exaustivo sem abreviações, arquivos completos ou prevenção estrita de placeholders e código pulado.

**Quando usar:** Para garantir que código gerado seja completo e funcional.

**Exemplo:** Gerar componente React complexo com todos os estados e tratamentos de erro.

### 1.9 GPT-Taste
**Descrição:** Usar ao gerar páginas frontend elite pesadas com GSAP, estrutura AIDA rigorosa, tipografia hero ampla e grids bento sem lacunas.

**Quando usar:** Para landing pages de alta conversão com animações impressionantes.

**Exemplo:** Criar página de produto com hero animado e scroll de parallax.

### 1.10 High-End-Visual-Design
**Descrição:** Usar ao projetar interfaces de agência premium com fontes premium, ritmo espacial, profundidade suave e micro-interações fluidas.

**Quando usar:** Para projetos que precisam de design de nível premium e sofisticado.

**Exemplo:** Criar site institucional para marca de moda de alto padrão.

### 1.11 Industrial-Brutalist-UI
**Descrição:** Usar ao criar UIs industriais ou de telemetria tática com grids rígidos, tipografia rígida, efeitos CRT e dados de alta densidade.

**Quando usar:** Para dashboards industriais, sistemas de monitoramento ou interfaces de dados técnicos.

**Exemplo:** Criar painel de monitoramento de servidores com layout denso e tipografia monospace.

### 1.12 Markstream-Angular
**Descrição:** Integrar o renderizador alpha markstream-angular em aplicações Angular 20+ com componentes standalone, signals, padrões seguros de HTML e recursos peer opcionais.

**Quando usar:** Para projetos Angular que precisam de renderização de Markdown streaming.

**Exemplo:** Integrar documentação interativa em app Angular com renderização em tempo real.

### 1.13 Markstream-Custom-Components
**Descrição:** Substituir renderizadores de nós Markstream e adicionar tags customizadas confiáveis em Vue, React, Svelte e Angular usando mapeamentos scoped ou de renderizador.

**Quando usar:** Para personalizar como elementos Markdown são renderizados em diferentes frameworks.

**Exemplo:** Criar componente de código personalizado que destaca sintaxe de forma diferente.

### 1.14 Markstream-Install
**Descrição:** Instalar e configurar renderizadores Markstream para Markdown streaming para Vue, React, Svelte, Angular, Nuxt, Next.js e aplicações Vue 2.

**Quando usar:** Para adicionar renderização de Markdown streaming em qualquer projeto frontend.

**Exemplo:** Instalar Markstream em projeto Next.js para renderizar posts de blog com streaming.

### 1.15 Markstream-Migration
**Descrição:** Auditar e migrar um renderizador Markdown existente para Markstream preservando renderizadores customizados, política de segurança, comportamento de streaming e gaps de paridade explícitos.

**Quando usar:** Para migrar de outro renderizador Markdown para Markstream.

**Exemplo:** Migrar projeto que usa react-markdown para Markstream.

### 1.16 Markstream-Nuxt
**Descrição:** Integrar markstream-vue em Nuxt 3 ou 4 com limites cliente seguros para SSR, modos de renderizador, CSS explícito e peers opcionais apenas no browser.

**Quando usar:** Para projetos Nuxt que precisam de renderização Markdown streaming.

**Exemplo:** Criar blog Nuxt com posts que carregam progressivamente.

### 1.17 Markstream-React
**Descrição:** Integrar o renderizador beta markstream-react em React 18+ ou Next.js com pontos de entrada cliente/servidor corretos, CSS, estado de streaming e overrides de componentes.

**Quando usar:** Para projetos React ou Next.js que precisam de renderização Markdown streaming.

**Exemplo:** Implementar chat com mensagens que aparecem word-by-word.

### 1.18 Markstream-Svelte
**Descrição:** Integrar o renderizador beta markstream-svelte em Svelte 5 ou SvelteKit com runes, CSS explícito, streaming suave, workers e limites seguros para SSR.

**Quando usar:** Para projetos Svelte/SvelteKit que precisam de renderização Markdown streaming.

**Exemplo:** Criar app SvelteKit com documentação interativa e streaming.

### 1.19 Markstream-Vue
**Descrição:** Integrar markstream-vue em Vue 3 puro com modos de renderizador, escolhas de código e DOM, estado de streaming, virtualização, peers opcionais e componentes scoped.

**Quando usar:** Para projetos Vue 3 que precisam de renderização Markdown streaming.

**Exemplo:** Integrar preview de Markdown em editor de conteúdo Vue.

### 1.20 Markstream-Vue2
**Descrição:** Integrar markstream-vue2 em Vue 2.6 ou 2.7 com decisões corretas de Composition API, CSS, estado de streaming, peers opcionais e overrides scoped.

**Quando usar:** Para projetos Vue 2 legados que precisam de renderização Markdown streaming.

**Exemplo:** Atualizar app Vue 2 para usar renderização Markdown moderna.

### 1.21 Markstream-Vue2-CLI
**Descrição:** Integrar markstream-vue2 em Vue CLI ou Webpack 4 com CSS seguro para export-map, fallbacks CDN para workers e padrões conservadores para blocos de código.

**Quando usar:** Para projetos Vue 2 com Vue CLI ou Webpack 4.

**Exemplo:** Adicionar Markdown streaming em projeto Vue 2 existente sem alterar bundler.

### 1.22 Markstream-Vue2-Vite
**Descrição:** Integrar markstream-vue2 em Vue 2 mais Vite com imports de worker bundled, ordenação de CSS, compatibilidade de Composition API e padrões seguros de streaming.

**Quando usar:** Para projetos Vue 2 usando Vite como bundler.

**Exemplo:** Migrar projeto Vue 2 de Webpack para Vite com Markstream.

### 1.23 Minimalist-UI
**Descrição:** Usar ao criar interfaces editoriais limpas com paletas monocromáticas quentes, bordas nítidas, movimento contido e layouts bento planos.

**Quando usar:** Para sites de conteúdo, blogs ou portfólios com design minimalista.

**Exemplo:** Criar site de revista digital com layout limpo e tipografia elegante.

### 1.24 NextJS-Best-Practices
**Descrição:** Princípios do Next.js App Router. Server Components, padrões de data fetching, rotas.

**Quando usar:** Para projetos Next.js que precisam seguir best practices modernas.

**Exemplo:** Implementar dashboard com Server Components e Client Components where appropriate.

### 1.25 Premium-3D-Website
**Descrição:** Diretrizes para construir sites 3D premium, focando em shaders WebGL customizados, pós-processamento, interações baseadas em física, animações suaves, preloaders e otimização de dispositivos.

**Quando usar:** Para sites com experiências 3D interativas e imersivas.

**Exemplo:** Criar página de produto com visualização 3D interativa do item.

### 1.26 React-Patterns
**Descrição:** Padrões modernos e princípios do React. Hooks, composição, performance, best practices de TypeScript.

**Quando usar:** Para desenvolvimento React que precisa seguir padrões modernos.

**Exemplo:** Implementar sistema de autenticação com Context API e hooks customizados.

### 1.27 Redesign-Existing-Projects
**Descrição:** Usar ao atualizar sites ou apps existentes auditando padrões de UI genéricos e aplicando correções de design premium sem reescritas.

**Quando usar:** Para modernizar interfaces legadas sem reescrever tudo.

**Exemplo:** Atualizar design de app corporativo existente para visual mais moderno.

### 1.28 Review-Animations
**Descrição:** Usar ao revisar código de animação e movimento contra padrão rigoroso de craft, performance, acessibilidade e qualidade de interação.

**Quando usar:** Para auditar e melhorar animações existentes.

**Exemplo:** Revisar animações de scroll para garantir performance e acessibilidade.

### 1.29 Stitch-Design-Taste
**Descrição:** Usar ao gerar sistemas DESIGN.md do Google Stitch para tipografia premium, cores, layout, intenção de movimento e regras anti-UI genérica.

**Quando usar:** Para criar design systems documentados e consistentes.

**Exemplo:** Criar guia de estilo para projeto com paleta de cores e hierarquia tipográfica definidas.

### 1.30 SvelteKit
**Descrição:** Construir aplicações web full-stack com SvelteKit — rotas baseadas em arquivo, SSR, SSG, rotas API e form actions em um único framework.

**Quando usar:** Para projetos full-stack que preferem Svelte over React/Vue.

**Exemplo:** Criar e-commerce com SSR para SEO e form actions para checkout.

### 1.31 Tailwind-Patterns
**Descrição:** Princípios do Tailwind CSS v4. Configuração CSS-first, container queries, padrões modernos, arquitetura de design tokens.

**Quando usar:** Para projetos que usam Tailwind CSS e precisam de padrões modernos.

**Exemplo:** Implementar design system com design tokens em Tailwind v4.

### 1.32 Zustand-Store-TS
**Descrição:** Criar stores Zustand seguindo padrões estabelecidos com tipos TypeScript apropriados e middleware.

**Quando usar:** Para gerenciamento de estado em projetos React com Zustand.

**Exemplo:** Criar store de carrinho de compras com persistência e TypeScript types.

---

## 2. Front End Category Pointer (14 skills)

### 2.1 Chat-Widget
**Descrição:** Construir sistema de chat de suporte em tempo real com widget flutuante para usuários e dashboard admin para equipe de suporte.

**Quando usar:** Quando o usuário quiser chat ao vivo, suporte ao cliente, mensagens em tempo real ou suporte in-app.

**Exemplo:** Adicionar widget de chat em site de e-commerce para atendimento ao cliente.

### 2.2 Chrome-Extension-Developer
**Descrição:** Especialista em construir Chrome Extensions usando Manifest V3. Cobre scripts de background, service workers, scripts de conteúdo e comunicação entre contextos.

**Quando usar:** Para desenvolver extensões para navegador Chrome.

**Exemplo:** Criar extensão que bloqueia anúncios em páginas específicas.

### 2.3 Fixing-Accessibility
**Descrição:** Auditar e corrigir problemas de acessibilidade HTML incluindo labels ARIA, navegação por teclado, gerenciamento de foco, contraste de cores e erros de formulário.

**Quando usar:** Para adicionar controles interativos, formulários, diálogos ou revisar conformidade WCAG.

**Exemplo:** Tornar formulário de contato totalmente acessível por teclado e leitores de tela.

### 2.4 Fixing-Metadata
**Descrição:** Auditar e corrigir metadados HTML incluindo títulos de página, meta descriptions, URLs canônicas, Open Graph tags, Twitter cards, favicons, dados estruturados JSON-LD e diretrizes robots.

**Quando usar:** Para melhorar SEO e compartilhamento em redes sociais.

**Exemplo:** Adicionar metadados completos para que links compartilhados no LinkedIn apareçam corretamente.

### 2.5 Fixing-Motion-Performance
**Descrição:** Auditar e corrigir problemas de performance de animação incluindo layout thrashing, propriedades de compositor, movimento vinculado ao scroll e efeitos de blur.

**Quando usar:** Quando animações stutter, transições jank ou ao revisar performance de animações CSS/JS.

**Exemplo:** Otimizar animações de scroll que causam frame drops em dispositivos móveis.

### 2.6 Frontend-Design (dentro do Front End Pointer)
**Descrição:** Projetar e implementar um frontend distintivo dentro das restrições existentes de marca, acessibilidade, performance e framework do produto.

**Quando usar:** Para criar interfaces visualmente distintas que sigam a identidade da marca.

**Exemplo:** Redesign de landing page mantendo componentes existentes mas com visual renovado.

### 2.7 Frontend-Dev-Guidelines
**Descrição:** Engenheiro frontend sênior operando sob padrões arquiteturais e de performance rigorosos. Usar ao criar componentes ou páginas, adicionar novas features ou buscar/mutar dados.

**Quando usar:** Para garantir código frontend de alta qualidade e performance.

**Exemplo:** Criar componente de tabela com paginação seguindo padrões arquiteturais.

### 2.8 Frontend-Developer
**Descrição:** Construir componentes React, implementar layouts responsivos e gerenciar estado client-side. Domina React 19, Next.js 15 e arquitetura frontend moderna.

**Quando usar:** Para desenvolvimento React moderno com foco em componentes e estado.

**Exemplo:** Construir dashboard interativo com React 19 e gerenciamento de estado.

### 2.9 Interactive-Portfolio
**Descrição:** Especialista em construir portfólios que realmente conseguem empregos e clientes — não apenas mostrar trabalho, mas criar experiências memoráveis.

**Quando usar:** Para criar portfólio profissional que converta visitantes em oportunidades.

**Exemplo:** Criar portfólio de desenvolvedor com projetos interativos eCases de estudo.

### 2.10 Landing-Page-Generator
**Descrição:** Gera landing pages de alta conversão com Next.js/React e Tailwind CSS. Usa frameworks PAS, AIDA e BAB para copy/components otimizados. Foca em Core Web Vitals/SEO.

**Quando usar:** Para criar landing pages focadas em conversão e performance.

**Exemplo:** Criar página de vendas para produto SaaS com seções de features, pricing e CTA.

### 2.11 Progressive-Web-App
**Descrição:** Construir Progressive Web Apps (PWAs) com suporte offline, instalabilidade e estratégias de caching. Dispara quando o usuário menciona PWA, service workers, web app manifests, Workbox, 'add to home screen'.

**Quando usar:** Quando o app precisar funcionar offline, parecer nativo ou ser instalável.

**Exemplo:** Transformar app existente em PWA para funcionar offline em áreas sem internet.

### 2.12 Scroll-Experience
**Descrição:** Especialista em construir experiências imersivas baseadas em scroll — parallax narrativo, animações de scroll, narrativas interativas e experiências web cinematográficas.

**Quando usar:** Para criar experiências web como NY Times interactives, páginas de produto Apple ou experiências web premiadas.

**Exemplo:** Criar página de caso de estudo com scroll narrativo e animações progressivas.

### 2.13 UI-UX-Pro-Max
**Descrição:** Guia abrangente de design para aplicações web e mobile. Usar ao projetar novos componentes ou páginas de UI, escolher paletas de cores e tipografia, ou revisar código para problemas de UX.

**Quando usar:** Para decisões de design de interface que afetam usabilidade e experiência do usuário.

**Exemplo:** Projetar fluxo de onboarding de app mobile com hierarquia visual clara.

### 2.14 Web-Performance-Optimization
**Descrição:** Otimizar performance de sites e aplicações web incluindo velocidade de carregamento, Core Web Vitals, tamanho de bundle, estratégias de caching e performance de runtime.

**Quando usar:** Para melhorar métricas de performance e experiência do usuário.

**Exemplo:** Reduzir tempo de carregamento de página de 5s para 2s otimizando bundle e imagens.

---

## 3. Frontend Design (1 skill)

### 3.1 Frontend-Design (Skill Individual)
**Descrição:** Abordar como o líder de design em um estúdio conhecido por dar a cada cliente uma identidade visual distinta que não é confundida com ninguém else. Fazer escolhas deliberadas e opinativas sobre paleta, tipografia e layout específicas para o briefing.

**Quando usar:** Quando precisar criar uma interface visualmente distinta que não pareça genérica ou templateada.

**Exemplo:** Criar landing page para marca de café artesanal com paleta de tons terrosos, tipografia artesanal e layout orgânico que refleta a identidade da marca.

**Princípios-chave:**
- Fundamentar designs no assunto/indústria do produto
- Tipografia carrega a personalidade da página
- Usar movimento de forma deliberada e esparsa
- Evitar padrões genéricos de IA (backgrounds cream, acentos terracotta, layouts de jornal)
- Trabalhar em dois passes: planejar, depois construir
- Auto-crítica constante e restriência no design

---

## Estatísticas Finais

| Categoria | Quantidade |
|-----------|------------|
| Frontend Category Pointer | 32 |
| Front End Category Pointer | 14 |
| Frontend Design | 1 |
| **Total** | **47** |

---

*Documento gerado automaticamente em 2026-09-13*
