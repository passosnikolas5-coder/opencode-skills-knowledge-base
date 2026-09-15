# 🟡 ClaudeBlox - 21 Agentes para Roblox

> **O framework mais completo com agentes especializados para criar jogos profissionais**

---

## 📊 Resumo

| Aspecto | Detalhe |
|---------|---------|
| **GitHub** | [Claudeblox/claudeblox](https://github.com/Claudeblox/claudeblox) |
| **Agentes** | 21 agentes especializados |
| **Powered by** | Claude Code |
| **Preço** | Requer assinatura Claude |
| **Ideal para** | Jogos completos e profissionais |

---

## 🤖 Os 21 Agentes

### 🏗️ Arquitetura & Planejamento

| Agente | Especialidade | Experiência |
|--------|---------------|-------------|
| **roblox-architect** | Arquiteto sênior | 12+ anos |
| **ai-developer** | Arquiteto de agentes IA | Prompt engineering |
| **story-teller** | Designer narrativo | 12+ anos |

#### roblox-architect
```
Especialidades:
- Design de sistemas complexos
- Arquitetura de dados
- Padrões de design
- Otimização de performance
- Documentação técnica

Uso:
"Projete a arquitetura completa do jogo Steal An Egg"
"Crie o plano de desenvolvimento para um RPG com crafting"
```

#### ai-developer
```
Especialidades:
- Criação de prompts eficazes
- Otimização de IAs
- Debug de agentes
- Self-healing
- Automação de workflows

Uso:
"Crie prompts para o CodeWriter gerar código Luau"
"Otimize o agente Testador para encontrar mais bugs"
```

#### story-teller
```
Especialidades:
- Storytelling ambiental
- Diálogos de NPCs
- World-building
- Narrativa iterativa
- Lore do jogo

Uso:
"Crie a história do jogo Steal An Egg"
"Escreva diálogos para os NPCs da loja"
```

---

### 💻 Código & Scripts

| Agente | Especialidade | Experiência |
|--------|---------------|-------------|
| **luau-scripter** | Engenheiro sênior Roblox | 8+ anos |
| **luau-reviewer** | Engenheiro de segurança | Security audit |

#### luau-scripter
```
Especialidades:
- Luau production-quality
- Padrões Roblox
- Otimização de performance
- Tratamento de erros
- Documentação de código

Uso:
"Crie o sistema de combate com dash attack"
"Implemente o sistema de save com DataStore"
"Otimize este script para mobile"
```

#### luau-reviewer
```
Especialidades:
- Vulnerabilidades de segurança
- Performance audit
- Code review
- Best practices
- Refatoração

Uso:
"Revise este script para vulnerabilidades"
"Otimize este código para evitar lag"
"Verifique se está seguindo best practices"
```

---

### 🌍 Construção de Mundo

| Agente | Especialidade | Experiência |
|--------|---------------|-------------|
| **world-builder** | Construtor técnico | 12 anos |

#### world-builder
```
Especialidades:
- Ambientes 3D
- Terreno
- Lighting
- Atmosfera
- Otimização de assets

Uso:
"Construa o mapa do jogo Steal An Egg"
"Crie uma floresta atmosférica com lighting"
"Otimize as parts para melhor performance"
```

---

### 🧪 Testes & Publicação

| Agente | Especialidade | Experiência |
|--------|---------------|-------------|
| **roblox-playtester** | QA engineer | 12 anos |
| **computer-player** | Jogador autônomo | Automação |
| **roblox-publisher** | Publicação | Deploy |

#### roblox-playtester
```
Especialidades:
- Teste exploratório
- Encontrar bugs
- Validar UX
- Teste de performance
- Documentação de bugs

Uso:
"Teste o jogo por 10 minutos e encontre bugs"
"Valide se o sistema de moedas funciona"
"Teste a performance em mobile"
```

#### computer-player
```
Especialidades:
- Jogo autônomo
- Simulação de input
- Teste de edge cases
- Stress testing
- Validação de mecânicas

Uso:
"Jogue o jogo por 5 minutos"
"Teste se é possível dar exploit"
"Simule 100 jogadores ao mesmo tempo"
```

#### roblox-publisher
```
Especialidades:
- Configuração de place
- Thumbnails e descrição
- Monetização
- Analytics
- Deploy

Uso:
"Configure o place para publicação"
"Crie thumbnails atraentes"
"Configure a monetização"
```

---

## 🔄 Fluxo de Trabalho com ClaudeBlox

### Passo 1: Configuração
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
```

### Passo 2: Iniciar Arquiteto
```
Prompt: "Analise o jogo 'Steal An Egg' e crie um documento de design completo"

O roblox-architect vai:
1. Analisar mecânicas
2. Criar estrutura de sistemas
3. Documentar arquitetura
4. Criar plano de desenvolvimento
```

### Passo 3: CodeWriter
```
Prompt: "Implemente o sistema de moedas descrito no documento de design"

O luau-scripter vai:
1. Ler o documento de design
2. Criar DataStoreManager
3. Criar CurrencyManager
4. Criar UI de moedas
5. Documentar o código
```

### Passo 4: Testador
```
Prompt: "Teste o sistema de moedas e encontre bugs"

O roblox-playtester vai:
1. Testar cada funcionalidade
2. Tentar exploits
3. Documentar bugs
4. Sugerir correções
```

### Passo 5: Corretor
```
Prompt: "Corrija os bugs encontrados pelo testador"

O luau-scripter vai:
1. Ler relatório de bugs
2. Corrigir cada bug
3. Documentar correções
4. Solicitar re-teste
```

### Passo 6: Publicador
```
Prompt: "Publique o jogo na Roblox"

O roblox-publisher vai:
1. Configurar place
2. Criar thumbnails
3. Escrever descrição
4. Publicar
```

---

## 💡 Dicas de Uso

### 1. Prompts Específicos
```
❌ ERRADO: "Crie um jogo"
✅ CORRETO: "Crie um sistema de moedas com DataStoreService que salva a cada 5 minutos"
```

### 2. Contexto Completo
```
❌ ERRADO: "Adicione um botão"
✅ CORRETO: "Adicione um botão de compra na tela de loja que custa 100 moedas"
```

### 3. Validação Contínua
```
❌ ERRADO: Criar tudo de uma vez
✅ CORRETO: Criar → Testar → Corrigir → Próximo
```

---

## 📊 Comparativo

| Aspecto | ClaudeBlox | MCP Genérico |
|---------|------------|--------------|
| **Agentes** | 21 especializados | 1 genérico |
| **Especialização** | Roblox específico | Geral |
| **Testes** | Playtester dedicado | Manual |
| **Publicação** | Publisher incluso | Manual |
| **Curva de aprendizado** | Média | Baixa |
| **Flexibilidade** | Alta | Média |

---

## 🔗 Recursos

| Recurso | URL |
|---------|-----|
| **GitHub** | https://github.com/Claudeblox/claudeblox |
| **Claude Code** | https://claude.ai/code |
| **Roblox Studio MCP** | https://github.com/Meganugger/roblox-studio-mcp |

---

*ClaudeBlox Guide v1.0 - Setembro 2026*