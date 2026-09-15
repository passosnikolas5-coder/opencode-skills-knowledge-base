# 📊 Assistente Pessoal Automatizada

> Dashboard completo de produtividade com IA

---

## Visão Geral

Sistema completo de assistente pessoal que integra:
- E-mails
- Tarefas
- Reuniões
- Calendário
- Dashboard de produtividade

---

## Fluxos do Sistema

### 1. Fluxo Principal - API Dashboard

```
┌─────────────────────────────────────────────────┐
│              API DASHBOARD                       │
├─────────────────────────────────────────────────┤
│                                                 │
│  [Webhook] → [Buscar Dados] → [Combinar]       │
│                                                 │
│  ┌───────────┐  ┌───────────┐  ┌───────────┐  │
│  │  E-mails  │  │  Tarefas  │  │ Reuniões  │  │
│  └───────────┘  └───────────┘  └───────────┘  │
│                                                 │
│                   ↓                             │
│                                                 │
│         [Formatar JSON] → [Response]            │
│                                                 │
└─────────────────────────────────────────────────┘
```

**Descrição:** API que retorna todos os dados do dashboard em formato JSON.

---

### 2. Monitor de E-mails

```
[Gmail Trigger] → [Filtrar] → [Processar] → [Armazenar]
```

**Funcionalidades:**
- Monitora novos e-mails a cada minuto
- Filtra por remetente/assunto
- Extrai informações relevantes
- Armazena em planilha

---

### 3. Leitor de Reuniões

```
[Schedule] → [Google Calendar] → [Formatar] → [Notificar]
```

**Funcionalidades:**
- Busca reuniões das próximas 2 horas
- Envia resumo via Telegram
- Lembrete antes da reunião

---

### 4. Extrator de Tarefas

```
[Trigger] → [IA Analisa] → [Classifica] → [Salva]
```

**Funcionalidades:**
- Analisa e-mails com IA
- Extrai tarefas mencionadas
- Classifica por prioridade
- Salva no Google Sheets

---

### 5. Secretária IA

```
[Telegram Trigger] → [Transcrever Áudio] → [IA Processa] → [Resposta]
```

**Funcionalidades:**
- Recebe áudio via Telegram
- Transcreve com Whisper
- Processa com GPT-4
- Responde automaticamente

---

## Configuração

### Variáveis de Ambiente

```bash
# Google
GOOGLE_CLIENT_ID=xxx
GOOGLE_CLIENT_SECRET=xxx

# Telegram
TELEGRAM_BOT_TOKEN=xxx
TELEGRAM_CHAT_ID=xxx

# OpenAI
OPENAI_API_KEY=xxx

# Planilha de Dados
GOOGLE_SHEET_ID=xxx
```

### Credenciais necessárias

1. **Google OAuth2** - Gmail, Sheets, Calendar, Drive
2. **Telegram API** - Bot Token
3. **OpenAI API** - API Key

---

## Estrutura da Planilha

### Aba: E-mails

| Coluna | Descrição |
|--------|-----------|
| A | Data/Hora |
| B | Remetente |
| C | Assunto |
| D | Resumo |
| E | Prioridade |
| F | Status |

### Aba: Tarefas

| Coluna | Descrição |
|--------|-----------|
| A | Tarefa |
| B | Descrição |
| C | Prioridade |
| D | Data Limite |
| E | Status |
| F | Fonte |

### Aba: Reuniões

| Coluna | Descrição |
|--------|-----------|
| A | Título |
| B | Data/Hora |
| C | Participantes |
| D | Link |
| E | Notas |

---

## Como Usar

### 1. Importar Workflows

```bash
# Importar cada fluxo
n8n import:workflow --input=./api-dashboard.json
n8n import:workflow --input=./monitor-emails.json
n8n import:workflow --input=./leitor-reunioes.json
```

### 2. Configurar Credenciais

1. Acesse n8n → Credentials
2. Adicione cada credencial
3. Teste a conexão

### 3. Ativar Workflows

1. Abra cada workflow
2. Clique em "Active"
3. Teste manualmente primeiro

### 4. Acessar Dashboard

```
GET https://seu-n8n.com/webhook/dashboard
```

**Resposta:**
```json
{
  "emails": [...],
  "tarefas": [...],
  "reunioes": [...],
  "resumo": {
    "totalEmails": 15,
    "tarefasPendentes": 8,
    "proximaReuniao": "2026-09-14T14:00:00Z"
  }
}
```

---

## Personalização

### Adicionar nova fonte de dados

```json
{
  "name": "Nova Fonte",
  "type": "n8n-nodes-base.httpRequest",
  "parameters": {
    "url": "https://api.sua-fonte.com/dados"
  }
}
```

### Modificar intervalo de atualização

```json
{
  "rule": {
    "interval": [
      {
        "field": "minutes",
        "minutesInterval": 5  // A cada 5 minutos
      }
    ]
  }
}
```

---

## Troubleshooting

| Problema | Solução |
|----------|---------|
| Dashboard vazio | Verificar credenciais Google |
| E-mails não aparecem | Verificar permissões Gmail |
| Reuniões não listam | Verificar Calendar API |
| Telegram não responde | Verificar bot token |

---

*Última atualização: Setembro 2026*