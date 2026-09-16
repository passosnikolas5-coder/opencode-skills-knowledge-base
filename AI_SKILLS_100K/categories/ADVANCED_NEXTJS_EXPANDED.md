# 🚀 ADVANCED NEXT.JS - Skills Expandidas

> **Fonte:** https://github.com/vercel/next.js (135k+ stars)
> **Descrição:** O framework React para produção — App Router, Server Components, Server Actions, Streaming e otimizações integradas.

---

## 1. 📁 App Router (Estrutura)

```
app/
├── layout.tsx          # Layout raiz (compartilhado)
├── page.tsx            # Home (/)
├── loading.tsx         # Loading global
├── error.tsx           # Error boundary global
├── not-found.tsx       # 404 global
├── (auth)/             # Grupo de rotas (sem afetar URL)
│   ├── login/page.tsx  # /login
│   └── register/page.tsx
├── dashboard/
│   ├── layout.tsx      # Layout do dashboard
│   ├── page.tsx        # /dashboard
│   └── settings/page.tsx
└── api/
    └── users/route.ts  # API Route
```

```typescript
// app/layout.tsx
import type { Metadata } from 'next'
import { Inter } from 'next/font/google'

const inter = Inter({ subsets: ['latin'] })

export const metadata: Metadata = {
  title: 'Meu App',
  description: 'Descrição do app',
}

export default function RootLayout({
  children,
}: {
  children: React.ReactNode
}) {
  return (
    <html lang="pt-BR">
      <body className={inter.className}>{children}</body>
    </html>
  )
}
```

### MELHORIA

❌ ERRADO:
```tsx
// Não crie layout desnecessariamente complexo
export default function Layout({ children }) {
  return (
    <div>
      <Header />
      {children}
      <Footer />
    </div>
  )
}
// Sem separação de concerns, sem loading states
```

✅ CORRETO:
```tsx
// app/dashboard/layout.tsx
export default function DashboardLayout({
  children,
}: {
  children: React.ReactNode
}) {
  return (
    <div className="flex">
      <Sidebar />
      <main className="flex-1">{children}</main>
    </div>
  )
}
// Layouts específicos por seção do app
```

---

## 2. 🖥️ Server Components vs Client Components

```tsx
// Server Component (padrão) — app/products/page.tsx
import { db } from '@/lib/database'

export default async function ProductsPage() {
  const products = await db.product.findMany()
  // Query direto no servidor — zero client JS

  return (
    <ul>
      {products.map(p => (
        <li key={p.id}>{p.name} - R$ {p.price}</li>
      ))}
    </ul>
  )
}

// Client Component — components/AddToCartButton.tsx
'use client'

import { useState } from 'react'
import { useCart } from '@/hooks/use-cart'

export function AddToCartButton({ productId }: { productId: string }) {
  const [quantity, setQuantity] = useState(1)
  const { addItem } = useCart()

  return (
    <button onClick={() => addItem(productId, quantity)}>
      Adicionar ao Carrinho
    </button>
  )
}
```

### MELHORIA

❌ ERRADO:
```tsx
// Não marque componentes como client sem necessidade
'use client'
export default function ProductList({ products }) {
  return products.map(p => <div key={p.id}>{p.name}</div>)
}
// Este componente não usa state/events — desnecessariamente client
```

✅ CORRETO:
```tsx
// Mantenha como Server Component por padrão
export default async function ProductList() {
  const products = await fetchProducts()
  return products.map(p => <div key={p.id}>{p.name}</div>)
}
// Apenas marque 'use client' quando precisar de useState, useEffect, events
```

---

## 3. ✏️ Server Actions (Mutations)

```typescript
// app/actions/order.ts
'use server'

import { revalidatePath } from 'next/cache'
import { redirect } from 'next/navigation'
import { z } from 'zod'

const OrderSchema = z.object({
  productId: z.string().uuid(),
  quantity: z.number().min(1).max(100),
})

export async function createOrder(formData: FormData) {
  const validated = OrderSchema.parse({
    productId: formData.get('productId'),
    quantity: Number(formData.get('quantity')),
  })

  const order = await db.order.create({
    data: {
      productId: validated.productId,
      quantity: validated.quantity,
      status: 'pending'
    }
  })

  revalidatePath('/orders')
  redirect(`/orders/${order.id}`)
}

// app/new-order/page.tsx
import { createOrder } from '@/app/actions/order'

export default function NewOrderPage() {
  return (
    <form action={createOrder}>
      <input name="productId" type="hidden" value="..." />
      <input name="quantity" type="number" defaultValue={1} />
      <button type="submit">Criar Pedido</button>
    </form>
  )
}
```

### MELHORIA

❌ ERRADO:
```typescript
// Não use Server Actions sem validação
'use server'
export async function createOrder(formData: FormData) {
  await db.order.create({
    data: {
      productId: formData.get('productId'), // Sem validação!
      quantity: Number(formData.get('quantity'))
    }
  })
}
// Injection, dados inválidos, sem tratamento de erro
```

✅ CORRETO:
```typescript
'use server'
export async function createOrder(formData: FormData) {
  const parsed = OrderSchema.safeParse({
    productId: formData.get('productId'),
    quantity: Number(formData.get('quantity'))
  })

  if (!parsed.success) {
    return { error: parsed.error.flatten().fieldErrors }
  }

  // Usar validated data
  await db.order.create({ data: parsed.data })
}
// Validação + tratamento de erro + feedback
```

---

## 4. 📡 Data Fetching

```typescript
// fetch com cache (default: force-cache)
async function getProducts() {
  const res = await fetch('https://api.example.com/products', {
    next: { revalidate: 3600 } // ISR: revalidar a cada hora
  })
  return res.json()
}

// fetch sem cache (sempre fresh)
async function getUser() {
  const res = await fetch('https://api.example.com/user', {
    cache: 'no-store' // SSR: sem cache
  })
  return res.json()
}

// fetch com tags para revalidação manual
async function getOrders() {
  const res = await fetch('https://api.example.com/orders', {
    next: { tags: ['orders'] }
  })
  return res.json()
}

// revalidateByTag
import { revalidateTag } from 'next/cache'

export async function refreshOrders() {
  revalidateTag('orders')
}

// Cookies e Headers
import { cookies, headers } from 'next/headers'

async function getProfile() {
  const cookieStore = await cookies()
  const token = cookieStore.get('session')?.value

  const res = await fetch('https://api.example.com/profile', {
    headers: { Authorization: `Bearer ${token}` }
  })
  return res.json()
}
```

### MELHORIA

❌ ERRADO:
```typescript
// Não fetch sem estratégia de cache
async function getData() {
  const res = await fetch('/api/data') // Cache indefinido
  return res.json()
}
// Pode servir dados stale ou frescos sem controle
```

✅ CORRETO:
```typescript
// Defina explicitamente a estratégia
async function getData() {
  const res = await fetch('/api/data', {
    next: {
      revalidate: 60,      // ISR: revalida a cada 60s
      tags: ['data']       // ou revalidateTag para controle manual
    }
  })
  return res.json()
}
```

---

## 5. 🔀 API Routes / Route Handlers

```typescript
// app/api/products/route.ts
import { NextRequest, NextResponse } from 'next/server'
import { z } from 'zod'

const ProductSchema = z.object({
  name: z.string().min(1).max(100),
  price: z.number().positive(),
})

export async function GET(request: NextRequest) {
  const searchParams = request.nextUrl.searchParams
  const page = Number(searchParams.get('page') || 1)
  const limit = Number(searchParams.get('limit') || 10)

  const products = await db.product.findMany({
    skip: (page - 1) * limit,
    take: limit,
  })

  return NextResponse.json({ products, page, limit })
}

export async function POST(request: NextRequest) {
  try {
    const body = await request.json()
    const validated = ProductSchema.parse(body)

    const product = await db.product.create({ data: validated })
    return NextResponse.json(product, { status: 201 })
  } catch (error) {
    if (error instanceof z.ZodError) {
      return NextResponse.json(
        { error: error.errors },
        { status: 400 }
      )
    }
    return NextResponse.json(
      { error: 'Internal Server Error' },
      { status: 500 }
    )
  }
}

// Route Handler com Dynamic Segments
// app/api/products/[id]/route.ts
export async function GET(
  request: NextRequest,
  { params }: { params: { id: string } }
) {
  const { id } = await params
  const product = await db.product.findUnique({ where: { id } })

  if (!product) {
    return NextResponse.json({ error: 'Not found' }, { status: 404 })
  }

  return NextResponse.json(product)
}
```

### MELHORIA

❌ ERRADO:
```typescript
// Não aceite body sem validação
export async function POST(request: NextRequest) {
  const body = await request.json()
  await db.product.create({ data: body }) // Injection vulnerável!
  return NextResponse.json({ success: true })
}
```

✅ CORRETO:
```typescript
export async function POST(request: NextRequest) {
  const body = await request.json()
  const validated = ProductSchema.parse(body) // Validação obrigatória
  const product = await db.product.create({ data: validated })
  return NextResponse.json(product, { status: 201 })
}
```

---

## 6. 🔀 Middleware

```typescript
// middleware.ts (raiz do projeto)
import { NextResponse } from 'next/server'
import type { NextRequest } from 'next/server'

export function middleware(request: NextRequest) {
  const token = request.cookies.get('session')?.value

  // Proteger rotas do dashboard
  if (request.nextUrl.pathname.startsWith('/dashboard')) {
    if (!token) {
      return NextResponse.redirect(new URL('/login', request.url))
    }
  }

  // Rate limiting básico
  const ip = request.ip || request.headers.get('x-forwarded-for')
  // Implementar lógica de rate limiting

  return NextResponse.next()
}

export const config = {
  matcher: [
    '/dashboard/:path*',
    '/api/:path*',
    '/((?!_next/static|_next/image|favicon.ico).*)',
  ]
}
```

```typescript
// Middleware com geolocalização
export function middleware(request: NextRequest) {
  const country = request.geo?.country || 'BR'

  // Redirecionar baseado no país
  if (country === 'US') {
    return NextResponse.rewrite(new URL('/en' + request.nextUrl.pathname, request.url))
  }

  return NextResponse.next()
}
```

### MELHORIA

❌ ERRADO:
```typescript
// Não valide auth apenas no middleware
export function middleware(request: NextRequest) {
  const token = request.cookies.get('session')?.value
  if (token) return NextResponse.next()
  return NextResponse.redirect(new URL('/login', request.url))
}
// Client-side auth pode ser bypassado
```

✅ CORRETO:
```typescript
// Middleware + Server Components + RLS = defense in depth
// Middleware: primeira barreira
// Server Components: verificação no servidor
// RLS: proteção no banco de dados
export function middleware(request: NextRequest) {
  // Rate limiting + redirecionamento básico
  return NextResponse.next()
}
// A verificação real acontece nos Server Components e RLS
```

---

## 7. 🖼️ Image Optimization

```tsx
import Image from 'next/image'

// Imagem otimizada automática
export default function ProductImage() {
  return (
    <Image
      src="/products/camera.jpg"
      alt="Câmera profissional"
      width={600}
      height={400}
      priority // Above-the-fold
      placeholder="blur"
      blurDataURL="data:image/jpeg;base64,..."
    />
  )
}

// Imagem remota
const remotePatterns = [
  {
    protocol: 'https',
    hostname: 'images.unsplash.com',
  },
]

// next.config.js
module.exports = {
  images: {
    remotePatterns,
    formats: ['image/avif', 'image/webp'],
    deviceSizes: [640, 750, 828, 1080, 1200],
  },
}
```

```tsx
// Imagem responsiva com múltiplos tamanhos
export default function HeroImage() {
  return (
    <Image
      src="/hero.jpg"
      alt="Hero"
      fill
      className="object-cover"
      sizes="(max-width: 768px) 100vw, (max-width: 1200px) 50vw, 33vw"
    />
  )
}
```

### MELHORIA

❌ ERRADO:
```tsx
// Não use <img> nativo no Next.js
<img src="/photo.jpg" alt="Foto" />
// Sem otimização, sem lazy loading, sem formatos modernos
```

✅ CORRETO:
```tsx
import Image from 'next/image'

<Image
  src="/photo.jpg"
  alt="Foto"
  width={800}
  height={600}
  loading="lazy"
/>
// Otimização automática, lazy loading, WebP/AVIF, responsive
```

---

## 8. 🔤 Font Optimization

```tsx
import { Inter, Roboto_Slab } from 'next/font/google'

const inter = Inter({
  subsets: ['latin'],
  display: 'swap',
  variable: '--font-inter',
})

const robotoSlab = Roboto_Slab({
  subsets: ['latin'],
  display: 'swap',
  variable: '--font-roboto-slab',
})

export default function RootLayout({ children }) {
  return (
    <html className={`${inter.variable} ${robotoSlab.variable}`}>
      <body className={inter.className}>{children}</body>
    </html>
  )
}
```

```css
/* Usar variáveis de fonte no CSS */
.text-heading {
  font-family: var(--font-roboto-slab);
}

.text-body {
  font-family: var(--font-inter);
}
```

### MELHORIA

❌ ERRADO:
```tsx
// Não importe fontes via <link> no layout
export default function Layout({ children }) {
  return (
    <head>
      <link href="https://fonts.googleapis.com/css2?family=Inter" rel="stylesheet" />
    </head>
    <body>{children}</body>
  </head>
  )
}
// FOIT (Flash of Invisible Text) + layout shift
```

✅ CORRETO:
```tsx
import { Inter } from 'next/font/google'

const inter = Inter({ subsets: ['latin'], display: 'swap' })

export default function Layout({ children }) {
  return (
    <html className={inter.className}>
      <body>{children}</body>
    </html>
  )
}
// Fonte otimizada pelo Next.js, sem FOIT
```

---

## 9. 📝 Metadata API

```typescript
// Metadata estática
import type { Metadata } from 'next'

export const metadata: Metadata = {
  title: {
    template: '%s | Meu App',
    default: 'Meu App',
  },
  description: 'Descrição do app',
  openGraph: {
    title: 'Meu App',
    description: 'Descrição',
    images: ['/og-image.jpg'],
    type: 'website',
  },
  twitter: {
    card: 'summary_large_image',
    title: 'Meu App',
    images: ['/og-image.jpg'],
  },
  robots: {
    index: true,
    follow: true,
  },
}

// Metadata dinâmica
export async function generateMetadata({ params }) {
  const product = await getProduct(params.id)

  return {
    title: product.name,
    description: product.description,
    openGraph: {
      title: product.name,
      images: [product.image],
    },
  }
}
```

### MELHORIA

❌ ERRADO:
```tsx
// Não use <head> manualmente para meta tags
export default function Page() {
  return (
    <head>
      <title>Meu App</title>
      <meta name="description" content="..." />
    </head>
    <main>...</main>
  )
}
// Não funciona com Server Components, sem suporte a templates
```

✅ CORRETO:
```tsx
// Use Metadata API
export const metadata: Metadata = {
  title: 'Meu App',
  description: 'Descrição do app',
}
// Suporte a templates, geração dinâmica, SEO otimizado
```

---

## 10. 🔀 Parallel & Intercepting Routes

```tsx
// Parallel Routes — múltiplos layouts simultâneos
// app/layout.tsx
export default function Layout({ children, analytics, modal }) {
  return (
    <div>
      {children}
      {analytics}
      {modal}
    </div>
  )
}

// app/@analytics/page.tsx
export default function AnalyticsSlot() {
  return <AnalyticsDashboard />
}

// app/@modal/(.)product/[id]/page.tsx
// Intercepting: /product/123 mostra modal + página por trás
export default function ProductModal({ params }) {
  return (
    <Modal>
      <ProductDetail id={params.id} />
    </Modal>
  )
}
```

### MELHORIA

❌ ERRADO:
```tsx
// Não use modais com state global sem necessidade
const [showModal, setShowModal] = useState(false)
// Modais que não funcionam com URL, sem SSR, sem compartilhamento
```

✅ CORRETO:
```tsx
// Use Intercepting Routes para modais com URL
// app/@modal/(.)product/[id]/page.tsx
// Modal acessível via URL, funciona com SSR, compartilhável
```

---

## 11. 🌊 Streaming & Suspense

```tsx
// app/dashboard/page.tsx
import { Suspense } from 'react'

export default function Dashboard() {
  return (
    <div>
      <h1>Dashboard</h1>
      <Suspense fallback={<StatsSkeleton />}>
        <Stats />
      </Suspense>
      <Suspense fallback={<OrdersSkeleton />}>
        <RecentOrders />
      </Suspense>
      <Suspense fallback={<ChartSkeleton />}>
        <AnalyticsChart />
      </Suspense>
    </div>
  )
}

// Streaming com loading.tsx
// app/dashboard/loading.tsx
export default function Loading() {
  return <div>Carregando dashboard...</div>
}

// Server Component com async
async function Stats() {
  const stats = await getStats() // Pode demorar
  return <StatsDisplay data={stats} />
}
```

### MELHORIA

❌ ERRADO:
```tsx
// Não carregue tudo sequencialmente
export default async function Dashboard() {
  const stats = await getStats()       // 2s
  const orders = await getOrders()     // 1s
  const analytics = await getAnalytics() // 3s
  // Total: 6s — usuário vê nada por 6 segundos
  return <DashboardUI stats={stats} orders={orders} analytics={analytics} />
}
```

✅ CORRETO:
```tsx
// Use Suspense para streaming paralelo
export default function Dashboard() {
  return (
    <div>
      <Suspense fallback={<Skeleton />}>
        <Stats />      {/* Começa a carregar imediatamente */}
      </Suspense>
      <Suspense fallback={<Skeleton />}>
        <Orders />     {/* Começa a carregar imediatamente */}
      </Suspense>
    </div>
  )
}
// Usuário vê conteúdo incremental em vez de esperar tudo
```

---

## 12. ⚡ ISR, SSR, SSG

```typescript
// SSG (Static Site Generation) — build time
export async function generateStaticParams() {
  const products = await db.product.findMany()
  return products.map(p => ({ id: p.id }))
}

// ISR (Incremental Static Regeneration) — revalidação
async function getProduct(id: string) {
  const res = await fetch(`https://api.example.com/products/${id}`, {
    next: { revalidate: 3600 } // Revalidar a cada hora
  })
  return res.json()
}

// SSR (Server Side Request) — sem cache
async function getRealTimeData() {
  const res = await fetch('https://api.example.com/realtime', {
    cache: 'no-store'
  })
  return res.json()
}

// On-demand revalidation
import { revalidatePath, revalidateTag } from 'next/cache'

// Via Server Action
export async function updateProduct(id: string, data: ProductData) {
  await db.product.update({ where: { id }, data })
  revalidatePath('/products')
  revalidatePath(`/products/${id}`)
  revalidateTag('products')
}

// Via API Route
export async function POST(request: NextRequest) {
  const body = await request.json()
  revalidateTag('products')
  return NextResponse.json({ revalidated: true })
}
```

### MELHORIA

❌ ERRADO:
```typescript
// Não use SSR quando SSG é suficiente
export const dynamic = 'force-dynamic'
export default async function ProductsPage() {
  const products = await fetchProducts() // Sempre fresco
  return <ProductList products={products} />
}
// Produtos não mudam a cada segundo — SSR desnecessário
```

✅ CORRETO:
```typescript
// Use a estratégia adequada
// SSG: páginas estáticas que mudam raramente
export async function generateStaticParams() { ... }

// ISR: páginas que precisam de dados atualizados periodicamente
const res = await fetch(url, { next: { revalidate: 3600 } })

// SSR: dados que precisam ser frescos a cada request
const res = await fetch(url, { cache: 'no-store' })
```

---

## 13. 🔐 Authentication Patterns

```typescript
// lib/auth.ts
import { createServerClient } from '@supabase/ssr'
import { cookies } from 'next/headers'

export async function getSession() {
  const supabase = await createServerClient(
    process.env.NEXT_PUBLIC_SUPABASE_URL!,
    process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY!,
    {
      cookies: {
        getAll: () => cookies().getAll(),
        setAll: (cookiesToSet) => {
          cookiesToSet.forEach(({ name, value, options }) => {
            cookies().set(name, value, options)
          })
        },
      },
    }
  )

  const { data: { session } } = await supabase.auth.getSession()
  return session
}

// Middleware de proteção
export async function requireAuth() {
  const session = await getSession()
  if (!session) {
    redirect('/login')
  }
  return session
}

// Server Component protegido
import { requireAuth } from '@/lib/auth'

export default async function DashboardPage() {
  const session = await requireAuth()
  // Usuário autenticado garantido

  const { data: orders } = await supabase
    .from('orders')
    .select('*')
    .eq('user_id', session.user.id)

  return <Dashboard orders={orders} />
}
```

### MELHORIA

❌ ERRADO:
```tsx
// Não proteja rotas apenas no client-side
'use client'
import { useEffect, useState } from 'react'

export default function Dashboard() {
  const [user, setUser] = useState(null)

  useEffect(() => {
    const session = getSession()
    if (!session) router.push('/login')
    setUser(session)
  }, [])

  // Usuário pode ver conteúdo por um momento antes do redirect
}
```

✅ CORRETO:
```typescript
// Server-side auth check — sem flash de conteúdo
export default async function DashboardPage() {
  const session = await requireAuth() // Redirect no servidor
  // Conteúdo nunca chega ao client se não autenticado
}
```

---

## 14. 🗄️ Database Integration (Prisma/Drizzle)

```typescript
// lib/prisma.ts
import { PrismaClient } from '@prisma/client'

const globalForPrisma = globalThis as unknown as {
  prisma: PrismaClient | undefined
}

export const prisma = globalForPrisma.prisma ?? new PrismaClient()

if (process.env.NODE_ENV !== 'production') globalForPrisma.prisma = prisma

// Server Component com Prisma
export default async function ProductsPage() {
  const products = await prisma.product.findMany({
    include: { category: true, reviews: true },
    orderBy: { createdAt: 'desc' },
    take: 20,
  })

  return <ProductGrid products={products} />
}

// Server Action com Prisma
'use server'
export async function createProduct(data: ProductInput) {
  const validated = ProductSchema.parse(data)
  return prisma.product.create({ data: validated })
}
```

```typescript
// Drizzle ORM
import { drizzle } from 'drizzle-orm/node-postgres'
import { products } from '@/db/schema'

const db = drizzle(process.env.DATABASE_URL!)

export default async function ProductsPage() {
  const allProducts = await db.select().from(products).limit(20)
  return <ProductGrid products={allProducts} />
}
```

### MELHORIA

❌ ERRADO:
```typescript
// Não crie PrismaClient a cada request
export default async function Page() {
  const prisma = new PrismaClient() // Connection leak!
  const data = await prisma.product.findMany()
  return <div>{data.length}</div>
}
```

✅ CORRETO:
```typescript
// Use singleton pattern
import { prisma } from '@/lib/prisma'

export default async function Page() {
  const data = await prisma.product.findMany()
  return <div>{data.length}</div>
}
// Conexão reutilizada, sem memory leak
```

---

## 15. 🚢 Deployment (Vercel/Docker)

```dockerfile
# Dockerfile para Next.js
FROM node:18-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build

FROM node:18-alpine AS runner
WORKDIR /app
ENV NODE_ENV production

COPY --from=builder /app/public ./public
COPY --from=builder /app/.next/standalone ./
COPY --from=builder /app/.next/static ./.next/static

EXPOSE 3000
ENV PORT 3000
CMD ["node", "server.js"]
```

```javascript
// next.config.js para standalone output
module.exports = {
  output: 'standalone',
  experimental: {
    serverActions: {
      bodySizeLimit: '2mb',
    },
  },
}
```

### MELHORIA

❌ ERRADO:
```dockerfile
# Não use node:latest nem instale deps desnecessárias
FROM node:latest
WORKDIR /app
COPY . .
RUN npm install
RUN npm run build
EXPOSE 3000
CMD ["npm", "start"]
// Imagem enorme, sem cache de camadas, sem multi-stage
```

✅ CORRETO:
```dockerfile
# Multi-stage build + alpine + cache de camadas
FROM node:18-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production
COPY . .
RUN npm run build

FROM node:18-alpine
WORKDIR /app
COPY --from=builder /app/.next/standalone ./
EXPOSE 3000
CMD ["node", "server.js"]
// Imagem mínima, build otimizado
```

---

## 16. ⚡ Performance Optimization

```typescript
// Dynamic imports para code splitting
import dynamic from 'next/dynamic'

const HeavyChart = dynamic(() => import('@/components/HeavyChart'), {
  loading: () => <ChartSkeleton />,
  ssr: false, // Não renderizar no servidor
})

// React.cache para deduplicação
import { cache } from 'react'

export const getUser = cache(async (id: string) => {
  const res = await fetch(`/api/users/${id}`)
  return res.json()
})
// Mesma requisição não é duplicada no mesmo render

// React.memo para evitar re-renders desnecessários
import { memo } from 'react'

const ExpensiveList = memo(function ExpensiveList({ items }) {
  return items.map(item => <ExpensiveItem key={item.id} item={item} />)
})
```

```typescript
// Prefetch de rotas
'use client'
import Link from 'next/link'

export function Navigation() {
  return (
    <nav>
      <Link href="/dashboard" prefetch={true}>Dashboard</Link>
      {/* Prefetch automático ao hover */}
    </nav>
  )
}
```

### MELHORIA

❌ ERRADO:
```tsx
// Não importe componentes pesados sem lazy loading
import HeavyChart from '@/components/HeavyChart'
// HeavyChart carrega em todos os renders, mesmo sem ser visível
```

✅ CORRETO:
```tsx
import dynamic from 'next/dynamic'

const HeavyChart = dynamic(() => import('@/components/HeavyChart'), {
  loading: () => <Skeleton />,
  ssr: false,
})
// Code splitting automático — carrega apenas quando necessário
```

---

## 17. 🧪 Testing (Jest + Playwright)

```typescript
// __tests__/products.test.ts
import { render, screen } from '@testing-library/react'
import ProductsPage from '@/app/products/page'

// Mock do banco de dados
jest.mock('@/lib/database', () => ({
  db: {
    product: {
      findMany: jest.fn().mockResolvedValue([
        { id: '1', name: 'Produto Teste', price: 99.99 }
      ])
    }
  }
}))

describe('ProductsPage', () => {
  it('renders products', async () => {
    render(await ProductsPage())
    expect(screen.getByText('Produto Teste')).toBeInTheDocument()
  })
})
```

```typescript
// e2e/products.spec.ts (Playwright)
import { test, expect } from '@playwright/test'

test('user can view products', async ({ page }) => {
  await page.goto('/products')
  await expect(page.locator('h1')).toHaveText('Produtos')

  const productCard = page.locator('[data-testid="product-card"]').first()
  await expect(productCard).toBeVisible()
})

test('user can add product to cart', async ({ page }) => {
  await page.goto('/products')
  await page.locator('[data-testid="add-to-cart"]').first().click()
  await expect(page.locator('[data-testid="cart-count"]')).toHaveText('1')
})
```

### MELHORIA

❌ ERRADO:
```typescript
// Não teste implementação, teste comportamento
it('calls fetchProducts', async () => {
  const spy = jest.spyOn(global, 'fetch')
  render(<ProductList />)
  expect(spy).toHaveBeenCalled() // Testa implementação, não comportamento
})
```

✅ CORRETO:
```typescript
// Teste o que o usuário vê e faz
it('displays product list', async () => {
  render(<ProductList />)
  expect(screen.getByText('Produto Teste')).toBeInTheDocument()
  expect(screen.getByText('R$ 99,99')).toBeInTheDocument()
})
// Testa o resultado visível, não a implementação interna
```

---

## 18. 🔧 Configuração Avançada

```typescript
// next.config.js
module.exports = {
  // Headers de segurança
  async headers() {
    return [
      {
        source: '/(.*)',
        headers: [
          { key: 'X-Frame-Options', value: 'DENY' },
          { key: 'X-Content-Type-Options', value: 'nosniff' },
          { key: 'Referrer-Policy', value: 'origin-when-cross-origin' },
          {
            key: 'Content-Security-Policy',
            value: "default-src 'self'; script-src 'self' 'unsafe-eval'"
          },
        ],
      },
    ]
  },

  // Redirecionamentos
  async redirects() {
    return [
      {
        source: '/old-path',
        destination: '/new-path',
        permanent: true,
      },
    ]
  },

  // Rewrites (proxy)
  async rewrites() {
    return [
      {
        source: '/api/:path*',
        destination: 'https://backend.example.com/:path*',
      },
    ]
  },

  // Webpack personalizado
  webpack: (config, { isServer }) => {
    if (!isServer) {
      config.resolve.fallback = { fs: false }
    }
    return config
  },
}
```

### MELHORIA

❌ ERRADO:
```javascript
// Não use configurações permissivas em produção
module.exports = {
  // Sem headers de segurança
  // Sem CSP
  // Sem redirects
}
// App vulnerável a XSS, clickjacking, etc.
```

✅ CORRETO:
```javascript
module.exports = {
  async headers() {
    return [{
      source: '/(.*)',
      headers: [
        { key: 'X-Frame-Options', value: 'DENY' },
        { key: 'X-Content-Type-Options', value: 'nosniff' },
        { key: 'Strict-Transport-Security', value: 'max-age=63072000' },
      ]
    }]
  }
}
// Headers de segurança obrigatórios
```

---

## 19. 📊 Error Handling

```tsx
// app/error.tsx
'use client'

export default function Error({
  error,
  reset,
}: {
  error: Error & { digest?: string }
  reset: () => void
}) {
  return (
    <div>
      <h2>Algo deu errado!</h2>
      <p>{error.message}</p>
      <button onClick={() => reset()}>Tentar novamente</button>
    </div>
  )
}

// app/not-found.tsx
export default function NotFound() {
  return (
    <div>
      <h2>404 - Página não encontrada</h2>
      <a href="/">Voltar ao início</a>
    </div>
  )
}

// Error boundary por segmento
// app/dashboard/settings/error.tsx
'use client'
export default function SettingsError({ error, reset }) {
  return <div>Erro nas configurações: {error.message}</div>
}
```

### MELHORIA

❌ ERRADO:
```tsx
// Não ignore erros silenciosamente
async function getData() {
  try {
    return await fetch('/api/data').then(r => r.json())
  } catch {
    return null // Erro sumiu — difícil debugar
  }
}
```

✅ CORRETO:
```tsx
async function getData() {
  try {
    return await fetch('/api/data').then(r => r.json())
  } catch (error) {
    console.error('Erro ao buscar dados:', error)
    throw error // Deixa o error boundary tratar
  }
}
// Erro registrado + tratamento adequado
```

---

## 20. 🎨 Tailwind CSS Integration

```tsx
// app/layout.tsx
import '@/styles/globals.css'

// styles/globals.css
@tailwind base;
@tailwind components;
@tailwind utilities;

// Componente com Tailwind
export function Button({ children, variant = 'primary' }) {
  const variants = {
    primary: 'bg-blue-600 text-white hover:bg-blue-700',
    secondary: 'bg-gray-200 text-gray-800 hover:bg-gray-300',
    danger: 'bg-red-600 text-white hover:bg-red-700',
  }

  return (
    <button className={`px-4 py-2 rounded-lg font-medium transition-colors ${variants[variant]}`}>
      {children}
    </button>
  )
}
```

### MELHORIA

❌ ERRADO:
```tsx
// Não use classes inline para estilos complexos
<div style={{ display: 'flex', justifyContent: 'center', padding: '16px' }}>
  <span style={{ color: '#3B82F6', fontWeight: 'bold' }}>Texto</span>
</div>
// Sem responsividade, sem design system, difícil de manter
```

✅ CORRETO:
```tsx
<div className="flex justify-center p-4">
  <span className="text-blue-500 font-bold">Texto</span>
</div>
// Tailwind: responsivo, consistente, tree-shakeable
```

---

## 📋 Resumo das Skills

| # | Skill | Dificuldade |
|---|-------|-------------|
| 1 | App Router | ⭐⭐ |
| 2 | Server/Client Components | ⭐⭐⭐ |
| 3 | Server Actions | ⭐⭐⭐ |
| 4 | Data Fetching | ⭐⭐⭐ |
| 5 | API Routes | ⭐⭐ |
| 6 | Middleware | ⭐⭐⭐ |
| 7 | Image Optimization | ⭐⭐ |
| 8 | Font Optimization | ⭐ |
| 9 | Metadata API | ⭐⭐ |
| 10 | Parallel/Intercepting Routes | ⭐⭐⭐⭐ |
| 11 | Streaming & Suspense | ⭐⭐⭐ |
| 12 | ISR/SSR/SSG | ⭐⭐⭐ |
| 13 | Authentication | ⭐⭐⭐ |
| 14 | Database Integration | ⭐⭐⭐ |
| 15 | Deployment | ⭐⭐ |
| 16 | Performance | ⭐⭐⭐ |
| 17 | Testing | ⭐⭐⭐ |
| 18 | Configuração Avançada | ⭐⭐ |
| 19 | Error Handling | ⭐⭐ |
| 20 | Tailwind CSS | ⭐⭐ |
