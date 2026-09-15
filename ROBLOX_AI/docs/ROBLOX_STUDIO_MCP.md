# 🟢 Roblox Studio MCP - Guia Completo

> **O servidor MCP mais completo para controlar o Roblox Studio via IA**

---

## 📊 Resumo

| Aspecto | Detalhe |
|---------|---------|
| **GitHub** | [Meganugger/roblox-studio-mcp](https://github.com/Meganugger/roblox-studio-mcp) |
| **Tipo** | MCP Server + Plugin Lua |
| **Clientes** | Claude, Cursor, Codex, Gemini |
| **Preço** | Gratuito (open source) |
| **21 Tools** | Listadas abaixo |

---

## 🛠️ As 21 Tools Disponíveis

### Gerenciamento de Instâncias
| # | Tool | Função |
|---|------|--------|
| 1 | `roblox_create` | Cria instâncias (Part, Script, Folder, etc.) |
| 2 | `roblox_delete` | Deleta instâncias |
| 3 | `roblox_clone` | Clona instâncias |
| 4 | `roblox_move` | Move instâncias |
| 5 | `roblox_set_property` | Define propriedades |

### Scripts
| # | Tool | Função |
|---|------|--------|
| 6 | `roblox_get_script` | Lê scripts existentes |
| 7 | `roblox_set_script` | Modifica scripts |
| 8 | `roblox_create_script` | Cria novos scripts |
| 9 | `roblox_delete_script` | Deleta scripts |
| 10 | `roblox_run_code` | Executa código Lua |

### Exploração
| # | Tool | Função |
|---|------|--------|
| 11 | `roblox_get_children` | Lista filhos de instância |
| 12 | `roblox_findFirstChild` | Busca filho por nome |
| 13 | `roblox_get_descendants` | Lista todos descendentes |
| 14 | `roblox_get_property` | Lê propriedades |

### Testes
| # | Tool | Função |
|---|------|--------|
| 15 | `roblox_playtest` | Inicia teste automático |
| 16 | `roblox_stop` | Para teste |
| 17 | `roblox_press_button` | Clica em botões |
| 18 | `roblox_type_text` | Digita texto |

### Utilidades
| # | Tool | Função |
|---|------|--------|
| 19 | `roblox_screenshot` | Tira screenshot |
| 20 | `roblox_get_logs` | Lê logs do console |
| 21 | `roblox_get_errors` | Lista erros |

---

## 🚀 Instalação Rápida

### Pré-requisitos
- Node.js 18+
- Roblox Studio
- Conta Roblox (para publicar)

### Passo 1: Clonar o Repositório
```bash
git clone https://github.com/Meganugger/roblox-studio-mcp.git
cd roblox-studio-mcp
npm install
```

### Passo 2: Iniciar o Servidor
```bash
npm start
```

### Passo 3: Configurar no Studio
1. Abra seu place no Roblox Studio
2. Clique no botão MCP na toolbar
3. Cole o token de autenticação
4. Clique em "Conectar"

### Passo 4: Configurar no Claude/Cursor
```json
// configuração MCP para Claude
{
  "mcpServers": {
    "roblox-studio": {
      "command": "node",
      "args": ["caminho/para/roblox-studio-mcp/server.js"]
    }
  }
}
```

---

## 📝 Exemplos de Uso

### Criar uma Part
```
IA: Crie uma Part vermelha de tamanho 4x1x2 no Workspace
MCP: roblox_create(
  className="Part",
  parent="Workspace",
  name="PartVermelha",
  properties={
    Size={4,1,2},
    Color={255,0,0},
    Anchored=true
  }
)
```

### Criar Script
```
IA: Crie um script que printa "Hello" quando o jogo inicia
MCP: roblox_create_script(
  name="HelloScript",
  parent="ServerScriptService",
  source='print("Hello World!")'
)
```

### Modificar Script
```
IA: Adicione um contador ao script HelloScript
MCP: roblox_set_script(
  name="HelloScript",
  source='
local count = 0
while true do
    count = count + 1
    print("Contador: " .. count)
    task.wait(1)
end
'
)
```

### Testar Automaticamente
```
IA: Teste o jogo por 30 segundos e me diga se há erros
MCP: roblox_playtest(duration=30)
MCP: roblox_get_errors()
```

---

## 🔧 Configuração Avançada

### Autenticação
```bash
# Gerar token
npm run generate-token

# Configurar variável de ambiente
export ROBLOX_MCP_TOKEN="seu-token-aqui"
```

### Porta Personalizada
```bash
# Iniciar na porta 3001
PORT=3001 npm start
```

### Logs Detalhados
```bash
# Ativar debug
DEBUG=true npm start
```

---

## 🎯 Casos de Uso

### 1. Criar Jogo Completo
```
Prompt: "Crie um obby com 10 fases, cada uma mais difícil que a anterior"
A IA vai:
1. Criar estrutura de pastas
2. Criar plataformas para cada fase
3. Adicionar scripts de morte
4. Criar checkpoints
5. Testar automaticamente
```

### 2. Adicionar Sistema de Moedas
```
Prompt: "Adicione um sistema de moedas que salva os dados"
A IA vai:
1. Criar DataStoreManager
2. Criar CurrencyManager
3. Criar UI de moedas
4. Configurar eventos
5. Testar persistência
```

### 3. Criar UI Profissional
```
Prompt: "Crie um menu principal moderno com animações"
A IA vai:
1. Criar ScreenGui
2. Adicionar botões com gradients
3. Criar animações de hover
4. Configurar layout responsivo
5. Testar em diferentes resoluções
```

---

## 🐛 Solução de Problemas

### Problema: MCP não conecta
```bash
# Verificar se o servidor está rodando
curl http://localhost:3000/health

# Reiniciar o servidor
npm start
```

### Problema: Plugin não aparece
```
1. Verifique se o Studio está aberto
2. Clique em "Plugins" → "Manage Plugins"
3. Habilite "MCP Plugin"
4. Reinicie o Studio
```

### Problema: Comandos não executam
```
1. Verifique se o token está correto
2. Verifique os logs do servidor
3. Teste com um comando simples (roblox_create)
```

---

## 📚 Recursos

| Recurso | URL |
|---------|-----|
| **GitHub** | https://github.com/Meganugger/roblox-studio-mcp |
| **Documentação** | https://github.com/Meganugger/roblox-studio-mcp/blob/main/README.md |
| **MCP Spec** | https://modelcontextprotocol.io |
| **Roblox API** | https://create.roblox.com/docs |

---

*Roblox Studio MCP Guide v1.0 - Setembro 2026*