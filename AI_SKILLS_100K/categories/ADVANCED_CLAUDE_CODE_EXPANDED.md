# 🤖 Claude Code — Skills Avançadas Expandidas

**Fonte:** https://github.com/anthropics/claude-code  
**Descrição:** Claude Code é uma ferramenta de codificação agêntica que vive no terminal, entende sua base de código e ajuda a programar mais rápido através de comandos em linguagem natural. Capacidades incluem: leitura/escrita de arquivos, execução de comandos, busca de código, edição multi-arquivo, operações Git, testes, sistema de memória, integração MCP, sub-agentes, permissões, IDE integration, slash commands, hooks e extended thinking.

---

## 📚 Índice de Categorias

1. [Configuração e Setup](#1-configuração-e-setup)
2. [CLAUDE.md — Sistema de Memória](#2-claudemd--sistema-de-memória)
3. [Comandos Básicos de Terminal](#3-comandos-básicos-de-terminal)
4. [Leitura e Análise de Código](#4-leitura-e-análise-de-código)
5. [Edição Multi-Arquivo](#5-edição-multi-arquivo)
6. [Operações Git Avançadas](#6-operações-git-avançadas)
7. [Execução de Testes e Debug](#7-execução-de-testes-e-debug)
8. [MCP Server Integration](#8-mcp-server-integration)
9. [Sub-Agentes Paralelos](#9-sub-agentes-paralelos)
10. [Sistema de Permissões](#10-sistema-de-permissões)
11. [Slash Commands Customizados](#11-slash-commands-customizados)
12. [Hooks Pre/Post Command](#12-hooks-prepost-command)
13. [Extended Thinking](#13-extended-thinking)
14. [IDE Integration](#14-ide-integration)
15. [Gerenciamento de Projetos](#15-gerenciamento-de-projetos)
16. [Refatoração em Larga Escala](#16-refatoração-em-larga-escala)
17. [Geração de Documentação](#17-geração-de-documentação)
18. [CI/CD e Automação](#18-cicd-e-automação)
19. [Segurança e Code Review](#19-segurança-e-code-review)
20. [Dicas e Padrões Avançados](#20-dicas-e-padrões-avançados)

---

## 1. Configuração e Setup

### 1.1 Instalação via npm

```bash
# Instalação global
npm install -g @anthropic-ai/claude-code

# Verificar versão
claude --version

# Iniciar em um projeto
cd meu-projeto && claude
```

### 1.2 Configuração inicial do projeto

```bash
# Criar arquivo de configuração do projeto
claude config set --project autoApprove "Read,Glob,Grep"

# Configurar modelo padrão
claude config set --global model claude-sonnet-4-20250514

# Habilitar extended thinking
claude config set --global extendedThinking true
```

### 1.3 Estrutura de diretórios recomendada

```
meu-projeto/
├── CLAUDE.md              # Instruções globais do projeto
├── .claude/
│   ├── settings.json      # Configurações do projeto
│   └── commands/          # Slash commands customizados
│       ├── test.md
│       └── review.md
├── src/
└── tests/
```

---

## 2. CLAUDE.md — Sistema de Memória

### 2.1 CLAUDE.md global (por projeto)

```markdown
# CLAUDE.md - Projeto MeuApp

## Tech Stack
- Frontend: React 18 + TypeScript + Tailwind CSS
- Backend: Node.js + Express + PostgreSQL
- Testes: Jest + React Testing Library
- Build: Vite

## Convenções
- Usar functional components com hooks
- Prefira `const` para funções anônimas
- Sempre tipar props com TypeScript
- Seguir padrão responsivo mobile-first

## Comandos Úteis
- `npm run dev` — Inicia servidor de desenvolvimento
- `npm test` — Executa testes
- `npm run lint` — Verifica lint
- `npm run build` — Build de produção

## Arquitetura
- `/src/components` — Componentes React reutilizáveis
- `/src/hooks` — Custom hooks
- `/src/services` — Chamadas API
- `/src/utils` — Funções utilitárias
```

### 2.2 CLAUDE.md por diretório

```bash
# Criar CLAUDE.md específico para diretório
cat > src/components/CLAUDE.md << 'EOF'
# Componentes
- Cada componente deve ter seu arquivo de testes correspondente
- Usar `data-testid` para seletores de teste
- Props interfaces devem ser exportadas junto com o componente
- Seguir atomic design: atoms → molecules → organisms
EOF
```

### 2.3 MELHORIA — CLAUDE.md vs sem memória

```bash
# ❌ ERRADO: Sem CLAUDE.md, o Claude precisa descobrir o projeto toda vez
claude "crie um componente de botão"

# ✅ CORRETO: Com CLAUDE.md, Claude já conhece o padrão
# O arquivo CLAUDE.md define que componentes usam Tailwind + TypeScript
claude "crie um componente de botão"
# Resultado: já segue o padrão do projeto automaticamente
```

---

## 3. Comandos Básicos de Terminal

### 3.1 Modo interativo vs pipe

```bash
# Modo interativo (REPL)
claude

# Pipe de comando único
echo "explique esta função" | cat src/utils.ts | claude

# Modo não-interativo para scripts
claude -p "liste todos os exports do arquivo src/index.ts"
```

### 3.2 Flags importantes

```bash
# Continuar última conversa
claude --continue

# Responder a última pergunta com contexto
claude --resume

# Definir permissões automaticamente
claude --allowedTools "Read,Glob,Grep,Bash(npm test)"

# Diretório de trabalho específico
claude --workdir /path/to/project
```

### 3.3 MELHORIA — Flags eficientes

```bash
# ❌ ERRADO: Abrir Claude e digitar tudo manualmente
claude
# > "execute os testes e me diga o resultado"

# ✅ CORRETO: Usar pipe para comandos rápidos
claude -p "execute os testes com npm test e resuma os resultados"
```

---

## 4. Leitura e Análise de Código

### 4.1 Exploração de codebase

```bash
# Perguntar sobre arquitetura
claude "como está estruturada a aplicação? Quais são as principais camadas?"

# Encontrar padrões específicos
claude "encontre todos os componentes que usam useEffect e listei"

# Analisar dependências
claude "quais são as dependências circulares neste projeto?"
```

### 4.2 Análise de arquivos específicos

```bash
# Ler e explicar código
claude "explique linha por linha o que src/services/api.ts faz"

# Encontrar bugs potenciais
claude "analise src/utils/parser.ts para possíveis bugs ou edge cases"

# Sugerir melhorias
claude "liste 5 melhorias de performance para src/components/DataGrid.tsx"
```

### 4.3 MELHORIA — Análise superficial vs profunda

```bash
# ❌ ERRADO: Pedir análise genérica
claude "analise o projeto"

# ✅ CORRETO: Pedir análise focada e acionável
claude "analise src/services/api.ts, foque em: tratamento de erros,
       timeout de requisições, retry pattern, e typing TypeScript.
       Retorne um relatório com issues encontradas e sugestões de fix."
```

---

## 5. Edição Multi-Arquivo

### 5.1 Edição com contexto

```bash
# Refatoração que toca múltiplos arquivos
claude "refatore o componente UserList para usar a nova API de users,
       atualizando também os testes e o mock"

# Renomear variável globalmente
claude "renomeie a função 'fetchData' para 'fetchUserData' em todo o projeto,
       mas mantenha 'fetchData' apenas em src/utils/api.ts"
```

### 5.2 Padrão de edição segura

```bash
# Criar feature nova com scaffold completo
claude "crie o módulo de autenticação com:
       - src/auth/types.ts (interfaces)
       - src/auth/useAuth.ts (hook)
       - src/auth/LoginForm.tsx (componente)
       - src/auth/auth.service.ts (serviço API)
       - src/auth/__tests__/useAuth.test.ts (testes)
       Use JWT tokens e siga o padrão existente do projeto"
```

### 5.3 MELHORIA — Edição pontual vs sistêmica

```bash
# ❌ ERRADO: Editar arquivo por arquivo manualmente
# Editar A, depois B, depois C, esquecer D...

# ✅ CORRETO: Pedir ao Claude para fazer sistematicamente
claude "adicione validação de email em todos os formulários do projeto.
       Verifique src/components/forms/, src/pages/, e crie um
       shared validator em src/utils/validators.ts"
```

---

## 6. Operações Git Avançadas

### 6.1 Commits inteligentes

```bash
# Criar commit com mensagem descritiva
claude "analise minhas mudanças staged e crie um commit convencional"

# Commit com escopo
claude "adicione os arquivos alterados e crie um commit do tipo
       feat(auth): adicione login com Google OAuth"

# Amend no último commit
claude "adicione o arquivo que esqueci ao último commit sem mudar a mensagem"
```

### 6.2 Branch management

```bash
# Criar branch feature
claude "crie uma branch feature/user-profile a partir de develop
       e implemente o componente UserProfile"

# Merge com resolução
claude "faça merge de feature/cart em develop, resolvendo conflitos
       se houver, priorizando a versão de feature/cart"

# Criar PR
claude "crie um PR para feature/cart com descrição detalhando
       as mudanças, testes executados e breaking changes"
```

### 6.3 MELHORIA — Git manual vs assistido

```bash
# ❌ ERRADO: Commits genéricos sem contexto
git add -A && git commit -m "fix"
git commit -m "updates"
git commit -m "wip"

# ✅ CORRETO: Commits convencionais assistidos por Claude
claude "analise as mudanças staged e gere commit convencional"
# Resultado: feat(auth): implement JWT refresh token rotation
```

---

## 7. Execução de Testes e Debug

### 7.1 Execução e análise de testes

```bash
# Rodar testes e interpretar resultados
claude "execute npm test e analise os testes que falharam,
       sugerindo correções"

# Criar testes para código existente
claude "crie testes unitários para src/utils/formatters.ts,
       cobrindo edge cases: datas inválidas, strings vazias,
       números negativos"

# Testes de integração
claude "crie testes de integração para o fluxo de checkout,
       testando: carrinho → pagamento → confirmação → email"
```

### 7.2 Debug assistido

```bash
# Debug com contexto completo
claude "este teste está falhando: [erro colado].
       Analise o teste e o código testado, encontre a causa raiz"

# Debug de performance
claude "o endpoint /api/users está lento (2s+).
       Analise src/routes/users.ts e sugira otimizações"

# Debug de memória
claude "a aplicação está com memory leak.
       Analise src/hooks/useWebSocket.ts para possíveis
       subscriptions não limpas"
```

### 7.3 MELHORIA — Testes manuais vs automatizados

```bash
# ❌ ERRADO: Pedir apenas "crie testes"
claude "crie testes"
# Resultado: testes superficiais sem edge cases

# ✅ CORRETO: Pedir testes com critérios específicos
claude "crie testes para src/services/payment.ts com:
       1. Happy path (pagamento aprovado)
       2. Cartão recusado
       3. Timeout de rede
       4. Retry automático
       5. Validação de dados de entrada
       6. Teste de concorrência (dois pagamentos simultâneos)
       Alcance cobertura mínima de 90%"
```

---

## 8. MCP Server Integration

### 8.1 Configuração de servidor MCP

```json
// .claude/settings.json
{
  "mcpServers": {
    "postgres": {
      "command": "npx",
      "args": ["-y", "@anthropic-ai/mcp-server-postgres"],
      "env": {
        "DATABASE_URL": "postgresql://user:pass@localhost:5432/mydb"
      }
    },
    "filesystem": {
      "command": "npx",
      "args": ["-y", "@anthropic-ai/mcp-server-filesystem", "/path/to/allowed/dir"]
    }
  }
}
```

### 8.2 Uso de MCP tools no Claude

```bash
# Consultar banco de dados diretamente
claude "liste todas as tabelas do banco de dados e mostre
       a estrutura da tabela 'users'"

# Ler arquivos do sistema via MCP
claude "leia o arquivo de configuração /etc/app/config.json
       e valide se está correto"

# Combinar MCP com código local
claude "consulte o banco via MCP para listar os usuários ativos,
       depois gere um script de migração para adicionar campo 'phone'"
```

### 8.3 MELHORIA — Sem MCP vs com MCP

```bash
# ❌ ERRADO: Copiar/colar dados manualmente
# Abrir PgAdmin → exportar CSV → colar no terminal → ...

# ✅ CORRETO: Usar MCP server integrado
claude "via MCP, Consulte o banco e gere uma migration
       para alterar a tabela products adicionando
       o campo 'sku' com índice único"
```

---

## 9. Sub-Agentes Paralelos

### 9.1 Decomposição de tarefas

```bash
# Tarefa complexa → múltiplos sub-agentes
claude "refatore o módulo de pagamentos:
       - Subtarefa 1: Migrar service layer para nova API
       - Subtarefa 2: Atualizar testes unitários
       - Subtarefa 3: Atualizar testes de integração
       - Subtarefa 4: Atualizar documentação da API
       Execute as subtarefas 1 e 2 em paralelo"
```

### 9.2 Padrão de paralelismo

```bash
# Code review paralelo
claude "faça code review dos seguintes arquivos em paralelo:
       - src/services/auth.ts (foque em segurança)
       - src/services/payment.ts (foque em transações)
       - src/services/email.ts (foque em performance)
       Compile um relatório consolidado ao final"

# Migração paralela
claude "migre os seguintes componentes para React 19 em paralelo:
       - Header, Footer, Sidebar (componentes simples)
       - DataGrid, FormBuilder (componentes complexos)
       Cada grupo pode ser processado independentemente"
```

### 9.3 MELHORIA — Sequencial vs paralelo

```bash
# ❌ ERRADO: Processar tudo sequencialmente
claude "refatore A, depois B, depois C, depois D"
# Total: ~4x o tempo

# ✅ CORRETO: Executar subtarefas independentes em paralelo
claude "refatore A, B, C e D em paralelo, são independentes.
       Compile resultado consolidado ao final"
# Total: ~1x o tempo (tempo da subtarefa mais lenta)
```

---

## 10. Sistema de Permissões

### 10.1 Configuração de permissões

```bash
# Listar permissões atuais
claude config list

# Permitir ferramenta específica
claude config add allowedTools "Bash(npm test)"

# Permitir padrão de comando
claude config add allowedTools "Bash(git *)"

# Permissões por projeto
claude config set --project autoApprove "Read,Glob,Grep"
```

### 10.2 Níveis de confiança

```json
// .claude/settings.json
{
  "permissions": {
    "allow": [
      "Read",
      "Glob",
      "Grep",
      "Bash(npm test)",
      "Bash(npm run lint)",
      "Bash(git status)",
      "Bash(git diff *)"
    ],
    "deny": [
      "Bash(rm -rf *)",
      "Bash(git push --force *)",
      "Bash(npm publish *)"
    ]
  }
}
```

### 10.3 MELHORIA — Permissões restritivas vs balanceadas

```bash
# ❌ ERRADO: Permissões muito amplas (risco de segurança)
claude config add allowedTools "Bash(*)"

# ❌ ERRADO: Permissões tão restritivas que travam o trabalho
claude config add allowedTools "Read"

# ✅ CORRETO: Permissões granulares e seguras
claude config add allowedTools "Bash(npm test)"
claude config add allowedTools "Bash(npm run lint)"
claude config add allowedTools "Bash(git status)"
claude config add allowedTools "Bash(git diff --name-only)"
claude config add allowedTools "Bash(node scripts/migrate.js)"
# Comando sem risco liberado, comandos destrutivos negados
```

---

## 11. Slash Commands Customizados

### 11.1 Criando slash commands

```bash
# Criar diretório de comandos
mkdir -p .claude/commands

# Criar comando de review
cat > .claude/commands/review.md << 'EOF'
Faça um code review detalhado dos arquivos staged:
1. Verifique padrões de código do projeto
2. Identifique possíveis bugs
3. Sugira melhorias de performance
4. Verifique cobertura de testes
5. Valide tipagem TypeScript
Retorne um relatório em formato markdown.
EOF

# Criar comando de deploy
cat > .claude/commands/deploy-check.md << 'EOF'
Antes do deploy, verifique:
1. Todos os testes passam (npm test)
2. Lint sem erros (npm run lint)
3. Build OK (npm run build)
4. Sem dependências desatualizadas críticas
5. Changelog atualizado
EOF
```

### 11.2 Uso dos comandos

```bash
# Dentro do Claude Code
/review
/deploy-check

# Com argumentos
/refactor src/old-service.ts --target=new-pattern
```

### 11.3 MELHORIA — Comandos genéricos vs específicos

```bash
# ❌ ERRADO: Comando genérico demais
cat > .claude/commands/check.md << 'EOF'
Verifique o código
EOF

# ✅ CORRETO: Comando com checklist explícito
cat > .claude/commands/check.md << 'EOF'
Execute a verificação completa do projeto:
1. Rode `npm test` e verifique cobertura mínima de 80%
2. Rode `npm run lint` e corrija erros (warnings são aceitáveis)
3. Rode `npm run typecheck` e verifique tipos
4. Verifique se há TODOs pendentes no código staged
5. Valide que nenhum segredo está exposto (API keys, tokens)
Gere um relatório com status PASS/FAIL de cada item.
EOF
```

---

## 12. Hooks Pre/Post Command

### 12.1 Configuração de hooks

```json
// .claude/settings.json
{
  "hooks": {
    "PreCommand": [
      {
        "matcher": "Bash(npm publish *)",
        "hooks": [
          {
            "type": "command",
            "command": "npm test && npm run lint"
          }
        ]
      }
    ],
    "PostCommand": [
      {
        "matcher": "Edit",
        "hooks": [
          {
            "type": "command",
            "command": "npm run format"
          }
        ]
      }
    ]
  }
}
```

### 12.2 Hooks de validação

```bash
# Hook que roda antes de qualquer edição de arquivo
# .claude/settings.json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Edit",
        "hooks": [
          {
            "type": "command",
            "command": "echo 'Verificando se o branch está atualizado...' && git fetch origin"
          }
        ]
      }
    ]
  }
}
```

### 12.3 MELHORIA — Sem hooks vs com hooks

```bash
# ❌ ERRADO: Esquecer de formatar após edição
# Edição feita → commit → CI reclama de formatação → retry

# ✅ CORRETO: Hook automático pós-edição
# PostCommand hook roda `prettier --write` automaticamente
# Após qualquer Edit, código já fica formatado
```

---

## 13. Extended Thinking

### 13.1 Ativação e uso

```bash
# Ativar extended thinking globalmente
claude config set --global extendedThinking true

# Usar em problemas complexas
claude --think "analise a arquitetura deste monólito e proponha
uma estratégia de microsserviços, considerando:
- Dependências entre módulos
- Estratégia de migração incremental
- Impacto na equipe
- Riscos e mitigações
- Timeline realista"
```

### 13.2 Casos ideais para extended thinking

```bash
# Arquitetura de sistema
claude "pense profundamente sobre como reestruturar
o sistema de autenticação para suportar SSO, MFA
e multi-tenant simultaneamente"

# Debug complexo
claude "pense passo a passo sobre por que o sistema de
fila está perdendo mensagens em alta concorrência.
Considere race conditions, buffering e backpressure"

# Otimização de performance
claude "analise o profile de performance da aplicação
e proponha otimizações priorizadas por impacto"
```

### 13.3 MELHORIA — Respostas rápidas vs thinking profundo

```bash
# ❌ ERRADO: Usar extended thinking para tudo
claude --think "qual a versão do node?"  # Desperdício

# ✅ CORRETO: Reservar para problemas complexos
# Pergunta simples → sem thinking
claude "liste os arquivos em src/"

# Problema complexo → com thinking
claude --think "analise o sistema de cache atual,
identifique os pontos de invalidação e proponha
uma estratégia de cache invalidation que minimize
reads stale e maximize hit rate"
```

---

## 14. IDE Integration

### 14.1 VS Code

```bash
# Instalar extensão Claude Code no VS Code
# Marketplace: "Claude Code" by Anthropic

# Atalhos úteis:
# Cmd/Ctrl + Shift + P → "Claude Code: Open"
# Cmd/Ctrl + L → Enviar seleção para Claude
# Cmd/Ctrl + Enter → Executar último comando
```

### 14.2 JetBrains

```bash
# Plugin Claude Code para IntelliJ/WebStorm
# Settings → Plugins → Marketplace → "Claude Code"

# Configurar atalhos:
# Tools → Claude Code → Open Claude Code
# Context menu → Send to Claude
```

### 14.3 MELHORIA — Terminal vs IDE

```bash
# ❌ ERRADO: Alternar entre IDE e terminal constantemente
# Abrir terminal → digitar comando → copiar resultado → colar na IDE

# ✅ CORRETO: Usar integração nativa do IDE
# Selecionar código no editor → Cmd+L → Claude processa in-place
# Resultado: fluxo contínuo sem context switching
```

---

## 15. Gerenciamento de Projetos

### 15.1 Inicialização de projeto

```bash
# Scaffold completo de projeto
claude "crie um projeto Next.js 14 com:
       - App Router
       - TypeScript
       - Tailwind CSS
       - Prisma ORM
       - NextAuth.js
       - Estrutura de pastas feature-based
       - Docker para dev
       - GitHub Actions para CI"

# Setup de monorepo
claude "configure um monorepo com Turborepo:
       - packages/ui (componentes compartilhados)
       - packages/utils (utilitários)
       - apps/web (frontend Next.js)
       - apps/api (backend NestJS)"
```

### 15.2 Migração de projeto

```bash
# Migração de framework
claude "migre este projeto de Create React App para Vite:
       1. Atualize package.json
       2. Mova config de Babel para Vite
       3. Atualize imports de assets
       4. Teste que tudo funciona
       5. Atualize scripts de build"

# Migração de dependência
claude "migre de moment.js para date-fns em todo o projeto,
       substituindo cada API correspondente"
```

### 15.3 MELHORIA — Setup manual vs scaffold

```bash
# ❌ ERRADO: Setup manual file-by-file
# Criar package.json → instalar deps → configurar → ...

# ✅ CORRETO: Scaffold completo de uma vez
claude "crie projeto completo com stack X, Y, Z,
       incluindo config de CI, lint, testes e docker.
       Valide que `npm install && npm test` funciona."
```

---

## 16. Refatoração em Larga Escala

### 16.1 Refatoração assistida

```bash
# Migrar padrão arquitetural
claude "refatore de class components para functional components
       com hooks em todos os arquivos de src/components/.
       Mantenha a mesma funcionalidade, adicione tipos TypeScript"

# Extrair lógica compartilhada
claude "analise todos os componentes que fazem chamadas API
       e extraia um hook useFetch() reutilizável em src/hooks/.
       Substitua o código duplicado nos componentes"
```

### 16.2 Migração de estado

```bash
# Redux → Zustand
claude "migre o estado global de Redux para Zustand:
       1. Crie stores equivalente em src/stores/
       2. Substitua connect() por hooks
       3. Remova action creators desnecessários
       4. Simplifique reducers em store slices
       5. Atualize testes"

# Context → State Management
claude "refatore o ThemeContext para usar Zustand,
       mantendo a mesma API pública para componentes"
```

### 16.3 MELHORIA — Refatoração incremental vs sistêmica

```bash
# ❌ ERRADO: Refatorar arquivo por arquivo sem padrão
# Arquivo 1: functional component
# Arquivo 2: ainda class component (esqueceu)
# Arquivo 3: functional mas sem tipos

# ✅ CORRETO: Refatoração sistêmica com validação
claude "refatore TODOS os class components para functional.
       Execute ao final:
       - npm test (garantir que não quebrou nada)
       - npm run typecheck (garantir tipos corretos)
       - grep -r 'extends React.Component' src/ (confirmar zero ocorrências)"
```

---

## 17. Geração de Documentação

### 17.1 Documentação de código

```bash
# Gerar JSDoc para funções
claude "adicione documentação JSDoc completa para todas as
       funções exportadas em src/services/api.ts"

# Gerar README
claude "gere um README.md completo para este projeto com:
       - Descrição do projeto
       - Pré-requisitos
       - Instalação
       - Uso com exemplos
       - Estrutura do projeto
       - Contribuição
       - Licença"

# Gerar documentação de API
claude "gere documentação OpenAPI 3.0 para todas as rotas
       definidas em src/routes/"
```

### 17.2 Documentação de decisões

```bash
# ADR (Architecture Decision Records)
claude "crie um ADR para a decisão de usar PostgreSQL ao invés
       de MongoDB, documentando: contexto, decisão, consequências,
       alternativas consideradas"
```

### 17.3 MELHORIA — Doc manual vs auto-gerada

```bash
# ❌ ERRADO: Documentação desatualizada
# Escrever README no início → código muda → doc fica errada

# ✅ CORRETO: Doc gerada a partir do código
claude "gere a documentação da API diretamente das rotas
       e controllers definidos, garantindo que está 100%
       sincronizado com o código atual"
```

---

## 18. CI/CD e Automação

### 18.1 Configuração de pipeline

```bash
# GitHub Actions
claude "crie um pipeline GitHub Actions com:
       - Lint na PR
       - Testes com cobertura
       - Build de produção
       - Deploy staging (automático)
       - Deploy produção (manual approval)
       - Notificação Slack"

# GitLab CI
claude "crie .gitlab-ci.yml com stages:
       - lint → test → build → deploy
       - Cache de node_modules
       - Artifacts de teste"
```

### 18.2 Scripts de automação

```bash
# Script de release
claude "crie um script scripts/release.sh que:
       1. Verifica se está em main
       2. Roda todos os testes
       3. Atualiza version no package.json
       4. Gera changelog
       5. Cria tag git
       6. Push com tags"

# Script de hotfix
claude "crie um script scripts/hotfix.sh que:
       1. Cria branch hotfix a partir de main
       2. Aplica fix
       3. Roda testes
       4. Merge em main e develop
       5. Delete a branch hotfix"
```

### 18.3 MELHORIA — CI manual vs automatizado

```bash
# ❌ ERRADO: Pipeline sem proteção
# Push direto em main → deploy automático sem testes

# ✅ CORRETO: Pipeline protegido com quality gates
claude "configure pipeline com:
       - PR obrigatório para main
       - Testes devem passar antes do merge
       - Build deve compilar sem erros
       - Coverage mínima de 80%
       - Deploy staging automático
       - Deploy produção com approval"
```

---

## 19. Segurança e Code Review

### 19.1 Auditoria de segurança

```bash
# Scan de vulnerabilidades
claude "analise o projeto para vulnerabilidades de segurança:
       - Dependências com CVEs conhecidos
       - Secrets hardcoded no código
       - SQL injection potencial
       - XSS em templates
       - Autenticação fraca"

# Validação de input
claude "revise todos os endpoints da API e verifique se
       estão validando e sanitizando inputs corretamente"
```

### 19.2 Code review assistido

```bash
# Review de PR
claude "faça code review deste PR focando em:
       1. Bugs potenciais
       2. Vulnerabilidades de segurança
       3. Performance
       4. Manutenibilidade
       5. Cobertura de testes
       Retorne comments inline no padrão do GitHub"

# Review de dependências
claude "analise as dependências do package.json e identifique:
       - Pacotes deprecated
       - Versões com vulnerabilidades
       - Dependências não utilizadas
       - Alternativas mais seguras"
```

### 19.3 MELHORIA — Review superficial vs profundo

```bash
# ❌ ERRADO: Review apenas de sintaxe
claude "revise o código"  # → "Looks good to me"

# ✅ CORRETO: Review com checklist de segurança
claude "revise src/services/auth.ts com foco em segurança:
       1. Tokens estão sendo validados?
       2. Senhas têm salt/hash adequado?
       3. Rate limiting está configurado?
       4. CORS está restritivo?
       5. Headers de segurança estão presentes?
       6. Logs não expõem dados sensíveis?
       7. Timeout está configurado?
       8. Falha graceful em errores?"
```

---

## 20. Dicas e Padrões Avançados

### 20.1 Padrões de prompting eficientes

```bash
# ❌ PROMPT VAGO:
claude "melhore o código"

# ✅ PROMPT ESPECÍFICO:
claude "refatore src/services/userService.ts:
       1. Extraia lógica de validação para src/validators/user.ts
       2. Use Result pattern ao invés de throw
       3. Adicione logging estruturado
       4. Atualize testes para cobrir novos paths
       5. Mantenha backward compatibility"
```

### 20.2 Chain of thought para problemas complexos

```bash
claude "vou descrever um problema e quero que resolva passo a passo:

Problema: O sistema de cache Redis está perdendo dados após restart.

Passo 1: Analise a configuração atual de cache em src/config/redis.ts
Passo 2: Identifique a estratégia de persistência (RDB, AOF, nenhum)
Passo 3: Proponha solução que mantenha dados entre restarts
Passo 4: Implemente a solução
Passo 5: Adicione testes de integração
Passo 6: Documente a mudança"
```

### 20.3 Workflows de produtividade

```bash
# Feature development workflow
claude "inicie o workflow de feature 'dark-mode':
       1. Crie branch feature/dark-mode
       2. Implemente toggle de tema
       3. Crie CSS variables para temas
       4. Implemente persistência no localStorage
       5. Adicione testes
       6. Crie PR com descrição completa
       7. Rode lint e testes antes do PR"

# Bug fix workflow
claude "inicie o workflow de bugfix:
       1. Crie branch bugfix/[descrição]
       2. Reproduza o bug com teste que falha
       3. Implemente o fix
       4. Verifique que o teste agora passa
       5. Rode suite completa de testes
       6. Crie commit e PR"
```

### 20.4 Padrões de organização

```bash
# ❌ ESTRUTURA RUIM:
src/
  utils.js      # Tudo misturado
  helpers.js    # Funções diversas
  misc.js       # O que sobrou
  index.js      # God file

# ✅ ESTRUTURA ORGANIZADA (pedir ao Claude):
claude "reestruture src/ seguindo Feature-Sliced Design:
       - src/app/        (configuração da aplicação)
       - src/processes/  (processos de negócio)
       - src/features/   (features por domínio)
       - src/entities/   (entidades de domínio)
       - src/shared/     (componentes, utils, APIs compartilhadas)"
```

### 20.5 Checklist de produtividade

```bash
# Antes de cada sessão:
claude "verifique o estado do projeto:
       1. Branch atual e mudanças pendentes
       2. Testes passando?
       3. Lint limpo?
       4. Dependências atualizadas?
       5. Algum TODO crítico pendente?"

# Ao final de cada sessão:
claude "gere um resumo do que foi feito:
       1. Arquivos criados/modificados
       2. Testes adicionados/corrigidos
       3. Issues encontradas e resolvidas
       4. Próximos passos recomendados
       5. Possíveis risks para revisar"
```

---

## 📋 Resumo de Comandos Essenciais

| Comando | Uso |
|---------|-----|
| `claude` | Iniciar modo interativo |
| `claude -p "..."` | Executar comando único |
| `claude --continue` | Continuar conversa |
| `claude --resume` | Retomar última pergunta |
| `claude config set` | Configurar opções |
| `/review` | Executar slash command |
| `/refactor` | Executar slash command |
| `claude --think` | Extended thinking |

---

## 🎯 Princípios Fundamentais

1. **Seja específico** — Quanto mais contexto, melhor o resultado
2. **Use CLAUDE.md** — Memorize padrões do projeto
3. **Automatize com hooks** — Validações automáticas
4. **Segurança primeiro** — Permissões granulares
5. **Paralelize** — Use sub-agentes para tarefas independentes
6. **Valide sempre** — Rode testes/lint após cada mudança
7. **Documente decisões** — Gere docs a partir do código
8. **Itere incrementalmente** — Grandes mudanças em passos pequenos

---

*Documento gerado para fins de referência e aprendizado. Baseado na documentação oficial do Claude Code (Anthropic).*
*Última atualização: 2026*
