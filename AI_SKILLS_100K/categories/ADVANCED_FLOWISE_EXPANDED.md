# 🌊 Flowise — Construtor Visual de Flows LLM

**Fonte:** https://github.com/FlowiseAI/Flowise (40k+ estrelas)  
**Descrição:** Flowise é uma ferramenta open-source de drag & drop para construir fluxos de LLM. Oferece interface visual intuitiva para encadear modelos de linguagem, agentes, memória, vector stores e ferramentas de forma modular.

---

## 1. Construtor Visual de Flows

Interface drag & drop para criar pipelines de IA sem escrever código.

```javascript
// Exemplo de flow JSON (formato interno do Flowise)
const flowConfig = {
  nodes: [
    {
      id: "start",
      type: "custom",
      position: { x: 100, y: 200 },
      data: {
        type: "startNode",
        label: "Início",
        inputs: {
          userMessage: "string"
        }
      }
    },
    {
      id: "llm",
      type: "custom",
      position: { x: 400, y: 200 },
      data: {
        type: "chatOpenAI",
        label: "GPT-4",
        inputs: {
          model: "gpt-4",
          temperature: 0.7,
          maxTokens: 2000,
          systemMessage: "Você é um assistente útil."
        }
      }
    },
    {
      id: "output",
      type: "custom",
      position: { x: 700, y: 200 },
      data: {
        type: "outputNode",
        label: "Resposta"
      }
    }
  ],
  edges: [
    { source: "start", target: "llm", sourceHandle: "output", targetHandle: "input" },
    { source: "llm", target: "output", sourceHandle: "output", targetHandle: "input" }
  ]
};
```

### MELHORIA

❌ **ERRADO:** Criar flows lineares sem branches
```javascript
// Fluxo limitado - sem tratamento condicional
const flowRuim = {
  nodes: [
    { id: "1", type: "chatOpenAI" },
    { id: "2", type: "output" }
  ],
  edges: [
    { source: "1", target: "2" }
  ]
};
// Não permite lógica condicional
```

✅ **CORRETO:** Usar conditional routing e branches
```javascript
const flowCompleto = {
  nodes: [
    {
      id: "start",
      type: "startNode",
      data: { inputs: { message: "string" } }
    },
    {
      id: "classifier",
      type: "llmClassifier",
      data: {
        model: "gpt-3.5-turbo",
        categories: ["suporte", "vendas", "técnico"]
      }
    },
    {
      id: "suporte",
      type: "chatOpenAI",
      data: {
        systemMessage: "Você é do suporte ao cliente."
      }
    },
    {
      id: "vendas",
      type: "chatOpenAI",
      data: {
        systemMessage: "Você é um consultor de vendas."
      }
    },
    {
      id: "tecnico",
      type: "chatOpenAI",
      data: {
        systemMessage: "Você é um engenheiro técnico."
      }
    },
    {
      id: "output",
      type: "outputNode"
    }
  ],
  edges: [
    { source: "start", target: "classifier" },
    { source: "classifier", target: "suporte", sourceHandle: "suporte" },
    { source: "classifier", target: "vendas", sourceHandle: "vendas" },
    { source: "classifier", target: "tecnico", sourceHandle: "técnico" },
    { source: "suporte", target: "output" },
    { source: "vendas", target: "output" },
    { source: "tecnico", target: "output" }
  ]
};
```

---

## 2. Chatflow vs Agentflow

Dois tipos de fluxos para diferentes necessidades.

```javascript
// CHATFLOW - Conversas interativas com memória
const chatflowConfig = {
  type: "chatflow",
  name: "Atendente Virtual",
  
  // Nodes específicos para chatflow
  nodes: [
    {
      type: "chatMemory",
      data: {
        memoryType: "buffer",
        windowSize: 10,
        sessionTTL: 3600
      }
    },
    {
      type: "chatOpenAI",
      data: {
        model: "gpt-4",
        temperature: 0.7
      }
    }
  ]
};

// AGENTFLOW - Tarefas autônomas com tools
const agentflowConfig = {
  type: "agentflow",
  name: "Agente de Pesquisa",
  
  // Nodes específicos para agentflow
  nodes: [
    {
      type: "agentNode",
      data: {
        agentType: "openAIFunctions",
        model: "gpt-4",
        tools: ["web_search", "calculator"],
        maxIterations: 10,
        returnIntermediateSteps: true
      }
    },
    {
      type: "toolNode",
      data: {
        toolType: "requestsGet",
        name: "web_search",
        description: "Busca na web"
      }
    }
  ]
};
```

### MELHORIA

❌ **ERRADO:** Usar chatflow para tarefas autônomas
```javascript
// Chatflow não tem tools nativas
const flowIncorreto = {
  type: "chatflow",
  nodes: [
    { type: "chatOpenAI" },
    // Sem tool node disponível
  ]
};
```

✅ **CORRETO:** Escolher o tipo correto para cada caso
```javascript
// Chatflow para conversas com memória
const chatflow = {
  type: "chatflow",
  useCase: "Atendimento ao cliente",
  nodes: [
    { type: "chatMemory", data: { memoryType: "buffer" } },
    { type: "chatOpenAI" },
    { type: "outputNode" }
  ]
};

// Agentflow para tarefas com ferramentas
const agentflow = {
  type: "agentflow",
  useCase: "Pesquisa automatizada",
  nodes: [
    { type: "agentNode", data: { tools: ["web_search", "code_executor"] } },
    { type: "toolNode", data: { toolType: "webSearch" } },
    { type: "toolNode", data: { toolType: "codeExecution" } }
  ]
};
```

---

## 3. Sistema de Nodes — LLM, Chain, Agent, Tool, Memory

Componha flows usando nodes modulares.

```javascript
// NÓ LLM - Modelo de linguagem
const llmNode = {
  type: "chatOpenAI",
  data: {
    model: "gpt-4",
    temperature: 0.7,
    maxTokens: 2000,
    topP: 1,
    frequencyPenalty: 0,
    presencePenalty: 0,
    systemMessage: "Você é um assistente especializado em {{domain}}.",
    // Streaming
    streaming: true,
    // Callbacks
    callbacks: {
      onLLMStart: "log_start",
      onLLMEnd: "log_end",
      onLLMError: "log_error"
    }
  }
};

// NÓ CHAIN - Encadeamento de operações
const chainNode = {
  type: "conversationChain",
  data: {
    llm: "chatOpenAI",
    memory: "chatMemory",
    prompt: "Histórico:\n{history}\n\nHumano: {input}\nAssistente:",
    verbose: true
  }
};

// NÓ AGENT - Agente autônomo
const agentNode = {
  type: "openAIAgent",
  data: {
    model: "gpt-4",
    tools: ["web_search", "calculator", "wikipedia"],
    agentType: "zeroShotReactDescription",
    maxIterations: 5,
    returnIntermediateSteps: true,
    handleParsingErrors: true
  }
};

// NÓ TOOL - Ferramenta externa
const toolNode = {
  type: "requestsGet",
  data: {
    name: "api_call",
    description: "Chama API externa",
    url: "https://api.exemplo.com/{{endpoint}}",
    headers: {
      "Authorization": "Bearer {{api_key}}"
    },
    parameters: {
      endpoint: { type: "string", required: true }
    }
  }
};

// NÓ MEMORY - Memória de conversa
const memoryNode = {
  type: "bufferMemory",
  data: {
    memoryKey: "history",
    returnMessages: true,
    inputKey: "input",
    outputKey: "output",
    humanPrefix: "Humano",
    aiPrefix: "Assistente"
  }
};
```

### MELHORIA

❌ **ERRADO:** Não configurar memória nos chatflows
```javascript
// Conversa sem contexto - esquece tudo a cada mensagem
const flowSemMemoria = {
  nodes: [
    { type: "chatOpenAI", data: {} }
    // Sem memory node!
  ]
};
```

✅ **CORRETO:** Configurar memória adequadamente
```javascript
const flowComMemoria = {
  nodes: [
    {
      type: "bufferMemory",
      data: {
        memoryKey: "chat_history",
        returnMessages: true,
        // Limitar tokens da memória
        maxTokenLimit: 4000,
        // Resumir quando exceder
        autoSummarize: true,
        summarizationPrompt: "Resuma esta conversa em 3 pontos principais:"
      }
    },
    {
      type: "chatOpenAI",
      data: {
        model: "gpt-4",
        systemMessage: "Contexto: {chat_history}"
      }
    }
  ]
};
```

---

## 4. Chat Memory — Buffer, Summary e Window

Diferentes estratégias de memória para diferentes necessidades.

```javascript
// BUFFER MEMORY - Histórico completo
const bufferMemory = {
  type: "bufferMemory",
  data: {
    memoryKey: "history",
    returnMessages: true,
    humanPrefix: "Usuário",
    aiPrefix: "Assistente",
    // Limite de tokens
    maxTokenLimit: 4000
  }
};

// SUMMARY MEMORY - Resumo da conversa
const summaryMemory = {
  type: "summaryMemory",
  data: {
    memoryKey: "history",
    returnMessages: true,
    llm: "chatOpenAI",
    maxTokenLimit: 2000,
    // Prompt de resumo
    summaryPrompt: "Resuma a conversa anterior em 2-3 parágrafos concisos, mantendo informações importantes como nomes, decisões e pendências.",
    // Auto-resumir quando exceder
    autoSummarize: true,
    autoSummarizeThreshold: 3000
  }
};

// WINDOW MEMORY - Últimas N mensagens
const windowMemory = {
  type: "windowBufferMemory",
  data: {
    memoryKey: "history",
    returnMessages: true,
    windowSize: 10,  // Últimas 10 mensagens
    k: 10,
    // Incluir resumo do contexto anterior
    includeContextSummary: true,
    contextSummaryPrompt: "Resumo do contexto anterior:"
  }
};

// ENTITY MEMORY - Memória de entidades
const entityMemory = {
  type: "entityMemory",
  data: {
    memoryKey: "history",
    entitiesKey: "entities",
    llm: "chatOpenAI",
    // Extrair entidades automaticamente
    extractionPrompt: "Extraia entidades importantes (pessoas, empresas, datas, valores) desta conversa.",
    // Store de entidades
    entityStore: "inMemory",
    // Schema de entidades
    entitySchema: {
      name: "string",
      type: "string",
      attributes: "object",
      lastMentioned: "datetime"
    }
  }
};

// KNOWLEDGE GRAPH MEMORY - Grafo de conhecimento
const knowledgeGraphMemory = {
  type: "knowledgeGraphMemory",
  data: {
    memoryKey: "history",
    graph: {
      type: "inMemory",
      // Ou externo
      neo4j: {
        uri: "bolt://localhost:7687",
        auth: { user: "neo4j", password: "password" }
      }
    },
    // Extração de triples
    extractionPrompt: "Extraia triples (sujeito, predicate, objeto) desta conversa.",
    // Retrieval
    retrieval: {
      maxTriples: 50,
      includeRelationships: true
    }
  }
};
```

### MELHORIA

❌ **ERRADO:** Usar buffer memory para conversas longas
```javascript
// Custo cresce exponencialmente
const memoryRuim = {
  type: "bufferMemory",
  data: {
    maxTokenLimit: 999999  // Sem limite real
  }
};
// Tokens da memória → custo da API
```

✅ **CORRETO:** Escolher estratégia baseada no caso de uso
```javascript
// Para conversas curtas (< 20 turnos)
const paraConversasCurtas = {
  type: "bufferMemory",
  data: {
    maxTokenLimit: 2000,
    returnMessages: true
  }
};

// Para conversas longas / suporte
const paraConversasLongas = {
  type: "summaryMemory",
  data: {
    maxTokenLimit: 1000,
    autoSummarize: true,
    summaryPrompt: "Resuma mantendo: 1) Problema do cliente 2) Soluções tentadas 3) Próximos passos"
  }
};

// Para atendimento com contexto de cliente
const paraAtendimento = {
  type: "entityMemory",
  data: {
    entitySchema: {
      cliente: { nome: "string", empresa: "string", contrato: "string" },
      problema: { tipo: "string", urgencia: "string", historico: "array" }
    }
  }
};
```

---

## 5. Document Loaders — PDF, CSV, Web, Notion

Carregue documentos de diversas fontes para alimentar RAG.

```javascript
// LOADER PDF
const pdfLoader = {
  type: "pdfLoader",
  data: {
    filePath: "/docs/manual.pdf",
    // Opções de extração
    splitPages: true,
    // OCR para PDFs escaneados
    ocr: {
      enabled: true,
      language: "por",
      engine: "tesseract"
    },
    // Metadata
    metadata: {
      source: "manual",
      version: "2.1",
      lastUpdated: "2024-01-15"
    }
  }
};

// LOADER CSV
const csvLoader = {
  type: "csvLoader",
  data: {
    filePath: "/data/produtos.csv",
    // Configuração de parsing
    csvOptions: {
      delimiter: ",",
      columns: true,
      skipEmptyLines: true,
      encoding: "utf-8"
    },
    // Mapeamento de colunas
    columnMapping: {
      "nome": "product_name",
      "preço": "price",
      "descrição": "description"
    }
  }
};

// LOADER WEB
const webLoader = {
  type: "webLoader",
  data: {
    url: "https://docs.exemplo.com/api",
    // Configuração de scraping
    scraper: "cheerio",
    selector: ".content",
    // Headers
    headers: {
      "User-Agent": "FlowiseBot/1.0"
    },
    // Autenticação
    auth: {
      type: "basic",
      username: "${WEB_USER}",
      password: "${WEB_PASS}"
    },
    // Rate limiting
    rateLimit: {
      requests: 5,
      per: "second"
    }
  }
};

// LOADER NOTION
const notionLoader = {
  type: "notionLoader",
  data: {
    apiKey: "${NOTION_API_KEY}",
    databaseId: "xxxx-xxxx-xxxx",
    // Filtros
    filter: {
      property: "Status",
      select: { equals: "Publicado" }
    },
    // Campos específicos
    properties: ["Título", "Conteúdo", "Tags", "Autor"],
    // Paginação
    pageSize: 100
  }
};

// LOADER MARKDOWN
const markdownLoader = {
  type: "directoryLoader",
  data: {
    directoryPath: "/docs/",
    globPattern: "**/*.md",
    // Configuração de encoding
    encoding: "utf-8",
    // Recursive
    recursive: true,
    // Excluir padrões
    excludePatterns: ["**/node_modules/**", "**/.git/**"]
  }
};

// LOADER API
const apiLoader = {
  type: "apiLoader",
  data: {
    url: "https://api.exemplo.com/v1/articles",
    method: "GET",
    headers: {
      "Authorization": "Bearer ${API_TOKEN}"
    },
    // Paginação
    pagination: {
      type: "offset",
      limitParam: "per_page",
      offsetParam: "page",
      maxPages: 10
    },
    // Mapeamento de resposta
    responseMapping: {
      items: "data.articles",
      title: "title",
      content: "body",
      metadata: "created_at"
    }
  }
};
```

### MELHORIA

❌ **ERRADO:** Carregar documentos inteiros sem chunking
```javascript
// Documento grande → excede limite de tokens
const loaderRuim = {
  type: "pdfLoader",
  data: {
    filePath: "/docs/livro_completo_500pg.pdf"
    // Sem splitChunks configurado!
  }
};
```

✅ **CORRETO:** Configurar chunking inteligente
```javascript
const loaderOtimizado = {
  type: "pdfLoader",
  data: {
    filePath: "/docs/livro_completo_500pg.pdf",
    // Chunking por conteúdo
    splitStrategy: "recursiveCharacter",
    chunkSize: 1000,
    chunkOverlap: 200,
    separators: ["\n\n", "\n", ". ", " ", ""],
    
    // Metadata enriquecida
    metadata: {
      source: "livro",
      chunkIndex: "{{index}}",
      totalChunks: "{{total}}",
      pageStart: "{{pageStart}}",
      pageEnd: "{{pageEnd}}"
    },
    
    // Pré-processamento
    preprocessing: {
      removeHeaders: true,
      normalizeWhitespace: true,
      removeSpecialChars: false
    }
  }
};
```

---

## 6. Text Splitters — Recursive, Character, Token

Divida textos de forma otimizada para embeddings.

```javascript
// RECURSIVE CHARACTER SPLITTER
const recursiveSplitter = {
  type: "recursiveCharacterTextSplitter",
  data: {
    chunkSize: 1000,
    chunkOverlap: 200,
    separators: ["\n\n", "\n", ". ", " ", ""],
    lengthFunction: "characters"
  }
};

// CHARACTER SPLITTER
const characterSplitter = {
  type: "characterTextSplitter",
  data: {
    chunkSize: 500,
    chunkOverlap: 50,
    separator: "\n\n",
    keepSeparator: true
  }
};

// TOKEN SPLITTER (mais preciso para LLMs)
const tokenSplitter = {
  type: "tokenTextSplitter",
  data: {
    chunkSize: 200,  // Em tokens
    chunkOverlap: 20,
    encodingName: "cl100k_base",  // GPT-4 encoding
    model: "gpt-4"  // Auto-detecta encoding
  }
};

// MARKDOWN SPLITTER (preserva estrutura)
const markdownSplitter = {
  type: "markdownTextSplitter",
  data: {
    chunkSize: 1500,
    chunkOverlap: 100,
    // Preserva headers como metadata
    preserveHeaders: true,
    // Headers que criam novo chunk
    headerLevels: [1, 2, 3]
  }
};

// SEMANTIC CHUNKER (usa embeddings)
const semanticSplitter = {
  type: "semanticChunker",
  data: {
    embeddingModel: "text-embedding-3-small",
    // Threshold de similaridade
    similarityThreshold: 0.5,
    // Máximo de chunks
    maxChunkSize: 2000,
    minChunkSize: 100,
    // Buffer para contexto
    bufferPercentage: 0.1
  }
};
```

### MELHORIA

❌ **ERRADO:** Usar character splitter para tudo
```javascript
// Quebra palavras e perde contexto
const splitterRuim = {
  type: "characterTextSplitter",
  data: {
    chunkSize: 200,  // Muito pequeno
    separator: " "   // Quebra no meio de frases
  }
};
```

✅ **CORRETO:** Usar splitter apropriado para o tipo de conteúdo
```javascript
// Para documentação técnica
const paraDocumentacao = {
  type: "recursiveCharacterTextSplitter",
  data: {
    chunkSize: 1500,
    chunkOverlap: 200,
    separators: ["\n\n## ", "\n\n### ", "\n\n", "\n", ". ", " "]
  }
};

// Para código
const paraCodigo = {
  type: "recursiveCharacterTextSplitter",
  data: {
    chunkSize: 1000,
    chunkOverlap: 100,
    separators: ["\n\n", "\ndef ", "\nclass ", "\n\n#", "\n", " "]
  }
};

// Para artigos/livros
const paraArtigos = {
  type: "markdownTextSplitter",
  data: {
    chunkSize: 2000,
    chunkOverlap: 200,
    preserveHeaders: true,
    headerLevels: [1, 2, 3]
  }
};
```

---

## 7. Vector Stores — Pinecone, Qdrant, Chroma, Supabase

Armazene e recupere embeddings de forma eficiente.

```javascript
// PINECONE
const pineconeStore = {
  type: "pinecone",
  data: {
    apiKey: "${PINECONE_API_KEY}",
    environment: "us-east1-gcp",
    indexName: "documentos",
    namespace: "producao",
    // Configuração de busca
    search: {
      topK: 5,
      includeMetadata: true,
      includeValues: false,
      scoreThreshold: 0.7
    },
    // Upsert
    upsert: {
      batchSize: 100,
      concurrency: 5
    }
  }
};

// QDRANT
const qdrantStore = {
  type: "qdrant",
  data: {
    url: "http://localhost:6333",
    apiKey: "${QDRANT_API_KEY}",
    collectionName: "documentos",
    // Configuração da coleção
    collection: {
      vectors: {
        size: 1536,  // Dimensão do embedding
        distance: "Cosine"
      }
    },
    // Busca
    search: {
      limit: 5,
      scoreThreshold: 0.7,
      withPayload: true
    }
  }
};

// CHROMA (local)
const chromaStore = {
  type: "chroma",
  data: {
    collectionName: "documentos",
    // Local ou cloud
    persistDirectory: "./chroma_db",
    // Ou cloud
    // host: "http://localhost:8000",
    // Para cloud
    // host: "${CHROMA_CLOUD_URL}",
    // apiKey: "${CHROMA_API_KEY}",
    
    // Configuração de busca
    search: {
      nResults: 5,
      where: { source: "manual" },
      whereDocument: { $contains: "API" }
    }
  }
};

// SUPABASE (PostgreSQL + pgvector)
const supabaseStore = {
  type: "supabase",
  data: {
    supabaseUrl: "${SUPABASE_URL}",
    supabaseKey: "${SUPABASE_SERVICE_KEY}",
    tableName: "documents",
    // Schema da tabela
    columns: {
      id: "id",
      content: "content",
      embedding: "embedding",
      metadata: "metadata"
    },
    // Busca
    search: {
      matchCount: 5,
      matchThreshold: 0.7,
      // Filtros
      filters: {
        source: "manual",
        version: "2.0"
      }
    },
    // RLS (Row Level Security)
    rls: {
      enabled: true,
      policy: "authenticated"
    }
  }
};

// IN-MEMORY (para testes)
const inMemoryStore = {
  type: "inMemory",
  data: {
    collectionName: "test",
    // Persistência opcional
    persist: false
  }
};
```

### MELHORIA

❌ **ERRADO:** Usar in-memory em produção
```javascript
// Perde dados entre reinicializações
const storeRuim = {
  type: "inMemory",
  data: {}  // Dados voláteis
};
```

✅ **CORRETO:** Vector store persistente com configuração adequada
```javascript
const storeProducao = {
  type: "pinecone",
  data: {
    apiKey: process.env.PINECONE_API_KEY,
    environment: "us-east1-gcp",
    indexName: "producao",
    namespace: "v2",
    
    // Configuração de performance
    upsert: {
      batchSize: 100,
      concurrency: 10,
      retryAttempts: 3
    },
    
    // Configuração de busca otimizada
    search: {
      topK: 5,
      includeMetadata: true,
      scoreThreshold: 0.75,
      // Filtros dinâmicos
      dynamicFilters: true
    },
    
    // Monitoramento
    metrics: {
      enabled: true,
      logSearches: true,
      trackLatency: true
    }
  }
};
```

---

## 8. Embedding Models

Configure modelos de embedding para vetORIZAÇÃO de texto.

```javascript
// OPENAI EMBEDDINGS
const openaiEmbedding = {
  type: "openAIEmbedding",
  data: {
    model: "text-embedding-3-small",
    apiKey: "${OPENAI_API_KEY}",
    // Dimensões
    dimensions: 1536,
    // Batch size para processamento
    batchSize: 100,
    // Rate limiting
    rateLimit: {
      requestsPerMinute: 500
    }
  }
};

// HUGGING FACE EMBEDDINGS
const huggingfaceEmbedding = {
  type: "huggingFaceEmbedding",
  data: {
    model: "sentence-transformers/all-MiniLM-L6-v2",
    // Configuração local
    device: "cpu",  // ou "cuda" para GPU
    // Dimensões
    dimensions: 384,
    // Normalização
    normalize: true
  }
};

// OLLAMA EMBEDDINGS (local)
const ollamaEmbedding = {
  type: "ollamaEmbedding",
  data: {
    baseUrl: "http://localhost:11434",
    model: "nomic-embed-text",
    // Dimensões
    dimensions: 768
  }
};

// COHERE EMBEDDINGS
const cohereEmbedding = {
  type: "cohereEmbedding",
  data: {
    model: "embed-english-v3.0",
    apiKey: "${COHERE_API_KEY}",
    // Tipo de embedding
    inputType: "search_document",
    // Dimensões
    dimensions: 1024,
    // Truncation
    truncation: "END"
  }
};
```

---

## 9. Tools — API Calls, Web Scraping, Code Execution

Ferramentas para agentes interagirem com o mundo exterior.

```javascript
// TOOL: Requisição HTTP
const httpTool = {
  type: "requestsGet",
  data: {
    name: "buscar_produtos",
    description: "Busca produtos na API de e-commerce",
    url: "https://api.loja.com/v1/produtos",
    headers: {
      "Authorization": "Bearer ${LOJA_API_KEY}",
      "Content-Type": "application/json"
    },
    parameters: {
      query: { type: "string", description: "Termo de busca" },
      categoria: { type: "string", description: "Filtrar por categoria" },
      limite: { type: "integer", description: "Máximo de resultados", default: 10 }
    },
    responseTemplate: "Produtos encontrados: {{data.results}}"
  }
};

// TOOL: Web Scraping
const scraperTool = {
  type: "cheerioWebScraper",
  data: {
    name: "scrape_noticias",
    description: "Extrai notícias de um site",
    url: "https://exemplo.com/noticias",
    selector: "article.post",
    fields: {
      titulo: "h2.title a",
      resumo: "p.summary",
      data: "time[datetime]",
      link: "h2.title a[href]"
    },
    // Limite
    maxResults: 20,
    // Delay entre requests
    delay: 1000
  }
};

// TOOL: Code Execution
const codeTool = {
  type: "codeInterpreter",
  data: {
    name: "executar_codigo",
    description: "Executa código Python de forma segura",
    language: "python",
    // Sandbox
    sandbox: {
      enabled: true,
      timeout: 30,
      maxMemory: "512MB"
    },
    // Bibliotecas permitidas
    allowedLibraries: [
      "pandas", "numpy", "matplotlib",
      "requests", "json", "datetime"
    ],
    // Bloquear
    blockedOperations: [
      "os.system", "subprocess",
      "eval", "exec", "__import__"
    ]
  }
};

// TOOL: Calculator
const calculatorTool = {
  type: "calculator",
  data: {
    name: "calcular",
    description: "Realiza cálculos matemáticos"
  }
};

// TOOL: Wikipedia
const wikipediaTool = {
  type: "wikipedia",
  data: {
    name: "buscar_wikipedia",
    description: "Busca informações na Wikipedia",
    language: "pt",
    maxChars: 3000
  }
};

// TOOL: SQL Database
const sqlTool = {
  type: "sqlDatabase",
  data: {
    name: "consultar_banco",
    description: "Executa consultas SQL no banco de dados",
    database: {
      type: "postgresql",
      host: "${DB_HOST}",
      port: 5432,
      database: "${DB_NAME}",
      user: "${DB_USER}",
      password: "${DB_PASS}",
      ssl: true
    },
    // Segurança
    security: {
      readOnly: true,
      maxRows: 100,
      allowedTables: ["usuarios", "pedidos", "produtos"],
      blockedOperations: ["DROP", "DELETE", "TRUNCATE", "ALTER"]
    }
  }
};
```

### MELHORIA

❌ **ERRADO:** Tools sem validação de entrada
```javascript
// Permite injeção e abuso
const toolPerigosa = {
  type: "sqlDatabase",
  data: {
    name: "query_db",
    security: {
      readOnly: false,  // Pode escrever!
      allowedTables: [], // Sem restrição!
      blockedOperations: [] // Sem bloqueio!
    }
  }
};
```

✅ **CORRETO:** Tools com sandbox e validação robusta
```javascript
const toolSegura = {
  type: "sqlDatabase",
  data: {
    name: "query_db",
    security: {
      readOnly: true,
      maxRows: 50,
      allowedTables: ["produtos", "categorias"],
      blockedOperations: ["DROP", "DELETE", "UPDATE", "INSERT", "ALTER"],
      // Validação de query
      queryValidation: {
        maxJoins: 3,
        requireWhere: true,
        forbiddenPatterns: ["1=1", "OR true", "UNION"]
      },
      // Logging
      auditLog: true,
      logQueries: true
    }
  }
};

// HTTP Tool com validação
const toolHttpSegura = {
  type: "requestsGet",
  data: {
    name: "api_segura",
    security: {
      // Rate limiting
      rateLimit: {
        requests: 10,
        per: "minute"
      },
      // Allowlist de endpoints
      allowedEndpoints: [
        "https://api.exemplo.com/v1/produtos",
        "https://api.exemplo.com/v1/pedidos"
      ],
      // Timeout
      timeout: 10000,
      // Validação de resposta
      responseValidation: {
        maxSize: 1048576,  // 1MB
        allowedContentTypes: ["application/json"]
      }
    }
  }
};
```

---

## 10. Agent Types — OpenAI, ReAct, Plan & Execute

Diferentes arquiteturas de agentes para diferentes necessidades.

```javascript
// AGENT: OpenAI Functions (Recomendado)
const openaiAgent = {
  type: "openAIAgent",
  data: {
    model: "gpt-4",
    agentType: "openAIFunctions",
    tools: ["web_search", "calculator", "sql_query"],
    // Configurações
    maxIterations: 10,
    returnIntermediateSteps: true,
    handleParsingErrors: true,
    // Early stopping
    earlyStoppingMethod: "generate",
    // Prompt do agente
    systemMessage: """Você é um assistente analítico.
    
    Regras:
    - Use ferramentas sempre que possível
    - Justifique cada ação
    - Seja conciso nas respostas
    - Em caso de dúvida, pergunte ao usuário"""
  }
};

// AGENT: ReAct (Reasoning + Acting)
const reactAgent = {
  type: "reactAgent",
  data: {
    model: "gpt-4",
    tools: ["web_search", "calculator"],
    // Template ReAct
    reactTemplate: """
    Responda a pergunta do usuário seguindo o formato:
    
    Thought: [Seu raciocínio]
    Action: [Nome da ferramenta]
    Action Input: [Entrada para a ferramenta]
    Observation: [Resultado da ferramenta]
    ... (repetir Thought/Action até ter resposta final)
    Thought: [Raciocínio final]
    Final Answer: [Resposta final]
    
    Comece!
    
    Pergunta: {input}
    """,
    maxIterations: 5,
    verbose: true
  }
};

// AGENT: Plan & Execute
const planExecuteAgent = {
  type: "planAndExecuteAgent",
  data: {
    // Planner (planejador)
    planner: {
      model: "gpt-4",
      systemMessage: "Você planeja tarefas detalhadas para resolver problemas."
    },
    // Executor (executador)
    executor: {
      model: "gpt-3.5-turbo",
      tools: ["web_search", "code_executor"],
      maxIterations: 3
    },
    // Replanner (replanejador)
    replanner: {
      model: "gpt-4",
      maxRetries: 3
    },
    // Configuração geral
    maxSteps: 10,
    maxRetries: 2,
    verbose: true
  }
};

// AGENT: LangChain Agent
const langchainAgent = {
  type: "langchainAgent",
  data: {
    model: "chatOpenAI",
    agentType: "zeroShotReactDescription",
    tools: ["web_search", "calculator"],
    // Prompt customizado
    prefix: """Você é um assistente útil. Use as ferramentas disponíveis."""
    suffix: """Begin! Pergunta: {input}
    
    {agent_scratchpad}""",
    maxIterations: 5,
    returnIntermediateSteps: true
  }
};
```

### MELHORIA

❌ **ERRADO:** Agent sem limite de iterações
```javascript
// Pode entrar em loop infinito
const agentPerigoso = {
  type: "openAIAgent",
  data: {
    tools: ["search", "reason"],
    maxIterations: 999  // Perigoso!
  }
};
```

✅ **CORRETO:** Agent com limites e monitoramento
```javascript
const agentControlado = {
  type: "openAIAgent",
  data: {
    model: "gpt-4",
    tools: ["web_search", "calculator"],
    maxIterations: 10,  // Limite seguro
    timeout: 120,  // 2 minutos
    
    // Monitoramento
    logging: {
      enabled: true,
      logSteps: true,
      logToolCalls: true,
      logTokenUsage: true
    },
    
    // Tratamento de erros
    errorHandling: {
      maxRetries: 2,
      retryDelay: 1000,
      fallbackResponse: "Desculpe, não consegui processar sua solicitação."
    },
    
    // Guardrails
    guardrails: {
      blockedTopics: ["política", "religião"],
      contentFilter: true,
      maxTokensPerStep: 500
    }
  }
};
```

---

## 11. Human Handoff

Transferir conversa para um humano quando necessário.

```javascript
// HUMAN HANDOFF - Transferência para humano
const humanHandoff = {
  type: "humanHandoff",
  data: {
    // Condições para handoff
    conditions: [
      {
        type: "keyword",
        keywords: ["falar com humano", "atendente", "suporte humano"],
        priority: "high"
      },
      {
        type: "sentiment",
        threshold: -0.5,  // Sentimento negativo
        priority: "high"
      },
      {
        type: "error_count",
        maxErrors: 3,
        priority: "medium"
      },
      {
        type: "iterations",
        maxIterations: 10,
        priority: "low"
      }
    ],
    
    // Canais de handoff
    channels: [
      {
        type: "slack",
        webhook: "${SLACK_HANDOFF_WEBHOOK}",
        channel: "#suporte",
        message_template: "🔴 Handoff necessário!\n\n*Conversa:* {{conversation_id}}\n*Motivo:* {{reason}}\n*Última mensagem:* {{last_message}}"
      },
      {
        type: "email",
        to: "suporte@empresa.com",
        subject: "Handoff de chatbot - {{conversation_id}}"
      },
      {
        type: "webhook",
        url: "https://crm.empresa.com/api/handoff",
        method: "POST",
        headers: {
          "Authorization": "Bearer ${CRM_TOKEN}"
        },
        body: {
          conversation_id: "{{conversation_id}}",
          reason: "{{reason}}",
          history: "{{history}}",
          customer_info: "{{customer_info}}"
        }
      }
    ],
    
    // Mensagem para o usuário
    userMessage: "Estou transferindo sua conversa para um atendente humano. Aguarde um momento.",
    
    // Tempo máximo de espera
    timeout: 300,  // 5 minutos
    timeoutMessage: "Desculpe, todos os atendentes estão ocupados. Por favor, tente novamente mais tarde."
  }
};

// HUMAN INPUT NODE
const humanInput = {
  type: "humanInput",
  data: {
    // Modo de input
    mode: "webhook",  // ou "interface"
    
    // Webhook para receber input
    webhook: {
      url: "https://seu-app.com/api/human-input",
      method: "POST"
    },
    
    // Timeout
    timeout: 60,
    timeoutAction: "continue",  // ou "escalate"
    
    // Validação do input
    validation: {
      required: true,
      minLength: 1,
      maxLength: 500
    }
  }
};
```

### MELHORIA

❌ **ERRADO:** Não ter plano de fallback para handoff
```javascript
// Se ninguém estiver disponível, usuário fica perdido
const handoffRuim = {
  type: "humanHandoff",
  data: {
    channels: [],
    userMessage: "Aguardando atendente..."
    // Sem timeout, sem alternativa
  }
};
```

✅ **CORRETO:** Handoff com múltiplos canais e fallback
```javascript
const handoffCompleto = {
  type: "humanHandoff",
  data: {
    // Hierarquia de canais
    channels: [
      {
        type: "slack",
        priority: 1,
        timeout: 60,
        fallback: "email"
      },
      {
        type: "email",
        priority: 2,
        timeout: 300,
        fallback: "ticket"
      },
      {
        type: "ticket",
        priority: 3,
        sla: "24h",
        fallback: null
      }
    ],
    
    // Mensagens progressivas
    messages: {
      initial: "Estou transferindo para um atendente...",
      waiting: "Aguarde, um atendente estará disponível em breve.",
      timeout: "Estamos em horário de pico. Abrimos um ticket e retornaremos em até 24h.",
      unavailable: "Nosso horário de atendimento é de segunda a sexta, das 9h às 18h."
    },
    
    // Fallback automático
    fallback: {
      after_timeout: "create_ticket",
      ticket_priority: "high",
      notify_email: "suporte@empresa.com"
    }
  }
};
```

---

## 12. Moderation

Filtre conteúdo inadequado e garanta respostas apropriadas.

```javascript
// CONTENT MODERATION
const contentModeration = {
  type: "moderation",
  data: {
    // OpenAI Moderation API
    provider: "openAI",
    apiKey: "${OPENAI_API_KEY}",
    
    // Categorias de moderação
    categories: {
      hate: true,
      hate_threatening: true,
      self_harm: true,
      sexual: true,
      sexual_minors: true,
      violence: true,
      violence_graphic: true,
      harassment: true,
      harassment_threatening: true,
      self_harm_intent: true,
      self_harm_instructions: true
    },
    
    // Threshold por categoria
    thresholds: {
      hate: 0.7,
      violence: 0.5,
      self_harm: 0.3  // Mais restritivo para autolesão
    },
    
    // Ação quando detectado
    action: {
      type: "block",
      message: "Desculpe, não posso processar esta solicitação. Por favor, reformule sua mensagem.",
      // Log para análise
      log: true,
      logLevel: "warning",
      // Notificar
      notify: {
        slack: "${SLACK_MODERATION_WEBHOOK}",
        email: "moderacao@empresa.com"
      }
    }
  }
};

// PROFANITY FILTER
const profanityFilter = {
  type: "profanityFilter",
  data: {
    // Dicionário customizado
    customWords: ["palavra1", "palavra2"],
    // Ação
    action: "replace",
    replacement: "***",
    // Sensibilidade
    sensitivity: "medium",
    // Exceções (palavras que parecem mas não são)
    exceptions: ["clássico", "analista"]
  }
};

// INPUT VALIDATION
const inputValidation = {
  type: "inputValidator",
  data: {
    rules: [
      { type: "minLength", value: 2, message: "Mensagem muito curta" },
      { type: "maxLength", value: 500, message: "Mensagem muito longa" },
      { type: "noProfanity", message: "Linguagem inadequada" },
      { type: "noInjection", message: "Entrada inválida" }
    ],
    // Whitelist de caracteres permitidos
    allowedPattern: /^[a-zA-Z0-9\s\.\,\!\?\-\_\@\#\$\%]+$/,
    // Bloquear padrões de injeção
    blockedPatterns: [
      /ignore previous/i,
      /ignore above/i,
      /system prompt/i,
      /jailbreak/i
    ]
  }
};
```

### MELHORIA

❌ **ERRADO:** Não usar moderação em chatbots públicos
```javascript
// Sem filtro - conteúdo inadequado passa
const flowSemMod = {
  nodes: [
    { type: "chatOpenAI", data: {} },
    { type: "output", data: {} }
    // Sem moderation node!
  ]
};
```

✅ **CORRETO:** Moderação em múltiplas camadas
```javascript
const flowModerado = {
  nodes: [
    { type: "inputValidator", position: 1 },
    { type: "profanityFilter", position: 2 },
    { type: "chatOpenAI", position: 3 },
    { type: "outputModeration", position: 4 },
    { type: "output", position: 5 }
  ]
};
```

---

## 13. Sub-Flows

Componha flows complexos usando sub-flows reutilizáveis.

```javascript
// SUB-FLOW reutilizável
const subFlowValidation = {
  name: "validar_documento",
  description: "Valida e extrai informações de documentos",
  nodes: [
    {
      type: "pdfLoader",
      data: { filePath: "{{input.filePath}}" }
    },
    {
      type: "recursiveCharacterTextSplitter",
      data: { chunkSize: 1000, chunkOverlap: 200 }
    },
    {
      type: "openAIEmbedding",
      data: { model: "text-embedding-3-small" }
    },
    {
      type: "pinecone",
      data: { indexName: "validados" }
    }
  ],
  inputs: [
    { name: "filePath", type: "string" }
  ],
  outputs: [
    { name: "status", type: "string" },
    { name: "chunkCount", type: "integer" }
  ]
};

// Flow principal usando sub-flow
const flowPrincipal = {
  name: "processador_documentos",
  nodes: [
    {
      type: "subFlow",
      data: {
        flowId: "validar_documento",
        inputs: {
          filePath: "{{userInput.filePath}}"
        }
      }
    },
    {
      type: "chatOpenAI",
      data: {
        systemMessage: "Documento validado com {{chunkCount}} chunks."
      }
    }
  ]
};
```

---

## 14. API Endpoints

Exponha flows como endpoints RESTful.

```javascript
// Configuração de API
const apiConfig = {
  // Endpoint de chat
  chatEndpoint: {
    path: "/api/v1/chat",
    method: "POST",
    auth: {
      type: "bearer",
      token: "${FLOWISE_API_KEY}"
    },
    rateLimit: {
      windowMs: 60000,
      max: 100
    },
    cors: {
      origin: ["https://app.empresa.com"],
      methods: ["POST"]
    }
  },
  
  // Prediction endpoint
  predictionEndpoint: {
    path: "/api/v1/prediction",
    method: "POST",
    auth: {
      type: "apiKey",
      header: "X-API-Key"
    }
  },
  
  // Variáveis de ambiente por flow
  flows: {
    "chatbot-vendas": {
      vars: {
        OPENAI_API_KEY: "${OPENAI_KEY}",
        PINECONE_API_KEY: "${PINECONE_KEY}"
      },
      rateLimit: 50
    },
    "chatbot-suporte": {
      vars: {
        SLACK_WEBHOOK: "${SLACK_URL}"
      },
      rateLimit: 200
    }
  }
};
```

---

## 15. Conversation Variables

Gerencie estado e contexto ao longo de conversas.

```javascript
// VARIÁVEIS DE CONVERSÃO
const conversationVariables = {
  // Variáveis pré-definidas
  predefined: [
    { name: "sessionId", source: "system" },
    { name: "userId", source: "auth" },
    { name: "startTime", source: "system" }
  ],
  
  // Variáveis customizadas
  custom: [
    {
      name: "contexto",
      type: "object",
      defaultValue: {},
      description: "Contexto acumulado da conversa"
    },
    {
      name: "contador_mensagens",
      type: "integer",
      defaultValue: 0
    },
    {
      name: "preferencias",
      type: "object",
      defaultValue: {
        idioma: "pt-BR",
        formato: "texto"
      }
    }
  ],
  
  // Atualização automática
  autoUpdate: [
    {
      trigger: "onMessage",
      variable: "contador_mensagens",
      action: "increment"
    },
    {
      trigger: "onEntityExtracted",
      variable: "contexto.entities",
      action: "append"
    }
  ],
  
  // Persistência
  persistence: {
    type: "redis",
    host: "${REDIS_HOST}",
    ttl: 3600,
    prefix: "chat:"
  }
};

// USO EM NODES
const nodeComVariaveis = {
  type: "chatOpenAI",
  data: {
    systemMessage: """
    Contexto da conversa:
    - Sessão: {{sessionId}}
    - Mensagens anteriores: {{contador_mensagens}}
    - Preferências: {{preferencias}}
    - Entidades mencionadas: {{contexto.entities}}
    
    Mensagem do usuário: {{userInput}}
    """
  }
};
```

---

## 16. Scheduled Triggers

Execute flows automaticamente em horários específicos.

```javascript
// TRIGGERS AGENDADOS
const scheduledTriggers = [
  {
    name: "relatorio_diario",
    type: "cron",
    schedule: "0 8 * * *",
    flowId: "gerar_relatorio",
    params: {
      periodo: "24h",
      destinatarios: ["gerencia@empresa.com"]
    },
    enabled: true
  },
  {
    name: "limpeza_semanal",
    type: "cron",
    schedule: "0 2 * * 0",
    flowId: "limpar_dados",
    params: {
      diasManter: 30
    }
  },
  {
    name: "sync_hourly",
    type: "interval",
    intervalMs: 3600000,
    flowId: "sincronizar_dados"
  }
];

// TRIGGERS POR EVENTO
const eventTriggers = [
  {
    name: "novo_pedido",
    type: "webhook",
    path: "/webhook/pedido",
    method: "POST",
    flowId: "processar_pedido",
    auth: {
      type: "hmac",
      secret: "${WEBHOOK_SECRET}",
      header: "X-Webhook-Signature"
    }
  },
  {
    name: "file_uploaded",
    type: "storage",
    provider: "s3",
    bucket: "uploads",
    prefix: "documentos/",
    flowId: "processar_documento"
  }
];
```

---

## 17. Integração com LangChain

Combine Flowise com a ecossistema LangChain.

```javascript
// LANGCHAIN RETRIEVER
const langchainRetriever = {
  type: "langchainRetriever",
  data: {
    retrieverType: "vectorStore",
    vectorStore: "pinecone",
    searchKwargs: {
      k: 5,
      scoreThreshold: 0.7
    },
    // Filtros
    filter: {
      source: "manual",
      version: "2.0"
    }
  }
};

// LANGCHAIN CHAIN
const langchainChain = {
  type: "langchainChain",
  data: {
    chainType: "retrievalQA",
    llm: "chatOpenAI",
    retriever: "langchainRetriever",
    returnSourceDocuments: true,
    verbose: true
  }
};

// LANGCHAIN MEMORY
const langchainMemory = {
  type: "langchainMemory",
  data: {
    memoryType: "conversationBufferWindowMemory",
    k: 10,
    returnMessages: true,
    inputKey: "input",
    outputKey: "output"
  }
};
```

---

## 18. Métricas e Monitoramento

Monitore performance e uso dos seus flows.

```javascript
// CONFIGURAÇÃO DE MÉTRICAS
const metricsConfig = {
  // Métricas coletadas
  metrics: [
    "response_time",
    "token_usage",
    "cost_usd",
    "error_rate",
    "user_satisfaction"
  ],
  
  // Destinos de exportação
  destinations: [
    {
      type: "datadog",
      apiKey: "${DD_API_KEY}",
      service: "flowise",
      tags: ["production"]
    },
    {
      type: "prometheus",
      endpoint: "http://prometheus:9090",
      job: "flowise"
    }
  ],
  
  // Alertas
  alerts: [
    {
      name: "slow_response",
      metric: "response_time",
      condition: "p95 > 3000",
      window: "5m",
      action: {
        type: "slack",
        webhook: "${SLACK_ALERTS}"
      }
    },
    {
      name: "high_error_rate",
      metric: "error_rate",
      condition: "rate > 0.05",
      window: "10m",
      action: {
        type: "pagerduty",
        service: "flowise"
      }
    }
  ],
  
  // Dashboard
  dashboard: {
    enabled: true,
    widgets: [
      { type: "response_time_trend", period: "24h" },
      { type: "top_flows", limit: 10 },
      { type: "error_breakdown" },
      { type: "cost_by_flow" }
    ]
  }
};
```

---

## 19. Segurança e Auth

Implemente autenticação e autorização robustas.

```javascript
// CONFIGURAÇÃO DE SEGURANÇA
const securityConfig = {
  // Autenticação
  auth: {
    provider: "auth0",
    domain: "${AUTH0_DOMAIN}",
    clientId: "${AUTH0_CLIENT_ID}",
    clientSecret: "${AUTH0_CLIENT_SECRET}",
    audience: "https://api.flowise.com",
    scope: "openid profile email"
  },
  
  // API Keys
  apiKeys: {
    generate: true,
    prefix: "fk_",
    length: 32,
    scopes: ["read", "write", "admin"]
  },
  
  // Rate Limiting
  rateLimit: {
    global: {
      windowMs: 60000,
      max: 1000
    },
    perUser: {
      windowMs: 60000,
      max: 100
    },
    perFlow: {
      windowMs: 60000,
      max: 50
    }
  },
  
  // CORS
  cors: {
    origin: [
      "https://app.empresa.com",
      "https://admin.empresa.com"
    ],
    methods: ["GET", "POST"],
    allowedHeaders: ["Authorization", "Content-Type"],
    credentials: true
  },
  
  // Headers de segurança
  securityHeaders: {
    contentSecurityPolicy: {
      defaultSrc: ["'self'"],
      scriptSrc: ["'self'"],
      styleSrc: ["'self'", "'unsafe-inline'"]
    },
    strictTransportSecurity: {
      maxAge: 31536000,
      includeSubDomains: true
    }
  },
  
  // Logging de auditoria
  audit: {
    enabled: true,
    events: [
      "login.success",
      "login.failed",
      "api_key.created",
      "flow.published",
      "flow.deleted"
    ],
    destination: {
      type: "elasticsearch",
      index: "flowise-audit"
    }
  }
};
```

---

## 20. Deploy e Escalabilidade

Estratégias para produção em larga escala.

```javascript
// CONFIGURAÇÃO DE DEPLOY
const deployConfig = {
  // Docker
  docker: {
    image: "flowiseai/flowise:latest",
    ports: ["3000:3000"],
    env: {
      PORT: 3000,
      DATABASE_TYPE: "postgres",
      DATABASE_URL: "${DATABASE_URL}",
      REDIS_URL: "${REDIS_URL}",
      FLOWISE_SECRET: "${FLOWISE_SECRET}"
    },
    volumes: [
      "./flows:/app/flows",
      "./credentials:/app/credentials"
    ],
    healthcheck: {
      path: "/api/v1/health",
      interval: 30,
      timeout: 10,
      retries: 3
    }
  },
  
  // Kubernetes
  kubernetes: {
    replicas: 3,
    resources: {
      requests: { cpu: "500m", memory: "512Mi" },
      limits: { cpu: "1000m", memory: "1Gi" }
    },
    autoscaling: {
      enabled: true,
      minReplicas: 2,
      maxReplicas: 10,
      targetCPU: 70,
      targetMemory: 80
    },
    ingress: {
      enabled: true,
      host: "flowise.empresa.com",
      tls: true,
      annotations: {
        "nginx.ingress.kubernetes.io/rate-limit": "100"
      }
    }
  },
  
  // Load Balancing
  loadBalancer: {
    strategy: "round_robin",
    healthCheck: {
      path: "/api/v1/health",
      interval: 10
    }
  },
  
  // Cache
  cache: {
    provider: "redis",
    url: "${REDIS_URL}",
    ttl: 300,
    prefix: "flowise:",
    strategies: {
      flows: "persistent",
      embeddings: "long",
      sessions: "short"
    }
  }
};
```

---

## Referências

- **Documentação Oficial:** https://docs.flowiseai.com/
- **GitHub:** https://github.com/FlowiseAI/Flowise
- **Community:** https://community.flowiseai.com/
- **API Reference:** https://docs.flowiseai.com/integrations/langchain
