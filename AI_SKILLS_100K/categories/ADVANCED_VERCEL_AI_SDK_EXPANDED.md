# 🚀 Vercel AI SDK — Skills Avançados Expandido

> **Fonte:** https://github.com/vercel/ai (35k+ stars)
> **Descrição:** Toolkit completo para construir aplicações de IA com React/Next.js, suporte a streaming, multi-modal, function calling e agentes.
> **Nível:** Intermediário → Avançado

---

## 1. useChat Hook — Chat em Tempo Real

```typescript
'use client';
import { useChat } from 'ai/react';

export default function Chat() {
  const { messages, input, handleInputChange, handleSubmit, isLoading } = useChat({
    api: '/api/chat',
    onResponse: (response) => {
      console.log('Resposta recebida:', response);
    },
    onFinish: (message) => {
      console.log('Mensagem final:', message);
    },
    onError: (error) => {
      console.error('Erro no chat:', error);
    }
  });

  return (
    <div className="flex flex-col h-screen max-w-2xl mx-auto p-4">
      <div className="flex-1 overflow-y-auto space-y-4 mb-4">
        {messages.map((m) => (
          <div key={m.id} className={`p-3 rounded-lg ${
            m.role === 'user' ? 'bg-blue-100 ml-10' : 'bg-gray-100 mr-10'
          }`}>
            <strong>{m.role === 'user' ? 'Você' : 'IA'}:</strong>
            {m.content}
          </div>
        ))}
      </div>
      <form onSubmit={handleSubmit} className="flex gap-2">
        <input
          value={input}
          onChange={handleInputChange}
          placeholder="Digite sua mensagem..."
          className="flex-1 border rounded px-3 py-2"
          disabled={isLoading}
        />
        <button type="submit" disabled={isLoading} className="bg-blue-500 text-white px-4 py-2 rounded">
          {isLoading ? '...' : 'Enviar'}
        </button>
      </form>
    </div>
  );
}
```

### ❌ ERRADO
```typescript
// Não gerenciar estado manualmente
const [messages, setMessages] = useState([]);
const [input, setInput] = useState('');

async function sendMessage() {
  const res = await fetch('/api/chat', {
    method: 'POST',
    body: JSON.stringify({ messages: [...messages, { role: 'user', content: input }] })
  });
  // Lógica manual de streaming... complexo e propenso a erros
}
```

### ✅ CORRETO
```typescript
// Use useChat para gerenciamento completo de estado e streaming
const { messages, input, handleInputChange, handleSubmit } = useChat();
// A SDK cuida de streaming, estado, erros e re-conexão
```

---

## 2. useCompletion — Autocomplete de Texto

```typescript
'use client';
import { useCompletion } from 'ai/react';

export default function TextCompletion() {
  const { completion, input, handleInputChange, handleSubmit, isLoading, stop } = useCompletion({
    api: '/api/completion',
  });

  return (
    <div className="max-w-2xl mx-auto p-4">
      <div className="bg-gray-50 p-4 rounded-lg min-h-[200px] mb-4">
        <p>{completion || 'O texto completo aparecerá aqui...'}</p>
      </div>
      <form onSubmit={handleSubmit} className="flex gap-2">
        <input
          value={input}
          onChange={handleInputChange}
          placeholder="Comece a escrever..."
          className="flex-1 border rounded px-3 py-2"
        />
        <button type="submit" disabled={isLoading} className="bg-green-500 text-white px-4 py-2 rounded">
          Completar
        </button>
        {isLoading && (
          <button type="button" onClick={stop} className="bg-red-500 text-white px-4 py-2 rounded">
            Parar
          </button>
        )}
      </form>
    </div>
  );
}
```

---

## 3. Streaming de Texto com Server-Sent Events

```typescript
// app/api/chat/route.ts
import { openai } from '@ai-sdk/openai';
import { streamText } from 'ai';

export async function POST(req: Request) {
  const { messages } = await req.json();

  const result = streamText({
    model: openai('gpt-4o'),
    messages,
    system: 'Você é um assistente útil em português brasileiro.',
    maxTokens: 1000,
    temperature: 0.7,
  });

  return result.toDataStreamResponse();
}
```

### ❌ ERRADO
```typescript
// Não usar response streaming manual com ReadableStream
const response = await openai.chat.completions.create({
  model: 'gpt-4o',
  messages,
  stream: true,
});
// Manualmente processar chunks... ineficiente
```

### ✅ CORRETO
```typescript
// Use streamText da AI SDK para streaming nativo
import { streamText } from 'ai';
const result = streamText({ model: openai('gpt-4o'), messages });
return result.toDataStreamResponse();
```

---

## 4. Function Calling / Tool Use

```typescript
// app/api/chat/route.ts
import { openai } from '@ai-sdk/openai';
import { streamText, tool } from 'ai';
import { z } from 'zod';

export async function POST(req: Request) {
  const { messages } = await req.json();

  const result = streamText({
    model: openai('gpt-4o'),
    messages,
    tools: {
      getWeather: tool({
        description: 'Obtém o clima de uma cidade',
        parameters: z.object({
          city: z.string().describe('Nome da cidade'),
          unit: z.enum(['celsius', 'fahrenheit']).optional(),
        }),
        execute: async ({ city, unit = 'celsius' }) => {
          const temp = Math.floor(Math.random() * 35) + 5;
          return {
            city,
            temperature: temp,
            unit,
            condition: 'Ensolarado',
          };
        },
      }),
      searchProducts: tool({
        description: 'Busca produtos no catálogo',
        parameters: z.object({
          query: z.string().describe('Termo de busca'),
          category: z.string().optional(),
          maxPrice: z.number().optional(),
        }),
        execute: async ({ query, category, maxPrice }) => {
          // Simula busca no banco de dados
          return { products: [], total: 0 };
        },
      }),
    },
    maxSteps: 5, // Permite múltiplas chamadas de ferramentas
  });

  return result.toDataStreamResponse();
}
```

---

## 5. Output Estruturado com Zod

```typescript
import { generateObject } from 'ai';
import { openai } from '@ai-sdk/openai';
import { z } from 'zod';

const schema = z.object({
  sentiment: z.enum(['positivo', 'negativo', 'neutro']),
  confidence: z.number().min(0).max(1),
  keywords: z.array(z.string()).max(5),
  summary: z.string().max(200),
  language: z.string(),
});

async function analyzeReview(review: string) {
  const { object } = await generateObject({
    model: openai('gpt-4o'),
    schema,
    prompt: `Analise a seguinte avaliação e retorne um objeto estruturado:\n\n"${review}"`,
  });

  return object;
  // { sentiment: "positivo", confidence: 0.92, keywords: ["qualidade", "rápido"], ... }
}
```

### ❌ ERRADO
```typescript
// Não confiar em JSON parse manual sem validação
const response = await fetch('/api/analyze', { method: 'POST', body: review });
const data = JSON.parse(await response.text()); // Pode falhar silenciosamente
```

### ✅ CORRETO
```typescript
// Use generateObject com schema Zod para validação automática
const { object } = await generateObject({ model, schema, prompt });
// Se o modelo retornar JSON inválido, a SDK valida automaticamente
```

---

## 6. Multi-Modal — Texto + Imagem

```typescript
import { openai } from '@ai-sdk/openai';
import { generateText } from 'ai';

async function describeImage(imageUrl: string) {
  const { text } = await generateText({
    model: openai('gpt-4o'),
    messages: [
      {
        role: 'user',
        content: [
          { type: 'text', text: 'Descreva esta imagem em detalhes em português.' },
          { type: 'image', image: imageUrl },
        ],
      },
    ],
  });

  return text;
}
```

```typescript
// Upload de imagem no cliente
'use client';
import { useChat } from 'ai/react';
import { useRef, useState } from 'react';

export default function ImageChat() {
  const { messages, input, handleInputChange, handleSubmit } = useChat();
  const [imageUrl, setImageUrl] = useState<string | null>(null);
  const fileInputRef = useRef<HTMLInputElement>(null);

  function handleFileChange(e: React.ChangeEvent<HTMLInputElement>) {
    const file = e.target.files?.[0];
    if (file) {
      const reader = new FileReader();
      reader.onload = () => setImageUrl(reader.result as string);
      reader.readAsDataURL(file);
    }
  }

  return (
    <div>
      <input type="file" ref={fileInputRef} onChange={handleFileChange} accept="image/*" />
      {imageUrl && <img src={imageUrl} alt="Upload" className="max-w-xs my-2" />}
      <form onSubmit={(e) => {
        e.preventDefault();
        handleSubmit(e, {
          experimental_attachments: imageUrl ? [{ name: 'image', url: imageUrl, contentType: 'image/jpeg' }] : []
        });
      }}>
        <input value={input} onChange={handleInputChange} />
        <button type="submit">Enviar</button>
      </form>
    </div>
  );
}
```

---

## 7. AI React Server Components (RSC)

```typescript
// app/page.tsx
import { createStreamableUI } from 'ai/rsc';
import { openai } from '@ai-sdk/openai';

export async function askAI(question: string) {
  const ui = createStreamableUI();

  (async () => {
    const result = await streamText({
      model: openai('gpt-4o'),
      prompt: question,
    });

    for await (const chunk of result.textStream) {
      ui.update(<div className="p-4">{chunk}</div>);
    }

    ui.done();
  })();

  return ui.value;
}
```

---

## 8. Agentes com AI SDK

```typescript
// app/api/agent/route.ts
import { openai } from '@ai-sdk/openai';
import { generateText, tool } from 'ai';
import { z } from 'zod';

const agentTools = {
  calculator: tool({
    description: 'Calcula expressões matemáticas',
    parameters: z.object({
      expression: z.string().describe('Expressão matemática'),
    }),
    execute: async ({ expression }) => {
      try {
        return { result: eval(expression) };
      } catch {
        return { error: 'Expressão inválida' };
      }
    },
  }),
  webSearch: tool({
    description: 'Busca informações na web',
    parameters: z.object({
      query: z.string().describe('Termo de busca'),
    }),
    execute: async ({ query }) => {
      // Integração com API de busca
      return { results: [`Resultado para: ${query}`] };
    },
  }),
  databaseQuery: tool({
    description: 'Executa query no banco de dados',
    parameters: z.object({
      query: z.string().describe('SQL query'),
    }),
    execute: async ({ query }) => {
      // Integração com banco
      return { rows: [], count: 0 };
    },
  }),
};

export async function POST(req: Request) {
  const { messages } = await req.json();

  const result = await generateText({
    model: openai('gpt-4o'),
    system: `Você é um agente inteligente. Analise o pedido do usuário,
    escolha as ferramentas apropriadas e execute múltiplos passos até
    encontrar a resposta completa.`,
    messages,
    tools: agentTools,
    maxSteps: 10,
    temperature: 0.1,
  });

  return Response.json({ text: result.text, steps: result.steps });
}
```

---

## 9. Edge Runtime e Performance

```typescript
// app/api/chat/route.ts (Edge Runtime)
export const runtime = 'edge';

import { openai } from '@ai-sdk/openai';
import { streamText } from 'ai';

export async function POST(req: Request) {
  const { messages } = await req.json();

  const result = streamText({
    model: openai('gpt-4o-mini'),
    messages,
  });

  return result.toDataStreamResponse();
}
```

---

## 10. Multi-Provider — Anthropic, Google, Mistral

```typescript
import { anthropic } from '@ai-sdk/anthropic';
import { google } from '@ai-sdk/google';
import { mistral } from '@ai-sdk/mistral';
import { openai } from '@ai-sdk/openai';
import { generateText } from 'ai';

// Anthropic Claude
const anthropicResult = await generateText({
  model: anthropic('claude-sonnet-4-20250514'),
  prompt: 'Explique computação quântica em 3 parágrafos.',
});

// Google Gemini
const googleResult = await generateText({
  model: google('gemini-1.5-pro'),
  prompt: 'Crie um plano de negócios para uma startup de IA.',
});

// Mistral
const mistralResult = await generateText({
  model: mistral('mistral-large-latest'),
  prompt: 'Escreva uma função em Python para ordenação.',
});

// Troca dinâmica de provider
function getModel(provider: string) {
  switch (provider) {
    case 'openai': return openai('gpt-4o');
    case 'anthropic': return anthropic('claude-sonnet-4-20250514');
    case 'google': return google('gemini-1.5-pro');
    case 'mistral': return mistral('mistral-large-latest');
    default: return openai('gpt-4o-mini');
  }
}
```

---

## 11. Embeddings e Similaridade Semântica

```typescript
import { openai } from '@ai-sdk/openai';
import { embed, embedMany } from 'ai';

// Embedding de texto único
const { embedding } = await embed({
  model: openai.embedding('text-embedding-3-small'),
  value: 'Como criar um chatbot inteligente?',
});

// Embeddings em lote
const texts = [
  'Machine Learning é um subcampo da IA',
  'Deep Learning usa redes neurais profundas',
  'NLP processa linguagem natural',
  'Visão computacional analisa imagens',
];

const { embeddings } = await embedMany({
  model: openai.embedding('text-embedding-3-small'),
  values: texts,
});

// Calcular similaridade coseno
function cosineSimilarity(a: number[], b: number[]): number {
  const dotProduct = a.reduce((sum, val, i) => sum + val * b[i], 0);
  const normA = Math.sqrt(a.reduce((sum, val) => sum + val * val, 0));
  const normB = Math.sqrt(b.reduce((sum, val) => sum + val * val, 0));
  return dotProduct / (normA * normB);
}

// Encontrar textos mais similares
function findSimilar(queryEmbedding: number[], allEmbeddings: number[][], topK = 3) {
  const similarities = allEmbeddings.map((emb, i) => ({
    index: i,
    score: cosineSimilarity(queryEmbedding, emb),
  }));
  return similarities.sort((a, b) => b.score - a.score).slice(0, topK);
}
```

---

## 12. Telemetry e Observabilidade

```typescript
import { openai } from '@ai-sdk/openai';
import { generateText } from 'ai';

const result = await generateText({
  model: openai('gpt-4o'),
  prompt: 'Olá!',
  experimental_telemetry: {
    isEnabled: true,
    functionId: 'meu-chatbot',
    metadata: {
      userId: 'user-123',
      sessionId: 'session-456',
      feature: 'customer-support',
    },
  },
});

// Métricas disponíveis:
// - Tempo de first token (TTFT)
// - Tempo total de geração
// - Uso de tokens (input/output)
// - Custo estimado
// - Erros e retentativas
```

---

## 13. Playground UI — Interface de Testes

```typescript
// npx ai dev (comando CLI para playground)
// Ou use o Playground da Vercel AI SDK no navegador

// Configuração do playground
// next.config.js
module.exports = {
  experimental: {
    serverActions: true,
  },
};

// Habilitar playground em desenvolvimento
// Acesse: http://localhost:3000/api/chat?playground=true
```

---

## 14. Voz e Áudio

```typescript
// Reconhecimento de voz no cliente
'use client';
import { useChat } from 'ai/react';
import { useRef, useState } from 'react';

export default function VoiceChat() {
  const [isRecording, setIsRecording] = useState(false);
  const mediaRecorderRef = useRef<MediaRecorder | null>(null);
  const { messages, input, handleInputChange, handleSubmit } = useChat();

  async function startRecording() {
    const stream = await navigator.mediaDevices.getUserMedia({ audio: true });
    const mediaRecorder = new MediaRecorder(stream);
    mediaRecorderRef.current = mediaRecorder;

    const chunks: Blob[] = [];
    mediaRecorder.ondataavailable = (e) => chunks.push(e.data);
    mediaRecorder.onstop = async () => {
      const audioBlob = new Blob(chunks, { type: 'audio/webm' });
      const formData = new FormData();
      formData.append('audio', audioBlob);

      const res = await fetch('/api/transcribe', { method: 'POST', body: formData });
      const { text } = await res.json();
      handleInputChange({ target: { value: text } });
    };

    mediaRecorder.start();
    setIsRecording(true);
  }

  function stopRecording() {
    mediaRecorderRef.current?.stop();
    setIsRecording(false);
  }

  return (
    <div>
      <button onClick={isRecording ? stopRecording : startRecording}>
        {isRecording ? '⏹ Parar' : '🎤 Gravar'}
      </button>
      <form onSubmit={handleSubmit}>
        <input value={input} onChange={handleInputChange} />
        <button type="submit">Enviar</button>
      </form>
    </div>
  );
}
```

```typescript
// app/api/transcribe/route.ts
import { openai } from '@ai-sdk/openai';

export async function POST(req: Request) {
  const formData = await req.formData();
  const audio = formData.get('audio') as File;

  const transcription = await openai.transcription({
    model: 'whisper-1',
    audio,
  });

  return Response.json({ text: transcription.text });
}
```

---

## 15. Integração com Banco de Dados (RAG)

```typescript
import { openai } from '@ai-sdk/openai';
import { streamText, tool } from 'ai';
import { z } from 'zod';
import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

export async function POST(req: Request) {
  const { messages } = await req.json();

  const result = streamText({
    model: openai('gpt-4o'),
    system: `Você é um assistente que busca informações no banco de dados.
    Use a ferramenta searchKnowledge para encontrar informações relevantes.`,
    messages,
    tools: {
      searchKnowledge: tool({
        description: 'Busca informações na base de conhecimento',
        parameters: z.object({
          query: z.string().describe('Termo de busca semântica'),
          limit: z.number().optional().default(5),
        }),
        execute: async ({ query, limit }) => {
          // Busca embeddings similares no banco
          const { embedding } = await embed({
            model: openai.embedding('text-embedding-3-small'),
            value: query,
          });

          const results = await prisma.$queryRaw`
            SELECT content, source, 
                   1 - (embedding <=> ${embedding}::vector) as similarity
            FROM knowledge_base
            WHERE 1 - (embedding <=> ${embedding}::vector) > 0.7
            ORDER BY similarity DESC
            LIMIT ${limit}
          `;

          return results;
        },
      }),
    },
    maxSteps: 3,
  });

  return result.toDataStreamResponse();
}
```

---

## 16. Validação de Respostas e Retry

```typescript
import { generateObject } from 'ai';
import { openai } from '@ai-sdk/openai';
import { z } from 'zod';

const productSchema = z.object({
  name: z.string().min(1).max(100),
  price: z.number().positive(),
  description: z.string().min(10).max(500),
  categories: z.array(z.string()).min(1).max(5),
  inStock: z.boolean(),
});

// Com retry automático
const { object } = await generateObject({
  model: openai('gpt-4o'),
  schema: productSchema,
  prompt: 'Gere um produto fictício para uma loja online.',
  maxRetries: 3, // Tenta novamente se a validação falhar
});
```

---

## 17. Composição de Prompts e Templates

```typescript
import { generateText } from 'ai';
import { openai } from '@ai-sdk/openai';

const templates = {
  codeReview: (code: string) => `
    Você é um revisor de código sênior. Revise o código abaixo:
    
    \`\`\`
    ${code}
    \`\`\`
    
    Forneça:
    1. Pontos positivos
    2. Problemas encontrados
    3. Sugestões de melhoria
    4. Código corrigido (se aplicável)
  `,
  
  summarize: (text: string) => `
    Resuma o texto abaixo em 3-5 pontos principais:
    
    "${text}"
  `,
  
  translate: (text: string, targetLang: string) => `
    Traduza o texto abaixo para ${targetLang}:
    
    "${text}"
  `,
};

const review = await generateText({
  model: openai('gpt-4o'),
  prompt: templates.codeReview(`
    function add(a, b) {
      return a + b;
    }
  `),
});
```

---

## 18. Cache e Otimização

```typescript
import { openai } from '@ai-sdk/openai';
import { generateText } from 'ai';
import { unstable_cache } from 'next/cache';

// Cache de resultados de IA
const getCachedResponse = unstable_cache(
  async (prompt: string) => {
    const { text } = await generateText({
      model: openai('gpt-4o-mini'),
      prompt,
    });
    return text;
  },
  ['ai-responses'],
  { revalidate: 3600 } // Cache por 1 hora
);

// Uso
const response = await getCachedResponse('Qual a capital do Brasil?');
```

---

## 19. Deploy na Vercel com Variáveis de Ambiente

```env
# .env.local
OPENAI_API_KEY=sk-...
ANTHROPIC_API_KEY=sk-ant-...
GOOGLE_GENERATIVE_AI_API_KEY=AI...
MISTRAL_API_KEY=...
```

```typescript
// Liberação de variáveis para o cliente (apenas leitura)
// next.config.js
module.exports = {
  env: {
    NEXT_PUBLIC_AI_MODEL: 'gpt-4o',
  },
};
```

---

## 20. Padrões Avançados e Anti-Padrões

```typescript
// ❌ ERRADO: Gerenciar estado do chat manualmente
const [messages, setMessages] = useState([]);
const [isLoading, setIsLoading] = useState(false);
const [error, setError] = useState(null);
// + lógica de streaming manual + reconnect + error handling...

// ✅ CORRETO: useChat já faz tudo isso
const { messages, error, isLoading } = useChat();

// ❌ ERRADO: Parsear JSON sem validação
const data = JSON.parse(response);

// ✅ CORRETO: Usar generateObject com Zod
const { object } = await generateObject({ schema, ... });

// ❌ ERRADO: Chamar API sem tratamento de erro
const res = await fetch('/api/chat');

// ✅ CORRETO: A SDK já trata erros e retentativas
const { error } = useChat({ onError: handleError });
```

---

## Referências

- [Documentação Oficial](https://sdk.vercel.ai/docs)
- [GitHub](https://github.com/vercel/ai)
- [Exemplos](https://github.com/vercel/ai/tree/main/examples)
- [Blog Vercel](https://vercel.com/blog/category/ai)
