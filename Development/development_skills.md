# Documentação de Skills de Development

Este documento lista todas as skills relacionadas a development disponíveis no sistema, organizadas por categoria. Cada skill é documentada com nome, descrição breve, quando usar e exemplo prático quando disponível.

**Data de geração:** 2026-09-13  
**Fonte:** Arquivos SKILL.md das categorias de ponteiro

---

## 📁 Categoria: development-category-pointer

**Descrição:** Biblioteca com 186 skills especializadas em desenvolvimento.  
**Uso:** Tarefas relacionadas a desenvolvimento de software.

### Skills disponíveis:

1. **agent-harness-fault-injection**  
   - **Descrição:** Usa injeção de falhas determinística para testar recuperação de workflows de agentes.  
   - **Quando usar:** Quando um workflow de agente multi-etapas precisa evidências de recuperação para falhas de sandbox, MCP/tool, worker, checkpoint, memória ou orquestração.  
   - **Exemplo:** Testar se um agente de checkout recupera timeout de ferramenta de busca e retoma a partir do último checkpoint.

2. **agents-md**  
   - **Descrição:** Cria, revisa ou audita arquivos AGENTS.md a partir de evidências de repositório.  
   - **Quando usar:** Para documentar comportamento de agentes em repositórios, garantindo instruções corretas e escalonadas.  
   - **Exemplo:** Gerar AGENTS.md para um novo projeto que define regras de contribuição para agentes AI.

3. **agenttrace-session-audit**  
   - **Descrição:** Audita sessões de agentes de codificação locais usando agenttrace para custo, falhas de ferramenta, latência, anomalias e saúde.  
   - **Quando usar:** Para analisar sessões de agentes e identificar problemas de desempenho ou erros.  
   - **Exemplo:** Auditar uma sessão do Claude Code para verificar por que uma tarefa demorou mais que o esperado.

4. **api-endpoint-builder**  
   - **Descrição:** Constrói endpoints REST prontos para produção com validação, tratamento de erros, autenticação e documentação.  
   - **Quando usar:** Para criar novos endpoints de API seguindo boas práticas de segurança e escalabilidade.  
   - **Exemplo:** Criar endpoint POST /users com validação de entrada, hash de senha e documentação OpenAPI.

5. **api-rate-limit-handler**  
   - **Descrição:** Implementa tratamento de limitação de taxa, backoff e retry para respostas 429 e 5xx transitórias.  
   - **Quando usar:** Para integrar com APIs que possuem limites de taxa e garantir resiliência.  
   - **Exemplo:** Implementar retry exponencial ao chamar API do GitHub que retorna 429.

6. **arm-cortex-expert**  
   - **Descrição:** Engenheiro de software embarcado especialista em firmware e drivers para microcontroladores ARM Cortex-M.  
   - **Quando usar:** Para desenvolvimento de firmware para dispositivos IoT, drones, robôs.  
   - **Exemplo:** Implementar driver de sensor I2C para STM32 com interrupções.

7. **ask-copilot**  
   - **Descrição:** Usa GitHub Copilot CLI em modo não interativo para perguntas, revisão de código ou geração de snippets.  
   - **Quando usar:** Para obter respostas rápidas sobre código sem interação manual.  
   - **Exemplo:** `gh copilot suggest "como ordenar array em JavaScript"`.

8. **async-python-patterns**  
   - **Descrição:** Guia abrangente para implementação de aplicações Python assíncronas usando asyncio e padrões de programação concorrente.  
   - **Quando usar:** Para construir sistemas de alto desempenho não bloqueantes em Python.  
   - **Exemplo:** Implementar web scraper assíncrono com aiohttp e semáforo para limitar concorrência.

9. **avalonia-layout-zafiro**  
   - **Descrição:** Diretrizes para layout moderno em Avalonia UI usando Zafiro.Avalonia, enfatizando estilos compartilhados e componentes genéricos.  
   - **Quando usar:** Para desenvolvimento de interfaces desktop com Avalonia e Zafiro.  
   - **Exemplo:** Criar tema compartilhado para botões e cards em aplicação multiplataforma.

10. **avalonia-viewmodels-zafiro**  
    - **Descrição:** Padrões otimizados para criação de ViewModels e Wizards em Avalonia usando Zafiro e ReactiveUI.  
    - **Quando usar:** Para arquitetura MVVM em aplicações Avalonia.  
    - **Exemplo:** Criar ViewModel para tela de configuração com validação reativa.

11. **avalonia-zafiro-development**  
    - **Descrição:** Habilidades, convenções e regras comportamentais obrigatórias para desenvolvimento de UI em Avalonia usando toolkit Zafiro.  
    - **Quando usar:** Para garantir conformidade com padrões estabelecidos em projetos Avalonia.  
    - **Exemplo:** Aplicar convenções de nomenclatura e estrutura de pastas em projeto existente.

12. **ax-extract-workflow**  
    - **Descrição:** Reconstrói workflow por trás de um artefato de codificação passado usando sessões/commits/skills/rastros de ferramentas locais.  
    - **Quando usar:** Quando solicitado como um artefato foi construído.  
    - **Exemplo:** Explicar como uma feature específica foi implementada em um commit anterior.

13. **bash-defensive-patterns**  
    - **Descrição:** Técnicas avançadas de programação Bash defensiva para scripts de produção, pipelines CI/CD e utilitários de sistema.  
    - **Quando usar:** Para escrever scripts shell robustos com tolerância a falhas e segurança.  
    - **Exemplo:** Script de backup com tratamento de erros, logging e verificação de integridade.

14. **bash-linux**  
    - **Descrição:** Padrões de terminal Bash/Linux. Comandos críticos, pipe, tratamento de erros, scripting.  
    - **Quando usar:** Para tarefas de administração de sistemas em macOS ou Linux.  
    - **Exemplo:** Comando para encontrar e matar processos que consomem muita memória.

15. **bash-pro**  
    - **Descrição:** Mestre em scripting Bash defensivo para automação de produção, pipelines CI/CD e utilitários de sistema.  
    - **Quando usar:** Para scripts shell portáveis e testáveis em ambiente de produção.  
    - **Exemplo:** Script de deploy com rollback automático em caso de falha.

16. **bazel-build-optimization**  
    - **Descrição:** Otimiza builds Bazel para monorepos de grande escala.  
    - **Quando usar:** Para configurar Bazel, implementar execução remota ou otimizar performance de build.  
    - **Exemplo:** Configurar cache remoto para build de monorepo com 1000+ pacotes.

17. **boost-asio-pro**  
    - **Descrição:** Código de rede assíncrono em C++ com Boost.Asio ou Asio standalone.  
    - **Quando usar:** Para servidores TCP/UDP, SSL/TLS, timers, strands e operações assíncronas compostas.  
    - **Exemplo:** Servidor HTTP assíncrono com SSL usando co_await.

18. **brooks-lint**  
    - **Descrição:** Revisor de código AI baseado em livros clássicos de engenharia de software para detectar smells de design, acoplamento e riscos arquiteturais.  
    - **Quando usar:** Para revisão de código focada em problemas de design e arquitetura.  
    - **Exemplo:** Identificar violação do Princípio de Responsabilidade Única em uma classe.

19. **cmux**  
    - **Descrição:** Controla workspaces, panes, surfaces e sessões de agentes cmux com segurança a partir de fluxos de trabalho do terminal macOS.  
    - **Quando usar:** Para gerenciar múltiplos painéis de terminal e sessões de agentes.  
    - **Exemplo:** Criar layout de terminal com 4 painéis para diferentes tarefas de desenvolvimento.

20. **code-audit**  
    - **Descrição:** Revisão autorizada de segurança de código-fonte e fluxos de trabalho SAST: padrões Semgrep e CodeQL, identificação de APIs perigosas e verificação de correções.  
    - **Quando usar:** Para auditar segurança de código antes de commits ou releases.  
    - **Exemplo:** Identificar vulnerabilidades de injeção SQL em código Java.

21. **code-documentation-code-explain**  
    - **Descrição:** Especialista em educação de código que explica código complexo através de narrativas claras, diagramas visuais e análises passo a passo.  
    - **Quando usar:** Para explicar código difícil para desenvolvedores de todos os níveis.  
    - **Exemplo:** Explicar algoritmo de ordenação quicksort com diagramas e exemplos.

22. **code-documentation-doc-generate**  
    - **Descrição:** Especialista em documentação que cria documentação abrangente e sustentável a partir de código.  
    - **Quando usar:** Para gerar documentação de API, diagramas de arquitetura, guias do usuário e referências técnicas.  
    - **Exemplo:** Gerar documentação OpenAPI completa a partir de código FastAPI.

23. **code-polish**  
    - **Descrição:** Reescreve comentários de código não profissionais em claros e realiza limpeza não semântica.  
    - **Quando usar:** Para profissionalizar código sem alterar lógica ou comportamento.  
    - **Exemplo:** Transformar comentários vagos em explicações úteis.

24. **code-refactoring-context-restore**  
    - **Descrição:** Uso ao trabalhar com restauração de contexto de refatoração de código.  
    - **Quando usar:** Para restaurar contexto perdido durante refatorações complexas.  
    - **Exemplo:** Recuperar decisões de design após interrupção de sessão de refatoração.

25. **code-refactoring-tech-debt**  
    - **Descrição:** Identifica dívida técnica a partir do código real e histórico de mudanças, estima seu impacto e prioriza melhorias delimitadas com suposições explícitas.  
    - **Quando usar:** Para avaliar e priorizar melhorias de código em projetos existentes.  
    - **Exemplo:** Criar relatório de dívida técnica com estimativa de esforço para cada item.

26. **code-review-ai-ai-review**  
    - **Descrição:** Especialista em revisão de código com IA combinando análise estática automatizada, reconhecimento inteligente de padrões e práticas modernas de DevOps.  
    - **Quando usar:** Para revisão automatizada de código com ferramentas AI.  
    - **Exemplo:** Usar GitHub Copilot para identificar possíveis bugs e melhorias.

27. **code-review-and-quality**  
    - **Descrição:** Realiza revisão de código multi-eixo. Usar antes de mesclar qualquer alteração.  
    - **Quando usar:** Para avaliar qualidade do código em múltiplas dimensões antes de entrar na branch principal.  
    - **Exemplo:** Checklist de revisão incluindo segurança, performance, legibilidade e testabilidade.

28. **code-review-excellence**  
    - **Descrição:** Transforma revisões de código de bloqueio para compartilhamento de conhecimento através de feedback construtivo, análise sistemática e melhoria colaborativa.  
    - **Quando usar:** Para conduzir revisões de código produtivas e educativas.  
    - **Exemplo:** Sugerir melhorias com explicações didáticas em vez de apenas apontar problemas.

29. **code-reviewer**  
    - **Descrição:** Especialista elite em revisão de código focada em code review moderno com IA.  
    - **Quando usar:** Para revisão profunda de código com foco em qualidade e melhores práticas.  
    - **Exemplo:** Analisar PR complexo e sugerir refactorings específicos.

30. **code-showcase-core-components**  
    - **Descrição:** Biblioteca de componentes centrais e padrões de design system.  
    - **Quando usar:** Para construir UI, usar design tokens ou trabalhar com biblioteca de componentes.  
    - **Exemplo:** Criar componente Button reutilizável com variantes e tamanhos.

31. **code-showcase-react-ui-patterns**  
    - **Descrição:** Padrões modernos de React UI para estados de carregamento, tratamento de erros e busca de dados.  
    - **Quando usar:** Para construir componentes UI, lidar com dados assíncronos ou gerenciar estados de UI.  
    - **Exemplo:** Componente de lista com skeleton loading e tratamento de erro.

32. **code-showcase-systematic-debugging**  
    - **Descrição:** Metodologia de debug de quatro fases com análise de causa raiz.  
    - **Quando usar:** Para investigar bugs, corrigir falhas de testes ou solucionar comportamento inesperado.  
    - **Exemplo:** Processo sistemático para debugar memory leak em aplicação React.

33. **code-showcase-testing-patterns**  
    - **Descrição:** Padrões de teste Jest, funções factory, estratégias de mocking e workflow TDD.  
    - **Quando usar:** Para escrever testes unitários, criar factories de teste ou seguir ciclo TDD.  
    - **Exemplo:** Suite de testes para componente React com mocks de API.

34. **code-simplification**  
    - **Descrição:** Simplifica código para clareza.  
    - **Quando usar:** Para refatorar código para clareza sem alterar comportamento.  
    - **Exemplo:** Transformar função complexa em várias funções menores e nomeadas.

35. **code-simplifier**  
    - **Descrição:** Simplifica e refina código para clareza, consistência e sustentabilidade preservando todas as funcionalidades.  
    - **Quando usar:** Quando solicitado para "simplificar código", "limpar código", "refatorar para clareza".  
    - **Exemplo:** Remover código morto e simplificar condicionais complexas.

36. **codebase-audit-pre-push**  
    - **Descrição:** Auditoria profunda antes de push GitHub: remove arquivos junk, código morto, falhas de segurança e problemas de otimização.  
    - **Quando usar:** Para garantir que o código esteja pronto para produção antes de commit.  
    - **Exemplo:** Verificar cada linha de arquivo para prontidão de produção.

37. **codebase-cleanup-deps-audit**  
    - **Descrição:** Especialista em segurança de dependências especializado em verificação de vulnerabilidades, conformidade de licenças e segurança da cadeia de suprimentos.  
    - **Quando usar:** Para analisar vulnerabilidades, problemas de licenciamento e pacotes desatualizados.  
    - **Exemplo:** Relatório de dependências com vulnerabilidades conhecidas e sugestões de atualização.

38. **codebase-cleanup-refactor-clean**  
    - **Descrição:** Especialista em refatoração de código especializado em princípios de código limpo, padrões SOLID e melhores práticas de engenharia de software moderna.  
    - **Quando usar:** Para analisar e refatorar código melhorando qualidade, sustentabilidade e performance.  
    - **Exemplo:** Refatorar classe com múltiplas responsabilidades seguindo SRP.

39. **codebase-to-wordpress-converter**  
    - **Descrição:** Habilidade especialista para converter qualquer codebase (React/HTML/Next.js) em tema WordPress pixel-perfect, otimizado para SEO e dinâmico.  
    - **Quando usar:** Para migrar sites estáticos ou SPAs para WordPress.  
    - **Exemplo:** Converter site React em tema WordPress com Gutenberg blocks.

40. **cross-platform-contract-propagation-audit**  
    - **Descrição:** Uso ao auditar se um campo, enum, flag ou contrato de API se propaga consistentemente entre armazenamento, serviços, clientes, analytics e testes.  
    - **Quando usar:** Para garantir consistência de contratos em toda a pilha tecnológica.  
    - **Exemplo:** Verificar se campo `user_id` é propagado corretamente do frontend ao banco de dados.

41. **dbos-golang**  
    - **Descrição:** Guia para construir aplicações Go confiáveis e tolerantes a falhas com workflows duráveis DBOS.  
    - **Quando usar:** Para adicionar DBAS a código Go existente, criar workflows e etapas, ou usar filas para controle de concorrência.  
    - **Exemplo:** Workflow de processamento de pagamento com retentativas automáticas.

42. **dbos-python**  
    - **Descrição:** Guia para construir aplicações Python confiáveis e tolerantes a falhas com workflows duráveis DBOS.  
    - **Quando usar:** Para adicionar DBOS a código Python existente.  
    - **Exemplo:** Workflow de importação de dados com checkpoint e recuperação.

43. **dbos-typescript**  
    - **Descrição:** Guia para construir aplicações TypeScript confiáveis e tolerantes a falhas com workflows duráveis DBOS.  
    - **Quando usar:** Para adicionar DBOS a código TypeScript existente.  
    - **Exemplo:** Workflow de envio de e-mails com retry e dead-letter queue.

44. **debugging-and-error-recovery**  
    - **Descrição:** Orienta debugging de causa raiz sistemático.  
    - **Quando usar:** Quando testes falham, builds quebram, comportamento não corresponde às expectativas, ou quando encontrar qualquer erro inesperado.  
    - **Exemplo:** Processo para debugar falha intermitente em teste de integração.

45. **debugging-code**  
    - **Descrição:** Depura código-fonte interativamente - define breakpoints, percorre execução linha por linha, inspeciona estado de variáveis ao vivo, avalia expressões contra o programa em execução e navega na pilha de chamadas para rastrear causas raiz.  
    - **Quando usar:** Para debug profundo de código com inspeção de estado.  
    - **Exemplo:** Usar debugger para encontrar por que condição de borda não é tratada.

46. **debugging-toolkit**  
    - **Descrição:** Uso ao trabalhar com toolkit de debug smart (Alias para debugging-toolkit-smart-debug).  
    - **Quando usar:** Para ferramentas avançadas de debug.  
    - **Exemplo:** Usar toolkit para analisar logs e traces de aplicação.

47. **debugging-toolkit-smart-debug**  
    - **Descrição:** Uso ao trabalhar com toolkit de debug smart.  
    - **Quando usar:** Para debug inteligente com ferramentas especializadas.  
    - **Exemplo:** Analisar performance de query SQL com ferramentas de profiling.

48. **dependency-upgrade**  
    - **Descrição:** Domina atualizações de versão maiores de dependências, análise de compatibilidade, estratégias de atualização incrementais e abordagens abrangentes de teste.  
    - **Quando usar:** Para planejar e executar upgrades seguros de dependências.  
    - **Exemplo:** Migrar projeto de React 18 para React 19 com testes de regressão.

49. **devcontainer-setup**  
    - **Descrição:** Cria devcontainers com Claude Code, ferramentas específicas de linguagem (Python/Node/Rust/Go) e volumes persistentes.  
    - **Quando usar:** Para adicionar suporte a devcontainer a um projeto, configurar ambientes de desenvolvimento isolados.  
    - **Exemplo:** Configurar devcontainer para projeto Python com FastAPI e PostgreSQL.

50. **diagnosing-bugs**  
    - **Descrição:** Loop de diagnóstico para bugs difíceis e regressões de performance.  
    - **Quando usar:** Quando o usuário diz "diagnosticar"/"depurar isso" ou relata algo quebrado/lançando/falhando/lento.  
    - **Exemplo:** Diagnosticar por que aplicação consome muita memória após deploy.

51. **distribute-skill-to-all-agents**  
    - **Descrição:** Distribui uma skill para pastas de skills de agentes configurados respeitando layouts de symlink locais.  
    - **Quando usar:** Para compartilhar skills entre múltiplos agentes.  
    - **Exemplo:** Publicar nova skill para todos os agentes do time.

52. **dotnet-architect**  
    - **Descrição:** Arquiteto backend .NET especialista em C#, ASP.NET Core, Entity Framework, Dapper e padrões de aplicação empresarial.  
    - **Quando usar:** Para arquitetura e desenvolvimento de aplicações .NET robustas.  
    - **Exemplo:** Projetar API RESTful com ASP.NET Core seguindo Clean Architecture.

53. **dwarf-expert**  
    - **Descrição:** Fornece expertise para analisar arquivos de debug DWARF e entender o formato/padrão DWARF (v3-v5).  
    - **Quando usar:** Para entender informações DWARF, interagir com arquivos DWARF, responder perguntas sobre DWARF.  
    - **Exemplo:** Analisar core dump para encontrar causa raiz de crash.

54. **dx-optimizer**  
    - **Descrição:** Especialista em Experiência do Desenvolvedor. Melhora ferramentas, configuração e workflows.  
    - **Quando usar:** PROATIVAMENTE ao configurar novos projetos, após feedback da equipe, ou quando fricção de desenvolvimento é notada.  
    - **Exemplo:** Configurar ESLint, Prettier e Husky para novo projeto.

55. **ecl-harness-engineer**  
    - **Descrição:** Cria ou audita infraestrutura de ECL Agent Harness: AGENTS.md, rastreamento de mudanças, orientação de repositório, verificações lint, CI gates e docs de handoff de agentes.  
    - **Quando usar:** Para configurar infraestrutura de agentes em projeto.  
    - **Exemplo:** Criar AGENTS.md completo para repositório de microserviços.

56. **effective-agent-skills**  
    - **Descrição:** Autora e revisa skills de agentes de alta qualidade com triggers, divulgação progressiva e notas de segurança.  
    - **Quando usar:** Para criar ou melhorar skills de agentes AI.  
    - **Exemplo:** Criar skill para deploy automático com verificações de segurança.

57. **electron-development**  
    - **Descrição:** Domina desenvolvimento de apps desktop Electron com IPC seguro, contextIsolation, scripts preload, arquitetura multi-processo, empacotamento electron-builder, code signing e auto-update.  
    - **Quando usar:** Para construir aplicações desktop multiplataforma com Electron.  
    - **Exemplo:** Criar app de chat com comunicação segura entre processos.

58. **environment-setup-guide**  
    - **Descrição:** Guia desenvolvedores através da configuração de ambientes de desenvolvimento com ferramentas adequadas, dependências e configurações.  
    - **Quando usar:** Para ajudar novos desenvolvedores a configurarem seus ambientes.  
    - **Exemplo:** Guia passo a passo para configurar ambiente de desenvolvimento Python.

59. **error-debugging-error-analysis**  
    - **Descrição:** Especialista em análise de erros com experiência profunda em debugging de sistemas distribuídos, análise de incidentes de produção e implementação de soluções abrangentes de observabilidade.  
    - **Quando usar:** Para analisar erros complexos em sistemas distribuídos.  
    - **Exemplo:** Rastrear erro em microserviços usando distributed tracing.

60. **error-debugging-error-trace**  
    - **Descrição:** Especialista em rastreamento de erros e observabilidade especializado em implementar soluções abrangentes de monitoramento de erros.  
    - **Quando usar:** Para configurar sistemas de rastreamento de erros, configurar alertas, implementar logging estruturado.  
    - **Exemplo:** Configurar Sentry para rastrear erros em aplicação React + Node.js.

61. **error-debugging-multi-agent-review**  
    - **Descrição:** Uso ao trabalhar com revisão multi-agente de debug de erros.  
    - **Quando usar:** Para revisão colaborativa de erros com múltiplos agentes.  
    - **Exemplo:** Usar múltiplos agentes para analisar complexo bug de concorrência.

62. **error-detective**  
    - **Descrição:** Pesquisa padrões de erros, stack traces e anomalias em logs e codebases. Correlaciona erros entre sistemas e identifica causas raiz.  
    - **Quando usar:** Para encontrar e correlacionar erros em sistemas complexos.  
    - **Exemplo:** Rastrear erro de timeout desde o frontend até o banco de dados.

63. **error-diagnostics-error-analysis**  
    - **Descrição:** Especialista em análise de erros (similar ao error-debugging-error-analysis).  
    - **Quando usar:** Para análise profunda de erros em sistemas distribuídos.  
    - **Exemplo:** Analisar padrão de erros 500 em API e encontrar causa raiz.

64. **error-diagnostics-error-trace**  
    - **Descrição:** Especialista em rastreamento de erros (similar ao error-debugging-error-trace).  
    - **Quando usar:** Para implementar monitoramento de erros.  
    - **Exemplo:** Configurar alertas para erros críticos em produção.

65. **error-diagnostics-smart-debug**  
    - **Descrição:** Uso ao trabalhar com diagnóstico inteligente de erros.  
    - **Quando usar:** Para debug inteligente de erros.  
    - **Exemplo:** Usar ferramentas de IA para analisar logs e encontrar padrões.

66. **error-handling-patterns**  
    - **Descrição:** Constrói aplicações resilientes com estratégias robustas de tratamento de erros que lidam graciosamente com falhas e fornecem excelentes experiências de debug.  
    - **Quando usar:** Para implementar tratamento de erros em qualquer aplicação.  
    - **Exemplo:** Sistema de error boundaries em React com fallbacks user-friendly.

67. **folder-specific-claude-and-agents-md**  
    - **Descrição:** Cria orientação CLAUDE.md e AGENTS.md com escopo de pasta para futuros agentes trabalhando naquela área.  
    - **Quando usar:** Para documentar comportamento esperado de agentes em pastas específicas.  
    - **Exemplo:** Criar CLAUDE.md na pasta src/components com regras de componentes React.

68. **fp-async**  
    - **Descrição:** Padrões assíncronos práticos usando TaskEither - pipelines limpos em vez de try/catch hell, com exemplos reais de API.  
    - **Quando usar:** Para código assíncrono mais limpo e funcional.  
    - **Exemplo:** Pipeline de chamadas de API com tratamento de erros funcional.

69. **fp-backend**  
    - **Descrição:** Padrões de programação funcional para backend Node.js/Deno usando fp-ts, ReaderTaskEither e injeção de dependência funcional.  
    - **Quando usar:** Para backend funcional com TypeScript.  
    - **Exemplo:** Serviço de usuário com ReaderTaskEither para dependências.

70. **fp-data-transforms**  
    - **Descrição:** Transformações de dados do dia a dia usando padrões funcionais - arrays, objetos, agrupamento, agregação e acesso null-safe.  
    - **Quando usar:** Para transformações de dados limpas e funcionais.  
    - **Exemplo:** Agrupar e filtrar lista de usuários com pipe.

71. **fp-either-ref**  
    - **Descrição:** Referência rápida para tipo Either.  
    - **Quando usar:** Quando precisa de tratamento de erros, validação ou operações que podem falhar com erros tipados.  
    - **Exemplo:** Validar entrada de usuário retornando Either<Error, User>.

72. **fp-errors**  
    - **Descrição:** Para de lançar erros em todo lugar - trate erros como valores usando Either e TaskEither para código mais limpo e previsível.  
    - **Quando usar:** Para tratamento de erros funcional.  
    - **Exemplo:** Substituir try/catch por encadeamento de Either.

73. **fp-option-ref**  
    - **Descrição:** Referência rápida para tipo Option.  
    - **Quando usar:** Para lidar com valores nullable, dados opcionais ou evitar null checks.  
    - **Exemplo:** Buscar usuário retornando Option<User> em vez de User | null.

74. **fp-pipe-ref**  
    - **Descrição:** Referência rápida para pipe e flow.  
    - **Quando usar:** Para encadear funções, compor operações ou construir pipelines de dados.  
    - **Exemplo:** `pipe(data, filter, map, reduce)`.

75. **fp-pragmatic**  
    - **Descrição:** Guia prático e sem jargão para programação funcional - a abordagem 80/20 que obtém resultados sem a sobrecarga acadêmica.  
    - **Quando usar:** Para aprender programação funcional de forma prática.  
    - **Exemplo:** Usar funções puras e imutabilidade no dia a dia.

76. **fp-react**  
    - **Descrição:** Padrões práticos para usar fp-ts com React - hooks, estado, formulários, busca de dados. Funciona com React 18/19, Next.js 14/15.  
    - **Quando usar:** Para React com programação funcional.  
    - **Exemplo:** Hook useEither para gerenciar estado de erro em componente.

77. **fp-refactor**  
    - **Descrição:** Guia abrangente para refatorar código TypeScript imperativo para padrões funcionais fp-ts.  
    - **Quando usar:** Para migrar código existente para estilo funcional.  
    - **Exemplo:** Refatorar função com múltiplos return para usar Either.

78. **fp-taskeither-ref**  
    - **Descrição:** Referência rápida para TaskEither.  
    - **Quando usar:** Para tratamento de erros assíncrono, chamadas de API ou operações baseadas em Promise que podem falhar.  
    - **Exemplo:** `fetchUser(id).pipe(mapLeft(toAppError))`.

79. **fp-ts-errors**  
    - **Descrição:** Trate erros como valores usando Either e TaskEither do fp-ts para código mais limpo e previsível.  
    - **Quando usar:** Para implementar padrões de tratamento de erros com fp-ts.  
    - **Exemplo:** Serviço de pagamento com tratamento funcional de erros.

80. **fp-ts-pragmatic**  
    - **Descrição:** Guia prático para programação funcional com fp-ts - abordagem 80/20.  
    - **Quando usar:** Para usar fp-ts de forma prática em TypeScript.  
    - **Exemplo:** Usar Option para optional chaining e validação.

81. **fp-ts-react**  
    - **Descrição:** Padrões práticos para usar fp-ts com React.  
    - **Quando usar:** Para React com programação funcional e fp-ts.  
    - **Exemplo:** Componente com estado gerenciado por StateEither.

82. **fp-types-ref**  
    - **Descrição:** Referência rápida para tipos fp-ts.  
    - **Quando usar:** Quando pergunta qual tipo usar, precisa de ajuda na decisão Option/Either/Task.  
    - **Exemplo:** Decidir entre Option e Either para dado nullable que pode falhar.

83. **framework-migration-code-migrate**  
    - **Descrição:** Especialista em migração de código especializado em transição de codebases entre frameworks, linguagens, versões e plataformas.  
    - **Quando usar:** Para planejar e executar migrações de frameworks.  
    - **Exemplo:** Migrar aplicação Angular para React.

84. **framework-migration-deps-upgrade**  
    - **Descrição:** Especialista em gerenciamento de dependências especializado em upgrades seguros e incrementais.  
    - **Quando usar:** Para planejar e executar upgrades de dependências com risco mínimo.  
    - **Exemplo:** Atualizar Next.js 13 para Next.js 14 com testes.

85. **framework-migration-legacy-modernize**  
    - **Descrição:** Orquestra modernização abrangente de sistemas legados usando padrão strangler fig.  
    - **Quando usar:** Para substituir gradualmente componentes obsoletos mantendo operações contínuas.  
    - **Exemplo:** Migrar monolito PHP para microserviços Node.js.

86. **gdb-cli**  
    - **Descrição:** Assistente de debug GDB para agentes AI - analisa core dumps, depura processos ao vivo, investiga crashes e deadlocks com correlação de código-fonte.  
    - **Quando usar:** Para debug de programas C/C++ com GDB.  
    - **Exemplo:** Analisar core dump de aplicação C para encontrar memory leak.

87. **global-chat-agent-discovery**  
    - **Descrição:** Descobre e pesquisa mais de 18K servidores MCP e agentes AI em 6+ registros usando diretório cross-protocol do Global Chat.  
    - **Quando usar:** Para encontrar servidores MCP e agentes AI para integração.  
    - **Exemplo:** Descobrir servidor MCP para integração com GitHub.

88. **go-concurrency-patterns**  
    - **Descrição:** Domina concorrência em Go com goroutines, channels, primitivas sync e context.  
    - **Quando usar:** Para construir aplicações Go concorrentes, implementar worker pools ou depurar race conditions.  
    - **Exemplo:** Worker pool para processamento paralelo de imagens.

89. **go-in-depth**  
    - **Descrição:** Harness Go in depth - buscas web fan-out, busca de fontes, verificação adversarial de alegações, síntese de relatório citado.  
    - **Quando usar:** Para pesquisa profunda sobre tópicos Go.  
    - **Exemplo:** Pesquisar melhores práticas de concorrência em Go com fontes verificadas.

90. **go-rod-master**  
    - **Descrição:** Guia abrangente para automação de navegador e web scraping com go-rod (Chrome DevTools Protocol) incluindo padrões stealth anti-bot-detection.  
    - **Quando usar:** Para automação de navegador e scraping em Go.  
    - **Exemplo:** Scraper que ignora detecção de bots.

91. **go-rust-reverse**  
    - **Descrição:** Engenharia reversa de binários Go e Rust stripped: reconhecimento de runtime, recuperação de metadados pclntab/module, análise de panic-string e estratégias de descompilação idiomáticas.  
    - **Quando usar:** Para analisar binários compilados sem símbolos.  
    - **Exemplo:** Extrair informações de binário Rust para entender seu comportamento.

92. **graceful-shutdown**  
    - **Descrição:** Implementa encerramento gracioso para servidores e workers: drena conexões, finaliza trabalho em voo, libera recursos e sai limpo em SIGTERM/SIGINT.  
    - **Quando usar:** Para garantir que aplicações parem graciosamente.  
    - **Exemplo:** Servidor HTTP que drena conexões existentes antes de parar.

93. **grpc-golang**  
    - **Descrição:** Constrói serviços gRPC prontos para produção em Go com mTLS, streaming e observabilidade.  
    - **Quando usar:** Para projetar contratos Protobuf com Buf ou implementar transporte seguro service-to-service.  
    - **Exemplo:** Serviço gRPC com autenticação mTLS e streaming bidirecional.

94. **hig-components-content**  
    - **Descrição:** Diretrizes Apple Human Interface Guidelines para componentes de exibição de conteúdo.  
    - **Quando usar:** Para seguir diretrizes Apple em componentes de conteúdo.  
    - **Exemplo:** Criar componente de lista seguindo HIG.

95. **hig-components-controls**  
    - **Descrição:** Verifica .claude/apple-design-context.md antes de fazer perguntas.  
    - **Quando usar:** Para componentes de controle seguindo Apple HIG.  
    - **Exemplo:** Criar toggle switch seguindo diretrizes Apple.

96. **hig-components-dialogs**  
    - **Descrição:** Diretrizes Apple HIG para componentes de apresentação incluindo alerts, action sheets, popovers, sheets.  
    - **Quando usar:** Para criar diálogos seguindo padrões Apple.  
    - **Exemplo:** Criar alerta de confirmação seguindo HIG.

97. **hig-components-layout**  
    - **Descrição:** Diretrizes Apple Human Interface Guidelines para componentes de layout e navegação.  
    - **Quando usar:** Para layouts e navegação em apps Apple.  
    - **Exemplo:** Criar navigation bar seguindo HIG.

98. **hig-components-menus**  
    - **Descrição:** Verifica .claude/apple-design-context.md antes de fazer perguntas.  
    - **Quando usar:** Para menus seguindo Apple HIG.  
    - **Exemplo:** Criar dropdown menu seguindo diretrizes.

99. **hig-components-search**  
    - **Descrição:** Diretrizes Apple HIG para componentes relacionados a navegação incluindo campos de busca, page controls e path controls.  
    - **Quando usar:** Para campos de busca em apps Apple.  
    - **Exemplo:** Criar search bar seguindo HIG.

100. **hig-components-status**  
    - **Descrição:** Diretrizes Apple HIG para componentes de status e progresso incluindo progress indicators, status bars e activity rings.  
     - **Quando usar:** Para indicadores de progresso e status.  
     - **Exemplo:** Criar progress bar seguindo HIG.

101. **hig-components-system**  
     - **Descrição:** Diretrizes Apple HIG para componentes de experiência do sistema: widgets, live activities, notificações, complications, home screen quick actions, top shelf, watch faces, app clips e app shortcuts.  
     - **Quando usar:** Para componentes de sistema Apple.  
     - **Exemplo:** Criar widget para iOS seguindo HIG.

102. **hig-foundations**  
     - **Descrição:** Fundamentos de design Apple Human Interface Guidelines.  
     - **Quando usar:** Para fundamentos de design Apple.  
     - **Exemplo:** Aplicar tipografia e cores do Apple Design System.

103. **hig-inputs**  
     - **Descrição:** Verifica .claude/apple-design-context.md antes de fazer perguntas.  
     - **Quando usar:** Para inputs seguindo Apple HIG.  
     - **Exemplo:** Criar formulário de entrada seguindo diretrizes.

104. **hig-patterns**  
     - **Descrição:** Diretrizes Apple Human Interface Guidelines para padrões de interação e UX.  
     - **Quando usar:** Para padrões de interação em apps Apple.  
     - **Exemplo:** Implementar gesto de swipe seguindo HIG.

105. **hig-platforms**  
     - **Descrição:** Diretrizes Apple Human Interface Guidelines para design específico de plataforma.  
     - **Quando usar:** Para apps específicos de plataforma Apple.  
     - **Exemplo:** Adaptar UI para watchOS seguindo HIG.

106. **hig-project-context**  
     - **Descrição:** Cria ou atualiza documento compartilhado de contexto de design Apple que outras skills HIG usam para personalizar orientação.  
     - **Quando usar:** Para criar contexto compartilhado de design Apple.  
     - **Exemplo:** Criar apple-design-context.md para projeto.

107. **hig-technologies**  
     - **Descrição:** Verifica .claude/apple-design-context.md antes de fazer perguntas.  
     - **Quando usar:** Para tecnologias Apple seguindo HIG.  
     - **Exemplo:** Usar SwiftUI seguindo diretrizes Apple.

108. **i18n-localization**  
     - **Descrição:** Padrões de internacionalização e localização. Detecção de strings hardcoded, gerenciamento de traduções, arquivos de localização, suporte RTL.  
     - **Quando usar:** Para internacionalizar aplicações.  
     - **Exemplo:** Configurar next-intl para app Next.js multilíngue.

109. **improve-codebase-architecture**  
     - **Descrição:** Escaneia codebase para oportunidades de aprofundamento, apresenta-as como relatório HTML visual, depois analisa a que você escolher.  
     - **Quando usar:** Para melhorar arquitetura de projeto existente.  
     - **Exemplo:** Analisar e sugerir melhorias de arquitetura para app monolítico.

110. **instructree**  
     - **Descrição:** Mapeia, explica e verifica instruções de codificação de agentes com escopo de repositório antes de alterar código.  
     - **Quando usar:** Para entender e validar instruções de agentes em repositório.  
     - **Exemplo:** Analisar AGENTS.md e CLAUDE.md para garantir consistência.

111. **javascript-mastery**  
     - **Descrição:** 33+ conceitos essenciais de JavaScript que todo desenvolvedor deveria saber, inspirado em 33-js-concepts.  
     - **Quando usar:** Para aprender ou revisar conceitos fundamentais de JavaScript.  
     - **Exemplo:** Estudar closure, prototypes, event loop.

112. **javascript-testing-patterns**  
     - **Descrição:** Guia abrangente para implementar estratégias de teste robustas em aplicações JavaScript/TypeScript usando frameworks modernos.  
     - **Quando usar:** Para escrever testes em projetos JavaScript/TypeScript.  
     - **Exemplo:** Configurar Jest com testes de unidade e integração.

113. **jq**  
     - **Descrição:** Uso expert de jq para consulta, filtragem, transformação de JSON e integração com pipeline. Padrões práticos para workflows reais de shell.  
     - **Quando usar:** Para processar JSON no terminal.  
     - **Exemplo:** `cat data.json | jq '.users[] | select(.age > 18)'`.

114. **kotlin-coroutines-expert**  
     - **Descrição:** Padrões expert para Kotlin Coroutines e Flow, cobrindo concorrência estruturada, tratamento de erros e testes.  
     - **Quando usar:** Para código Kotlin assíncrono com coroutines.  
     - **Exemplo:** Implementar repository com Flow e tratamento de erros.

115. **laravel-development-workflow**  
     - **Descrição:** Constrói e corrige aplicações Laravel existentes através de diagnóstico de causa raiz, implementação nativa do repositório, cobertura de regressão e verificação baseada em risco.  
     - **Quando usar:** Para desenvolvimento e manutenção de aplicações Laravel.  
     - **Exemplo:** Debugar e corrigir bug em aplicação Laravel existente.

116. **legacy-modernizer**  
     - **Descrição:** Refatora codebases legados, migra frameworks desatualizados e implementa modernização gradual.  
     - **Quando usar:** Para lidar com dívida técnica, atualização de dependências e compatibilidade retroativa.  
     - **Exemplo:** Migrar jQuery para React gradualmente.

117. **linux-shell-scripting**  
     - **Descrição:** Fornece templates de scripts shell prontos para produção para tarefas comuns de administração de sistemas Linux incluindo backups, monitoramento, gerenciamento de usuários, análise de logs e automação.  
     - **Quando usar:** Para scripts de administração de sistemas Linux.  
     - **Exemplo:** Script de backup automático com rotação.

118. **logic-lens**  
     - **Descrição:** Habilidade de revisão de código com IA que realiza revisão profunda usando lógica formal e frameworks de raciocínio para detectar bugs, anti-padrões e riscos de segurança.  
     - **Quando usar:** Para revisão de código focada em lógica e segurança.  
     - **Exemplo:** Detectar race condition usando análise lógica.

119. **lore**  
     - **Descrição:** Memória de projeto markdown para agentes AI.  
     - **Quando usar:** Para decisões, arquitetura, convenções, escopos de monorepo, `.lore/` ou comandos `lore`.  
     - **Exemplo:** Criar lore.md com decisões de arquitetura do projeto.

120. **makepad-animation**  
     - **Descrição:** CRÍTICO: Usar para sistema de animação Makepad.  
     - **Quando usar:** Para animações em apps Makepad.  
     - **Exemplo:** Implementar animação de hover em botão Makepad.

121. **makepad-basics**  
     - **Descrição:** CRÍTICO: Usar para introdução Makepad e estrutura de app.  
     - **Quando usar:** Para começar com Makepad.  
     - **Exemplo:** Criar primeiro app Makepad "Hello World".

122. **makepad-deployment**  
     - **Descrição:** CRÍTICO: Usar para empacotamento e deploy Makepad.  
     - **Quando usar:** Para empacotar e distribuir apps Makepad.  
     - **Exemplo:** Gerar APK para Android a partir de app Makepad.

123. **makepad-dsl**  
     - **Descrição:** CRÍTICO: Usar para sintaxe DSL e herança Makepad.  
     - **Quando usar:** Para definir componentes Makepad.  
     - **Exemplo:** Criar widget customizado usando Makepad DSL.

124. **makepad-event-action**  
     - **Descrição:** CRÍTICO: Usar para tratamento de eventos e ações Makepad.  
     - **Quando usar:** Para lidar com eventos em apps Makepad.  
     - **Exemplo:** Tratar clique de botão e toque em tela.

125. **makepad-font**  
     - **Descrição:** CRÍTICO: Usar para fonte e renderização de texto Makepad.  
     - **Quando usar:** Para tipografia em apps Makepad.  
     - **Exemplo:** Carregar fonte customizada e renderizar texto.

126. **makepad-layout**  
     - **Descrição:** CRÍTICO: Usar para sistema de layout Makepad.  
     - **Quando usar:** Para layouts em apps Makepad.  
     - **Exemplo:** Criar layout flexível com padding e margin.

127. **makepad-platform**  
     - **Descrição:** CRÍTICO: Usar para suporte multiplataforma Makepad.  
     - **Quando usar:** Para apps Makepad em múltiplas plataformas.  
     - **Exemplo:** Compilar app Makepad para Windows, macOS e Linux.

128. **makepad-reference**  
     - **Descrição:** Esta categoria fornece materiais de referência para debug, qualidade de código e padrões avançados de layout.  
     - **Quando usar:** Para referência durante desenvolvimento Makepad.  
     - **Exemplo:** Consultar documentação de componentes Makepad.

129. **makepad-shaders**  
     - **Descrição:** CRÍTICO: Usar para sistema de shaders Makepad.  
     - **Quando usar:** Para shaders e renderização GPU em Makepad.  
     - **Exemplo:** Criar efeito de gradiente usando Sdf2d.

130. **makepad-skills**  
     - **Descrição:** Habilidades de desenvolvimento UI Makepad para apps Rust: configuração, padrões, shaders, empacotamento e solução de problemas.  
     - **Quando usar:** Para desenvolvimento Makepad abrangente.  
     - **Exemplo:** Configurar projeto Makepad com todas as habilidades necessárias.

131. **makepad-splash**  
     - **Descrição:** CRÍTICO: Usar para linguagem de script Splash Makepad.  
     - **Quando usar:** Para scripting dinâmico em Makepad.  
     - **Exemplo:** Criar script Splash para comportamento dinâmico.

132. **makepad-widgets**  
     - **Descrição:** Versão: makepad-widgets (dev branch) | Última atualização: 2026-01-19.  
     - **Quando usar:** Para widgets Makepad.  
     - **Exemplo:** Usar widgets pré-construídos em app Makepad.

133. **memory-safety-patterns**  
     - **Descrição:** Padrões cross-language para programação memory-safe incluindo RAII, ownership, smart pointers e gerenciamento de recursos.  
     - **Quando usar:** Para código seguro em termos de memória.  
     - **Exemplo:** Usar smart pointers em C++ para evitar memory leaks.

134. **modern-javascript-patterns**  
     - **Descrição:** Guia abrangente para dominar recursos modernos de JavaScript (ES6+), padrões de programação funcional e melhores práticas.  
     - **Quando usar:** Para aprender e aplicar JavaScript moderno.  
     - **Exemplo:** Usar optional chaining, nullish coalescing e destructuring.

135. **monorepo-architect**  
     - **Descrição:** Especialista em arquitetura de monorepo, sistemas de build e gerenciamento de dependências em escala. Domina Nx, Turborepo, Bazel e Lerna.  
     - **Quando usar:** PROATIVAMENTE para configuração de monorepo, otimização de builds ou implementação de cache.  
     - **Exemplo:** Configurar monorepo com Nx e cache remoto.

136. **monorepo-management**  
     - **Descrição:** Constrói monorepos eficientes e escaláveis que permitem compartilhamento de código, ferramentas consistentes e mudanças atômicas.  
     - **Quando usar:** Para gerenciar projetos com múltiplos pacotes.  
     - **Exemplo:** Configurar monorepo com Turborepo para app Next.js + biblioteca compartilhada.

137. **multi-platform-apps-multi-platform**  
     - **Descrição:** Constrói e implanta a mesma feature consistentemente em web, mobile e desktop usando arquitetura API-first e estratégias de implementação paralela.  
     - **Quando usar:** Para desenvolvimento cross-platform.  
     - **Exemplo:** Criar feature de chat que funciona em web, iOS e Android.

138. **native-data-fetching**  
     - **Descrição:** Uso ao implementar ou depurar QUALQUER requisição de rede, chamada de API ou busca de dados.  
     - **Quando usar:** Para buscar dados de APIs.  
     - **Exemplo:** Implementar fetch com React Query e cache.

139. **nx-workspace-patterns**  
     - **Descrição:** Configura e otimiza workspaces Nx monorepo.  
     - **Quando usar:** Para configurar Nx, definir limites de projeto, otimizar cache de build.  
     - **Exemplo:** Configurar bibliotecas compartilhadas no Nx.

140. **ontoly-software-graph**  
     - **Descrição:** Usa Software Graph determinístico do Ontoly, MCP server e skills de agente para revisão de arquitetura, rastreamento de requisições, análise de impacto e análise de dependências.  
     - **Quando usar:** Para análise de dependências e impacto.  
     - **Exemplo:** Analisar impacto de alteração em API pública.

141. **orca-replay**  
     - **Descrição:** Responde perguntas sobre uma execução passada de agente a partir de sua gravação em vez de memória, e reproduz ou bifurca essa execução.  
     - **Quando usar:** Para entender por que uma execução anterior fez algo, ou reproduzir uma falha.  
     - **Exemplo:** Reproduzir falha de deploy para entender causa raiz.

142. **performance-engineer**  
     - **Descrição:** Engenheiro de performance especialista em observabilidade moderna.  
     - **Quando usar:** Para otimização de performance e observabilidade.  
     - **Exemplo:** Implementar monitoring de performance em API.

143. **performance-optimization**  
     - **Descrição:** Otimiza performance de aplicações.  
     - **Quando usar:** Quando existem requisitos de performance, quando suspeitar de regressões de performance, ou quando Core Web Vitals ou tempos de carregamento precisam melhorar.  
     - **Exemplo:** Otimizar bundle size de app React.

144. **performance-optimizer**  
     - **Descrição:** Identifica e corrige gargalos de performance em código, bancos de dados e APIs. Mede antes e depois para provar melhorias.  
     - **Quando usar:** Para identificar e corrigir problemas de performance.  
     - **Exemplo:** Otimizar query SQL lenta com indexação.

145. **performance-profiling**  
     - **Descrição:** Princípios de profiling de performance. Técnicas de medição, análise e otimização.  
     - **Quando usar:** Para medir e analisar performance.  
     - **Exemplo:** Usar Chrome DevTools para profilear app React.

146. **performance-testing-review-ai-review**  
     - **Descrição:** Especialista em revisão de código com IA combinando análise estática automatizada.  
     - **Quando usar:** Para revisão de código focada em performance.  
     - **Exemplo:** Identificar operações O(n²) em código.

147. **performance-testing-review-multi-agent-review**  
     - **Descrição:** Uso ao trabalhar com revisão multi-agente de teste de performance.  
     - **Quando usar:** Para revisão colaborativa de testes de performance.  
     - **Exemplo:** Usar múltiplos agentes para analisar resultados de load test.

148. **poka-yoke**  
     - **Descrição:** Código, config e processo à prova de erros: torna a ação errada impossível ou autoanunciante em vez de documentada.  
     - **Quando usar:** Para prevenir erros em código e processos.  
     - **Exemplo:** Usar tipos para tornar estados inválidos não representáveis.

149. **prototype**  
     - **Descrição:** Constrói protótipo descartável para esboçar design - app terminal executável para perguntas de estado/lógica de negócio, ou várias variações de UI radicalmente diferentes alternáveis a partir de uma rota.  
     - **Quando usar:** Para validar design rapidamente.  
     - **Exemplo:** Criar protótipo interativo para testar fluxo de usuário.

150. **push-skill-to-github**  
     - **Descrição:** Commit e push alterações de skill para repositório de skills configurado após revisão e validação.  
     - **Quando usar:** Para publicar skills após desenvolvimento.  
     - **Exemplo:** Push de nova skill para repositório compartilhado.

151. **pydantic-models-py**  
     - **Descrição:** Cria modelos Pydantic seguindo padrão multi-model para contratos de API limpos.  
     - **Quando usar:** Para definir modelos de dados em Python com validação.  
     - **Exemplo:** Criar schemas de request/response com Pydantic.

152. **python-development**  
     - **Descrição:** Especialista em arquitetura de projetos Python especializado em scaffolding de aplicações Python prontas para produção.  
     - **Quando usar:** Para criar novos projetos Python com estrutura adequada.  
     - **Exemplo:** Criar projeto FastAPI com uv, testes e configuração.

153. **python-development-python-scaffold**  
     - **Descrição:** Especialista em arquitetura de projetos Python (similar ao anterior).  
     - **Quando usar:** Para scaffolding de projetos Python.  
     - **Exemplo:** Criar estrutura de projeto com pasta tests, src e configuração.

154. **python-packaging**  
     - **Descrição:** Guia abrangente para criar, estruturar e distribuir pacotes Python usando ferramentas modernas de empacotamento, pyproject.toml e publicação no PyPI.  
     - **Quando usar:** Para empacotar e distribuir bibliotecas Python.  
     - **Exemplo:** Criar pacote Python com poetry e publicar no PyPI.

155. **python-patterns**  
     - **Descrição:** Princípios de desenvolvimento Python e tomada de decisão. Seleção de framework, padrões assíncronos, type hints, estrutura de projeto.  
     - **Quando usar:** Para decisões de design em projetos Python.  
     - **Exemplo:** Escolher entre Django e FastAPI para novo projeto.

156. **python-performance-optimization**  
     - **Descrição:** Profile e otimize código Python usando cMemory profilers e melhores práticas de performance.  
     - **Quando usar:** Para debugar código Python lento, otimizar gargalos.  
     - **Exemplo:** Usar cProfile para identificar função lenta.

157. **python-pptx-generator**  
     - **Descrição:** Gera scripts Python completos que constroem apresentações PowerPoint polidas com python-pptx e conteúdo real de slides.  
     - **Quando usar:** Para criar apresentações PowerPoint programaticamente.  
     - **Exemplo:** Gerar relatório mensal em formato PowerPoint.

158. **python-testing-patterns**  
     - **Descrição:** Implementa estratégias abrangentes de teste com pytest, fixtures, mocking e desenvolvimento orientado a testes.  
     - **Quando usar:** Para escrever testes em projetos Python.  
     - **Exemplo:** Criar suite de testes com pytest e fixtures.

159. **rayden-code**  
     - **Descrição:** Gera código React com componentes Rayden UI usando props corretas, tokens e padrões de layout premium.  
     - **Quando usar:** Para criar componentes React com Rayden UI.  
     - **Exemplo:** Criar dashboard com componentes Rayden.

160. **robius-app-architecture**  
     - **Descrição:** CRÍTICO: Usar para padrões de arquitetura de app Robius.  
     - **Quando usar:** Para arquitetura de apps Robius.  
     - **Exemplo:** Estruturar app Robius com Tokio e async.

161. **robius-event-action**  
     - **Descrição:** CRÍTICO: Usar para padrões de eventos e ações Robius.  
     - **Quando usar:** Para tratamento de eventos em apps Robius.  
     - **Exemplo:** Implementar custom action em app Robius.

162. **robius-matrix-integration**  
     - **Descrição:** CRÍTICO: Usar para integração Matrix SDK com Makepad.  
     - **Quando usar:** Para integração com protocolo Matrix.  
     - **Exemplo:** Criar cliente Matrix usando Robius.

163. **robius-state-management**  
     - **Descrição:** CRÍTICO: Usar para padrões de gerenciamento de estado Robius.  
     - **Quando usar:** Para estado em apps Robius.  
     - **Exemplo:** Implementar AppState com persistência.

164. **robius-widget-patterns**  
     - **Descrição:** CRÍTICO: Usar para padrões de widgets Robius.  
     - **Quando usar:** Para widgets reutilizáveis em Robius.  
     - **Exemplo:** Criar widget modal reutilizável.

165. **runapi-cli**  
     - **Descrição:** Gera imagens, vídeos e música/áudio de IA a partir de agentes usando RunAPI CLI.  
     - **Quando usar:** Para gerar conteúdo multimídia com IA.  
     - **Exemplo:** Gerar imagem a partir de prompt de texto.

166. **rust-async-patterns**  
     - **Descrição:** Domina programação assíncrona Rust com Tokio, traits assíncronos, tratamento de erros e padrões concorrentes.  
     - **Quando usar:** Para construir aplicações Rust assíncronas.  
     - **Exemplo:** Implementar servidor HTTP assíncrono com Axum.

167. **senior-architect**  
     - **Descrição:** Kit completo para arquiteto sênior com ferramentas modernas e melhores práticas.  
     - **Quando usar:** Para decisões de arquitetura de alto nível.  
     - **Exemplo:** Projetar sistema distribuído para alta disponibilidade.

168. **senior-fullstack**  
     - **Descrição:** Kit completo para desenvolvedor fullstack sênior com ferramentas modernas e melhores práticas.  
     - **Quando usar:** Para desenvolvimento fullstack completo.  
     - **Exemplo:** Construir feature completa do frontend ao backend.

169. **setup-matt-pocock-skills**  
     - **Descrição:** Configura este repositório para as habilidades de engenharia - configura seu issue tracker, vocabulário de labels de triagem e layout de documentação de domínio.  
     - **Quando usar:** Uma vez antes do primeiro uso das outras habilidades de engenharia.  
     - **Exemplo:** Rodar uma vez para configurar repositório.

170. **skill-check**  
     - **Descrição:** Valida skills de Claude Code contra a especificação agentskills. Captura problemas estruturais, semânticos e de nomenclatura antes dos usuários.  
     - **Quando usar:** Para validar skills antes de publicar.  
     - **Exemplo:** Verificar se skill segue o padrão agentskills.

171. **spec-driven-loop**  
     - **Descrição:** Congela PRD, design técnico e critérios de aceitação antes de trabalho Codex de médio a grande porte; coordena agentes com posse explícita, depois julga entrega a partir de diffs, testes e evidências.  
     - **Quando usar:** Para projetos maiores que precisam de planejamento.  
     - **Exemplo:** Criar PRD e design técnico antes de implementar feature complexa.

172. **squirrel**  
     - **Descrição:** Habilidade de codificação AI de ciclo completo: planeja, constrói, testa, linta, corrige bugs e escreve docs prontos para produção. Auto-detecta estado do projeto e adapta seu pipeline de 8 fases.  
     - **Quando usar:** Para desenvolvimento completo de feature.  
     - **Exemplo:** Usar para implementar feature completa com testes e documentação.

173. **systems-programming-rust-project**  
     - **Descrição:** Especialista em arquitetura de projetos Rust especializado em scaffolding de aplicações Rust prontas para produção.  
     - **Quando usar:** Para criar novos projetos Rust.  
     - **Exemplo:** Criar projeto Rust com estrutura adequada e testes.

174. **tdd**  
     - **Descrição:** Desenvolvimento orientado a testes.  
     - **Quando usar:** Quando o usuário quiser construir features ou corrigir bugs test-first, mencionar "red-green-refactor", ou quiser testes de integração.  
     - **Exemplo:** Escrever teste primeiro, depois implementar código.

175. **technical-change-tracker**  
     - **Descrição:** Rastreia alterações de código com registros JSON estruturados, enforcement de máquina de estados e handoff de sessão AI para continuidade de bot.  
     - **Quando usar:** Para rastrear mudanças técnicas de forma estruturada.  
     - **Exemplo:** Registrar cada mudança de código com contexto e estado.

176. **tmux**  
     - **Descrição:** Gerenciamento expert de sessões, janelas e painéis tmux para multiplexação de terminal, workflows remotos persistentes e automação de shell scripting.  
     - **Quando usar:** Para gerenciar múltiplos terminais.  
     - **Exemplo:** Criar sessão tmux com janelas para diferentes tarefas.

177. **tree-ring-memory**  
     - **Descrição:** Usa Tree Ring Memory para trabalho de ciclo de vida de memória de agente AI local-first: recall, evidência, auditoria, esquecimento e consolidação sem dump de transcript.  
     - **Quando usar:** Para memória persistente de agentes AI.  
     - **Exemplo:** Implementar recall de contexto entre sessões de agente.

178. **triage**  
     - **Descrição:** Move issues e PRs externos através de uma máquina de estados de funções de triagem - categoriza, verifica, analisa se necessário e escreve briefs prontos para agentes.  
     - **Quando usar:** Para gerenciar issues e PRs.  
     - **Exemplo:** Triagem automática de issues com labels e assignment.

179. **turborepo-caching**  
     - **Descrição:** Configura Turborepo para builds eficientes de monorepo com cache local e remoto.  
     - **Quando usar:** Para configurar Turborepo, otimizar pipelines de build.  
     - **Exemplo:** Configurar cache remoto com Turborepo.

180. **unship**  
     - **Descrição:** Compara variantes de UI feitas por agentes AI localmente em um app real, depois mantém uma e limpa código temporário não utilizado.  
     - **Quando usar:** Para comparar alternativas de UI.  
     - **Exemplo:** Testar duas abordagens de layout e escolher a melhor.

181. **using-git-worktrees**  
     - **Descrição:** Git worktrees criam workspaces isolados compartilhando o mesmo repositório, permitindo trabalho em múltiplas branches simultaneamente sem trocar.  
     - **Quando usar:** Para trabalhar em múltiplas features simultaneamente.  
     - **Exemplo:** Criar worktree para feature branch sem stashar alterações atuais.

182. **using-lwc**  
     - **Descrição:** Uso quando decisões de projeto, estrutura de código, pesquisa, incidentes ou contexto verificado devem sobreviver sessões futuras de agentes de codificação através de memória LWC e índices de grafo.  
     - **Quando usar:** Para memória persistente de projeto.  
     - **Exemplo:** Armazenar decisões de design para referência futura.

183. **uv-package-manager**  
     - **Descrição:** Guia abrangente para usar uv, um instalador e resolvedor de pacotes Python extremamente rápido escrito em Rust.  
     - **Quando usar:** Para gerenciamento de dependências Python moderno.  
     - **Exemplo:** Usar uv para instalar e gerenciar pacotes Python.

184. **vexor**  
     - **Descrição:** CLI baseado em vetor para busca semântica de arquivos com skill Claude/Codex.  
     - **Quando usar:** Para busca semântica em repositórios.  
     - **Exemplo:** Encontrar onde uma função específica é implementada.

185. **vexor-cli**  
     - **Descrição:** Descoberta semântica de arquivos via `vexor`.  
     - **Quando usar:** Para localizar onde algo é implementado/carregado/definido em repo de médio ou grande porte.  
     - **Exemplo:** `vexor find "auth middleware"`.

186. **wp-site-health-auditor**  
     - **Descrição:** Transforma relatório de Saúde do Site WordPress em plano de correção por tier de risco com snippets WP-CLI/PHP exatos.  
     - **Quando usar:** Para saúde do site, melhorias recomendadas ou relatórios de problemas críticos.  
     - **Exemplo:** Auditar site WordPress e gerar plano de correção.

---

## 📁 Categoria: coding-category-pointer

**Descrição:** Biblioteca com 1 skill especializada em codificação.  
**Uso:** Tarefas relacionadas a codificação.

### Skills disponíveis:

1. **faf-expert**  
   - **Descrição:** Especialista avançado em .faf (Foundational AI-context Format). Formato registrado na IANA, configuração MCP server, pontuação de campeonato, sincronização bidirecional.  
   - **Quando usar:** Para trabalhar com formato .faf e configuração de MCP server.  
   - **Exemplo:** Configurar MCP server para integração com ferramentas AI.

---

## 📁 Categoria: code-category-pointer

**Descrição:** Biblioteca com 18 skills especializadas em código.  
**Uso:** Tarefas relacionadas a programação em diferentes linguagens.

### Skills disponíveis:

1. **c-pro**  
   - **Descrição:** Escreve código C eficiente com gerenciamento adequado de memória e ponteiros.  
   - **Quando usar:** Para programação em C com foco em performance e segurança de memória.  
   - **Exemplo:** Implementar estrutura de dados eficiente em C.

2. **cpp-pro**  
   - **Descrição:** Escreve código C++ idiomático com recursos modernos, RAII, smart pointers e algoritmos STL.  
   - **Quando usar:** Para programação moderna em C++.  
   - **Exemplo:** Usar smart pointers para gerenciamento automático de memória.

3. **csharp-pro**  
   - **Descrição:** Escreve código C# moderno com recursos avançados como records, pattern matching e async/await.  
   - **Quando usar:** Para desenvolvimento .NET moderno.  
   - **Exemplo:** Usar records para imutabilidade e pattern matching para condicionais.

4. **elixir-pro**  
   - **Descrição:** Escreve código Elixir idiomático com padrões OTP, supervision trees e Phoenix LiveView.  
   - **Quando usar:** Para desenvolvimento de aplicações concorrentes e tolerantes a falhas.  
   - **Exemplo:** Criar aplicação Real-time com Phoenix LiveView.

5. **golang-pro**  
   - **Descrição:** Domina Go 1.21+ com padrões modernos, concorrência avançada, otimização de performance e microsserviços prontos para produção.  
   - **Quando usar:** Para desenvolvimento Go de alta qualidade.  
   - **Exemplo:** Implementar microsserviço com Go e gRPC.

6. **haskell-pro**  
   - **Descrição:** Engenheiro Haskell especialista em sistemas de tipos avançados, programação pura e padrões funcionais.  
   - **Quando usar:** Para programação funcional avançada em Haskell.  
   - **Exemplo:** Usar tipos phantom para segurança de tipos em compile-time.

7. **java-pro**  
   - **Descrição:** Domina Java 21+ com recursos modernos como virtual threads, pattern matching e Spring Boot 3.x.  
   - **Quando usar:** Para desenvolvimento Java moderno.  
   - **Exemplo:** Usar virtual threads para concorrência leve.

8. **javascript-pro**  
   - **Descrição:** Domina JavaScript moderno com ES6+, padrões assíncronos e APIs Node.js.  
   - **Quando usar:** Para desenvolvimento JavaScript/Node.js.  
   - **Exemplo:** Implementar API REST com Express.js usando async/await.

9. **julia-pro**  
   - **Descrição:** Domina Julia 1.10+ com recursos modernos, otimização de performance, multiple dispatch e práticas prontas para produção.  
   - **Quando usar:** Para computação científica e análise de dados em Julia.  
   - **Exemplo:** Implementar algoritmo de machine learning em Julia.

10. **php-pro**  
    - **Descrição:** Escreve código PHP idiomático com generators, iterators, SPL data structures e recursos modernos de OOP.  
    - **Quando usar:** Para aplicações PHP de alto desempenho.  
    - **Exemplo:** Implementar sistema de cache eficiente em PHP.

11. **python-pro**  
    - **Descrição:** Domina Python 3.12+ com recursos modernos, programação assíncrona, otimização de performance e práticas prontas para produção.  
    - **Quando usar:** Para desenvolvimento Python moderno.  
    - **Exemplo:** Criar API FastAPI com async e Pydantic.

12. **ruby-pro**  
    - **Descrição:** Escreve código Ruby idiomático com metaprogramação, padrões Rails e otimização de performance.  
    - **Quando usar:** Para desenvolvimento Ruby/Rails.  
    - **Exemplo:** Usar metaprogramação para criar DSLs.

13. **rust-pro**  
    - **Descrição:** Domina Rust 1.75+ com padrões assíncronos modernos, recursos avançados do sistema de tipos e programação de sistemas pronta para produção.  
    - **Quando usar:** Para programação de sistemas em Rust.  
    - **Exemplo:** Implementar servidor HTTP de alta performance com Rust.

14. **sankhya-dashboard-html-jsp-custom-best-pratices**  
    - **Descrição:** Esta skill deve ser usada quando o usuário pedir padrões, melhores práticas, criação ou correção de dashboards Sankhya usando HTML, JSP, Java e SQL.  
    - **Quando usar:** Para dashboards Sankhya.  
    - **Exemplo:** Criar dashboard de vendas com HTML/JSP.

15. **scala-pro**  
    - **Descrição:** Domina desenvolvimento Scala empresarial com programação funcional, sistemas distribuídos e processamento de big data.  
    - **Quando usar:** Para desenvolvimento Scala empresarial.  
    - **Exemplo:** Criar pipeline de dados com Apache Spark em Scala.

16. **typescript-advanced-types**  
    - **Descrição:** Guia abrangente para dominar sistema de tipos avançado do TypeScript incluindo generics, conditional types, mapped types, template literal types e utility types.  
    - **Quando usar:** Para tipos avançados em TypeScript.  
    - **Exemplo:** Criar tipo que extrai propriedades de objeto de forma condicional.

17. **typescript-pro**  
    - **Descrição:** Domina TypeScript com tipos avançados, generics e type safety estrita.  
    - **Quando usar:** Para desenvolvimento TypeScript robusto.  
    - **Exemplo:** Implementar sistema de eventos tipado com TypeScript.

18. **unreal-engine-cpp-pro**  
    - **Descrição:** Guia expert para desenvolvimento C++ Unreal Engine 5.x, cobrindo higiene de UObject, padrões de performance e melhores práticas.  
    - **Quando usar:** Para desenvolvimento de jogos com Unreal Engine.  
    - **Exemplo:** Implementar sistema de inventário com C++ no Unreal.

---

## 📁 Categoria: core-dev-category-pointer

**Descrição:** Biblioteca com 1 skill especializada em desenvolvimento core.  
**Uso:** Tarefas de desenvolvimento de ferramentas e plugins.

### Skills disponíveis:

1. **vscode-extension-guide-en**  
   - **Descrição:** Guia para desenvolvimento de extensões VS Code desde scaffolding até publicação no Marketplace.  
   - **Quando usar:** Para criar extensões para Visual Studio Code.  
   - **Exemplo:** Criar extensão que formata código automaticamente.

---

## 📁 Categoria: fullstack-category-pointer

**Descrição:** Biblioteca com 1 skill especializada em fullstack.  
**Uso:** Tarefas de desenvolvimento fullstack.

### Skills disponíveis:

1. **vibe-code-cleanup**  
   - **Descrição:** Limpeza e hardening seguro em produção para apps fullstack feitos com vibe-coded (Next.js, React, Node.js, etc.). Remove imports mortos, arquivos não utilizados e referências quebradas sem quebrar rotas ou APIs.  
   - **Quando usar:** Para limpar e garantir segurança de código legado ou rapidamente prototipado.  
   - **Exemplo:** Limpar projeto Next.js removendo código morto e verificando rotas.

---

## 📊 Resumo Estatístico

| Categoria | Número de Skills |
|-----------|------------------|
| development-category-pointer | 186 |
| coding-category-pointer | 1 |
| code-category-pointer | 18 |
| core-dev-category-pointer | 1 |
| fullstack-category-pointer | 1 |
| **Total** | **207** |

---

## 🔍 Observações

1. **Profundidade variável:** As skills listadas variam em profundidade desde guias completos até referências rápidas.

2. **Diversidade tecnológica:** Cobrem uma ampla gama de tecnologias incluindo:
   - Linguagens: Python, JavaScript, TypeScript, Go, Rust, Java, C#, C++, Elixir, Haskell, Julia, PHP, Ruby, Scala, Kotlin
   - Frameworks: React, Next.js, Vue, Angular, Django, FastAPI, Laravel, Rails, Spring Boot
   - Ferramentas: Docker, Kubernetes, Git, CI/CD, Bazel, Nx, Turborepo
   - Plataformas: Web, Mobile, Desktop, Embedded, Cloud
   - Conceitos: Arquitetura, Design Patterns, Testing, Debugging, Performance, Security

3. **Uso das skills:** Para usar uma skill específica, consulte o vault correspondente:
   - Development: `C:/Users/Alendaviva007/.config/opencode/skill-libraries/development/<skill-name>/SKILL.md`
   - Coding: `C:/Users/Alendaviva007/.config/opencode/skill-libraries/coding/<skill-name>/SKILL.md`
   - Code: `C:/Users/Alendaviva007/.config/opencode/skill-libraries/code/<skill-name>/SKILL.md`
   - Core Dev: `C:/Users/Alendaviva007/.config/opencode/skill-libraries/core-dev/<skill-name>/SKILL.md`
   - Fullstack: `C:/Users/Alendaviva007/.config/opencode/skill-libraries/fullstack/<skill-name>/SKILL.md`

4. **Atualização:** Esta documentação foi gerada em 13/09/2026. Verifique o vault para informações atualizadas.

---

**Arquivo gerado automaticamente a partir dos arquivos SKILL.md das categorias de ponteiro.**