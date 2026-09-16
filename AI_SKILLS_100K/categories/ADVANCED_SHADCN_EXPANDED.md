# 🎨 shadcn/ui — Biblioteca de Componentes Avançada

**Fonte:** https://github.com/shadcn-ui/ui (85k+ stars)
**Descrição:** shadcn/ui é uma coleção de componentes reutilizáveis construídos com Radix UI e Tailwind CSS, projetada para Next.js e React. Oferece instalação via CLI, customização profunda e acessibilidade nativa.

---

## 📦 1. Instalação e Configuração Inicial

```bash
npx shadcn-ui@latest init
```

```typescript
// components.json
{
  "$schema": "https://ui.shadcn.com/schema.json",
  "style": "default",
  "rsc": true,
  "tsx": true,
  "tailwind": {
    "config": "tailwind.config.ts",
    "css": "src/app/globals.css",
    "baseColor": "slate",
    "cssVariables": true
  },
  "aliases": {
    "components": "@/components",
    "utils": "@/lib/utils"
  }
}
```

```typescript
// lib/utils.ts
import { clsx, type ClassValue } from "clsx"
import { twMerge } from "tailwind-merge"

export function cn(...inputs: ClassValue[]) {
  return twMerge(clsx(inputs))
}
```

---

## 🔘 2. Botões (Button)

```typescript
import { Button } from "@/components/ui/button"

export function ButtonDemo() {
  return (
    <div className="flex gap-4">
      <Button variant="default">Padrão</Button>
      <Button variant="destructive">Destrutivo</Button>
      <Button variant="outline">Outline</Button>
      <Button variant="secondary">Secundário</Button>
      <Button variant="ghost">Fantasma</Button>
      <Button variant="link">Link</Button>
      <Button size="sm">Pequeno</Button>
      <Button size="lg">Grande</Button>
      <Button disabled>Desabilitado</Button>
    </div>
  )
}
```

---

## 🃏 3. Cards

```typescript
import { Card, CardContent, CardDescription, CardFooter, CardHeader, CardTitle } from "@/components/ui/card"
import { Button } from "@/components/ui/button"

export function CardDemo() {
  return (
    <Card className="w-[350px]">
      <CardHeader>
        <CardTitle>Criar projeto</CardTitle>
        <CardDescription>Deploy seu novo projeto em um clique.</CardDescription>
      </CardHeader>
      <CardContent>
        <p>Configure as opções de deploy antes de continuar.</p>
      </CardContent>
      <CardFooter className="flex justify-between">
        <Button variant="ghost">Cancelar</Button>
        <Button>Deploy</Button>
      </CardFooter>
    </Card>
  )
}
```

---

## 🎭 4. Dialog (Modal)

```typescript
import { Dialog, DialogContent, DialogDescription, DialogFooter, DialogHeader, DialogTitle, DialogTrigger } from "@/components/ui/dialog"
import { Button } from "@/components/ui/button"

export function DialogDemo() {
  return (
    <Dialog>
      <DialogTrigger asChild>
        <Button variant="outline">Abrir Diálogo</Button>
      </DialogTrigger>
      <DialogContent className="sm:max-w-[425px]">
        <DialogHeader>
          <DialogTitle>Editar perfil</DialogTitle>
          <DialogDescription>
            Faça alterações no seu perfil aqui.
          </DialogDescription>
        </DialogHeader>
        <div className="grid gap-4 py-4">
          <p>Conteúdo do diálogo</p>
        </div>
        <DialogFooter>
          <Button type="submit">Salvar</Button>
        </DialogFooter>
      </DialogContent>
    </Dialog>
  )
}
```

---

## 📊 5. Tabela (Table)

```typescript
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table"

const invoices = [
  { invoice: "INV001", status: "Pago", method: "Cartão", amount: "$250.00" },
  { invoice: "INV002", status: "Pendente", method: "Boleto", amount: "$150.00" },
]

export function TableDemo() {
  return (
    <Table>
      <TableHeader>
        <TableRow>
          <TableHead>Fatura</TableHead>
          <TableHead>Status</TableHead>
          <TableHead>Método</TableHead>
          <TableHead className="text-right">Valor</TableHead>
        </TableRow>
      </TableHeader>
      <TableBody>
        {invoices.map((inv) => (
          <TableRow key={inv.invoice}>
            <TableCell className="font-medium">{inv.invoice}</TableCell>
            <TableCell>{inv.status}</TableCell>
            <TableCell>{inv.method}</TableCell>
            <TableCell className="text-right">{inv.amount}</TableCell>
          </TableRow>
        ))}
      </TableBody>
    </Table>
  )
}
```

---

## 🎨 6. Temas e CSS Variables

```css
/* globals.css */
@tailwind base;
@tailwind components;
@tailwind utilities;

@layer base {
  :root {
    --background: 0 0% 100%;
    --foreground: 222.2 84% 4.9%;
    --primary: 222.2 47.4% 11.2%;
    --primary-foreground: 210 40% 98%;
    --secondary: 210 40% 96.1%;
    --secondary-foreground: 222.2 47.4% 11.2%;
    --destructive: 0 84.2% 60.2%;
    --destructive-foreground: 210 40% 98%;
    --border: 214.3 31.8% 91.4%;
    --input: 214.3 31.8% 91.4%;
    --ring: 222.2 84% 4.9%;
    --radius: 0.5rem;
  }

  .dark {
    --background: 222.2 84% 4.9%;
    --foreground: 210 40% 98%;
    --primary: 210 40% 98%;
    --primary-foreground: 222.2 47.4% 11.2%;
    --secondary: 217.2 32.6% 17.5%;
    --secondary-foreground: 210 40% 98%;
  }
}
```

---

## 📝 7. Formulários com React Hook Form + Zod

```typescript
import { useForm } from "react-hook-form"
import { zodResolver } from "@hookform/resolvers/zod"
import * as z from "zod"
import { Button } from "@/components/ui/button"
import { Form, FormControl, FormField, FormItem, FormLabel, FormMessage } from "@/components/ui/form"
import { Input } from "@/components/ui/input"

const formSchema = z.object({
  username: z.string().min(2, "Mínimo 2 caracteres"),
  email: z.string().email("Email inválido"),
})

export function ProfileForm() {
  const form = useForm<z.infer<typeof formSchema>>({
    resolver: zodResolver(formSchema),
    defaultValues: { username: "", email: "" },
  })

  return (
    <Form {...form}>
      <form onSubmit={form.handleSubmit(onSubmit)} className="space-y-8">
        <FormField control={form.control} name="username" render={({ field }) => (
          <FormItem>
            <FormLabel>Usuário</FormLabel>
            <FormControl><Input {...field} /></FormControl>
            <FormMessage />
          </FormItem>
        )} />
        <Button type="submit">Enviar</Button>
      </form>
    </Form>
  )
}
```

---

## 🔔 8. Toast Notifications

```typescript
import { useToast } from "@/hooks/use-toast"
import { Button } from "@/components/ui/button"
import { ToastAction } from "@/components/ui/toast"

export function ToastDemo() {
  const { toast } = useToast()

  return (
    <Button onClick={() => toast({
      title: "Agendado!",
      description: "Terça-feira, 15 de agosto de 2025.",
      action: <ToastAction altText="Desfazer">Desfazer</ToastAction>,
    })}>
      Mostrar Toast
    </Button>
  )
}
```

---

## 🔍 9. Command Palette

```typescript
import { CommandDialog, CommandEmpty, CommandGroup, CommandInput, CommandItem, CommandList } from "@/components/ui/command"

export function CommandDemo() {
  const [open, setOpen] = React.useState(false)

  return (
    <>
      <Button onClick={() => setOpen(true)}>Buscar... ⌘K</Button>
      <CommandDialog open={open} onOpenChange={setOpen}>
        <CommandInput placeholder="Digite um comando..." />
        <CommandList>
          <CommandEmpty>Nenhum resultado encontrado.</CommandEmpty>
          <CommandGroup heading="Sugestões">
            <CommandItem>Calendar</CommandItem>
            <CommandItem>Search Emoji</CommandItem>
          </CommandGroup>
        </CommandList>
      </CommandDialog>
    </>
  )
}
```

---

## 🧭 10. Navegação (Sidebar)

```typescript
import { Sidebar, SidebarContent, SidebarGroup, SidebarGroupLabel, SidebarMenu, SidebarMenuItem, SidebarMenuButton } from "@/components/ui/sidebar"

export function AppSidebar() {
  return (
    <Sidebar>
      <SidebarContent>
        <SidebarGroup>
          <SidebarGroupLabel>Menu</SidebarGroupLabel>
          <SidebarMenu>
            <SidebarMenuItem>
              <SidebarMenuButton asChild>
                <a href="/dashboard">Dashboard</a>
              </SidebarMenuButton>
            </SidebarMenuItem>
            <SidebarMenuItem>
              <SidebarMenuButton asChild>
                <a href="/settings">Configurações</a>
              </SidebarMenuButton>
            </SidebarMenuItem>
          </SidebarMenu>
        </SidebarGroup>
      </SidebarContent>
    </Sidebar>
  )
}
```

---

## 🏷️ 11. Badges e Avatares

```typescript
import { Badge } from "@/components/ui/badge"
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar"

export function BadgeAvatarDemo() {
  return (
    <div className="flex items-center gap-4">
      <Badge variant="default">Novo</Badge>
      <Badge variant="secondary">Secundário</Badge>
      <Badge variant="destructive">Erro</Badge>
      <Badge variant="outline">Outline</Badge>

      <Avatar>
        <AvatarImage src="https://github.com/shadcn.png" />
        <AvatarFallback>CN</AvatarFallback>
      </Avatar>
    </div>
  )
}
```

---

## ⚠️ 12. Alertas

```typescript
import { Alert, AlertDescription, AlertTitle } from "@/components/ui/alert"

export function AlertDemo() {
  return (
    <Alert>
      <AlertTitle>Atenção!</AlertTitle>
      <AlertDescription>
        Você tem uma nova notificação pendente.
      </AlertDescription>
    </Alert>
  )
}
```

---

## ⏳ 13. Skeleton Loading

```typescript
import { Skeleton } from "@/components/ui/skeleton"

export function SkeletonDemo() {
  return (
    <div className="flex items-center space-x-4">
      <Skeleton className="h-12 w-12 rounded-full" />
      <div className="space-y-2">
        <Skeleton className="h-4 w-[250px]" />
        <Skeleton className="h-4 w-[200px]" />
      </div>
    </div>
  )
}
```

---

## 📐 14. Layout — Separator e ResizablePanel

```typescript
import { Separator } from "@/components/ui/separator"
import { ResizablePanelGroup, ResizablePanel, ResizableHandle } from "@/components/ui/resizable"

export function LayoutDemo() {
  return (
    <ResizablePanelGroup direction="horizontal">
      <ResizablePanel defaultSize={50}>
        <div className="p-4">Painel Esquerdo</div>
      </ResizablePanel>
      <ResizableHandle />
      <ResizablePanel defaultSize={50}>
        <div className="p-4">Painel Direito</div>
      </ResizablePanel>
    </ResizablePanelGroup>
  )
}
```

---

## 🎬 15. Sheet (Drawer lateral)

```typescript
import { Sheet, SheetContent, SheetDescription, SheetHeader, SheetTitle, SheetTrigger } from "@/components/ui/sheet"
import { Button } from "@/components/ui/button"

export function SheetDemo() {
  return (
    <Sheet>
      <SheetTrigger asChild>
        <Button variant="outline">Abrir Menu</Button>
      </SheetTrigger>
      <SheetContent>
        <SheetHeader>
          <SheetTitle>Configurações</SheetTitle>
          <SheetDescription>Alterne as opções do perfil.</SheetDescription>
        </SheetHeader>
        <div className="py-4">Conteúdo</div>
      </SheetContent>
    </Sheet>
  )
}
```

---

## 🪝 16. Hooks (useTheme)

```typescript
import { useTheme } from "next-themes"
import { Button } from "@/components/ui/button"

export function ThemeToggle() {
  const { theme, setTheme } = useTheme()

  return (
    <Button onClick={() => setTheme(theme === "dark" ? "light" : "dark")}>
      Tema: {theme === "dark" ? "🌙" : "☀️"}
    </Button>
  )
}
```

---

## ♿ 17. Acessibilidade

```typescript
import { VisuallyHidden } from "@/components/ui/visually-hidden"

// Componentes shadcn usam Radix UI nativamente
// Todas as primitivas têm roles ARIA e gerenciamento de foco

export function AccessibleDialog() {
  return (
    <Dialog>
      <DialogTrigger>Abrir</DialogTrigger>
      <DialogContent>
        <DialogHeader>
          <VisuallyHidden>Fechar diálogo</VisuallyHidden>
          <DialogTitle>Título acessível</DialogTitle>
        </DialogHeader>
        <p>Conteúdo com foco gerenciado automaticamente.</p>
      </DialogContent>
    </Dialog>
  )
}
```

---

## 🎭 18. Motion Integration (Framer Motion)

```typescript
import { motion } from "framer-motion"
import { Card } from "@/components/ui/card"

export function AnimatedCard() {
  return (
    <motion.div
      initial={{ opacity: 0, y: 20 }}
      animate={{ opacity: 1, y: 0 }}
      transition={{ duration: 0.3 }}
    >
      <Card className="p-6">
        <h3>Card Animado</h3>
        <p>Entrada com transição suave.</p>
      </Card>
    </motion.div>
  )
}
```

---

## 🔧 19. Customização via tailwind.config.ts

```typescript
import type { Config } from "tailwindcss"

const config: Config = {
  darkMode: ["class"],
  content: ["./src/**/*.{ts,tsx}"],
  theme: {
    extend: {
      colors: {
        border: "hsl(var(--border))",
        input: "hsl(var(--input))",
        ring: "hsl(var(--ring))",
        background: "hsl(var(--background))",
        foreground: "hsl(var(--foreground))",
        primary: { DEFAULT: "hsl(var(--primary))", foreground: "hsl(var(--primary-foreground))" },
        secondary: { DEFAULT: "hsl(var(--secondary))", foreground: "hsl(var(--secondary-foreground))" },
        destructive: { DEFAULT: "hsl(var(--destructive))", foreground: "hsl(var(--destructive-foreground))" },
      },
      borderRadius: {
        lg: "var(--radius)",
        md: "calc(var(--radius) - 2px)",
        sm: "calc(var(--radius) - 4px)",
      },
      keyframes: {
        "accordion-down": { from: { height: "0" }, to: { height: "var(--radix-accordion-content-height)" } },
      },
      animation: {
        "accordion-down": "accordion-down 0.2s ease-out",
      },
    },
  },
  plugins: [require("tailwindcss-animate")],
}
```

---

## 📦 20. Monorepo e Versionamento

```bash
# Atualizar componentes
npx shadcn-ui@latest add button --overwrite

# Listar componentes instalados
cat components.json

# Monorepo com Turborepo
pnpm add -D shadcn-ui --filter=@myapp/ui
```

---

## ❌ ERRADO vs ✅ CORRETO

### 🚫 Importar componentes diretamente do node_modules
```typescript
// ❌ ERRADO
import { Button } from "shadcn-ui" // Não existe!

// ✅ CORRETO — Componente copiado localmente
import { Button } from "@/components/ui/button"
```

### 🚫 Não usar cn() para merge de classes
```typescript
// ❌ ERRADO
<div className={`p-4 ${isActive ? "bg-primary" : ""}`}>

// ✅ CORRETO
import { cn } from "@/lib/utils"
<div className={cn("p-4", isActive && "bg-primary")}>
```

### 🚫 Esquecer dark mode nas CSS variables
```typescript
// ❌ ERRADO — Só define :root, esquece .dark
:root { --background: 0 0% 100%; }

// ✅ CORRETO — Define ambos
:root { --background: 0 0% 100%; }
.dark { --background: 222.2 84% 4.9%; }
```

### 🚫 Usar Dialog sem DialogTrigger
```typescript
// ❌ ERRADO — Dialog não abre
<Dialog>
  <Button>Clique</Button>
</Dialog>

// ✅ CORRETO — Usa DialogTrigger
<Dialog>
  <DialogTrigger asChild>
    <Button>Clique</Button>
  </DialogTrigger>
  <DialogContent>...</DialogContent>
</Dialog>
```

### 🚫 Ignorar variant e size do Button
```typescript
// ❌ ERRADO — Classes manuais duplicadas
<button className="bg-primary text-white px-4 py-2">Enviar</button>

// ✅ CORRETO — Usa variant e size
<Button variant="default" size="default">Enviar</Button>
```

### 🚫 Formulário sem validação Zod
```typescript
// ❌ ERRADO — Sem schema de validação
const form = useForm({ defaultValues: { name: "" } })

// ✅ CORRETO — Com Zod resolver
const form = useForm({
  resolver: zodResolver(formSchema),
  defaultValues: { name: "" },
})
```

### 🚫 Toast sem action
```typescript
// ❌ ERRADO — Toast sem opção de desfazer
toast({ title: "Item removido" })

// ✅ CORRETO — Toast com ação
toast({
  title: "Item removido",
  action: <ToastAction altText="Desfazer">Desfazer</ToastAction>,
})
```

### 🚫 Não usar Skeleton em loading states
```typescript
// ❌ ERRADO — Espera sem feedback visual
{isLoading && <p>Carregando...</p>}

// ✅ CORRETO — Skeleton para melhor UX
{isLoading ? (
  <div className="space-y-2">
    <Skeleton className="h-4 w-[250px]" />
    <Skeleton className="h-4 w-[200px]" />
  </div>
) : (
  <p>Dados carregados</p>
)}
```

---

## 📋 Resumo dos Comandos Essenciais

| Comando | Descrição |
|---------|-----------|
| `npx shadcn-ui@latest init` | Inicializar projeto |
| `npx shadcn-ui@latest add button` | Adicionar componente |
| `npx shadcn-ui@latest add --all` | Adicionar todos |
| `npx shadcn-ui@latest diff` | Verificar atualizações |

---

*Documento gerado para uso como skill de referência avançada.*
