# 💰 Agente Financeiro com Subagentes

> Atendimento financeiro via Telegram com IA

---

## Visão Geral

Sistema completo de atendimento financeiro com:
- Recebimento via Telegram
- Transcrição de áudio
- Agente principal com IA
- Subagentes especializados
- Respostas personalizadas
- Encaminhamento para suporte

---

## Arquitetura

```
┌─────────────────────────────────────────────────┐
│           AGENTE FINANCEIRO                     │
├─────────────────────────────────────────────────┤
│                                                 │
│  [Telegram] → [Transcrição] → [Roteador IA]    │
│                                                 │
│  ┌─────────────────────────────────────────┐   │
│  │           AGENTE PRINCIPAL              │   │
│  │  (Analisa e decide qual subagente)      │   │
│  └─────────────────────────────────────────┘   │
│                    │                            │
│    ┌───────────────┼───────────────┐            │
│    │               │               │            │
│    ▼               ▼               ▼            │
│  ┌─────┐       ┌─────┐       ┌─────┐          │
│  │Inv. │       │Cred.│       │Imp. │          │
│  └─────┘       └─────┘       └─────┘          │
│                                                 │
└─────────────────────────────────────────────────┘
```

---

## Componentes

### 1. Telegram Trigger

```json
{
  "type": "n8n-nodes-base.telegramTrigger",
  "parameters": {
    "updates": ["message"]
  }
}
```

### 2. Transcrição de Áudio

```json
{
  "type": "n8n-nodes-base.telegram",
  "parameters": {
    "operation": "getFile",
    "fileId": "={{$json.message.voice.file_id}}"
  }
},
{
  "type": "n8n-nodes-base.openAi",
  "parameters": {
    "resource": "audio",
    "operation": "transcribe",
    "model": "whisper-1",
    "binaryPropertyName": "data"
  }
}
```

### 3. Agente Principal (Roteador)

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
          "content": "Você é o roteador do atendimento financeiro.\n\nAnalise a mensagem e identifique o departamento:\n- INVESTIMENTO: Dúvidas sobre investimentos, renda fixa, variável\n- CREDITO: Solicitações de crédito, empréstimos, financiamento\n- IMPOSTO: Dúvidas sobre impostos, declaração, restituição\n- GERAL: Dúvidas gerais, informações\n- SUPORTE: Problemas técnicos, encaminhamento\n\nResponda APENAS com o departamento.",
          "role": "system"
        },
        {
          "content": "={{$json.text}}",
          "role": "user"
        }
      ]
    }
  }
}
```

### 4. Switch para Roteamento

```json
{
  "type": "n8n-nodes-base.switch",
  "parameters": {
    "dataType": "string",
    "value1": "={{$json.message.content}}",
    "rules": [
      {
        "value2": "INVESTIMENTO",
        "output": 0
      },
      {
        "value2": "CREDITO",
        "output": 1
      },
      {
        "value2": "IMPOSTO",
        "output": 2
      },
      {
        "value2": "GERAL",
        "output": 3
      },
      {
        "value2": "SUPORTE",
        "output": 4
      }
    ]
  }
}
```

### 5. Subagentes Especializados

#### Investimentos

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
          "content": "Você é um consultor de investimentos especializado.\n\n## Expertise:\n- Renda fixa (CDB, LCI, LCA, Tesouro Direto)\n- Renda variável (Ações, FIIs)\n- Fundos de investimento\n- Previdência privada\n\n## Regras:\n- Analise o perfil do investidor\n- Considere o horizonte de tempo\n- Mencione riscos explicitamente\n- Nunca garanta retornos\n- Fundamente em dados\n\n## Formato:\n- Resposta clara e objetiva\n- Use exemplos quando possível\n- Inclua próximo passo sugerido",
          "role": "system"
        },
        {
          "content": "={{$json.text}}",
          "role": "user"
        }
      ]
    }
  }
}
```

#### Crédito

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
          "content": "Você é um especialista em crédito e financiamento.\n\n## Expertise:\n- Crédito pessoal\n- Financiamento imobiliário\n- Financiamento veicular\n- Capital de giro\n\n## Regras:\n- Explique condições claramente\n- Mencione taxas e prazos\n- Solicite informações necessárias\n- Encaminhe para análise quando necessário\n\n## Formato:\n- Resposta objetiva\n- Próximos passos claros",
          "role": "system"
        },
        {
          "content": "={{$json.text}}",
          "role": "user"
        }
      ]
    }
  }
}
```

#### Impostos

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
          "content": "Você é um consultor tributário.\n\n## Expertise:\n- Imposto de Renda\n- Nota Fiscal\n- Simplificado Nacional\n- MEI\n\n## Regras:\n- Informe prazos importantes\n- Explique documentos necessários\n- Mencione deduções possíveis\n- Para casos complexos, encaminhe para contador\n\n## Formato:\n- Resposta clara\n- Lista de documentos quando aplicável",
          "role": "system"
        },
        {
          "content": "={{$json.text}}",
          "role": "user"
        }
      ]
    }
  }
}
```

---

## Fluxo Completo

```
1. Usuário envia mensagem/áudio via Telegram
2. Se áudio → transcreve com Whisper
3. Agente principal analisa e identifica departamento
4. Roteia para subagente especializado
5. Subagente gera resposta personalizada
6. Envia resposta via Telegram
7. Registra interação em planilha
```

---

## Configuração

### Variáveis de Ambiente

```bash
# Telegram
TELEGRAM_BOT_TOKEN=xxx
TELEGRAM_CHAT_ID=xxx

# OpenAI
OPENAI_API_KEY=xxx

# Google Sheets
GOOGLE_SHEET_ID=xxx
```

### Credenciais

1. **Telegram API** - Bot Token
2. **OpenAI API** - GPT-4 + Whisper
3. **Google OAuth2** - Sheets para registro

---

## Memória de Contexto

```json
{
  "type": "n8n-nodes-base.memoryBufferWindow",
  "parameters": {
    "contextWindow": 15,
    "memoryKey": "chat_history",
    "sessionKey": "={{$json.chat.id}}"
  }
}
```

---

## Integrações

### 1. Consulta de Dados

```json
{
  "name": "Buscar Dados Cliente",
  "type": "n8n-nodes-base.googleSheets",
  "parameters": {
    "operation": "read",
    "filtersUI": {
      "values": [
        {
          "lookupColumn": "CPF",
          "lookupValue": "={{$json.cpf}}"
        }
      ]
    }
  }
}
```

### 2. Agendamento

```json
{
  "name": "Agendar Reunião",
  "type": "n8n-nodes-base.googleCalendar",
  "parameters": {
    "operation": "create",
    "title": "Reunião Financeira - {{$json.cliente}}",
    "startDateTime": "={{$json.data}}",
    "endDateTime": "={{$json.dataFim}}"
  }
}
```

### 3. Notificação

```json
{
  "name": "Notificar Equipe",
  "type": "n8n-nodes-base.gmail",
  "parameters": {
    "resource": "message",
    "operation": "send",
    "sendTo": "equipe@empresa.com",
    "subject": "Atendimento Financeiro",
    "message": "Novo atendimento: {{$json.resumo}}"
  }
}
```

---

## Métricas

### Dashboard de Atendimentos

```json
{
  "endpoint": "GET /webhook/financeiro/status",
  "response": {
    "atendimentos_hoje": 45,
    "por_departamento": {
      "investimento": 15,
      "credito": 20,
      "imposto": 10
    },
    "tempo_medio_resposta": "8s",
    "satisfacao": "4.8/5"
  }
}
```

### Registro em Planilha

```json
{
  "columns": {
    "value": {
      "Timestamp": "={{$now.toISO()}}",
      "Chat ID": "={{$json.chat.id}}",
      "Mensagem": "={{$json.text}}",
      "Departamento": "={{$json.departamento}}",
      "Resposta": "={{$json.resposta}}"
    }
  }
}
```

---

## Personalização

### Adicionar Novo Subagente

1. Crie um novo nó OpenAI com system prompt específico
2. Adicione regra no Switch
3. Conecte ao output correspondente

### Modificar Departamentos

```json
{
  "rules": [
    { "value2": "NOVO_DEPTO", "output": 5 }
  ]
}
```

### Ajustar Tom de Voz

```json
{
  "system_prompt": "Você é um consultor financeiro com tom:\n- Profissional\n- Empático\n- Didático\n- Direto ao ponto"
}
```

---

## Troubleshooting

| Problema | Solução |
|----------|---------|
| Áudio não transcreve | Verificar formato (ogg/mp3) |
| Roteamento errado | Melhorar exemplos no prompt |
| Resposta genérica | Adicionar contexto do cliente |
| Lentidão | Reduzir janela de memória |

---

*Última atualização: Setembro 2026*