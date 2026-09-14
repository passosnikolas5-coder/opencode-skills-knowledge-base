# Template de Skill

Use este template para documentar novas skills no **OpenCode Skills Knowledge Base**.

---

## [NÚMERO]. [NOME-DA-SKILL]

**Descrição:** [Breve descrição do que a skill faz]

**Quando usar:**
- [Caso de uso 1]
- [Caso de uso 2]
- [Caso de uso 3]

**Exemplos práticos:**

```[linguagem]
// Exemplo 1: [Descrição do exemplo]
[código do exemplo 1]

// Exemplo 2: [Descrição do exemplo]
[código do exemplo 2]
```

**Casos de uso avançados:**
- [Projeto Real 1]: [Descrição de como a skill é usada]
- [Projeto Real 2]: [Descrição de como a skill é usada]

**Integração com outras skills:**
- [skill-complementar1]: [Para quando precisar de...]
- [skill-complementar2]: [Para integrar com...]
- [skill-complementar3]: [Para complementar...]

**Padrões e anti-padrões:**

✅ **Fazer:**
- [Prática recomendada 1]
- [Prática recomendada 2]
- [Prática recomendada 3]

❌ **Evitar:**
- [Anti-pattern 1]
- [Anti-pattern 2]
- [Anti-pattern 3]

**Dicas de performance:**
- [Dica 1: Otimização específica]
- [Dica 2: Melhoria de performance]
- [Dica 3: Boa prática de otimização]

**Comandos úteis:**

```bash
# Comando 1: [Descrição]
comando1

# Comando 2: [Descrição]
comando2
```

**Referências:**
- [Link 1](url) - [Descrição]
- [Link 2](url) - [Descrição]
- [Link 3](url) - [Descrição]

---

## Diretrizes para Preenchimento

### 1. Descrição
- Seja claro e conciso
- Explique o que a skill faz
- Mencione o objetivo principal

### 2. Quando Usar
- Liste casos de uso específicos
- Inclua triggers de ativação
- Mencione pré-requisitos

### 3. Exemplos Práticos
- Use código funcional
- Inclua comentários explicativos
- Mostre diferentes cenários

### 4. Casos de Uso Avançados
- Descreva projetos reais
- Explique a aplicação prática
- Mencione resultados esperados

### 5. Integração com Outras Skills
- Liste skills complementares
- Explique quando usar cada uma
- Mencione sinergias

### 6. Padrões e Anti-padrões
- Lista clara do que fazer
- Lista clara do que evitar
- Inclua exemplos quando possível

### 7. Dicas de Performance
- Otimizações específicas
- Boas práticas
- Armadilhas comuns

### 8. Comandos Úteis
- Snippets prontos para usar
- Comentários explicativos
- Diferentes contextos

### 9. Referências
- Links para documentação oficial
- Artigos relevantes
- Recursos adicionais

---

## Exemplo Preenchido

## 1. react-patterns

**Descrição:** Padrões modernos para React incluindo hooks, context e composição.

**Quando usar:**
- Componentes com lógica complexa
- Estado compartilhado entre componentes
- Otimização de performance
- Reutilização de lógica

**Exemplos práticos:**

```jsx
// Exemplo 1: Hook personalizado
function useLocalStorage(key, initialValue) {
  const [storedValue, setStoredValue] = useState(() => {
    try {
      const item = window.localStorage.getItem(key);
      return item ? JSON.parse(item) : initialValue;
    } catch (error) {
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

// Exemplo 2: Context para tema
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
```

**Casos de uso avançados:**
- Dashboard com múltiplos widgets
- Sistema de autenticação
- Aplicativo offline-first

**Integração com outras skills:**
- zustand-store-ts: Para gerenciamento de estado global
- nextjs-best-practices: Para aplicações Next.js
- frontend-design: Para design visual

**Padrões e anti-padrões:**

✅ **Fazer:**
- Usar hooks personalizados para lógica reutilizável
- Implementar React.memo para componentes puros
- Usar useCallback e useMemo para otimização

❌ **Evitar:**
- Props drilling excessivo
- Mutations diretas de estado
- Hooks condicionais

**Dicas de performance:**
- Use lazy loading para rotas
- Implemente code splitting
- Otimize re-renderizações

**Comandos úteis:**

```bash
# Criar novo componente
npx create-react-app meu-app --template typescript

# Instalar dependências
npm install zustand
```

**Referências:**
- [React Docs](https://react.dev/) - Documentação oficial
- [React Patterns](https://reactpatterns.com/) - Padrões comuns
- [Hooks Reference](https://react.dev/reference/react) - Referência de hooks

---

*Template atualizado em: Setembro 2026*
*Versão: 2.0*