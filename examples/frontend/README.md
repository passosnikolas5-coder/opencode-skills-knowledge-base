# 🎨 Exemplos de Frontend

Este diretório contém exemplos práticos de skills de Frontend do **OpenCode Skills Knowledge Base**.

## 📋 Índice

- [React](#react)
- [Next.js](#nextjs)
- [Vue](#vue)
- [Tailwind CSS](#tailwind-css)
- [TypeScript](#typescript)

---

## React

### Componente com Hooks

```jsx
// UserProfile.jsx
import { useState, useEffect } from 'react';

function UserProfile({ userId }) {
  const [user, setUser] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    const fetchUser = async () => {
      try {
        const response = await fetch(`/api/users/${userId}`);
        if (!response.ok) {
          throw new Error('Erro ao buscar usuário');
        }
        const data = await response.json();
        setUser(data);
      } catch (err) {
        setError(err.message);
      } finally {
        setLoading(false);
      }
    };

    fetchUser();
  }, [userId]);

  if (loading) return <div>Carregando...</div>;
  if (error) return <div>Erro: {error}</div>;
  if (!user) return <div>Usuário não encontrado</div>;

  return (
    <div className="profile">
      <h2>{user.name}</h2>
      <p>{user.email}</p>
      <p>{user.bio}</p>
    </div>
  );
}

export default UserProfile;
```

### Context API

```jsx
// ThemeContext.jsx
import { createContext, useContext, useState } from 'react';

const ThemeContext = createContext();

export function ThemeProvider({ children }) {
  const [theme, setTheme] = useState('light');

  const toggleTheme = () => {
    setTheme(prev => prev === 'light' ? 'dark' : 'light');
  };

  return (
    <ThemeContext.Provider value={{ theme, toggleTheme }}>
      {children}
    </ThemeContext.Provider>
  );
}

export function useTheme() {
  const context = useContext(ThemeContext);
  if (!context) {
    throw new Error('useTheme must be used within a ThemeProvider');
  }
  return context;
}
```

### Custom Hooks

```jsx
// useLocalStorage.js
import { useState, useEffect } from 'react';

export function useLocalStorage(key, initialValue) {
  const [storedValue, setStoredValue] = useState(() => {
    try {
      const item = window.localStorage.getItem(key);
      return item ? JSON.parse(item) : initialValue;
    } catch (error) {
      console.error(error);
      return initialValue;
    }
  });

  const setValue = value => {
    try {
      setStoredValue(value);
      window.localStorage.setItem(key, JSON.stringify(value));
    } catch (error) {
      console.error(error);
    }
  };

  return [storedValue, setValue];
}

// Uso
function App() {
  const [name, setName] = useLocalStorage('name', 'João');
  
  return (
    <div>
      <input
        type="text"
        value={name}
        onChange={(e) => setName(e.target.value)}
      />
      <p>Olá, {name}!</p>
    </div>
  );
}
```

---

## Next.js

### App Router

```tsx
// app/page.tsx
import Link from 'next/link';

export default function Home() {
  return (
    <main>
      <h1>Bem-vindo ao Next.js</h1>
      <nav>
        <Link href="/about">Sobre</Link>
        <Link href="/blog">Blog</Link>
        <Link href="/contact">Contato</Link>
      </nav>
    </main>
  );
}
```

### Server Components

```tsx
// app/blog/page.tsx
async function getPosts() {
  const res = await fetch('https://api.example.com/posts', {
    cache: 'no-store',
  });
  return res.json();
}

export default async function BlogPage() {
  const posts = await getPosts();

  return (
    <main>
      <h1>Blog</h1>
      <ul>
        {posts.map((post: any) => (
          <li key={post.id}>
            <Link href={`/blog/${post.id}`}>
              <h2>{post.title}</h2>
              <p>{post.excerpt}</p>
            </Link>
          </li>
        ))}
      </ul>
    </main>
  );
}
```

### API Routes

```typescript
// app/api/users/route.ts
import { NextResponse } from 'next/server';

export async function GET() {
  const users = await getUsers();
  return NextResponse.json(users);
}

export async function POST(request: Request) {
  const body = await request.json();
  const user = await createUser(body);
  return NextResponse.json(user, { status: 201 });
}

export async function PUT(request: Request) {
  const body = await request.json();
  const user = await updateUser(body.id, body);
  return NextResponse.json(user);
}

export async function DELETE(request: Request) {
  const { searchParams } = new URL(request.url);
  const id = searchParams.get('id');
  await deleteUser(id);
  return NextResponse.json({ message: 'Usuário removido' });
}
```

---

## Vue

### Componente Composition API

```vue
<script setup>
import { ref, onMounted } from 'vue';

const users = ref([]);
const loading = ref(true);
const error = ref(null);

onMounted(async () => {
  try {
    const response = await fetch('/api/users');
    users.value = await response.json();
  } catch (err) {
    error.value = err.message;
  } finally {
    loading.value = false;
  }
});
</script>

<template>
  <div>
    <h1>Usuários</h1>
    <div v-if="loading">Carregando...</div>
    <div v-else-if="error">Erro: {{ error }}</div>
    <ul v-else>
      <li v-for="user in users" :key="user.id">
        {{ user.name }} - {{ user.email }}
      </li>
    </ul>
  </div>
</template>
```

### Pinia Store

```typescript
// stores/users.ts
import { defineStore } from 'pinia';

interface User {
  id: number;
  name: string;
  email: string;
}

export const useUsersStore = defineStore('users', {
  state: () => ({
    users: [] as User[],
    loading: false,
    error: null as string | null,
  }),
  
  getters: {
    getUserById: (state) => (id: number) => {
      return state.users.find(user => user.id === id);
    },
  },
  
  actions: {
    async fetchUsers() {
      this.loading = true;
      this.error = null;
      
      try {
        const response = await fetch('/api/users');
        this.users = await response.json();
      } catch (err) {
        this.error = err.message;
      } finally {
        this.loading = false;
      }
    },
    
    async addUser(user: Omit<User, 'id'>) {
      const response = await fetch('/api/users', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(user),
      });
      
      const newUser = await response.json();
      this.users.push(newUser);
    },
    
    async deleteUser(id: number) {
      await fetch(`/api/users/${id}`, { method: 'DELETE' });
      this.users = this.users.filter(user => user.id !== id);
    },
  },
});
```

---

## Tailwind CSS

### Design System

```html
<!-- components/Button.tsx -->
<button class="px-4 py-2 bg-blue-500 text-white rounded hover:bg-blue-600 transition-colors">
  Clique Aqui
</button>

<button class="px-4 py-2 bg-green-500 text-white rounded hover:bg-green-600 transition-colors">
  Salvar
</button>

<button class="px-4 py-2 bg-red-500 text-white rounded hover:bg-red-600 transition-colors">
  Excluir
</button>
```

### Layout Responsivo

```html
<!-- components/Layout.tsx -->
<div class="min-h-screen flex flex-col">
  <!-- Header -->
  <header class="bg-white shadow">
    <nav class="container mx-auto px-4 py-4">
      <div class="flex justify-between items-center">
        <div class="text-xl font-bold">Logo</div>
        <div class="hidden md:flex space-x-4">
          <a href="/" class="hover:text-blue-500">Home</a>
          <a href="/about" class="hover:text-blue-500">Sobre</a>
          <a href="/contact" class="hover:text-blue-500">Contato</a>
        </div>
      </div>
    </nav>
  </header>

  <!-- Main -->
  <main class="container mx-auto px-4 py-8 flex-grow">
    <slot />
  </main>

  <!-- Footer -->
  <footer class="bg-gray-800 text-white py-8">
    <div class="container mx-auto px-4 text-center">
      <p>&copy; 2026 Minha Empresa</p>
    </div>
  </footer>
</div>
```

### Componentes de Formulário

```html
<!-- components/Input.tsx -->
<div class="mb-4">
  <label class="block text-gray-700 text-sm font-bold mb-2" for="email">
    Email
  </label>
  <input
    class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
    id="email"
    type="email"
    placeholder="seu@email.com"
  />
  <p class="text-red-500 text-xs italic">Por favor, insira um email válido.</p>
</div>
```

---

## TypeScript

### Interfaces e Types

```typescript
// types/user.ts
export interface User {
  id: number;
  name: string;
  email: string;
  role: 'admin' | 'user' | 'guest';
  createdAt: Date;
  updatedAt: Date;
}

export interface CreateUserDTO {
  name: string;
  email: string;
  password: string;
  role?: 'admin' | 'user' | 'guest';
}

export interface UpdateUserDTO {
  name?: string;
  email?: string;
  role?: 'admin' | 'user' | 'guest';
}
```

### Funções Tipadas

```typescript
// services/userService.ts
import { User, CreateUserDTO, UpdateUserDTO } from '../types/user';

const API_URL = '/api/users';

export const userService = {
  async getAll(): Promise<User[]> {
    const response = await fetch(API_URL);
    if (!response.ok) {
      throw new Error('Erro ao buscar usuários');
    }
    return response.json();
  },

  async getById(id: number): Promise<User> {
    const response = await fetch(`${API_URL}/${id}`);
    if (!response.ok) {
      throw new Error('Usuário não encontrado');
    }
    return response.json();
  },

  async create(data: CreateUserDTO): Promise<User> {
    const response = await fetch(API_URL, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(data),
    });
    if (!response.ok) {
      throw new Error('Erro ao criar usuário');
    }
    return response.json();
  },

  async update(id: number, data: UpdateUserDTO): Promise<User> {
    const response = await fetch(`${API_URL}/${id}`, {
      method: 'PUT',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(data),
    });
    if (!response.ok) {
      throw new Error('Erro ao atualizar usuário');
    }
    return response.json();
  },

  async delete(id: number): Promise<void> {
    const response = await fetch(`${API_URL}/${id}`, {
      method: 'DELETE',
    });
    if (!response.ok) {
      throw new Error('Erro ao deletar usuário');
    }
  },
};
```

### Hooks Tipados

```typescript
// hooks/useUsers.ts
import { useState, useEffect } from 'react';
import { User, CreateUserDTO } from '../types/user';
import { userService } from '../services/userService';

export function useUsers() {
  const [users, setUsers] = useState<User[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  const fetchUsers = async () => {
    try {
      setLoading(true);
      const data = await userService.getAll();
      setUsers(data);
    } catch (err) {
      setError(err.message);
    } finally {
      setLoading(false);
    }
  };

  const createUser = async (data: CreateUserDTO) => {
    try {
      const newUser = await userService.create(data);
      setUsers(prev => [...prev, newUser]);
      return newUser;
    } catch (err) {
      throw err;
    }
  };

  const updateUser = async (id: number, data: Partial<User>) => {
    try {
      const updatedUser = await userService.update(id, data);
      setUsers(prev => prev.map(user => user.id === id ? updatedUser : user));
      return updatedUser;
    } catch (err) {
      throw err;
    }
  };

  const deleteUser = async (id: number) => {
    try {
      await userService.delete(id);
      setUsers(prev => prev.filter(user => user.id !== id));
    } catch (err) {
      throw err;
    }
  };

  useEffect(() => {
    fetchUsers();
  }, []);

  return {
    users,
    loading,
    error,
    createUser,
    updateUser,
    deleteUser,
    refetch: fetchUsers,
  };
}
```

---

## 📚 Referências

- [React Documentation](https://react.dev/)
- [Next.js Documentation](https://nextjs.org/docs)
- [Vue Documentation](https://vuejs.org/guide/introduction.html)
- [Tailwind CSS Documentation](https://tailwindcss.com/docs)
- [TypeScript Documentation](https://www.typescriptlang.org/docs/)

---

*Última atualização: Setembro 2026*