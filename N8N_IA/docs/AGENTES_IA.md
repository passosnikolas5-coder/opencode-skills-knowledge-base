# 🤖 Criação de Agentes com IA no n8n

> **Guia completo para criar agentes inteligentes que pensam e agem!**

---

## 📋 Índice

1. [O que são Agentes IA](#o-que-são-agentes-ia)
2. [Arquitetura de Agentes](#arquitetura-de-agentes)
3. [Integração com OpenAI](#integração-com-openai)
4. [Memória de Contexto](#memória-de-contexto)
5. [Subagentes Especializados](#subagentes-especializados)
6. [Processamento de Áudio](#processamento-de-áudio)
7. [Templates de Prompts](#templates-de-prompts)
8. [Otimização e Custos](#otimização-e-custos)

---

## O que são Agentes IA

**Agentes IA** são sistemas autônomos que:
- **Recebem** informações do ambiente
- **Processam** usando modelos de linguagem
- **Decidem** a melhor ação
- **Agem** automaticamente
- **Aprendem** com o contexto

### Diferença: Chatbot vs Agente IA

| Aspecto | Chatbot | Agente IA |
|---------|---------|-----------|
| **Autonomia** | Baixa | Alta |
| **Ações** | Respostas apenas | Executa tarefas |
| **Contexto** | Sessão atual | Memória persistente |
| **Integrações** | Limitada | Múltiplos sistemas |
| **Lógica** | Simples | Complexa e condicional |

---

## Arquitetura de Agentes

### Estrutura Básica

```
┌─────────────────────────────────────────────────┐
│                  AGENTE IA                      │
├─────────────────────────────────────────────────┤
│                                                 │
│  [Input] → [Prompt] → [LLM] → [Tool] → [Output]│
│                                                 │
│  ┌─────────┐  ┌─────────┐  ┌─────────┐        │
│  │ Memória │  │ Regras  │  │ Ações   │        │
│  └─────────┘  └─────────┘  └─────────┘        │
│                                                 │
└─────────────────────────────────────────────────┘
```

### Componentes Principais

#### 1. System Prompt (Instrução do Sistema)

Define o comportamento do agente:

```markdown
Você é um assistente financeiro especializado.

## Suas Responsabilidades:
- Responder dúvidas sobre investimentos
- Analisar sitrações financeiras
- Recomendar ações adequadas

## Regras:
- Seja profissional e objetivo
- Nunca dê conselhos financeiros pessoais
- Sempre mencione riscos quando aplicável
- Encaminhe para um humano quando necessário
```

#### 2. Memória (Context)

Armazena conversas anteriores:

```json
{
  "memoryType": "windowBuffer",
  "contextWindow": 10,
  "memoryKey": "chat_history"
}
```

#### 3. Ferramentas (Tools)

Ações que o agente pode executar:

```json
{
  "tools": [
    {
      "name": "buscar_cliente",
      "description": "Busca dados do cliente por CPF",
      "parameters": {
        "cpf": "string"
      }
    },
    {
      "name": "agendar_reuniao",
      "description": "Agenda reunião com consultor",
      "parameters": {
        "data": "string",
        "horario": "string"
      }
    }
  ]
}
```

#### 4. Output Parser

Extrai a resposta formatada:

```json
{
  "outputParser": "structured",
  "schema": {
    "resposta": "string",
    "acao": "string",
    "confianca": "number"
  }
}
```

---

## Integração com OpenAI

### Configuração

#### 1. Criar Credencial

```
Credentials → Add Credential → OpenAI API
```

**Campos:**
- API Key: `sk-...`
- Organization: (opcional)

#### 2. Nó OpenAI no n8n

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
          "content": "={{$json.message}}",
          "role": "user"
        }
      ]
    },
    "options": {
      "temperature": 0.7,
      "maxTokens": 1000
    }
  }
}
```

### Modelos Disponíveis

| Modelo | Uso | Custo |
|--------|-----|-------|
| `gpt-4` | Tarefas complexas | $$
| `gpt-4-turbo` | Mais rápido | $$ |
| `gpt-3.5-turbo` | Tarefas simples | $ |
| `gpt-4o` | Multimodal | $$ |

### Parâmetros Importantes

```json
{
  "temperature": 0.7,    // 0-2: Criatividade
  "maxTokens": 1000,     // Tamanho da resposta
  "topP": 1,             // Diversidade
  "frequencyPenalty": 0, // Repetição
  "presencePenalty": 0   // Novos tópicos
}
```

---

## Memória de Contexto

### Tipos de Memória

#### 1. Window Buffer Memory

Armazena últimas N mensagens:

```json
{
  "type": "n8n-nodes-base.memoryBufferWindow",
  "parameters": {
    "contextWindow": 10,
    "memoryKey": "chat_history"
  }
}
```

**Vantagens:**
- Simples
- Previsível
- Consumo constante

**Desvantagens:**
- Perde contexto antigo
- Limite fixo

#### 2. Token Buffer Memory

Limita por tokens:

```json
{
  "type": "n8n-nodes-base.memoryBufferToken",
  "parameters": {
    "maxTokenLimit": 2000,
    "memoryKey": "chat_history"
  }
}
```

#### 3. Summary Memory

Resume conversas anteriores:

```json
{
  "type": "n8n-nodes-base.memorySummary",
  "parameters": {
    "maxTokenLimit": 1000,
    "memoryKey": "chat_history",
    "summaryPrompt": "Resuma a conversa anterior em 2-3 frases."
  }
}
```

**Vantagens:**
- Mantém contexto resumido
- Economiza tokens

**Desvantagens:**
- Perde detalhes
- Custo adicional (resumo)

#### 4. Vector Store Memory

Armazena em banco vetorial:

```json
{
  "type": "n8n-nodes-base.memoryVectorStore",
  "parameters": {
    "vectorStore": "pinecone",
    "collection": "conversas",
    "embeddingDimensions": 1536
  }
}
```

**Vantagens:**
- Busca semântica
- Escalável
- Recall preciso

### Implementação Completa

```json
{
  "nodes": [
    {
      "name": "Memory",
      "type": "n8n-nodes-base.memoryBufferWindow",
      "parameters": {
        "contextWindow": 15,
        "memoryKey": "chat_history",
        "sessionKey": "={{$json.sessionId}}"
      }
    },
    {
      "name": "OpenAI",
      "type": "n8n-nodes-base.openAi",
      "parameters": {
        "resource": "chat",
        "operation": "complete",
        "model": "gpt-4",
        "messages": {
          "values": [
            {
              "content": "={{$json.message}}",
              "role": "user"
            }
          ]
        },
        "options": {
          "memory": "={{$node['Memory'].json.memory}}"
        }
      }
    }
  ]
}
```

---

## Subagentes Especializados

### Conceito

**Subagentes** são agentes menores focados em tarefas específicas, coordenados por um agente principal.

```
┌─────────────────────────────────────────┐
│           AGENTE PRINCIPAL              │
│  (Coordena e decide)                    │
├─────────────────────────────────────────┤
│                                         │
│  ┌───────────┐  ┌───────────┐          │
│  │ Subagente │  │ Subagente │          │
│  │ Financeiro│  │ Suporte   │          │
│  └───────────┘  └───────────┘          │
│                                         │
│  ┌───────────┐  ┌───────────┐          │
│  │ Subagente │  │ Subagente │          │
│  │ Vendas    │  │ Técnico   │          │
│  └───────────┘  └───────────┘          │
│                                         │
└─────────────────────────────────────────┘
```

### Implementação no n8n

#### 1. Agente Principal (Roteador)

```json
{
  "name": "Agente Principal",
  "type": "n8n-nodes-base.openAi",
  "parameters": {
    "resource": "chat",
    "operation": "complete",
    "model": "gpt-4",
    "messages": {
      "values": [
        {
          "content": "Você é o roteador. Analise a mensagem e identifique o departamento.\n\nOpções:\n- FINANCEIRO: Dúvidas sobre investimentos, impostos, financeiro\n- SUPORTE: Problemas técnicos, suporte\n- VENDAS: Interesse em produtos, orçamentos\n- GERAL: Dúvidas gerais\n\nResponda APENAS com o departamento.",
          "role": "system"
        },
        {
          "content": "={{$json.message}}",
          "role": "user"
        }
      ]
    }
  }
}
```

#### 2. Subagente Financeiro

```json
{
  "name": "Subagente Financeiro",
  "type": "n8n-nodes-base.openAi",
  "parameters": {
    "resource": "chat",
    "operation": "complete",
    "model": "gpt-4",
    "messages": {
      "values": [
        {
          "content": "Você é um consultor financeiro especializado.\n\n## Regras:\n- Seja profissional e objetivo\n- Analise a situação antes de recomendar\n- Sempre mencione riscos\n- Encaminhe para humano quando necessário\n\n## Contexto do Cliente:\n{{$json.clienteContext}}",
          "role": "system"
        },
        {
          "content": "={{$json.message}}",
          "role": "user"
        }
      ]
    }
  }
}
```

#### 3. Switch para Roteamento

```json
{
  "name": "Roteador",
  "type": "n8n-nodes-base.switch",
  "parameters": {
    "dataType": "string",
    "value1": "={{$json.departamento}}",
    "rules": [
      {
        "value2": "FINANCEIRO",
        "output": 0
      },
      {
        "value2": "SUPORTE",
        "output": 1
      },
      {
        "value2": "VENDAS",
        "output": 2
      }
    ]
  }
}
```

### Exemplo Completo: Agente Financeiro

```json
{
  "nodes": [
    {
      "name": "Telegram Trigger",
      "type": "n8n-nodes-base.telegramTrigger",
      "parameters": {
        "updates": ["message"]
      }
    },
    {
      "name": "Transcriver Áudio",
      "type": "n8n-nodes-base.openAi",
      "parameters": {
        "resource": "audio",
        "operation": "transcribe",
        "model": "whisper-1",
        "binaryData": "={{$json.audio}}"
      }
    },
    {
      "name": "Roteador",
      "type": "n8n-nodes-base.openAi",
      "parameters": {
        "resource": "chat",
        "operation": "complete",
        "model": "gpt-4",
        "messages": {
          "values": [
            {
              "content": "Identifique o departamento: FINANCEIRO, SUPORTE, VENDAS ou GERAL",
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
      "name": "Switch",
      "type": "n8n-nodes-base.switch",
      "parameters": {
        "dataType": "string",
        "value1": "={{$json.message.content}}",
        "rules": [
          { "value2": "FINANCEIRO", "output": 0 },
          { "value2": "SUPORTE", "output": 1 },
          { "value2": "VENDAS", "output": 2 }
        ]
      }
    },
    {
      "name": "Agente Financeiro",
      "type": "n8n-nodes-base.openAi",
      "parameters": {
        "resource": "chat",
        "operation": "complete",
        "model": "gpt-4",
        "messages": {
          "values": [
            {
              "content": "Você é um consultor financeiro. Responda dúvidas sobre investimentos.",
              "role": "system"
            },
            {
              "content": "={{$json.message.content}}",
              "role": "user"
            }
          ]
        }
      }
    },
    {
      "name": "Enviar Resposta",
      "type": "n8n-nodes-base.telegram",
      "parameters": {
        "operation": "sendMessage",
        "chatId": "={{$json.chat.id}}",
        "text": "={{$json.message.content}}"
      }
    }
  ]
}
```

---

## Processamento de Áudio

### Transcrição com Whisper

```json
{
  "name": "Transcrever Áudio",
  "type": "n8n-nodes-base.openAi",
  "parameters": {
    "resource": "audio",
    "operation": "transcribe",
    "model": "whisper-1",
    "binaryPropertyName": "audio",
    "options": {
      "language": "pt",
      "prompt": "Transcrição de áudio do Telegram"
    }
  }
}
```

### Integração com Telegram

```json
{
  "name": "Receber Áudio",
  "type": "n8n-nodes-base.telegramTrigger",
  "parameters": {
    "updates": ["message"]
  }
},
{
  "name": "Download Áudio",
  "type": "n8n-nodes-base.telegram",
  "parameters": {
    "operation": "getFile",
    "fileId": "={{$json.message.voice.file_id}}"
  }
},
{
  "name": "Transcrever",
  "type": "n8n-nodes-base.openAi",
  "parameters": {
    "resource": "audio",
    "operation": "transcribe",
    "model": "whisper-1",
    "binaryPropertyName": "data"
  }
}
```

### Geração de Áudio (TTS)

```json
{
  "name": "Gerar Áudio",
  "type": "n8n-nodes-base.openAi",
  "parameters": {
    "resource": "audio",
    "operation": "speech",
    "model": "tts-1",
    "input": "={{$json.resposta}}",
    "voice": "nova",
    "responseFormat": "mp3"
  }
}
```

---

## Templates de Prompts

### 1. Assistente Pessoal

```markdown
Você é um assistente pessoal inteligente.

## Funcionalidades:
- Organizar e-mails
- Gerenciar tarefas
- Agendar reuniões
- Responder perguntas

## Personalidade:
- Profissional mas amigável
- Proativo em sugestões
- Organizado e detalhista

## Regras:
- Sempre confirme ações importantes
- Priorize tarefas urgentes
- Mantenha contexto da conversa
```

### 2. Consultor Financeiro

```markdown
Você é um consultor financeiro especializado.

## Expertise:
- Investimentos (renda fixa, variável)
- Planejamento financeiro
- Análise de riscos
- Tributação

## Regras:
- Nunca dê conselhos pessoais
- Sempre mencione riscos
- Fundamente em dados
- Encaminhe para especialista quando necessário

## Formato:
- Respostas claras e objetivas
- Use exemplos quando possível
- Cite fontes quando aplicável
```

### 3. Suporte Técnico

```markdown
Você é um agente de suporte técnico.

## Responsabilidades:
- Diagnosticar problemas
- Fornecer soluções
- Documentar chamados
- Escalar quando necessário

## Fluxo:
1. Identifique o problema
2. Pergunte detalhes relevantes
3. Forneça solução
4. Confirme se resolveu
5. Registre o chamado

## Regras:
- Seja paciente e claro
- Use linguagem simples
- Documente tudo
- Escale problemas críticos
```

### 4. Vendas

```markdown
Você é um consultor de vendas.

## Objetivo:
- Qualificar leads
- Apresentar soluções
- Fechar vendas

## Abordagem:
1. Descubra a necessidade
2. Apresente benefícios
3. Trate objeções
4. Proponha próximo passo

## Regras:
- Não seja agressivo
- Escute mais que fale
- Personalize a abordagem
- Respeite o tempo do cliente
```

---

## Otimização e Custos

### Estratégias de Otimização

#### 1. Cache de Respostas

```json
{
  "name": "Cache",
  "type": "n8n-nodes-base.redis",
  "parameters": {
    "operation": "get",
    "key": "={{$json.cacheKey}}"
  }
},
{
  "name": "Se Não Cached",
  "type": "n8n-nodes-base.if",
  "parameters": {
    "conditions": {
      "boolean": [
        {
          "value1": "={{$json.cacheHit}}",
          "value2": false
        }
      ]
    }
  }
}
```

#### 2. Reduzir Tokens

```json
{
  "prompt": "Responda em máximo 100 palavras.",
  "maxTokens": 200
}
```

#### 3. Usar Modelos Menores

```json
{
  "model": "gpt-3.5-turbo",  // Para tarefas simples
  "model": "gpt-4"           // Para tarefas complexas
}
```

### Estimativa de Custos

| Modelo | Input (1K tokens) | Output (1K tokens) |
|--------|-------------------|---------------------|
| GPT-3.5-turbo | $0.0015 | $0.002 |
| GPT-4 | $0.03 | $0.06 |
| GPT-4-turbo | $0.01 | $0.03 |
| Whisper | $0.006/min | - |

### Exemplo de Cálculo

```
Mensagens por dia: 100
Tokens por mensagem: 500 input + 200 output
Modelo: GPT-3.5-turbo

Custo diário:
- Input: 100 × 500/1000 × $0.0015 = $0.075
- Output: 100 × 200/1000 × $0.002 = $0.04
- Total: $0.115/dia = $3.45/mês
```

---

## 📚 Próximos Passos

1. Aprenda [Integrações](INTEGRACOES.md) com Google e Telegram
2. Conheça [Padrões de Projeto](PADROES_PROJETO.md)
3. Pratique com os [Templates](../templates/)

---

*Última atualização: Setembro 2026*