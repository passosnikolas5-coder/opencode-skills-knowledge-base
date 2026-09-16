# 🎨 ADVANCED TAILWIND CSS EXPANDED

**Fonte:** https://github.com/tailwindlabs/tailwindcss (88k+ stars)
**Descrição:** Tailwind CSS é um framework CSS utility-first que permite construir interfaces modernas diretamente no HTML com classes utilitárias.

---

## 1. Utility Classes Fundamentais

### Spacing

```html
<!-- Margin -->
<div class="m-4">m-4 (1rem)</div>
<div class="mx-auto">mx-auto (centralizar)</div>
<div class="mt-8 mb-4">margem top e bottom</div>
<div class="p-6">padding 1.5rem</div>
<div class="px-4 py-2">padding horizontal/vertical</div>
<div class="gap-4">gap entre flex/grid items</div>

<!-- Spacing scales -->
<div class="space-y-4">espaçamento vertical entre filhos</div>
<div class="space-x-2">espaçamento horizontal entre filhos</div>
```

### Colors

```html
<!-- Background -->
<div class="bg-blue-500">azul padrão</div>
<div class="bg-red-100">vermelho claro</div>
<div class="bg-green-500/50">verde com 50% opacity</div>

<!-- Text -->
<p class="text-gray-900">texto escuro</p>
<p class="text-white">texto branco</p>
<p class="text-blue-600 hover:text-blue-800">hover mais escuro</p>

<!-- Border -->
<div class="border border-gray-300">borda cinza</div>
<div class="border-2 border-dashed border-red-500">borda vermelha tracejada</div>
```

### Typography

```html
<h1 class="text-4xl font-bold tracking-tight">Heading Grande</h1>
<h2 class="text-2xl font-semibold text-gray-800">Subheading</h2>
<p class="text-base leading-relaxed text-gray-600">Parágrafo confortável</p>
<span class="text-sm font-medium text-blue-500">Texto pequeno</span>
<p class="text-xs uppercase tracking-widest text-gray-400">Textotiny</p>

<!-- Font families -->
<p class="font-sans">Fonte padrão</p>
<p class="font-serif">Fonte serifada</p>
<p class="font-mono">Fonte monoespaçada</p>
```

---

## 2. Responsive Design

```html
<!-- Mobile First -->
<div class="w-full md:w-1/2 lg:w-1/3 xl:w-1/4">
  Responsivo em todas telas
</div>

<!-- Grid responsivo -->
<div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-4">
  <div class="bg-white p-4 rounded shadow">Card 1</div>
  <div class="bg-white p-4 rounded shadow">Card 2</div>
  <div class="bg-white p-4 rounded shadow">Card 3</div>
  <div class="bg-white p-4 rounded shadow">Card 4</div>
</div>

<!-- Padding responsivo -->
<div class="p-4 sm:p-6 md:p-8 lg:p-12">
  Padding cresce com a tela
</div>

<!-- Fonte responsiva -->
<h1 class="text-2xl sm:text-3xl md:text-4xl lg:text-5xl font-bold">
  Título Responsivo
</h1>

<!-- Flex responsivo -->
<div class="flex flex-col md:flex-row gap-4">
  <div class="flex-1">Sidebar</div>
  <div class="flex-2">Conteúdo</div>
</div>
```

---

## 3. Dark Mode

```html
<!-- Class Strategy -->
<html class="dark">
<body class="bg-white dark:bg-gray-900 text-gray-900 dark:text-gray-100">
  <div class="bg-gray-100 dark:bg-gray-800 p-4 rounded-lg shadow">
    <h2 class="text-xl font-bold dark:text-white">Título</h2>
    <p class="text-gray-600 dark:text-gray-300">Parágrafo</p>
    <button class="bg-blue-500 hover:bg-blue-600 dark:bg-blue-400 dark:hover:bg-blue-500 text-white px-4 py-2 rounded">
      Botão
    </button>
  </div>
</body>
</html>

<!-- Toggle Dark Mode com JS -->
<button onclick="document.documentElement.classList.toggle('dark')" class="p-2">
  🌙 Toggle Theme
</button>
```

---

## 4. Customization (tailwind.config.js)

```javascript
/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ['./src/**/*.{js,jsx,ts,tsx}'],
  darkMode: 'class',
  theme: {
    extend: {
      colors: {
        primary: {
          50: '#eff6ff',
          500: '#3b82f6',
          900: '#1e3a8a',
        },
        brand: '#ff6b35',
      },
      fontFamily: {
        display: ['Inter', 'sans-serif'],
        body: ['Roboto', 'sans-serif'],
      },
      animation: {
        'bounce-slow': 'bounce 2s infinite',
        'spin-slow': 'spin 3s linear infinite',
      },
      keyframes: {
        'bounce-slow': {
          '0%, 100%': { transform: 'translateY(-5%)' },
          '50%': { transform: 'translateY(0)' },
        },
      },
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/typography'),
  ],
};
```

---

## 5. Component Layer

```css
/* tailwind.css */
@tailwind base;
@tailwind components;
@tailwind utilities;

@layer components {
  .btn-primary {
    @apply bg-blue-500 text-white px-4 py-2 rounded-lg font-medium
           hover:bg-blue-600 active:bg-blue-700 
           focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-offset-2
           transition-colors duration-200;
  }

  .btn-secondary {
    @apply bg-gray-200 text-gray-800 px-4 py-2 rounded-lg font-medium
           hover:bg-gray-300 active:bg-gray-400
           transition-colors duration-200;
  }

  .card {
    @apply bg-white rounded-xl shadow-md p-6
           hover:shadow-lg transition-shadow duration-300;
  }

  .input-field {
    @apply w-full px-4 py-2 border border-gray-300 rounded-lg
           focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent
           placeholder-gray-400 transition-all duration-200;
  }
}
```

**Uso:**
```html
<button class="btn-primary">Salvar</button>
<button class="btn-secondary">Cancelar</button>
<div class="card">Conteúdo do card</div>
<input class="input-field" placeholder="Digite aqui..." />
```

---

## 6. Variants e Pseudo-classes

```html
<!-- Hover -->
<button class="bg-blue-500 hover:bg-blue-700 transition-colors">Hover Me</button>

<!-- Focus -->
<input class="focus:ring-2 focus:ring-blue-500 focus:outline-none" />

<!-- Active -->
<button class="active:scale-95 transition-transform">Press Me</button>

<!-- Group hover -->
<div class="group cursor-pointer">
  <div class="group-hover:bg-blue-500 p-4">
    <h3 class="group-hover:text-white">Título muda no hover do pai</h3>
    <p class="group-hover:text-blue-100">Parágrafo também</p>
  </div>
</div>

<!-- Peer -->
<div class="peer">
  <input type="checkbox" id="check" class="hidden" />
</div>
<label for="check" class="peer-checked:bg-green-500 peer-checked:text-white p-2 rounded">
  Label muda quando checkbox está marcado
</label>

<!-- First/Last/Odd/Even -->
<ul>
  <li class="first:font-bold last:italic odd:bg-gray-100 even:bg-gray-200">
    Item
  </li>
</ul>

<!-- Not -->
<div class="not(:first-child):mt-4">
  Todos exceto o primeiro têm margem top
</div>
```

---

## 7. Plugins

### @tailwindcss/forms

```javascript
// tailwind.config.js
module.exports = {
  plugins: [require('@tailwindcss/forms')],
};
```

```html
<!-- Estilos de formulário automático -->
<input type="text" class="form-input rounded-md border-gray-300" />
<select class="form-select rounded-md border-gray-300">
  <option>Opção 1</option>
</select>
<textarea class="form-textarea rounded-md border-gray-300" rows="4"></textarea>
<input type="checkbox" class="form-checkbox rounded text-blue-600" />
<input type="radio" class="form-radio text-blue-600" />
```

### @tailwindcss/typography

```html
<!-- Prose para conteúdo editorial -->
<article class="prose prose-lg prose-gray max-w-none">
  <h1>Título do Artigo</h1>
  <p>Parágrafo com <a href="#">link</a> e <strong>negrito</strong>.</p>
  
  <h2>Subtítulo</h2>
  <ul>
    <li>Item da lista</li>
    <li>Outro item</li>
  </ul>
  
  <blockquote>
    <p>Citação importante</p>
  </blockquote>
  
  <pre><code>function hello() {
  console.log('world');
}</code></pre>
</article>
```

### @tailwindcss/aspect-ratio

```html
<!-- Proporção de aspecto -->
<div class="aspect-video">
  <iframe src="video.mp4" class="w-full h-full"></iframe>
</div>

<div class="aspect-square">
  <img src="photo.jpg" class="w-full h-full object-cover" />
</div>
```

---

## 8. JIT Mode (Just-In-Time)

```html
<!-- Arbitrary values -->
<div class="w-[345px] h-[200px]">Largura e altura específicas</div>
<div class="bg-[#1da1f2]">Cor personalizada</div>
<div class="top-[117px]">Posição específica</div>
<div class="grid-cols-[200px_1fr_200px]">Grid com template</div>

<!-- Arbitrary responsive -->
<div class="min-h-[calc(100vh-64px)]">Altura mínima calculada</div>

<!-- Arbitrary variants -->
<div class="[&>*]:p-4">Todos os filhos têm padding</div>
<div class="hover:[&>p]:text-blue-500">Hover muda texto dos parágrafos filhos</div>
```

---

## 9. CSS Variables com Tailwind

```html
<!-- Definir variáveis -->
<div style="--my-color: #3b82f6;">
  <div class="bg-[var(--my-color)]">Usa variável CSS</div>
</div>

<!-- Em globals.css */
@layer base {
  :root {
    --color-primary: 59 130 246; /* RGB */
    --color-secondary: 16 185 129;
  }
}

/* Uso no HTML */
<div class="bg-[rgb(var(--color-primary))]">
  Card com cor dinâmica
</div>
```

---

## 10. Animações

```html
<!-- Animações built-in -->
<div class="animate-spin">🔄</div>
<div class="animate-pulse">Pulsando</div>
<div class="animate-bounce">Saltitando</div>
<div class="animate-ping">Ping</div>

<!-- Animação customizada em config -->
<div class="animate-bounce-slow">Bounce Lento</div>

<!-- Transições -->
<button class="transition-all duration-300 ease-in-out 
               hover:scale-105 hover:shadow-xl 
               active:scale-95">
  Botão com Transição
</button>

<!-- Animação com keyframes inline -->
<style>
  @keyframes slideIn {
    from { transform: translateX(-100%); opacity: 0; }
    to { transform: translateX(0); opacity: 1; }
  }
</style>
<div class="animate-[slideIn_0.5s_ease-out]">
  Elemento desliza para dentro
</div>
```

---

## 11. Layout

### Flexbox

```html
<!-- Flex básico -->
<div class="flex items-center justify-between">
  <span>Esquerda</span>
  <span>Direita</span>
</div>

<!-- Flex grow/shrink -->
<div class="flex">
  <div class="flex-none w-64">Não encolhe</div>
  <div class="flex-1">Ocupa o resto</div>
</div>

<!-- Flex direction -->
<div class="flex flex-col md:flex-row gap-4">
  <div>Sidebar</div>
  <div class="flex-1">Content</div>
</div>

<!-- Justify e Align -->
<div class="flex justify-center items-center h-screen">
  Centro absoluto
</div>

<div class="flex justify-end items-start gap-4">
  Alinhamento misto
</div>
```

### CSS Grid

```html
<!-- Grid básico -->
<div class="grid grid-cols-3 gap-4">
  <div>1</div>
  <div>2</div>
  <div>3</div>
</div>

<!-- Grid com colunas de tamanho específico -->
<div class="grid grid-cols-[1fr_2fr_1fr] gap-4">
  <div>Largura fixa</div>
  <div>Dobro</div>
  <div>Igual ao primeiro</div>
</div>

<!-- Grid responsivo -->
<div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6">
  <div class="col-span-2">Ocupa 2 colunas</div>
  <div>1</div>
  <div>2</div>
</div>

<!-- Grid areas -->
<div class="grid grid-areas-[header_header_nav_main_main_footer]">
  <div class="grid-area-header">Header</div>
  <div class="grid-area-nav">Nav</div>
  <div class="grid-area-main">Main</div>
  <div class="grid-area-footer">Footer</div>
</div>
```

### Container

```html
<!-- Container responsivo -->
<div class="container mx-auto px-4 sm:px-6 lg:px-8">
  Conteúdo centralizado e limitado
</div>

<!-- Container com max-width customizado -->
<div class="max-w-7xl mx-auto">
  Máximo 80rem de largura
</div>
```

---

## 12. Typography com Prose

```html
<article class="prose prose-slate dark:prose-invert max-w-2xl mx-auto">
  <h1 class="text-3xl font-bold">Guia Completo</h1>
  
  <p class="lead text-lg text-gray-600">
    Parágrafo introdutório destacado.
  </p>
  
  <h2>Seção Principal</h2>
  
  <p>Texto com <a href="#">links</a>, <strong>negrito</strong> e <em>itálico</em>.</p>
  
  <ul>
    <li>Item da lista</li>
    <li>Segundo item</li>
  </ul>
  
  <blockquote class="border-l-4 border-blue-500 pl-4 italic">
    "Uma citação inspiradora."
  </blockquote>
  
  <pre class="bg-gray-900 text-green-400 p-4 rounded-lg">
    <code>const hello = () => 'world';</code>
  </pre>
  
  <table class="w-full border-collapse">
    <thead>
      <tr class="border-b-2 border-gray-300">
        <th class="text-left py-2">Nome</th>
        <th class="text-left py-2">Valor</th>
      </tr>
    </thead>
    <tbody>
      <tr class="border-b border-gray-200">
        <td class="py-2">Item 1</td>
        <td class="py-2">100</td>
      </tr>
    </tbody>
  </table>
</article>
```

---

## 13. Forms Styling

```html
<!-- Formulário completo estilizado -->
<form class="space-y-6 max-w-md mx-auto">
  <div>
    <label class="block text-sm font-medium text-gray-700 mb-1">
      Email
    </label>
    <input 
      type="email" 
      class="w-full px-4 py-2 border border-gray-300 rounded-lg 
             focus:ring-2 focus:ring-blue-500 focus:border-transparent
             transition-colors duration-200"
      placeholder="seu@email.com"
    />
    <p class="mt-1 text-sm text-red-500 hidden">Email inválido</p>
  </div>

  <div>
    <label class="block text-sm font-medium text-gray-700 mb-1">
      Senha
    </label>
    <input 
      type="password" 
      class="w-full px-4 py-2 border border-gray-300 rounded-lg 
             focus:ring-2 focus:ring-blue-500 focus:border-transparent"
    />
  </div>

  <div class="flex items-center gap-2">
    <input type="checkbox" id="remember" class="rounded border-gray-300 text-blue-600 focus:ring-blue-500" />
    <label for="remember" class="text-sm text-gray-600">Lembrar-me</label>
  </div>

  <button type="submit" 
    class="w-full bg-blue-500 text-white py-2 px-4 rounded-lg 
           hover:bg-blue-600 focus:ring-2 focus:ring-blue-500 focus:ring-offset-2
           transition-colors duration-200">
    Entrar
  </button>
</form>
```

---

## 14. Backdrop Filters

```html
<!-- Glassmorphism -->
<div class="relative">
  <div class="absolute inset-0 bg-gradient-to-r from-blue-500 to-purple-600"></div>
  <div class="relative bg-white/10 backdrop-blur-md border border-white/20 rounded-xl p-8 text-white">
    <h2 class="text-2xl font-bold">Card Glass</h2>
    <p class="mt-2 opacity-90">Efeito de vidro fosco</p>
  </div>
</div>

<!-- Navbar com blur -->
<nav class="sticky top-0 bg-white/80 backdrop-blur-lg border-b border-gray-200 z-50">
  <div class="container mx-auto px-4 py-3 flex justify-between items-center">
    <span class="font-bold text-xl">Logo</span>
    <div class="flex gap-4">
      <a href="#" class="hover:text-blue-500">Home</a>
      <a href="#" class="hover:text-blue-500">Sobre</a>
    </div>
  </div>
</nav>

<!-- Modal com backdrop -->
<div class="fixed inset-0 bg-black/50 backdrop-blur-sm z-40"></div>
```

---

## 15. Container Queries

```html
<!-- Componente com container query -->
<div class="@container">
  <div class="@sm:flex @lg:grid @lg:grid-cols-2 gap-4">
    <div class="p-4 bg-white rounded-lg shadow">
      <h3 class="@sm:text-lg @lg:text-xl font-bold">Título Responsivo</h3>
      <p class="@sm:text-sm @lg:text-base">Texto que escala com o container</p>
    </div>
    <div class="p-4 bg-white rounded-lg shadow">
      <img class="w-full @sm:h-32 @lg:h-48 object-cover rounded" src="image.jpg" />
    </div>
  </div>
</div>

<!-- Definir container -->
<div class="@container min-h-[400px] bg-gray-100 p-4">
  <div class="@sm:w-1/2 @md:w-1/3 @lg:w-1/4">
    Conteúdo responsivo ao container
  </div>
</div>
```

---

## 16. Tailwind CSS v4 (Novidades)

```html
<!-- CSS-first configuration -->
<style type="text/tailwindcss">
  @theme {
    --color-primary: oklch(0.6 0.2 250);
    --color-secondary: oklch(0.7 0.15 170);
    --font-display: "Inter", sans-serif;
  }
</style>

<!-- @source directive -->
<style>
  @source "../components/**/*.tsx";
</style>

<!-- Variants otimizados -->
<div class="hover:bg-primary focus-visible:ring-2 supports-backdrop-blur:flex">
  v4 otimiza automaticamente
</div>

<!-- Inline theme -->
<div class="bg-primary/50 text-primary-foreground p-4">
  Cores do tema inline
</div>
```

---

## 17. Patterns Avançados

### Sidebar + Main Layout

```html
<div class="flex min-h-screen">
  <!-- Sidebar -->
  <aside class="w-64 bg-gray-900 text-white p-4 fixed h-full">
    <h2 class="text-xl font-bold mb-6">Menu</h2>
    <nav class="space-y-2">
      <a href="#" class="block px-4 py-2 rounded hover:bg-gray-800 transition">Dashboard</a>
      <a href="#" class="block px-4 py-2 rounded hover:bg-gray-800 transition">Settings</a>
    </nav>
  </aside>

  <!-- Main -->
  <main class="ml-64 flex-1 p-8">
    <header class="mb-8">
      <h1 class="text-3xl font-bold text-gray-900">Dashboard</h1>
    </header>
    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
      <!-- Cards aqui -->
    </div>
  </main>
</div>
```

### Card Grid Responsivo

```html
<div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-6">
  <div class="bg-white rounded-xl shadow-md overflow-hidden hover:shadow-xl transition-shadow duration-300">
    <img src="https://picsum.photos/400/200" class="w-full h-48 object-cover" />
    <div class="p-6">
      <h3 class="text-xl font-bold text-gray-900">Card Title</h3>
      <p class="mt-2 text-gray-600">Description text here.</p>
      <button class="mt-4 bg-blue-500 text-white px-4 py-2 rounded-lg hover:bg-blue-600 transition">
        Saiba mais
      </button>
    </div>
  </div>
</div>
```

---

## 18. Utility Patterns

### Center Anything

```html
<!-- Flex center -->
<div class="flex items-center justify-center min-h-screen">
  <div>Centralizado!</div>
</div>

<!-- Grid center -->
<div class="grid place-items-center min-h-screen">
  <div>Centralizado!</div>
</div>
```

### Sticky Footer

```html
<div class="flex flex-col min-h-screen">
  <header class="bg-white shadow">Header</header>
  <main class="flex-1">Content</main>
  <footer class="bg-gray-900 text-white p-4">Footer</footer>
</div>
```

### Aspect Ratio

```html
<div class="aspect-video bg-gray-200 rounded-lg overflow-hidden">
  <img src="video-thumb.jpg" class="w-full h-full object-cover" />
</div>
```

---

## Referências

- [Tailwind CSS Docs](https://tailwindcss.com/docs)
- [Tailwind CSS GitHub](https://github.com/tailwindlabs/tailwindcss)
- [Tailwind UI](https://tailwindui.com/)
- [Headless UI](https://headlessui.com/)
- [DaisyUI](https://daisyui.com/)
- [Flowbite](https://flowbite.com/)
