# 🎮 IA para Desenvolvimento de Jogos Roblox

> **Guia completo de ferramentas de IA para criar jogos profissionais no Roblox Studio**

---

## 📊 Resumo Executivo

| Categoria | Melhores Opções | Para Quem |
|-----------|-----------------|-----------|
| **Agentes Autônomos** | ClaudeBlox, Roblox Studio MCP | Criar jogos completos automaticamente |
| **Assistentes de Código** | RoAgent, RoCortex, Ropilot | Escrever Luau com IA |
| **Plugins Studio** | Stud, Genesis AI, BloxyAI | Construir dentro do Studio |
| **MCP Integration** | roblox-studio-mcp, roblox-mcp-pro | Controle total via IA |
| **Frameworks** | Lux (LangGraph), CrewAI | Agentes multi-tarefa |

---

## 🏆 Top Ferramentas de IA para Roblox (2026)

### 1. 🟢 Roblox Studio MCP (Oficial + Comunidade)
**Melhor para:** Controle total do Studio via IA

| Aspecto | Detalhe |
|---------|---------|
| **GitHub** | Meganugger/roblox-studio-mcp |
| **Tipo** | MCP Server + Plugin |
| **Clientes** | Claude, Cursor, Codex, Gemini |
| **Preço** | Gratuito (open source) |

**Capacidades:**
- 🖥️ **Executa Studio para você** - Cria place, abre Studio, conecta plugin
- 🎮 **Joga sozinho** - Pressiona F5, testa o jogo automaticamente
- 🐞 **Debug em tempo real** - Lê logs, encontra erros, corrige sozinho
- 🧩 **Scaffolds completos** - DataStore, moedas, inventário, loja, quests
- 🔐 **Segurança** - Token de autenticação, sandbox

**Arquitetura:**
```
AI Agent (Claude/Cursor) → MCP Server → Studio Plugin → Roblox Studio
```

---

### 2. 🟡 ClaudeBlox
**Melhor para:** Criar jogos completos com 21 agentes especializados

| Aspecto | Detalhe |
|---------|---------|
| **GitHub** | Claudeblox/claudeblox |
| **Agentes** | 21 agentes especializados |
| **Powered by** | Claude Code |
| **Preço** | Requer assinatura Claude |

**21 Agentes:**

#### 🏗️ Arquitetura & Planejamento
| Agente | Função |
|--------|--------|
| **roblox-architect** | Arquiteto sênior (12+ anos). Projeta arquitetura completa |
| **ai-developer** | Arquiteto de agentes IA. Cria e corrige prompts |
| **story-teller** | Designer narrativo (12+ anos). Storytelling ambiental |

#### 💻 Código & Scripts
| Agente | Função |
|--------|--------|
| **luau-scripter** | Engenheiro sênior Roblox (8+ anos). Luau production-quality |
| **luau-reviewer** | Engenheiro de segurança. Revisa vulnerabilidades |

#### 🌍 Construção de Mundo
| Agente | Função |
|--------|--------|
| **world-builder** | Construtor técnico (12 anos). Ambientes 3D via MCP |

#### 🧪 Testes & Publicação
| Agente | Função |
|--------|--------|
| **roblox-playtester** | QA engineer (12 anos). Testa via MCP |
| **computer-player** | Joga autonomamente, encontra bugs |
| **roblox-publisher** | Publica na plataforma Roblox |

---

### 3. 🔵 RoAgent
**Melhor para:** Desenvolvimento profissional com Claude/GPT

| Aspecto | Detalhe |
|---------|---------|
| **Site** | roagent.ai |
| **Powered by** | Claude Opus, Sonnet, GPT |
| **Preço** | Free tier + $75/mês Pro+ |
| **Recursos** | Playtest automatizado, diffs |

**Recursos:**
- ✅ Escreve Luau production-ready
- ✅ Playtesta sozinho (clica botões, simula input)
- ✅ Self-healing (falha → corrige → retesta)
- ✅ Diffs reviewáveis antes de enviar
- ✅ Entende árvore completa do jogo

---

### 4. 🟠 RoCortex
**Melhor para:** 6 modelos de IA, sync instantâneo

| Aspecto | Detalhe |
|---------|---------|
| **Site** | rocortex.gg |
| **Modelos** | 6 opções (Flash → Frontier) |
| **Sync** | ~800ms |
| **Preço** | Free + planos pagos |

**Modelos Disponíveis:**
- Flash (1 credit - scripts rápidos)
- Frontier (complexos)

---

### 5. 🔴 Ropilot
**Melhor para:** GPT-6 Astra no Roblox Studio

| Aspecto | Detalhe |
|---------|---------|
| **Site** | ropilot.ai |
| **Modelo** | GPT-6 Astra, Claude Fable 5.1, Opus 5 |
| **Preço** | Assinatura OpenAI/Anthropic |

**Capacidades:**
- Lê estrutura do jogo
- Escreve Luau
- Constroi 3D
- Playtesta e corrige bugs

---

### 6. 🟢 Lux (lang-agentic-ai)
**Melhor para:** Framework LangGraph para Roblox

| Aspecto | Detalhe |
|---------|---------|
| **GitHub** | Seryozh/lux-agentic-ai |
| **Framework** | LangGraph + LangChain |
| **Backend** | Python FastAPI |
| **Preço** | Gratuito (BYOK) |

**Arquitetura:**
```
Plugin (Lua) → Backend (Python) → AI Agent (LangGraph) → LLM (OpenRouter)
```

**Ferramentas (4 níveis):**
| Nível | Ferramenta | Custo |
|-------|------------|-------|
| 1 | Project Map | GRÁTIS |
| 2 | search_project | ~200 tokens |
| 3 | get_metadata | ~100 tokens |
| 4 | get_full_script | ~1.000 tokens |

**Ações (8 primitivos):**
- set_property
- create_instance
- delete_instance
- move_instance
- clone_instance
- create_script
- modify_script
- delete_script

---

### 7. 🔵 Stud
**Melhor para:** Cursor AI para Roblox

| Aspecto | Detalhe |
|---------|---------|
| **GitHub** | madebyshaurya/stud |
| **Stack** | React 19, Tauri 2 (Rust), Warp |
| **Modelos** | GPT-4, Claude, ChatGPT Plus/Pro |
| **Preço** | Grátis com assinatura |

**15+ Ferramentas IA:**
- roblox_create, roblox_delete, roblox_clone
- roblox_move, roblox_set_property
- roblox_get_script, roblox_set_script
- roblox_run_code, roblox_bulk_create

---

### 8. 🟠 Genesis AI
**Melhor para:** Conversar com o Studio

| Aspecto | Detalhe |
|---------|---------|
| **Site** | genesis.tessermind.com |
| **Tipo** | Plugin Studio |
| **Ações** | 60+ ações Studio |
| **Preço** | Free + planos pagos |

**Recursos:**
- Chat dentro do Studio
- 60+ ações automáticas
- Cria partes, scripts, UI, terreno
- Entende Workspace, serviços, instâncias

---

### 9. 🟡 BloxyAI
**Melhor para:** Código Luau que funciona no paste

| Aspecto | Detalhe |
|---------|---------|
| **Site** | bloxyai.com |
| **Especialidade** | Luau específico para Roblox |
| **Preço** | Free + Creator + Studio |
| **Categorias** | 7 categorias de scripts |

**Categorias:**
- Combat, Leaderboards, GUIs
- Monetização, Admin Tools
- NPCs, Game Mechanics

---

### 10. 🔵 Roscript
**Melhor para:** Geração completa de sistemas

| Aspecto | Detalhe |
|---------|---------|
| **Site** | roscript.pro |
| **Preço** | Free (5 créditos/dia) + planos pagos |
| **Modelo** | Claude Sonnet 4.6 |

**Recursos:**
- Gerador de scripts
- Live Studio Plugin
- Biblioteca de templates
- Geração de jogo completo

---

### 11. 🟢 RoAI Studio
**Melhor para:** Agent mode + Chat mode

| Aspecto | Detalhe |
|---------|---------|
| **Site** | roai.studio |
| **Modos** | Agent (constrói) + Chat (pergunta) |
| **Sync** | Live com Studio |

---

### 12. 🔴 SuperbulletAI
**Melhor para:** IA treinada especificamente para Roblox

| Aspecto | Detalhe |
|---------|---------|
| **Site** | superbullet.ai |
| **Modelo** | BulletMindV1 (em breve) |
| **Precisão** | 90%+ |
| **Tab Completion** | 99%+ (em breve) |

---

## 🔧 MCP (Model Context Protocol) para Roblox

### O que é MCP?
Protocolo aberto que permite IA controlar ferramentas externas.

### Servidores MCP para Roblox

| Projeto | GitHub | Destaques |
|---------|--------|-----------|
| **roblox-studio-mcp** | Meganugger/roblox-studio-mcp | Mais completo, 21+ tools |
| **roblox-mcp-pro** | PeerapolSelanon/roblox-mcp-pro | 29 tools, multi-agent |
| **studio-rust-mcp-server** | Roblox/ (oficial) | Rust, oficial |
| **robloxstudio-mcp** | boshyxd/ | TypeScript |

### Como Funciona
```
┌─────────────┐    MCP     ┌──────────────┐    HTTP    ┌─────────────┐
│  AI Agent   │ ────────── │  MCP Server  │ ───────── │   Plugin    │
│ (Claude/    │   stdio    │  (Node.js)   │  bridge   │   (Lua)     │
│  Cursor)    │            │              │           │             │
└─────────────┘            └──────────────┘           └─────────────┘
                                  │                        │
                                  └────────────────────────┘
                                       Roblox Studio
```

---

## 📚 Guias de Instalação

### 1. roblox-studio-mcp (Mais Completo)

```bash
# 1. Instalar o servidor MCP
git clone https://github.com/Meganugger/roblox-studio-mcp.git
cd roblox-studio-mcp
npm install

# 2. Iniciar o servidor
npm start

# 3. No Roblox Studio
# - Abra seu place
# - Clique no botão MCP na toolbar
# - Cole o token de autenticação
# - Conecte

# 4. No Claude/Cursor
# - Configure o MCP server
# - Pronto! A IA pode controlar o Studio
```

### 2. ClaudeBlox (21 Agentes)

```bash
# 1. Instalar Roblox Studio MCP
# Baixe rbx-studio-mcp.exe do GitHub releases
# Execute uma vez para instalar o plugin

# 2. Configurar Claude Code
# Assine Claude (claude.ai/code)

# 3. Criar projeto
# Abra Roblox Studio
# Publique o place
# Habilite HTTP Requests

# 4. Iniciar ClaudeBlox
# Siga as instruções do repositório
```

### 3. Lux (Framework LangGraph)

```bash
# 1. Instalar backend
git clone https://github.com/Seryozh/lux-agentic-ai.git
cd lux-agentic-ai
pip install -r requirements.txt

# 2. Configurar .env
OPENROUTER_API_KEY=sua-chave

# 3. Iniciar servidor
python main.py

# 4. Instalar plugin no Studio
# Copie o plugin para a pasta de plugins

# 5. Conectar
# Abra o plugin no Studio
# Cole a chave da API
```

---

## 🎯 Orquestração de IAs para o Jogo "Steal An Egg"

### Arquitetura Recomendada

```
┌─────────────────────────────────────────────────────────────────┐
│                    ORQUESTRADOR PRINCIPAL                       │
│                    (Claude Code + MCP)                          │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐            │
│  │  ARQUITETO  │  │  CODEWRITER │  │  TESTADOR   │            │
│  │  (Planeja)  │  │  (Escreve)  │  │  (Testa)    │            │
│  └──────┬──────┘  └──────┬──────┘  └──────┬──────┘            │
│         │                │                │                    │
│         ▼                ▼                ▼                    │
│  ┌─────────────────────────────────────────────────┐          │
│  │           ROBLOX STUDIO (via MCP)               │          │
│  │  - Cria instâncias                              │          │
│  │  - Escreve scripts                             │          │
│  │  - Testa automaticamente                       │          │
│  │  - Corrige erros                               │          │
│  └─────────────────────────────────────────────────┘          │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

### Fluxo de Trabalho

#### Fase 1: Planejamento
```
1. Arquiteto IA analisa "Steal An Egg"
2. Identifica mecânicas principais
3. Cria plano de desenvolvimento
4. Define estrutura de pastas
```

#### Fase 2: Construção
```
1. CodeWriter cria scripts principais
2. WorldBuilder constrói mapa
3. UI Designer cria interface
4. Tudo via MCP no Studio
```

#### Fase 3: Testes
```
1. Playtester IA joga o jogo
2. Encontra bugs automaticamente
3. ComputerPlayer testa edge cases
4. Correções automáticas via MCP
```

#### Fase 4: Publicação
```
1. Publisher publica na Roblox
2. Analytics monitora performance
3. Iterações baseadas em dados
```

---

## 💡 Mecânicas do "Steal An Egg" para Implementar

### Core Mechanics
| Mecânica | Descrição | Prioridade |
|----------|-----------|------------|
| **Roubar Ovos** | Pegar ovos de outros jogadores | Alta |
| **Proteger Ninhos** | Defender seus ovos | Alta |
| **Velocidade** | Correr mais rápido | Média |
| **Invisibilidade** | Ficar invisível temporariamente | Média |
| **Armadilhas** | Colocar armadilhas | Baixa |

### Progressão
| Sistema | Descrição |
|---------|-----------|
| **Moedas** | Comprar upgrades |
| **Níveis** | Desbloquear habilidades |
| **Inventário** | Guardar ovos coletados |
| **Loja** | Comprar itens especiais |

---

## 📊 Comparativo das Ferramentas

| Ferramenta | Agentes | MCP | Playtest | Preço | Ideal Para |
|------------|---------|-----|----------|-------|------------|
| **roblox-studio-mcp** | ✅ | ✅ | ✅ | Grátis | Automação total |
| **ClaudeBlox** | 21 | ✅ | ✅ | Claude sub | Jogos completos |
| **RoAgent** | ✅ | ✅ | ✅ | $75/mês | Profissional |
| **Lux** | ✅ | ✅ | ❌ | Grátis (BYOK) | Customização |
| **Stud** | ✅ | ✅ | ❌ | Grátis | Iniciantes |
| **Genesis AI** | ❌ | ✅ | ❌ | Free+ | Rápido |
| **BloxyAI** | ❌ | ❌ | ❌ | Free+ | Código Luau |

---

## 🚀 Recomendação Final

### Para Começar Agora:
1. **Instale** roblox-studio-mcp (gratuito, mais completo)
2. **Configure** com Claude Code ou Cursor
3. **Crie** o jogo "Steal An Egg" usando os 21 agentes do ClaudeBlox
4. **Teste** automaticamente com o playtester
5. **Publique** na Roblox

### Para Equipes:
1. **Use** RoAgent para desenvolvimento profissional
2. **Combine** com LangGraph para orquestração complexa
3. **Implemente** CI/CD para deploy automático

---

## 🔗 Links Úteis

| Recurso | URL |
|---------|-----|
| **roblox-studio-mcp** | https://github.com/Meganugger/roblox-studio-mcp |
| **ClaudeBlox** | https://github.com/Claudeblox/claudeblox |
| **Lux** | https://github.com/Seryozh/lux-agentic-ai |
| **RoAgent** | https://roagent.ai |
| **Roblox Studio** | https://create.roblox.com |
| **MCP Spec** | https://modelcontextprotocol.io |

---

*Última atualização: Setembro 2026*