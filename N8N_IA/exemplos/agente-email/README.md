# 📧 Agente de Resposta a E-mails

> Sistema automático de resposta usando IA

---

## Visão Geral

Agente inteligente que:
- Recebe e-mails automaticamente
- Interpreta o conteúdo com IA
- Gera respostas personalizadas
- Envia resposta automaticamente

---

## Fluxo do Sistema

```
┌─────────────────────────────────────────────────┐
│           AGENTE DE E-MAIL                      │
├─────────────────────────────────────────────────┤
│                                                 │
│  [Gmail Trigger] → [Análise IA] → [Resposta]   │
│                                                 │
│  ┌───────────┐     ┌───────────┐               │
│  │ Novo      │     │ GPT-4     │               │
│  │ E-mail    │────▶│ Analisa   │               │
│  └───────────┘     └─────┬─────┘               │
│                          │                      │
│                          ▼                      │
│                    ┌───────────┐                │
│                    │ Resposta  │                │
│                    │ Automática│                │
│                    └───────────┘                │
│                                                 │
└─────────────────────────────────────────────────┘
```

---

## Componentes

### 1. Gmail Trigger

```json
{
  "type": "n8n-nodes-base.gmailTrigger",
  "parameters": {
    "pollTimes": {
      "item": [
        {
          "mode": "everyMinute"
        }
      ]
    },
    "filters": {
      "readStatus": "unread"
    }
  }
}
```

### 2. Análise com IA

```json
{
  "type": "n8n-nodes-base.openAi",
  "parameters": {
    "resource": "chat",
    "operation": "complete",
    "model": "gpt-4",
    "messages": {
      "values": [
        {
          "content": "Você é um assistente profissional que responde e-mails.\n\n## Regras:\n- Seja cordial e profissional\n- Responda de forma clara e objetiva\n- Se não souber a resposta, diga que vai encaminhar para o setor responsável\n- Mantenha o tom amigável\n\n## Formato:\n- Saudação adequada\n- Resposta direta\n- Encerramento profissional",
          "role": "system"
        },
        {
          "content": "De: {{$json.from}}\nAssunto: {{$json.subject}}\n\nCorpo: {{$json.text}}",
          "role": "user"
        }
      ]
    },
    "options": {
      "temperature": 0.7,
      "maxTokens": 500
    }
  }
}
```

### 3. Memória de Contexto

```json
{
  "type": "n8n-nodes-base.memoryBufferWindow",
  "parameters": {
    "contextWindow": 10,
    "memoryKey": "chat_history",
    "sessionKey": "={{$json.from}}"
  }
}
```

### 4. Enviar Resposta

```json
{
  "type": "n8n-nodes-base.gmail",
  "parameters": {
    "resource": "message",
    "operation": "reply",
    "messageId": "={{$json.id}}",
    "responseResponse": "={{$json.message.content}}",
    "options": {
      "appendAttribution": false
    }
  }
}
```

---

## Configuração

### Variáveis de Ambiente

```bash
# Google
GOOGLE_CLIENT_ID=xxx
GOOGLE_CLIENT_SECRET=xxx

# OpenAI
OPENAI_API_KEY=xxx

# Configurações
MAX_EMAILS_PER_HOUR=50
RESPONSE_DELAY_MS=1000
```

### Credenciais

1. **Google OAuth2** - Permissão para ler e enviar e-mails
2. **OpenAI API** - Para processamento de linguagem natural

---

## Personalização

### Modificar Tom de Resposta

```json
{
  "content": "Você é um assistente que responde e-mails com tom:\n- Formal para empresas\n- Amigável para clientes\n- Técnico para suporte",
  "role": "system"
}
```

### Adicionar Filtros

```json
{
  "filters": {
    "readStatus": "unread",
    "subject": "!Re:",  // Excluir respostas
    "from": "!newsletter@" // Excluir newsletters
  }
}
```

### Limitar Respostas

```json
{
  "options": {
    "maxResults": 10,  // Máximo 10 e-mails por execução
    "timeout": 30000   // Timeout de 30 segundos
  }
}
```

---

## Exemplos de Uso

### 1. Suporte Técnico

```json
{
  "system_prompt": "Você é o suporte técnico. Responda dúvidas sobre o produto.",
  "filters": {
    "subject": "Suporte"
  }
}
```

### 2. Vendas

```json
{
  "system_prompt": "Você é o consultor de vendas. Responda sobre preços e demonstrações.",
  "filters": {
    "subject": "Vendas"
  }
}
```

### 3. RH

```json
{
  "system_prompt": "Você é do RH. Responda sobre vagas e processos seletivos.",
  "filters": {
    "subject": "RH"
  }
}
```

---

## Métricas

### Monitorar Performance

```json
{
  "name": "Log Métricas",
  "type": "n8n-nodes-base.googleSheets",
  "parameters": {
    "operation": "append",
    "columns": {
      "value": {
        "Timestamp": "={{$now.toISO()}}",
        "De": "={{$json.from}}",
        "Assunto": "={{$json.subject}}",
        "TempoResposta": "={{$execution.duration}}",
        "Status": "respondido"
      }
    }
  }
}
```

### Dashboard de Status

```json
{
  "endpoint": "GET /webhook/status",
  "response": {
    "emails_processados": 150,
    "taxa_resposta": "95%",
    "tempo_medio": "2.5s"
  }
}
```

---

## Troubleshooting

| Problema | Solução |
|----------|---------|
| E-mails não são lidos | Verificar permissões Gmail |
| Respostas genéricas | Melhorar system prompt |
| Muitas respostas | Adicionar filtros |
| Lentidão | Reduzir contexto de memória |

---

*Última atualização: Setembro 2026*