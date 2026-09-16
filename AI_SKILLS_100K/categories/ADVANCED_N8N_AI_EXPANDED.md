# 🤖 N8N AI — Automação Avançada com IA

> **Fonte:** https://github.com/n8n-io/n8n (65k+ stars)
> **Descrição:** n8n é uma ferramenta de automação de fluxos de trabalho com capacidades de IA, permitindo criar automações visuais com mais de 400 integrações e nós de agentes AI powered by LangChain.

---

## 📋 Índice de Habilidades

1. [Criação de Workflows Visuais](#1)
2. [Nós de Agente AI (LangChain)](#2)
3. [Gerenciamento de Memória de Chat](#3)
4. [Nós de Ferramentas (HTTP, Code, SQL)](#4)
5. [Pipelines RAG](#5)
6. [Nós de Vector Store](#6)
7. [Document Loaders e Text Splitters](#7)
8. [Triggers de Webhook e Schedule](#8)
9. [Tratamento de Erros](#9)
10. [Sub-workflows](#10)
11. [Variáveis e Expressões](#11)
12. [Gerenciamento de Credenciais](#12)
13. [Self-hosting e Cloud Deployment](#13)
14. [Community Nodes](#14)
15. [Debugging e Logs](#15)

---

## 1. Criação de Workflows Visuais

O editor visual do n8n permite construir automações arrastando nós e conectando-os.

### Exemplo: Workflow de Processamento de Email com AI

```json
{
  "name": "Email AI Processor",
  "nodes": [
    {
      "parameters": { "pollTimes": { "item": [{ "mode": "everyMinute" }] }, "filters": { "subject": "URGENTE" } },
      "name": "Email Trigger",
      "type": "n8n-nodes-base.emailReadImap",
      "position": [250, 300]
    },
    {
      "parameters": { "resource": "chat", "model": "gpt-4", "messages": { "values": [{ "content": "Resuma: {{ $json.text }}" }] } },
      "name": "AI Summarizer",
      "type": "@n8n/n8n-nodes-langchain.openAi",
      "position": [450, 300]
    },
    {
      "parameters": { "channel": "#emails", "text": "Resumo: {{ $json.choices[0].message.content }}" },
      "name": "Slack Notification",
      "type": "n8n-nodes-base.slack",
      "position": [650, 300]
    }
  ],
  "connections": {
    "Email Trigger": { "main": [[{ "node": "AI Summarizer" }]] },
    "AI Summarizer": { "main": [[{ "node": "Slack Notification" }]] }
  }
}
```

### Exemplo: Lógica Condicional Avançada

```javascript
const items = $input.all();
const results = [];
for (const item of items) {
  const { priority, aiSentiment } = item.json;
  if (priority === 'high' && aiSentiment === 'negative') {
    results.push({ json: { action: 'escalate', route: 'manager' } });
  } else if (priority === 'medium') {
    results.push({ json: { action: 'queue', route: 'support' } });
  } else {
    results.push({ json: { action: 'auto_respond', route: 'bot' } });
  }
}
return results;
```

### ❌ ERRADO / ✅ CORRETO

❌ Criar workflows monolíticos com 50+ nós sem sub-workflows
✅ Modularizar em sub-workflows reutilizáveis

❌ Hardcoded de API keys no workflow
✅ Usar `{{ $env.OPENAI_API_KEY }}` ou credenciais do n8n

---

## 2. Nós de Agente AI (LangChain)

### Exemplo: Agente com Múltiplas Ferramentas

```javascript
const agentConfig = {
  agent: 'conversationalAgent',
  model: { type: 'openAi', model: 'gpt-4', temperature: 0.7, maxTokens: 2000 },
  tools: {
    tool: [
      { type: 'calculator', name: 'Calculator' },
      { type: 'httpRequest', name: 'API Caller', parameters: { method: 'GET', url: '={{ $json.apiUrl }}' } },
      { type: 'code', name: 'Data Processor', jsCode: 'return { processed: JSON.stringify($input.first().json).toUpperCase() };' }
    ]
  },
  memory: { type: 'windowBuffer', contextWindowLength: 10 },
  systemMessage: 'You are a helpful assistant that can use tools to answer questions.'
};
```

### Exemplo: Agente de Atendimento ao Cliente

```javascript
const workflow = {
  nodes: [
    { name: 'Chat Trigger', type: 'n8n-nodes-base.chatTrigger', parameters: { options: { title: 'Suporte AI' } } },
    {
      name: 'Customer AI Agent',
      type: '@n8n/n8n-nodes-langchain.agent',
      parameters: {
        agent: 'toolsAgent',
        model: { type: 'openAi', model: 'gpt-4' },
        systemMessage: `Você é Maria, assistente de vendas.
Regras:
1. Cumprimente o cliente pelo nome
2. Ofereça no máximo 3 opções
3. Nunca invente preços
4. Para dúvidas técnicas, transfira para suporte`
      }
    }
  ]
};
```

### ❌ ERRADO / ✅ CORRETO

❌ Criar agente sem system message clara → comportamento imprevisível
✅ Definir persona e regras claras no system message

❌ Não configurar maxIterations → loop infinito consumindo tokens
✅ Definir `maxIterations: 10` e `timeout: 30000`

---

## 3. Gerenciamento de Memória de Chat

### Exemplo: Memória com Buffer de Janela

```javascript
const memoryConfig = {
  type: 'windowBufferMemory',
  contextWindowLength: 20,
  memoryKey: 'chat_history',
  returnMessages: true
};
```

### Exemplo: Memória Persistente com Vector Store

```javascript
const persistentMemory = {
  type: 'vectorStoreMemory',
  vectorStore: { type: 'pinecone', config: { apiKey: '{{ $env.PINECONE_API_KEY }}', indexName: 'chat-history' } },
  retrievalConfig: { k: 10, similarityThreshold: 0.7 },
  memoryKey: 'long_term_memory'
};
```

### ❌ ERRADO / ✅ CORRETO

❌ Armazenar toda a conversa sem limite → memory leak e custo crescente
✅ Estratégia: buffer (20 msgs) + resumo (após 50) + vector store (longo prazo)

❌ Não persistir memória entre sessões → usuário perde contexto
✅ Usar session ID: `user_${userId}_session` com TTL de 7 dias

---

## 4. Nós de Ferramentas (HTTP, Code, SQL)

### Exemplo: HTTP Request com Retry

```javascript
const httpRequestConfig = {
  method: 'POST', url: 'https://api.example.com/data',
  headers: { 'Authorization': 'Bearer {{ $env.API_TOKEN }}' },
  body: { json: { query: '{{ $json.userQuery }}' } },
  options: { retry: { maxRetries: 3, retryOn: [429, 500, 502, 503] }, timeout: 30000 }
};
```

### Exemplo: Transformação de Dados

```javascript
const items = $input.all();
return items.map(item => {
  const { id, name, orders } = item.json;
  const totalSpent = orders.reduce((s, o) => s + o.amount, 0);
  const segment = totalSpent > 10000 ? 'VIP' : totalSpent > 5000 ? 'PREMIUM' : 'REGULAR';
  return { json: { customerId: id, name, totalSpent, segment } };
});
```

### ❌ ERRADO / ✅ CORRETO

❌ Hardcoded de credenciais: `const apiKey = 'sk-123...'`
✅ Usar variáveis de ambiente: `$env.OPENAI_API_KEY`

❌ Não tratar erros HTTP → workflow quebra
✅ Try/catch com retry em 429/5xx

---

## 5. Pipelines RAG

### Exemplo: Pipeline RAG Completo

```javascript
const ragPipeline = {
  steps: [
    { name: 'Loader', type: 'pdfLoader', config: { url: '{{ $json.docUrl }}' } },
    { name: 'Splitter', type: 'recursiveCharacter', config: { chunkSize: 1000, chunkOverlap: 200 } },
    { name: 'Embeddings', type: 'openAI', config: { model: 'text-embedding-3-small' } },
    { name: 'VectorStore', type: 'pinecone', config: { indexName: 'knowledge-base', namespace: '{{ $json.tenantId }}' } }
  ]
};
```

### Exemplo: Query com Reranking

```javascript
async function searchWithReranking(query, topK = 10) {
  const vectorResults = await vectorStore.similaritySearch(query, { k: topK * 3 });
  const reranked = await reranker.rerank({ query, documents: vectorResults.map(r => r.pageContent), topN: topK });
  return reranked.filter(r => r.score > 0.5);
}
```

### ❌ ERRADO / ✅ CORRETO

❌ Chunking fixo: `text.match(/.{1,500}/g)` → quebra frases
✅ RecursiveCharacterTextSplitter com separadores semânticos

---

## 6. Nós de Vector Store

### Exemplo: Operações com Pinecone

```javascript
const pineconeConfig = {
  operation: 'upsert', indexName: 'my-index', namespace: 'documents',
  documents: { values: '{{ $json.embeddings }}', metadata: { source: '{{ $json.source }}' } }
};

const searchConfig = {
  operation: 'search', indexName: 'my-index', query: '{{ $json.userQuery }}',
  topK: 5, filter: { source: { $eq: 'knowledge_base' } }
};
```

### ❌ ERRADO / ✅ CORRETO

❌ Documento de 100k caracteres em um único embedding
✅ Chunking inteligente: 800 chars com 150 overlap

---

## 7. Document Loaders e Text Splitters

### Exemplo: Loaders para Múltiplos Formatados

```javascript
const loaders = {
  pdf: { type: 'pdfLoader', config: { url: '{{ $json.pdfUrl }}', splitPages: true } },
  csv: { type: 'csvLoader', config: { filePath: '{{ $json.csvPath }}', headers: true } },
  web: { type: 'cheerioLoader', config: { url: '{{ $json.webUrl }}', selector: 'article' } }
};
```

### Exemplo: Splitter para Código

```javascript
const codeSplitter = { type: 'code', config: { language: 'javascript', chunkSize: 50 } };
const technicalSplitter = {
  type: 'recursiveCharacter',
  config: { chunkSize: 1500, chunkOverlap: 300, separators: ['\\n## ', '\\n```', '\\n\\n', '. '] }
};
```

### ❌ ERRADO / ✅ CORRETO

❌ Usar 500 chars fixo para todo tipo de conteúdo
✅ Adaptar splitter: PDF=1000, Code=1500, Chat=500

---

## 8. Triggers de Webhook e Schedule

### Exemplo: Webhook Seguro

```javascript
const webhookConfig = {
  httpMethod: 'POST', path: 'api/v1/ingest',
  authentication: 'headerAuth', responseMode: 'responseNode'
};

// Validação HMAC
async function validateWebhook(request) {
  const signature = request.headers['x-webhook-signature'];
  const expected = crypto.createHmac('sha256', $env.WEBHOOK_SECRET)
    .update(`${request.headers['x-timestamp']}.${request.body}`).digest('hex');
  if (signature !== expected) throw new Error('Invalid signature');
}
```

### Exemplo: Cron Avançado

```javascript
const schedules = {
  businessHours: { rule: '*/15 9-18 * * 1-5', timezone: 'America/Sao_Paulo' },
  dailyCleanup: { rule: '0 2 * * *' },
  weeklyReport: { rule: '0 9 * * 1' }
};
```

### ❌ ERRADO / ✅ CORRETO

❌ Webhook sem autenticação → vulnerável a abusos
✅ HMAC signature verification + timestamp anti-replay

❌ Cron a cada minuto sem necessidade
✅ Frequência adequada: monitoramento=5min, relatórios=diário

---

## 9. Tratamento de Erros

### Exemplo: Error Handling Completo

```javascript
const errorHandlingConfig = {
  onError: 'continueRegularOutput', retryOnFail: true,
  maxTries: 3, waitBetweenTries: 5000
};

async function handleError(error, context) {
  const errorInfo = { workflow: context.workflow.id, node: context.currentNode.name, error: error.message };
  if (error.severity === 'high') await sendSlackAlert(errorInfo);
  if (error.retryable) { await sleep(Math.pow(2, error.attempt) * 1000); throw error; }
  return { json: { error: true, fallbackAction: 'queued_for_review' } };
}
```

### ❌ ERRADO / ✅ CORRETO

❌ Workflow sem error handling → qualquer falha trava tudo
✅ Retry com backoff + error workflow + notificações

---

## 10. Sub-workflows

### Exemplo: Orquestração com Sub-workflows

```javascript
const mainWorkflow = {
  nodes: [
    { name: 'Route', type: 'switch', parameters: { rules: [{ value2: 'customer' }, { value2: 'order' }] } },
    { name: 'Process Customer', type: 'executeWorkflow', parameters: { workflowId: 'customer-processing' } },
    { name: 'Process Order', type: 'executeWorkflow', parameters: { workflowId: 'order-processing' } }
  ]
};
```

### ❌ ERRADO / ✅ CORRETO

❌ Duplicar lógica de validação em 10 workflows
✅ Criar sub-workflow reutilizável chamado por todos

---

## 11. Variáveis e Expressões

### Exemplo: Expressões Avançadas

```javascript
const expressions = {
  previousData: '{{ $json.fieldName }}',
  firstItem: '{{ $input.first().json.name }}',
  specificNode: '{{ $("Node Name").item.json.data }}',
  calculated: '{{ $json.price * $json.quantity * (1 - $json.discount) }}',
  conditional: '{{ $json.status === "active" ? "Sim" : "Não" }}',
  processed: '{{ $json.items.filter(i => i.active).map(i => i.name) }}'
};
```

### ❌ ERRADO / ✅ CORRETO

❌ Expressões complexas inline → ilegíveis
✅ Lógica complexa em nó Code separado e testável

---

## 12. Gerenciamento de Credenciais

### Exemplo: Estrutura de Credenciais

```javascript
const credentialTypes = {
  openai: { type: 'openAiApi', data: { apiKey: '{{ $env.OPENAI_API_KEY }}' } },
  postgres: { type: 'postgres', data: { host: '{{ $env.DB_HOST }}', ssl: true } },
  slack: { type: 'slackApi', data: { accessToken: '{{ $env.SLACK_BOT_TOKEN }}' } }
};
```

### ❌ ERRADO / ✅ CORRETO

❌ Senhas hardcoded em workflows exportados
✅ Sistema de credenciais criptografadas do n8n

---

## 13. Self-hosting e Cloud Deployment

### Exemplo: Docker Compose

```yaml
version: '3.8'
services:
  n8n:
    image: n8nio/n8n:latest
    ports: ["5678:5678"]
    environment:
      - DB_TYPE=postgresdb
      - DB_POSTGRESDB_HOST=postgres
      - WEBHOOK_URL=https://n8n.yourdomain.com
    volumes: [n8n_data:/home/node/.n8n]
  postgres:
    image: postgres:16
    environment:
      - POSTGRES_DB=n8n
      - POSTGRES_PASSWORD=${DB_PASSWORD}
```

### ❌ ERRADO / ✅ CORRETO

❌ Deploy sem HTTPS → webhooks expostos
✅ Reverse proxy com SSL/TLS (nginx/caddy)

---

## 14. Community Nodes

### Exemplo: Criar Community Node

```typescript
import { INodeType, INodeTypeDescription } from 'n8n-workflow';

export class MyCustomNode implements INodeType {
  description: INodeTypeDescription = {
    displayName: 'My Custom Node', name: 'myCustomNode',
    group: ['transform'], version: 1,
    inputs: ['main'], outputs: ['main'],
    credentials: [{ name: 'myApi', required: true }],
    properties: [{ displayName: 'Operation', name: 'operation', type: 'options',
      options: [{ name: 'Create' }, { name: 'Read' }], default: 'read' }]
  };
}
```

### ❌ ERRADO / ✅ CORRETO

❌ Não documentar community nodes → outros devs não sabem usar
✅ Incluir README com exemplos de uso e parâmetros

---

## 15. Debugging e Logs

### Exemplo: Estratégias de Debug

```javascript
// Nó Code para logging detalhado
const debugInfo = {
  timestamp: new Date().toISOString(),
  workflowId: $workflow.id,
  executionId: $execution.id,
  nodeName: $node.name,
  input: $input.all(),
  env: { NODE_ENV: $env.NODE_ENV }
};
console.log('DEBUG:', JSON.stringify(debugInfo, null, 2));
```

### ❌ ERRADO / ✅ CORRETO

❌ Só usar console.log sem contexto
✅ Log estruturado com timestamp, workflow, node e dados relevantes

---

> **Total de habilidades documentadas:** 15 categorias com exemplos práticos e comparações ERRADO/CORRETO
