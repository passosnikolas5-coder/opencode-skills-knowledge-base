# ⚛️ ADVANCED REACT EXPANDED

**Fonte:** https://github.com/facebook/react (240k+ stars)
**Descrição:** React é a biblioteca UI mais popular do mundo. Este documento abrange desde hooks avançados até Server Components, concorrência e otimização de performance.

---

## 1. Hooks Avançados

### useState e useEffect

```jsx
function UserProfile({ userId }) {
  const [user, setUser] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    let cancelled = false;
    
    async function fetchUser() {
      try {
        setLoading(true);
        const response = await fetch(`/api/users/${userId}`);
        const data = await response.json();
        if (!cancelled) {
          setUser(data);
          setError(null);
        }
      } catch (err) {
        if (!cancelled) setError(err.message);
      } finally {
        if (!cancelled) setLoading(false);
      }
    }
    
    fetchUser();
    return () => { cancelled = true; };
  }, [userId]);

  if (loading) return <Spinner />;
  if (error) return <ErrorMessage message={error} />;
  return <UserCard user={user} />;
}
```

### useMemo e useCallback

```jsx
function ProductList({ products, filter, sortBy }) {
  // useMemo: evita recálculo desnecessário
  const filteredProducts = useMemo(() => {
    return products
      .filter(p => p.category === filter)
      .sort((a, b) => a[sortBy] - b[sortBy]);
  }, [products, filter, sortBy]);

  // useCallback: mantene referência estável da função
  const handleSelect = useCallback((productId) => {
    console.log('Selected:', productId);
  }, []);

  return (
    <ul>
      {filteredProducts.map(product => (
        <ProductItem 
          key={product.id} 
          product={product} 
          onSelect={handleSelect}
        />
      ))}
    </ul>
  );
}
```

### useReducer

```jsx
const initialState = { count: 0, history: [] };

function reducer(state, action) {
  switch (action.type) {
    case 'increment':
      return {
        count: state.count + 1,
        history: [...state.history, state.count + 1]
      };
    case 'decrement':
      return {
        count: Math.max(0, state.count - 1),
        history: [...state.history, Math.max(0, state.count - 1)]
      };
    case 'reset':
      return initialState;
    default:
      throw new Error(`Unknown action: ${action.type}`);
  }
}

function Counter() {
  const [state, dispatch] = useReducer(reducer, initialState);

  return (
    <div>
      <p>Count: {state.count}</p>
      <button onClick={() => dispatch({ type: 'increment' })}>+</button>
      <button onClick={() => dispatch({ type: 'decrement' })}>-</button>
      <button onClick={() => dispatch({ type: 'reset' })}>Reset</button>
      <p>History: {state.history.join(', ')}</p>
    </div>
  );
}
```

### useRef

```jsx
function TextInputWithFocus() {
  const inputRef = useRef(null);
  const renderCount = useRef(0);

  useEffect(() => {
    renderCount.current += 1;
  });

  const focusInput = () => {
    inputRef.current?.focus();
  };

  return (
    <div>
      <input ref={inputRef} type="text" placeholder="Type here..." />
      <button onClick={focusInput}>Focus Input</button>
      <p>Rendered {renderCount.current} times</p>
    </div>
  );
}
```

### **MELHORIA - useEffect**

```jsx
// ❌ ERRADO: Dependência faltando
useEffect(() => {
  fetchData(userId);
}, []);

// ✅ CORRETO: Dependência incluída + cleanup
useEffect(() => {
  const controller = new AbortController();
  fetchData(userId, { signal: controller.signal });
  return () => controller.abort();
}, [userId]);
```

---

## 2. Custom Hooks

### useLocalStorage

```jsx
function useLocalStorage(key, initialValue) {
  const [storedValue, setStoredValue] = useState(() => {
    try {
      const item = window.localStorage.getItem(key);
      return item ? JSON.parse(item) : initialValue;
    } catch (error) {
      console.error(error);
      return initialValue;
    }
  });

  const setValue = (value) => {
    try {
      const valueToStore = value instanceof Function ? value(storedValue) : value;
      setStoredValue(valueToStore);
      window.localStorage.setItem(key, JSON.stringify(valueToStore));
    } catch (error) {
      console.error(error);
    }
  };

  return [storedValue, setValue];
}

// Uso:
function App() {
  const [theme, setTheme] = useLocalStorage('theme', 'light');
  return <button onClick={() => setTheme(theme === 'light' ? 'dark' : 'light')}>{theme}</button>;
}
```

### useDebounce

```jsx
function useDebounce(value, delay) {
  const [debouncedValue, setDebouncedValue] = useState(value);

  useEffect(() => {
    const handler = setTimeout(() => setDebouncedValue(value), delay);
    return () => clearTimeout(handler);
  }, [value, delay]);

  return debouncedValue;
}

// Uso:
function SearchInput() {
  const [search, setSearch] = useState('');
  const debouncedSearch = useDebounce(search, 500);

  useEffect(() => {
    if (debouncedSearch) fetchResults(debouncedSearch);
  }, [debouncedSearch]);

  return <input value={search} onChange={e => setSearch(e.target.value)} />;
}
```

### useMediaQuery

```jsx
function useMediaQuery(query) {
  const [matches, setMatches] = useState(false);

  useEffect(() => {
    const media = window.matchMedia(query);
    if (media.matches !== matches) setMatches(media.matches);

    const listener = (e) => setMatches(e.matches);
    media.addEventListener('change', listener);
    return () => media.removeEventListener('change', listener);
  }, [query, matches]);

  return matches;
}

// Uso:
function Layout() {
  const isMobile = useMediaQuery('(max-width: 768px)');
  return isMobile ? <MobileLayout /> : <DesktopLayout />;
}
```

### **MELHORIA - Custom Hooks**

```jsx
// ❌ ERRADO: Lógica duplicada em cada componente
function ComponentA() {
  const [data, setData] = useState(null);
  useEffect(() => { fetchData().then(setData); }, []);
  if (!data) return <Spinner />;
  return <div>{data.name}</div>;
}

function ComponentB() {
  const [data, setData] = useState(null);
  useEffect(() => { fetchData().then(setData); }, []);
  if (!data) return <Spinner />;
  return <span>{data.name}</span>;
}

// ✅ CORRETO: Custom hook extraído
function useFetchData() {
  const [data, setData] = useState(null);
  const [loading, setLoading] = useState(true);
  
  useEffect(() => {
    fetchData().then(setData).finally(() => setLoading(false));
  }, []);
  
  return { data, loading };
}

function ComponentA() {
  const { data, loading } = useFetchData();
  if (loading) return <Spinner />;
  return <div>{data?.name}</div>;
}
```

---

## 3. Context API

### ThemeContext com Provider

```jsx
const ThemeContext = createContext(null);

function ThemeProvider({ children }) {
  const [theme, setTheme] = useState('light');

  const toggleTheme = useCallback(() => {
    setTheme(prev => prev === 'light' ? 'dark' : 'light');
  }, []);

  const value = useMemo(() => ({ theme, toggleTheme }), [theme, toggleTheme]);

  return (
    <ThemeContext.Provider value={value}>
      {children}
    </ThemeContext.Provider>
  );
}

function useTheme() {
  const context = useContext(ThemeContext);
  if (!context) throw new Error('useTheme must be used within ThemeProvider');
  return context;
}

// Uso:
function App() {
  return (
    <ThemeProvider>
      <Header />
      <Main />
    </ThemeProvider>
  );
}

function Header() {
  const { theme, toggleTheme } = useTheme();
  return <button onClick={toggleTheme}>Current: {theme}</button>;
}
```

### **MELHORIA - Context Performance**

```jsx
// ❌ ERRADO: Provider com objeto novo a cada render
function App() {
  return (
    <UserContext.Provider value={{ user, setUser }}>
      <App />
    </UserContext.Provider>
  );
}

// ✅ CORRETO: Memoização do value
function App() {
  const [user, setUser] = useState(null);
  const value = useMemo(() => ({ user, setUser }), [user]);
  
  return (
    <UserContext.Provider value={value}>
      <App />
    </UserContext.Provider>
  );
}
```

---

## 4. React.memo e Memoização

```jsx
const ExpensiveComponent = React.memo(function ExpensiveComponent({ data, onClick }) {
  console.log('ExpensiveComponent rendered');
  return (
    <div onClick={onClick}>
      {data.map(item => (
        <ComplexItem key={item.id} item={item} />
      ))}
    </div>
  );
});

// Comparador customizado
const MemoizedComponent = React.memo(
  function Component({ user }) {
    return <div>{user.name}</div>;
  },
  (prevProps, nextProps) => {
    return prevProps.user.id === nextProps.user.id;
  }
);
```

### **MELHORIA - React.memo**

```jsx
// ❌ ERRADO: Props instáveis derroam memo
function Parent() {
  return <MemoizedChild onClick={() => console.log('clicked')} />;
}

// ✅ CORRETO: useCallback para estável
function Parent() {
  const handleClick = useCallback(() => console.log('clicked'), []);
  return <MemoizedChild onClick={handleClick} />;
}
```

---

## 5. Server Components (RSC)

```jsx
// app/page.tsx (Server Component por padrão)
async function ServerComponent() {
  const data = await fetch('https://api.example.com/data', {
    cache: 'no-store' // ou 'force-cache'
  });
  const posts = await data.json();

  return (
    <div>
      <h1>Server Rendered Posts</h1>
      {posts.map(post => (
        <PostCard key={post.id} post={post} />
      ))}
      <ClientCounter /> {/* Componente cliente misturado */}
    </div>
  );
}

// components/ClientCounter.tsx
'use client';
import { useState } from 'react';

export function ClientCounter() {
  const [count, setCount] = useState(0);
  return <button onClick={() => setCount(c => c + 1)}>Count: {count}</button>;
}
```

---

## 6. Concurrent Features

### Suspense

```jsx
function App() {
  return (
    <Suspense fallback={<LoadingSpinner />}>
      <UserProfile />
      <Suspense fallback={<PostsSkeleton />}>
        <UserPosts />
      </Suspense>
    </Suspense>
  );
}
```

### useTransition

```jsx
function SearchApp() {
  const [query, setQuery] = useState('');
  const [isPending, startTransition] = useTransition();

  const handleChange = (e) => {
    setQuery(e.target.value);
    startTransition(() => {
      // Atualização de baixa prioridade
      setFilteredResults(filterByQuery(e.target.value));
    });
  };

  return (
    <div>
      <input value={query} onChange={handleChange} />
      {isPending && <Spinner />}
      <ResultsList results={filteredResults} />
    </div>
  );
}
```

### useDeferredValue

```jsx
function DeferredSearch({ query }) {
  const deferredQuery = useDeferredValue(query);
  const isStale = query !== deferredQuery;

  return (
    <div style={{ opacity: isStale ? 0.7 : 1 }}>
      <SearchResults query={deferredQuery} />
    </div>
  );
}
```

---

## 7. Error Boundaries

```jsx
class ErrorBoundary extends React.Component {
  constructor(props) {
    super(props);
    this.state = { hasError: false, error: null };
  }

  static getDerivedStateFromError(error) {
    return { hasError: true, error };
  }

  componentDidCatch(error, errorInfo) {
    console.error('Error caught:', error, errorInfo);
    // Enviar para serviço de monitoramento
  }

  render() {
    if (this.state.hasError) {
      return (
        <div className="error-fallback">
          <h2>Algo deu errado</h2>
          <p>{this.state.error?.message}</p>
          <button onClick={() => this.setState({ hasError: false })}>
            Tentar novamente
          </button>
        </div>
      );
    }
    return this.props.children;
  }
}

// Uso:
function App() {
  return (
    <ErrorBoundary>
      <Header />
      <ErrorBoundary>
        <MainContent />
      </ErrorBoundary>
      <Footer />
    </ErrorBoundary>
  );
}
```

---

## 8. Refs e forwardRef

```jsx
const FancyInput = React.forwardRef(function FancyInput({ label, ...props }, ref) {
  return (
    <div className="fancy-input">
      <label>{label}</label>
      <input ref={ref} {...props} />
    </div>
  );
});

function Parent() {
  const inputRef = useRef(null);

  const focusInput = () => inputRef.current?.focus();

  return (
    <div>
      <FancyInput ref={inputRef} label="Name" />
      <button onClick={focusInput}>Focus</button>
    </div>
  );
}
```

---

## 9. Portals

```jsx
function Modal({ isOpen, onClose, children }) {
  if (!isOpen) return null;

  return ReactDOM.createPortal(
    <div className="modal-overlay" onClick={onClose}>
      <div className="modal-content" onClick={e => e.stopPropagation()}>
        <button className="modal-close" onClick={onClose}>×</button>
        {children}
      </div>
    </div>,
    document.body
  );
}
```

---

## 10. Fragments

```jsx
// ✅ Fragment sem key (em listas)
function Column() {
  return (
    <>
      <td>Column 1</td>
      <td>Column 2</td>
    </>
  );
}

// ✅ Fragment com key (em listas)
function Table({ rows }) {
  return (
    <table>
      <tbody>
        {rows.map(row => (
          <React.Fragment key={row.id}>
            <tr>
              <td>{row.name}</td>
              <td>{row.value}</td>
            </tr>
          </React.Fragment>
        ))}
      </tbody>
    </table>
  );
}
```

---

## 11. Keys e Reconciliação

```jsx
// ❌ ERRADO: Usando índice como key
function List({ items }) {
  return (
    <ul>
      {items.map((item, index) => (
        <li key={index}>{item.name}</li>
      ))}
    </ul>
  );
}

// ✅ CORRETO: Usando ID único
function List({ items }) {
  return (
    <ul>
      {items.map(item => (
        <li key={item.id}>{item.name}</li>
      ))}
    </ul>
  );
}
```

---

## 12. Virtual DOM e Otimização

```jsx
// Profiler para medir performance
function App() {
  return (
    <Profiler id="App" onRender={onRenderCallback}>
      <MainLayout />
    </Profiler>
  );
}

function onRenderCallback(
  id,
  phase,
  actualDuration,
  baseDuration,
  startTime,
  commitTime
) {
  console.log(`${id} ${phase}: ${actualDuration}ms`);
}
```

---

## 13. State Management com Zustand

```jsx
import { create } from 'zustand';

const useStore = create((set, get) => ({
  count: 0,
  users: [],
  loading: false,

  increment: () => set(state => ({ count: state.count + 1 })),
  decrement: () => set(state => ({ count: state.count - 1 })),
  
  fetchUsers: async () => {
    set({ loading: true });
    const users = await fetch('/api/users').then(r => r.json());
    set({ users, loading: false });
  },

  getUserById: (id) => get().users.find(u => u.id === id),
}));

// Uso em componente:
function Counter() {
  const count = useStore(state => state.count);
  const increment = useStore(state => state.increment);
  
  return <button onClick={increment}>Count: {count}</button>;
}
```

---

## 14. React Hook Form

```jsx
import { useForm } from 'react-hook-form';

function SignupForm() {
  const { register, handleSubmit, formState: { errors, isSubmitting } } = useForm();

  const onSubmit = async (data) => {
    await fetch('/api/signup', {
      method: 'POST',
      body: JSON.stringify(data)
    });
  };

  return (
    <form onSubmit={handleSubmit(onSubmit)}>
      <input
        {...register('email', { required: 'Email obrigatório', pattern: /^\S+@\S+$/i })}
      />
      {errors.email && <span>{errors.email.message}</span>}

      <input
        type="password"
        {...register('password', { required: true, minLength: 8 })}
      />
      {errors.password && <span>Senha deve ter 8+ caracteres</span>}

      <button type="submit" disabled={isSubmitting}>
        {isSubmitting ? 'Enviando...' : 'Cadastrar'}
      </button>
    </form>
  );
}
```

---

## 15. Animações com Framer Motion

```jsx
import { motion, AnimatePresence } from 'framer-motion';

function AnimatedList({ items }) {
  return (
    <AnimatePresence>
      {items.map(item => (
        <motion.div
          key={item.id}
          initial={{ opacity: 0, height: 0 }}
          animate={{ opacity: 1, height: 'auto' }}
          exit={{ opacity: 0, height: 0 }}
          transition={{ duration: 0.3 }}
        >
          {item.name}
        </motion.div>
      ))}
    </AnimatePresence>
  );
}

function DraggableBox() {
  return (
    <motion.div
      drag
      dragConstraints={{ left: 0, right: 300 }}
      whileHover={{ scale: 1.1 }}
      whileTap={{ scale: 0.95 }}
      className="draggable-box"
    >
      Drag me!
    </motion.div>
  );
}
```

---

## 16. Performance Profiling

```jsx
// React DevTools Profiler API
import { Profiler } from 'react';

function App() {
  const onRender = useCallback((id, phase, duration) => {
    if (phase === 'commit') {
      performance.mark(`${id}-commit`);
    }
  }, []);

  return (
    <Profiler id="Sidebar" onRender={onRender}>
      <Sidebar />
    </Profiler>
  );
}
```

---

## 17. Padroões Avançados

### Compound Components

```jsx
function Tabs({ children, defaultTab }) {
  const [activeTab, setActiveTab] = useState(defaultTab);
  
  return (
    <TabsContext.Provider value={{ activeTab, setActiveTab }}>
      <div className="tabs">{children}</div>
    </TabsContext.Provider>
  );
}

Tabs.TabList = function TabList({ children }) {
  return <div className="tab-list" role="tablist">{children}</div>;
};

Tabs.Tab = function Tab({ value, children }) {
  const { activeTab, setActiveTab } = useContext(TabsContext);
  return (
    <button
      role="tab"
      aria-selected={activeTab === value}
      className={activeTab === value ? 'active' : ''}
      onClick={() => setActiveTab(value)}
    >
      {children}
    </button>
  );
};

// Uso:
<Tabs defaultTab="tab1">
  <Tabs.TabList>
    <Tabs.Tab value="tab1">Tab 1</Tabs.Tab>
    <Tabs.Tab value="tab2">Tab 2</Tabs.Tab>
  </Tabs.TabList>
  <Tabs.Panel value="tab1">Content 1</Tabs.Panel>
  <Tabs.Panel value="tab2">Content 2</Tabs.Panel>
</Tabs>
```

### Render Props

```jsx
function MouseTracker({ render }) {
  const [position, setPosition] = useState({ x: 0, y: 0 });

  useEffect(() => {
    const handler = (e) => setPosition({ x: e.clientX, y: e.clientY });
    window.addEventListener('mousemove', handler);
    return () => window.removeEventListener('mousemove', handler);
  }, []);

  return render(position);
}

// Uso:
<MouseTracker render={({ x, y }) => (
  <div>Mouse at: {x}, {y}</div>
)} />
```

---

## 18. Testing com React Testing Library

```jsx
import { render, screen, fireEvent, waitFor } from '@testing-library/react';
import userEvent from '@testing-library/user-event';

test('submits form with user input', async () => {
  const onSubmit = jest.fn();
  render(<LoginForm onSubmit={onSubmit} />);

  await userEvent.type(screen.getByLabelText(/email/i), 'user@example.com');
  await userEvent.type(screen.getByLabelText(/password/i), 'password123');
  await userEvent.click(screen.getByRole('button', { name: /sign in/i }));

  await waitFor(() => {
    expect(onSubmit).toHaveBeenCalledWith({
      email: 'user@example.com',
      password: 'password123'
    });
  });
});
```

---

## Referências

- [React Docs](https://react.dev)
- [React GitHub](https://github.com/facebook/react)
- [React Testing Library](https://testing-library.com/docs/react-testing-library/intro/)
- [Zustand](https://github.com/pmndrs/zustand)
- [Framer Motion](https://www.framer.com/motion/)
- [React Hook Form](https://react-hook-form.com/)
