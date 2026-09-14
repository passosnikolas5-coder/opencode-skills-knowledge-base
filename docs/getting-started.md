# 🚀 Guia de Início Rápido

Bem-vindo ao **OpenCode Skills Knowledge Base**! Este guia vai ajudá-lo a começar a usar a base de conhecimento de skills de forma rápida e eficiente.

## 📋 Índice

- [Visão Geral](#visão-geral)
- [Instalação](#instalação)
- [Primeiros Passos](#primeiros-passos)
- [Como Usar as Skills](#como-usar-as-skills)
- [Exemplos Práticos](#exemplos-práticos)
- [Dicas Úteis](#dicas-úteis)
- [Próximos Passos](#próximos-passos)

---

## Visão Geral

O **OpenCode Skills Knowledge Base** é uma coleção completa de **1.500+ skills** documentadas para o sistema OpenCode. Cada skill é documentada com:

1. **Exemplos Práticos** - 2-3 exemplos de código
2. **Casos de Uso Avançados** - Projetos reais
3. **Integração com Outras Skills** - Skills complementares
4. **Padrões e Anti-padrões** - O que fazer e evitar
5. **Dicas de Performance** - Otimizações
6. **Comandos Úteis** - Snippets prontos
7. **Referências** - Links oficiais

### Por que Usar Esta Base?

- ✅ **Completa**: Mais de 1.500 skills documentadas
- ✅ **Prática**: Exemplos de código prontos para usar
- ✅ **Organizada**: Categorias lógicas e intuitivas
- ✅ **Atualizada**: Documentação sempre em dia
- ✅ **Gratuita**: Código aberto e livre para uso

---

## Instalação

### Opção 1: Clonar o Repositório (Recomendado)

```bash
# Clonar o repositório
git clone https://github.com/passosnikolas5-coder/opencode-skills-knowledge-base.git

# Entrar no diretório
cd opencode-skills-knowledge-base
```

### Opção 2: Download ZIP

1. Acesse [GitHub](https://github.com/passosnikolas5-coder/opencode-skills-knowledge-base)
2. Clique em "Code" → "Download ZIP"
3. Extraia o arquivo
4. Entre no diretório

### Opção 3: Usar Diretamente

Você pode usar a base de conhecimento sem instalar nada:

1. Acesse os arquivos no GitHub
2. Navegue pelas categorias
3. Leia a documentação online

---

## Primeiros Passos

### 1. Entenda a Estrutura

```
opencode-skills-knowledge-base/
├── README.md                    # Documentação principal
├── CONTRIBUTING.md              # Guia de contribuição
├── CHANGELOG.md                 # Histórico de versões
├── LICENSE                      # Licença MIT
├── docs/                        # Documentação
│   ├── getting-started.md       # Este arquivo
│   ├── advanced-usage.md        # Uso avançado
│   ├── best-practices.md        # Melhores práticas
│   └── troubleshooting.md       # Solução de problemas
├── examples/                    # Exemplos práticos
├── scripts/                     # Scripts auxiliares
├── templates/                   # Templates
└── src/                         # Skills documentadas
    ├── Development/
    ├── AI_ML/
    ├── DevOps/
    ├── Security/
    ├── Testing/
    ├── Business/
    ├── Data/
    ├── Design/
    ├── ProjectManagement/
    └── Other/
```

### 2. Escolha uma Categoria

Dependendo do seu interesse, escolha uma categoria:

- **Desenvolvimento**: `src/Development/`
- **AI/ML**: `src/AI_ML/`
- **DevOps**: `src/DevOps/`
- **Segurança**: `src/Security/`
- **Testes**: `src/Testing/`
- **Negócios**: `src/Business/`
- **Dados**: `src/Data/`
- **Design**: `src/Design/`
- **Gestão**: `src/ProjectManagement/`

### 3. Leia a Documentação

Cada skill é documentada com o mesmo formato:

```markdown
## X. nome-da-skill

**Descrição:** O que a skill faz

**Quando usar:**
- Caso 1
- Caso 2

**Exemplos práticos:**
```código```

**Casos de uso avançados:**
- Projeto Real 1
- Projeto Real 2

**Integração com outras skills:**
- skill-complementar1: para quando precisar de...
- skill-complementar2: para integrar com...

**Padrões e anti-padrões:**
✅ Fazer: ...
❌ Evitar: ...

**Dicas de performance:**
- Dica 1
- Dica 2

**Comandos úteis:**
```bash/código```

**Referências:**
- [Link 1](url)
- [Link 2](url)
```

---

## Como Usar as Skills

### Carregar uma Skill

Para usar uma skill específica, use o comando:

```bash
skill <nome-da-skill>
```

### Exemplos Comuns

#### Para Desenvolvimento Web

```bash
# React
skill react-patterns
skill nextjs-best-practices
skill tailwind-patterns

# Vue
skill vue-patterns
skill nuxt-best-practices

# Svelte
skill svelte-patterns
skill sveltekit-best-practices
```

#### Para Backend

```bash
# APIs
skill api-designer
skill api-security-best-practices
skill graphql

# Python
skill fastapi-router-py
skill django-backend
skill flask-api

# Node.js
skill nodejs-backend-patterns
skill express-api
skill nestjs-backend
```

#### Para DevOps

```bash
# Containers
skill docker-expert
skill kubernetes-architect

# Infraestrutura
skill terraform-specialist
skill ansible-automation

# CI/CD
skill github-actions-advanced
skill gitops-workflow
```

#### Para AI/ML

```bash
# Frameworks
skill langchain
skill hugging-face
skill pytorch

# Agentes
skill ai-agents
skill agent-orchestration

# Prompting
skill prompt-engineering
skill llm-optimization
```

#### Para Segurança

```bash
# API Security
skill api-security-best-practices
skill backend-security-coder

# Pentest
skill src-hunter
skill burp-suite

# Compliance
skill owasp-top-10
skill pci-dss
```

---

## Exemplos Práticos

### Exemplo 1: Criar uma API com FastAPI

```python
# 1. Instalar FastAPI
# pip install fastapi uvicorn

# 2. Criar a aplicação
from fastapi import FastAPI
from pydantic import BaseModel

app = FastAPI()

class User(BaseModel):
    name: str
    email: str
    password: str

@app.post("/users/")
async def create_user(user: User):
    return {"message": "Usuário criado", "user": user}

# 3. Executar
# uvicorn main:app --reload
```

### Exemplo 2: Docker com Multi-stage Build

```dockerfile
# Stage 1: Build
FROM node:18-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build

# Stage 2: Production
FROM node:18-alpine AS production
WORKDIR /app
COPY --from=builder /app/dist ./dist
COPY --from=builder /app/node_modules ./node_modules
EXPOSE 3000
CMD ["node", "dist/main.js"]
```

### Exemplo 3: React com Hooks

```jsx
import { useState, useEffect } from 'react';

function UserList() {
  const [users, setUsers] = useState([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    fetch('/api/users')
      .then(res => res.json())
      .then(data => {
        setUsers(data);
        setLoading(false);
      });
  }, []);

  if (loading) return <div>Carregando...</div>;

  return (
    <ul>
      {users.map(user => (
        <li key={user.id}>{user.name}</li>
      ))}
    </ul>
  );
}
```

---

## Dicas Úteis

### 1. Use o Índice

Consulte o `INDEX.md` para encontrar skills rapidamente:

```bash
# Abrir o índice
cat INDEX.md
```

### 2. Busca por Palavras-Chave

Use `grep` para buscar skills específicas:

```bash
# Buscar skills de React
grep -r "react" src/

# Buscar skills de Docker
grep -r "docker" src/
```

### 3. Comece pelas Básicas

Se você é iniciante, comece por:

1. **Development** - Fundamentos
2. **Testing** - Qualidade
3. **Project Management** - Organização

### 4. Pratique

A melhor forma de aprender é praticando:

1. Escolha uma skill
2. Leia a documentação
3. Execute os exemplos
4. Adapte ao seu projeto

### 5. Contribua

Encontrou um erro ou tem uma sugestão? Contribua!

1. Abra uma issue
2. Crie um pull request
3. Compartilhe conhecimento

---

## Próximos Passos

### Para Iniciantes

1. **Leia o README.md** - Visão geral completa
2. **Explore as categorias** - Veja o que está disponível
3. **Pratique exemplos** - Execute os exemplos de código
4. **Crie algo** - Aplique o aprendizado

### Para Desenvolvedores Experientes

1. **Aprofunde-se** - Explore skills avançadas
2. **Integre** - Use skills em projetos reais
3. **Contribua** - Adicione novas skills
4. **Mentore** - Ajude iniciantes

### Para Gestores

1. **Entenda o valor** - Veja como skills aumentam produtividade
2. **Planeje** - Crie um plano de aprendizado para a equipe
3. **Implemente** - Adote skills nos processos
4. **Meça** - Avalie resultados

---

## Recursos Adicionais

### Documentação

- [README.md](../README.md) - Documentação principal
- [CONTRIBUTING.md](../CONTRIBUTING.md) - Guia de contribuição
- [CHANGELOG.md](../CHANGELOG.md) - Histórico de versões

### Exemplos

- [examples/backend/](../examples/backend/) - Exemplos de Backend
- [examples/frontend/](../examples/frontend/) - Exemplos de Frontend
- [examples/devops/](../examples/devops/) - Exemplos de DevOps

### Scripts

- [scripts/install.sh](../scripts/install.sh) - Instalação
- [scripts/update.sh](../scripts/update.sh) - Atualização

### Templates

- [templates/skill-template.md](../templates/skill-template.md) - Template para skills
- [templates/category-template.md](../templates/category-template.md) - Template para categorias

---

## 🔍 Solução de Problemas

### Problema: Não encontro a skill que preciso

**Solução:**
1. Use o índice (`INDEX.md`)
2. Busque por palavras-chave
3. Navegue pelas categorias
4. Abra uma issue pedindo ajuda

### Problema: Exemplo não funciona

**Solução:**
1. Verifique se instalou as dependências
2. Confira a versão das ferramentas
3. Consulte a documentação oficial
4. Abra um bug report

### Problema: Não entendo a documentação

**Solução:**
1. Leia os exemplos práticos
2. Consulte as referências
3. Peça ajuda na comunidade
4. Contribua com melhorias

---

## 📞 Suporte

### Canais de Suporte

- **GitHub Issues**: Para bugs e sugestões
- **GitHub Discussions**: Para dúvidas
- **README**: Para documentação básica
- **docs/**: Para documentação avançada

### Como Pedir Ajuda

1. **Seja específico**: Descreva claramente seu problema
2. **Inclua contexto**: O que você estava tentando fazer
3. **Mostre código**: Se aplicável
4. **Seja paciente**: Aguarde resposta

---

## 🎉 Parabéns!

Agora você está pronto para começar a usar o **OpenCode Skills Knowledge Base**!

Lembre-se:
- **Pratique** regularmente
- **Contribua** quando possível
- **Compartilhe** conhecimento
- **Aprenda** continuamente

**Boa sorte na sua jornada!** 🚀

---

*Guia atualizado em: Setembro 2026*
*Versão: 2.0*