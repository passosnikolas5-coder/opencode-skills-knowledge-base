# 🤖 COZE — Plataforma de Criação de Bots AI

> **Fonte:** https://github.com/coze-dev/coze-js (8k+ stars)
> **Descrição:** Coze é a plataforma da ByteDance para construção de bots AI com visual workflow builder, knowledge base, plugins, memória e publicação multi-plataforma.

---

## 📋 Índice de Habilidades

1. [Criação de Bots](#1)
2. [Workflow Builder Visual](#2)
3. [Knowledge Base](#3)
4. [Sistema de Plugins](#4)
5. [Memória (Varieties, Session, Database)](#5)
6. [Publicação Multi-plataforma](#6)
7. [Variáveis e Slots](#7)
8. [Sistema de Triggers](#8)
9. [Integração com APIs](#9)
10. [Teste e Debugging](#10)
11. [Dashboard de Analytics](#11)
12. [Colaboração em Equipe](#12)
13. [Coze Studio (Open Source)](#13)
14. [Gerenciamento de Persona](#14)
15. [Segurança e Permissões](#15)

---

## 1. Criação de Bots

### Exemplo: Configuração de Bot com Persona

```javascript
const botConfig = {
  name: "Assistente de Vendas",
  description: "Bot especializado em auxiliar clientes durante o processo de compra",
  persona: {
    name: "Maria",
    role: "Consultora de Vendas",
    personality: "Amigável, profissional, persuasiva",
    tone: "Formal mas acolhedor",
    language: "pt-BR",
    avatar: "https://example.com/avatar.png"
  },
  instructions: `Você é Maria, consultora de vendas da Empresa X.
Regras:
1. Sempre cumprimente o cliente pelo nome
2. Apresente no máximo 3 produtos relevantes
3. Nunca invente informações sobre preços
4. Para objeções complexas, transfira para humano
5. Finalize sempre com uma pergunta aberta`,
  model: {
    provider: "doubao",
    name: "doubao-pro-32k",
    temperature: 0.7,
    maxTokens: 4096
  },
  capabilities: {
    canAccessWeb: true,
    canGenerateImages: false,
    canUseCodeInterpreter: true
  }
};
```

### Exemplo: Bot com Múltiplas Competências

```javascript
const multiSkillBot = {
  name: "Suporte Técnico Inteligente",
  skills: [
    { name: "FAQ", type: "knowledge_base", kbId: "kb_123" },
    { name: "Pesquisa Web", type: "web_search", enabled: true },
    { name: "Análise de Código", type: "code_interpreter", languages: ["python", "javascript"] },
    { name: "Geração de Imagens", type: "image_gen", model: "dall-e-3" }
  ],
  fallback: {
    action: "transfer_to_human",
    message: "Vou conectar você com um especialista."
  }
};
```

### ❌ ERRADO / ✅ CORRETO

❌ Bot sem persona definida → respostas genéricas e inconsistentes
✅ Persona detalhada com nome, tom, regras e limites claros

❌ Não definir limite de tokens → respostas infinitas
✅ Configurar `maxTokens` e `maxTurns` apropriados

---

## 2. Workflow Builder Visual

### Exemplo: Workflow de Processamento de Pedido

```javascript
const orderWorkflow = {
  name: "Processar Pedido",
  trigger: { type: "webhook", path: "/order/new" },
  nodes: [
    {
      id: "validate",
      type: "condition",
      config: { field: "{{input.orderId}}", operator: "exists" },
      trueBranch: "check_inventory",
      falseBranch: "error_handler"
    },
    {
      id: "check_inventory",
      type: "api_call",
      config: {
        method: "GET",
        url: "https://api.store.com/inventory/{{input.productId}}",
        headers: { "Authorization": "Bearer {{env.API_KEY}}" }
      },
      next: "process_payment"
    },
    {
      id: "process_payment",
      type: "api_call",
      config: {
        method: "POST",
        url: "https://api.payments.com/charge",
        body: { amount: "{{input.total}}", currency: "BRL" }
      },
      next: "send_confirmation"
    },
    {
      id: "send_confirmation",
      type: "code",
      config: {
        code: `
          const result = $input.first().json;
          return {
            status: "success",
            orderId: result.orderId,
            message: "Pedido confirmado!"
          };
        `
      }
    },
    {
      id: "error_handler",
      type: "response",
      config: { status: 400, body: { error: "Pedido inválido" } }
    }
  ]
};
```

### Exemplo: Workflow com Loop e Paralelismo

```javascript
const parallelWorkflow = {
  nodes: [
    {
      id: "fetch_data",
      type: "api_call",
      config: { url: "https://api.example.com/items" },
      next: "parallel_process"
    },
    {
      id: "parallel_process",
      type: "parallel",
      branches: [
        { name: "analyze_sentiment", nodes: [{ type: "llm_call", prompt: "Analise o sentimento" }] },
        { name: "extract_keywords", nodes: [{ type: "llm_call", prompt: "Extraia palavras-chave" }] },
        { name: "translate", nodes: [{ type: "llm_call", prompt: "Traduza para inglês" }] }
      ],
      next: "merge_results"
    },
    {
      id: "merge_results",
      type: "code",
      config: {
        code: `
          const [sentiment, keywords, translation] = $input.all();
          return { sentiment: sentiment.json, keywords: keywords.json, translation: translation.json };
        `
      }
    }
  ]
};
```

### ❌ ERRADO / ✅ CORRETO

❌ Workflow sem tratamento de erros em chamadas API
✅ Sempre adicionar error handler e fallback

❌ Nós paralelos sem merge strategy definida
✅ Usar nó de merge com estratégia clara (all, any, first)

---

## 3. Knowledge Base

### Exemplo: Configuração de Knowledge Base

```javascript
const knowledgeBaseConfig = {
  name: "Base de Conhecimento - FAQ",
  description: "Documentos oficiais da empresa",
  sources: [
    {
      type: "document",
      name: "Manual do Produto",
      format: "pdf",
      url: "https://docs.example.com/manual.pdf",
      metadata: { department: "produto", version: "2.1" }
    },
    {
      type: "url",
      name: "FAQ Site",
      url: "https://example.com/faq",
      scrapeConfig: { maxPages: 100, followLinks: true }
    },
    {
      type: "text",
      name: "Política de Garantia",
      content: "Garantia de 12 meses para todos os produtos..."
    }
  ],
  indexing: {
    method: "hybrid", // hybrid, semantic, keyword
    chunkSize: 512,
    chunkOverlap: 50,
    embedding: "doubao-embedding"
  },
  retrieval: {
    topK: 5,
    scoreThreshold: 0.7,
    reranking: true,
    rerankingModel: "doubao-rerank"
  },
  update: {
    schedule: "0 2 * * *", // diário às 2h
    autoSync: true
  }
};
```

### Exemplo: Consulta com Filtros

```javascript
async function queryKnowledgeBase(question, filters = {}) {
  const results = await coze.knowledge.search({
    kbId: "kb_123",
    query: question,
    topK: 5,
    filter: {
      metadata: {
        department: filters.department || { $exists: true },
        version: { $gte: "2.0" }
      }
    },
    reranking: { enabled: true, model: "doubao-rerank" }
  });

  return results.items.map(item => ({
    content: item.content,
    score: item.score,
    source: item.metadata.source,
    title: item.metadata.title
  }));
}
```

### ❌ ERRADO / ✅ CORRETO

❌ Knowledge base sem chunking adequado → respostas incompletas
✅ Chunking de 512 chars com 50 overlap + reranking

❌ Não atualizar documentos desatualizados
✅ Auto-sync com agendamento e versionamento

---

## 4. Sistema de Plugins

### Exemplo: Criar Plugin Personalizado

```javascript
const customPlugin = {
  name: "Calculadora Financeira",
  description: "Realiza cálculos financeiros complexos",
  version: "1.0.0",
  author: "equipe-dev",
  tools: [
    {
      name: "calcular_juros_compostos",
      description: "Calcula juros compostos",
      parameters: {
        principal: { type: "number", description: "Valor principal" },
        taxa: { type: "number", description: "Taxa mensal (%)" },
        meses: { type: "integer", description: "Período em meses" }
      },
      handler: async (params) => {
        const { principal, taxa, meses } = params;
        const montante = principal * Math.pow(1 + taxa / 100, meses);
        const juros = montante - principal;
        return {
          montante: montante.toFixed(2),
          juros: juros.toFixed(2),
          periodo: meses
        };
      }
    },
    {
      name: "calcular_parcela",
      description: "Calcula parcela de financiamento Price",
      parameters: {
        valor: { type: "number" },
        taxa: { type: "number" },
        parcelas: { type: "integer" }
      },
      handler: async (params) => {
        const { valor, taxa, parcelas } = params;
        const t = taxa / 100;
        const parcela = valor * (t * Math.pow(1 + t, parcelas)) / (Math.pow(1 + t, parcelas) - 1);
        return { parcela: parcela.toFixed(2), total: (parcela * parcelas).toFixed(2) };
      }
    }
  ]
};
```

### Exemplo: Uso de Plugins em Bot

```javascript
const botWithPlugins = {
  name: "Consultor Financeiro",
  plugins: [
    { id: "calculadora_financeira", version: "1.0.0" },
    { id: "cotacoes_moedas", version: "2.1.0" },
    { id: "noticias_financeiras", version: "1.3.0" }
  ],
  pluginConfig: {
    calculadora_financeira: {
      enabledTools: ["calcular_juros_compostos", "calcular_parcela"]
    }
  }
};
```

### ❌ ERRADO / ✅ CORRETO

❌ Plugin sem validação de parâmetros
✅ Validação rigorosa: tipo, range, obrigatoriedade

❌ Handler sem tratamento de erros
✅ Try/catch com mensagem amigável ao usuário

---

## 5. Memória (Varieties, Session, Database)

### Exemplo: Configuração de Memória

```javascript
const memoryConfig = {
  varieties: {
    // Memória de longo prazo - persiste entre sessões
    longTerm: {
      type: "database",
      database: { type: "postgresql", connection: "{{env.DB_URL}}" },
      schema: {
        userId: "string",
        key: "string",
        value: "jsonb",
        expiresAt: "timestamp"
      }
    },
    // Memória de sessão - persiste durante a sessão
    session: {
      type: "redis",
      connection: "{{env.REDIS_URL}}",
      ttl: 3600 // 1 hora
    },
    // Memória de vetor - busca semântica
    semantic: {
      type: "vector",
      embedding: "doubao-embedding",
      dimension: 1536,
      similarity: "cosine"
    }
  },
  strategies: [
    {
      trigger: "user_preferences",
      action: "save",
      varieties: ["longTerm"],
      ttl: 86400 * 30 // 30 dias
    },
    {
      trigger: "conversation_context",
      action: "save",
      varieties: ["session", "semantic"],
      ttl: 3600
    },
    {
      trigger: "important_facts",
      action: "extract_and_save",
      varieties: ["longTerm", "semantic"],
      extractionPrompt: "Extraia fatos importantes sobre o usuário"
    }
  ]
};
```

### Exemplo: Recuperação de Memória

```javascript
async function retrieveMemory(userId, query, context) {
  // Busca semântica
  const semanticResults = await memory.semantic.search({
    query, topK: 5, filter: { userId }
  });

  // Busca por chave
  const preferences = await memory.longTerm.get({
    userId, key: "preferences"
  });

  // Contexto da sessão atual
  const sessionContext = await memory.session.get({
    sessionId: context.sessionId, keys: ["lastTopic", "sentiment"]
  });

  return {
    relevantFacts: semanticResults.map(r => r.content),
    preferences: preferences?.value || {},
    sessionContext
  };
}
```

### ❌ ERRADO / ✅ CORRETO

❌ Armazenar dados sensíveis sem criptografia
✅ Criptografar dados PII e usar masking em logs

❌ Memória sem expiração → acumulação infinita
✅ TTL adequado: sessão=1h, preferências=30d, fatos=90d

---

## 6. Publicação Multi-plataforma

### Exemplo: Configuração de Canais

```javascript
const publishConfig = {
  channels: [
    {
      platform: "web",
      config: {
        embedCode: '<script src="https://api.coze.com/widget.js" data-bot-id="bot_123"></script>',
        customDomain: "chat.empresa.com.br",
        theme: { primaryColor: "#0066FF", fontFamily: "Inter" }
      }
    },
    {
      platform: "discord",
      config: {
        token: "{{env.DISCORD_BOT_TOKEN}}",
        guildId: "123456789",
        channels: ["suporte", "vendas"],
        intents: ["GUILDS", "GUILD_MESSAGES"]
      }
    },
    {
      platform: "telegram",
      config: {
        token: "{{env.TELEGRAM_BOT_TOKEN}}",
        webhookUrl: "https://api.coze.com/webhook/telegram/bot_123",
        commands: ["/start", "/help", "/status"]
      }
    },
    {
      platform: "slack",
      config: {
        token: "{{env.SLACK_BOT_TOKEN}}",
        appToken: "{{env.SLACK_APP_TOKEN}}",
        socketMode: true,
        channels: ["#suporte"]
      }
    }
  ],
  messageTemplates: {
    welcome: {
      web: "Olá! Como posso ajudar você hoje?",
      discord: "**Olá!** Como posso ajudar? 🎯",
      telegram: "Olá! Como posso ajudar?",
      slack: "Olá! Como posso ajudar? :wave:"
    }
  }
};
```

### ❌ ERRADO / ✅ CORRETO

❌ Tokens hardcoded nos arquivos de configuração
✅ Usar variáveis de ambiente: `{{env.PLATFORM_TOKEN}}`

❌ Não adaptar mensagens por plataforma
✅ Templates específicos para cada canal (emojis, formatação)

---

## 7. Variáveis e Slots

### Exemplo: Sistema de Slots para Extração de Informação

```javascript
const bookingSlots = {
  name: "reservation_system",
  slots: [
    { name: "destination", type: "string", required: true, prompt: "Qual é o destino?" },
    { name: "checkIn", type: "date", required: true, prompt: "Qual a data de check-in?" },
    { name: "checkOut", type: "date", required: true, prompt: "Qual a data de check-out?" },
    { name: "guests", type: "integer", required: true, default: 2, prompt: "Quantos hóspedes?" },
    { name: "roomType", type: "enum", values: ["standard", "deluxe", "suite"], required: false },
    { name: "specialRequests", type: "string", required: false }
  ],
  confirmationTemplate: `
    Reserva confirmada!
    Destino: {{slots.destination}}
    Check-in: {{slots.checkIn}}
    Check-out: {{slots.checkOut}}
    Hóspedes: {{slots.guests}}
    Quarto: {{slots.roomType}}
  `
};
```

### Exemplo: Variáveis de Sistema

```javascript
const systemVariables = {
  // Variáveis de contexto
  user_id: "{{context.userId}}",
  session_id: "{{context.sessionId}}",
  platform: "{{context.platform}}",
  timestamp: "{{context.timestamp}}",

  // Variáveis de ambiente
  api_key: "{{env.COZE_API_KEY}}",
  webhook_url: "{{env.WEBHOOK_URL}}",

  // Variáveis calculadas
  message_count: "{{session.messageCount}}",
  sentiment_score: "{{session.lastSentiment}}",
  user_tier: "{{user.subscriptionTier}}"
};
```

### ❌ ERRADO / ✅ CORRETO

❌ Slots sem validação → dados inconsistentes
✅ Validação de tipo, obrigatoriedade e regex

❌ Variáveis sem escaping → injeção de template
✅ Usar escape em inputs do usuário antes de interpolar

---

## 8. Sistema de Triggers

### Exemplo: Triggers Personalizados

```javascript
const triggerConfig = {
  triggers: [
    {
      name: "welcome_new_user",
      type: "event",
      event: "user.first_message",
      condition: { userMessageCount: { $eq: 1 } },
      action: {
        type: "send_message",
        message: "Bem-vindo! Sou seu assistente virtual. Como posso ajudar?"
      }
    },
    {
      name: "frustration_detected",
      type: "condition",
      condition: {
        sentiment: { $lt: -0.5 },
        consecutiveNegatives: { $gte: 3 }
      },
      action: {
        type: "escalate",
        target: "human_agent",
        message: "Cliente demonstrou frustração. Transfira para atendente humano."
      }
    },
    {
      name: "daily_summary",
      type: "schedule",
      cron: "0 18 * * *",
      action: {
        type: "webhook",
        url: "{{env.SUMMARY_WEBHOOK_URL}}",
        payload: { date: "{{now}}", stats: "{{session.stats}}" }
      }
    }
  ]
};
```

### Exemplo: Triggers baseados em Comportamento

```javascript
const behaviorTriggers = {
  rules: [
    {
      name: "idle_timeout",
      condition: { idleTime: { $gt: 300 } }, // 5 minutos
      action: { type: "send_message", message: "Ainda está aí? Posso ajudar?" }
    },
    {
      name: "long_conversation",
      condition: { messageCount: { $gt: 20 } },
      action: { type: "send_message", message: "Nossa conversa está longa! Quer que eu resuma?" }
    },
    {
      name: "repeat_question",
      condition: { repeatedQueries: { $gte: 2 } },
      action: { type: "escalate", target: "human_agent" }
    }
  ]
};
```

### ❌ ERRADO / ✅ CORRETO

❌ Triggers sem condição clara → disparos indevidos
✅ Condições específicas com thresholds testados

❌ Não ter fallback para triggers que falham
✅ Sempre incluir error handling e retry

---

## 9. Integração com APIs

### Exemplo: Configuração de API Gateway

```javascript
const apiConfig = {
  endpoints: [
    {
      path: "/api/v1/chat",
      method: "POST",
      handler: "chatHandler",
      auth: { type: "bearer", tokenEnv: "API_TOKEN" },
      rateLimit: { requests: 100, window: 60 },
      cors: { origins: ["https://app.example.com"] }
    },
    {
      path: "/api/v1/bot/:botId/config",
      method: "GET",
      handler: "getBotConfig",
      auth: { type: "api_key", header: "X-API-Key" },
      cache: { ttl: 300 }
    }
  ],
  webhook: {
    endpoints: [
      {
        url: "https://api.coze.com/webhook/bot_123",
        events: ["message.received", "conversation.ended"],
        secret: "{{env.WEBHOOK_SECRET}}",
        retryPolicy: { maxRetries: 3, backoff: "exponential" }
      }
    ]
  }
};
```

### Exemplo: Uso do SDK

```javascript
const { CozeClient } = require('coze-js');

const client = new CozeClient({
  token: process.env.COZE_API_TOKEN,
  baseURL: 'https://api.coze.com'
});

// Criar conversa
async function startConversation(userId) {
  const conversation = await client.conversations.create({
    bot_id: 'bot_123',
    user_id: userId,
    stream: true
  });

  // Enviar mensagem com streaming
  const stream = await client.chat.create({
    conversation_id: conversation.id,
    bot_id: 'bot_123',
    user_id: userId,
    auto_save_history: true,
    additional_messages: [{ role: 'user', content: 'Olá!' }]
  });

  for await (const event of stream) {
    if (event.event === 'conversation.message.completed') {
      console.log('Resposta:', event.message.content);
    }
  }
}
```

### ❌ ERRADO / ✅ CORRETO

❌ API sem rate limiting → possível abuso
✅ Rate limiting configurado por endpoint

❌ Webhooks sem verificação de assinatura
✅ Validar HMAC signature em cada webhook recebido

---

## 10. Teste e Debugging

### Exemplo: Suite de Testes para Bot

```javascript
const testSuite = {
  name: "Testes do Bot de Vendas",
  tests: [
    {
      name: "Saudação inicial",
      input: "Olá",
      expected: { contains: ["Olá", "ajudar"] },
      tags: ["saudacao"]
    },
    {
      name: "Consulta de produto",
      input: "Qual o preço do iPhone 15?",
      expected: { contains: ["iPhone", "preço"], notContains: ["não sei"] },
      tags: ["produto", "preco"]
    },
    {
      name: "Transferência para humano",
      input: "Quero cancelar meu pedido e pedir reembolso imediato",
      expected: { action: "transfer_to_human" },
      tags: ["escalação"]
    }
  ],
  assertions: {
    maxResponseTime: 5000,
    requiredFields: ["content", "confidence"],
    bannedPatterns: ["não posso ajudar", "não sei"]
  }
};

// Executar testes
async function runTests(botId) {
  const results = [];
  for (const test of testSuite.tests) {
    const response = await bot.chat({ message: test.input, userId: "test_user" });
    const passed = validateResponse(response, test.expected);
    results.push({ test: test.name, passed, response: response.content });
  }
  return results;
}
```

### ❌ ERRADO / ✅ CORRETO

❌ Testar só o caso feliz
✅ Testar edge cases: inputs vazios, mensagens longas, erros de API

❌ Não monitorar performance em produção
✅ Métricas: tempo de resposta, taxa de sucesso, satisfação do usuário

---

## 11. Dashboard de Analytics

### Exemplo: Métricas Importantes

```javascript
const analyticsConfig = {
  metrics: {
    engagement: {
      totalConversations: { type: "count", period: "daily" },
      activeUsers: { type: "unique_count", field: "userId", period: "daily" },
      avgMessagesPerConversation: { type: "avg", field: "messageCount" },
      retentionRate: { type: "percentage", period: "weekly" }
    },
    performance: {
      avgResponseTime: { type: "avg", field: "responseTimeMs" },
      p95ResponseTime: { type: "percentile", field: "responseTimeMs", percentile: 95 },
      errorRate: { type: "percentage", condition: "status === 'error'" },
      tokenUsage: { type: "sum", field: "tokensUsed", period: "daily" }
    },
    satisfaction: {
      csatScore: { type: "avg", field: "userRating", min: 1, max: 5 },
      escalationRate: { type: "percentage", condition: "action === 'escalate'" },
      resolutionRate: { type: "percentage", condition: "resolved === true" }
    }
  },
  dashboards: [
    {
      name: "Visão Geral",
      widgets: ["totalConversations", "avgResponseTime", "csatScore", "errorRate"]
    },
    {
      name: "Performance Detalhada",
      widgets: ["p95ResponseTime", "tokenUsage", "resolutionRate"]
    }
  ]
};
```

### ❌ ERRADO / ✅ CORRETO

❌ Sem dashboard → não consegue acompanhar performance
✅ Dashboard com métricas de engajamento, performance e satisfação

❌ Métricas sem contexto temporal
✅ Sempre comparar com período anterior e definir baselines

---

## 12. Colaboração em Equipe

### Exemplo: Configuração de Permissões

```javascript
const teamConfig = {
  organization: "empresa-x",
  roles: [
    {
      name: "admin",
      permissions: ["*"], // acesso total
      members: ["admin@empresa.com"]
    },
    {
      name: "developer",
      permissions: ["bot.create", "bot.edit", "bot.deploy", "analytics.view"],
      members: ["dev1@empresa.com", "dev2@empresa.com"]
    },
    {
      name: "content_manager",
      permissions: ["knowledge_base.edit", "bot.edit_persona", "analytics.view"],
      members: ["content@empresa.com"]
    },
    {
      name: "viewer",
      permissions: ["bot.view", "analytics.view"],
      members: ["stakeholder@empresa.com"]
    }
  ],
  workflows: {
    approvalRequired: ["bot.deploy", "knowledge_base.delete"],
    reviewers: ["admin"]
  }
};
```

### ❌ ERRADO / ✅ CORRETO

❌ Todos com acesso de admin → risco de segurança
✅ Princípio do menor privilégio: cada função só tem acesso necessário

❌ Sem audit trail
✅ Log de todas as ações: quem, quando, o que mudou

---

## 13. Coze Studio (Open Source)

### Exemplo: Setup do Coze Studio

```bash
# Clonar repositório
git clone https://github.com/coze-dev/coze-js.git
cd coze-js

# Instalar dependências
npm install

# Configurar ambiente
cp .env.example .env
# Editar .env com suas credenciais

# Iniciar em desenvolvimento
npm run dev

# Build para produção
npm run build
```

### Exemplo: Estrutura do Projeto

```typescript
// Estrutura do coze-js SDK
const sdkStructure = {
  "packages": {
    "coze-js": "SDK principal para Node.js",
    "coze-react": "Componentes React para embedding",
    "coze-api": "Cliente API TypeScript",
    "coze-cli": "CLI para gerenciamento de bots"
  },
  "features": {
    "streaming": "Suporte a streaming de respostas",
    "pagination": " paginação automática",
    "retry": "Retry com backoff exponencial",
    "webhooks": "Handler para webhooks"
  }
};
```

### ❌ ERRADO / ✅ CORRETO

❌ Não atualizar SDK frequentemente
✅ Usar última versão estável e verificar changelogs

❌ Não testar em staging antes de produção
✅ Pipeline: dev → staging → canary → produção

---

## 14. Gerenciamento de Persona

### Exemplo: Persona Dinâmica

```javascript
const dynamicPersona = {
  base: {
    name: "Assistente",
    language: "pt-BR",
    tone: "profissional"
  },
  adaptations: [
    {
      condition: { userMood: "frustrated" },
      adjustments: { tone: "empático", patience: "alta", escalateThreshold: 1 }
    },
    {
      condition: { userMood: "excited" },
      adjustments: { tone: "entusiasmado", pace: "rápido" }
    },
    {
      condition: { context: "technical_support" },
      adjustments: {
        vocabulary: "técnico",
        includeCodeExamples: true,
        detailLevel: "alto"
      }
    }
  ]
};
```

### Exemplo: Persona por Segmento

```javascript
const segmentPersonas = {
  vip: {
    name: "Consultor VIP",
    tone: "premium",
    greeting: "Bem-vindo de volta! Que bom ter você novamente.",
    prioritize: true,
    maxWaitTime: 10
  },
  new_user: {
    name: "Guia de Boas-vindas",
    tone: "acolhedor",
    greeting: "Olá! Seja bem-vindo! Vou te ajudar a começar.",
    includeTutorial: true
  },
  enterprise: {
    name: "Consultor Empresarial",
    tone: "formal",
    sla: { responseTime: 30, resolutionTime: 240 }
  }
};
```

### ❌ ERRADO / ✅ CORRETO

❌ Persona estática para todos os contextos
✅ Persona adaptativa baseada no humor e contexto do usuário

❌ Não definir limites de persona → respostas inadequadas
✅ Sempre ter guardrails: não prometer, não inventar, não discutir política

---

## 15. Segurança e Permissões

### Exemplo: Configuração de Segurança

```javascript
const securityConfig = {
  authentication: {
    method: "oauth2",
    providers: ["google", "microsoft"],
    mfa: { enabled: true, methods: ["totp", "sms"] }
  },
  authorization: {
    rbac: {
      enabled: true,
      defaultRole: "viewer",
      customRoles: {
        "bot_admin": { permissions: ["bot:*", "kb:*"] },
        "bot_viewer": { permissions: ["bot:read", "kb:read"] }
      }
    }
  },
  dataProtection: {
    encryption: { atRest: "AES-256", inTransit: "TLS-1.3" },
    pii: { maskInLogs: true, retentionDays: 90 },
    audit: { enabled: true, retentionDays: 365 }
  },
  rateLimiting: {
    global: { requests: 1000, window: 60 },
    perUser: { requests: 100, window: 60 },
    perBot: { requests: 500, window: 60 }
  }
};
```

### ❌ ERRADO / ✅ CORRETO

❌ Sem autenticação em endpoints de administração
✅ OAuth2 + MFA para acesso administrativo

❌ Logs com dados sensíveis expostos
✅ PII masking em todos os logs e métricas

---

> **Total de habilidades documentadas:** 15 categorias com exemplos práticos e comparações ERRADO/CORRETO
