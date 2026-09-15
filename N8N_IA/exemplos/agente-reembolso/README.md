# 🔄 Agente de Reembolso

> Análise inteligente de solicitações de reembolso

---

## Visão Geral

Sistema que:
- Recebe solicitações via Webhook
- Consulta dados do cliente
- Classifica o perfil
- Decide automaticamente
- Encaminha quando necessário

---

## Fluxo do Sistema

```
┌─────────────────────────────────────────────────┐
│           AGENTE DE REEMBOLSO                   │
├─────────────────────────────────────────────────┤
│                                                 │
│  [Webhook] → [Validar] → [Buscar Cliente]      │
│                                                 │
│                    ↓                            │
│                                                 │
│         [Classificar Cliente com IA]            │
│                                                 │
│    ┌─────────────┼─────────────┐               │
│    │             │             │               │
│    ▼             ▼             ▼               │
│  ┌─────┐     ┌─────┐     ┌─────┐             │
│  │ BOM │     │COMUM│     │ PROB│             │
│  └─────┘     └─────┘     └─────┘             │
│    │             │             │               │
│    ▼             ▼             ▼               │
│  Aprovar     Análise      Rejeitar            │
│              Manual                           │
│                                                 │
└─────────────────────────────────────────────────┘
```

---

## Componentes

### 1. Webhook de Recebimento

```json
{
  "type": "n8n-nodes-base.webhook",
  "parameters": {
    "httpMethod": "POST",
    "path": "reembolso",
    "authentication": "headerAuth",
    "headerAuth": {
      "name": "X-API-Key",
      "value": "={{$env.WEBHOOK_SECRET}}"
    }
  }
}
```

**Payload esperado:**
```json
{
  "clienteId": "12345",
  "valor": 1500.00,
  "motivo": "Produto defeituoso",
  "comprovante": "url_do_comprovante",
  "dataCompra": "2026-09-01"
}
```

### 2. Validação

```json
{
  "type": "n8n-nodes-base.if",
  "parameters": {
    "conditions": {
      "boolean": [
        {
          "value1": "={{$json.body.clienteId}}",
          "operation": "isNotEmpty"
        },
        {
          "value1": "={{$json.body.valor}}",
          "operation": "larger",
          "value2": 0
        }
      ]
    }
  }
}
```

### 3. Busca de Dados do Cliente

```json
{
  "type": "n8n-nodes-base.googleSheets",
  "parameters": {
    "operation": "read",
    "documentId": {
      "value": "ID_PLANILHA_CLIENTES"
    },
    "sheetName": {
      "value": "Clientes"
    },
    "filtersUI": {
      "values": [
        {
          "lookupColumn": "ID",
          "lookupValue": "={{$json.body.clienteId}}"
        }
      ]
    }
  }
}
```

### 4. Classificação com IA

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
          "content": "Você é um analista de reembolsos. Classifique o cliente com base nos dados:\n\n## Critérios:\n- BOM: Histórico de compras alto, pouco reembolsos, cliente antigo\n- COMUM: Compras regulares, alguns reembolsos\n- PROBLEMÁTICO: Muitos reembolsos, reclamações frequentes, valores altos\n\n## Dados do Cliente:\n{{JSON.stringify($json.cliente)}}\n\n## Solicitação:\nValor: R$ {{$json.body.valor}}\nMotivo: {{$json.body.motivo}}\n\nResponda APENAS com: BOM, COMUM ou PROBLEMÁTICO",
          "role": "system"
        }
      ]
    }
  }
}
```

### 5. Switch de Decisão

```json
{
  "type": "n8n-nodes-base.switch",
  "parameters": {
    "dataType": "string",
    "value1": "={{$json.message.content}}",
    "rules": [
      {
        "value2": "BOM",
        "output": 0
      },
      {
        "value2": "COMUM",
        "output": 1
      },
      {
        "value2": "PROBLEMÁTICO",
        "output": 2
      }
    ]
  }
}
```

### 6. Respostas por Classificação

#### Cliente BOM - Aprovação Automática

```json
{
  "name": "Aprovar Auto",
  "type": "n8n-nodes-base.respondToWebhook",
  "parameters": {
    "respondWith": "json",
    "responseBody": "={{{ status: 'aprovado', mensagem: 'Reembolso aprovado automaticamente', prazo: '3-5 dias úteis' }}}"
  }
}
```

#### Cliente COMUM - Análise Manual

```json
{
  "name": "Encaminhar Equipe",
  "type": "n8n-nodes-base.gmail",
  "parameters": {
    "resource": "message",
    "operation": "send",
    "sendTo": "analise@empresa.com",
    "subject": "Reembolso Pendente - Análise",
    "message": "Cliente: {{$json.cliente.nome}}\nValor: R$ {{$json.body.valor}}\nMotivo: {{$json.body.motivo}}\n\nClassificação: COMUM\nRequer análise manual."
  }
}
```

#### Cliente Problemático - Rejeição

```json
{
  "name": "Rejeitar",
  "type": "n8n-nodes-base.respondToWebhook",
  "parameters": {
    "respondWith": "json",
    "responseBody": "={{{ status: 'pendente', mensagem: 'Solicitação em análise. Retornaremos em até 48h.' }}}"
  }
}
```

---

## Configuração

### Variáveis de Ambiente

```bash
# Webhook
WEBHOOK_SECRET=xxx

# Google Sheets
GOOGLE_SHEET_ID_CLIENTES=xxx
GOOGLE_SHEET_ID_REEMBOLSOS=xxx

# OpenAI
OPENAI_API_KEY=xxx

# E-mail
EQUIPE_ANALISE_EMAIL=analise@empresa.com
```

### Estrutura da Planilha

#### Aba: Clientes

| Coluna | Descrição |
|--------|-----------|
| ID | Identificador único |
| Nome | Nome do cliente |
| CPF | CPF |
| Email | E-mail |
| Data Cadastro | Data de cadastro |
| Total Compras | Valor total de compras |
| Total Reembolsos | Valor total de reembolsos |
| Qtd Reembolsos | Quantidade de reembolsos |

#### Aba: Reembolsos

| Coluna | Descrição |
|--------|-----------|
| ID | Identificador |
| Cliente ID | FK do cliente |
| Valor | Valor solicitado |
| Motivo | Motivo do reembolso |
| Status | pendente/aprovado/rejeitado |
| Data Solicitação | Data da solicitação |
| Data Análise | Data da análise |
| Analista | Quem analisou |

---

## Testes

### Request de Teste

```bash
curl -X POST https://seu-n8n.com/webhook/reembolso \
  -H "Content-Type: application/json" \
  -H "X-API-Key: SEU_SECRET" \
  -d '{
    "clienteId": "12345",
    "valor": 150.00,
    "motivo": "Produto não chegou",
    "dataCompra": "2026-09-01"
  }'
```

### Resposta Esperada

```json
{
  "status": "aprovado",
  "mensagem": "Reembolso aprovado automaticamente",
  "prazo": "3-5 dias úteis"
}
```

---

## Métricas

### Dashboard

```json
{
  "reembolsos_hoje": 25,
  "aprovados_auto": 15,
  "analise_manual": 8,
  "rejeitados": 2,
  "valor_total": 15000.00,
  "tempo_medio_analise": "2.5h"
}
```

### Registro

```json
{
  "columns": {
    "value": {
      "Timestamp": "={{$now.toISO()}}",
      "Cliente ID": "={{$json.body.clienteId}}",
      "Valor": "={{$json.body.valor}}",
      "Classificação": "={{$json.classificacao}}",
      "Decisão": "={{$json.decisao}}"
    }
  }
}
```

---

## Personalização

### Ajustar Critérios

```json
{
  "system_prompt": "Classifique considerando:\n- BOM: Compras > R$ 5000, < 2 reembolsos\n- COMUM: Compras R$ 1000-5000, 2-5 reembolsos\n- PROBLEMÁTICO: Reembolsos > 50% das compras"
}
```

### Adicionar Novos Status

```json
{
  "rules": [
    { "value2": "BOM", "output": 0 },
    { "value2": "COMUM", "output": 1 },
    { "value2": "PROBLEMÁTICO", "output": 2 },
    { "value2": "VIP", "output": 3 }
  ]
}
```

---

## Troubleshooting

| Problema | Solução |
|----------|---------|
| Webhook 401 | Verificar header X-API-Key |
| Cliente não encontrado | Verificar ID na planilha |
| Classificação errada | Ajustar critérios no prompt |
| Resposta não chega | Verificar respondToWebhook |

---

*Última atualização: Setembro 2026*