# 🏗️ Padrões de Projeto para Automações

> **Boas práticas e arquiteturas para automações profissionais!**

---

## 📋 Índice

1. [Padrões de Arquitetura](#padrões-de-arquitetura)
2. [Organização de Workflows](#organização-de-workflows)
3. [Tratamento de Erros](#tratamento-de-erros)
4. [Segurança](#segurança)
5. [Performance](#performance)
6. [Monitoramento](#monitoramento)
7. [Versionamento](#versionamento)

---

## Padrões de Arquitetura

### 1. Padrão Pipe-and-Filter

Sequência linear de processamento.

```
[Input] → [Filter 1] → [Filter 2] → [Filter 3] → [Output]
```

**Uso ideal:**
- Processamento de dados
- Transformações sequenciais
- Validações encadeadas

**Exemplo:**
```json
{
  "nodes": [
    {
      "name": "Receber Dados",
      "type": "n8n-nodes-base.webhook"
    },
    {
      "name": "Validar Email",
      "type": "n8n-nodes-base.if",
      "parameters": {
        "conditions": {
          "string": [{
            "value1": "={{$json.body.email}}",
            "operation": "isEmail"
          }]
        }
      }
    },
    {
      "name": "Formatar",
      "type": "n8n-nodes-base.set",
      "parameters": {
        "assignments": {
          "assignments": [
            {
              "name": "nome",
              "value": "={{$json.body.nome.toUpperCase()}}"
            }
          ]
        }
      }
    },
    {
      "name": "Salvar",
      "type": "n8n-nodes-base.googleSheets"
    }
  ]
}
```

### 2. Padrão Router

Roteamento baseado em condições.

```
                    ┌→ [Handler A]
[Input] → [Router] ─┼→ [Handler B]
                    └→ [Handler C]
```

**Uso ideal:**
- Múltiplos destinos
- Classificação
- Processamento condicional

**Exemplo:**
```json
{
  "nodes": [
    {
      "name": "Receber Mensagem",
      "type": "n8n-nodes-base.telegramTrigger"
    },
    {
      "name": "Classificar",
      "type": "n8n-nodes-base.openAi",
      "parameters": {
        "messages": {
          "values": [{
            "content": "Classifique: VENDAS, SUPORTE ou FINANCEIRO",
            "role": "system"
          }, {
            "content": "={{$json.message.text}}",
            "role": "user"
          }]
        }
      }
    },
    {
      "name": "Roteador",
      "type": "n8n-nodes-base.switch",
      "parameters": {
        "rules": [
          { "value2": "VENDAS", "output": 0 },
          { "value2": "SUPORTE", "output": 1 },
          { "value2": "FINANCEIRO", "output": 2 }
        ]
      }
    },
    {
      "name": "Handler Vendas",
      "type": "n8n-nodes-base.openAi"
    },
    {
      "name": "Handler Suporte",
      "type": "n8n-nodes-base.openAi"
    },
    {
      "name": "Handler Financeiro",
      "type": "n8n-nodes-base.openAi"
    }
  ]
}
```

### 3. Padrão Aggregator

Combina dados de múltiplas fontes.

```
[Fonte A] ─┐
[Fonte B] ─┼→ [Aggregator] → [Output]
[Fonte C] ─┘
```

**Uso ideal:**
- APIs múltiplas
- Consolidação de dados
- Relatórios

**Exemplo:**
```json
{
  "nodes": [
    {
      "name": "Buscar Clientes",
      "type": "n8n-nodes-base.googleSheets",
      "parameters": {
        "operation": "read",
        "documentId": { "value": "CLIENTES" }
      }
    },
    {
      "name": "Buscar Vendas",
      "type": "n8n-nodes-base.googleSheets",
      "parameters": {
        "operation": "read",
        "documentId": { "value": "VENDAS" }
      }
    },
    {
      "name": "Combinar",
      "type": "n8n-nodes-base.merge",
      "parameters": {
        "mode": "combine",
        "mergeByFields": {
          "values": [{ "field1": "clienteId", "field2": "clienteId" }]
        }
      }
    },
    {
      "name": "Gerar Relatório",
      "type": "n8n-nodes-base.function",
      "parameters": {
        "functionCode": "return items.map(item => {\n  return {\n    json: {\n      cliente: item.json.cliente,\n      totalVendas: item.json.vendas.reduce((sum, v) => sum + v.valor, 0)\n    }\n  };\n});"
      }
    }
  ]
}
```

### 4. Padrão Circuit Breaker

Evita falhas em cascata.

```
[Request] → [Circuit Breaker] → [Service]
                ↓
          [Fallback]
```

**Implementação:**
```json
{
  "nodes": [
    {
      "name": "Tentar Chamada",
      "type": "n8n-nodes-base.httpRequest",
      "parameters": {
        "url": "https://api.externa.com/dados",
        "options": {
          "timeout": 5000
        }
      }
    },
    {
      "name": "Se Falhou",
      "type": "n8n-nodes-base.if",
      "parameters": {
        "conditions": {
          "boolean": [{
            "value1": "={{$json.error}}",
            "operation": "equal",
            "value2": true
          }]
        }
      }
    },
    {
      "name": "Fallback",
      "type": "n8n-nodes-base.set",
      "parameters": {
        "assignments": {
          "assignments": [{
            "name": "dados",
            "value": "Dados não disponíveis no momento",
            "type": "string"
          }]
        }
      }
    }
  ]
}
```

### 5. Padrão Event Sourcing

Armazena todas as mudanças de estado.

```
[Event] → [Store Event] → [Update State] → [Notify]
```

**Exemplo:**
```json
{
  "nodes": [
    {
      "name": "Receber Evento",
      "type": "n8n-nodes-base.webhook"
    },
    {
      "name": "Registrar Evento",
      "type": "n8n-nodes-base.googleSheets",
      "parameters": {
        "operation": "append",
        "columns": {
          "value": {
            "Timestamp": "={{$now.toISO()}}",
            "Evento": "={{$json.body.evento}}",
            "Dados": "={{JSON.stringify($json.body.dados)}}",
            "Status": "registrado"
          }
        }
      }
    },
    {
      "name": "Processar",
      "type": "n8n-nodes-base.function"
    },
    {
      "name": "Atualizar Status",
      "type": "n8n-nodes-base.googleSheets",
      "parameters": {
        "operation": "update",
        "columns": {
          "value": {
            "Status": "processado"
          }
        }
      }
    }
  ]
}
```

---

## Organização de Workflows

### Nomenclatura

```
✅ BOM:
- "Enviar Email de Boas-Vindas"
- "Processar Pedido #123"
- "Monitorar Estoque"

❌ RUIM:
- "Node1"
- "Teste"
- "Workflow 2"
```

### Cores dos Nós

| Cor | Uso |
|-----|-----|
| 🟢 Verde | Triggers, entrada de dados |
| 🔵 Azul | Processamento principal |
| 🟡 Amarelo | Condições, branching |
| 🔴 Vermelho | Erros, alertas |
| 🟣 Roxo | IA, machine learning |
| ⚫ Cinza | Output, notificações |

### Agrupamento

```
📋 PROJETO: Atendimento ao Cliente
├── 📂 Prerequisites
│   ├── Configurar Credenciais
│   └── Variáveis de Ambiente
├── 📂 Triggers
│   ├── Webhook Principal
│   └── Monitor de E-mails
├── 📂 Processamento
│   ├── Classificar Mensagem
│   ├── Rotear para Agente
│   └── Gerar Resposta
├── 📂 Output
│   ├── Enviar Resposta
│   └── Notificar Equipe
└── 📂 Error Handling
    ├── Capturar Erros
    └── Notificar Admin
```

### Variáveis de Ambiente

```bash
# .env (nunca committar!)

# Google
GOOGLE_CLIENT_ID=xxx
GOOGLE_CLIENT_SECRET=xxx

# Telegram
TELEGRAM_BOT_TOKEN=xxx
TELEGRAM_CHAT_ID=xxx

# OpenAI
OPENAI_API_KEY=xxx

# Webhooks
WEBHOOK_SECRET=xxx

# Database
DATABASE_URL=xxx
```

---

## Tratamento de Erros

### 1. Error Trigger Global

Captura erros de qualquer nó:

```json
{
  "name": "Error Trigger",
  "type": "n8n-nodes-base.errorTrigger",
  "parameters": {}
}
```

**Conexão:**
```
[Error Trigger] → [Notificar Admin] → [Log Erro]
```

### 2. Continue on Fail

Permite que o workflow continue mesmo com erro:

```json
{
  "name": "HTTP Request",
  "type": "n8n-nodes-base.httpRequest",
  "parameters": {
    "url": "https://api.externa.com",
    "options": {
      "response": {
        "response": {
          "neverError": true
        }
      }
    }
  }
}
```

### 3. Retry Automático

```json
{
  "options": {
    "retry": {
      "maxRetries": 3,
      "retryInterval": 1000
    }
  }
}
```

### 4. Timeout

```json
{
  "options": {
    "timeout": 30000
  }
}
```

### 5. Validação de Input

```json
{
  "name": "Validar",
  "type": "n8n-nodes-base.if",
  "parameters": {
    "conditions": {
      "boolean": [
        {
          "value1": "={{$json.body.email}}",
          "operation": "isEmail"
        },
        {
          "value1": "={{$json.body.nome}}",
          "operation": "isNotEmpty"
        }
      ]
    }
  }
}
```

### 6. Log de Erros

```json
{
  "name": "Log Erro",
  "type": "n8n-nodes-base.googleSheets",
  "parameters": {
    "operation": "append",
    "columns": {
      "value": {
        "Timestamp": "={{$now.toISO()}}",
        "Workflow": "={{$workflow.name}}",
        "Erro": "={{$json.error.message}}",
        "Node": "={{$json.error.node}}",
        "Stack": "={{$json.error.stack}}"
      }
    }
  }
}
```

---

## Segurança

### 1. Credenciais

```
✅ Usar Variáveis de Ambiente
✅ Nunca hardcodar chaves
✅ Rotacionar chaves periodicamente
✅ Usar mínimo de permissões necessário

❌ Não commitar .env
❌ Não compartilhar credenciais
❌ Não usar chaves de produção em testes
```

### 2. Webhooks

```json
{
  "authentication": "headerAuth",
  "headerAuth": {
    "name": "X-Webhook-Secret",
    "value": "={{$env.WEBHOOK_SECRET}}"
  }
}
```

### 3. Rate Limiting

```json
{
  "options": {
    "batching": {
      "batch": {
        "batchSize": 10,
        "batchInterval": 1000
      }
    }
  }
}
```

### 4. Input Sanitization

```javascript
// Sanitizar input
function sanitize(input) {
  return input
    .replace(/<[^>]*>/g, '')  // Remove HTML
    .trim()
    .substring(0, 1000);      // Limita tamanho
}

return items.map(item => ({
  json: {
    ...item.json,
    mensagem: sanitize(item.json.mensagem)
  }
}));
```

### 5. Audit Log

```json
{
  "name": "Audit Log",
  "type": "n8n-nodes-base.googleSheets",
  "parameters": {
    "operation": "append",
    "columns": {
      "value": {
        "Timestamp": "={{$now.toISO()}}",
        "User": "={{$json.userId}}",
        "Action": "={{$json.action}}",
        "Resource": "={{$json.resource}}",
        "IP": "={{$json.ip}}"
      }
    }
  }
}
```

---

## Performance

### 1. Batch Processing

```json
{
  "options": {
    "batching": {
      "batch": {
        "batchSize": 50,
        "batchInterval": 1000
      }
    }
  }
}
```

### 2. Caching

```json
{
  "name": "Cache Check",
  "type": "n8n-nodes-base.redis",
  "parameters": {
    "operation": "get",
    "key": "cache:{{$json.cacheKey}}"
  }
},
{
  "name": "Se Não Cached",
  "type": "n8n-nodes-base.if",
  "parameters": {
    "conditions": {
      "boolean": [{
        "value1": "={{$json.cacheHit}}",
        "operation": "equal",
        "value2": false
      }]
    }
  }
},
{
  "name": "Buscar Dados",
  "type": "n8n-nodes-base.httpRequest"
},
{
  "name": "Salvar Cache",
  "type": "n8n-nodes-base.redis",
  "parameters": {
    "operation": "set",
    "key": "cache:{{$json.cacheKey}}",
    "value": "={{JSON.stringify($json)}}",
    "expire": 3600
  }
}
```

### 3. Parallel Execution

```json
{
  "name": "Split Batch",
  "type": "n8n-nodes-base.splitInBatches",
  "parameters": {
    "batchSize": 10
  }
}
```

### 4. Connection Pooling

Para bancos de dados:
```json
{
  "options": {
    "connectionPool": {
      "min": 2,
      "max": 10
    }
  }
}
```

### 5. Lazy Loading

```json
{
  "name": "Conditional Load",
  "type": "n8n-nodes-base.if",
  "parameters": {
    "conditions": {
      "boolean": [{
        "value1": "={{$json.needsDetail}}",
        "operation": "equal",
        "value2": true
      }]
    }
  }
}
```

---

## Monitoramento

### 1. Health Check

```json
{
  "name": "Health Check",
  "type": "n8n-nodes-base.scheduleTrigger",
  "parameters": {
    "rule": {
      "interval": [{ "field": "hours", "hoursInterval": 1 }]
    }
  }
},
{
  "name": "Verificar Serviços",
  "type": "n8n-nodes-base.httpRequest",
  "parameters": {
    "url": "https://status.service.com/api/health",
    "options": {
      "timeout": 5000
    }
  }
},
{
  "name": "Notificar se Down",
  "type": "n8n-nodes-base.if",
  "parameters": {
    "conditions": {
      "boolean": [{
        "value1": "={{$json.statusCode}}",
        "operation": "notEqual",
        "value2": 200
      }]
    }
  }
}
```

### 2. Métricas

```json
{
  "name": "Log Métricas",
  "type": "n8n-nodes-base.googleSheets",
  "parameters": {
    "operation": "append",
    "columns": {
      "value": {
        "Timestamp": "={{$now.toISO()}}",
        "Workflow": "={{$workflow.name}}",
        "Duration": "={{$execution.duration}}",
        "Status": "={{$execution.status}}",
        "ItemsProcessed": "={{$json.itemsCount}}"
      }
    }
  }
}
```

### 3. Alertas

```json
{
  "name": "Alerta de Performance",
  "type": "n8n-nodes-base.if",
  "parameters": {
    "conditions": {
      "number": [{
        "value1": "={{$execution.duration}}",
        "operation": "larger",
        "value2": 30000
      }]
    }
  }
},
{
  "name": "Enviar Alerta",
  "type": "n8n-nodes-base.telegram",
  "parameters": {
    "operation": "sendMessage",
    "text": "⚠️ Workflow {{$workflow.name}} demorou mais de 30s para executar."
  }
}
```

---

## Versionamento

### Estrutura de Versões

```
v1.0.0 - Versão inicial
v1.1.0 - Novas features
v1.1.1 - Bugfix
v2.0.0 - Breaking changes
```

### Git para Workflows

```bash
# Exportar workflow
n8n export:workflow --id=WORKFLOW_ID --output=./workflows/

# Importar workflow
n8n import:workflow --input=./workflows/my-workflow.json
```

### Changelog

```markdown
# Changelog

## [1.2.0] - 2026-09-14

### Added
- Suporte a múltiplos idiomas
- Cache de respostas

### Changed
- Otimizado processamento de áudio

### Fixed
- Corrigido timeout em webhooks
```

---

## 📚 Próximos Passos

1. Consulte [Troubleshooting](TROUBLESHOOTING.md) para problemas comuns
2. Revise [Fundamentos](N8N_FUNDAMENTOS.md) para conceitos básicos
3. Estude [Agentes IA](AGENTES_IA.md) para inteligência

---

*Última atualização: Setembro 2026*