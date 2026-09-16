# ✨ Motion Primitives - 155+ React Animation Components (Skills)

> **Fonte: https://github.com/itsjwill/motion-primitives-website**
> **Skills extraídas e aprimoradas para o knowledge base**

---

## 📋 Visão Geral

**Motion Primitives** é uma biblioteca com 155+ componentes React animados gratuitos para Next.js. Framer Motion, GSAP, Three.js, Tailwind CSS. Alternativa open-source ao Aceternity UI e Magic UI.

---

## 🎨 Skills de Animação

### 1. Arquitetura de Animação React

```typescript
// SKILL: Arquitetura de Animação Moderna
// Nível: Expert
// Contexto: Componentes animados com React

// STACK:
// - Framer Motion: animações declarativas
// - GSAP: animações de scroll
// - Three.js: 3D na web
// - Tailwind CSS: estilização
// - Next.js: framework

// PADRÕES:
// 1. Declarative: animações definidas em JSX
// 2. Gesture-based: hover, tap, drag
// 3. Scroll-linked: animações no scroll
// 4. Physics-based: spring animations
// 5. Layout: animações de layout

// MELHORIA:
// ERRADO: CSS animations limitadas
// CORRECT: Animações ricas com Framer Motion
```

### 2. Componentes Interativos (16)

```typescript
// SKILL: Componentes Interativos com Gestures
// Nível: Expert
// Contexto: Interações ricas no browser

// DOCK (macOS-style):
import { Dock, DockItem } from '@/components/interactive/dock';
<Dock magnification={60} distance={140}>
  <DockItem label="Home"><HomeIcon /></DockItem>
  <DockSeparator />
  <DockItem label="Settings"><GearIcon /></DockItem>
</Dock>

// SPOTLIGHT CARD:
import { SpotlightCard } from '@/components/interactive/spotlight-card';
<SpotlightCard>
  <div>Conteúdo com spotlight que segue o mouse</div>
</SpotlightCard>

// MORPHING TEXT:
import { MorphingText } from '@/components/interactive/morphing-text';
<MorphingText text="Hello World" variant="flip" />

// MAGNETIC:
import { Magnetic } from '@/components/interactive/magnetic';
<Magnetic strength={0.3}>
  <button>Elemento magnético</button>
</Magnetic>

// MELHORIA:
// ERRADO: Hover básico com CSS
// CORRECT: Interações ricas com Framer Motion
```

### 3. Backgrounds Animados (13)

```typescript
// SKILL: Backgrounds Visuais Impactantes
// Nível: Expert
// Contexto: Fundos animados para websites

// AURORA:
import { Aurora } from '@/components/backgrounds/aurora';
<Aurora colors={['#6366f1', '#8b5cf6', '#ec4899']} />

// METEORS:
import { Meteors } from '@/components/backgrounds/meteors';
<Meteors number={20} />

// GRADIENT MESH:
import { GradientMesh } from '@/components/backgrounds/gradient-mesh';
<GradientMesh interactive />

// PARTICLES:
import { Particles } from '@/components/backgrounds/particles';
<Particles count={100} />

// SHADER BACKGROUNDS:
import { ShaderBackground } from '@/components/backgrounds/shader-backgrounds';
<ShaderBackground type="liquid-metal" />

// MELHORIA:
// ERRADO: Backgrounds estáticos
// CORRECT: Backgrounds animados e interativos
```

### 4. SVG Animations (12 + 4 hooks)

```typescript
// SKILL: Animações SVG Avançadas
// Nível: Expert
// Contexto: Animações de caminhos SVG

// SVG PATH DRAW:
import { SvgPathDraw } from '@/components/svg/animated-svg';
<SvgPathDraw
  paths={[{ d: "M10,80 Q95,10 180,80", stroke: "#6366f1", strokeWidth: 3 }]}
  trigger="inView"
  duration={1.5}
/>

// SVG MORPH:
import { SvgMorph } from '@/components/svg/animated-svg';
<SvgMorph
  paths={["M0,0 L100,0 L100,100 L0,100 Z", "M50,0 L100,50 L50,100 L0,50 Z"]}
  trigger="hover"
/>

// SVG GOOEY BLOB:
import { SvgGooeyBlob } from '@/components/svg/animated-svg';
<SvgGooeyBlob radius={50} />

// HOOKS:
// useSvgPathDraw: desenho de caminhos
// useSvgMorph: morphing de SVGs
// useSvgFilter: filtros SVG
// useScrollVelocity: velocidade do scroll

// MELHORIA:
// ERRADO: SVGs estáticos
// CORRECT: SVGs animados e interativos
```

### 5. Animated Chat UI (8)

```typescript
// SKILL: Interface de Chat Animada
// Nível: Expert
// Contexto: Chat UI com animações ricas

// CHAT CONTAINER:
import { ChatContainer, ChatBubble } from '@/components/chat/animated-chat';
<ChatContainer variant="glass">
  <ChatBubble sender="user">Olá!</ChatBubble>
  <ChatBubble sender="assistant">
    <StreamingText text="Resposta animada" mode="word" />
  </ChatBubble>
  <TypingIndicator />
</ChatContainer>

// STREAMING TEXT:
import { StreamingText } from '@/components/chat/animated-chat';
<StreamingText text="Texto aparecendo palavra por palavra" mode="word" />

// MESSAGE REACTION:
import { MessageReaction } from '@/components/chat/animated-chat';
<MessageReaction emoji="👍" count={5} />

// MELHORIA:
// ERRADO: Chat básico sem animação
// CORRECT: Chat UI rica e interativa
```

### 6. Scroll Orchestration (7)

```typescript
// SKILL: Orquestração de Scroll
// Nível: Expert
// Contexto: Animações sincronizadas com scroll

// SCROLL ORCHESTRATOR:
import { ScrollOrchestrator, ScrollStage } from '@/components/scroll/scroll-orchestrator';
<ScrollOrchestrator>
  <ScrollStage start={0} end={0.25}>
    <div>Fase 1: Fade in</div>
  </ScrollStage>
  <ScrollStage start={0.25} end={0.5}>
    <div>Fase 2: Slide up</div>
  </ScrollStage>
  <ScrollStage start={0.5} end={0.75}>
    <div>Fase 3: Scale</div>
  </ScrollStage>
</ScrollOrchestrator>

// IMAGE SEQUENCE SCROLL:
import { ImageSequenceScroll } from '@/components/scroll/scroll-orchestrator';
<ImageSequenceScroll
  frames={Array.from({ length: 120 }, (_, i) => `/frames/frame-${i}.webp`)}
  preloadCount={20}
/>

// DEPTH PARALLAX:
import { DepthParallax, DepthLayer } from '@/components/scroll/scroll-orchestrator';
<DepthParallax>
  <DepthLayer depth={0}>Fundo</DepthLayer>
  <DepthLayer depth={1}>Meio</DepthLayer>
  <DepthLayer depth={2}>Frente</DepthLayer>
</DepthParallax>

// MELHORIA:
// ERRADO: Scroll básico com CSS
// CORRECT: Orquestração complexa de scroll
```

---

## 🎯 4 Design Directions

```typescript
// SKILL: Sistemas de Design Alternativos
// Nível: Expert
// Contexto: Múltiplas estéticas em um código

// DIREÇÕES:
// 1. LUXURY: Pagani, Richard Mille
//    - Fonts: Space Grotesk + Inter
//    - Motion: Slow, deliberate [0.16, 1, 0.3, 1]

// 2. CYBERPUNK: Neon, Glitch, Terminal
//    - Fonts: JetBrains Mono + IBM Plex
//    - Motion: Snappy, glitchy [0.76, 0, 0.24, 1]

// 3. KINETIC: Stripe, Vercel, Linear
//    - Fonts: Outfit + DM Sans
//    - Motion: Spring physics stiffness: 200

// 4. FREESTYLE: Bold, Unexpected
//    - Fonts: Syne + Manrope
//    - Motion: Varied, unpredictable

// TROCA EM TEMPO REAL:
document.documentElement.setAttribute("data-direction", "cyberpunk");

// O QUE MUDA:
// - 40+ CSS color variables
// - 8 font families
// - 4 distinct animation timing functions
// - 20+ keyframe animations
// - Component border radii, shadows, spacing

// MELHORIA:
// ERRADO: Design system único
// CORRECT: Múltiplas direções de design
```

---

## 📊 Componentes por Categoria

| Categoria | Quantidade | Tecnologias |
|-----------|------------|-------------|
| Interactive | 16+ | Framer Motion, Spring Physics |
| Backgrounds | 13+ | Canvas, SVG, WebGL |
| SVG Animations | 12+ | GSAP, Path Drawing |
| Chat UI | 8 | AnimatePresence, Spring |
| Scroll | 7 | GSAP ScrollTrigger |
| Text | 7 | Split Text, Variable Fonts |
| Cards | 7 | 3D Transform, Parallax |
| Effects | 16+ | Custom Cursors, Fluid |
| Buttons | 10+ | Shader, Ink, Portal |
| 3D | 6 | Three.js, Spline |
| Layout | 5 | Masonry, Morphing |
| Transitions | 3 | Noise, Page |

---

## 🚀 Setup

```bash
# Clone
git clone https://github.com/itsjwill/motion-primitives-website.git
cd motion-primitives-website

# Install
npm install

# Development
npm run dev

# Acesse: http://localhost:3000
```

---

## 📈 Métricas

| Métrica | Valor |
|---------|-------|
| Components | 155+ |
| License | MIT |
| Framework | Next.js 14 |
| Animation | Framer Motion |
| 3D | Three.js + Spline |
| CSS | Tailwind CSS |
| Scroll | GSAP ScrollTrigger |
| Design Directions | 4 |

---

*Motion Primitives Skills v1.0 — Setembro 2026*
*Fonte: https://github.com/itsjwill/motion-primitives-website*