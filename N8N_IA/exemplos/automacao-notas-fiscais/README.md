# 📄 Automação de Notas Fiscais

> Processamento completo de documentos fiscais com IA

---

## Visão Geral

Sistema que:
- Recebe notas fiscais por e-mail
- Analisa documentos com IA
- Classifica entre pessoal/corporativo
- Organiza no Google Drive
- Registra em planilha

---

## Fluxo do Sistema

```
┌─────────────────────────────────────────────────┐
│        AUTOMAÇÃO DE NOTAS FISCAIS               │
├─────────────────────────────────────────────────┤
│                                                 │
│  [Gmail Trigger] → [Extrair Anexos]            │
│                                                 │
│                    ↓                            │
│                                                 │
│         [Análise com IA - Classificar]          │
│                                                 │
│    ┌─────────────────┴─────────────────┐       │
│    │                                   │       │
│    ▼                                   ▼       │
│  ┌─────────┐                     ┌─────────┐  │
│  │PESSOAL  │                     │CORPORAT.│  │
│  └─────────┘                     └─────────┘  │
│    │                                   │       │
│    ▼                                   ▼       │
│  Drive/Pessoal                   Drive/Corp    │
│    │                                   │       │
│    └───────────────┬───────────────────┘       │
│                    │                           │
│                    ▼                           │
│           [Registrar em Planilha]              │
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
      "readStatus": "unread",
      "hasAttachment": true
    }
  }
}
```

### 2. Extrair Anexos

```json
{
  "type": "n8n-nodes-base.gmail",
  "parameters": {
    "resource": "message",
    "operation": "get",
    "messageId": "={{$json.id}}",
    "options": {
      "downloadAttachments": true,
      "attachmentPrefix": "attachment_"
    }
  }
}
```

### 3. Filtrar PDFs

```json
{
  "type": "n8n-nodes-base.if",
  "parameters": {
    "conditions": {
      "string": [
        {
          "value1": "={{$json.attachment_0.mimeType}}",
          "operation": "equals",
          "value2": "application/pdf"
        }
      ]
    }
  }
}
```

### 4. Análise com IA

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
          "content": "Analise esta nota fiscal e retorne um JSON com:\n\n1. tipo: 'pessoal' ou 'corporativo'\n2. empresa: nome da empresa emissora\n3. cnpj: CNPJ da empresa\n4. valor: valor total (número)\n5. data: data de emissão (YYYY-MM-DD)\n6. categoria: categoria do gasto\n7. descricao: breve descrição\n\nExemplo de resposta:\n{\n  \"tipo\": \"corporativo\",\n  \"empresa\": \"Empresa XYZ\",\n  \"cnpj\": \"12.345.678/0001-90\",\n  \"valor\": 1500.00,\n  \"data\": \"2026-09-01\",\n  \"categoria\": \"Material de Escritório\",\n  \"descricao\": \"Compra de papel e canetas\"\n}\n\nRetorne APENAS o JSON, sem texto adicional.",
          "role": "system"
        },
        {
          "content": "={{$json.attachment_0.text}}",
          "role": "user"
        }
      ]
    },
    "options": {
      "temperature": 0.1,
      "maxTokens": 500
    }
  }
}
```

### 5. Parse do JSON

```json
{
  "type": "n8n-nodes-base.code",
  "parameters": {
    "jsCode": "const text = $input.first().json.message.content;\nconst jsonMatch = text.match(/\\{[\\s\\S]*\\}/);\nif (jsonMatch) {\n  const parsed = JSON.parse(jsonMatch[0]);\n  return [{ json: parsed }];\n}\nthrow new Error('JSON não encontrado na resposta');"
  }
}
```

### 6. Switch por Tipo

```json
{
  "type": "n8n-nodes-base.switch",
  "parameters": {
    "dataType": "string",
    "value1": "={{$json.tipo}}",
    "rules": [
      {
        "value2": "pessoal",
        "output": 0
      },
      {
        "value2": "corporativo",
        "output": 1
      }
    ]
  }
}
```

### 7. Upload para Google Drive

#### Pasta Pessoal

```json
{
  "type": "n8n-nodes-base.googleDrive",
  "parameters": {
    "operation": "upload",
    "name": "={{$json.empresa}}_{{$json.data}}.pdf",
    "folderId": "ID_PASTA_PESSOAL",
    "binaryPropertyName": "attachment_0",
    "options": {
      "mimeType": "application/pdf"
    }
  }
}
```

#### Pasta Corporativa

```json
{
  "type": "n8n-nodes-base.googleDrive",
  "parameters": {
    "operation": "upload",
    "name": "={{$json.empresa}}_{{$json.data}}.pdf",
    "folderId": "ID_PASTA_CORPORATIVA",
    "binaryPropertyName": "attachment_0",
    "options": {
      "mimeType": "application/pdf"
    }
  }
}
```

### 8. Registrar em Planilha

```json
{
  "type": "n8n-nodes-base.googleSheets",
  "parameters": {
    "operation": "append",
    "documentId": {
      "value": "ID_PLANILHA"
    },
    "sheetName": {
      "value": "Notas Fiscais"
    },
    "columns": {
      "mappingMode": "defineBelow",
      "value": {
        "Data Processamento": "={{$now.toISO()}}",
        "Empresa": "={{$json.empresa}}",
        "CNPJ": "={{$json.cnpj}}",
        "Valor": "={{$json.valor}}",
        "Data Emissão": "={{$json.data}}",
        "Categoria": "={{$json.categoria}}",
        "Descrição": "={{$json.descricao}}",
        "Tipo": "={{$json.tipo}}",
        "Arquivo": "={{$json.driveUrl}}"
      }
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

# Google Drive
GOOGLE_DRIVE_PESSOAL_ID=xxx
GOOGLE_DRIVE_CORPORATIVO_ID=xxx

# Google Sheets
GOOGLE_SHEET_ID=xxx
```

### Estrutura de Pastas Drive

```
📁 Drive
├── 📁 Notas Fiscais
│   ├── 📁 Pessoal
│   │   ├── 📁 2026
│   │   │   ├── 📁 09-Setembro
│   │   │   └── 📁 08-Agosto
│   │   └── ...
│   └── 📁 Corporativo
│       ├── 📁 2026
│       │   ├── 📁 09-Setembro
│       │   └── 📁 08-Agosto
│       └── ...
└── ...
```

### Estrutura da Planilha

| Coluna | Descrição |
|--------|-----------|
| Data Processamento | Quando foi processado |
| Empresa | Empresa emissora |
| CNPJ | CNPJ da empresa |
| Valor | Valor total |
| Data Emissão | Data da nota |
| Categoria | Categoria do gasto |
| Descrição | Breve descrição |
| Tipo | pessoal/corporativo |
| Arquivo | Link no Drive |

---

## Tratamento de Múltiplos Anexos

```json
{
  "type": "n8n-nodes-base.splitInBatches",
  "parameters": {
    "batchSize": 1
  }
}
```

---

## Categorias Automáticas

```json
{
  "system_prompt": "Categorize a nota fiscal em uma das categorias:\n- Alimentação\n- Transporte\n- Material de Escritório\n- Serviços\n- Software\n- Treinamento\n- Consultoria\n- Outros"
}
```

---

## Testes

### Request de Teste

```bash
# Enviar e-mail com anexo de nota fiscal para a conta monitorada
# O workflow detectará automaticamente e processará
```

### Verificar Resultado

1. Verificar planilha de registro
2. Verificar pasta correspondente no Drive
3. Verificar logs de processamento

---

## Métricas

### Dashboard

```json
{
  "notas_processadas_hoje": 15,
  "pessoal": 8,
  "corporativo": 7,
  "valor_total": 12500.00,
  "categorias": {
    "alimentacao": 5,
    "transporte": 3,
    "material_escritorio": 4,
    "servicos": 3
  }
}
```

---

## Personalização

### Adicionar Categorias

```json
{
  "system_prompt": "... Categorize em:\n- Alimentação\n- Transporte\n- Material de Escritório\n- Serviços\n- Software\n- Treinamento\n- Consultoria\n- Marketing\n- Jurídico\n- Contábil\n- Outros"
}
```

### Mudar Critérios de Classificação

```json
{
  "system_prompt": "Classifique como corporativo se:\n- Empresa emissora é fornecedora conhecida\n- Categoria é material de escritório ou serviços\n- Valor > R$ 100,00\n\nCaso contrário, pessoal."
}
```

### Adicionar Notificação

```json
{
  "name": "Notificar Contabilidade",
  "type": "n8n-nodes-base.gmail",
  "parameters": {
    "resource": "message",
    "operation": "send",
    "sendTo": "contabilidade@empresa.com",
    "subject": "NF Processada - {{$json.empresa}}",
    "message": "Nota fiscal processada:\n\nEmpresa: {{$json.empresa}}\nValor: R$ {{$json.valor}}\nTipo: {{$json.tipo}}"
  }
}
```

---

## Troubleshooting

| Problema | Solução |
|----------|---------|
| E-mail sem anexo | Verificar filtro hasAttachment |
| PDF não lê texto | Usar OCR (Google Vision) |
| Classificação errada | Ajustar prompt da IA |
| Drive sem permissão | Verificar compartilhamento |

---

## Integração com OCR

Para PDFs escaneados (imagens):

```json
{
  "type": "n8n-nodes-base.googleVision",
  "parameters": {
    "operation": "detectText",
    "binaryPropertyName": "attachment_0"
  }
}
```

---

*Última atualização: Setembro 2026*