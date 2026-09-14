# Project Management Skills — Documentação Completa

> **Data de geração:** 14/09/2026
> **Total de skills documentadas:** 149 skills em 6 categorias
> **Fonte:** Pointer skills do sistema OpenCode

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

### 1.1 asana-automation
- **Descrição:** Automatiza tarefas no Asana via Rube MCP (Composio): tasks, projetos, seções, times, workspaces.
- **Quando usar:** Quando precisar criar, atualizar ou gerenciar projetos e tarefas no Asana programaticamente.
- **Exemplo:** Criar uma nova tarefa no Asana associada a um sprint específico, atribuída a um membro da equipe.

### 1.2 basecamp-automation
- **Descrição:** Automatiza gerenciamento de projetos no Basecamp: to-dos, mensagens, pessoas e organização de listas.
- **Quando usar:** Para sincronizar ou gerenciar tarefas e comunicação dentro de projetos Basecamp.
- **Exemplo:** Criar um to-do list no Basecamp a partir de um backlog extraído de uma conversa.

### 1.3 confluence-automation
- **Descrição:** Automatiza criação de páginas, busca de conteúdo, gerenciamento de espaços, labels e navegação hierárquica no Confluence.
- **Quando usar:** Para documentar decisões, criar páginas de specs ou buscar documentação existente no Confluence.
- **Exemplo:** Criar uma página de retrospectiva no Confluence com o resumo das decisões tomadas na sprint.

### 1.4 feature-tracking
- **Descrição:** Mantém memória duradoura a nível de feature entre sessões de IA com arquivos Markdown leves para status, docs de verdade, decisões, riscos e mudanças.
- **Quando usar:** Quando trabalhar em features complexas que se estendem por múltiplas sessões de desenvolvimento.
- **Exemplo:** Manter um `feature-status.md` atualizado com o progresso da implementação de um módulo de pagamento.

### 1.5 freshservice-automation
- **Descrição:** Automatiza tarefas ITSM no Freshservice: criar/atualizar tickets, operações em lote, service requests e emails outbound.
- **Quando usar:** Para gerenciar tickets de suporte, criar incidentes ou disparar notificações via Freshservice.
- **Exemplo:** Criar um ticket de incidente no Freshservice automaticamente a partir de um erro detectado em monitoramento.

### 1.6 github-issue-creator
- **Descrição:** Transforma logs de erro, screenshots, voice notes e relatórios vagos em issues GitHub bem estruturadas com passos de reprodução, impacto e evidências.
- **Quando usar:** Quando precisar documentar um bug ou feature request de forma clara e acionável no GitHub.
- **Exemplo:** Converter um crash report com stack trace em uma issue GitHub com label, prioridade e passos de reprodução.

### 1.7 jira-automation
- **Descrição:** Automatiza tarefas no Jira via Rube MCP (Composio): issues, projetos, sprints, boards, comentários, usuários.
- **Quando usar:** Para criar, mover ou atualizar issues do Jira, gerenciar sprints ou extrair dados de boards.
- **Exemplo:** Mover uma issue de "In Progress" para "Done" no Jira ao concluir um pull request.

### 1.8 linear-automation
- **Descrição:** Automatiza tarefas no Linear via Rube MCP (Composio): issues, projetos, cycles, times, labels.
- **Quando usar:** Para gerenciar o ciclo de vida de issues no Linear, criar projetos ou atribuir work.
- **Exemplo:** Criar uma issue no Linear com label "bug" e atribuí-la ao time de backend a partir de um relato de usuário.

### 1.9 linear-claude-skill
- **Descrição:** Gerencia issues, projetos e times no Linear de forma integrada com Claude.
- **Quando usar:** Quando precisar interagir com o Linear de forma conversacional para criar ou consultar issues.
- **Exemplo:** "Crie uma issue no Linear para implementar autenticação OAuth no projeto X".

### 1.10 miro-automation
- **Descrição:** Automatiza tarefas no Miro via Rube MCP (Composio): boards, items, sticky notes, frames, sharing, connectors.
- **Quando usar:** Para criar quadros de brainstorming, diagramas de arquitetura ou boards de planejamento no Miro.
- **Exemplo:** Criar um board no Miro com sticky notes organizados por categorias de backlog.

### 1.11 monday-automation
- **Descrição:** Automatiza o Monday.com: boards, items, columns, groups, subitems e updates.
- **Quando usar:** Para gerenciar projetos no Monday.com, criar itens ou atualizar status de trabalhos.
- **Exemplo:** Criar um novo item no Monday.com com colunas de data, responsável e status automaticamente.

### 1.12 progressive-estimation
- **Descrição:** Estima trabalho de desenvolvimento assistido por IA e híbrido (humano+agente) com estatísticas PERT pesquisadas e loops de calibração.
- **Quando usar:** Quando precisar estimar esforço para tarefas que envolvem colaboração entre humanos e agentes de IA.
- **Exemplo:** Estimar que a implementação de uma feature complexa levará 3-5 dias usando PERT com dados históricos.

### 1.13 project-state-governor
- **Descrição:** Governança de estado canonical de projeto baseado em evidências, mantendo consistência entre sessões, branches, reviews e ciclos de pesquisa.
- **Quando usar:** Para manter uma fonte única de verdade sobre o estado atual do projeto ao longo do tempo.
- **Exemplo:** Manter um `project-state.md` que registra automaticamente mudanças de status de features entre sessões.

### 1.14 sred-project-organizer
- **Descrição:** Organiza uma lista de projetos e sua documentação relacionada no formato SRED para submissão.
- **Quando usar:** Para preparar documentação de projetos de P&D para submissão de créditos fiscais SRED.
- **Exemplo:** Organizar 5 projetos de desenvolvimento com suas specs e evidências no formato SRED.

### 1.15 sred-work-summary
- **Descrição:** Percorre o trabalho do último ano e cria um documento Notion agrupando links relevantes em projetos documentáveis como SRED.
- **Quando usar:** Para gerar um resumo consolidado de trabalho anual para fins de créditos fiscais.
- **Exemplo:** Criar um documento Notion que agrupa commits, PRs e decisões em 3 projetos SRED.

### 1.16 team-collaboration-issue
- **Descrição:** Especialista em resolução de issues GitHub: investigação sistemática de bugs, implementação de features e workflows de desenvolvimento colaborativo.
- **Quando usar:** Para resolver issues complexas do GitHub com abordagem estruturada e colaborativa.
- **Exemplo:** Investigar e resolver uma issue de performance analisando logs, reproduzindo o bug e implementando a correção.

### 1.17 team-collaboration-standup-notes
- **Descrição:** Especialista em comunicação assíncrona: práticas de standup, geração de notas por IA a partir de histórico de commits, coordenação de times remotos.
- **Quando usar:** Para gerar notas de standup automaticamente ou coordenar comunicação entre times distribuídos.
- **Exemplo:** Gerar um resumo de standup a partir dos commits e PRs das últimas 24 horas.

### 1.18 to-issues
- **Descrição:** Decompõe um plano, spec ou PRD em issues independentes no issue tracker usando fatias verticais tracer-bullet.
- **Quando usar:** Quando precisar quebrar um specification grande em issues menores e acionáveis.
- **Exemplo:** Transformar um PRD de "Sistema de Pagamentos" em 8 issues independentes, cada uma com valor entregável.

### 1.19 to-prd
- **Descrição:** Transforma a conversa atual em um PRD e publica no issue tracker — sem entrevista, apenas síntese do que já foi discutido.
- **Quando usar:** Quando uma conversa evoluiu para requisitos claros e você quer documentar como PRD formal.
- **Exemplo:** Sintetizar 2 horas de discussão sobre uma feature em um PRD estruturado publicado no GitHub.

### 1.20 todoist-automation
- **Descrição:** Automatiza gestão de tarefas no Todoist: projetos, seções, filtros e operações em lote.
- **Quando usar:** Para criar, organizar ou consultar tarefas no Todoist programaticamente.
- **Exemplo:** Criar um projeto no Todoist com seções "Sprint Atual" e "Backlog" e popular com tarefas.

### 1.21 trello-automation
- **Descrição:** Automatiza boards, cards e workflows no Trello: criar cards, gerenciar listas, atribuir membros e buscar across boards.
- **Quando usar:** Para gerenciar quadros Kanban no Trello, mover cards ou criar listas automaticamente.
- **Exemplo:** Mover um card de "Em Progresso" para "Revisão" no Trello quando um PR é aberto.

### 1.22 wrike-automation
- **Descrição:** Automatiza gerenciamento de projetos no Wrike: criar tasks/folders, gerenciar projetos, atribuir work e acompanhar progresso.
- **Quando usar:** Para criar e gerenciar tarefas no Wrike, atribuir trabalho e monitorar progresso.
- **Exemplo:** Criar uma task no Wrike com dependências e atribuí-la ao time de QA.

---

## 2. Planning

**Ponteiro:** `planning-category-pointer`
**Vault:** `C:/Users/Alendaviva007/.config/opencode/skill-libraries/planning`

### 2.1 blueprint
- **Descrição:** Transforma um objetivo de uma linha em um plano de construção passo a passo que qualquer agente de código pode executar frio. Cada passo tem um brief de contexto autocontido.
- **Quando usar:** Quando precisar de um plano detalhado e executável para uma tarefa de desenvolvimento complexa.
- **Exemplo:** Gerar um blueprint de 12 passos para implementar um sistema de autenticação JWT do zero.

### 2.2 concise-planning
- **Descrição:** Gera um checklist claro, acionável e atômico para tarefas de codificação.
- **Quando usar:** Quando precisar de um plano rápido e direto para uma tarefa de desenvolvimento.
- **Exemplo:** Criar um checklist de 5 itens para adicionar validação de formulário em um React component.

### 2.3 decision-navigator
- **Descrição:** Guia usuários travados ou sobrecarregados através de perguntas de ramificação direcionadas até alcançar próximos passos concretos.
- **Quando usar:** Quando o usuário está indeciso sobre qual abordagem tomar ou por onde começar.
- **Exemplo:** Através de perguntas como "Qual é o prazo?", "Qual o impacto?", guiar a decisão entre refactor completo ou patch rápido.

### 2.4 plan-writing
- **Descrição:** Planejamento estruturado de tarefas com breakdowns claros, dependências e critérios de verificação.
- **Quando usar:** Para implementar features, refatorar ou qualquer trabalho multi-etapa que precise de planejamento formal.
- **Exemplo:** Criar um plano com 6 fases, dependências e critérios de aceite para migrar de REST para GraphQL.

### 2.5 planning-with-files
- **Descrição:** Trabalha como o Manus: usa arquivos Markdown persistentes como "memória de trabalho em disco".
- **Quando usar:** Quando precisar manter estado persistente de planejamento entre múltiplas interações.
- **Exemplo:** Criar arquivos `plan.md`, `progress.md` e `decisions.md` para acompanhar o desenvolvimento de uma feature.

### 2.6 track-management
- **Descrição:** Cria, gerencia e trabalha com Conductor tracks — unidades de trabalho lógicas para features, bugs e refactors. Aplica-se a spec.md, plan.md e operações de lifecycle de tracks.
- **Quando usar:** Para organizar trabalho em tracks paralelos usando o sistema Conductor.
- **Exemplo:** Criar uma track "Authentication" com spec.md e plan.md, dividida em 3 fases de implementação.

### 2.7 writing-plans
- **Descrição:** Usa quando há um spec ou requisitos para uma tarefa multi-etapa, antes de tocar no código.
- **Quando usar:** Para transformar requisitos em um plano de execução antes de começar a implementar.
- **Exemplo:** Dado um requisito de "adicionar cache Redis", criar um plano com setup, integração, testes e deploy.

---

## 3. Productivity

**Ponteiro:** `productivity-category-pointer`
**Vault:** `C:/Users/Alendaviva007/.config/opencode/skill-libraries/productivity`

### 3.1 anywrite
- **Descrição:** CLI compilado cobrindo todos os 52 endpoints da API local do Anytype — objetos, propriedades, tags, busca, chat, arquivos.
- **Quando usar:** Para interagir programaticamente com o Anytype sem precisar de servidor MCP.
- **Exemplo:** Criar um objeto no Anytype com propriedades personalizadas via CLI.

### 3.2 ask-matt
- **Descrição:** Pergunta qual skill ou flow se encaixa na situação do usuário. Um roteador sobre as skills invocadas pelo usuário.
- **Quando usar:** Quando não sabe qual skill usar para resolver o problema apresentado.
- **Exemplo:** O usuário pergunta "preciso automatizar meu workflow de deploy" → ask-matt identifica a skill correta.

### 3.3 box-automation
- **Descrição:** Automatiza operações no Box: upload/download de arquivos, busca de conteúdo, gerenciamento de pastas, colaboração, consultas de metadata e sign requests.
- **Quando usar:** Para gerenciar arquivos e colaboração no Box programaticamente.
- **Exemplo:** Fazer upload de um documento de spec para uma pasta compartilhada no Box.

### 3.4 brain-to-docs
- **Descrição:** Entrevista o usuário para transformar visão do projeto e decisões em documentação README e ADR.
- **Quando usar:** Quando um projeto novo precisa de documentação inicial ou quando decisões arquiteturais precisam ser formalizadas.
- **Exemplo:** Extrair de uma conversa de 30 minutos os ADRs sobre escolha de framework, banco de dados e padrão de API.

### 3.5 cal-com-automation
- **Descrição:** Automatiza tarefas no Cal.com via Rube MCP: gerenciar bookings, verificar disponibilidade, configurar webhooks e lidar com times.
- **Quando usar:** Para integrar agendamento de reuniões em workflows automatizados.
- **Exemplo:** Criar um webhook no Cal.com que notifica um Slack channel quando um booking é confirmado.

### 3.6 calendly-automation
- **Descrição:** Automatiza agendamento, gestão de eventos, rastreamento de invitees, verificações de disponibilidade e administração de organização no Calendly.
- **Quando usar:** Para gerenciar reuniões e disponibilidade de equipe via Calendly.
- **Exemplo:** Verificar slots disponíveis no Calendly e sugerir horários para uma reunião de alinhamento.

### 3.7 codex-profiles
- **Descrição:** Executa Codex CLI ou Codex Desktop com perfis CODEX_HOME isolados para contas separadas, projetos e estado local.
- **Quando usar:** Quando precisa manter múltiplas configurações isoladas do Codex para projetos diferentes.
- **Exemplo:** Rodar um perfil "trabalho" e outro "pessoal" do Codex com configs e histories separados.

### 3.8 compile-knowledge
- **Descrição:** Compila descobertas duradouras e não óbvias em um store de conhecimento Markdown interligado — arquivos atônicos, [[wiki-links]], índice mantido.
- **Quando usar:** Para acumular conhecimento técnico entre sessões de forma organizada e buscável.
- **Exemplo:** Criar um `knowledge-index.md` com links para descobertas sobre otimização de queries, padrões de caching, etc.

### 3.9 context-kit
- **Descrição:** Avalia, adapta e instala com segurança artefatos de contexto pessoal do Context Kit para Claude Code ou workflows de agentes adjacentes.
- **Quando usar:** Para configurar contexto persistente que melhora a qualidade das respostas do agente.
- **Exemplo:** Instalar um `context.md` com preferências do projeto, stack tecnológica e convenções de código.

### 3.10 daily-gift
- **Descrição:** Engine de presentes diários com pipeline criativo de cinco estágios — julgamento editorial, síntese, geração de conceitos, estratégia visual e renderização em H5, imagem ou vídeo.
- **Quando usar:** Para criar conteúdo criativo personalizado diariamente para relacionamento com clientes ou público.
- **Exemplo:** Gerar um post visual diário com tema personalizado para diferentes segmentos de audiência.

### 3.11 docusign-automation
- **Descrição:** Automatiza tarefas no DocuSign via Rube MCP: templates, envelopes, assinaturas, gerenciamento de documentos.
- **Quando usar:** Para enviar documentos para assinatura ou gerenciar templates no DocuSign.
- **Exemplo:** Enviar um contrato automaticamente para assinatura de 3 partes via DocuSign.

### 3.12 dropbox-automation
- **Descrição:** Automatiza gerenciamento de arquivos no Dropbox: compartilhamento, busca, uploads, downloads e operações de pastas.
- **Quando usar:** Para sincronizar, organizar ou compartilhar arquivos no Dropbox programaticamente.
- **Exemplo:** Fazer backup automático de relatórios gerados para uma pasta específica no Dropbox.

### 3.13 faf-wizard
- **Descrição:** Gerador done-for-you de .faf. Uma única ação gera contexto AI para qualquer projeto — novo, legado ou famoso. Detecta stack automaticamente, avalia readiness, funciona em qualquer lugar.
- **Quando usar:** Para快速 configurar contexto de IA para qualquer projeto sem configuração manual.
- **Exemplo:** Gerar um arquivo .faf que descreve automaticamente a stack, padrões e convenções de um projeto existente.

### 3.14 file-organizer
- **Descrição:** Reduz clutter: identifica arquivos antigos que provavelmente não são mais necessários.
- **Quando usar:** Para limpar e organizar diretórios de projeto removendo arquivos obsoletos.
- **Exemplo:** Identificar 15 arquivos não modificados há 2 anos e sugerir remoção ou arquivamento.

### 3.15 gmail-automation
- **Descrição:** Integração leve com Gmail com autenticação OAuth standalone. Sem servidor MCP necessário.
- **Quando usar:** Para ler, enviar ou gerenciar emails do Gmail de forma programática.
- **Exemplo:** Verificar se há emails não lidos de um remetente específico e resumi-los.

### 3.16 google-calendar-automation
- **Descrição:** Integração leve com Google Calendar com autenticação OAuth standalone. Sem servidor MCP necessário.
- **Quando usar:** Para criar, consultar ou gerenciar eventos no Google Calendar.
- **Exemplo:** Criar um evento recorrente de standup todas as segundas-feiras às 9h.

### 3.17 grill-me
- **Descrição:** Uma entrevista incansável para afiar um plano ou design.
- **Quando usar:** Quando precisar testar estressadamente um plano ou design antes de implementar.
- **Exemplo:** Submeter um design de API a perguntas como "E se o banco cair?", "E se houver 10x mais tráfego?".

### 3.18 grill-with-docs
- **Descrição:** Entrevista incansável para afiar plano ou design, que também cria documentação (ADRs e glossário) durante o processo.
- **Quando usar:** Quando quer testar um plano E gerar documentação formal das decisões tomadas.
- **Exemplo:** Realizar entrevista sobre arquitetura microserviços e gerar ADRs documentando cada decisão.

### 3.19 grilling
- **Descrição:** Entrevista o usuário incansavelmente sobre um plano ou design. Ativa quando o usuário quer testar estressamente um plano antes de construir.
- **Quando usar:** Quando o usuário explicitamente pede para "grill" ou testar um plano.
- **Exemplo:** Questionar cada premissa de um plano de migração de banco de dados para garantir robustez.

### 3.20 handoff
- **Descrição:** Compacta a conversa atual em um documento de handoff para outro agente continuar o trabalho.
- **Quando usar:** Quando precisa transferir contexto de uma sessão para outra ou para outro agente.
- **Exemplo:** Criar um `handoff.md` com resumo de 2 páginas sobre o progresso, decisões pendentes e próximos passos.

### 3.21 interview-coach
- **Descrição:** Sistema completo de coaching para busca de emprego: decodificação de JD, resume, storybank, mock interviews, análise de transcrição, negociação salarial. 23 comandos, estado persistente.
- **Quando usar:** Para se preparar para entrevistas técnicas ou de behavioral.
- **Exemplo:** Rodar um mock interview para vaga de Engineering Manager com feedback estruturado.

### 3.22 interview-style-doc-building
- **Descrição:** Constrói documentos de estratégia estruturados fazendo uma pergunta por vez e atualizando o arquivo.
- **Quando usar:** Para criar documentos estratégicos de forma iterativa, perguntando ao usuário antes de escrever.
- **Exemplo:** Construir um documento de estratégia de produto fazendo perguntas sobre mercado, usuários e objetivos.

### 3.23 markdown-rendering
- **Descrição:** Abre Markdown de forma confiável em painéis cmux e recupera superfícies renderizadas em branco.
- **Quando usar:** Para visualizar documentação Markdown corretamente no editor.
- **Exemplo:** Renderizar um README.md complexo com tabelas e diagramas no painel do editor.

### 3.24 mdpr-skill
- **Descrição:** Revisa workflows de apresentação Markdown MDPR com dicas semânticas, verificações visuais e limites de renderer determinísticos.
- **Quando usar:** Para criar ou revisar apresentações em formato Markdown.
- **Exemplo:** Revisar uma apresentação de 20 slides garantindo formatação consistente e links funcionais.

### 3.25 office-productivity
- **Descrição:** Workflow de produtividade de escritório cobrindo criação de documentos, automação de planilhas, geração de apresentações e integração com formatos LibreOffice e Microsoft Office.
- **Quando usar:** Para criar, editar ou converter documentos de escritório programaticamente.
- **Exemplo:** Gerar uma planilha Excel com dados de vendas a partir de um JSON.

### 3.26 one-drive-automation
- **Descrição:** Automatiza gerenciamento de arquivos no OneDrive: busca, uploads, downloads, compartilhamento, permissões e operações de pastas.
- **Quando usar:** Para sincronizar ou gerenciar arquivos no OneDrive programaticamente.
- **Exemplo:** Compartilhar uma pasta de relatórios com permissão de visualização para o time de gestão.

### 3.27 read-all-adrs
- **Descrição:** Lê todos os ADRs de um projeto antes de resumir contexto arquitetural ou decisões.
- **Quando usar:** Quando precisa entender o histórico de decisões arquiteturais de um projeto.
- **Exemplo:** Ler 12 ADRs existentes e gerar um resumo do contexto arquitetural para um novo membro da equipe.

### 3.28 rich-elicitation
- **Descrição:** Faz perguntas de esclarecimento em múltiplas rodadas antes de iniciar tarefas ambíguas. Ativa quando 2+ dimensões da tarefa têm 3+ respostas viáveis.
- **Quando usar:** Quando a tarefa é ambígua e precisa de mais contexto antes de começar.
- **Exemplo:** Antes de criar uma API, esclarecer: protocolo, formato de dados, autenticação, versionamento e audience.

### 3.29 setup-help
- **Descrição:** Guiia o usuário passo a passo por uma instalação ou configuração, com os passos restantes sempre visíveis.
- **Quando usar:** Para ajudar o usuário a configurar um ambiente de desenvolvimento ou instalar dependências.
- **Exemplo:** Guiar a instalação do Docker, Node.js e configuração de um projeto passo a passo.

### 3.30 telegram-bot-messaging
- **Descrição:** Envia mensagens, arquivos e alertas via bot API do Telegram; faz perguntas com botões inline e aguarda resposta. Suporta múltiplos bots, chats nomeados e notificações CI/cron/hook.
- **Quando usar:** Para integrar notificações e interações via Telegram em workflows automatizados.
- **Exemplo:** Enviar uma notificação no Telegram quando um deploy é concluído com sucesso.

### 3.31 time-ledger
- **Descrição:** Registro de tempo em linguagem natural: interpreta o que o usuário disse em linhas de Atividade/Minutos/Data no banco Notion — perguntando ao invés de adivinhar quando inseguro.
- **Quando usar:** Para registrar tempo gasto em atividades de forma natural e integrada ao Notion.
- **Exemplo:** "Trabalhei 2h na feature de pagamento e 30min em reunião" → cria registros no Notion.

### 3.32 trading-ledger
- **Descrição:** Journal de trading que captura a decisão, não apenas o fill: tese, plano e emoção no momento da entrada, escrito no Notion do usuário; reviews avaliam decisões, não P&L.
- **Quando usar:** Para documentar e revisar decisões de trading de forma estruturada.
- **Exemplo:** Registrar uma entrada em ação com tese, plano de saída e emoção, e depois reviewar se a decisão foi boa independente do resultado.

### 3.33 workorai
- **Descrição:** Skill de marketplace de talentos WorkorAI: candidatos buscam vagas e gerenciam aplicações; empregadores rodam o ciclo de vida de vagas e recebem matches ranqueados com explicações transparentes.
- **Quando usar:** Para buscar vagas, candidatar-se ou gerenciar processo seletivo via plataforma WorkorAI.
- **Exemplo:** Buscar vagas de "Senior Backend" filtrando por stack e localização, e enviar candidatura automaticamente.

---

## 4. Workflow

**Ponteiro:** `workflow-category-pointer`
**Vault:** `C:/Users/Alendaviva007/.config/opencode/skill-libraries/workflow`

### 4.1 acceptance-orchestrator
- **Descrição:** Orquestra tarefa de codificação end-to-end: intake de issue, implementação, review, deploy e verificação de aceitação com mínimo de reintervenção humana.
- **Quando usar:** Para executar uma feature completa do início ao fim sem precisar de intervenção manual constante.
- **Exemplo:** Receber uma issue, implementar, criar PR, aguardar CI, fazer deploy e verificar em staging automaticamente.

### 4.2 address-github-comments
- **Descrição:** Endereça comentários de review ou issues em um Pull Request aberto no GitHub usando gh CLI.
- **Quando usar:** Quando um PR recebe comentários de review que precisam ser respondidos ou implementados.
- **Exemplo:** Ler 5 comentários de review em um PR e implementar as mudanças solicitadas commit a commit.

### 4.3 ai-loop
- **Descrição:** Executa um loop de desenvolvimento spec-build-review com escopo delimitado, condições de parada e gates de aprovação humana para trabalho arriscado ou ambíguo.
- **Quando usar:** Para features complexas que precisam de iteração controlada com aprovação humana.
- **Exemplo:** Loop de 3 iterações para implementar um sistema de cache, cada uma revisada antes de avançar.

### 4.4 airflow-dag-patterns
- **Descrição:** Constrói DAGs Apache Airflow de produção com práticas recomendadas para operators, sensors, testes e deploy.
- **Quando usar:** Para criar pipelines de dados ou workflows de agendamento com Airflow.
- **Exemplo:** Criar um DAG que extrai dados de uma API, transforma e carrega em um data warehouse.

### 4.5 antigravity-workflows
- **Descrição:** Paraship de SaaS MVP, auditoria de segurança de aplicações, construção de AI agent, QA via browser ou design de domínio com skills múltiplas e checkpoints verificados.
- **Quando usar:** Para projetos ambiciosos que combinam múltiplas disciplines com checkpoints de qualidade.
- **Exemplo:** Construir um MVP de SaaS com auth, API, frontend e deploy em 4 fases verificadas.

### 4.6 ask-questions-if-underspecified
- **Descrição:** Esclarece requisitos antes de implementar. Usa quando surgem dúvidas sérias.
- **Quando usar:** Quando a tarefa está subespecificada e implementar sem esclarecer causaria retrabalho.
- **Exemplo:** Antes de criar uma API, perguntar "Qual o formato de autenticação? Rate limiting?".

### 4.7 bitbucket-automation
- **Descrição:** Automatiza repositórios, pull requests, branches, issues e gerenciamento de workspace no Bitbucket via Rube MCP.
- **Quando usar:** Para gerenciar repositórios e PRs no Bitbucket programaticamente.
- **Exemplo:** Criar uma branch de feature no Bitbucket a partir de uma issue.

### 4.8 build
- **Descrição:** Executa o comando de build do projeto.
- **Quando usar:** Para compilar ou buildar o projeto antes de testar ou fazer deploy.
- **Exemplo:** Rodar `npm run build` ou `cargo build` para verificar se o código compila.

### 4.9 changelog-automation
- **Descrição:** Automatiza geração de changelog a partir de commits, PRs e releases seguindo formato Keep a Changelog.
- **Quando usar:** Para configurar workflows de release ou gerar release notes automaticamente.
- **Exemplo:** Gerar um CHANGELOG.md com as últimas 20 mudanças agrupadas por tipo (feat, fix, chore).

### 4.10 closed-loop-delivery
- **Descrição:** Entrega de código com critérios de aceitação explícitos com mínimo de reintervenção do usuário através de implementação, feedback de review, deploy e verificação em runtime.
- **Quando usar:** Quando uma tarefa deve ser concluída contra critérios de aceitação claros sem perturbar o usuário.
- **Exemplo:** Implementar, testar, fazer deploy e verificar em produção uma feature seguindo critérios de aceitação definidos.

### 4.11 commit
- **Descrição:** SEMPRE usar esta skill ao fazer commit — nunca committar diretamente. Cria commits seguindo convenções Sentry com formato conventional commit e referências de issues.
- **Quando usar:** Para qualquer operação de commit no Git.
- **Exemplo:** `git commit -m "feat(auth): add JWT validation middleware (closes #142)"`.

### 4.12 conductor-implement
- **Descrição:** Executa tarefas do plano de implementação de uma track seguindo workflow TDD.
- **Quando usar:** Para implementar o plano de uma track do sistema Conductor com TDD.
- **Exemplo:** Executar as 5 tarefas da fase 1 da track "Authentication" com testes primero.

### 4.13 conductor-manage
- **Descrição:** Gerencia lifecycle de tracks: arquivar, restaurar, deletar, renomear e cleanup.
- **Quando usar:** Para manter organizadas as tracks do projeto no Conductor.
- **Exemplo:** Arquivar a track "Authentication" após conclusão e limpar referências órfãs.

### 4.14 conductor-new-track
- **Descrição:** Cria uma nova track com especificação e plano de implementação em fases.
- **Quando usar:** Para iniciar uma nova unidade de trabalho no sistema Conductor.
- **Exemplo:** Criar a track "Payment Integration" com spec.md e plan.md de 3 fases.

### 4.15 conductor-revert
- **Descrição:** Undo consciente de Git por unidade de trabalho lógica (track, fase ou tarefa).
- **Quando usar:** Quando precisar desfazer mudanças de uma track específica sem afetar outras.
- **Exemplo:** Reverter todas as mudanças da fase 2 da track "Cache" mantendo a fase 1.

### 4.16 conductor-setup
- **Descrição:** Configura um projeto Rails para trabalhar com Conductor (agentes de codificação paralelos).
- **Quando usar:** Para configurar um projeto Rails existente para usar o sistema Conductor.
- **Exemplo:** Adicionar a estrutura de tracks e configuração do Conductor a um projeto Rails legado.

### 4.17 conductor-status
- **Descrição:** Exibe status do projeto, tracks ativas e próximas ações.
- **Quando usar:** Para verificar o estado geral do projeto e identificar o que fazer a seguir.
- **Exemplo:** Listar 3 tracks ativas, suas fases atuais e a próxima tarefa de cada uma.

### 4.18 conductor-validator
- **Descrição:** Valida artefatos do projeto Conductor para completude, consistência e correção. Usa após setup, ao diagnosticar problemas ou antes da implementação.
- **Quando usar:** Para garantir que os arquivos do Conductor estão consistentes antes de começar a trabalhar.
- **Exemplo:** Validar que todas as tracks têm spec.md, plan.md e que as dependências estão corretas.

### 4.19 create-branch
- **Descrição:** Cria uma branch Git seguindo convenções Sentry. Usa quando pedido para criar branch ou iniciar novo trabalho.
- **Quando usar:** Para criar branches com nomenclatura padronizada.
- **Exemplo:** `git checkout -b feat/payment-integration` ou `fix/auth-token-expiry`.

### 4.20 create-issue-gate
- **Descrição:** Usa ao iniciar nova tarefa de implementação quando uma issue deve ser criada com critérios de aceitação estritos antes da execução.
- **Quando usar:** Para garantir que toda implementação tenha uma issue documentada antes de começar.
- **Exemplo:** Criar issue com título, descrição, critérios de aceitação e labels antes de implementar.

### 4.21 create-pr
- **Descrição:** Alias para pr-writer. Usa quando o usuário pede explicitamente "create-pr".
- **Quando usar:** Para criar Pull Requests seguindo práticas de engenharia estabelecidas.
- **Exemplo:** Criar um PR com título descritivo, descrição estruturada e checklist de review.

### 4.22 crossframe
- **Descrição:** Diagnóstico estrutural canônico chinês para relações complexas, organizações, disputas públicas ou evolução de longo prazo.
- **Quando usar:** Para análise estrutural de problemas complexos usando framework CrossFrame.
- **Exemplo:** Diagnosticar a estrutura de conflito em uma organização com múltiplos stakeholders.

### 4.23 crossframe-public
- **Descrição:** Análise CrossFrame de questões públicas, governança de plataformas, políticas, responsabilidade institucional ou conformidade.
- **Quando usar:** Para analisar questões públicas ou de governança com o framework CrossFrame.
- **Exemplo:** Analisar responsabilidade institucional em um caso de uso de dados de plataforma.

### 4.24 crossframe-review
- **Descrição:** Revisão de output CrossFrame para fidelidade de raciocínio, limites de evidência, âncoras de fonte, deriva de conceitos ou passos de reparo.
- **Quando usar:** Para validar a qualidade e integridade de uma análise CrossFrame.
- **Exemplo:** Revisar se uma análise de mercado mantém consistência conceitual e usa evidências adequadas.

### 4.25 crossframe-suite
- **Descrição:** Suite completa de workflows CrossFrame para diagnóstico estrutural chinês em relações, organizações, questões públicas, filosofia, pesquisa ou output ensaístico.
- **Quando usar:** Para workflows completos de análise estrutural usando todas as capacidades CrossFrame.
- **Exemplo:** Executar um diagnóstico completo de 4 etapas de uma questão de mercado regulado.

### 4.26 executing-plans
- **Descrição:** Executa um plano de implementação escrito em uma sessão separada com checkpoints de review.
- **Quando usar:** Quando há um plano detalhado pronto e precisa executá-lo com pontos de verificação.
- **Exemplo:** Executar um plano de 8 tarefas com review após cada par de tarefas concluídas.

### 4.27 finishing-a-development-branch
- **Descrição:** Quando a implementação está completa, todos os testes passam, e precisa decidir como integrar o trabalho — guia opções estruturadas para merge, PR ou cleanup.
- **Quando usar:** Ao finalizar uma branch de desenvolvimento e precisar integrar ao main.
- **Exemplo:** Após 3 dias de desenvolvimento, decidir entre merge direto, criar PR ou fazer squash.

### 4.28 full-stack-orchestration-full-stack-feature
- **Descrição:** Orquestração full-stack para features completas.
- **Quando usar:** Para implementar features que envolvem frontend, backend e infraestrutura simultaneamente.
- **Exemplo:** Implementar uma feature de upload de arquivo com frontend React, API Node.js e storage S3.

### 4.29 gh-review-requests
- **Descrição:** Busca notificações não lidas do GitHub para PRs abertos onde review é solicitado de um time especificado.
- **Quando usar:** Para verificar quais PRs precisam de review pelo seu time.
- **Exemplo:** Listar 4 PRs abertos onde o time "backend" foi solicitado para review.

### 4.30 git-advanced-workflows
- **Descrição:** Domina técnicas avançadas de Git para manter histórico limpo, colaborar efetivamente e se recuperar de qualquer situação.
- **Quando usar:** Para operações Git complexas como rebase interativo, cherry-pick ou bisect.
- **Exemplo:** Fazer rebase interativo de 10 commits para limpar o histórico antes de um merge.

### 4.31 git-hooks-automation
- **Descrição:** Configura Git hooks com Husky, lint-staged, pre-commit framework e commitlint. Automatiza gates de qualidade, formatação, linting e validação de mensagens de commit.
- **Quando usar:** Para configurar verificação automática de qualidade antes de cada commit.
- **Exemplo:** Configurar Husky para rodar ESLint e Prettier automaticamente antes de cada commit.

### 4.32 git-pr-review
- **Descrição:** Gera uma descrição de PR concisa e estruturada a partir do histórico de commits com uso mínimo de tokens.
- **Quando usar:** Para criar descrições de PRs de forma rápida e eficiente.
- **Exemplo:** Gerar uma descrição de PR com resumo, mudanças e测试列表 a partir de 8 commits.

### 4.33 git-pr-workflows-git-workflow
- **Descrição:** Orquestra review, testes, commits, branch pushes e criação de pull requests com agentes paralelos.
- **Quando usar:** Quando mudanças precisam passar por validação completa antes de um PR ou merge.
- **Exemplo:** Executar lint, testes unitários, testes de integração e criar PR em paralelo.

### 4.34 git-pr-workflows-onboard
- **Descrição:** Especialista em onboarding e transferência de conhecimento com experiência em organizações remote-first.
- **Quando usar:** Para integrar novos membros à equipe com processos e contexto do projeto.
- **Exemplo:** Criar um guia de onboarding de 10 passos para novos desenvolvedores do time.

### 4.35 git-pr-workflows-pr-enhance
- **Descrição:** Especialista em otimização de PRs para facilitar reviews eficientes. Gera descrições completas, automatiza processos de review.
- **Quando usar:** Para melhorar a qualidade dos PRs e tornar os reviews mais eficientes.
- **Exemplo:** Adicionar screenshots, testes manuais e Impact Assessment a um PR existente.

### 4.36 git-pushing
- **Descrição:** Stage, commit e push seguro de mudanças Git com mensagens de commit convencionais. Usa para pushes normais não-release quando pedido explicitamente.
- **Quando usar:** Para sincronizar trabalho local com o repositório remoto.
- **Exemplo:** `git add . && git commit -m "feat: add user search" && git push origin feat/user-search`.

### 4.37 git-workflow-and-versioning
- **Descrição:** Estrutura práticas de workflow Git. Usa ao fazer qualquer mudança de código, commit, branch ou resolver conflitos.
- **Quando usar:** Para garantir consistência no workflow Git do projeto.
- **Exemplo:** Criar branches feature a partir de develop, com merges de volta via PR.

### 4.38 github-actions-templates
- **Descrição:** Padrões de workflow GitHub Actions prontos para produção para testar, buildar e fazer deploy de aplicações.
- **Quando usar:** Para configurar CI/CD com GitHub Actions rapidamente.
- **Exemplo:** Usar um template que roda testes, faz build e deploy para Vercel automaticamente.

### 4.39 github-automation
- **Descrição:** Opera issues, pull requests, branches, checks, workflows e permissões do GitHub via Rube MCP com safeguards de política de repositório.
- **Quando usar:** Para gerenciar programaticamente repositórios GitHub com proteções de política.
- **Exemplo:** Verificar status de checks de um PR e comentar resultado automaticamente.

### 4.40 github-presence
- **Descrição:** Otimiza perfil GitHub, README ou discoverability de projetos. Frases trigger: "GitHub README", "GitHub profile", "GitHub stars".
- **Quando usar:** Para melhorar a presença e visibilidade no GitHub.
- **Exemplo:** Criar um README.md profissional com badges, screenshots e descrição compelling.

### 4.41 github-workflow-automation
- **Descrição:** Padrões para automatizar workflows GitHub com assistência de IA, inspirados no Gemini CLI e práticas DevOps modernas.
- **Quando usar:** Para criar automações inteligentes no GitHub com IA.
- **Exemplo:** Criar um workflow que analisa PRs automaticamente e sugere melhorias.

### 4.42 gitlab-automation
- **Descrição:** Automatiza gerenciamento de projetos GitLab, issues, merge requests, pipelines, branches e operações de usuário via Rube MCP.
- **Quando usar:** Para gerenciar repositórios e pipelines no GitLab programaticamente.
- **Exemplo:** Criar um merge request no GitLab com template pré-definido.

### 4.43 gitlab-ci-patterns
- **Descrição:** Padrões abrangentes de pipeline GitLab CI/CD para teste automatizado, build e deploy.
- **Quando usar:** Para configurar pipelines CI/CD no GitLab.
- **Exemplo:** Criar um `.gitlab-ci.yml` com stages de test, build e deploy para Docker.

### 4.44 inngest
- **Descrição:** Especialista em Inngest para background jobs serverless-first, workflows event-driven e execução durável sem gerenciar filas ou workers.
- **Quando usar:** Para criar background jobs ou workflows event-driven com Inngest.
- **Exemplo:** Criar uma função Inngest que envia email de boas-vindas 24h após cadastro.

### 4.45 issues
- **Descrição:** Interage com issues do GitHub — criar, listar e visualizar.
- **Quando usar:** Para operações básicas de issues no GitHub.
- **Exemplo:** Listar todas as issues abertas com label "bug" no repositório.

### 4.46 iterate-pr
- **Descrição:** Itera em um PR até o CI passar. Usa quando precisa corrigir falhas de CI, atender feedback de review ou continuar pushando fixes até todos os checks ficarem verdes.
- **Quando usar:** Para corrigir automaticamente falhas de CI em um PR.
- **Exemplo:** Rodar testes localmente, corrigir erros, commitar e pushar até o CI ficar verde.

### 4.47 lint-and-validate
- **Descrição:** Roda lint e type checks configurados, distingue falhas de checks que não rodaram, e reporta resultados concretos de validação.
- **Quando usar:** Para verificar qualidade do código antes de commits ou reviews.
- **Exemplo:** Rodar `eslint` e `typy` e reportar 3 erros de lint e 1 de tipagem.

### 4.48 ml-pipeline-workflow
- **Descrição:** Orquestração completa de pipeline MLOps de ponta a ponta: preparação de dados through deploy de modelo.
- **Quando usar:** Para criar pipelines de ML completos do treinamento ao deploy.
- **Exemplo:** Criar pipeline que treina modelo, valida métricas, versiona e deploya em endpoint.

### 4.49 pr-merge-champion
- **Descrição:** Otimiza pull requests para aprovação e merge rápidos garantindo diffs limpos, self-reviews completos e documentação estruturada.
- **Quando usar:** Para preparar um PR para merge garantindo alta qualidade.
- **Exemplo:** Revisar um PR, limpar commits, adicionar descrição completa e garantir CI verde.

### 4.50 pr-writer
- **Descrição:** Cria pull requests seguindo práticas de engenharia Sentry.
- **Quando usar:** Para criar PRs padronizados e de alta qualidade.
- **Exemplo:** Criar PR com título convencional, descrição com contexto, mudanças e testes.

### 4.51 receiving-code-review
- **Descrição:** Code review requer avaliação técnica, não performance emocional.
- **Quando usar:** Para processar feedback de review de forma produtiva e técnica.
- **Exemplo:** Analisar 8 comentários de review, implementar os 5 relevantes e explicar por que os 3 outros não se aplicam.

### 4.52 requesting-code-review
- **Descrição:** Usa ao completar tarefas, implementar features principais ou antes de merge para verificar se o trabalho atende requisitos.
- **Quando usar:** Para solicitar review após concluir uma implementação.
- **Exemplo:** Criar PR e notificar reviewers com contexto sobre o que foi implementado e por quê.

### 4.53 subagent-driven-development
- **Descrição:** Usa ao executar planos de implementação com tarefas independentes na sessão atual.
- **Quando usar:** Para paralelizar implementação de tarefas independentes usando sub-agentes.
- **Exemplo:** Executar 4 tarefas independentes em paralelo, cada uma em um sub-agente.

### 4.54 task-intelligence
- **Descrição:** Protocolo de Inteligência Pré-Tarefa — ativa TODOS os agentes relevantes do ecossistema ANTES de executar qualquer tarefa.
- **Quando usar:** Para garantir que todas as fontes de conhecimento sejam consultadas antes de agir.
- **Exemplo:** Antes de implementar uma feature, consultar skills de testing, security, performance e documentation.

### 4.55 temporal-golang-pro
- **Descrição:** Para sistemas distribuídos duráveis com Temporal Go SDK. Regras de workflow determinísticos, configs de worker mTLS e padrões avançados.
- **Quando usar:** Para construir workflows duráveis com Temporal em Go.
- **Exemplo:** Implementar uma saga pattern com Temporal Go SDK para transação distribuída.

### 4.56 temporal-python-pro
- **Descrição:** Dominar orquestração de workflows Temporal com Python SDK. Implementa workflows duráveis, padrões saga e transações distribuídas.
- **Quando usar:** Para criar workflows duráveis com Temporal em Python.
- **Exemplo:** Criar uma workflow que processa pedidos com compensate automático em caso de falha.

### 4.57 trigger-dev
- **Descrição:** Especialista Trigger.dev para background jobs, workflows de IA e execução async confiável com design TypeScript-first.
- **Quando usar:** Para criar background jobs ou AI workflows com Trigger.dev.
- **Exemplo:** Criar um job que processa uploads de vídeo em background com retry automático.

### 4.58 upstash-qstash
- **Descrição:** Especialista Upstash QStash para filas de mensagens serverless, jobs agendados e entrega de tarefas HTTP confiável sem gerenciar infraestrutura.
- **Quando usar:** Para criar filas de mensagens ou jobs agendados serverless.
- **Exemplo:** Enviar notificação push 1 hora após o usuário abandonar um carrinho.

### 4.59 verification-before-completion
- **Descrição:** Declarar trabalho completo sem verificação é desonestidade, não eficiência. Usa quando QUALQUER variação de afirmação de sucesso/conclusão.
- **Quando usar:** Para garantir que trabalho está realmente completo antes de declarar como tal.
- **Exemplo:** Rodar testes, verificar logs, testar manualmente e só então declarar "feature implementada com sucesso".

### 4.60 workflow-automation
- **Descrição:** Automação de workflow é a infraestrutura que torna agentes de IA confiáveis. Com execução durável, workflows retomam exatamente de onde pararam.
- **Quando usar:** Para criar automações que precisam ser resilientes a falhas de rede ou interrupções.
- **Exemplo:** Criar um workflow de pagamento de 10 etapas que retoma do passo 7 se a rede cair no passo 8.

### 4.61 workflow-orchestration-patterns
- **Descrição:** Dominar arquitetura de orquestração de workflows com Temporal, cobrindo decisões de design fundamentais, padrões de resiliência e práticas recomendadas.
- **Quando usar:** Para projetar sistemas de orquestração de workflow robustos.
- **Exemplo:** Projetar um sistema de workflow com retry, timeout, compensation e monitoring.

### 4.62 workflow-patterns
- **Descrição:** Usa esta skill ao implementar tarefas conforme workflow TDD do Conductor, lidar com checkpoints de fase, gerenciar commits de tarefas ou entender protocolo de verificação.
- **Quando usar:** Para seguir o workflow padrão do Conductor com TDD.
- **Exemplo:** Implementar uma tarefa seguindo o ciclo: escrever teste → implementar → refactor → commit.

---

## 5. Workflow Bundle

**Ponteiro:** `workflow-bundle-category-pointer`
**Vault:** `C:/Users/Alendaviva007/.config/opencode/skill-libraries/workflow-bundle`

### 5.1 ai-ml
- **Descrição:** Workflow de IA e machine learning cobrindo desenvolvimento de aplicações LLM, implementação RAG, arquitetura de agentes, pipelines ML e features powered by AI.
- **Quando usar:** Para projetos que envolvem IA/ML do início ao fim.
- **Exemplo:** Implementar um chatbot RAG com LangChain, vector database e API de inference.

### 5.2 cloud-devops
- **Descrição:** Workflow de infraestrutura cloud e DevOps cobrindo AWS, Azure, GCP, Kubernetes, Terraform, CI/CD, monitoramento e desenvolvimento cloud-native.
- **Quando usar:** Para configurar ou gerenciar infraestrutura cloud e pipelines de deploy.
- **Exemplo:** Configurar cluster EKS no AWS com Terraform e pipeline GitLab CI/CD.

### 5.3 database
- **Descrição:** Workflow de desenvolvimento e operação de bancos de dados cobrindo SQL, NoSQL, design de banco, migrações, otimização e engenharia de dados.
- **Quando usar:** Para projetar, otimizar ou migrar bancos de dados.
- **Exemplo:** Migrar schema de banco PostgreSQL de 50 tabelas para nova normalização.

### 5.4 development
- **Descrição:** Workflow abrangente de desenvolvimento web, mobile e backend bundlando frontend, backend, full-stack e mobile para entrega ponta a ponta de aplicações.
- **Quando usar:** Para projetos de desenvolvimento completos que envolvem múltiplas camadas.
- **Exemplo:** Desenvolver uma aplicação SaaS com React frontend, Node.js backend e React Native mobile.

### 5.5 documentation
- **Descrição:** Workflow de geração de documentação cobrindo docs de API, docs de arquitetura, README, comentários de código e escrita técnica.
- **Quando usar:** Para criar ou manter documentação técnica de qualidade.
- **Exemplo:** Gerar documentação OpenAPI a partir de código Express.js existente.

### 5.6 os-scripting
- **Descrição:** Workflow de troubleshooting de sistemas operacionais e shell scripting para Linux, macOS e Windows. Cobre bash scripting, administração de sistemas, debugging e automação.
- **Quando usar:** Para criar scripts de automação ou resolver problemas de sistema.
- **Exemplo:** Criar um script bash que monitora uso de disco e envia alerta quando > 80%.

### 5.7 security-audit
- **Descrição:** Workflow abrangente de auditoria de segurança cobrindo testes de aplicação web, segurança de APIs, penetration testing, scanning de vulnerabilidades e hardening.
- **Quando usar:** Para realizar auditorias de segurança em aplicações ou APIs.
- **Exemplo:** Executar auditoria OWASP Top 10 em uma aplicação web e gerar relatório.

### 5.8 testing-qa
- **Descrição:** Workflow abrangente de testes e QA cobrindo testes unitários, integração, E2E, automação de browser e assurance de qualidade.
- **Quando usar:** Para configurar ou executar suites de teste completas.
- **Exemplo:** Configurar Jest, Cypress e Playwright para cobertura completa de testes.

### 5.9 wordpress
- **Descrição:** Workflow completo de desenvolvimento WordPress cobrindo desenvolvimento de temas, criação de plugins, integração WooCommerce, otimização de performance e hardening de segurança. Inclui features WordPress 7.0.
- **Quando usar:** Para projetos completos de desenvolvimento WordPress.
- **Exemplo:** Desenvolver um tema WordPress customizado com block editor e WooCommerce.

---

## 6. Granular Workflow Bundle

**Ponteiro:** `granular-workflow-bundle-category-pointer`
**Vault:** `C:/Users/Alendaviva007/.config/opencode/skill-libraries/granular-workflow-bundle`

### 6.1 ai-agent-development
- **Descrição:** Workflow de desenvolvimento de AI agents para construir agentes autônomos, sistemas multi-agent e orquestração de agentes com CrewAI, LangGraph e agents customizados.
- **Quando usar:** Para criar agentes de IA autônomos ou sistemas multi-agent.
- **Exemplo:** Construir um agente de pesquisa com LangGraph que busca, analisa e resume artigos.

### 6.2 api-documentation
- **Descrição:** Workflow de documentação de APIs para gerar specs OpenAPI, criar guias para desenvolvedores e manter documentação abrangente de APIs.
- **Quando usar:** Para documentar APIs de forma completa e padronizada.
- **Exemplo:** Gerar spec OpenAPI 3.1 para uma API REST com 25 endpoints.

### 6.3 api-security-testing
- **Descrição:** Workflow de testes de segurança de APIs para REST e GraphQL cobrindo autenticação, autorização, rate limiting, validação de input e práticas de segurança.
- **Quando usar:** Para testar segurança de APIs REST ou GraphQL.
- **Exemplo:** Testar uma API GraphQL para vulnerabilidades de injeção e autorização.

### 6.4 bash-scripting
- **Descrição:** Workflow de shell scripting bash para criar scripts de produção com padrões defensivos, tratamento de erros e testes.
- **Quando usar:** Para criar scripts bash robustos e production-ready.
- **Exemplo:** Criar um script de deploy com tratamento de erros, logging e rollback automático.

### 6.5 e2e-testing
- **Descrição:** Workflow de testes end-to-end com Playwright para automação de browser, regressão visual, testes cross-browser e integração CI/CD.
- **Quando usar:** Para criar testes E2E completos com Playwright.
- **Exemplo:** Criar suite de testes E2E que valida fluxo de login, compra e checkout.

### 6.6 kubernetes-deployment
- **Descrição:** Workflow de deploy Kubernetes para orquestração de containers, Helm charts, service mesh e configurações K8s production-ready.
- **Quando usar:** Para configurar ou gerenciar deploys em Kubernetes.
- **Exemplo:** Criar Helm chart para deploy de aplicação com 3 réplicas e health checks.

### 6.7 linux-troubleshooting
- **Descrição:** Workflow de troubleshooting de sistemas Linux para diagnosticar e resolver problemas de sistema, questões de performance e falhas de serviço.
- **Quando usar:** Para diagnosticar problemas em servidores Linux.
- **Exemplo:** Diagnosticar por que um serviço está consumindo 100% de CPU e resolver.

### 6.8 postgresql-optimization
- **Descrição:** Workflow de otimização PostgreSQL para ajuste de queries, estratégias de indexação, análise de performance e gerenciamento de banco de dados em produção.
- **Quando usar:** Para otimizar performance de queries ou configurações PostgreSQL.
- **Exemplo:** Identificar e otimizar 5 queries lentas com EXPLAIN ANALYZE e índices adequados.

### 6.9 python-fastapi-development
- **Descrição:** Desenvolvimento backend Python FastAPI com padrões async, SQLAlchemy, Pydantic, autenticação e padrões de API em produção.
- **Quando usar:** Para construir APIs REST de alta performance com FastAPI.
- **Exemplo:** Criar API FastAPI com autenticação JWT, SQLAlchemy ORM e validação Pydantic.

### 6.10 rag-implementation
- **Descrição:** Workflow de implementação RAG (Retrieval-Augmented Generation) cobrindo seleção de embeddings, configuração de vector database, estratégias de chunking e otimização de retrieval.
- **Quando usar:** Para implementar sistemas RAG completos.
- **Exemplo:** Criar sistema RAG com Pinecone, OpenAI embeddings e chunking semântico.

### 6.11 react-nextjs-development
- **Descrição:** Desenvolvimento de aplicações React e Next.js 14+ com App Router, Server Components, TypeScript, Tailwind CSS e padrões frontend modernos.
- **Quando usar:** Para desenvolver aplicações web modernas com React e Next.js.
- **Exemplo:** Criar dashboard Next.js 14 com Server Components, streaming e Tailwind CSS.

### 6.12 terraform-infrastructure
- **Descrição:** Workflow de infraestrutura como código Terraform para provisionar recursos cloud, criar módulos reutilizáveis e gerenciar infraestrutura em escala.
- **Quando usar:** Para gerenciar infraestrutura cloud como código com Terraform.
- **Exemplo:** Criar módulos Terraform para VPC, ECS cluster e RDS com state management remoto.

### 6.13 web-security-testing
- **Descrição:** Workflow de testes de segurança de aplicações web para vulnerabilidades OWASP Top 10 incluindo injeção, XSS, falhas de autenticação e problemas de controle de acesso.
- **Quando usar:** Para testar segurança de aplicações web contra OWASP Top 10.
- **Exemplo:** Testar uma aplicação para XSS refletido, stored e DOM-based.

### 6.14 wordpress-plugin-development
- **Descrição:** Workflow de desenvolvimento de plugins WordPress cobrindo arquitetura de plugins, hooks, interfaces admin, REST API, práticas de segurança e features WordPress 7.0.
- **Quando usar:** Para desenvolver plugins WordPress customizados.
- **Exemplo:** Criar plugin WordPress que adiciona campo customizado ao post com interface admin.

### 6.15 wordpress-theme-development
- **Descrição:** Workflow de desenvolvimento de temas WordPress cobrindo arquitetura, hierarquia de templates, custom post types, suporte a block editor e features WordPress 7.0.
- **Quando usar:** Para desenvolver temas WordPress customizados.
- **Exemplo:** Criar tema WordPress com suporte completo a block editor e patterns customizados.

### 6.16 wordpress-woocommerce-development
- **Descrição:** Workflow de desenvolvimento de loja WooCommerce cobrindo setup, integração de pagamentos, configuração de frete, customização e features WordPress 7.0.
- **Quando usar:** Para desenvolver lojas WooCommerce completas.
- **Exemplo:** Criar loja WooCommerce com gateway de pagamento personalizado e frete por região.

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

### Top 10 Skills Mais Versáteis (Project Management)

1. **jira-automation** — Gerenciamento completo de projetos ágeis
2. **linear-automation** — Alternativa moderna ao Jira
3. **to-prd** — Transforma conversas em PRDs formais
4. **to-issues** — Decompõe specs em issues acionáveis
5. **feature-tracking** — Memória duradoura entre sessões
6. **project-state-governor** — Estado canônico do projeto
7. **github-issue-creator** — Issues GitHub profissionais
8. **progressive-estimation** — Estimativas com PERT
9. **team-collaboration-standup-notes** — Notas de standup automáticas
10. **trello-automation** — Gestão Kanban visual

### Top 5 Skills Mais Úteis para Planejamento

1. **blueprint** — Planos executáveis passo a passo
2. **plan-writing** — Planejamento estruturado com dependências
3. **writing-plans** — De specs a planos de execução
4. **track-management** — Organização em tracks paralelas
5. **planning-with-files** — Estado persistente em Markdown

### Top 5 Skills Mais Úteis para Workflow

1. **commit** — Convenções de commit padronizadas
2. **executing-plans** — Execução de planos com checkpoints
3. **closed-loop-delivery** — Entrega end-to-end autônoma
4. **verification-before-completion** — Garantia de qualidade
5. **workflow-automation** — Automações resilientes

---

## Arquivos Alterados

- **Criado:** `D:\SkillsKnowledge\ProjectManagement\project_management_skills.md`

## Verificação Realizada

- ✅ Todos os 6 arquivos SKILL.md dos ponteiros de categoria foram lidos
- ✅ 149 skills documentadas com nome, descrição, caso de uso e exemplo
- ✅ Arquivo salvo com sucesso no caminho especificado
- ✅ Índice e estatísticas incluídos no documento

## Limitações

- As descrições são baseadas nos textos dos ponteiros de categoria (SKILL.md dos pointers). Para detalhes completos de cada skill, seria necessário ler o SKILL.md individual de cada uma no vault (`C:/Users/Alendaviva007/.config/opencode/skill-libraries/`)
- Os exemplos práticos são inferidos a partir das descrições, já que os SKILL.md dos ponteiros não contêm exemplos explícitos
- A documentação cobre apenas as skills listadas nos ponteiros; podem existir skills adicionais não listadas
