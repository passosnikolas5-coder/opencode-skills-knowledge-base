# ✅ Melhores Práticas

Este guia apresenta as melhores práticas para usar o **OpenCode Skills Knowledge Base** de forma eficiente e eficaz.

## 📋 Índice

- [Visão Geral](#visão-geral)
- [Organização](#organização)
- [Documentação](#documentação)
- [Código](#código)
- [Testes](#testes)
- [Segurança](#segurança)
- [Performance](#performance)
- [Colaboração](#colaboração)

---

## Visão Geral

Seguir melhores práticas ajuda a:

- ✅ **Aumentar produtividade**
- ✅ **Reduzir erros**
- ✅ **Melhorar manutenibilidade**
- ✅ **Facilitar colaboração**
- ✅ **Garantir qualidade**

---

## Organização

### 1. Estrutura de Pastas

```
projeto/
├── .opencode/
│   ├── config.yaml
│   ├── workflows/
│   └── skills/
├── src/
│   ├── components/
│   ├── services/
│   └── utils/
├── docs/
├── tests/
└── scripts/
```

### 2. Nomenclatura

```yaml
# ✅ BOM: Nomes claros e descritivos
skills:
  - react-patterns
  - api-security-best-practices
  - docker-expert

# ❌ RUIM: Nomes vagos ou genéricos
skills:
  - skill1
  - helper
  - util
```

### 3. Configuração Centralizada

```yaml
# ✅ BOM: Configuração centralizada
# .opencode/config.yaml
project:
  name: meu-projeto
  version: 1.0.0

skills:
  enabled:
    - react-patterns
    - fastapi-router-py
    - docker-expert

# ❌ RUIM: Configurações dispersas
# Em cada arquivo separado
```

---

## Documentação

### 1. Documente Tudo

```markdown
# ✅ BOM: Documentação completa

## minhas-skill

**Descrição:** O que a skill faz

**Quando usar:**
- Caso específico 1
- Caso específico 2

**Exemplos práticos:**
```código
// Exemplo funcional
```

# ❌ RUIM: Documentação incompleta

## minhas-skill

Faz alguma coisa.
```

### 2. Mantenha Atualizado

```yaml
# ✅ BOM: Documentação sempre atualizada
changelog:
  - version: 2.0.0
    date: 2026-09-14
    changes:
      - Adiciona novos exemplos
      - Atualiza referências

# ❌ RUIM: Documentação desatualizada
# Última atualização: 2024
```

### 3. Use Formato Consistente

```markdown
# ✅ BOM: Formato padronizado

## X. nome-da-skill

**Descrição:** ...

**Quando usar:**
- ...

**Exemplos práticos:**
```código```

# ❌ RUIM: Formato inconsistente

## skill1
Faz isso.

## skill2
**Descrição:** Faz aquilo.
**Quando usar:** ...
```

---

## Código

### 1. Siga Padrões

```javascript
// ✅ BOM: Código limpo e padronizado
function calculateTotal(items) {
  return items.reduce((total, item) => total + item.price, 0);
}

// ❌ RUIM: Código confuso
function calc(a) {
  let t = 0;
  for (let i = 0; i < a.length; i++) {
    t += a[i].p;
  }
  return t;
}
```

### 2. Use TypeScript

```typescript
// ✅ BOM: TypeScript com tipos
interface User {
  id: string;
  name: string;
  email: string;
}

function getUser(id: string): Promise<User> {
  return fetch(`/api/users/${id}`).then(res => res.json());
}

// ❌ RUIM: JavaScript sem tipos
function getUser(id) {
  return fetch(`/api/users/${id}`).then(res => res.json());
}
```

### 3. Implemente Error Handling

```typescript
// ✅ BOM: Tratamento de erros adequado
async function fetchData(url: string): Promise<Data> {
  try {
    const response = await fetch(url);
    if (!response.ok) {
      throw new Error(`HTTP error! status: ${response.status}`);
    }
    return await response.json();
  } catch (error) {
    console.error('Erro ao buscar dados:', error);
    throw error;
  }
}

// ❌ RUIM: Sem tratamento de erros
async function fetchData(url) {
  const response = await fetch(url);
  return await response.json();
}
```

---

## Testes

### 1. Escreva Testes

```typescript
// ✅ BOM: Testes abrangentes
describe('calculateTotal', () => {
  it('should return 0 for empty array', () => {
    expect(calculateTotal([])).toBe(0);
  });

  it('should sum item prices', () => {
    const items = [{ price: 10 }, { price: 20 }];
    expect(calculateTotal(items)).toBe(30);
  });

  it('should handle negative prices', () => {
    const items = [{ price: 10 }, { price: -5 }];
    expect(calculateTotal(items)).toBe(5);
  });
});

// ❌ RUIM: Sem testes
function calculateTotal(items) {
  return items.reduce((total, item) => total + item.price, 0);
}
```

### 2. Teste Unitários

```python
# ✅ BOM: Testes unitários
def test_calculate_total():
    assert calculate_total([]) == 0
    assert calculate_total([{"price": 10}, {"price": 20}]) == 30
    assert calculate_total([{"price": 10}, {"price": -5}]) == 5

# ❌ RUIM: Sem testes
def calculate_total(items):
    return sum(item["price"] for item in items)
```

### 3. Teste de Integração

```yaml
# ✅ BOM: Testes de integração
tests:
  integration:
    - name: API Integration
      steps:
        - POST /api/users
        - GET /api/users/:id
        - Verify response

# ❌ RUIM: Apenas testes unitários
tests:
  unit:
    - test_function
```

---

## Segurança

### 1. Valide Input

```typescript
// ✅ BOM: Validação de input
function validateEmail(email: string): boolean {
  const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
  return emailRegex.test(email);
}

function processUser(input: any) {
  if (!validateEmail(input.email)) {
    throw new Error('Email inválido');
  }
  // Processar usuário
}

// ❌ RUIM: Sem validação
function processUser(input) {
  // Processar usuário diretamente
}
```

### 2. Use Autenticação

```typescript
// ✅ BOM: Autenticação adequada
async function fetchProtectedData(token: string) {
  const response = await fetch('/api/protected', {
    headers: {
      'Authorization': `Bearer ${token}`,
    },
  });
  return response.json();
}

// ❌ RUIM: Sem autenticação
async function fetchProtectedData() {
  const response = await fetch('/api/protected');
  return response.json();
}
```

### 3. Sanitize Output

```typescript
// ✅ BOM: Sanitização de output
function sanitizeInput(input: string): string {
  return input
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;')
    .replace(/"/g, '&quot;')
    .replace(/'/g, '&#x27;');
}

// ❌ RUIM: Sem sanitização
function displayUserInput(input: string) {
  document.innerHTML = input;
}
```

---

## Performance

### 1. Cache

```typescript
// ✅ BOM: Uso de cache
const cache = new Map();

async function fetchDataWithCache(url: string) {
  if (cache.has(url)) {
    return cache.get(url);
  }
  
  const data = await fetch(url).then(res => res.json());
  cache.set(url, data);
  return data;
}

// ❌ RUIM: Sem cache
async function fetchData(url) {
  return await fetch(url).then(res => res.json());
}
```

### 2. Lazy Loading

```typescript
// ✅ BOM: Lazy loading
const LazyComponent = React.lazy(() => import('./LazyComponent'));

function App() {
  return (
    <Suspense fallback={<div>Carregando...</div>}>
      <LazyComponent />
    </Suspense>
  );
}

// ❌ RUIM: Carregamento eagerly
import LazyComponent from './LazyComponent';
```

### 3. Otimização de Queries

```sql
-- ✅ BOM: Queries otimizadas
SELECT id, name, email 
FROM users 
WHERE active = true 
LIMIT 100;

-- ❌ RUIM: Queries ineficientes
SELECT * 
FROM users 
WHERE active = true;
```

---

## Colaboração

### 1. Use Versionamento

```bash
# ✅ BOM: Versionamento adequado
git add .
git commit -m "feat: adiciona nova skill de segurança"
git push origin feature/security-skill

# ❌ RUIM: Commits confusos
git add .
git commit -m "mudanças"
git push
```

### 2. Siga o Style Guide

```yaml
# ✅ BOM: Style guide documentado
# .opencode/style-guide.yaml
naming:
  skills: kebab-case
  files: kebab-case
  functions: camelCase
  classes: PascalCase

# ❌ RUIM: Sem style guide
# Cada um faz de um jeito
```

### 3. Revise Código

```yaml
# ✅ BOM: Code review obrigatório
pull_request:
  require_review: true
  min_reviewers: 2
  require_approval: true

# ❌ RUIM: Sem revisão
pull_request:
  auto_merge: true
```

---

## 📊 Checklist de Melhores Práticas

### Organização
- [ ] Estrutura de pastas clara
- [ ] Nomenclatura consistente
- [ ] Configuração centralizada
- [ ] Documentação atualizada

### Código
- [ ] Padrões de codificação
- [ ] TypeScript com tipos
- [ ] Error handling adequado
- [ ] Comments explicativos

### Testes
- [ ] Testes unitários
- [ ] Testes de integração
- [ ] Testes E2E
- [ ] Coverage adequado

### Segurança
- [ ] Validação de input
- [ ] Autenticação
- [ ] Sanitização
- [ ] Criptografia

### Performance
- [ ] Cache
- [ ] Lazy loading
- [ ] Otimização de queries
- [ ] Monitoramento

### Colaboração
- [ ] Versionamento
- [ ] Style guide
- [ ] Code review
- [ ] Documentação

---

## 📚 Recursos

### Leituras Recomendadas

- [Clean Code](https://www.amazon.com/Clean-Code-Handbook-Software-Craftsmanship/dp/0132350882)
- [Refactoring](https://www.amazon.com/Refactoring-Improving-Design-Existing-Code/dp/0201485672)
- [Design Patterns](https://www.amazon.com/Design-Patterns-Elements-Reusable-Object-Oriented/dp/0201633612)

### Ferramentas

- [ESLint](https://eslint.org/) - Linting
- [Prettier](https://prettier.io/) - Formatação
- [TypeScript](https://www.typescriptlang.org/) - Tipagem

---

*Guia atualizado em: Setembro 2026*
*Versão: 2.0*