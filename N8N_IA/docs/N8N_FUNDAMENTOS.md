# 📚 Fundamentos do n8n

> **Guia completo para dominar o n8n e criar automações poderosas!**

---

## 📋 Índice

1. [O que é n8n](#o-que-é-n8n)
2. [Instalação](#instalação)
3. [Conceitos Fundamentais](#conceitos-fundamentais)
4. [Interface do Usuário](#interface-do-usuário)
5. [Nós Básicos](#nós-básicos)
6. [Expressões e Dados](#expressões-e-dados)
7. [Autenticação](#autenticação)
8. [Execução e Depuração](#execução-e-depuração)
9. [Boas Práticas](#boas-práticas)

---

## O que é n8n

**n8n** (pronuncia-se "n-eight-n") é uma plataforma de automação de workflows de código aberto que permite conectar diferentes serviços e criar automações complexas sem necessidade de programação avançada.

### Por que usar n8n?

| Vantagem | Descrição |
|----------|-----------|
| **Código Aberto** | Self-hosted gratuito ou n8n Cloud |
| **400+ Integrações** | Google, Slack, Telegram, APIs REST |
| **Visual Drag-and-Drop** | Interface intuitiva |
| **JavaScript Customizável** | Lógica avançada quando necessário |
| **IA Integrada** | OpenAI, Langchain, agentes |
| **Escalável** | De projetos pessoais a enterprise |

---

## Instalação

### Opção 1: Docker (Recomendado)

```bash
# Criar diretório de dados
mkdir ~/.n8n

# Executar n8n
docker run -it --rm \
  --name n8n \
  -p 5678:5678 \
  -v ~/.n8n:/home/node/.n8n \
  n8nio/n8n
```

### Opção 2: npm (Desenvolvimento)

```bash
# Instalar globalmente
npm install n8n -g

# Executar
n8n start
```

### Opção 3: n8n Cloud

Acesse: https://n8n.io/cloud

**Vantagens:**
- Sem servidor para gerenciar
- Atualizações automáticas
- Suporte integrado
- Webhooks públicos

---

## Conceitos Fundamentais

### Workflow (Fluxo de Trabalho)

Um **workflow** é uma sequência de nós conectados que processam dados de ponta a ponta.

```
[Trigger] → [Nó 1] → [Nó 2] → [Nó 3] → [Output]
```

### Nó (Node)

Cada **nó** representa uma ação ou operação:
- **Trigger**: Inicia o workflow
- **Ação**: Processa dados
- **Condição**: Decide caminho
- **Output**: Resultado final

### Conexão (Connection)

**Conexões** ligam nós, transmitindo dados entre eles.

### Item

Cada registro processado é um **item**. Um nó pode receber e enviar múltiplos items.

---

## Interface do Usuário

### Layout Principal

```
┌─────────────────────────────────────────────────┐
│  Header: Workflow Name, Save, Execute           │
├────────────────────┬────────────────────────────┤
│                    │                            │
│   Painel           │   Canvas                   │
│   Lateral          │   (Área de Trabalho)       │
│                    │                            │
│   - Nós            │   [Node] → [Node] → [Node]│
│   - Configurações  │                            │
│   - Histórico      │                            │
│                    │                            │
├────────────────────┴────────────────────────────┤
│  Footer: Status, Execuções, Logs               │
└─────────────────────────────────────────────────┘
```

### Atalhos de Teclado

| Atalho | Ação |
|--------|------|
| `Ctrl + S` | Salvar workflow |
| `Ctrl + Enter` | Executar workflow |
| `Ctrl + Z` | Desfazer |
| `Ctrl + C/X/V` | Copiar/Colar nó |
| `Delete` | Remover nó selecionado |
| `Ctrl + F` | Buscar nó |

---

## Nós Básicos

### 1. Trigger (Gatilho)

Inicia a execução do workflow.

**Tipos de Trigger:**

| Trigger | Descrição |
|---------|-----------|
| **Manual** | Execução manual (teste) |
| **Schedule** | Cronograma (diário, semanal) |
| **Webhook** | Requisição HTTP |
| **Email Trigger** | Novo e-mail recebido |
| **Telegram Trigger** | Nova mensagem Telegram |
| **Google Sheets Trigger** | Nova linha na planilha |

**Exemplo - Schedule:**
```json
{
  "type": "n8n-nodes-base.scheduleTrigger",
  "parameters": {
    "rule": {
      "interval": [
        {
          "field": "hours",
          "hoursInterval": 1
        }
      ]
    }
  }
}
```

### 2. HTTP Request

Faz requisições para APIs externas.

**Exemplo - GET:**
```json
{
  "type": "n8n-nodes-base.httpRequest",
  "parameters": {
    "url": "https://api.example.com/data",
    "method": "GET",
    "headers": {
      "Authorization": "Bearer {{$env.API_KEY}}"
    }
  }
}
```

**Exemplo - POST:**
```json
{
  "type": "n8n-nodes-base.httpRequest",
  "parameters": {
    "url": "https://api.example.com/create",
    "method": "POST",
    "body": {
      "name": "{{$json.name}}",
      "email": "{{$json.email}}"
    }
  }
}
```

### 3. IF (Condição)

Executa ações diferentes baseado em condições.

**Exemplo:**
```json
{
  "type": "n8n-nodes-base.if",
  "parameters": {
    "conditions": {
      "number": [
        {
          "value1": "={{$json.amount}}",
          "operation": "largerEqual",
          "value2": 1000
        }
      ]
    }
  }
}
```

### 4. Switch (Múltiplas Condições)

Avalia múltiplas condições simultaneamente.

### 5. Set (Definir Dados)

Modifica ou adiciona campos aos items.

**Exemplo:**
```json
{
  "type": "n8n-nodes-base.set",
  "parameters": {
    "assignments": {
      "assignments": [
        {
          "name": "status",
          "value": "processed",
          "type": "string"
        },
        {
          "name": "timestamp",
          "value": "={{$now.toISO()}}",
          "type": "string"
        }
      ]
    }
  }
}
```

### 6. Function (JavaScript)

Executa código JavaScript personalizado.

**Exemplo:**
```javascript
// Processar dados
return items.map(item => {
  return {
    json: {
      ...item.json,
      fullName: `${item.json.firstName} ${item.json.lastName}`,
      processedAt: new Date().toISOString()
    }
  };
});
```

### 7. Code (Node Moderno)

Versão atualizada do Function node.

---

## Expressões e Dados

### Sintaxe de Expressões

n8n usa expressões JavaScript entre `{{ }}`.

**Exemplos:**

```javascript
// Acessar dados do nó anterior
{{$json.name}}
{{$json.email}}

// Acessar dados específicos
{{$json.items[0].price}}

// Variáveis de ambiente
{{$env.API_KEY}}

// Dados do workflow
{{$workflow.name}}
{{$workflow.id}}

// Timestamp
{{$now}}
{{$now.plus({ hours: 1 })}}

// Expressões complexas
={{$json.items.filter(i => i.active).length}}
```

### Referências de Dados

| Referência | Descrição |
|------------|-----------|
| `{{$json}}` | Dados do item atual |
| `{{$input.item}}` | Item de entrada |
| `{{$node["NodeName"].json}}` | Dados de outro nó |
| `{{$env.VARIAVEL}}` | Variável de ambiente |
| `{{$workflow}}` | Dados do workflow |

### Manipulação de Arrays

```javascript
// Filtrar
={{$json.items.filter(item => item.price > 100}}

// Mapear
={{$json.items.map(item => item.name)}}

// Encontrar
={{$json.items.find(item => item.id === 123)}}

// Reduzir
={{$json.items.reduce((sum, item) => sum + item.price, 0)}}

// Ordenar
={{$json.items.sort((a, b) => a.price - b.price)}}
```

---

## Autenticação

### Tipos de Autenticação

#### 1. API Key

```json
{
  "headers": {
    "X-API-Key": "{{$env.API_KEY}}"
  }
}
```

#### 2. OAuth2

Configure no n8n:
1. Vá em Credentials → Add Credential
2. Selecione o serviço (Google, Slack, etc.)
3. Insira Client ID e Client Secret
4. Autorize a conexão

#### 3. Bearer Token

```json
{
  "headers": {
    "Authorization": "Bearer {{$env.TOKEN}}"
  }
}
```

#### 4. Basic Auth

```json
{
  "authentication": "genericCredentialType",
  "genericAuthType": "httpBasicAuth"
}
```

### Credenciais no n8n

**Estrutura de Credenciais:**

```
Credentials/
├── Google OAuth2
├── Telegram Bot Token
├── Slack Webhook
├── OpenAI API Key
└── Custom API
```

---

## Execução e Depuração

### Executar Workflow

1. **Manual**: Clique em "Execute Workflow"
2. **Agendado**: Configure Schedule Trigger
3. **Webhook**: Acesse a URL do webhook
4. **API**: Use a API REST do n8n

### Depuração

#### 1. Visualizar Dados

Clique em um nó para ver:
- **Input**: Dados de entrada
- **Output**: Dados de saída
- **Parameters**: Configurações

#### 2. Execução Passo a Passo

1. Execute o workflow
2. Clique em cada nó
3. Analise os dados em cada etapa

#### 3. Logs

Acesse: Executions → Selecione uma execução

**Informações disponíveis:**
- Status (success/error)
- Duração
- Dados em cada nó
- Mensagens de erro

#### 4. Error Handling

```json
{
  "type": "n8n-nodes-base.errorTrigger",
  "parameters": {}
}
```

### Testes

#### Teste de Nó

1. Configure o nó
2. Clique em "Test step"
3. Verifique o output

#### Teste de Workflow

1. Adicione dados de teste
2. Execute manualmente
3. Valide cada etapa

---

## Boas Práticas

### 1. Organização

```
✅ Usar nomes descritivos nos nós
✅ Agrupar nós relacionados
✅ Adicionar notas/legendas
✅ Cores para identificar tipos

❌ Não deixar workflows bagunçados
❌ Não usar nomes genéricos (Node1, Node2)
```

### 2. Tratamento de Erros

```json
{
  "type": "n8n-nodes-base.errorTrigger",
  "parameters": {
    "options": {
      "continueOnFail": true
    }
  }
}
```

**Sempre implementar:**
- Error Trigger para capturar falhas
- Notificações de erro (e-mail, Telegram)
- Retry automático quando possível
- Logging detalhado

### 3. Performance

```
✅ Usar Batch Processing quando possível
✅ Limitar chamadas à API
✅ Cache de dados frequentes
✅ Async/await para operações lentas

❌ Não fazer chamadas desnecessárias
❌ Não processar items um por um (quando possível)
```

### 4. Segurança

```
✅ Usar Variáveis de Ambiente para chaves
✅ Nunca hardcodar credenciais
✅ Limitar acesso a webhooks
✅ Usar HTTPS em produção

❌ Não expor chaves no código
❌ Não compartilhar credenciais
❌ Não usar webhooks sem autenticação
```

### 5. Documentação

```
✅ Nomear workflows claramente
✅ Adicionar descrições
✅ Documentar configurações importantes
✅ Manter histórico de versões

❌ Não deixar workflows sem documentação
```

---

## 📚 Próximos Passos

1. Estude [Agentes IA](AGENTES_IA.md) para criar inteligência
2. Aprenda [Integrações](INTEGRACOES.md) com Google e Telegram
3. Conheça [Padrões de Projeto](PADROES_PROJETO.md)

---

*Última atualização: Setembro 2026*