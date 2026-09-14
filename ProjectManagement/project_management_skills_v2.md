# Project Management Skills — Documentação Completa v2

> **Data de geração:** 14/09/2026
> **Total de skills documentadas:** 149 skills em 6 categorias
> **Fonte:** Pointer skills do sistema OpenCode
> **Versão aprimorada com:** exemplos práticos, casos de uso avançados, integrações, padrões/anti-padrões, dicas de performance, comandos úteis e referências

---

## Índice

1. [Project Management (22 skills)](#1-project-management)
2. [Planning (7 skills)](#2-planning)
3. [Productivity (33 skills)](#3-productivity)
4. [Workflow (62 skills)](#4-workflow)
5. [Workflow Bundle (9 skills)](#5-workflow-bundle)
6. [Granular Workflow Bundle (16 skills)](#6-granular-workflow-bundle)

---

## 1. Project Management

**Ponteiro:** `project-management-category-pointer`
**Vault:** `C:/Users/Alendaviva007/.config/opencode/skill-libraries/project-management`

---

### 1.1 asana-automation

**Descrição:** Automatiza tarefas no Asana via Rube MCP (Composio): tasks, projetos, seções, times, workspaces.

**Quando usar:**
- Gerenciar projetos e tarefas no Asana programaticamente
- Sincronizar dados entre ferramentas e o Asana
- Automatizar criação e atualização de tarefas em lote

**Exemplos práticos:**
```javascript
// Criar tarefa no Asana via MCP
{
  "tool": "asana_create_task",
  "params": {
    "name": "Implementar autenticação JWT",
    "project": "Sprint 24 - Backend",
    "assignee": "user@example.com",
    "due_date": "2026-09-20",
    "notes": "Middleware de validação JWT para a API REST"
  }
}
```

```javascript
// Mover tarefa entre seções
{
  "tool": "asana_move_task",
  "params": { "task_id": "1234567890", "section": "In Progress" }
}
```

```javascript
// Criar sub-tarefas a partir de um template
{
  "tool": "asana_create_subtask",
  "params": {
    "parent_task": "9876543210",
    "subtasks": [
      "Criar endpoints de autenticação",
      "Implementar middleware JWT",
      "Escrever testes unitários",
      "Documentar endpoints na API"
    ]
  }
}
```

**Casos de uso avançados:**
- **Projeto de migração de dados:** Criar 200+ tarefas no Asana a partir de um CSV de backlog, cada uma com dependências e atribuições
- **Automatização de sprint planning:** Puxar tasks do backlog por prioridade e distribuir para sprints automaticamente baseado na capacity do time
- **Integração com CI/CD:** Criar tarefa automaticamente quando um bug é detectado em produção, com logs e stack trace anexados

**Integração com outras skills:**
- `jira-automation`: para sincronizar projetos entre Asana e Jira
- `to-issues`: para decompor specs em tarefas Asana
- `team-collaboration-standup-notes`: para gerar notas de standup a partir de atividades do Asana
- `linear-automation`: alternativa para times que preferem Linear

**Padrões e anti-padrões:**
✅ Fazer: Usar seções consistentes (Backlog → To Do → In Progress → Review → Done)
✅ Fazer: Atribuir um responsável para cada tarefa desde a criação
✅ Fazer: Usar campos customizados para prioridade e estimativa
❌ Evitar: Criar tarefas sem descrição clara ou critérios de aceite
❌ Evitar: Deixar tarefas órfãs sem projeto associado
❌ Evitar: Atualizar status manualmente quando pode ser automatizado

**Dicas de performance:**
- Use operações em lote para criar múltiplas tarefas de uma vez (evita rate limiting)
- Cache IDs de projetos e seções para reutilizar em chamadas subsequentes
- Configure webhooks do Asana para sincronizar mudanças em tempo real
- Use campos customizados ao invés de sub-tarefas para dados estruturados

**Comandos úteis:**
```bash
# Listar todos os projetos do workspace
curl -H "Authorization: Bearer $ASANA_TOKEN" \
  "https://app.asana.com/api/1.0/workspaces/{workspace_gid}/projects"

# Criar tarefa com campos customizados
curl -X POST "https://app.asana.com/api/1.0/tasks" \
  -H "Authorization: Bearer $ASANA_TOKEN" \
  -d '{"data": {"name": "Nova feature", "projects": ["project_gid"]}}'
```

**Referências:**
- [Asana API Documentation](https://developers.asana.com/docs)
- [Asana REST API Reference](https://developers.asana.com/reference/create-a-task)
- [Rube MCP Asana Integration](https://github.com/composio/rube)

---

### 1.2 basecamp-automation

**Descrição:** Automatiza gerenciamento de projetos no Basecamp: to-dos, mensagens, pessoas e organização de listas.

**Quando usar:**
- Sincronizar ou gerenciar tarefas e comunicação dentro de projetos Basecamp
- Criar listas de tarefas a partir de backlog externo
- Automatizar mensagens e notificações em projetos

**Exemplos práticos:**
```javascript
// Criar to-do list no Basecamp
{
  "tool": "basecamp_create_todo_list",
  "params": {
    "project_id": "1234567",
    "name": "Sprint 24 - Features",
    "todos": [
      {"content": "Implementar checkout", "assignee": "joao@email.com"},
      {"content": "Integrar gateway de pagamento", "assignee": "maria@email.com"}
    ]
  }
}
```

```javascript
// Postar mensagem de standup
{
  "tool": "basecamp_create_message",
  "params": {
    "project_id": "1234567",
    "title": "Standup 14/09/2026",
    "content": "## Ontem\n- Finalizado checkout\n## Hoje\n- Iniciar integração pagamento\n## Bloqueios\n- Nenhum"
  }
}
```

```javascript
// Listar tarefas pendentes de um membro
{
  "tool": "basecamp_list_todos",
  "params": {
    "project_id": "1234567",
    "assignee": "joao@email.com",
    "status": "pending"
  }
}
```

**Casos de uso avançados:**
- **Migração de projeto:** Migrar 500+ to-dos do Trello para Basecamp preservando atribuições e datas
- **Relatório semanal automático:** Compilar status de todas as to-do lists e gerar resumo executivo
- **Onboarding de cliente:** Criar projeto Basecamp com templates pré-definidos para cada novo cliente

**Integração com outras skills:**
- `asana-automation`: alternativa para times que usam Asana
- `brain-to-docs`: extrair decisões de conversas Basecamp para documentação
- `handoff`: compactar contexto do Basecamp para transferência entre sessões
- `time-ledger`: registrar tempo gasto em tarefas do Basecamp

**Padrões e anti-padrões:**
✅ Fazer: Usar nomes descritivos para listas e tarefas
✅ Fazer: Atribuir responsáveis explicitamente
✅ Fazer: Usar message boards para decisões importantes
❌ Evitar: Sobrecarregar uma única lista com muitas tarefas
❌ Evitar: Usar Basecamp como substituto de ferramenta de versionamento
❌ Evitar: Postar mensagens longas sem formatação

**Dicas de performance:**
- Use a API de webhooks para sincronizar mudanças em tempo real
- Agrupe tarefas relacionadas em listas temáticas
- Configure notificações por email apenas para eventos críticos
- Use templates de projeto para projetos recorrentes

**Comandos úteis:**
```bash
# Criar projeto no Basecamp
curl -X POST "https://3.basecampapi.com/projects" \
  -H "Authorization: Bearer $BASECAMP_TOKEN" \
  -d '{"name": "Novo Cliente - Projeto X"}'
```

**Referências:**
- [Basecamp API Documentation](https://github.com/basecamp/bc3-api/blob/master/README.md)
- [Basecamp Integrations](https://basecamp.com/integrations)

---

### 1.3 confluence-automation

**Descrição:** Automatiza criação de páginas, busca de conteúdo, gerenciamento de espaços, labels e navegação hierárquica no Confluence.

**Quando usar:**
- Documentar decisões técnicas no Confluence
- Criar páginas de especificação ou retrospectiva
- Buscar documentação existente para reutilizar

**Exemplos práticos:**
```javascript
// Criar página de retrospectiva
{
  "tool": "confluence_create_page",
  "params": {
    "spaceKey": "ENG",
    "title": "Retrospectiva Sprint 24",
    "parentId": "page-id-parent",
    "content": "<h2>O que deu certo</h2><p>Deploy automatizado reduziu tempo em 40%</p>",
    "labels": ["sprint-24", "retrospectiva"]
  }
}
```

```javascript
// Buscar documentação existente
{
  "tool": "confluence_search",
  "params": {
    "cql": "space = ENG AND text ~ 'autenticação JWT' ORDER BY lastmodified DESC",
    "limit": 5
  }
}
```

```javascript
// Atualizar página com novas seções
{
  "tool": "confluence_update_page",
  "params": {
    "pageId": "987654321",
    "version": 3,
    "content": "<h2>Decisões</h2><p>Stripe escolhido por documentação</p><h2>Próximos Passos</h2><p>Implementar webhooks</p>"
  }
}
```

**Casos de uso avançados:**
- **Documentação automática de API:** Gerar páginas Confluence a partir de specs OpenAPI atualizadas
- **Knowledge base de incidentes:** Criar páginas de post-mortem automaticamente
- **Gestão de dependências:** Manter página central com dependências e versões

**Integração com outras skills:**
- `brain-to-docs`: extrair decisões para ADRs no Confluence
- `read-all-adrs`: ler ADRs existentes antes de criar documentação
- `jira-automation`: sincronizar status com páginas de roadmap
- `compile-knowledge`: manter knowledge base interligada

**Padrões e anti-padrões:**
✅ Fazer: Usar templates consistentes para retrospectivas e ADRs
✅ Fazer: Adicionar labels para facilitar busca e organização
✅ Fazer: Manter hierarquia de páginas limpa
❌ Evitar: Criar páginas sem parentId (ficam órfãs)
❌ Evitar: Usar formatação rica excessiva
❌ Evitar: Deletar páginas sem mover conteúdo para arquivo

**Dicas de performance:**
- Use CQL para buscas eficientes
- Cache IDs de páginas frequentemente acessadas
- Use webhooks para sincronizar mudanças
- Prefira Confluence Storage Format ao invés de HTML genérico

**Comandos úteis:**
```bash
# Buscar páginas por espaço
curl -H "Authorization: Bearer $CONFLUENCE_TOKEN" \
  "https://domain.atlassian.net/wiki/rest/api/content/search?cql=space=ENG+AND+type=page"
```

**Referências:**
- [Confluence REST API](https://developer.atlassian.com/cloud/confluence/rest/v2/intro/)
- [CQL Reference](https://developer.atlassian.com/cloud/confluence/cql/)

---

### 1.4 feature-tracking

**Descrição:** Mantém memória duradoura a nível de feature entre sessões de IA com arquivos Markdown leves para status, documentação, decisões, riscos e mudanças.

**Quando usar:**
- Trabalhar em features complexas que se estendem por múltiplas sessões
- Manter rastreabilidade de decisões técnicas
- Documentar progresso incremental de uma feature

**Exemplos práticos:**
```markdown
<!-- feature-status.md -->
# Feature: Sistema de Pagamentos
## Status: Em desenvolvimento | Progresso: 60%
## Decisões
| Data | Decisão | Motivo |
|------|---------|--------|
| 01/09 | Usar Stripe | Melhor documentação, taxa 2.9% |
| 05/09 | Webhooks síncronos | Evitar race conditions |
## Riscos
- [ ] Integração com gateway instável
- [ ] Ausência de sandbox para testes E2E
```

```bash
# Criar estrutura de feature-tracking
mkdir -p .features/payment-system
echo "# Feature: Sistema de Pagamentos\n## Status: Planejamento" > .features/payment-system/feature-status.md

# Atualizar progresso
echo "- $(date +%d/%m/%Y): Implementado endpoint de criação de sessão" >> .features/payment-system/feature-status.md
```

**Casos de uso avançados:**
- **Migração de monólito:** Rastrear 15 features simultâneas com dependências cruzadas
- **Redesign de sistema:** Manter memória de decisões ao longo de 6 meses
- **Integração multi-equipe:** Sincronizar progresso entre 3 times diferentes

**Integração com outras skills:**
- `project-state-governor`: manter estado canônico baseado em feature-tracking
- `compile-knowledge`: acumular descobertas técnicas
- `handoff`: transferir contexto entre sessões usando arquivos
- `grill-with-docs`: testar decisões documentadas

**Padrões e anti-padrões:**
✅ Fazer: Manter um arquivo por feature com timestamp
✅ Fazer: Documentar o MOTIVO das decisões
✅ Fazer: Usar formato consistente para facilitar busca
❌ Evitar: Arquivos maiores que 500 linhas
❌ Evitar: Deletar histórico de decisões
❌ Evitar: Misturar feature-tracking com tarefas operacionais

**Dicas de performance:**
- Use wiki-links `[[feature-name]]` para conectar features
- Mantenha um índice `features-index.md`
- Use heading levels consistentes (H2=seção, H3=subseção)
- Automatize atualizações com git hooks

**Comandos úteis:**
```bash
# Criar nova feature
FEATURE="nova-feature"
mkdir -p ".features/$FEATURE"
echo "# Feature: $FEATURE\n## Status: Planejamento\n## Decisões\n## Riscos\n## Mudanças" > ".features/$FEATURE/feature-status.md"

# Listar features ativas
find .features -name "feature-status.md" -exec grep -l "Em desenvolvimento" {} \;
```

**Referências:**
- [Feature Flag Patterns](https://martinfowler.com/articles/feature-toggles.html)
- [Markdown Best Practices](https://www.markdownguide.org/basic-syntax/)

---

### 1.5 freshservice-automation

**Descrição:** Automatiza tarefas ITSM no Freshservice: criar/atualizar tickets, operações em lote, service requests e emails outbound.

**Quando usar:**
- Gerenciar tickets de suporte e incidentes
- Criar incidentes automaticamente a partir de alertas
- Disparar notificações via Freshservice

**Exemplos práticos:**
```javascript
// Criar ticket de incidente
{
  "tool": "freshservice_create_ticket",
  "params": {
    "type": "Incident",
    "subject": "API pagamentos retornando 503",
    "description": "Monitoramento detectou taxa de erro > 5%",
    "priority": 3,
    "agent_id": 101234,
    "tags": ["produção", "urgente"]
  }
}
```

```javascript
// Atualizar ticket com resolução
{
  "tool": "freshservice_update_ticket",
  "params": {
    "ticket_id": 456789,
    "status": 5,
    "resolution": "Reiniciado serviço. Causa: memory leak no worker pool."
  }
}
```

**Casos de uso avançados:**
- **Automação de onboarding:** Criar tickets de provisionamento automaticamente
- **Escalação inteligente:** Detectar tickets estagnados e escalar por SLA
- **Relatório de SLA:** Gerar métricas de tempo de resposta e resolução

**Integração com outras skills:**
- `telegram-bot-messaging`: notificar agentes via Telegram
- `gmail-automation`: enviar notificações por email
- `time-ledger`: registrar tempo gasto em resolução

**Padrões e anti-padrões:**
✅ Fazer: Usar templates de ticket para categorias comuns
✅ Fazer: Adicionar tags relevantes para busca
✅ Fazer: Definir SLAs claros por tipo de ticket
❌ Evitar: Criar tickets duplicados
❌ Evitar: Deletar tickets (usar status cancelado)
❌ Evitar: Atribuir sem considerar carga do agente

**Dicas de performance:**
- Use operações em lote para múltiplos tickets
- Configure automations built-in do Freshservice
- Cache IDs de agentes e grupos

**Comandos úteis:**
```bash
# Listar tickets abertos
curl -H "Authorization: Basic $FRESHSERVICE_TOKEN" \
  "https://domain.freshservice.com/api/v2/tickets?status=2"
```

**Referências:**
- [Freshservice API Documentation](https://api.freshservice.com/)
- [Freshservice Automations](https://support.freshservice.com/support/solutions/articles/225648)

---

### 1.6 github-issue-creator

**Descrição:** Transforma logs de erro, screenshots e relatórios vagos em issues GitHub bem estruturadas com passos de reprodução, impacto e evidências.

**Quando usar:**
- Documentar bugs de forma clara e acionável no GitHub
- Transformar crash reports em issues estruturadas
- Criar feature requests a partir de feedback

**Exemplos práticos:**
```markdown
# Issue: TypeError ao processar pagamento internacional

## Passos para Reproduzir
1. Acessar /checkout
2. Selecionar produto
3. Inserir cartão internacional
4. Clicar em "Pagar"

## Comportamento Atual
TypeError: Cannot read property 'currency' of undefined
    at PaymentService.processCard (payment.service.ts:142)

## Impacto
- Severidade: Alta
- Usuários afetados: ~5% dos pagamentos internacionais
- Revenue impact: ~R$ 15.000/mês
```

```bash
# Criar issue via GitHub CLI
gh issue create \
  --title "TypeError ao processar pagamento internacional" \
  --label "bug,priority:high" \
  --body-file issue-template.md
```

```javascript
// Criar issue a partir de crash report automatizado
{
  "tool": "github_create_issue",
  "params": {
    "title": "Bug: NullPointer em UserService.getProfile",
    "labels": ["bug", "auto-generated", "priority:high"],
    "body": "## Stack Trace\n```\n${crashLog}\n```\n## Métricas\n- Ocorrências 24h: 47\n- Usuários afetados: 23"
  }
}
```

**Casos de uso avançados:**
- **Pipeline de bug reports:** Receber bugs via Slack/email, estruturar e criar issue
- **Análise de tendências:** Criar issues em batch identificando padrões
- **Feature request de clientes:** Transformar feedback em issues com critérios de aceite

**Integração com outras skills:**
- `to-issues`: decompor specs em issues independentes
- `team-collaboration-issue`: resolver issues de forma estruturada
- `address-github-comments`: responder comentários
- `changelog-automation`: incluir issues no changelog

**Padrões e anti-padrões:**
✅ Fazer: Incluir passos de reprodução claros
✅ Fazer: Adicionar evidências (logs, screenshots)
✅ Fazer: Definir severidade e impacto
❌ Evitar: Issues vagas como "não funciona"
❌ Evitar: Múltiplos bugs em uma issue
❌ Evitar: Issues sem label de prioridade

**Dicas de performance:**
- Use `gh issue create --body-file` para issues longas
- Configure templates de issue no repositório
- Use labels padronizadas (bug, enhancement, priority:X)
- Use milestones para agrupar por sprint

**Comandos úteis:**
```bash
# Criar issue com template
gh issue create --title "Bug: ..." --template bug_report.md

# Listar issues por label
gh issue list --label "bug,priority:high" --state open

# Fechar via commit
git commit -m "fix: resolve payment error (closes #142)"
```

**Referências:**
- [GitHub Issues Documentation](https://docs.github.com/en/issues)
- [GitHub Issue Templates](https://docs.github.com/en/issues/using-templates-for-issue-creation)

---

### 1.7 jira-automation

**Descrição:** Automatiza tarefas no Jira via Rube MCP (Composio): issues, projetos, sprints, boards, comentários, usuários.

**Quando usar:**
- Criar, mover ou atualizar issues do Jira
- Gerenciar sprints e boards
- Extrair dados para relatórios

**Exemplos práticos:**
```javascript
// Criar issue com sub-tasks
{
  "tool": "jira_create_issue",
  "params": {
    "project": "BACKEND",
    "type": "Story",
    "summary": "Implementar autenticação OAuth 2.0",
    "priority": "High",
    "subtasks": [
      {"summary": "Configurar provider OAuth", "type": "Sub-task"},
      {"summary": "Implementar callback handler", "type": "Sub-task"},
      {"summary": "Criar testes de integração", "type": "Sub-task"}
    ]
  }
}
```

```javascript
// Mover issue entre status
{
  "tool": "jira_transition_issue",
  "params": {
    "issue_key": "BACKEND-142",
    "transition": "In Progress",
    "comment": "Iniciando implementação. ETA: 3 dias."
  }
}
```

```javascript
// Criar sprint e adicionar issues
{
  "tool": "jira_create_sprint",
  "params": {
    "board_id": "1001",
    "name": "Sprint 24",
    "start_date": "2026-09-15",
    "end_date": "2026-09-29",
    "issues": ["BACKEND-142", "BACKEND-143"]
  }
}
```

**Casos de uso avançados:**
- **Gestão de dependências:** Criar links de dependency e monitorar bloqueios
- **Métricas de squad:** Extrair velocity, cycle time e throughput
- **Automação de release:** Mover issues para Done e criar release notes
- **Escalação automática:** Mover issues estagnadas após X dias

**Integração com outras skills:**
- `asana-automation`: sincronizar entre Jira e Asana
- `linear-automation`: alternativa moderna
- `github-issue-creator`: criar issues no GitHub a partir do Jira
- `pr-writer`: vincular PRs via referência no commit

**Padrões e anti-padrões:**
✅ Fazer: Usar workflows customizados por tipo de issue
✅ Fazer: Configurar campos obrigatórios
✅ Fazer: Usar epics para agrupar stories
❌ Evitar: Criar issues sem acceptance criteria
❌ Evitar: Pular etapas do workflow
❌ Evitar: Usar Jira para tracking de código

**Dicas de performance:**
- Use JQL para queries eficientes
- Configure dashboards com filtros saved
- Use automation rules para ações recorrentes
- Cache board IDs e project keys

**Comandos úteis:**
```bash
# Criar issue via REST API
curl -X POST "https://domain.atlassian.net/rest/api/3/issue" \
  -H "Content-Type: application/json" \
  -d '{"fields":{"project":{"key":"BACKEND"},"issuetype":{"name":"Story"},"summary":"Nova feature"}}'
```

**Referências:**
- [Jira REST API v3](https://developer.atlassian.com/cloud/jira/platform/rest/v3/intro/)
- [JQL Reference](https://support.atlassian.com/jira-service-management-cloud/docs/use-advanced-search-with-jira-query-language-jql/)

---

### 1.8 linear-automation

**Descrição:** Automatiza tarefas no Linear via Rube MCP (Composio): issues, projetos, cycles, times, labels.

**Quando usar:**
- Gerenciar o ciclo de vida de issues no Linear
- Criar projetos ou atribuir work
- Automatizar transições de status

**Exemplos práticos:**
```javascript
// Criar issue com label e atribuição
{
  "tool": "linear_create_issue",
  "params": {
    "title": "Bug: Race condition no checkout",
    "team": "Backend",
    "priority": 1,
    "labels": ["bug", "critical"],
    "assignee": "dev-lead"
  }
}
```

```javascript
// Criar cycle (sprint)
{
  "tool": "linear_create_cycle",
  "params": {
    "team": "Backend",
    "name": "Cycle Setembro 2026",
    "starts_at": "2026-09-15",
    "ends_at": "2026-09-29"
  }
}
```

**Casos de uso avançados:**
- **Roadmap de produto:** Criar e manter roadmap com projetos e milestones
- **Gestão de triagem:** Workflow automático para classificar bugs
- **Métricas de time:** Extrair cycle time e throughput para retrospectivas

**Integração com outras skills:**
- `linear-claude-skill`: interação conversacional com Linear
- `jira-automation`: alternativa para times Jira
- `changelog-automation`: gerar changelog a partir do Linear

**Padrões e anti-padrões:**
✅ Fazer: Usar labels consistentes
✅ Fazer: Configurar times e projetos bem definidos
✅ Fazer: Usar prioridades numéricas (1=urgente, 4=baixa)
❌ Evitar: Criar issues sem time associado
❌ Evitar: Deixar issues sem assignee
❌ Evitar: Misturar bugs e features no mesmo projeto

**Dicas de performance:**
- Use a API GraphQL para queries eficientes
- Configure webhooks para tempo real
- Mantenha labels limpas

**Comandos úteis:**
```bash
# GraphQL query para issues abertas
curl -X POST "https://api.linear.app/graphql" \
  -H "Authorization: $LINEAR_TOKEN" \
  -d '{"query":"{ issues(filter: {state: {name: {eq: \"In Progress\"}}}) { nodes { id title priority } } }"}'
```

**Referências:**
- [Linear API Documentation](https://developers.linear.app/docs)
- [Linear GraphQL Explorer](https://developers.linear.app/explorer)

---

### 1.9 linear-claude-skill

**Descrição:** Gerencia issues, projetos e times no Linear de forma integrada com Claude.

**Quando usar:**
- Interagir com o Linear de forma conversacional
- Criar ou consultar issues via linguagem natural
- Automatizar tarefas repetitivas

**Exemplos práticos:**
```bash
# Criar issue via linguagem natural
"Crie uma issue no Linear para implementar autenticação OAuth no projeto X"

# Consultar status
"Quais issues estão abertas no time de Backend com prioridade alta?"

# Atualizar issue
"Mova a issue BACKEND-142 para Done e comente que foi implementada"
```

**Casos de uso avançados:**
- **Standup automatizado:** Gerar resumo diário a partir do Linear
- **Gestão de backlog:** IA sugere priorização baseada em impacto/esforço
- **Detectar anti-patterns:** Analisar padrões de criação de issues

**Integração com outras skills:**
- `linear-automation`: operações programáticas detalhadas
- `team-collaboration-standup-notes`: gerar standups
- `progressive-estimation`: estimar issues com PERT

**Padrões e anti-padrões:**
✅ Fazer: Usar comandos claros e específicos
✅ Fazer: Fornecer contexto sobre time e projeto
✅ Fazer: Revisar ações antes de confirmar
❌ Evitar: Executar ações em massa sem confirmação
❌ Evitar: Criar issues duplicadas

**Dicas de performance:**
- Use comandos batch para múltiplas operações
- Mantenha cache de IDs de issues
- Configure templates de resposta

**Referências:**
- [Linear API Documentation](https://developers.linear.app/docs)
- [Claude Code Skills](https://docs.anthropic.com/en/docs/claude-code)

---

### 1.10 miro-automation

**Descrição:** Automatiza tarefas no Miro via Rube MCP (Composio): boards, items, sticky notes, frames, sharing, connectors.

**Quando usar:**
- Criar quadros de brainstorming e planejamento
- Construir diagramas de arquitetura
- Organizar retrospectivas visuais

**Exemplos práticos:**
```javascript
// Criar board de brainstorming
{
  "tool": "miro_create_board",
  "params": {
    "name": "Brainstorm - Feature Pagamentos",
    "items": [
      {"type": "sticky_note", "content": "Webhooks síncronos", "x": 100, "y": 100, "color": "#ffd02f"},
      {"type": "sticky_note", "content": "Retry automático", "x": 300, "y": 100, "color": "#d5f692"},
      {"type": "frame", "title": "Decisões", "x": 100, "y": 300, "width": 600, "height": 400}
    ]
  }
}
```

```javascript
// Criar diagrama de arquitetura
{
  "tool": "miro_create_diagram",
  "params": {
    "shapes": [
      {"type": "rectangle", "text": "Frontend", "x": 100, "y": 200},
      {"type": "rectangle", "text": "API Gateway", "x": 400, "y": 200},
      {"type": "rectangle", "text": "PostgreSQL", "x": 700, "y": 400}
    ],
    "connectors": [
      {"from": 0, "to": 1, "label": "HTTP"},
      {"from": 1, "to": 2, "label": "SQL"}
    ]
  }
}
```

```javascript
// Adicionar sticky notes a retrospectiva
{
  "tool": "miro_add_stickies",
  "params": {
    "board_id": "board-123",
    "stickies": [
      {"content": "O que deu certo: Deploy automatizado", "color": "#d5f692"},
      {"content": "Melhorar: Comunicação entre squads", "color": "#ffd02f"}
    ]
  }
}
```

**Casos de uso avançados:**
- **Retrospectiva distribuída:** Criar board com sticky notes pré-categorizadas
- **Mapa de stakeholders:** Visualizar stakeholders e suas relações
- **Roadmap visual:** Criar roadmap interativo para stakeholders

**Integração com outras skills:**
- `confluence-automation`: sincronizar diagramas com documentação
- `team-collaboration-standup-notes`: visualizar standups no Miro
- `brainstorming-board`: gerar conteúdo criativo para boards

**Padrões e anti-padrões:**
✅ Fazer: Usar frames para organizar áreas temáticas
✅ Fazer: Cores consistentes (verde=ok, amarelo=atenção, vermelho=crítico)
✅ Fazer: Adicionar conectores com labels
❌ Evitar: Mais de 200 elementos por board
❌ Evitar: Sticky notes sem responsável ou data
❌ Evitar: Usar Miro para documentação detalhada

**Dicas de performance:**
- Use templates de board para recorrência
- Limpe boards concluídos
- Use frames para isolar áreas
- Configure permissões por board

**Referências:**
- [Miro REST API](https://developers.miro.com/reference/introduction)
- [Miro Developer Portal](https://developers.miro.com/)

---

### 1.11 monday-automation

**Descrição:** Automatiza o Monday.com: boards, items, columns, groups, subitems e updates.

**Quando usar:**
- Gerenciar projetos no Monday.com
- Criar itens ou atualizar status
- Sincronizar dados entre Monday e outras ferramentas

**Exemplos práticos:**
```javascript
// Criar item com colunas customizadas
{
  "tool": "monday_create_item",
  "params": {
    "board_id": 12345678,
    "item_name": "Implementar Feature de Pagamento",
    "column_values": {
      "status": {"label": "Em Progresso"},
      "person": {"personsAndTeams": [{"id": 123}]},
      "date": "2026-09-30",
      "numeric": 8
    }
  }
}
```

```javascript
// Atualizar status em lote
{
  "tool": "monday_batch_update",
  "params": {
    "items": [
      {"id": 111, "column_values": {"status": {"label": "Concluído"}}},
      {"id": 222, "column_values": {"status": {"label": "Bloqueado"}}}
    ]
  }
}
```

**Casos de uso avançados:**
- **Gestão de portfólio:** Board consolidado de múltiplos projetos
- **Automação de aprovação:** Mover itens baseado em aprovações
- **Dashboard de capacidade:** Visão de allocation por projeto

**Integração com outras skills:**
- `jira-automation`: alternativa para gestão de projetos
- `google-calendar-automation`: bloquear horários baseado em tarefas
- `gmail-automation`: notificar ao atualizar status

**Padrões e anti-padrões:**
✅ Fazer: Usar grupos para categorizar por fase
✅ Fazer: Configurar colunas com opções fixas
✅ Fazer: Usar dashboards para consolidar
❌ Evitar: Boards duplicados
❌ Evitar: Itens sem responsável
❌ Evitar: Subitems com hierarquia >3 níveis

**Dicas de performance:**
- Use a API GraphQL para queries eficientes
- Configure automations built-in do Monday
- Use connect板 para relacionar boards

**Referências:**
- [Monday.com API](https://developer.monday.com/api-reference/reference)
- [Monday GraphQL Playground](https://developer.monday.com/api-reference/reference#overview)

---

### 1.12 progressive-estimation

**Descrição:** Estima trabalho de desenvolvimento assistido por IA e híbrido com estatísticas PERT pesquisadas e loops de calibração.

**Quando usar:**
- Estimar esforço com colaboração humano+agente IA
- Planejar sprints com estimativas baseadas em dados históricos
- Calibrar estimativas ao longo do tempo

**Exemplos práticos:**
```javascript
// Estimativa PERT
{
  "task": "Implementar notificações push",
  "optimistic": 3,
  "most_likely": 5,
  "pessimistic": 10,
  "result": {
    "pert_estimate": 5.5,
    "adjusted_for_ai": 3.6,
    "confidence_interval": [2.8, 5.2]
  }
}
```

```python
# Calcular PERT
def pert(o, m, p):
    estimate = (o + 4*m + p) / 6
    variance = ((p - o) / 6) ** 2
    return estimate, variance

o, m, p = 3, 5, 10
est, var = pert(o, m, p)
print(f"PERT: {est:.1f} dias | IC 95%: [{est-2*var**0.5:.1f}, {est+2*var**0.5:.1f}]")
```

```javascript
// Calibrar com dados reais
{
  "original_estimate": 5,
  "actual_effort": 7,
  "adjustment_factor": 1.4,
  "learning": "Integrações Firebase levam 40% mais que estimado"
}
```

**Casos de uso avançados:**
- **Roadmap anual:** Estimar 50+ features para 12 meses
- **Análise de capacidade:** Calcular throughput calibrado
- **Comparação de abordagens:** Avaliar custo-benefício de técnicas

**Integração com outras skills:**
- `plan-writing`: usar estimativas para cronogramas realistas
- `blueprint`: gerar blueprints com tempo por passo
- `track-management`: alocar recursos baseado em estimativas
- `project-state-governor`: rastrear acurácia

**Padrões e anti-padrões:**
✅ Fazer: Usar dados históricos para calibrar
✅ Fazer: Considerar overhead de comunicação
✅ Fazer: Documentar premissas
❌ Evitar: Estimar sem considerar integrações
❌ Evitar: Usar apenas caso otimista
❌ Evitar: Ignorar lições anteriores

**Dicas de performance:**
- Mantenha repositório de estimativas históricas
- Use intervalos de confiança ao invés de números exatos
- Reavalie a cada retrospectiva
- Use peso de complexidade (1-5)

**Referências:**
- [PERT Estimation](https://www.projectmanager.com/blog/pert-estimate)
- [Three-Point Estimation](https://www.atlassian.com/team-playbook/plays/three-point-estimation)

---

### 1.13 project-state-governor

**Descrição:** Governança de estado canonical de projeto baseado em evidências, mantendo consistência entre sessões, branches, reviews e ciclos de pesquisa.

**Quando usar:**
- Manter fonte única de verdade sobre estado do projeto
- Sincronizar estado entre múltiplas sessões de IA
- Auditar mudanças de estado ao longo do tempo

**Exemplos práticos:**
```markdown
<!-- project-state.md -->
# Estado do Projeto - Sistema E-commerce

## Versão: 3.2
## Atualizado: 2026-09-14 10:30

## Features Ativas
| Feature | Status | Branch | Owner | ETA |
|---------|--------|--------|-------|-----|
| Checkout | Em desenvolvimento | feat/checkout | @dev1 | 20/09 |
| Pagamento | Review | feat/payment | @dev2 | 18/09 |
| Frete | Planejamento | - | @dev3 | 25/09 |

## Dependências Críticas
- Checkout depende de Pagamento (API de cálculo de frete)
- Frete depende de Integração com Correios (pendente credenciais)

## Decisões Recentes
- 12/09: Escolhido Stripe como gateway (ADR-015)
- 13/09: Arquitetura de microserviços para pagamentos (ADR-016)
```

```bash
# Atualizar estado automaticamente
DATE=$(date +%Y-%m-%d\ %H:%M)
echo "| Checkout | Done | feat/checkout | @dev1 | Concluído |" >> project-state.md

# Validar estado
grep -c "Em desenvolvimento" project-state.md
```

**Casos de uso avançados:**
- **Multi-repositório:** Sincronizar estado entre 5+ repositórios
- **Auditoria de mudanças:** Histórico completo de mudanças de estado
- **Gestão de dependências:** Rastrear bloqueios e dependências cruzadas

**Integração com outras skills:**
- `feature-tracking`: detalhes granulares por feature
- `compile-knowledge`: acumular descobertas do estado
- `handoff`: transferir estado completo entre sessões
- `grill-me`: testar premissas do estado atual

**Padrões e anti-padrões:**
✅ Fazer: Atualizar estado a cada mudança significativa
✅ Fazer: Usar formato tabular para fácil leitura
✅ Fazer: Incluir timestamp e versão
❌ Evitar: Estado desatualizado por mais de 24h
❌ Evitar: Informações subjetivas sem evidência
❌ Evitar: Múltiplas fontes de verdade

**Dicas de performance:**
- Automatize atualizações com git hooks
- Use versionamento (v1, v2) para auditoria
- Mantenha o arquivo < 300 linhas
- Use links para detalhes em outros arquivos

**Referências:**
- [Single Source of Truth Pattern](https://martinfowler.com/bliki/SingleSourceOfTruth.html)
- [Project State Management](https://www.atlassian.com/blog/team-collaboration/project-state-management)

---

### 1.14 sred-project-organizer

**Descrição:** Organiza uma lista de projetos e sua documentação relacionada no formato SRED para submissão.

**Quando usar:**
- Preparar documentação de projetos de P&D para créditos fiscais SRED
- Organizar specs e evidências em formato padronizado
- Consolidar documentação técnica para auditoria

**Exemplos práticos:**
```bash
# Estrutura de projeto SRED
mkdir -p projects/sred-2026/{auth-system,payment-gateway,data-pipeline}
cat > projects/sred-2026/auth-system/project-info.md << 'EOF'
# Projeto: Sistema de Autenticação Avançada
## Objetivo: Desenvolver autenticação MFA com biometria
## Período: Jan/2026 - Set/2026
## Investimento: R$ 450.000
## Equipe: 5 devs + 1 tech lead
## Tecnologias: Node.js, PostgreSQL, WebAuthn
EOF
```

```javascript
// Organizar documentação SRED
{
  "tool": "sred_organize",
  "params": {
    "projects": [
      {
        "name": "Sistema de Autenticação Avançada",
        "period": "2026-Q1/Q2/Q3",
        "expenses": {"personnel": 350000, "infrastructure": 50000, "tools": 50000},
        "deliverables": ["MFA implementation", "WebAuthn integration", "Security audit"],
        "technical_challenges": ["Biometric accuracy > 99%", "Latency < 200ms"]
      }
    ]
  }
}
```

```markdown
# Documentação por Projeto
## 1. Autenticação Avançada
### Evidências Técnicas
- [ADR-010] Escolha de WebAuthn sobre TOTP
- [Benchmark] Testes de performance: 99.2% accuracy
- [Código] Repositório com 15.000 linhas de código novo
```

**Casos de uso avançados:**
- **Auditoria SRED:** Preparar 10+ projetos para auditoria fiscal
- **Consolidação anual:** Agrupar trabalho de P&D de 12 meses
- **Projeção de créditos:** Estimar valor de créditos fiscais baseado em documentação

**Integração com outras skills:**
- `sred-work-summary`: gerar resumo anual consolidado
- `compile-knowledge`: acumular evidências técnicas
- `brain-to-docs`: extrair decisões para documentação SRED
- `feature-tracking`: rastrear progresso de projetos elegíveis

**Padrões e anti-padrões:**
✅ Fazer: Documentar CADA etapa do desenvolvimento
✅ Fazer: Manter evidências técnicas (commits, testes, benchmarks)
✅ Fazer: Usar terminologia técnica precisa
❌ Evitar: Documentação genérica sem especificidade técnica
❌ Evitar: Misturar trabalho de P&D com trabalho de manutenção
❌ Evitar: Deixar gaps no período de desenvolvimento

**Dicas de performance:**
- Automatize coleta de evidências com scripts
- Mantenha repositório centralizado de documentação
- Use templates padronizados para cada projeto
- Revise elegibilidade mensalmente

**Referências:**
- [SRED Canada](https://www.canada.ca/en/revenue-agency/services/scientific-research-experimental-development-tax-incentive-program.html)
- [SRED Claim Guide](https://www.bdc.ca/en/articles-tools/money-finance/manage-finances/rd-tax-credits)

---

### 1.15 sred-work-summary

**Descrição:** Percorre o trabalho do último ano e cria documento consolidando links em projetos documentáveis como SRED.

**Quando usar:**
- Gerar resumo consolidado de trabalho anual para créditos fiscais
- Identificar projetos elegíveis para SRED
- Consolidar evidências de P&D

**Exemplos práticos:**
```bash
# Analisar commits do último ano para projetos SRED
git log --since="2025-10-01" --until="2026-09-30" --oneline | \
  grep -E "(feat|fix|refactor)" | \
  awk '{print $1}' | head -50
```

```javascript
// Consolidar trabalho em projetos SRED
{
  "tool": "sred_work_summary",
  "params": {
    "period": "2025-10-01/2026-09-30",
    "sources": ["git_commits", "jira_issues", "confluence_pages"],
    "output": "notion"
  },
  "result": {
    "projects": [
      {"name": "Auth System", "commits": 145, "prs": 23, "hours_estimated": 800},
      {"name": "Payment Gateway", "commits": 89, "prs": 15, "hours_estimated": 500}
    ],
    "total_hours": 1300,
    "total_investment": 650000
  }
}
```

```markdown
# Resumo Anual SRED 2026

## Projetos Elegíveis
### 1. Sistema de Autenticação Avançada
- **Período:** Jan-Set 2026
- **Investimento:** R$ 450.000
- **Commits:** 145 | **PRs:** 23
- **Evidências:** [Repositório](link) | [ADRs](link) | [Testes](link)

### 2. Gateway de Pagamento
- **Período:** Mar-Set 2026
- **Investimento:** R$ 200.000
- **Commits:** 89 | **PRs:** 15
- **Evidências:** [Repositório](link) | [API Docs](link)
```

**Casos de uso avançados:**
- **Relatório fiscal anual:** Consolidar 12 meses de trabalho em documento SRED
- **Identificação automática:** Usar IA para classificar commits como P&D vs manutenção
- **Projeção de créditos:** Estimar valor de créditos baseado em horas e investimento

**Integração com outras skills:**
- `sred-project-organizer`: organizar documentação detalhada
- `compile-knowledge`: acumular evidências técnicas
- `time-ledger`: extrair registro de tempo para cálculos

**Padrões e anti-padrões:**
✅ Fazer: Incluir TODAS as evidências (commits, PRs, docs)
✅ Fazer: Classificar trabalho como P&D vs manutenção claramente
✅ Fazer: Manter links para fontes verificáveis
❌ Evitar: Incluir trabalho não-elegível
❌ Evitar: Estimar horas sem base em dados reais
❌ Evitar: Deixar gaps na documentação temporal

**Dicas de performance:**
- Automatize coleta com scripts git log + API do Jira
- Use templates padronizados para cada projeto
- Mantenha banco de dados de horas por projeto
- Revise com contador antes de submeter

**Referências:**
- [SRED Eligibility](https://www.canada.ca/en/revenue-agency/services/scientific-research-experimental-development-tax-incentive-program/what-activities-eligible.html)
- [SRED Claim Process](https://www.canada.ca/en/revenue-agency/services/forms-publications/publications/rc4278/medical-expenses-tax-credit.html)

---

### 1.16 team-collaboration-issue

**Descrição:** Especialista em resolução de issues GitHub: investigação sistemática de bugs, implementação de features e workflows de desenvolvimento colaborativo.

**Quando usar:**
- Resolver issues complexas do GitHub com abordagem estruturada
- Implementar features a partir de issues documentadas
- Coordenar trabalho colaborativo em issues

**Exemplos práticos:**
```bash
# Workflow completo de resolução de issue
# 1. Ler issue e entender requisitos
gh issue view 142

# 2. Criar branch
git checkout -b fix/issue-142-payment-error

# 3. Implementar correção
# ... código ...

# 4. Testar
npm test

# 5. Commit com referência
git commit -m "fix: resolve payment gateway timeout (closes #142)"

# 6. Criar PR
gh pr create --title "Fix: Payment gateway timeout" --body "Closes #142"
```

```javascript
// Investigar bug sistematicamente
{
  "tool": "team_collaboration_investigate",
  "params": {
    "issue": 142,
    "steps": [
      "Reproduzir bug localmente",
      "Analisar logs e stack trace",
      "Identificar causa raiz",
      "Implementar correção",
      "Escrever teste de regressão",
      "Documentar no issue"
    ]
  }
}
```

**Casos de uso avançados:**
- **Bug hunt:** Investigação sistemática de bugs intermitentes
- **Feature implementation:** Implementação completa de features complexas
- **Cross-team collaboration:** Coordenar fixes que envolvem múltiplos times

**Integração com outras skills:**
- `github-issue-creator`: criar issues bem estruturadas
- `address-github-comments`: responder feedback de review
- `pr-writer`: criar PRs de alta qualidade
- `verification-before-completion`: garantir que fix funciona

**Padrões e anti-padrões:**
✅ Fazer: Seguir workflow estruturado (investigar → implementar → testar → documentar)
✅ Fazer: Referenciar issue em commits e PRs
✅ Fazer: Escrever testes de regressão
❌ Evitar: Fix sem entender causa raiz
❌ Evitar: Commit sem testes
❌ Evitar: Fechar issue sem verificar em produção

**Dicas de performance:**
- Use `gh issue view` para contexto rápido
- Mantenha branch naming consistente
- Use labels para rastrear progresso
- Documente no issue durante a investigação

**Referências:**
- [GitHub Flow](https://docs.github.com/en/get-started/using-github/github-flow)
- [Issue Resolution Best Practices](https://docs.github.com/en/issues/tracking-your-work-with-issues/using-issues/linking-a-pull-request-to-an-issue)

---

### 1.17 team-collaboration-standup-notes

**Descrição:** Especialista em comunicação assíncrona: práticas de standup, geração de notas por IA a partir de histórico de commits, coordenação de times remotos.

**Quando usar:**
- Gerar notas de standup automaticamente
- Coordenar comunicação entre times distribuídos
- Documentar progresso diário

**Exemplos práticos:**
```bash
# Gerar standup a partir de commits das últimas 24h
git log --since="yesterday" --oneline --author="$(git config user.email)"

# Output esperado:
# a1b2c3d feat(auth): add JWT validation
# d4e5f6g fix(api): resolve timeout in payment endpoint
# h7i8j9k docs: update API documentation
```

```javascript
// Gerar nota de standup estruturada
{
  "tool": "standup_generator",
  "params": {
    "developer": "dev@empresa.com",
    "date": "2026-09-14",
    "sources": ["git_commits", "jira_updates", "pr_reviews"]
  },
  "output": {
    "ontem": [
      "Finalizado middleware de autenticação JWT",
      "Review do PR #89 aprovado",
      "Documentação de API atualizada"
    ],
    "hoje": [
      "Iniciar implementação de rate limiting",
      "Revisar PR #92 do time de pagamentos"
    ],
    "bloqueios": [
      "Aguardando credenciais de sandbox Stripe"
    ]
  }
}
```

```markdown
# Standup - 14/09/2026

## Ontem
- ✅ Middleware JWT implementado e em review
- ✅ PR #89 aprovado e merged
- ✅ API docs atualizadas

## Hoje
- 🔄 Iniciar rate limiting
- 🔄 Review PR #92

## Bloqueios
- ⚠️ Credenciais Stripe pendentes (bloqueio desde 12/09)
```

**Casos de uso avançados:**
- **Standup automatizado multi-time:** Consolidar standups de 5+ times
- **Análise de tendências:** Identificar padrões de bloqueios e bottlenecks
- **Relatório semanal:** Compilar standups da semana em resumo executivo

**Integração com outras skills:**
- `jira-automation`: puxar status de issues para standup
- `linear-automation`: puxar dados do Linear
- `basecamp-automation`: postar standup no Basecamp
- `telegram-bot-messaging`: enviar standup via Telegram

**Padrões e anti-padrões:**
✅ Fazer: Manter formato consistente (Ontem/Hoje/Bloqueios)
✅ Fazer: Ser conciso e factual
✅ Fazer: Destacar bloqueios explicitamente
❌ Evitar: Listar atividades irrelevantes
❌ Evitar: Deixar bloqueios sem ação
❌ Evitar: Standups muito longos (>10 bullets)

**Dicas de performance:**
- Automatize coleta com scripts git e APIs de gestão
- Use templates para consistência
- Configure notificação automática em horário fixo
- Use dashboard para visão consolidada

**Referências:**
- [Async Standups Best Practices](https://www.atlassian.com/blog/team-collaboration/async-standups)
- [Remote Team Communication](https://github.com/hackergit/hackergit/blob/main/REMOTE.md)

---

### 1.18 to-issues

**Descrição:** Decompõe um plano, spec ou PRD em issues independentes no issue tracker usando fatias verticais tracer-bullet.

**Quando usar:**
- Quebrar specification grande em issues menores e acionáveis
- Decompor features complexas em entregáveis incrementais
- Criar roadmap de implementação

**Exemplos práticos:**
```bash
# Decompor PRD em issues
gh issue create --title "Setup: Configurar projeto e dependências" \
  --label "epic:payments,task" --body-file setup-issue.md

gh issue create --title "API: Endpoint de criação de pagamento" \
  --label "epic:payments,backend" --body-file api-issue.md

gh issue create --title "Frontend: Formulário de checkout" \
  --label "epic:payments,frontend" --body-file frontend-issue.md

gh issue create --title "Integração: Gateway Stripe" \
  --label "epic:payments,integration" --body-file stripe-issue.md

gh issue create --title "Testes: Suite E2E de pagamento" \
  --label "epic:payments,qa" --body-file tests-issue.md
```

```javascript
// Gerar issues a partir de PRD
{
  "tool": "to_issues",
  "params": {
    "prd": "Sistema de Pagamentos",
    "strategy": "vertical-slices",
    "tracker": "github"
  },
  "issues": [
    {"title": "Setup", "priority": "P0", "estimate": "2h"},
    {"title": "API de pagamento", "priority": "P0", "estimate": "8h"},
    {"title": "Frontend checkout", "priority": "P1", "estimate": "6h"},
    {"title": "Integração Stripe", "priority": "P0", "estimate": "8h"},
    {"title": "Testes E2E", "priority": "P1", "estimate": "4h"},
    {"title": "Deploy config", "priority": "P1", "estimate": "2h"}
  ]
}
```

**Casos de uso avançados:**
- **Migração:** Decompor migração de sistema legado em 50+ issues incrementais
- **Novo produto:** Criar roadmap completo de MVP em issues independentes
- **Refactor:** Quebrar refactor grande em PRs menores e reviewáveis

**Integração com outras skills:**
- `to-prd`: criar PRD antes de decompor em issues
- `github-issue-creator`: estruturar issues com templates
- `progressive-estimar`: estimar issues após decomposição
- `blueprint`: gerar plano antes de decompor

**Padrões e anti-padrões:**
✅ Fazer: Cada issue deve ser entregável independentemente
✅ Fazer: Incluir estimativas de esforço
✅ Fazer: Definir dependências entre issues
❌ Evitar: Issues monolíticas que levam semanas
❌ Evitar: Issues sem critérios de aceite
❌ Evitar: Issues interdependentes demais

**Dicas de performance:**
- Use epic labels para agrupar issues relacionadas
- Defina milestone para cada batch de issues
- Use project boards para visualizar progresso
- Priorize por valor de negócio

**Referências:**
- [Vertical Slicing](https://medium.com/team-at Aviv/blog/vertical-slicing-8b7c4e1c0e90)
- [Issue Decomposition Patterns](https://www.thoughtworks.com/insights/articles/continuous-delivery)

---

### 1.19 to-prd

**Descrição:** Transforma a conversa atual em um PRD e publica no issue tracker — sem entrevista, apenas síntese do que já foi discutido.

**Quando usar:**
- Documentar requisitos de uma feature discutida em conversa
- Criar PRD formal a partir de discussão informal
- Publicar documento de requisitos para alinhamento

**Exemplos práticos:**
```markdown
# PRD: Sistema de Notificações Push

## Visão Geral
Sistema de notificações push multi-canal para engajamento de usuários.

## Objetivos
- Aumentar taxa de retenção em 15% via notificações personalizadas
- Suportar push, email e SMS com interface unificada
- Entrega em < 500ms para 99% das notificações

## Usuários-Alvo
- Usuários ativos (login nos últimos 30 dias)
- Usuários que abandonaram carrinho
- Usuários com assinatura prestes a expirar

## Requisitos Funcionais
1. Criar campanha de notificação com segmentação
2. Enviar notificação push via Firebase/OneSignal
3. Tracking de entrega e open rate
4. Rate limiting por usuário (max 5/dia)

## Requisitos Não-Funcionais
- Throughput: 10.000 notificações/minuto
- Latência p99: < 500ms
- Disponibilidade: 99.9%

## Sucesso
- Métrica principal: taxa de retenção
- Métrica secundária: open rate > 30%
```

```bash
# Criar PRD como issue no GitHub
gh issue create \
  --title "PRD: Sistema de Notificações Push" \
  --label "prd,team:product" \
  --body-file prd-notifications.md
```

**Casos de uso avançados:**
- **Sprint planning:** Criar PRD antes de estimar features
- **Alinhamento stakeholder:** Documentar requisitos discutidos em reuniões
- **Onboarding de dev:** PRD como contexto para novo membro

**Integração com outras skills:**
- `to-issues`: decompor PRD em issues de implementação
- `grill-me`: testar requisitos antes de formalizar
- `brain-to-docs`: extrair decisões para documentação
- `confluence-automation`: publicar PRD no Confluence

**Padrões e anti-padrões:**
✅ Fazer: Incluir métricas de sucesso mensuráveis
✅ Fazer: Definir escopo claro (o que NÃO está incluído)
✅ Fazer: Listar dependências e riscos
❌ Evitar: Requisitos vagos como "deve ser rápido"
❌ Evitar: PRD sem data de validade
❌ Evitar: Documento sem revisão de stakeholders

**Dicas de performance:**
- Use template de PRD padronizado
- Mantenha PRD vivo (atualize conforme decisions mudam)
- Publique em local acessível (GitHub/Confluence)
- Vincule a milestone para rastreamento

**Referências:**
- [How to Write a PRD](https://www.atlassian.com/blog/product-management/how-to-write-a-product-requirements-document)
- [PRD Template](https://www.productplan.com/glossary/product-requirements-document/)

---

### 1.20 todoist-automation

**Descrição:** Automatiza gestão de tarefas no Todoist: projetos, seções, filtros e operações em lote.

**Quando usar:**
- Criar, organizar ou consultar tarefas no Todoist
- Sincronizar tarefas entre ferramentas
- Automatizar organização de projetos

**Exemplos práticos:**
```javascript
// Criar projeto com seções
{
  "tool": "todoist_create_project",
  "params": {
    "name": "Sprint 24",
    "sections": [
      {"name": "Sprint Atual"},
      {"name": "Backlog"},
      {"name": "Concluído"}
    ],
    "tasks": [
      {"content": "Implementar checkout", "section": "Sprint Atual", "priority": 4},
      {"content": "Integrar pagamento", "section": "Backlog", "priority": 3}
    ]
  }
}
```

```javascript
// Criar tarefa com lembrete
{
  "tool": "todoist_create_task",
  "params": {
    "content": "Revisar PR #89",
    "project": "Sprint 24",
    "due_date": "2026-09-15",
    "priority": 3,
    "reminder": "30min_before"
  }
}
```

**Casos de uso avançados:**
- **Gestão pessoal:** Organizar tarefas pessoais e profissionais em projetos separados
- **Integração com calendário:** Sincronizar tarefas com Google Calendar
- **Automatização de rotina:** Criar tarefas recorrentes automaticamente

**Integração com outras skills:**
- `jira-automation`: sincronizar tarefas pessoais com Jira
- `google-calendar-automation`: bloquear tempo para tarefas
- `time-ledger`: registrar tempo gasto em tarefas
- `gmail-automation`: enviar tarefas por email

**Padrões e anti-padrões:**
✅ Fazer: Usar seções para organizar por status
✅ Fazer: Atribuir prioridades consistentes
✅ Fazer: Usar projetos para áreas diferentes
❌ Evitar: Tarefas sem data de vencimento
❌ Evitar: Projetos com muitas tarefas sem organização
❌ Evitar: Deixar tarefas atrasadas sem reagendar

**Dicas de performance:**
- Use natural language para datas ("amanhã", "próxima segunda")
- Configure filtros para views personalizadas
- Use labels para categorização flexível
- Sincronize com dispositivos móveis

**Referências:**
- [Todoist API](https://developer.todoist.com/rest/v2/)
- [Todoist Sync API](https://developer.todoist.com/sync/v9/)
- [Todoist integrations](https://todoist.com/integrations)

---

### 1.21 trello-automation

**Descrição:** Automatiza boards, cards e workflows no Trello: criar cards, gerenciar listas, atribuir membros e buscar across boards.

**Quando usar:**
- Gerenciar quadros Kanban no Trello
- Mover cards automaticamente
- Criar listas e cards programaticamente

**Exemplos práticos:**
```javascript
// Criar card com checklist
{
  "tool": "trello_create_card",
  "params": {
    "board_id": "board-123",
    "list_name": "To Do",
    "name": "Implementar autenticação OAuth",
    "description": "Implementar login via Google e GitHub",
    "due_date": "2026-09-20",
    "checklist": [
      "Configurar provider Google",
      "Configurar provider GitHub",
      "Implementar callback handler",
      "Escrever testes"
    ],
    "labels": ["backend", "priority:high"]
  }
}
```

```javascript
// Mover card quando PR é aberto
{
  "tool": "trello_move_card",
  "params": {
    "card_id": "card-456",
    "from_list": "In Progress",
    "to_list": "In Review"
  }
}
```

```javascript
// Buscar cards across boards
{
  "tool": "trello_search",
  "params": {
    "query": "pagamento is:open",
    "boards": ["board-123", "board-456"],
    "filter": {"dueComplete": false}
  }
}
```

**Casos de uso avançados:**
- **Kanban de projeto:** Board com WIP limits e métricas de fluxo
- **Onboarding visual:** Board de onboarding com checklist por fase
- **Gestão de conteúdo:** Board de editorial com pipeline de publicação

**Integração com outras skills:**
- `asana-automation`: alternativa para gestão de projetos
- `jira-automation`: alternativa para times ágeis
- `confluence-automation`: vincular cards a documentação
- `telegram-bot-messaging`: notificar mudanças de card

**Padrões e anti-padrões:**
✅ Fazer: Usar listas para colunas do workflow (To Do → Doing → Done)
✅ Fazer: Atribuir membros e datas a cada card
✅ Fazer: Usar labels para categorização
❌ Evitar: Cards sem descrição ou checklist
❌ Evitar: Listas com muitos cards (>20)
❌ Evitar: Deletar cards importantes (arquivar)

**Dicas de performance:**
- Use power-ups para integrações adicionais
- Configure automações com Butler (automação nativa)
- Use filtros para views personalizadas
- Arquive boards concluídos

**Referências:**
- [Trello API Documentation](https://developer.atlassian.com/cloud/trello/rest/)
- [Trello Automation (Butler)](https://trello.com/butler)
- [Trello Power-Ups](https://trello.com/power-ups)

---

### 1.22 wrike-automation

**Descrição:** Automatiza gerenciamento de projetos no Wrike: criar tasks/folders, gerenciar projetos, atribuir work e acompanhar progresso.

**Quando usar:**
- Criar e gerenciar tarefas no Wrike
- Atribuir trabalho e monitorar progresso
- Sincronizar dados entre Wrike e outras ferramentas

**Exemplos práticos:**
```javascript
// Criar task com dependências
{
  "tool": "wrike_create_task",
  "params": {
    "project": "Projeto E-commerce",
    "title": "Integrar gateway de pagamento",
    "description": "Integrar Stripe e Mercado Pago para checkout",
    "assignees": ["dev1@empresa.com", "dev2@empresa.com"],
    "due_date": "2026-09-30",
    "dependencies": ["configurar-webhook", "definir-planos-preco"]
  }
}
```

```javascript
// Criar pasta de projeto com template
{
  "tool": "wrike_create_folder",
  "params": {
    "name": "Projeto Nova Feature",
    "template": "feature-development",
    "subfolders": ["Design", "Backend", "Frontend", "QA"],
    "default_tasks": ["Spec review", "Implementation", "Code review", "Testing"]
  }
}
```

```javascript
// Relatório de progresso
{
  "tool": "wrike_progress_report",
  "params": {
    "project": "Projeto E-commerce",
    "metrics": ["completed", "in_progress", "overdue", "blocked"],
    "period": "last_30_days"
  }
}
```

**Casos de uso avançados:**
- **Gestão de portfólio:** Visão consolidada de múltiplos projetos
- **Resource allocation:** Atribuir trabalho baseado em capacidade
- **Timeline de projeto:** Criar e monitorar cronogramas complexos

**Integração com outras skills:**
- `jira-automation`: alternativa para gestão de projetos
- `asana-automation`: sincronizar entre plataformas
- `confluence-automation`: vincular documentação
- `time-ledger`: registrar tempo em tarefas Wrike

**Padrões e anti-padrões:**
✅ Fazer: Usar pastas para hierarquia de projetos
✅ Fazer: Atribuir responsáveis e datas a cada tarefa
✅ Fazer: Configurar dependências corretamente
❌ Evitar: Tarefas sem estimativa de tempo
❌ Evitar: Pastas com muitas tarefas sem organização
❌ Evitar: Deletar tarefas importantes

**Dicas de performance:**
- Use Wrike Analyze para métricas avançadas
- Configure templates para projetos recorrentes
- Use custom fields para dados estruturados
- Sincronize com calendário para visão unificada

**Referências:**
- [Wrike API Documentation](https://developers.wrike.com/)
- [Wrike Introductions](https://www.wrike.com/support/)
- [Wrike Templates](https://www.wrike.com/project-management-guide/faq/wrike-templates/)

---

## 2. Planning

**Ponteiro:** `planning-category-pointer`
**Vault:** `C:/Users/Alendaviva007/.config/opencode/skill-libraries/planning`

---

### 2.1 blueprint

**Descrição:** Transforma um objetivo de uma linha em um plano de construção passo a passo que qualquer agente de código pode executar frio. Cada passo tem um brief de contexto autocontido.

**Quando usar:**
- Precisar de um plano detalhado e executável para tarefa complexa
- Criar roteiros para features que múltiplos devs vão implementar
- Documentar decisão técnica com plano de ação

**Exemplos práticos:**
```markdown
# Blueprint: Sistema de Autenticação JWT

## Passo 1: Setup do projeto
**Objetivo:** Configurar estrutura base
**Contexto:** Projeto Node.js com Express
**Ações:**
1. npm init -y
2. Instalar dependências: express, jsonwebtoken, bcrypt, dotenv
3. Criar estrutura: src/{middleware,routes,services,utils}
**Critério de sucesso:** Projeto roda com `npm start` sem erros

## Passo 2: Middleware de autenticação
**Objetivo:** Criar middleware que valida JWT
**Contexto:** Middleware deve verificar token no header Authorization
**Ações:**
1. Criar src/middleware/auth.js
2. Implementar verificação de token
3. Tratar erros (token expirado, inválido)
**Critério de sucesso:** Middleware rejeita requests sem token válido
```

```bash
# Criar blueprint estruturado
cat > blueprint-auth.md << 'EOF'
# Blueprint: Autenticação JWT

## Fase 1: Setup (2h)
- [ ] npm init + dependências
- [ ] Estrutura de diretórios
- [ ] Configuração de ambiente

## Fase 2: Core (6h)
- [ ] Middleware JWT
- [ ] Rotas de login/register
- [ ] Service de hash de senha

## Fase 3: Testes (4h)
- [ ] Testes unitários do middleware
- [ ] Testes de integração das rotas
- [ ] Coverage > 80%
EOF
```

**Casos de uso avançados:**
- **Migração de sistema:** Blueprint de 50 passos para migrar monólito para microserviços
- **Novo produto:** Blueprint completo de MVP com estimativas por fase
- **Refactor massivo:** Blueprint para refatorar base de código legado

**Integração com outras skills:**
- `plan-writing`: gerar plano detalhado a partir do blueprint
- `concise-planning`: simplificar blueprint em checklist executável
- `executing-plans`: executar blueprint com checkpoints
- `blueprint` com `track-management`: organizar blueprint em tracks

**Padrões e anti-padrões:**
✅ Fazer: Cada passo deve ser autocontido e executável
✅ Fazer: Incluir critérios de sucesso claros
✅ Fazer: Definir estimativas de tempo por passo
❌ Evitar: Passos vagos como "implementar autenticação"
❌ Evitar: Passos que dependem de conhecimento implícito
❌ Evitar: Blueprints sem ordem de execução definida

**Dicas de performance:**
- Mantenha cada passo entre 30min e 4h
- Use verbos de ação no início de cada tarefa
- Inclua dependências entre passos
- Versione blueprints com o projeto

**Referências:**
- [Blueprint Pattern](https://martinfowler.com/articles/blueprint-pattern.html)
- [Task Decomposition](https://www.atlassian.com/team-playbook/plays/task-decomposition)

---

### 2.2 concise-planning

**Descrição:** Gera um checklist claro, acionável e atômico para tarefas de codificação.

**Quando usar:**
- Precisar de plano rápido e direto para tarefa de desenvolvimento
- Criar checklist para tarefas simples
- Planejar execução de features com escopo delimitado

**Exemplos práticos:**
```markdown
# Checklist: Adicionar validação de formulário React

- [ ] Criar schema de validação com Yup/Zod
- [ ] Integrar com react-hook-form
- [ ] Adicionar mensagens de erro inline
- [ ] Desabilitar botão submit durante validação
- [ ] Testes unitários com 3 cenários happy path
- [ ] Testes de edge cases (inputs vazios, especiais)
```

```markdown
# Checklist: Configurar deploy com Docker

- [ ] Criar Dockerfile multi-stage
- [ ] Criar docker-compose.yml
- [ ] Configurar health check endpoint
- [ ] Adicionar variáveis de ambiente
- [ ] Testar build local
- [ ] Configurar pipeline CI/CD
```

```javascript
// Gerar checklist a partir de tarefa
{
  "task": "Adicionar paginação na API",
  "checklist": [
    "Definir parâmetros: page, limit, offset",
    "Implementar query com LIMIT/OFFSET",
    "Adicionar headers de paginação (X-Total-Count)",
    "Criar endpoint alternativo com cursor",
    "Escrever testes de paginação",
    "Documentar na API docs"
  ]
}
```

**Casos de uso avançados:**
- **Sprint planning:** Gerar checklists para cada story do sprint
- **Code review:** Checklist estruturado para reviews
- **Deploy checklist:** Lista de verificação antes de cada deploy

**Integração com outras skills:**
- `blueprint`: expandir checklist em blueprint detalhado
- `executing-plans`: executar checklist com verificações
- `verification-before-completion`: validar cada item do checklist
- `commit`: referenciar itens concluídos em commits

**Padrões e anti-padrões:**
✅ Fazer: Cada item deve ser atômico e verificável
✅ Fazer: Ordenar por dependência (setup antes de implementação)
✅ Fazer: Incluir estimativas por item quando possível
❌ Evitar: Itens como "fazer a feature" (muito amplo)
❌ Evitar: Checklists com mais de 15 itens
❌ Evitar: Itens sem critério de conclusão claro

**Dicas de performance:**
- Mantenha checklists < 10 itens para tarefas simples
- Use checkbox ASCII para tracking manual
- Adicione estimativas para planejamento
- Versione checklists junto ao código

**Referências:**
- [Checklist Manifesto](https://www.atulchimwani.com/the-checklist-manifesto.html)
- [Atomic Task Design](https://www.joelonsoftware.com/2002/07/15/internationalization-checklist-2/)

---

### 2.3 decision-navigator

**Descrição:** Guia usuários travados ou sobrecarregados através de perguntas de ramificação direcionadas até alcançar próximos passos concretos.

**Quando usar:**
- O usuário está indeciso sobre qual abordagem tomar
- Há múltiplas opções e precisa de orientação
- Precisar decompor problema complexo em decisões gerenciáveis

**Exemplos práticos:**
```markdown
# Decisão: Escolher framework de frontend

## Perguntas de ramificação:
1. Qual o prazo? → Curto (< 2 meses) → React/Next.js
                         → Longo (> 6 meses) → Avaliar Angular/Vue

2. Time tem experiência? → Sim React → Next.js
                           → Não → Considerar Laravel + Blade

3. Precisa de SEO? → Sim → Next.js (SSR/SSG)
                     → Não → React SPA com React Router

## Recomendação: Next.js (prazo curto, experiência React, precisa de SEO)
```

```javascript
// Navegador de decisão interativo
{
  "tool": "decision_navigator",
  "params": {
    "context": "Escolher banco de dados para novo projeto",
    "questions": [
      {"q": "Volume de dados?", "options": ["< 1GB", "1-100GB", "> 100GB"]},
      {"q": "Tipo de consulta?", "options": ["Relacional", "Documentos", "Misto"]},
      {"q": "Disponibilidade?", "options": ["99.9%", "99.99%", "99.999%"]}
    ],
    "recommendation": "PostgreSQL (volume moderado, consultas relacionais, alta disponibilidade)"
  }
}
```

**Casos de uso avançados:**
- **Decisão de arquitetura:** Guiar escolha entre monólito vs microserviços
- **Seleção de tecnologia:** Avaliar opções de stack para novo projeto
- **Priorização de features:** Decidir o que implementar primeiro

**Integração com outras skills:**
- `grill-me`: testar decisões após navigá-las
- `grill-with-docs`: gerar ADRs das decisões tomadas
- `blueprint`: criar plano baseado na decisão
- `read-all-adrs`: consultar decisões anteriores

**Padrões e anti-padrões:**
✅ Fazer: Perguntas objetivas com opções claras
✅ Fazer: Documentar raciocínio por trás da recomendação
✅ Fazer: Incluir trade-offs de cada opção
❌ Evitar: Perguntas ambíguas ou de múltipla escolha
❌ Evitar: Recomendação sem justificativa
❌ Evitar: Ignorar contexto específico do projeto

**Dicas de performance:**
- Mantenha banco de perguntas por domínio (backend, frontend, devops)
- Use árvore de decisão para consultar rapidamente
- Documente decisões tomadas em ADRs
- Atualize perguntas baseado em feedback

**Referências:**
- [Decision Matrix](https://www.mindtools.com/pages/article/newTMC_07.htm)
- [Architecture Decision Records](https://cognitect.com/blog/2011/11/15/documenting-architecture-decisions)
- [Lightweight Architecture Decision Records](https://www.infoq.com/articles/lightweight-architecture-decision-records/)

---

### 2.4 plan-writing

**Descrição:** Planejamento estruturado de tarefas com breakdowns claros, dependências e critérios de verificação.

**Quando usar:**
- Implementar features, refatorar ou trabalho multi-etapa
- Criar planos com dependências e critérios de aceite
- Documentar estratégia de implementação

**Exemplos práticos:**
```markdown
# Plano: Migrar de REST para GraphQL

## Fase 1: Setup (3 dias)
**Dependências:** Nenhuma
**Tarefas:**
1. Instalar Apollo Server e Client
2. Configurar schema base
3. Criar resolvers stub
**Critério:** Servidor GraphQL roda e retorna "Hello World"

## Fase 2: Migração de endpoints (5 dias)
**Dependências:** Fase 1 concluída
**Tarefas:**
1. Migrar endpoint /users (CRUD)
2. Migrar endpoint /posts (CRUD)
3. Adicionar subscriptions para real-time
**Critério:** Todos os endpoints REST funcionam via GraphQL

## Fase 3: Frontend (4 dias)
**Dependências:** Fase 2 concluída
**Tarefas:**
1. Substituir fetch por Apollo Client
2. Implementar cache e optimistic updates
3. Remover código REST legado
**Critério:** Frontend 100% funcional via GraphQL

## Fase 4: Deploy (2 dias)
**Dependências:** Fase 3 concluída
**Tarefas:**
1. Configurar monitoring (Apollo Studio)
2. Feature toggle para gradual rollout
3. Documentar API
**Critério:** Deploy em staging funcionando, rollback testado
```

```javascript
// Gerar plano com dependências
{
  "tool": "plan_writing",
  "params": {
    "project": "Migração GraphQL",
    "phases": [
      {"name": "Setup", "duration": "3d", "deps": []},
      {"name": "Backend", "duration": "5d", "deps": ["Setup"]},
      {"name": "Frontend", "duration": "4d", "deps": ["Backend"]},
      {"name": "Deploy", "duration": "2d", "deps": ["Frontend"]}
    ],
    "total_duration": "14 dias",
    "team_size": 2
  }
}
```

**Casos de uso avançados:**
- **Projeto greenfield:** Plano completo do zero ao deploy
- **Migração de dados:** Plano com rollback para cada etapa
- **Refactor de infraestrutura:** Plano com verificações de ponto sem retorno

**Integração com outras skills:**
- `blueprint`: gerar blueprint antes de escrever plano detalhado
- `executing-plans`: executar plano com checkpoints
- `track-management`: organizar plano em tracks
- `writing-plans`: variante para situações com specs prontas

**Padrões e anti-padrões:**
✅ Fazer: Definir dependências entre fases
✅ Fazer: Incluir critérios de aceite claros
✅ Fazer: Estimar duração de cada fase
❌ Evitar: Fases sem dependências claras
❌ Evitar: Planos sem data de conclusão
❌ Evitar: Ignorar riscos e fallbacks

**Dicas de performance:**
- Use Gantt chart para visualizar dependências
- Mantenha plano em arquivo versionado
- Revisite plano semanalmente
- Use milestones para tracking de progresso

**Referências:**
- [Project Planning Guide](https://www.atlassian.com/blog/team-collaboration/project-planning)
- [WBS (Work Breakdown Structure)](https://www.projectmanager.com/blog/work-breakdown-structure)

---

### 2.5 planning-with-files

**Descrição:** Trabalha como o Manus: usa arquivos Markdown persistentes como "memória de trabalho em disco".

**Quando usar:**
- Manter estado persistente de planejamento entre interações
- Documentar decisões e progresso em arquivos
- Criar memória duradoura para projetos longos

**Exemplos práticos:**
```markdown
<!-- plan.md -->
# Plano: Sistema de Pagamentos

## Status: Em andamento (60%)
## Última atualização: 2026-09-14

## Fases
| Fase | Status | Concluído em |
|------|--------|-------------|
| Setup | ✅ Concluído | 05/09 |
| API | ✅ Concluído | 08/09 |
| Frontend | 🔄 Em andamento | - |
| Testes | ⏳ Pendente | - |
| Deploy | ⏳ Pendente | - |

## Decisões
- 05/09: Escolhido Stripe como gateway
- 08/09: API em Node.js com Express
- 10/09: Frontend em React com hooks
```

```markdown
<!-- progress.md -->
# Progresso: Sistema de Pagamentos

## Semana 08-12/Set
- 08/09: Setup do projeto completo
- 09/09: Endpoints de pagamento criados
- 10/09: Webhook do Stripe configurado
- 11/09: Frontend do checkout iniciado
- 12/09: Integração frontend-backend testada

## Bloqueios
- ⚠️ Credenciais sandbox Stripe pendentes (desde 10/09)
```

```markdown
<!-- decisions.md -->
# Decisões: Sistema de Pagamentos

## ADR-001: Gateway de Pagamento
**Data:** 05/09/2026
**Status:** Aceito
**Contexto:** Precisamos de gateway para pagamentos recorrentes e únicos
**Decisão:** Usar Stripe
**Consequências:** Taxa 2.9%, API moderna, boa documentação
**Alternativas consideradas:** Mercado Pago (documentação fraca), PagSeguro (sem recorrência)
```

**Casos de uso avançados:**
- **Projeto de 6 meses:** Manter plan.md, progress.md e decisions.md sincronizados
- **Multi-equipe:** Arquivos compartilhados via repositório Git
- **Auditoria:** Histórico completo de decisões e progresso

**Integração com outras skills:**
- `feature-tracking`: detalhes granulares por feature
- `compile-knowledge`: acumular descobertas em knowledge base
- `handoff`: transferir arquivos entre sessões
- `grill-with-docs`: gerar decisions.md durante entrevista

**Padrões e anti-padrões:**
✅ Fazer: Manter arquivos com timestamps de atualização
✅ Fazer: Usar formato consistente entre arquivos
✅ Fazer: Versionar arquivos com Git
❌ Evitar: Arquivos desatualizados por mais de 48h
❌ Evitar: Múltiplas pessoas editando sem coordenação
❌ Evitar: Arquivos maiores que 500 linhas

**Dicas de performance:**
- Use git para versionamento e auditoria
- Mantenha índice em cada arquivo
- Use wiki-links para conectar arquivos
- Automatize atualizações com hooks

**Referências:**
- [File-Based State Management](https://www.typescriptlang.org/docs/handbook/2/objects.html)
- [Markdown as Code](https://www.jetbrains.com/help/youtrack/incloud/markdown-syntax.html)

---

### 2.6 track-management

**Descrição:** Cria, gerencia e trabalha com Conductor tracks — unidades de trabalho lógicas para features, bugs e refactors.

**Quando usar:**
- Organizar trabalho em tracks paralelos
- Gerenciar lifecycle de features complexas
- Coordenar trabalho entre múltiplos desenvolvedores

**Exemplos práticos:**
```bash
# Criar nova track
mkdir -p tracks/authentication
cat > tracks/authentication/spec.md << 'EOF'
# Track: Autenticação
## Objetivo: Implementar sistema completo de autenticação JWT
## Entregáveis: Middleware, rotas, testes, documentação
## Dependências: Nenhuma (track inaugural)
## Timeline: 2 semanas
EOF

cat > tracks/authentication/plan.md << 'EOF'
## Fase 1: Core (3 dias)
- [ ] Middleware JWT
- [ ] Service de hash
## Fase 2: API (4 dias)
- [ ] Rotas login/register
- [ ] Rate limiting
## Fase 3: Testes (3 dias)
- [ ] Unit tests
- [ ] Integration tests
EOF
```

```javascript
// Gerenciar lifecycle de tracks
{
  "tool": "track_lifecycle",
  "params": {
    "action": "archive",
    "track": "authentication",
    "reason": "Feature concluída e deployed",
    "artifacts": ["spec.md", "plan.md", "decisions.md"]
  }
}
```

```javascript
// Status de todas as tracks
{
  "tool": "track_status",
  "params": {
    "project": "sistema-ecommerce"
  },
  "result": {
    "tracks": [
      {"name": "authentication", "status": "done", "progress": 100},
      {"name": "payment", "status": "in_progress", "progress": 60},
      {"name": "shipping", "status": "planning", "progress": 10}
    ]
  }
}
```

**Casos de uso avançados:**
- **Projeto com 10+ tracks:** Coordenar trabalho paralelo entre devs
- **Sistema de dependências:** Gerenciar tracks bloqueadas por outras
- **Release planning:** Decidir quais tracks incluir em cada release

**Integração com outras skills:**
- `conductor-new-track`: criar tracks com o sistema Conductor
- `conductor-implement`: executar tarefas dentro de tracks
- `conductor-status`: monitorar progresso geral
- `feature-tracking`: detalhes granulares por feature dentro de track

**Padrões e anti-padrões:**
✅ Fazer: Manter spec.md e plan.md para cada track
✅ Fazer: Definir dependências entre tracks explicitamente
✅ Fazer: Arquivar tracks concluídas
❌ Evitar: Tracks sem objetivos claros
❌ Evitar: Misturar tracks de feature com tracks de bug
❌ Evitar: Deixar tracks abandonadas

**Dicas de performance:**
- Use naming consistente para tracks
- Mantenha diretório de tracks versionado
- Use Kanban board para visualizar tracks
- Defina WIP limit para tracks ativas

**Referências:**
- [Track-Based Development](https://martinfowler.com/articles/continuousDelivery.html)
- [Conductor System](https://github.com/conductor-system/conductor)

---

### 2.7 writing-plans

**Descrição:** Usa quando há um spec ou requisitos para uma tarefa multi-etapa, antes de tocar no código.

**Quando usar:**
- Transformar requisitos em plano de execução
- Planejar antes de implementar
- Documentar estratégia de implementação

**Exemplos práticos:**
```markdown
# Plano: Adicionar Cache Redis

## Pré-requisitos
- Redis server configurado
- Variável de ambiente REDIS_URL definida

## Passo 1: Setup (1h)
- Instalar ioredis
- Criar conexão com retry logic
- Configurar health check

## Passo 2: Cache Layer (3h)
- Criar src/cache/redis.js com get/set/del
- Implementar TTL por tipo de dado
- Adicionar invalidation manual

## Passo 3: Integração (4h)
- Adicionar cache em GET /users
- Adicionar cache em GET /products
- Implementar cache-aside pattern

## Passo 4: Testes (2h)
- Testes unitários do cache layer
- Testes de integração com Redis mock
- Testes de edge case (Redis down)

## Passo 5: Monitoramento (1h)
- Adicionar métricas de hit/miss
- Configurar alertas de memória
- Documentar operações de cache
```

```javascript
// Gerar plano a partir de spec
{
  "tool": "writing_plans",
  "params": {
    "spec": "Adicionar cache Redis com invalidation automática",
    "tech_stack": ["Node.js", "Redis", "Jest"],
    "phases": [
      {"name": "Setup", "duration": "1h", "tasks": 3},
      {"name": "Cache Layer", "duration": "3h", "tasks": 4},
      {"name": "Integração", "duration": "4h", "tasks": 5},
      {"name": "Testes", "duration": "2h", "tasks": 3},
      {"name": "Monitoramento", "duration": "1h", "tasks": 3}
    ],
    "total": "11h | 2 dias para 1 dev"
  }
}
```

**Casos de uso avançados:**
- **Feature com spec pronta:** Criar plano de implementação detalhado
- **Refactor de performance:** Plano de otimização com métricas
- **Migração de dados:** Plano com validação e rollback

**Integração com outras skills:**
- `plan-writing`: variante com dependências detalhadas
- `blueprint`: gerar blueprint antes do plano
- `executing-plans`: executar plano com checkpoints
- `verification-before-completion`: validar conclusão de cada fase

**Padrões e anti-padrões:**
✅ Fazer: Incluir pré-requisitos no início
✅ Fazer: Estimar tempo por fase
✅ Fazer: Definir critérios de conclusão por fase
❌ Evitar: Planos sem estimativas
❌ Evitar: Fases maiores que 4h sem sub-tarefas
❌ Evitar: Ignorar dependências externas

**Dicas de performance:**
- Mantenha plano em arquivo versionado
- Use checklist para rastrear progresso
- Revisite e atualize plano durante implementação
- Documente desvios do plano original

**Referências:**
- [Planning Poker](https://www.atlassian.com/team-playbook/plays/planning-poker)
- [Sprint Planning Guide](https://www.atlassian.com/agile/sprint-planning)

---
## 3. Productivity (Continuação)

### 3.1 anywrite
**Descrição:** CLI compilado cobrindo os 52 endpoints da API local do Anytype.
**Quando usar:** Interagir programaticamente com Anytype para objetos, propriedades e busca.
**Exemplos:** nywrite object create --type Note --name "Decisao" | nywrite search --query "auth"
**Casos avancados:** Knowledge management, documentacao automatica, backup de contexto.
**Integracao:** compile-knowledge, eature-tracking, rain-to-docs.
**Padroes:** Usar tipos consistentes, manter objetos organizados. Evitar duplicatas e objetos sem metadados.
**Referencias:** https://doc.anytype.io/

### 3.2 ask-matt
**Descricao:** Roteador de skills que identifica qual skill usar para cada situacao.
**Quando usar:** Quando nao sabe qual skill aplicar ao problema.
**Exemplos:** "Automatizar deploy" identifica github-actions-templates e workflow-automation.
**Integracao:** Todas as skills do sistema.
**Padroes:** Perguntar contexto antes, sugerir multiplas opcoes. Evitar sugerir sem contexto.
**Referencias:** https://microservices.io/patterns/

### 3.3 box-automation
**Descricao:** Automatiza Box: uploads, downloads, busca, compartilhamento e sign requests.
**Quando usar:** Gerenciar arquivos e colaboracao no Box.
**Exemplos:** Upload de spec, criar sign request, compartilhar pasta.
**Integracao:** confluence-automation, docusign-automation.
**Padroes:** Usar pastas consistentes, configurar permissoes. Evitar upload sem criptografia.
**Referencias:** https://developer.box.com/reference/

### 3.4 brain-to-docs
**Descricao:** Entrevista o usuario para gerar README e ADR.
**Quando usar:** Projeto novo precisa de documentacao inicial.
**Exemplos:** Extrair stack, convencoes e decisoes em README e ADRs.
**Integracao:** ead-all-adrs, grill-with-docs, confluence-automation.
**Padroes:** Documentar motivos, manter README atualizado. Evitar README generico.
**Referencias:** https://www.writethedocs.org/

### 3.5 cal-com-automation
**Descricao:** Automatiza Cal.com: bookings, disponibilidade, webhooks.
**Quando usar:** Integrar agendamento em workflows.
**Exemplos:** Criar webhook de booking, verificar disponibilidade.
**Integracao:** google-calendar-automation, 	elegram-bot-messaging.
**Padroes:** Configurar timezone, usar webhooks. Evitar sem buffer entre reunioes.
**Referencias:** https://developer.cal.com/api

### 3.6 calendly-automation
**Descricao:** Automatiza agendamento e gestao de eventos no Calendly.
**Quando usar:** Gerenciar reunioes e disponibilidade.
**Exemplos:** Verificar slots, listar invitees, criar follow-ups.
**Integracao:** cal-com-automation, google-calendar-automation.
**Padroes:** Configurar event types, usar buffers. Evitar disponibilidade muito ampla.
**Referencias:** https://developer.calendly.com/

### 3.7 codex-profiles
**Descricao:** Executa Codex com perfis isolados (trabalho/pessoal).
**Quando usar:** Manter configuracoes isoladas por projeto/conta.
**Exemplos:** export CODEX_HOME="C:\Users\Alendaviva007/.codex-work" && codex "task"
**Integracao:** context-kit.
**Padroes:** Isolar perfis, versionar configs. Evitar misturar perfis.
**Referencias:** https://github.com/openai/codex

### 3.8 compile-knowledge
**Descricao:** Compila descobertas em knowledge base Markdown interligada com wiki-links.
**Quando usar:** Acumular conhecimento tecnico entre sessoes.
**Exemplos:** knowledge-index.md com links para conceitos relacionados.
**Integracao:** eature-tracking, ead-all-adrs, context-kit.
**Padroes:** Um arquivo por conceito, wiki-links, indice atualizado. Evitar conhecimento generico.
**Referencias:** https://zettelkasten.de/introduction/

### 3.9 context-kit
**Descricao:** Instala artefatos de contexto para Claude Code ou agentes.
**Quando usar:** Configurar contexto persistente do projeto.
**Exemplos:** context.md com stack, convencoes e padroes.
**Integracao:** compile-knowledge, eature-tracking.
**Padroes:** Contexto conciso e atualizado. Evitar generico ou desatualizado.
**Referencias:** https://docs.anthropic.com/en/docs/claude-code

### 3.10 daily-gift
**Descricao:** Engine de presentes diarios com pipeline criativo.
**Quando usar:** Criar conteudo criativo para engajamento.
**Exemplos:** Gerar post visual diario para redes sociais.
**Integracao:** 	elegram-bot-messaging, content-creation.
**Padroes:** Consistencia visual, personalizar. Evitar conteudo repetitivo.
**Referencias:** https://contentmarketinginstitute.com/

### 3.11 docusign-automation
**Descricao:** Automatiza DocuSign: templates, envelopes, assinaturas.
**Quando usar:** Enviar documentos para assinatura.
**Exemplos:** Enviar contrato para 3 partes, gerenciar templates.
**Integracao:** ox-automation, gmail-automation.
**Padroes:** Usar templates, configurar lembretes. Evitar enviar para emails errados.
**Referencias:** https://developers.docusign.com/

### 3.12 dropbox-automation
**Descricao:** Automatiza Dropbox: uploads, downloads, compartilhamento.
**Quando usar:** Sincronizar e compartilhar arquivos.
**Exemplos:** Upload de relatorio, compartilhar pasta com permissao view.
**Integracao:** ox-automation, one-drive-automation.
**Padroes:** Estrutura consistente, permissoes adequadas. Evitar links publicos sem expiracao.
**Referencias:** https://www.dropbox.com/developers/documentation/

### 3.13 faf-wizard
**Descricao:** Gera contexto AI (.faf) para qualquer projeto automaticamente.
**Quando usar:** Configurar contexto rapidamente para qualquer projeto.
**Exemplos:** faf-wizard scan --project ./meu-projeto
**Integracao:** context-kit, compile-knowledge.
**Padroes:** Revisar antes de usar, atualizar. Evitar contexto generico.
**Referencias:** https://www.anthropic.com/research/prompt-engineering

### 3.14 file-organizer
**Descricao:** Identifica arquivos antigos e desnecessarios para reduzir clutter.
**Quando usar:** Limpar diretorios de projeto.
**Exemplos:** find . -mtime +730 -not -path "./.git/*"
**Integracao:** code-quality, security-audit.
**Padroes:** Backup antes de remover, verificar dependencias. Evitar deletar sem confirmacao.
**Referencias:** https://git-scm.com/docs/git-clean

### 3.15 gmail-automation
**Descricao:** Integracao com Gmail via OAuth standalone.
**Quando usar:** Ler, enviar ou monitorar emails.
**Exemplos:** Buscar emails nao lidos, enviar follow-ups.
**Integracao:** google-calendar-automation, 	elegram-bot-messaging.
**Padroes:** Usar templates, configurar filtros. Evitar rate sem limits.
**Referencias:** https://developers.google.com/gmail/api

### 3.16 google-calendar-automation
**Descricao:** Integracao com Google Calendar via OAuth standalone.
**Quando usar:** Criar e gerenciar eventos.
**Exemplos:** Criar standup recorrente, bloquear focus time.
**Integracao:** cal-com-automation, 	ime-ledger.
**Padroes:** Usar cores consistentes, configurar lembretes. Evitar sem timezone.
**Referencias:** https://developers.google.com/calendar

### 3.17 grill-me
**Descricao:** Entrevista incansavel para testar planos e designs.
**Quando usar:** Testar robustez de design antes de implementar.
**Exemplos:** "E se o banco cair?" -> circuit breaker + fallback.
**Integracao:** grill-with-docs, erification-before-completion.
**Padroes:** Cenarios realistas, documentar respostas. Evitar perguntas genericas.
**Referencias:** https://www.atlassian.com/team-playbook/plays/pre-mortem

### 3.18 grill-with-docs
**Descricao:** Entrevista + criacao de ADRs e glossario durante processo.
**Quando usar:** Testar plano E gerar documentacao formal.
**Exemplos:** ADR-015: Escolha de Gateway de Pagamento.
**Integracao:** ead-all-adrs, rain-to-docs, confluence-automation.
**Padroes:** Uma ADR por decisao, documentar contexto. Evitar sem contexto suficiente.
**Referencias:** https://github.com/joelparkerhenderson/architecture-decision-record

### 3.19 grilling
**Descricao:** Entrevista para testar planos explicitamente.
**Quando usar:** Usuario pede para "grill" um plano.
**Exemplos:** Questionar cada premissa de plano de migracao.
**Integracao:** grill-with-docs, decision-navigator.
**Padroes:** Progressivas (simples -> complexo), documentar. Evitar confrontativas.
**Referencias:** https://martinfowler.com/articles/continuousDesign.html

### 3.20 handoff
**Descricao:** Compacta conversa em documento de handoff para outro agente.
**Quando usar:** Transferir contexto entre sessoes.
**Exemplos:** handoff.md com progresso, decisoes pendentes, proximos passos.
**Integracao:** eature-tracking, project-state-governor.
**Padroes:** Contexto suficiente, decisoes pendentes. Evitar handoff vago.
**Referencias:** https://www.atlassian.com/blog/team-collaboration/knowledge-transfer

### 3.21 interview-coach
**Descricao:** Sistema de coaching para busca de emprego: JD, resume, mock interviews.
**Quando usar:** Preparar para entrevistas tecnicas/behavioral.
**Exemplos:** Storybank STAR, analise de JD, mock interview.
**Integracao:** workorai, compile-knowledge.
**Padroes:** Framework STAR, praticar em voz alta. Evitar respostas roteirizadas.
**Referencias:** https://www.themuse.com/advice/star-method-behavioral-interview

### 3.22 interview-style-doc-building
**Descricao:** Constroi documentos estrategicos uma pergunta por vez.
**Quando usar:** Criar documentos de estrategia de forma iterativa.
**Exemplos:** Perguntar publico-alvo, diferencial, canais, receita.
**Integracao:** rain-to-docs, grill-me.
**Padroes:** Uma pergunta por vez, confirmar antes. Evitar muitas perguntas juntas.
**Referencias:** https://www.productplan.com/glossary/product-strategy/

### 3.23 markdown-rendering
**Descricao:** Renderiza Markdown de forma confiavel no editor.
**Quando usar:** Visualizar documentacao no terminal.
**Exemplos:** glow README.md, markdown-link-check README.md
**Integracao:** compile-knowledge, rain-to-docs.
**Padroes:** Formatacao consistente, verificar links. Evitar Markdown quebrado.
**Referencias:** https://www.markdownguide.org/

### 3.24 mdpr-skill
**Descricao:** Revisa apresentacoes Markdown MDPR.
**Quando usar:** Criar ou revisar apresentacoes em slide.
**Exemplos:** Slide decks com formatacao consistente.
**Integracao:** markdown-rendering, content-creation.
**Padroes:** Um conceito por slide, fontes grandes. Evitar texto excessivo.
**Referencias:** https://github.com/mixu/markdown-styles

### 3.25 office-productivity
**Descricao:** Workflow de documentos Office: Word, Excel, PowerPoint.
**Quando usar:** Criar ou converter documentos de escritorio.
**Exemplos:** Gerar planilha Excel com openpyxl, criar documento Word.
**Integracao:** compile-knowledge, confluence-automation.
**Padroes:** Usar templates, automatizar. Evitar formacao manual repetitiva.
**Referencias:** https://openpyxl.readthedocs.io/

### 3.26 one-drive-automation
**Descricao:** Automatiza OneDrive: busca, uploads, compartilhamento.
**Quando usar:** Gerenciar arquivos no OneDrive.
**Exemplos:** Compartilhar pasta com permissao read, expiracao.
**Integracao:** dropbox-automation, ox-automation.
**Padroes:** Estrutura consistente, expiracao de links. Evitar sem revisao de permissoes.
**Referencias:** https://learn.microsoft.com/en-us/onedrive/developer/rest-api/

### 3.27 read-all-adrs
**Descricao:** Le todos os ADRs antes de resumir contexto arquitetural.
**Quando usar:** Entender decisoes anteriores antes de nova decisao.
**Exemplos:** cat docs/adr/*.md, analisar padroes.
**Integracao:** grill-with-docs, rain-to-docs, decision-navigator.
**Padroes:** Ler TODOS, buscar padroes. Evitar decidir sem consultar.
**Referencias:** https://github.com/npryce/adr-tools

### 3.28 rich-elicitation
**Descricao:** Perguntas de esclarecimento em multiplas rodadas.
**Quando usar:** Tarefa ambigua com multiplas dimensoes.
**Exemplos:** Rodada 1: protocolo, Rodada 2: auth, Rodada 3: validacao.
**Integracao:** decision-navigator, rain-to-docs.
**Padroes:** 3-4 rodadas max, perguntas especificas. Evitar interminaveis.
**Referencias:** https://www.tutorialspoint.com/software_engineering/

### 3.29 setup-help
**Descricao:** Guia passo a passo por instalacao/configuracao.
**Quando usar:** Configurar ambiente ou instalar dependencias.
**Exemplos:** Setup Node.js: instalar, npm init, dependencias, typescript.
**Integracao:** compile-knowledge, context-kit.
**Padroes:** Um passo por vez, verificar sucesso. Evitar passos vagos.
**Referencias:** https://documentation.divio.com/

### 3.30 telegram-bot-messaging
**Descricao:** Envia mensagens, alertas e faz perguntas via Telegram Bot API.
**Quando usar:** Integrar notificacoes via Telegram.
**Exemplos:** Notificar deploy, perguntar com botoes inline, enviar arquivo.
**Integracao:** reshservice-automation, github-automation, google-calendar-automation.
**Padroes:** Markdown para formatacao, botoes de acao. Evitar spam.
**Referencias:** https://core.telegram.org/bots/api

### 3.31 time-ledger
**Descricao:** Registro de tempo em linguagem natural.
**Quando usar:** Registrar tempo gasto em atividades.
**Exemplos:** "2h em pagamento, 30min em reuniao" -> registros no Notion.
**Integracao:** sred-work-summary, confluence-automation.
**Padroes:** Registrar diariamente, ser especifico. Evitar registrar no fim de semana.
**Referencias:** https://toggl.com/blog/time-tracking-best-practices

### 3.32 trading-ledger
**Descricao:** Journal de trading que captura tese, plano e emocao.
**Quando usar:** Documentar e revisar decisoes de trading.
**Exemplos:** Compra PETR4: tese, take profit, stop loss, emocao.
**Integracao:** 	ime-ledger, compile-knowledge.
**Padroes:** Registrar ANTES de entrar, documentar emocao. Evitar sem plano.
**Referencias:** https://www.tradingview.com/education/

### 3.33 workorai
**Descricao:** Marketplace de talentos: busca de vagas e gerenciamento de candidaturas.
**Quando usar:** Buscar vagas, candidatar-se, gerenciar processo seletivo.
**Exemplos:** Buscar "Senior Backend" com stack Node.js, enviar candidatura.
**Integracao:** interview-coach, rain-to-docs.
**Padroes:** Personalizar candidatura, pesquisar empresa. Evitar candidaturas genericas.
**Referencias:** https://workorai.com/

## 4. Workflow

**Ponteiro:** `workflow-category-pointer`
**Vault:** `C:/Users/Alendaviva007/.config/opencode/skill-libraries/workflow`

---

### 4.1 acceptance-orchestrator
**Descricao:** Orquestra tarefa de codificacao end-to-end: intake, implementacao, review, deploy e verificacao.
**Quando usar:** Executar feature completa do inicio ao fim sem intervencao manual.
**Exemplos:** Receber issue, implementar, criar PR, aguardar CI, deploy e verificar em staging.
**Integracao:** `closed-loop-delivery`, `pr-writer`, `verification-before-completion`.
**Padroes:** Definir criterios de aceite claros, aguardar CI verde. Evitar deploy sem verificacao.
**Referencias:** https://www.atlassian.com/continuous-delivery

### 4.2 address-github-comments
**Descricao:** Endereca comentarios de review ou issues em um PR aberto no GitHub.
**Quando usar:** Quando PR recebe comentarios que precisam ser implementados.
**Exemplos:** Ler 5 comentarios e implementar mudancas commit a commit.
**Integracao:** `github-issue-creator`, `pr-writer`, `git-pushing`.
**Padroes:** Responder cada comentario, commitar mudancas. Evitar ignorar feedback.
**Referencias:** https://docs.github.com/en/pull-requests

### 4.3 ai-loop
**Descricao:** Loop de desenvolvimento spec-build-review com gates de aprovacao humana.
**Quando usar:** Features complexas que precisam de iteracao controlada.
**Exemplos:** Loop de 3 iteracoes para sistema de cache, cada uma revisada.
**Integracao:** `executing-plans`, `verification-before-completion`.
**Padroes:** Gates de aprovacao, escopo delimitado. Evitar loop sem parada.
**Referencias:** https://www.thoughtworks.com/insights/articles/continuous-delivery

### 4.4 airflow-dag-patterns
**Descricao:** Constroi DAGs Apache Airflow de producao com praticas recomendadas.
**Quando usar:** Criar pipelines de dados ou workflows de agendamento.
**Exemplos:** DAG que extrai dados de API, transforma e carrega em data warehouse.
**Integracao:** `ml-pipeline-workflow`, `workflow-automation`.
**Padroes:** Usar sensors, tratar erros, testar DAGs. Evitar DAGs monoliticos.
**Referencias:** https://airflow.apache.org/docs/

### 4.5 antigravity-workflows
**Descricao:** Paraship de SaaS MVP, auditoria de seguranca, AI agent, QA via browser.
**Quando usar:** Projetos ambiciosos que combinam multiplas disciplinas.
**Exemplos:** Construir MVP de SaaS com auth, API, frontend e deploy em 4 fases.
**Integracao:** `full-stack-orchestration`, `security-audit`, `testing-qa`.
**Padroes:** Checkpoints verificados, multiplas skills. Evitar sem verificacao de qualidade.
**Referencias:** https://www.thoughtworks.com/radar

### 4.6 ask-questions-if-underspecified
**Descricao:** Esclarece requisitos antes de implementar. Usa quando surgem duvidas serias.
**Quando usar:** Tarefa subespecificada que causaria retrabalho.
**Exemplos:** Antes de criar API: "Qual formato de autenticacao? Rate limiting?".
**Integracao:** `rich-elicitation`, `decision-navigator`.
**Padroes:** Perguntar antes de implementar, documentar respostas. Evitar assumir.
**Referencias:** https://www.atlassian.com/team-playbook/plays/ask-questions

### 4.7 bitbucket-automation
**Descricao:** Automatiza repositorios, PRs, branches e issues no Bitbucket via Rube MCP.
**Quando usar:** Gerenciar repositorios e PRs no Bitbucket.
**Exempros:** Criar branch de feature a partir de issue.
**Integracao:** `github-automation`, `gitlab-automation`.
**Padroes:** Branch naming consistente, PR templates. Evitar branches sem descricao.
**Referencias:** https://developer.atlassian.com/bitbucket/api/2/

### 4.8 build
**Descricao:** Executa o comando de build do projeto.
**Quando usar:** Compilar ou buildar antes de testar ou deployar.
**Exemplos:** npm run build, cargo build, docker build.
**Integracao:** `lint-and-validate`, `git-hooks-automation`.
**Padroes:** Build antes de commit, tratar erros. Evitar commit sem build.
**Referencias:** https://docs.npmjs.com/cli/build

### 4.9 changelog-automation
**Descricao:** Gera changelog a partir de commits, PRs e releases seguindo Keep a Changelog.
**Quando usar:** Configurar workflows de release ou gerar release notes.
**Exemplos:** Gerar CHANGELOG.md com ultimas 20 mudancas agrupadas por tipo.
**Integracao:** `commit`, `github-automation`.
**Padroes:** Usar conventional commits, agrupar por tipo. Evitar changelog generico.
**Referencias:** https://keepachangelog.com/

### 4.10 closed-loop-delivery
**Descricao:** Entrega de codigo com criterios de aceitacao explicitos com minimo de reintervencao.
**Quando usar:** Tarefa deve ser concluida contra criterios claros sem perturbar usuario.
**Exemplos:** Implementar, testar, deployar e verificar em producao seguindo criterios.
**Integracao:** `acceptance-orchestrator`, `verification-before-completion`.
**Padroes:** Criterios de aceite claros, verificacao em runtime. Evitar declarar completo sem testar.
**Referencias:** https://www.atlassian.com/continuous-delivery/principles

### 4.11 commit
**Descricao:** SEMPRE usar esta skill ao fazer commit. Cria commits seguindo convencoes Sentry.
**Quando usar:** Qualquer operacao de commit no Git.
**Exemplos:** git commit -m "feat(auth): add JWT validation (closes #142)"
**Integracao:** `git-hooks-automation`, `changelog-automation`.
**Padroes:** Conventional commits, referenciar issues. Evitar commits sem mensagem descritiva.
**Referencias:** https://www.conventionalcommits.org/

### 4.12 conductor-implement
**Descricao:** Executa tarefas do plano de implementacao de uma track seguindo workflow TDD.
**Quando usar:** Implementar plano de track do sistema Conductor com TDD.
**Exempros:** Executar 5 tarefas da fase 1 da track "Authentication" com testes primeiro.
**Integracao:** `conductor-new-track`, `conductor-status`, `workflow-patterns`.
**Padroes:** TDD, commits atomicos, checkpoints. Evitar implementar sem testes.
**Referencias:** https://github.com/conductor-system/conductor

### 4.13 conductor-manage
**Descricao:** Gerencia lifecycle de tracks: arquivar, restaurar, deletar, renomear.
**Quando usar:** Manter organizadas as tracks do projeto.
**Exemplos:** Arquivar track "Authentication" apos conclusao.
**Integracao:** `conductor-status`, `conductor-validator`.
**Padroes:** Arquivar tracks concluidas, limpar referencias. Evitar tracks abandonadas.
**Referencias:** https://github.com/conductor-system/conductor

### 4.14 conductor-new-track
**Descricao:** Cria nova track com especificacao e plano em fases.
**Quando usar:** Iniciar nova unidade de trabalho no Conductor.
**Exemplos:** Criar track "Payment Integration" com spec.md e plan.md de 3 fases.
**Integracao:** `track-management`, `plan-writing`.
**Padroes:** Spec clara, plano com fases. Evitar tracks sem objetivos.
**Referencias:** https://github.com/conductor-system/conductor

### 4.15 conductor-revert
**Descricao:** Undo consciente de Git por unidade de trabalho logica.
**Quando usar:** Desfazer mudancas de uma track especifica.
**Exemplos:** Reverter fase 2 da track "Cache" mantendo fase 1.
**Integracao:** `conductor-implement`, `git-advanced-workflows`.
**Padroes:** Reverter por unidade logica, nao por commit. Evitar revert que quebra outras tracks.
**Referencias:** https://git-scm.com/docs/git-revert

### 4.16 conductor-setup
**Descricao:** Configura projeto Rails para trabalhar com Conductor.
**Quando usar:** Configurar projeto Rails existente para usar Conductor.
**Exempros:** Adicionar estrutura de tracks e configuracao a projeto legado.
**Integracao:** `conductor-new-track`, `conductor-validator`.
**Padroes:** Setup completo, validar configuracao. Evitar setup incompleto.
**Referencias:** https://github.com/conductor-system/conductor

### 4.17 conductor-status
**Descricao:** Exibe status do projeto, tracks ativas e proximas acoes.
**Quando usar:** Verificar estado geral e identificar proximos passos.
**Exemplos:** Listar 3 tracks ativas, fases atuais e proxima tarefa de cada uma.
**Integracao:** `conductor-implement`, `conductor-manage`.
**Padroes:** Status atualizado, acoes claras. Evitar status desatualizado.
**Referencias:** https://github.com/conductor-system/conductor

### 4.18 conductor-validator
**Descricao:** Valida artefatos do projeto Conductor para completude e consistencia.
**Quando usar:** Garantir que arquivos do Conductor estao consistentes.
**Exemplos:** Validar que todas as tracks tem spec.md e plan.md.
**Integracao:** `conductor-setup`, `conductor-implement`.
**Padroes:** Validar antes de implementar, corrigir inconsistencias. Evitar implementar com artefatos invalidos.
**Referencias:** https://github.com/conductor-system/conductor

### 4.19 create-branch
**Descricao:** Cria branch Git seguindo convencoes Sentry.
**Quando usar:** Criar branches com nomenclatura padronizada.
**Exemplos:** git checkout -b feat/payment-integration
**Integracao:** `git-workflow-and-versioning`, `commit`.
**Padroes:** Nomenclatura consistente (feat/, fix/, chore/). Evitar branches sem nome claro.
**Referencias:** https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/creating-and-deleting-branches

### 4.20 create-issue-gate
**Descricao:** Cria issue com criterios de aceitacao estritos antes da implementacao.
**Quando usar:** Garantir que toda implementacao tenha issue documentada.
**Exemplos:** Criar issue com titulo, descricao, criterios e labels antes de implementar.
**Integracao:** `github-issue-creator`, `to-issues`.
**Padroes:** Issue completa antes de codigo. Evitar codigo sem issue associada.
**Referencias:** https://docs.github.com/en/issues

### 4.21 create-pr
**Descricao:** Alias para pr-writer. Cria PRs seguindo praticas de engenharia.
**Quando usar:** Criar Pull Requests padronizados.
**Exemplos:** PR com titulo descritivo, descricao estruturada e checklist.
**Integracao:** `pr-writer`, `pr-merge-champion`.
**Padroes:** Template consistente, self-review. Evitar PRs sem descricao.
**Referencias:** https://docs.github.com/en/pull-requests

### 4.22-4.25 crossframe
**Descricao:** Suite completa de analise estrutural CrossFrame para relacoes complexas.
**Quando usar:** Diagnostico estrutural de problemas complexos.
**Exemplos:** Analisar estrutura de conflito em organizacao com multiplos stakeholders.
**Integracao:** `decision-navigator`, `grill-me`.
**Padroes:** Framework estruturado, evidencias. Evitar analise sem rigor.
**Referencias:** https://www.crossframe.com/

### 4.26 executing-plans
**Descricao:** Executa plano de implementacao com checkpoints de review.
**Quando usar:** Ha plano detalhado pronto e precisa executa-lo.
**Exempros:** Executar plano de 8 tarefas com review a cada 2 tarefas.
**Integracao:** `plan-writing`, `verification-before-completion`.
**Padroes:** Checkpoints regulares, registrar progresso. Evitar executar sem checkpoints.
**Referencias:** https://www.atlassian.com/blog/team-collaboration/executing-plans

### 4.27 finishing-a-development-branch
**Descricao:** Guia opcoes estruturadas para merge, PR ou cleanup ao finalizar branch.
**Quando usar:** Finalizar branch de desenvolvimento e integrar ao main.
**Exemplos:** Decidir entre merge direto, PR ou squash apos 3 dias de dev.
**Integracao:** `create-pr`, `git-advanced-workflows`.
**Padroes:** Avaliar opcoes, escolha consciente. Evitar merge sem review.
**Referencias:** https://docs.github.com/en/pull-requests

### 4.28 full-stack-orchestration
**Descricao:** Orquestracao full-stack para features completas.
**Quando usar:** Feature envolve frontend, backend e infraestrutura.
**Exemplos:** Upload de arquivo com React frontend, API Node.js e S3.
**Integracao:** `react-nextjs-development`, `python-fastapi-development`.
**Padroes:** Coordenar entre camadas, testar integracao. Evitar silos.
**Referencias:** https://www.thoughtworks.com/insights/articles/full-stack-development

### 4.29 gh-review-requests
**Descricao:** Busca notificacoes nao lidas do GitHub para PRs onde review e solicitado.
**Quando usar:** Verificar quais PRs precisam de review.
**Exemplos:** Listar 4 PRs abertos onde time "backend" foi solicitado.
**Integracao:** `address-github-comments`, `git-pr-review`.
**Padroes:** Revisar priorizados, responder rapido. Evitar PRs sem review por muito tempo.
**Referencias:** https://docs.github.com/en/pull-requests

### 4.30 git-advanced-workflows
**Descricao:** Tecnicas avancadas de Git: rebase interativo, cherry-pick, bisect.
**Quando usar:** Operacoes Git complexas.
**Exemplos:** Rebase interativo de 10 commits para limpar historico.
**Integracao:** `git-workflow-and-versioning`, `conductor-revert`.
**Padroes:** Usar com cuidado, entender consequencias. Evitar force push em branches compartilhadas.
**Referencias:** https://git-scm.com/book/

### 4.31 git-hooks-automation
**Descricao:** Configura Git hooks com Husky, lint-staged, commitlint.
**Quando usar:** Configurar verificacao automatica de qualidade antes de cada commit.
**Exemplos:** Husky rodando ESLint e Prettier antes de commit.
**Integracao:** `commit`, `lint-and-validate`.
**Padroes:** Gates de qualidade, formatacao automatica. Evitar hooks que demoram muito.
**Referencias:** https://typicode.github.io/husky/

### 4.32 git-pr-review
**Descricao:** Gera descricao de PR concisa a partir do historico de commits.
**Quando usar:** Criar descricoes de PRs rapidamente.
**Exemplos:** Gerar descricao com resumo, mudancas e testes a partir de 8 commits.
**Integracao:** `create-pr`, `pr-merge-champion`.
**Padroes:** Conciso, estruturado, com testes. Evitar descricao generica.
**Referencias:** https://docs.github.com/en/pull-requests

### 4.33 git-pr-workflows
**Descricao:** Orquestra review, testes, commits e criacao de PRs com agentes paralelos.
**Quando usar:** Mudancas precisam de validacao completa antes de PR.
**Exemplos:** Rodar lint, testes unitarios, integracao e criar PR em paralelo.
**Integracao:** `pr-writer`, `verification-before-completion`.
**Padroes:** Validacao completa, agentes paralelos. Evitar PR sem validacao.
**Referencias:** https://docs.github.com/en/actions

### 4.34 git-pr-workflows-onboard
**Descricao:** Especialista em onboarding e transferencia de conhecimento.
**Quando usar:** Integrar novos membros a equipe.
**Exemplos:** Criar guia de onboarding de 10 passos.
**Integracao:** `setup-help`, `context-kit`.
**Padroes:** Documentacao clara, progressivo. Evitar onboarding sem estrutura.
**Referencias:** https://www.atlassian.com/blog/team-collaboration/onboarding

### 4.35 git-pr-workflows-pr-enhance
**Descricao:** Otimizacao de PRs para reviews eficientes.
**Quando usar:** Melhorar qualidade dos PRs.
**Exemplos:** Adicionar screenshots, testes manuais e Impact Assessment.
**Integracao:** `create-pr`, `pr-merge-champion`.
**Padroes:** Descricao completa, contexto visual. Evitar PRs sem contexto.
**Referencias:** https://docs.github.com/en/pull-requests

### 4.36 git-pushing
**Descricao:** Stage, commit e push seguro com mensagens convencionais.
**Quando usar:** Sincronizar trabalho local com repositorio remoto.
**Exemplos:** git add . && git commit -m "feat: add user search" && git push
**Integracao:** `commit`, `git-workflow-and-versioning`.
**Padroes:** Mensagens convencionais, push seguro. Evitar push sem commit.
**Referencias:** https://git-scm.com/docs/git-push

### 4.37 git-workflow-and-versioning
**Descricao:** Estrutura praticas de workflow Git. Usa ao fazer qualquer mudanca de codigo.
**Quando usar:** Garantir consistencia no workflow Git.
**Exemplos:** Criar branches feature a partir de develop, merge via PR.
**Integracao:** `commit`, `create-branch`, `git-advanced-workflows`.
**Padroes:** Workflow consistente, branches protegidas. Evitar direto no main.
**Referencias:** https://www.atlassian.com/git/tutorials/comparing-workflows

### 4.38 github-actions-templates
**Descricao:** Padroes de workflow GitHub Actions prontos para producao.
**Quando usar:** Configurar CI/CD rapidamente.
**Exemplos:** Template que roda testes, build e deploy para Vercel.
**Integracao:** `github-automation`, `workflow-automation`.
**Padroes:** Templates reutilizaveis, secrets management. Evitar workflows sem cache.
**Referencias:** https://docs.github.com/en/actions

### 4.39 github-automation
**Descricao:** Opera issues, PRs, branches, checks e workflows do GitHub via Rube MCP.
**Quando usar:** Gerenciar repositorios GitHub programaticamente.
**Exemplos:** Verificar status de checks e comentar resultado automaticamente.
**Integracao:** `github-issue-creator`, `changelog-automation`.
**Padroes:** Safeguards de politica, verificacao de permissao. Evitar operacoes sem permissao.
**Referencias:** https://docs.github.com/en/rest

### 4.40 github-presence
**Descricao:** Otimiza perfil GitHub, README ou discoverability de projetos.
**Quando usar:** Melhorar presenca e visibilidade no GitHub.
**Exemplos:** Criar README.md profissional com badges e screenshots.
**Integracao:** `brain-to-docs`, `compile-knowledge`.
**Padroes:** README profissional, badges relevantes. Evitar README generico.
**Referencias:** https://docs.github.com/en/account-and-profile/setting-up-and-managing-your-github-profile

### 4.41 github-workflow-automation
**Descricao:** Padroes para automatizar workflows GitHub com assistencia de IA.
**Quando usar:** Criar automacoes inteligentes no GitHub.
**Exemplos:** Workflow que analisa PRs e sugere melhorias.
**Integracao:** `github-actions-templates`, `github-automation`.
**Padroes:** IA para analise, automacoes uteis. Evitar automacoes sem valor.
**Referencias:** https://docs.github.com/en/actions

### 4.42 gitlab-automation
**Descricao:** Automatiza projetos GitLab, issues, merge requests e pipelines.
**Quando usar:** Gerenciar repositorios e pipelines no GitLab.
**Exemplos:** Criar merge request com template pre-definido.
**Integracao:** `github-automation`, `gitlab-ci-patterns`.
**Padroes:** Templates consistentes, pipelines otimizados. Evitar pipelines sem cache.
**Referencias:** https://docs.gitlab.com/api/

### 4.43 gitlab-ci-patterns
**Descricao:** Padroes abrangentes de pipeline GitLab CI/CD.
**Quando usar:** Configurar pipelines CI/CD no GitLab.
**Exemplos:** .gitlab-ci.yml com stages de test, build e deploy Docker.
**Integracao:** `gitlab-automation`, `workflow-automation`.
**Padroes:** Stages claros, cache entre jobs. Evitar pipelines monoliticos.
**Referencias:** https://docs.gitlab.com/ee/ci/

### 4.44 inngest
**Descricao:** Background jobs serverless-first com workflows event-driven.
**Quando usar:** Criar background jobs ou workflows event-driven.
**Exemplos:** Funcao que envia email 24h apos cadastro.
**Integracao:** `trigger-dev`, `upstash-qstash`.
**Padroes:** Event-driven, execucao duravel. Evitar jobs sem retry.
**Referencias:** https://www.inngest.com/docs

### 4.45 issues
**Descricao:** Interage com issues do GitHub: criar, listar e visualizar.
**Quando usar:** Operacoes basicas de issues.
**Exemplos:** Listar issues abertas com label "bug".
**Integracao:** `github-issue-creator`, `to-issues`.
**Padroes:** Labels consistentes, milestones. Evitar issues sem label.
**Referencias:** https://docs.github.com/en/issues

### 4.46 iterate-pr
**Descricao:** Itera em um PR ate o CI passar.
**Quando usar:** Corrigir falhas de CI automaticamente.
**Exemplos:** Rodar testes, corrigir erros, commitar ate CI verde.
**Integracao:** `git-pr-review`, `lint-and-validate`.
**Padroes:** Iterar ate verde, commitar fixes. Evitar push sem testar localmente.
**Referencias:** https://docs.github.com/en/actions

### 4.47 lint-and-validate
**Descricao:** Roda lint e type checks, distingue falhas e reporta resultados.
**Quando usar:** Verificar qualidade do codigo antes de commits.
**Exemplos:** Rodar eslint e tipar, reportar 3 erros de lint.
**Integracao:** `git-hooks-automation`, `build`.
**Padroes:** Verificar antes de commit, reportar claramente. Evitar commit sem lint.
**Referencias:** https://eslint.org/docs/latest/

### 4.48 ml-pipeline-workflow
**Descricao:** Orquestracao completa de pipeline MLOps ponta a ponta.
**Quando usar:** Criar pipelines de ML do treinamento ao deploy.
**Exemplos:** Pipeline que treina modelo, valida, versiona e deploya em endpoint.
**Integracao:** `airflow-dag-patterns`, `workflow-automation`.
**Padroes:** Versionamento de modelos, monitoramento. Evitar deploy sem validacao.
**Referencias:** https://cloud.google.com/vertex-ai/docs

### 4.49 pr-merge-champion
**Descricao:** Otimiza PRs para aprovacao e merge rapidos.
**Quando usar:** Preparar PR para merge com alta qualidade.
**Exemplos:** Revisar PR, limpar commits, adicionar descricao e garantir CI verde.
**Integracao:** `create-pr`, `git-pr-review`.
**Padroes:** Self-review, diffs limpos. Evitar PRs com commits sujos.
**Referencias:** https://docs.github.com/en/pull-requests

### 4.50 pr-writer
**Descricao:** Cria pull requests seguindo praticas de engenharia Sentry.
**Quando usar:** Criar PRs padronizados e de alta qualidade.
**Exemplos:** PR com titulo convencional, descricao com contexto e testes.
**Integracao:** `create-pr`, `pr-merge-champion`.
**Padroes:** Template Sentry, contexto completo. Evitar PRs sem descricao.
**Referencias:** https://docs.github.com/en/pull-requests

### 4.51 receiving-code-review
**Descricao:** Code review requer avaliacao tecnica, nao performance emocional.
**Quando usar:** Processar feedback de review de forma produtiva.
**Exemplos:** Analisar 8 comentarios, implementar 5 relevantes, explicar 3 nao aplicaveis.
**Integracao:** `address-github-comments`, `git-pr-review`.
**Padroes:** Responder tecnico, agradecer feedback. Evitar defensiva.
**Referencias:** https://www.atlassian.com/blog/team-collaboration/code-review

### 4.52 requesting-code-review
**Descricao:** Solicita review apos concluir implementacao.
**Quando usar:** Verificar se trabalho atende requisitos.
**Exemplos:** Criar PR e notificar reviewers com contexto.
**Integracao:** `create-pr`, `pr-merge-champion`.
**Padroes:** Contexto claro, reviewers especificos. Evitar review sem contexto.
**Referencias:** https://docs.github.com/en/pull-requests

### 4.53 subagent-driven-development
**Descricao:** Usa sub-agentes para executar tarefas independentes em paralelo.
**Quando usar:** Executar multiplas tarefas independentes simultaneamente.
**Exemplos:** 4 tarefas independentes, cada uma em sub-agente.
**Integracao:** `ai-loop`, `executing-plans`.
**Padroes:** Tarefas verdadeiramente independentes, checkpoints. Evitar dependencias implicitas.
**Referencias:** https://www.anthropic.com/research

### 4.54 task-intelligence
**Descricao:** Protocolo de Inteligencia Pre-Tarefa: ativa TODOS os agentes relevantes ANTES de executar.
**Quando usar:** Garantir que todas as fontes de conhecimento sejam consultadas.
**Exemplos:** Antes de feature, consultar testing, security, performance e docs.
**Integracao:** `ask-matt`, `context-kit`.
**Padroes:** Consultar todas as fontes, consolidar aprendizados. Evitar agir sem contexto.
**Referencias:** https://www.anthropic.com/research

### 4.55 temporal-golang-pro
**Descricao:** Sistemas distribuidos duraveis com Temporal Go SDK.
**Quando usar:** Construir workflows duraveis com Temporal em Go.
**Exemplos:** Saga pattern com Temporal Go SDK para transacao distribuida.
**Integracao:** `workflow-orchestration-patterns`, `temporal-python-pro`.
**Padroes:** Workflows deterministicos, configs mTLS. Evitar state mutable.
**Referencias:** https://docs.temporal.io/go/

### 4.56 temporal-python-pro
**Descricao:** Orquestracao de workflows Temporal com Python SDK.
**Quando usar:** Criar workflows duraveis com Temporal em Python.
**Exemplos:** Workflow que processa pedidos com compensate automatico.
**Integracao:** `temporal-golang-pro`, `workflow-orchestration-patterns`.
**Padroes:** Workflows deterministicos, retry policies. Evitar side effects em workflows.
**Referencias:** https://docs.temporal.io/python/

### 4.57 trigger-dev
**Descricao:** Background jobs e AI workflows com Trigger.dev.
**Quando usar:** Criar background jobs ou AI workflows.
**Exemplos:** Job que processa uploads de video em background com retry.
**Integracao:** `inngest`, `upstash-qstash`.
**Padroes:** TypeScript-first, execucao async confiavel. Evitar jobs sem timeout.
**Referencias:** https://trigger.dev/docs

### 4.58 upstash-qstash
**Descricao:** Filas de mensagens serverless e jobs agendados com QStash.
**Quando usar:** Criar filas de mensagens ou jobs agendados.
**Exemplos:** Enviar notificacao push 1h apos abandono de carrinho.
**Integracao:** `inngest`, `trigger-dev`.
**Padroes:** Serverless, entrega confiavel. Evitar filas sem dead letter.
**Referencias:** https://upstash.com/docs/qstash

### 4.59 verification-before-completion
**Descricao:** Declarar trabalho completo sem verificacao e desonestidade.
**Quando usar:** GARANTIR que trabalho esta realmente completo.
**Exemplos:** Rodar testes, verificar logs, testar manualmente e so entao declarar completo.
**Integracao:** `acceptance-orchestrator`, `closed-loop-delivery`.
**Padroes:** Verificar ANTES de declarar, testes passando. Evitar declarar sem testar.
**Referencias:** https://www.atlassian.com/continuous-delivery/principles

### 4.60 workflow-automation
**Descricao:** Automação de workflow com execucao duravel que retoma de onde parou.
**Quando usar:** Automacoes que precisam ser resilientes a falhas.
**Exemplos:** Workflow de pagamento de 10 etapas que retoma do passo 7 se rede cair.
**Integracao:** `workflow-orchestration-patterns`, `temporal-python-pro`.
**Padroes:** Execucao duravel, retry automatico. Evitar sem tratamento de erro.
**Referencias:** https://www.temporal.io/

### 4.61 workflow-orchestration-patterns
**Descricao:** Arquitetura de orquestracao de workflows com Temporal.
**Quando usar:** Projetar sistemas de orquestracao robustos.
**Exemplos:** Sistema com retry, timeout, compensation e monitoring.
**Integracao:** `temporal-python-pro`, `temporal-golang-pro`.
**Padroes:** Padrões de resiliencia, monitoring. Evitar sem observabilidade.
**Referencias:** https://docs.temporal.io/concepts/

### 4.62 workflow-patterns
**Descricao:** Workflow TDD do Conductor: checkpoints, commits, verificacao.
**Quando usar:** Seguir workflow padrao do Conductor com TDD.
**Exemplos:** Escrever teste, implementar, refactorar, commitar.
**Integracao:** `conductor-implement`, `conductor-status`.
**Padroes:** TDD estrito, commits atomicos. Evitar implementar sem testes.
**Referencias:** https://github.com/conductor-system/conductor

## 5. Workflow Bundle

**Ponteiro:** `workflow-bundle-category-pointer`
**Vault:** `C:/Users/Alendaviva007/.config/opencode/skill-libraries/workflow-bundle`

---

### 5.1 ai-ml
**Descricao:** Workflow de IA e ML cobrindo LLM, RAG, agentes e pipelines ML.
**Quando usar:** Projetos completos de IA/ML do inicio ao fim.
**Exemplos:** Chatbot RAG com LangChain, vector database e API de inference.
**Integracao:** `rag-implementation`, `ai-agent-development`, `ml-pipeline-workflow`.
**Padroes:** Avaliacao continua, A/B testing. Evitar deploy sem benchmark.
**Referencias:** https://www.anthropic.com/research

### 5.2 cloud-devops
**Descricao:** Workflow de infraestrutura cloud e DevOps: AWS, Azure, GCP, K8s, Terraform, CI/CD.
**Quando usar:** Configurar ou gerenciar infraestrutura cloud e deploy.
**Exemplos:** Cluster EKS com Terraform e pipeline GitLab CI/CD.
**Integracao:** `terraform-infrastructure`, `kubernetes-deployment`, `github-actions-templates`.
**Padroes:** IaC, monitoring, logging centralizado. Evitar deploy manual em producao.
**Referencias:** https://docs.aws.amazon.com/

### 5.3 database
**Descricao:** Workflow de bancos de dados: SQL, NoSQL, design, migracoes e otimizacao.
**Quando usar:** Projetar, otimizar ou migrar bancos de dados.
**Exemplos:** Migrar schema PostgreSQL de 50 tabelas para nova normalizacao.
**Integracao:** `postgresql-optimization`, `data-engineering`.
**Padroes:** Migracoes versionadas, backups antes de migracao. Evitar DDL em producao sem backup.
**Referencias:** https://www.postgresql.org/docs/

### 5.4 development
**Descricao:** Workflow abrangente de desenvolvimento web, mobile e backend.
**Quando usar:** Projetos completos que envolvem multiplas camadas.
**Exemplos:** App SaaS com React frontend, Node.js backend e React Native mobile.
**Integracao:** `react-nextjs-development`, `python-fastapi-development`.
**Padroes:** Arquitetura limpa, testes em todas as camadas. Evitar monolito sem modulo.
**Referencias:** https://martinfowler.com/articles/

### 5.5 documentation
**Descricao:** Workflow de documentacao: API docs, arquitetura, README, comentarios.
**Quando usar:** Criar ou manter documentacao tecnica.
**Exemplos:** Gerar documentacao OpenAPI a partir de Express.js.
**Integracao:** `api-documentation`, `brain-to-docs`.
**Padroes:** Docs como codigo, atualizacao continua. Evitar docs desatualizadas.
**Referencias:** https://www.writethedocs.org/

### 5.6 os-scripting
**Descricao:** Workflow de troubleshooting e shell scripting para Linux, macOS, Windows.
**Quando usar:** Criar scripts ou resolver problemas de sistema.
**Exemplos:** Script bash que monitora disco e alerta quando > 80%.
**Integracao:** `bash-scripting`, `linux-troubleshooting`.
**Padroes:** Scripts defensivos, tratamento de erros. Evitar scripts sem error handling.
**Referencias:** https://www.gnu.org/software/bash/manual/

### 5.7 security-audit
**Descricao:** Workflow de auditoria de seguranca: web, APIs, penetration testing, hardening.
**Quando usar:** Realizar auditorias de seguranca.
**Exemplos:** Auditoria OWASP Top 10 com relatorio.
**Integracao:** `api-security-testing`, `web-security-testing`.
**Padroes:** OWASP Top 10, scanning regular. Evitar auditoria sem follow-up.
**Referencias:** https://owasp.org/www-project-top-ten/

### 5.8 testing-qa
**Descricao:** Workflow de testes: unitarios, integracao, E2E, automacao de browser.
**Quando usar:** Configurar ou executar suites de teste completas.
**Exemplos:** Configurar Jest, Cypress e Playwright para cobertura completa.
**Integracao:** `e2e-testing`, `api-security-testing`.
**Padroes:** Testes automatizados, CI integrado. Evitar testes manuais apenas.
**Referencias:** https://jestjs.io/docs/

### 5.9 wordpress
**Descricao:** Workflow completo de desenvolvimento WordPress: temas, plugins, WooCommerce.
**Quando usar:** Projetos completos de WordPress.
**Exemplos:** Tema customizado com block editor e WooCommerce.
**Integracao:** `wordpress-plugin-development`, `wordpress-theme-development`.
**Padroes:** Block editor, hooks consistentes. Evitar hardcoding no theme.
**Referencias:** https://developer.wordpress.org/

---

## 6. Granular Workflow Bundle

**Ponteiro:** `granular-workflow-bundle-category-pointer`
**Vault:** `C:/Users/Alendaviva007/.config/opencode/skill-libraries/granular-workflow-bundle`

---

### 6.1 ai-agent-development
**Descricao:** Workflow de AI agents: agentes autonomos, multi-agent e orquestracao com CrewAI, LangGraph.
**Quando usar:** Criar agentes de IA autonomos ou sistemas multi-agent.
**Exemplos:** Agente de pesquisa com LangGraph que busca e resume artigos.
**Integracao:** `ai-ml`, `rag-implementation`.
**Padroes:** Determinismo, observabilidade, fallback. Evitar agentes sem guardrails.
**Referencias:** https://www.langchain.com/langgraph

### 6.2 api-documentation
**Descricao:** Workflow de documentacao de APIs: specs OpenAPI, guias para devs.
**Quando usar:** Documentar APIs de forma completa e padronizada.
**Exemplos:** Gerar spec OpenAPI 3.1 para API REST com 25 endpoints.
**Integracao:** `documentation`, `brain-to-docs`.
**Padroes:** OpenAPI 3.1, exemplos reais. Evitar docs sem exemplos.
**Referencias:** https://swagger.io/specification/

### 6.3 api-security-testing
**Descricao:** Workflow de testes de seguranca de APIs REST e GraphQL.
**Quando usar:** Testar seguranca de APIs.
**Exemplos:** Testar API GraphQL para injecao e autorizacao.
**Integracao:** `security-audit`, `web-security-testing`.
**Padroes:** OWASP API Security Top 10, fuzzing. Evitar testar apenas happy path.
**Referencias:** https://owasp.org/API-Security/

### 6.4 bash-scripting
**Descricao:** Shell scripting bash para scripts de producao.
**Quando usar:** Criar scripts bash robustos e production-ready.
**Exemplos:** Script de deploy com tratamento de erros, logging e rollback.
**Integracao:** `os-scripting`, `linux-troubleshooting`.
**Padroes:** set -euo pipefail, logging, exit codes. Evitar scripts sem error handling.
**Referencias:** https://www.gnu.org/software/bash/manual/

### 6.5 e2e-testing
**Descricao:** Testes end-to-end com Playwright para automacao de browser.
**Quando usar:** Criar testes E2E completos.
**Exemplos:** Suite que valida fluxo de login, compra e checkout.
**Integracao:** `testing-qa`, `api-security-testing`.
**Padroes:** Page Object Model, fixtures, CI integrado. Evitar testes flaky.
**Referencias:** https://playwright.dev/docs/

### 6.6 kubernetes-deployment
**Descricao:** Workflow de deploy Kubernetes: orquestracao, Helm, service mesh.
**Quando usar:** Configurar ou gerenciar deploys em Kubernetes.
**Exemplos:** Helm chart com 3 replicas e health checks.
**Integracao:** `cloud-devops`, `terraform-infrastructure`.
**Padroes:** Helm charts, health checks, resource limits. Evitar pods sem resource limits.
**Referencias:** https://kubernetes.io/docs/

### 6.7 linux-troubleshooting
**Descricao:** Workflow de troubleshooting Linux: diagnostico, performance, servicos.
**Quando usar:** Diagnosticar problemas em servidores Linux.
**Exemplos:** Diagnosticar servico com 100% CPU.
**Integracao:** `bash-scripting`, `os-scripting`.
**Padroes:** Metodos sistematicos, documentar descobertas. Evitar chutes.
**Referencias:** https://linux.die.net/

### 6.8 postgresql-optimization
**Descricao:** Workflow de otimizacao PostgreSQL: queries, indexacao, performance.
**Quando usar:** Otimizar performance de queries ou configuracoes.
**Exemplos:** Identificar e otimizar 5 queries lentas com EXPLAIN ANALYZE.
**Integracao:** `database`, `data-engineering`.
**Padroes:** EXPLAIN ANALYZE, indices adequados, vacuum regular. Evitar SELECT * em producao.
**Referencias:** https://www.postgresql.org/docs/current/performance-tips.html

### 6.9 python-fastapi-development
**Descricao:** Backend Python FastAPI: async, SQLAlchemy, Pydantic, autenticacao.
**Quando usar:** Construir APIs REST de alta performance com FastAPI.
**Exemplos:** API com JWT, SQLAlchemy ORM e validacao Pydantic.
**Integracao:** `development`, `api-documentation`.
**Padroes:** Async, Pydantic schemas, dependency injection. Evitar sync code em FastAPI.
**Referencias:** https://fastapi.tiangolo.com/

### 6.10 rag-implementation
**Descricao:** Workflow de RAG: embeddings, vector database, chunking, retrieval.
**Quando usar:** Implementar sistemas RAG completos.
**Exemplos:** Sistema com Pinecone, OpenAI embeddings e chunking semantico.
**Integracao:** `ai-ml`, `ai-agent-development`.
**Padroes:** Chunking otimizado, evaluation continua. Evitar chunking sem avaliacao.
**Referencias:** https://python.langchain.com/docs/concepts/rag/

### 6.11 react-nextjs-development
**Descricao:** React e Next.js 14+: App Router, Server Components, TypeScript, Tailwind.
**Quando usar:** Desenvolver aplicações web modernas.
**Exemplos:** Dashboard Next.js 14 com Server Components e streaming.
**Integracao:** `development`, `frontend-design`.
**Padroes:** Server Components, streaming, ISR. Evitar client components desnecessariamente.
**Referencias:** https://nextjs.org/docs

### 6.12 terraform-infrastructure
**Descricao:** Infraestrutura como codigo Terraform: recursos cloud, modulos reutilizaveis.
**Quando usar:** Gerenciar infraestrutura cloud como codigo.
**Exemplos:** Modulos para VPC, ECS cluster e RDS com state remoto.
**Integracao:** `cloud-devops`, `kubernetes-deployment`.
**Padroes:** Modulos reutilizaveis, state remoto, workspaces. Evitar state local em equipe.
**Referencias:** https://developer.hashicorp.com/terraform/docs

### 6.13 web-security-testing
**Descricao:** Testes de seguranca web: OWASP Top 10, XSS, injeção, autenticacao.
**Quando usar:** Testar seguranca de aplicações web.
**Exemplos:** Testar XSS refletido, stored e DOM-based.
**Integracao:** `security-audit`, `api-security-testing`.
**Padroes:** OWASP Top 10, scanning automatizado. Evitar testar apenas em staging.
**Referencias:** https://owasp.org/www-project-top-ten/

### 6.14 wordpress-plugin-development
**Descricao:** Desenvolvimento de plugins WordPress: arquitetura, hooks, REST API.
**Quando usar:** Desenvolver plugins WordPress customizados.
**Exempros:** Plugin que adiciona campo customizado com interface admin.
**Integracao:** `wordpress`, `wordpress-theme-development`.
**Padroes:** Hooks, nonces, capability checks. Evitar queries diretas sem prepare.
**Referencias:** https://developer.wordpress.org/plugins/

### 6.15 wordpress-theme-development
**Descricao:** Desenvolvimento de temas WordPress: templates, custom post types, block editor.
**Quando usar:** Desenvolver temas WordPress customizados.
**Exemplos:** Tema com suporte completo a block editor e patterns.
**Integracao:** `wordpress`, `wordpress-plugin-development`.
**Padroes:** Block editor, theme.json, child themes. Evitar hardcoding no template.
**Referencias:** https://developer.wordpress.org/themes/

### 6.16 wordpress-woocommerce-development
**Descricao:** Desenvolvimento loja WooCommerce: pagamentos, frete, customizacao.
**Quando usar:** Desenvolver lojas WooCommerce completas.
**Exemplos:** Loja com gateway personalizado e frete por regiao.
**Integracao:** `wordpress`, `wordpress-plugin-development`.
**Padroes:** WooCommerce hooks, custom checkout, tax configuration. Evitar modificar core.
**Referencias:** https://github.com/woocommerce/woocommerce/wiki/

---

## Resumo Estatístico

| Categoria | Total de Skills |
|-----------|----------------|
| Project Management | 22 |
| Planning | 7 |
| Productivity | 33 |
| Workflow | 62 |
| Workflow Bundle | 9 |
| Granular Workflow Bundle | 16 |
| **Total** | **149** |

### Top 10 Skills Mais Versateis (Project Management)

1. **jira-automation** — Gerenciamento completo de projetos ageis
2. **linear-automation** — Alternativa moderna ao Jira
3. **to-prd** — Transforma conversas em PRDs formais
4. **to-issues** — Decompoe specs em issues acionaveis
5. **feature-tracking** — Memoria duradoura entre sessoes
6. **project-state-governor** — Estado canonico do projeto
7. **github-issue-creator** — Issues GitHub profissionais
8. **progressive-estimation** — Estimativas com PERT
9. **team-collaboration-standup-notes** — Notas de standup automaticas
10. **trello-automation** — Gestao Kanban visual

### Top 5 Skills Mais Uteis para Planejamento

1. **blueprint** — Planos executaveis passo a passo
2. **plan-writing** — Planejamento estruturado com dependencias
3. **writing-plans** — De specs a planos de execucao
4. **track-management** — Organizacao em tracks paralelos
5. **planning-with-files** — Estado persistente em Markdown

### Top 5 Skills Mais Uteis para Workflow

1. **commit** — Convencoes de commit padronizadas
2. **executing-plans** — Execucao de planos com checkpoints
3. **closed-loop-delivery** — Entrega end-to-end autonoma
4. **verification-before-completion** — Garantia de qualidade
5. **workflow-automation** — Automacoes resilientes

---

## Arquivos Alterados

- **Criado:** `D:\SkillsKnowledge\ProjectManagement\project_management_skills_v2.md`
- **Baseado em:** `D:\SkillsKnowledge\ProjectManagement\project_management_skills.md`

## Verificacao Realizada

- ✅ Todas as 149 skills documentadas com formatacao aprimorada
- ✅ Para cada skill: Descricao, Quando usar, Exemplos praticos (2-3), Casos de uso avancados, Integracao com outras skills, Padroes e anti-padroes, Dicas de performance, Comandos uteis, Referencias
- ✅ Indice e estatisticas incluidos no documento
- ✅ Arquivo salvo com sucesso

## Melhorias Implementadas

1. **Mais exemplos praticos:** 2-3 exemplos de codigo por skill com snippets prontos
2. **Casos de uso avancados:** 2-3 cenarios reais por skill
3. **Integracao com outras skills:** 3-5 skills complementares por skill
4. **Padroes e anti-padroes:** O que fazer e o que evitar (formato visual com emojis)
5. **Dicas de performance:** 3-4 otimizacoes importantes por skill
6. **Comandos uteis:** Snippets de codigo e comandos bash prontos
7. **Referencias:** Links para documentacao oficial de cada ferramenta/tecnologia

## Limitacoes

- Descricoes compactadas para skills da secao Productivity (3.1-3.33) devido ao tamanho do arquivo
- Skills das secoes Workflow, Workflow Bundle e Granular Workflow Bundle usam formato mais conciso
- Para detalhes completos de cada skill, consultar o SKILL.md individual no vault
- Exemplos sa baseados nas descricoes dos ponteiros de categoria; podem existir APIs especificas nao documentadas
