# Documentacao Completa — Skills de Testing

> **Data de geracao:** 2026-09-14
> **Fonte:** Arquivos SKILL.md do sistema OpenCode

---

## 1. CATEGORY: testing-category-pointer (30 skills)

Skills especializadas em testes de software. Vault: `C:/Users/Alendaviva007/.config/opencode/skill-libraries/testing`

### 1.1 ab-testing
- **Descricao:** Planejar, desenhar e implementar testes A/B ou experimentos, ou construir um programa de experimentacao de crescimento.
- **Quando usar:** Quando o usuario quer criar um teste A/B, validar hipoteses de produto, ou medir impacto de variacoes em metricas.
- **Exemplo:** "Quero testar se uma nova cor de botao aumenta a taxa de clique. Planeje um teste A/B."

### 1.2 agent-qa-authoring
- **Descricao:** Criar, editar, validar e executar testes de Agent QA, suites e hooks via MCP ou CLI, preservando IDs canonicos e contratos de schema.
- **Quando usar:** Quando precisa escrever testes automatizados para agentes de IA, incluindo validacao de respostas e conformidade com schemas.
- **Exemplo:** "Crie uma suite de QA para validar as respostas do nosso agente de atendimento ao cliente."

### 1.3 agent-qa-debug-fix
- **Descricao:** Depurar, corrigir e verificar execucoes de Agent QA que falharam, usando evidencias MCP, artefatos e logs, sem esconder defeitos.
- **Quando usar:** Quando testes de QA de agentes falham e e necessario encontrar a causa raiz e aplicar correcao.
- **Exemplo:** "O teste de QA do agente falhou no cenario de validacao de formato. Depure e corrija."

### 1.4 agent-qa-result-triage
- **Descricao:** Triar execucoes de Agent QA que falharam com evidencias MCP, categorias de falha fixas, confianca e proximos passos acionaveis.
- **Quando usar:** Quando ha multiplos testes de QA falhando e e necessario classificar prioridades e acoes corretivas.
- **Exemplo:** "Trie os 15 testes de QA que falharam ontem e me diga quais sao os mais criticos."

### 1.5 android-ui-journey-testing
- **Descricao:** Testes de jornada UI em Android com XML especificado, execucao interativa, verificacao de assercoes e relatorios JSON.
- **Quando usar:** Quando precisa testar fluxos completos de interface em aplicativos Android com verificacao automatizada.
- **Exemplo:** "Crie um teste de jornada para o fluxo de login ate o dashboard do app Android."

### 1.6 bats-testing-patterns
- **Descricao:** Dominar Bash Automated Testing System (Bats) para testes abrangentes de shell scripts. Para scripts shell, pipelines CI/CD ou TDD de utilitarios shell.
- **Quando usar:** Quando precisa escrever testes para scripts Bash, validar comandos de sistema ou aplicar TDD em automacoes de shell.
- **Exemplo:** "Escreva testes Bats para o script de deploy.sh que valida o ambiente antes de publicar."

### 1.7 brooks-test
- **Descricao:** Revisar qualidade da suite de testes usando literatura estabelecida de testes; identificar fragilidade, abuso de mocks, fixtures obscuras, assercoes fracas, feedback lento e riscos de manutencao.
- **Quando usar:** Quando quer uma auditoria da qualidade geral da suite de testes, identificando problemas estruturais.
- **Exemplo:** "Revise nossa suite de testes e identifique pontos de fragilidade e manutencao."

### 1.8 browser-testing-with-devtools
- **Descricao:** Testar aplicacoes web com Chrome DevTools MCP — inspecionar DOM ao vivo, logs do console, trafego de rede, screenshots, acessibilidade e traces de performance.
- **Quando usar:** Quando precisa inspecionar e testar uma aplicacao web em tempo real usando DevTools via MCP.
- **Exemplo:** "Use o Chrome DevTools para testar se o carregamento da pagina esta dentro do tempo aceitavel."

### 1.9 cypress-skill
- **Descricao:** Gerar testes Cypress E2E e de componente em JavaScript ou TypeScript. Suporta execucao local e nuvem TestMu AI. Para comandos cy.visit, cy.get, cy.intercept.
- **Quando usar:** Quando quer escrever testes E2E com Cypress, configurar o Cypress, ou testar com comandos cy.
- **Exemplo:** "Escreva um teste Cypress para o fluxo de checkout do e-commerce."

### 1.10 k6-load-testing
- **Descricao:** Testes de carga k6 abrangentes para APIs, browser e escalabilidade. Escrever cenarios realistas de carga e integrar com CI/CD.
- **Quando usar:** Quando precisa testar performance e escalabilidade de APIs ou aplicacoes web sob carga.
- **Exemplo:** "Crie um cenario de carga k6 para simular 1000 usuarios concorrentes na API de login."

### 1.11 lambdatest-agent-skills
- **Descricao:** Skills de automacao de testes para 46 frameworks em E2E, unit, mobile, BDD, visual e testes em nuvem em 15+ linguagens.
- **Quando usar:** Quando precisa de automacao de testes em nuvem para multiplos frameworks e linguagens.
- **Exemplo:** "Execute testes E2E do nosso app React no LambdaTest com Selenium."

### 1.12 mock-hunter
- **Descricao:** Auditar uma pagina web ao vivo em 5 fases (catalogar, clicar, rastrear, classificar, relatar) para identificar dados mock, valores hardcoded, metricas geradas por LLM e endpoints quebrados.
- **Quando usar:** Quando quer auditar uma aplicacao para identificar dados artificiais ou quebrados antes de usar em decisoes reais.
- **Exemplo:** "Audite o dashboard de vendas e identifique quais metricas sao reais e quais sao mockadas."

### 1.13 network-101
- **Descricao:** Configurar e testar servicos de rede comuns (HTTP, HTTPS, SNMP, SMB) para ambientes de laboratorio de pentest.
- **Quando usar:** Quando esta configurando um laboratorio de testes de seguranca e precisa validar servicos de rede.
- **Exemplo:** "Configure e teste um servidor HTTP e SNMP para praticar enumeracao de servicos."

### 1.14 pypict-skill
- **Descricao:** Geracao de testes pairwise (combinacao de pares).
- **Quando usar:** Quando precisa gerar combinacoes otimizadas de parametros de teste para cobrir interacoes entre variaveis.
- **Exemplo:** "Gere combinacoes pairwise para testar o formulario de cadastro com 5 campos."

### 1.15 pytest-skill
- **Descricao:** Gerar testes pytest em Python com fixtures, parametrize, markers, mocking e padroes conftest. Para pytest, conftest, @pytest.fixture, @pytest.mark.
- **Quando usar:** Quando precisa escrever testes unitarios ou de integracao em Python usando pytest.
- **Exemplo:** "Escreva testes pytest para a classe UserRepository com fixtures de banco de dados."

### 1.16 screen-reader-testing
- **Descricao:** Guia pratico para testar aplicacoes web com leitores de tela para validacao abrangente de acessibilidade.
- **Quando usar:** Quando quer validar se a aplicacao web e acessivel para usuarios com deficiencia visual.
- **Exemplo:** "Teste a pagina de login com NVDA e VoiceOver para garantir acessibilidade."

### 1.17 smartui-skill
- **Descricao:** Gerar configuracoes de teste de regressao visual SmartUI para comparacao de screenshots na nuvem TestMu AI. Funciona com Playwright, Selenium, Cypress, Puppeteer.
- **Quando usar:** Quando quer implementar testes de regressao visual para detectar mudancas nao intencionais na UI.
- **Exemplo:** "Configure SmartUI para comparar screenshots do checkout entre versoes do app."

### 1.18 tdd-orchestrator
- **Descricao:** Orquestrador TDD especializado em disciplina red-green-refactor, coordenacao de workflows multi-agente e praticas abrangentes de TDD.
- **Quando usar:** Quando quer orquestrar um ciclo TDD completo com multiplos agentes e disciplina rigorosa.
- **Exemplo:** "Orquestre o desenvolvimento da feature de pagamentos usando TDD com a equipe."

### 1.19 tdd-workflow
- **Descricao:** Principios de workflow de Test-Driven Development. Ciclo RED-GREEN-REFACTOR.
- **Quando usar:** Quando quer seguir o ciclo basico de TDD em qualquer linguagem.
- **Exemplo:** "Siga o workflow TDD para implementar a validacao do formulario."

### 1.20 tdd-workflows / tdd-workflows-tdd-cycle
- **Descricao:** Alias para o ciclo TDD completo.
- **Quando usar:** Identico ao tdd-workflow.
- **Exemplo:** "Execute o ciclo TDD completo para a funcionalidade de busca."

### 1.21 tdd-workflows-tdd-green
- **Descricao:** Implementar o codigo minimo necessario para fazer testes falharem passarem na fase verde do TDD.
- **Quando usar:** Quando ja tem testes falhando (fase red) e precisa implementar o codigo minimo para passar.
- **Exemplo:** "Implemente o codigo minimo para o teste de validacao de email passar."

### 1.22 tdd-workflows-tdd-red
- **Descricao:** Gerar testes que falham para a fase vermelha do TDD, definindo comportamento esperado e edge cases.
- **Quando usar:** Quando esta iniciando uma feature e quer definir o comportamento esperado atraves de testes falhando.
- **Exemplo:** "Escreva testes que falham para o calculo de desconto com cenarios extremos."

### 1.23 tdd-workflows-tdd-refactor
- **Descricao:** Fase de refatoracao do TDD — melhorar o codigo sem mudar o comportamento.
- **Quando usar:** Quando os testes estao passando e quer melhorar a estrutura do codigo.
- **Exemplo:** "Refatore o servico de autenticacao mantendo todos os testes verdes."

### 1.24 temporal-python-testing
- **Descricao:** Testes abrangentes de workflows Temporal usando pytest, com recursos de divulgacao progressiva para cenarios especificos.
- **Quando usar:** Quando trabalha com workflows Temporal em Python e precisa testar-los.
- **Exemplo:** "Escreva testes para o workflow de processamento de pedidos Temporal."

### 1.25 test-driven-development
- **Descricao:** Usar um teste comportamental falhando para guiar uma feature ou correcao de bug, depois implementar e refatorar com verificacoes de regressao.
- **Quando usar:** Quando quer aplicar TDD em uma nova feature ou correcao de bug.
- **Exemplo:** "Use TDD para implementar a funcionalidade de exportacao de relatorios."

### 1.26 test-framework-migration-skill
- **Descricao:** Migrar e converter scripts de automacao de testes entre Selenium, Playwright, Puppeteer e Cypress.
- **Quando usar:** Quando quer migrar a suite de testes de um framework para outro.
- **Exemplo:** "Migre nossos testes Selenium para Playwright."

### 1.27 test-guard
- **Descricao:** Revisar codigo de testes gerado ou alterado contra regras universais de testes antes de entregar ou apresentar para aprovacao.
- **Quando usar:** Quando quer validar a qualidade do codigo de testes antes de commitar ou enviar para review.
- **Exemplo:** "Revise os testes que acabei de escrever contra as melhores praticas."

### 1.28 testing-patterns
- **Descricao:** Padroes de teste Jest, funcoes factory, estrategias de mocking e workflow TDD. Para testes unitarios, factories de teste e ciclo red-green-refactor.
- **Quando usar:** Quando esta escrevendo testes com Jest e quer aplicar padroes avancados.
- **Exemplo:** "Escreva testes Jest para o componente UserCard usando factory functions e mocks."

### 1.29 unit-testing-test-generate
- **Descricao:** Gerar testes unitarios abrangentes e manuteniveis em diversas linguagens com forte cobertura e foco em edge cases.
- **Quando usar:** Quando quer gerar testes unitarios completos para qualquer funcao ou classe.
- **Exemplo:** "Gere testes unitarios para a funcao de validacao de CPF com todos os edge cases."

---

## 2. CATEGORY: test-automation-category-pointer (9 skills)

Skills de automacao de testes. Vault: `C:/Users/Alendaviva007/.config/opencode/skill-libraries/test-automation`

### 2.1 android_ui_verification
- **Descricao:** Testes automatizados E2E de UI e verificacao em Android Emulator usando ADB.
- **Quando usar:** Quando precisa testar a interface de um app Android em um emulador.
- **Exemplo:** "Execute a verificacao E2E da tela de configuracoes do app Android no emulador."

### 2.2 awt-e2e-testing
- **Descricao:** Testes E2E web com IA — olhos e maos para ferramentas de codificacao IA. Cenarios declarativos em YAML, execucao Playwright, correspondencia visual (OpenCV + OCR).
- **Quando usar:** Quando quer testes E2E com IA que usam correspondencia visual para validar a UI.
- **Exemplo:** "Crie um cenario AWT YAML para testar o fluxo de cadastro com validacao visual."

### 2.3 browser-automation
- **Descricao:** Construir checks de browser confiaveis usando estado UI observado, localizadores semanticos, waits delimitados, dados de teste isolados e verificacao explicita de resultados.
- **Quando usar:** Quando quer criar automacoes de browser robustas e confiaveis.
- **Exemplo:** "Automatize o preenchimento do formulario de contato e verifique a mensagem de sucesso."

### 2.4 e2e-testing-patterns
- **Descricao:** Construir suites de testes E2E confiaveis, rapidas e manuteniveis que dao confianca para entregar codigo rapidamente e capturar regressoes.
- **Quando usar:** Quando quer estabelecer padroes E2E para o projeto.
- **Exemplo:** "Crie um padrao E2E para o nosso time seguir, incluindo fixtures ePage Objects."

### 2.5 go-playwright
- **Descricao:** Capacidade especialista em automacao de browser robusta, furtiva e eficiente usando Playwright Go.
- **Quando usar:** Quando trabalha com Playwright em Go e precisa de automacao avancada.
- **Exemplo:** "Escreva um script Playwright em Go para extrair dados de uma tabela."

### 2.6 playwright-java
- **Descricao:** Scaffold, escrever, depurar e melhorar testes Playwright E2E em Java com Page Object Model, JUnit 5, Allure reporting e execucao paralela.
- **Quando usar:** quando precisa de testes Playwright em Java com boas praticas de arquitetura.
- **Exemplo:** "Crie uma Page Object para a tela de login e escreva testes JUnit 5."

### 2.7 playwright-skill
- **Descricao:** Skill principal do Playwright para automacao de browser. Importante: resolver caminho do skill antes de executar comandos.
- **Quando usar:** Quando quer usar Playwright para automacao de browser em qualquer linguagem suportada.
- **Exemplo:** "Use o Playwright para automatizar o teste de upload de arquivo."

### 2.8 test-automator
- **Descricao:** Automacao de testes com IA, frameworks modernos, testes auto-healing e engenharia de qualidade abrangente. Estrategias escalaveis com integracao CI/CD avancada.
- **Quando usar:** Quando quer uma abordagem completa de automacao de testes com IA e integracao CI/CD.
- **Exemplo:** "Configure um pipeline de testes auto-healing com integracao no GitHub Actions."

### 2.9 webapp-testing (test-automation)
- **Descricao:** Para testar aplicacoes web locais, escrever scripts Playwright nativos em Python.
- **Quando usar:** Quando precisa testar uma aplicacao web local usando Playwright Python.
- **Exemplo:** "Escreva um script Playwright Python para testar o endpoint /api/users."

---

## 3. CATEGORY: development-and-testing-category-pointer (6 skills)

Skills de desenvolvimento e debugging. Vault: `C:/Users/Alendaviva007/.config/opencode/skill-libraries/development-and-testing`

### 3.1 bug-hunter
- **Descricao:** Encontrar e corrigir bugs sistematicamente usando tecnicas comprovadas de debugging. Rastrear de sintomas ate a causa raiz, implementar correcoes e prevenir regressoes.
- **Quando usar:** Quando ha um bug identificado e precisa encontrar a causa raiz e aplicar correcao.
- **Exemplo:** "O botao de submit nao esta funcionando. Encontre a causa e corrija."

### 3.2 debugger
- **Descricao:** Especialista em debugging para erros, falhas de teste e comportamento inesperado. Usar proativamente ao encontrar qualquer problema.
- **Quando usar:** Quando encontra erros, falhas de testes ou comportamento inesperado no codigo.
- **Exemplo:** "Depure este erro de TypeError que esta acontecendo na funcao calculateTotal."

### 3.3 debugging-strategies
- **Descricao:** Transformar debugging de tentativa e erro frustrante em resolucao sistematica de problemas com estrategias comprovadas, ferramentas poderosas e abordagens metodicas.
- **Quando usar:** Quando precisa de uma abordagem estruturada para debugar problemas complexos.
- **Exemplo:** "Use estrategias sistematicas para debugar o problema de memoria no servidor."

### 3.4 openclaw-github-repo-commander
- **Descricao:** Workflow de 7 estagios para auditoria, limpeza, review de PR e analise de concorrentes em repositorios GitHub.
- **Quando usar:** Quando quer auditar completamente um repositorio GitHub.
- **Exemplo:** "Execute o workflow completo de auditoria no repositorio da equipe."

### 3.5 systematic-debugging
- **Descricao:** Usar ao encontrar qualquer bug, falha de teste ou comportamento inesperado, antes de propor correcoes.
- **Quando usar:** Quando encontra um problema e quer uma abordagem sistematica antes de sair corrigindo.
- **Exemplo:** "Aplique debugging sistematico para o bug no servico de pagamentos."

### 3.6 test-fixing
- **Descricao:** Identificar e corrigir sistematicamente todos os testes falhando usando estrategias de agrupamento inteligente. Para quando o usuario pede para corrigir testes ou relata falhas.
- **Quando usar:** Quando ha testes falhando e precisa corrigi-los de forma organizada.
- **Exemplo:** "Corrija todos os 23 testes que estao falhando no suite."

---

## 4. CATEGORY: webapp-testing (skill direta, 1 skill)

Skill especifica para testes de aplicacoes web locais.

### 4.1 webapp-testing
- **Descricao:** Toolkit para interagir e testar aplicacoes web locais usando Playwright. Suporta verificacao de funcionalidade frontend, debug de comportamento UI, captura de screenshots e visualizacao de logs do browser.
- **Quando usar:** Quando precisa testar uma aplicacao web local, inspecionar DOM, capturar screenshots ou verificar logs do browser.
- **Exemplo pratico — Arvore de decisao:**
  - Se e HTML estatico → Ler o arquivo HTML diretamente para identificar seletores
  - Se e dinamico e o servidor NAO esta rodando → Usar `python scripts/with_server.py --help` e depois o helper + script Playwright
  - Se e dinamico e o servidor ESTA rodando → Reconhecimento-antes-da-acao (navegar, esperar networkidle, inspecionar DOM, executar acoes)
- **Exemplo de uso do with_server.py (servidor unico):**
  ```bash
  python scripts/with_server.py --server "npm run dev" --port 5173 -- python your_automation.py
  ```
- **Exemplo de uso com multiplos servidores:**
  ```bash
  python scripts/with_server.py \
    --server "cd backend && python server.py" --port 3000 \
    --server "cd frontend && npm run dev" --port 5173 \
    -- python your_automation.py
  ```
- **Exemplo de script Playwright basico:**
  ```python
  from playwright.sync_api import sync_playwright

  with sync_playwright() as p:
      browser = p.chromium.launch(headless=True)
      page = browser.new_page()
      page.goto('http://localhost:5173')
      page.wait_for_load_state('networkidle')  # CRITICO
      # ... logica de automacao
      browser.close()
  ```
- **Pitfall comum:** NUNCA inspecionar DOM antes de esperar `networkidle` em apps dinamicas.
- **Melhores praticas:** Usar scripts auxiliares como caixas-pretas, usar `sync_playwright()`, sempre fechar o browser, usar seletores descritivos, adicionar waits apropriados.

---

## Resumo Geral

| Categoria | Qtd Skills | Foco Principal |
|---|---|---|
| **testing-category-pointer** | 30 | Testes de software em geral (unit, E2E, TDD, load, visual, A/B, acessibilidade, shell, etc.) |
| **test-automation-category-pointer** | 9 | Automacao de testes com foco em frameworks (Playwright, Cypress, Selenium) e automacao de browser |
| **development-and-testing-category-pointer** | 6 | Debugging, correcao de bugs e correcao de testes falhando |
| **webapp-testing** | 1 | Toolkit especifico para testes de apps web locais com Playwright Python |
| **TOTAL** | **46** | |

### Categorias de uso mais frequentes identificadas:

1. **TDD / Test-Driven Development** — 8 skills (tdd-orchestrator, tdd-workflow, tdd-red, tdd-green, tdd-refactor, test-driven-development, etc.)
2. **Playwright / Browser Automation** — 8 skills (playwright-skill, playwright-java, go-playwright, browser-automation, browser-testing-with-devtools, webapp-testing, etc.)
3. **Debugging / Bug Fixing** — 5 skills (bug-hunter, debugger, debugging-strategies, systematic-debugging, test-fixing)
4. **Agent QA** — 3 skills (agent-qa-authoring, agent-qa-debug-fix, agent-qa-result-triage)
5. **E2E Testing** — 3 skills (e2e-testing-patterns, cypress-skill, awt-e2e-testing)
6. **Unit Testing** — 3 skills (pytest-skill, testing-patterns, unit-testing-test-generate)
7. **Test Quality / Review** — 3 skills (brooks-test, test-guard, mock-hunter)
8. **Performance / Load** — 2 skills (k6-load-testing, browser-testing-with-devtools)
9. **Visual Regression** — 2 skills (smartui-skill, awt-e2e-testing)
10. **Acessibilidade** — 1 skill (screen-reader-testing)
11. **Shell Testing** — 1 skill (bats-testing-patterns)
12. **Android Testing** — 2 skills (android-ui-journey-testing, android_ui_verification)
13. **Framework Migration** — 1 skill (test-framework-migration-skill)

### Fonte dos arquivos lidos:
- `C:\Users\Alendaviva007\.config\opencode\skills\testing-category-pointer\SKILL.md`
- `C:\Users\Alendaviva007\.config\opencode\skills\test-automation-category-pointer\SKILL.md`
- `C:\Users\Alendaviva007\.config\opencode\skills\development-and-testing-category-pointer\SKILL.md`
- `C:\Users\Alendaviva007\.agents\skills\webapp-testing\SKILL.md`
