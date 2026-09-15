# 🔗 Integrações Google e Telegram

> **Guia completo para conectar n8n com os principais serviços!**

---

## 📋 Índice

1. [Integrações Google](#integrações-google)
   - [Google OAuth2](#google-oauth2)
   - [Gmail](#gmail)
   - [Google Sheets](#google-sheets)
   - [Google Calendar](#google-calendar)
   - [Google Drive](#google-drive)
2. [Integração Telegram](#integração-telegram)
   - [Configuração do Bot](#configuração-do-bot)
   - [Recebendo Mensagens](#recebendo-mensagens)
   - [Enviando Mensagens](#enviando-mensagens)
   - [Áudio e Mídia](#áudio-e-mídia)
3. [Webhooks](#webhooks)
4. [APIs REST](#apis-rest)
5. [Autenticação](#autenticação)

---

## Integrações Google

### Google OAuth2

#### Configuração no Google Cloud Console

1. Acesse: https://console.cloud.google.com
2. Crie um novo projeto
3. Ative as APIs necessárias:
   - Gmail API
   - Google Sheets API
   - Google Calendar API
   - Google Drive API

4. Configure OAuth Consent Screen:
   ```
   APIs & Services → OAuth consent screen
   - App name: n8n Integration
   - User support email: seu@email.com
   - Scopes: adicionar todos necessários
   ```

5. Crie credenciais OAuth:
   ```
   APIs & Services → Credentials → Create Credentials → OAuth client ID
   - Application type: Web application
   - Authorized redirect URIs: https://seu-n8n.com/rest/oauth2-credential/callback
   ```

#### Configuração no n8n

```
Credentials → Add Credential → Google OAuth2
```

**Campos obrigatórios:**
- Client ID: `xxx.apps.googleusercontent.com`
- Client Secret: `GOCSPX-xxx`

---

### Gmail

#### Trigger: Novo E-mail

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
      "subject": "assunto do e-mail"
    }
  }
}
```

**Eventos Disponíveis:**
- `messageReceived`: Novo e-mail recebido
- `messageUpdated`: E-mail atualizado

#### Ação: Enviar E-mail

```json
{
  "type": "n8n-nodes-base.gmail",
  "parameters": {
    "resource": "message",
    "operation": "send",
    "sendTo": "destinatario@email.com",
    "subject": "Assunto do E-mail",
    "emailType": "html",
    "message": "<h1>Olá!</h1><p>Este é um e-mail automático.</p>",
    "options": {
      "ccList": ["copia@email.com"],
      "bccList": ["oculto@email.com"],
      "replyTo": "resposta@email.com",
      "attachments": [
        {
          "binaryPropertyName": "anexo"
        }
      ]
    }
  }
}
```

#### Ação: Responder E-mail

```json
{
  "type": "n8n-nodes-base.gmail",
  "parameters": {
    "resource": "message",
    "operation": "reply",
    "messageId": "={{$json.id}}",
    "responseResponse": "Sua resposta aqui",
    "options": {
      "appendAttribution": false
    }
  }
}
```

#### Ação: Marcar como Lido

```json
{
  "type": "n8n-nodes-base.gmail",
  "parameters": {
    "resource": "message",
    "operation": "markAsRead",
    "messageId": "={{$json.id}}"
  }
}
```

#### Exemplo Completo: Monitor de E-mails

```json
{
  "nodes": [
    {
      "name": "Gmail Trigger",
      "type": "n8n-nodes-base.gmailTrigger",
      "parameters": {
        "pollTimes": {
          "item": [{ "mode": "everyMinute" }]
        }
      }
    },
    {
      "name": "Filtrar Importantes",
      "type": "n8n-nodes-base.if",
      "parameters": {
        "conditions": {
          "string": [
            {
              "value1": "={{$json.subject}}",
              "operation": "contains",
              "value2": "URGENTE"
            }
          ]
        }
      }
    },
    {
      "name": "Notificar Telegram",
      "type": "n8n-nodes-base.telegram",
      "parameters": {
        "operation": "sendMessage",
        "chatId": "={{$env.TELEGRAM_CHAT_ID}}",
        "text": "📧 Novo e-mail importante:\n\nDe: {{$json.from}}\nAssunto: {{$json.subject}}"
      }
    }
  ]
}
```

---

### Google Sheets

#### Trigger: Nova Linha

```json
{
  "type": "n8n-nodes-base.googleSheetsTrigger",
  "parameters": {
    "pollTimes": {
      "item": [{ "mode": "everyMinute" }]
    },
    "documentId": {
      "value": "ID_DA_PLANILHA"
    },
    "sheetName": {
      "value": "Página1"
    },
    "event": "rowAdded"
  }
}
```

#### Ação: Adicionar Linha

```json
{
  "type": "n8n-nodes-base.googleSheets",
  "parameters": {
    "operation": "append",
    "documentId": {
      "value": "ID_DA_PLANILHA"
    },
    "sheetName": {
      "value": "Página1"
    },
    "columns": {
      "mappingMode": "defineBelow",
      "value": {
        "A": "={{$json.nome}}",
        "B": "={{$json.email}}",
        "C": "={{$json.data}}"
      }
    }
  }
}
```

#### Ação: Atualizar Linha

```json
{
  "type": "n8n-nodes-base.googleSheets",
  "parameters": {
    "operation": "update",
    "documentId": {
      "value": "ID_DA_PLANILHA"
    },
    "sheetName": {
      "value": "Página1"
    },
    "columns": {
      "mappingMode": "defineBelow",
      "value": {
        "A": "={{$json.id}}",
        "D": "={{$json.status}}"
      }
    },
    "options": {
      "matchingColumn": "A"
    }
  }
}
```

#### Ação: Buscar Dados

```json
{
  "type": "n8n-nodes-base.googleSheets",
  "parameters": {
    "operation": "read",
    "documentId": {
      "value": "ID_DA_PLANILHA"
    },
    "sheetName": {
      "value": "Página1"
    },
    "filtersUI": {
      "values": [
        {
          "lookupColumn": "status",
          "lookupValue": "ativo"
        }
      ]
    }
  }
}
```

#### Exemplo Completo: Automação de Dados

```json
{
  "nodes": [
    {
      "name": "Webhook",
      "type": "n8n-nodes-base.webhook",
      "parameters": {
        "httpMethod": "POST",
        "path": "novo-cliente"
      }
    },
    {
      "name": "Validar Dados",
      "type": "n8n-nodes-base.if",
      "parameters": {
        "conditions": {
          "boolean": [
            {
              "value1": "={{$json.body.email}}",
              "operation": "isNotEmpty"
            }
          ]
        }
      }
    },
    {
      "name": "Adicionar na Planilha",
      "type": "n8n-nodes-base.googleSheets",
      "parameters": {
        "operation": "append",
        "documentId": { "value": "ID_PLANILHA" },
        "sheetName": { "value": "Clientes" },
        "columns": {
          "mappingMode": "defineBelow",
          "value": {
            "Nome": "={{$json.body.nome}}",
            "Email": "={{$json.body.email}}",
            "Telefone": "={{$json.body.telefone}}",
            "Data": "={{$now.toISO()}}"
          }
        }
      }
    },
    {
      "name": "Confirmar Cadastro",
      "type": "n8n-nodes-base.gmail",
      "parameters": {
        "resource": "message",
        "operation": "send",
        "sendTo": "={{$json.body.email}}",
        "subject": "Cadastro Confirmado",
        "message": "Olá {{$json.body.nome}}, seu cadastro foi realizado com sucesso!"
      }
    }
  ]
}
```

---

### Google Calendar

#### Trigger: Novo Evento

```json
{
  "type": "n8n-nodes-base.googleCalendarTrigger",
  "parameters": {
    "pollTimes": {
      "item": [{ "mode": "everyMinute" }]
    },
    "calendarId": "primary",
    "event": "eventCreated"
  }
}
```

#### Ação: Criar Evento

```json
{
  "type": "n8n-nodes-base.googleCalendar",
  "parameters": {
    "operation": "create",
    "calendarId": "primary",
    "title": "Reunião com {{$json.cliente}}",
    "startDateTime": "={{$json.dataInicio}}",
    "endDateTime": "={{$json.dataFim}}",
    "options": {
      "description": "Reunião agendada automaticamente",
      "location": "Sala de Reuniões",
      "attendees": [
        { "email": "participante@email.com" }
      ],
      "reminder": [
        { "minutes": 30, "method": "popup" }
      ]
    }
  }
}
```

#### Ação: Listar Eventos

```json
{
  "type": "n8n-nodes-base.googleCalendar",
  "parameters": {
    "operation": "getAll",
    "calendarId": "primary",
    "timeMin": "={{$now.toISO()}}",
    "timeMax": "={{$now.plus({ days: 7 }).toISO()}}",
    "options": {
      "maxResults": 10
    }
  }
}
```

#### Exemplo: Leitor de Reuniões

```json
{
  "nodes": [
    {
      "name": "Schedule",
      "type": "n8n-nodes-base.scheduleTrigger",
      "parameters": {
        "rule": {
          "interval": [{ "field": "hours", "hoursInterval": 1 }]
        }
      }
    },
    {
      "name": "Buscar Reuniões",
      "type": "n8n-nodes-base.googleCalendar",
      "parameters": {
        "operation": "getAll",
        "calendarId": "primary",
        "timeMin": "={{$now.toISO()}}",
        "timeMax": "={{$now.plus({ hours: 2 }).toISO()}}"
      }
    },
    {
      "name": "Notificar",
      "type": "n8n-nodes-base.telegram",
      "parameters": {
        "operation": "sendMessage",
        "chatId": "={{$env.TELEGRAM_CHAT_ID}}",
        "text": "📅 Próximas reuniões:\n\n{{#each $json.items}}\n- {{this.summary}} ({{this.start.dateTime}})\n{{/each}}"
      }
    }
  ]
}
```

---

### Google Drive

#### Ação: Upload de Arquivo

```json
{
  "type": "n8n-nodes-base.googleDrive",
  "parameters": {
    "operation": "upload",
    "name": "={{$json.nomeArquivo}}",
    "folderId": "ID_DA_PASTA",
    "binaryPropertyName": "arquivo",
    "options": {
      "mimeType": "application/pdf"
    }
  }
}
```

#### Ação: Listar Arquivos

```json
{
  "type": "n8n-nodes-base.googleDrive",
  "parameters": {
    "operation": "list",
    "folderId": "ID_DA_PASTA",
    "options": {
      "maxResults": 50
    }
  }
}
```

#### Exemplo: Organização de Notas Fiscais

```json
{
  "nodes": [
    {
      "name": "Receber E-mail",
      "type": "n8n-nodes-base.gmailTrigger",
      "parameters": {
        "pollTimes": {
          "item": [{ "mode": "everyMinute" }]
        },
        "filters": {
          "hasAttachment": true
        }
      }
    },
    {
      "name": "Analisar com IA",
      "type": "n8n-nodes-base.openAi",
      "parameters": {
        "resource": "chat",
        "operation": "complete",
        "model": "gpt-4",
        "messages": {
          "values": [
            {
              "content": "Analise esta nota fiscal e retorne:\n1. Tipo (pessoal/corporativo)\n2. Empresa\n3. Valor\n4. Data",
              "role": "system"
            },
            {
              "content": "={{$json.text}}",
              "role": "user"
            }
          ]
        }
      }
    },
    {
      "name": "Mover para Pasta",
      "type": "n8n-nodes-base.googleDrive",
      "parameters": {
        "operation": "move",
        "fileId": "={{$json.attachmentId}}",
        "folderId": "={{$json.tipo === 'corporativo' ? 'ID_PASTA_CORP' : 'ID_PASTA_PESSOAL'}}"
      }
    },
    {
      "name": "Registrar em Planilha",
      "type": "n8n-nodes-base.googleSheets",
      "parameters": {
        "operation": "append",
        "documentId": { "value": "ID_PLANILHA" },
        "columns": {
          "mappingMode": "defineBelow",
          "value": {
            "Empresa": "={{$json.empresa}}",
            "Valor": "={{$json.valor}}",
            "Data": "={{$json.data}}",
            "Tipo": "={{$json.tipo}}"
          }
        }
      }
    }
  ]
}
```

---

## Integração Telegram

### Configuração do Bot

1. Procure `@BotFather` no Telegram
2. Envie `/newbot`
3. Escolha um nome para o bot
4. Copie o token recebido

### Configuração no n8n

```
Credentials → Add Credential → Telegram API
```

**Campo:**
- Access Token: `123456:ABC-DEF1234ghIkl-zyx57W2v1u123ew11`

---

### Recebendo Mensagens

#### Trigger: Novas Mensagens

```json
{
  "type": "n8n-nodes-base.telegramTrigger",
  "parameters": {
    "updates": ["message"]
  }
}
```

**Eventos Disponíveis:**
- `message`: Novas mensagens
- `editedMessage`: Mensagens editadas
- `channelPost`: Posts em canais
- `callbackQuery`: Botões inline

#### Filtros

```json
{
  "filters": {
    "chatId": "ID_DO_CHAT",
    "messageType": "text"
  }
}
```

---

### Enviando Mensagens

#### Texto Simples

```json
{
  "type": "n8n-nodes-base.telegram",
  "parameters": {
    "operation": "sendMessage",
    "chatId": "={{$json.chat.id}}",
    "text": "Olá! Mensagem automática.",
    "additionalFields": {
      "parse_mode": "HTML"
    }
  }
}
```

#### Formatação HTML

```json
{
  "text": "<b>Negrito</b>\n<i>Itálico</i>\n<a href='https://example.com'>Link</a>\n<code>Código</code>"
}
```

#### Botões Inline

```json
{
  "text": "Escolha uma opção:",
  "reply_markup": {
    "inline_keyboard": [
      [
        { "text": "Opção 1", "callback_data": "opcao1" },
        { "text": "Opção 2", "callback_data": "opcao2" }
      ]
    ]
  }
}
```

#### Teclado de Resposta

```json
{
  "text": "Selecione:",
  "reply_markup": {
    "keyboard": [
      [{ "text": "Opção A" }, { "text": "Opção B" }],
      [{ "text": "Opção C" }]
    ],
    "resize_keyboard": true,
    "one_time_keyboard": true
  }
}
```

---

### Áudio e Mídia

#### Enviar Áudio

```json
{
  "operation": "sendAudio",
  "chatId": "={{$json.chat.id}}",
  "audio": "={{$json.audioUrl}}",
  "caption": "Áudio processado"
}
```

#### Enviar Documento

```json
{
  "operation": "sendDocument",
  "chatId": "={{$json.chat.id}}",
  "document": "={{$json.documentUrl}}",
  "caption": "Documento processado"
}
```

#### Enviar Foto

```json
{
  "operation": "sendPhoto",
  "chatId": "={{$json.chat.id}}",
  "photo": "={{$json.photoUrl}}",
  "caption": "Foto processada"
}
```

---

## Webhooks

### Criar Webhook

```json
{
  "type": "n8n-nodes-base.webhook",
  "parameters": {
    "httpMethod": "POST",
    "path": "meu-webhook",
    "authentication": "headerAuth",
    "headerAuth": {
      "name": "X-API-Key",
      "value": "={{$env.WEBHOOK_SECRET}}"
    }
  }
}
```

**URL do Webhook:**
```
https://seu-n8n.com/webhook/meu-webhook
```

### Autenticação de Webhook

#### Header Auth

```json
{
  "authentication": "headerAuth",
  "headerAuth": {
    "name": "Authorization",
    "value": "Bearer {{$env.API_KEY}}"
  }
}
```

#### Basic Auth

```json
{
  "authentication": "basicAuth",
  "basicAuth": {
    "user": "={{$env.WEBHOOK_USER}}",
    "password": "={{$env.WEBHOOK_PASS}}"
  }
}
```

### Responder a Webhook

```json
{
  "type": "n8n-nodes-base.respondToWebhook",
  "parameters": {
    "respondWith": "json",
    "responseBody": "={{$json}}"
  }
}
```

### Exemplo Completo: API de Reembolso

```json
{
  "nodes": [
    {
      "name": "Webhook",
      "type": "n8n-nodes-base.webhook",
      "parameters": {
        "httpMethod": "POST",
        "path": "reembolso"
      }
    },
    {
      "name": "Validar",
      "type": "n8n-nodes-base.if",
      "parameters": {
        "conditions": {
          "boolean": [
            {
              "value1": "={{$json.body.clienteId}}",
              "operation": "isNotEmpty"
            }
          ]
        }
      }
    },
    {
      "name": "Buscar Cliente",
      "type": "n8n-nodes-base.googleSheets",
      "parameters": {
        "operation": "read",
        "documentId": { "value": "ID_PLANILHA" },
        "filtersUI": {
          "values": [
            {
              "lookupColumn": "ID",
              "lookupValue": "={{$json.body.clienteId}}"
            }
          ]
        }
      }
    },
    {
      "name": "Classificar",
      "type": "n8n-nodes-base.openAi",
      "parameters": {
        "resource": "chat",
        "operation": "complete",
        "model": "gpt-4",
        "messages": {
          "values": [
            {
              "content": "Classifique o cliente como: BOM, COMUM ou PROBLEMÁTICO baseado no histórico.",
              "role": "system"
            },
            {
              "content": "={{JSON.stringify($json.cliente)}}",
              "role": "user"
            }
          ]
        }
      }
    },
    {
      "name": "Processar",
      "type": "n8n-nodes-base.switch",
      "parameters": {
        "dataType": "string",
        "value1": "={{$json.classificacao}}",
        "rules": [
          { "value2": "BOM", "output": 0 },
          { "value2": "COMUM", "output": 1 },
          { "value2": "PROBLEMÁTICO", "output": 2 }
        ]
      }
    },
    {
      "name": "Aprovar Auto",
      "type": "n8n-nodes-base.respondToWebhook",
      "parameters": {
        "respondWith": "json",
        "responseBody": "={{{ status: 'aprovado', mensagem: 'Reembolso aprovado automaticamente' }}}"
      }
    },
    {
      "name": "Encaminhar Equipe",
      "type": "n8n-nodes-base.gmail",
      "parameters": {
        "resource": "message",
        "operation": "send",
        "sendTo": "equipe@empresa.com",
        "subject": "Reembolso Pendente",
        "message": "Cliente: {{$json.cliente.nome}}\nValor: {{$json.body.valor}}\nMotivo: Análise manual necessária"
      }
    },
    {
      "name": "Rejeitar",
      "type": "n8n-nodes-base.respondToWebhook",
      "parameters": {
        "respondWith": "json",
        "responseBody": "={{{ status: 'rejeitado', mensagem: 'Reembolso negado' }}}"
      }
    }
  ]
}
```

---

## APIs REST

### Configuração Genérica

```json
{
  "type": "n8n-nodes-base.httpRequest",
  "parameters": {
    "url": "https://api.example.com/endpoint",
    "method": "GET",
    "authentication": "genericCredentialType",
    "genericAuthType": "httpHeaderAuth",
    "sendHeaders": true,
    "headerParameters": {
      "parameters": [
        {
          "name": "X-Custom-Header",
          "value": "valor"
        }
      ]
    }
  }
}
```

### Headers Comuns

```json
{
  "headers": {
    "Content-Type": "application/json",
    "Authorization": "Bearer {{$env.API_KEY}}",
    "X-API-Key": "={{$env.API_KEY}}"
  }
}
```

### Tratamento de Erros

```json
{
  "options": {
    "response": {
      "response": {
        "fullResponse": true
      }
    },
    "timeout": 30000
  }
}
```

---

## Autenticação

### Tipos Suportados no n8n

| Tipo | Uso |
|------|-----|
| **API Key** | Chaves simples |
| **OAuth2** | Google, Microsoft, etc. |
| **Bearer Token** | JWT, API tokens |
| **Basic Auth** | Usuário/senha |
| **Header Auth** | Custom headers |

### Variáveis de Ambiente

```bash
# .env
GOOGLE_CLIENT_ID=xxx
GOOGLE_CLIENT_SECRET=xxx
TELEGRAM_BOT_TOKEN=xxx
OPENAI_API_KEY=xxx
WEBHOOK_SECRET=xxx
```

### Uso no n8n

```javascript
// Em expressões
{{$env.GOOGLE_CLIENT_ID}}
{{$env.TELEGRAM_BOT_TOKEN}}
{{$env.OPENAI_API_KEY}}
```

---

## 📚 Próximos Passos

1. Conheça [Padrões de Projeto](PADROES_PROJETO.md)
2. Estude [Troubleshooting](TROUBLESHOOTING.md)
3. Pratique com os [Templates](../templates/)

---

*Última atualização: Setembro 2026*