# 🚀 OpenAI Codex - Skills Avançadas

## 📋 Informações Gerais
- **Fonte**: https://github.com/openai/codex (125k+ estrelas)
- **Descrição**: Agente de codificação autônomo da OpenAI com capacidades de planejamento, execução de código em ambiente sandbox, e integração direta com GitHub para PRs e issues.
- **Linguagem**: TypeScript/Python
- **Modelos Suportados**: codex-mini, o3, o4-mini

---

## 🎯 Categorias de Skills

### 1. Instalação e Configuração Básica

**Skills:**
1. Instalação via npm com configuração inicial
2. Configuração de API key e provider
3. Setup do ambiente de trabalho
4. Verificação de dependências do sistema

**Código Exemplo:**
```bash
# Instalação global
npm install -g @openai/codex

# Configuração de ambiente
export OPENAI_API_KEY="sua-chave-aqui"

# Verificação de instalação
codex --version
```

**MELHORIA:** Configure seu `OPENCODE_ROUTER.md` para detectar automaticamente o projeto e sugerir o modo de execução ideal (auto vs ask).

---

### 2. Modo Auto vs Ask Mode

**Skills:**
1. Entender as diferenças entre auto e ask mode
2. Configurar permissões por projeto
3. Usar ask-mode para revisão de código sensível
4. Alternar entre modos dinamicamente

**Código Exemplo:**
```bash
# Modo ask (recomendado para produção)
codex --approval-mode ask "Refatore a função de autenticação"

# Modo auto (para tarefas de baixo risco)
codex --approval-mode auto "Adicione validação de input"

# Configuração no projeto
# .codex/config.json
{
  "approval_mode": "ask",
  "network": false,
  "git_branch_protection": true
}
```

**MELHORIA:** Implemente um agente de review que sempre roda em ask-mode e valida as mudanças antes de commit.

---

### 3. Execução de Tarefas Complexas

**Skills:**
1. Decomposição de tarefas em subtarefas
2. Planejamento multi-etapas
3. Execução sequencial com dependências
4. Rollback em caso de falha

**Código Exemplo:**
```bash
# Tarefa complexa com planejamento
codex "1. Crie um endpoint REST para usuários
2. Adicione validação com Zod
3. Escreva testes unitários
4. Documente com JSDoc"

# Com rollback habilitado
codex --rollback-on-failure "Migre o banco de dados"
```

**MELHORIA:** Crie um workflow de CI/CD que execute o codex em modo ask e submeta as mudanças para review automático.

---

### 4. Edição Multi-Arquivo

**Skills:**
1. Edições coordenadas entre múltiplos arquivos
2. Refatoração de imports e dependências
3. Atualização de configurações relacionadas
4. Manutenção de consistência em grandes codebases

**Código Exemplo:**
```bash
# Refatoração multi-arquivo
codex "Mova a lógica de autenticação de auth.ts para services/auth.ts
e atualize todos os imports nos arquivos que usam"

# Extração de componente
codex "Extraia o formulário de login do Login.tsx
para um componente isolado em components/LoginForm.tsx"
```

**MELHORIA:** Implemente um hook de lint pré-commit que valide se todas as edições multi-arquivo mantêm a consistência de tipos.

---

### 5. Integração com GitHub

**Skills:**
1. Criação automática de Pull Requests
2. Linkagem com Issues existentes
3. Review de PRs com sugestões
4. Gerenciamento de branch protection

**Código Exemplo:**
```bash
# Criar PR diretamente do codex
codex --create-pr "Fix: Corrige bug no cálculo de impostos"
# Automaticamente cria branch, commit, push e PR

# Linkar com issue
codex --link-issue #123 "Implementa a feature descrita na issue"

# Review de PR existente
codex --review-pr 456 "Analise este PR e sugira melhorias"
```

**MELHORIA:** Configure webhooks do GitHub para trigger automático do codex em eventos de issue assignment.

---

### 6. Sandboxing e Segurança

**Skills:**
1. Execução em ambiente isolado
2. Controle de rede (desabilitado por padrão)
3. Permissões de filesystem
4. Validação de comandos perigosos

**Código Exemplo:**
```bash
# Rede desabilitada por padrão
codex --network-disabled "Analise as dependências"

# Controle de filesystem
codex --allowed-paths "./src,./tests" "Escreva testes para o módulo"

# Bloqueio de comandos perigosos
codex --blocked-commands "rm -rf, sudo, chmod 777" "Execute os testes"
```

**MELHORIA:** Crie um wrapper de segurança que filtre automaticamente comandos perigosos antes de enviar ao codex.

---

### 7. Streaming e Output

**Skills:**
1. Streaming de output em tempo real
2. Parse de logs de execução
3. Monitoramento de progresso
4. Integração com ferramentas de logging

**Código Exemplo:**
```bash
# Streaming habilitado
codex --stream "Implemente o módulo de pagamentos"

# Output em formato JSON
codex --output json "Analise este código"

# Redirect para arquivo de log
codex --log-file ./codex-output.log "Refatore o componente"
```

**MELHORIA:** Implemente um parser de streaming que extraia métricas de performance e qualidade das sugestões do codex.

---

### 8. Gerenciamento de Contexto

**Skills:**
1. Inclusão seletiva de arquivos
2. Exclusão de arquivos irrelevantes
3. Contexto de projeto via README
4. Memória de sessão entre chamadas

**Código Exemplo:**
```bash
# Incluir apenas arquivos relevantes
codex --include "./src/**/*.ts" "Adicione tipos genéricos"

# Excluir diretórios desnecessários
codex --exclude "node_modules, dist, .git" "Analise o projeto"

# Contexto via arquivo
codex --context-file ./CONTEXT.md "Implemente conforme especificado"
```

**MELHORIA:** Crie um contexto automático que detecte o framework do projeto e forneça informações relevantes ao codex.

---

### 9. Debugging e Diagnóstico

**Skills:**
1. Identificação de bugs com stack traces
2. Sugestão de fixes baseadas em erros
3. Análise de performance
4. Detecção de code smells

**Código Exemplo:**
```bash
# Debug com stack trace
codex --debug "O endpoint /api/users retorna 500"

# Análise de erro específico
codex --error-file ./error.log "Diagnose este erro"

# Performance
codex --profile "Otimze a query de busca que está lenta"
```

**MELHORIA:** Integre o codex com ferramentas de APM para diagnóstico automático de problemas em produção.

---

### 10. Testes e Validação

**Skills:**
1. Geração automática de testes
2. Coverage analysis
3. Testes de regressão
4. Validação de tipos e interfaces

**Código Exemplo:**
```bash
# Gerar testes unitários
codex "Crie testes unitários para o módulo de validação"

# Testes de integração
codex "Escreva testes de integração para o fluxo de checkout"

# Coverage
codex --coverage-target 80 "Aumente a cobertura de testes"
```

**MELHORIA:** Configure o codex para rodar testes automaticamente após cada edição e reverter se houver falha.

---

### 11. Documentação Automática

**Skills:**
1. Geração de README.md
2. Documentação de API (OpenAPI/Swagger)
3. Comentários JSDoc/TSDoc
4. CHANGELOG automático

**Código Exemplo:**
```bash
# Gerar README
codex "Crie um README.md completo para este projeto"

# Documentação de API
codex --generate-openapi "Documente todos os endpoints REST"

# JSDoc
codex --add-jsdoc "Adicione documentação JSDoc para todas as funções públicas"
```

**MELHORIA:** Implemente um pipeline que gere documentação automaticamente a cada release e publique no GitHub Pages.

---

### 12. Migração e Atualização

**Skills:**
1. Migração de versões de frameworks
2. Atualização de dependências
3. Modernização de código legado
4. Conversão de paradigmas

**Código Exemplo:**
```bash
# Migração de versão
codex "Migre o projeto de React 17 para React 19"

# Atualização de dependências
codex --update-deps "Atualize todas as dependências para últimas versões"

# Modernização
codex "Converta este código de callbacks para async/await"
```

**MELHORIA:** Crie um agente de migração que execute em stages com testes de validação entre cada etapa.

---

### 13. Performance e Otimização

**Skills:**
1. Análise de bundle size
2. Otimização de queries
3. Code splitting automático
4. Memoização e caching

**Código Exemplo:**
```bash
# Bundle analysis
codex --analyze-bundle "Reduza o tamanho do bundle"

# Otimização de queries
codex "Otimize as queries do Prisma que estão N+1"

# Code splitting
codex --code-split "Adicione lazy loading para rotas"
```

**MELHORIA:** Integre com Lighthouse CI para medir impacto real das otimizações sugeridas pelo codex.

---

### 14. Arquitetura e Design Patterns

**Skills:**
1. Sugestão de arquitetura para novos projetos
2. Implementação de design patterns
3. Extração de módulos
4. Dependency injection

**Código Exemplo:**
```bash
# Arquitetura
codex "Sugira uma arquitetura de microsserviços para este monólito"

# Design patterns
codex "Implemente o padrão Repository para acesso a dados"

# Refatoração
codex "Extraia um módulo compartilhado para utils"
```

**MELHORIA:** Crie templates de arquitetura pré-configurados que o codex possa usar como base para diferentes tipos de projetos.

---

### 15. Integração com IDEs e Editores

**Skills:**
1. Plugin para VS Code
2. Integração com Neovim
3. Suporte a JetBrains IDEs
4. CLI avançado para terminal

**Código Exemplo:**
```bash
# VS Code integration
codex --vscode "Configure o extension pack"

# Neovim
codex --neovim "Setup do LSP para codex"

# JetBrains
codex --jetbrains "Configure o plugin para IntelliJ"
```

**MELHORIA:** Desenvolva um wrapper que detecte automaticamente o IDE em uso e configure a integração apropriadamente.

---

### 16. Collaboração em Equipe

**Skills:**
1. Configuração compartilhada de projeto
2. Regras de code review
3. Padrões de commit
4. Templates de PR

**Código Exemplo:**
```bash
# Configuração compartilhada
codex --project-config ./codex.config.json "Analise o projeto"

# Code review rules
codex --review-rules ./REVIEW_RULES.md "Revise este PR"

# Commit conventions
codex --commit-convention conventional "Crie o commit"
```

**MELHORIA:** Implemente um hook de pre-commit que valide se as mudanças seguem os padrões definidos no projeto.

---

### 17. CI/CD e DevOps

**Skills:**
1. Integração com GitHub Actions
2. Pipeline de deploy automático
3. Infraestrutura as Code
4. Monitoramento e alertas

**Código Exemplo:**
```yaml
# GitHub Actions workflow
name: Codex Review
on: [pull_request]
jobs:
  codex-review:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - run: codex --review-pr ${{ github.event.pull_request.number }}
```

**MELHORIA:** Crie um workflow que execute o codex automaticamente em PRs e comente os resultados diretamente no GitHub.

---

### 18. Segurança e Compliance

**Skills:**
1. Auditoria de vulnerabilidades
2. Validação de dependências
3. Secret scanning
4. Compliance de código

**Código Exemplo:**
```bash
# Auditoria de segurança
codex --security-audit "Analise vulnerabilidades no código"

# Secret scanning
codex --scan-secrets "Verifique se há chaves expostas"

# Dependências
codex --check-deps "Valide dependências contra CVEs conhecidos"
```

**MELHORIA:** Configure alertas automáticos quando o codex detectar potenciais vulnerabilidades em dependências.

---

### 19. Analytics e Métricas

**Skills:**
1. Métricas de produtividade
2. Análise de qualidade de código
3. Tracking de melhorias
4. Relatórios de progresso

**Código Exemplo:**
```bash
# Métricas
codex --metrics "Gere relatório de produtividade do mês"

# Qualidade
codex --quality-score "Analise a qualidade do código"

# Progresso
codex --progress "Compare a complexidade antes e depois da refatoração"
```

**MELHORIA:** Implemente um dashboard que visualize métricas de uso do codex e impacto na qualidade do código.

---

### 20. Personalização e Extensão

**Skills:**
1. Customização de prompts
2. Criação de plugins
3. Templates personalizados
4. Integração com sistemas externos

**Código Exemplo:**
```json
// .codex/prompts.json
{
  "review": "Revise o código focando em: segurança, performance, legibilidade",
  "refactor": "Refatore seguindo SOLID e Clean Architecture",
  "test": "Crie testes com cobertura mínima de 80%"
}
```

```bash
# Usar prompt customizado
codex --prompt-file ./codex/prompts/review.md "Analise este módulo"
```

**MELHORIA:** Crie um catálogo de prompts organizado por tipo de tarefa que possa ser compartilhado entre membros da equipe.

---

## 🔧 Boas Práticas

1. **Sempre use ask-mode** para mudanças em código de produção
2. **Valide as sugestões** antes de aplicar em branches principais
3. **Mantenha contexto atualizado** via arquivos CONTEXT.md
4. **Use sandboxing** para proteger seu ambiente de desenvolvimento
5. **Integre com CI/CD** para validação automatizada

---

## 📚 Recursos Adicionais

- **Documentação Oficial**: https://github.com/openai/codex
- **Discord da Comunidade**: https://discord.gg/codex
- **Exemplos de Uso**: https://github.com/openai/codex/examples
- **Changelog**: https://github.com/openai/codex/releases
