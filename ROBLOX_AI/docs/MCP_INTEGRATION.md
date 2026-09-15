# 🔧 MCP Integration para Roblox

> **Guia completo de como integrar Model Context Protocol com Roblox Studio**

---

## 📋 O que é MCP?

**Model Context Protocol (MCP)** é um protocolo aberto que permite que IAs controlem ferramentas externas. No contexto do Roblox, permite que IA como Claude ou Cursor controlem o Roblox Studio.

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

### Fluxo de Dados

1. **Usuário** faz pergunta para IA
2. **IA** decide usar ferramenta MCP
3. **MCP Server** recebe requisição
4. **Plugin** executa no Studio
5. **Resultado** retorna para IA
6. **IA** apresenta resultado ao usuário

---

## 🛠️ Servidores MCP para Roblox

### 1. roblox-studio-mcp (Mais Completo)

**GitHub:** https://github.com/Meganugger/roblox-studio-mcp

**Instalação:**
```bash
git clone https://github.com/Meganugger/roblox-studio-mcp.git
cd roblox-studio-mcp
npm install
npm start
```

**Configuração Claude:**
```json
{
  "mcpServers": {
    "roblox-studio": {
      "command": "node",
      "args": ["C:\\caminho\\para\\roblox-studio-mcp\\server.js"]
    }
  }
}
```

**21 Tools:**
- roblox_create
- roblox_delete
- roblox_clone
- roblox_move
- roblox_set_property
- roblox_get_children
- roblox_findFirstChild
- roblox_get_descendants
- roblox_get_property
- roblox_get_script
- roblox_set_script
- roblox_create_script
- roblox_delete_script
- roblox_run_code
- roblox_playtest
- roblox_stop
- roblox_press_button
- roblox_type_text
- roblox_screenshot
- roblox_get_logs
- roblox_get_errors

---

### 2. roblox-mcp-pro (Multi-Agent)

**GitHub:** https://github.com/PeerapolSelanon/roblox-mcp-pro

**Destaques:**
- 29 tools
- Suporte a multi-agent
- Configuração avançada

**Instalação:**
```bash
git clone https://github.com/PeerapolSelanon/roblox-mcp-pro.git
cd roblox-mcp-pro
npm install
npm start
```

---

### 3. studio-rust-mcp-server (Oficial Roblox)

**GitHub:** https://github.com/Roblox/studio-rust-mcp-server

**Destaques:**
- Escrito em Rust (rápido)
- Mantido pela Roblox
- Performance otimizada

**Instalação:**
```bash
git clone https://github.com/Roblox/studio-rust-mcp-server.git
cd studio-rust-mcp-server
cargo build --release
```

---

### 4. robloxstudio-mcp (TypeScript)

**GitHub:** https://github.com/boshyxd/robloxstudio-mcp

**Destaques:**
- TypeScript
- Fácil de entender
- Boa documentação

---

## 🎯 Configuração por Cliente

### Claude Code

```json
// ~/.claude/claude_desktop_config.json
{
  "mcpServers": {
    "roblox-studio": {
      "command": "node",
      "args": ["C:\\Users\\SeuUsuario\\roblox-studio-mcp\\server.js"],
      "env": {
        "ROBLOX_MCP_TOKEN": "seu-token"
      }
    }
  }
}
```

### Cursor

```json
// .cursor/mcp.json
{
  "mcpServers": {
    "roblox-studio": {
      "command": "node",
      "args": ["C:\\Users\\SeuUsuario\\roblox-studio-mcp\\server.js"]
    }
  }
}
```

### Windsurf

```json
// .windsurfrules
mcp:
  servers:
    roblox-studio:
      command: node
      args:
        - C:\Users\SeuUsuario\roblox-studio-mcp\server.js
```

---

## 📝 Exemplos de Uso

### Criar Estrutura de Projeto

```
Prompt: "Crie a estrutura de pastas para um jogo de obby"

A IA vai executar:
roblox_create Folder="GameSystems"
roblox_create Folder="GameSystems/Checkpoints"
roblox_create Folder="GameSystems/Traps"
roblox_create Folder="UI"
roblox_create Folder="Assets"
roblox_create Folder="ServerScripts"
roblox_create Folder="LocalScripts"
```

### Criar Script

```
Prompt: "Crie um script que detecta quando o jogador cai"

A IA vai executar:
roblox_create_script(
  name="KillBrick",
  parent="ServerScriptService",
  source='
script.Parent.Touched:Connect(function(hit)
    local humanoid = hit.Parent:FindFirstChild("Humanoid")
    if humanoid then
        humanoid.Health = 0
    end
end)
'
)
```

### Modificar Propriedades

```
Prompt: "Torne esta part vermelha e impossível de mover"

A IA vai executar:
roblox_set_property(
  instance="Workspace.MyPart",
  property="Color",
  value={255, 0, 0}
)
roblox_set_property(
  instance="Workspace.MyPart",
  property="Anchored",
  value=true
)
```

### Testar Automaticamente

```
Prompt: "Teste o jogo por 30 segundos e me diga se há erros"

A IA vai executar:
roblox_playtest(duration=30)
roblox_get_errors()
roblox_get_logs()
```

---

## 🔧 Troubleshooting

### Problema: MCP não conecta

**Causas possíveis:**
1. Servidor não está rodando
2. Token incorreto
3. Porta bloqueada
4. Plugin não instalado

**Soluções:**
```bash
# Verificar se o servidor está rodando
curl http://localhost:3000/health

# Reiniciar o servidor
npm start

# Verificar logs
tail -f logs/mcp.log
```

### Problema: Comandos não executam

**Causas possíveis:**
1. Plugin não habilitado no Studio
2. Place não publicado
3. HTTP Requests não habilitado

**Soluções:**
```
1. Plugins → Manage Plugins → Habilitar MCP Plugin
2. File → Publish to Roblox
3. Game Settings → Security → Allow HTTP Requests
```

### Problema: Lentidão

**Causas possíveis:**
1. Muitas instâncias no Studio
2. Scripts pesados
3. Conexão lenta

**Soluções:**
```
1. Otimizar assets
2. Usar Object pooling
3. Limitar chamadas MCP
```

---

## 🎯 Casos de Uso Avançados

### CI/CD para Roblox

```
GitHub Actions → MCP Server → Roblox Studio → Deploy

1. Push no GitHub
2. GitHub Actions roda testes
3. MCP atualiza o place
4. Roblox Studio publica
```

### Testes Automatizados

```
Prompt: "Crie uma suíte de testes para o sistema de moedas"

A IA vai:
1. Criar script de teste
2. Executar testes
3. Gerar relatório
4. Reportar falhas
```

### Code Review Automático

```
Prompt: "Revise todos os scripts do projeto"

A IA vai:
1. Listar todos os scripts
2. Analisar cada um
3. Encontrar problemas
4. Sugerir correções
```

---

## 📊 Comparativo de Servidores

| Servidor | Tools | Linguagem | Performance | Facilidade |
|----------|-------|-----------|-------------|------------|
| **roblox-studio-mcp** | 21 | Node.js | Média | Alta |
| **roblox-mcp-pro** | 29 | Node.js | Média | Média |
| **studio-rust-mcp** | ? | Rust | Alta | Baixa |
| **robloxstudio-mcp** | ? | TypeScript | Média | Alta |

---

## 🔗 Recursos

| Recurso | URL |
|---------|-----|
| **MCP Spec** | https://modelcontextprotocol.io |
| **roblox-studio-mcp** | https://github.com/Meganugger/roblox-studio-mcp |
| **roblox-mcp-pro** | https://github.com/PeerapolSelanon/roblox-mcp-pro |
| **studio-rust-mcp** | https://github.com/Roblox/studio-rust-mcp-server |
| **Roblox API** | https://create.roblox.com/docs |

---

*MCP Integration Guide v1.0 - Setembro 2026*