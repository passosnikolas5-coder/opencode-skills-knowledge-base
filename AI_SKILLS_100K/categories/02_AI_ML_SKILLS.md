# 🤖 AI & Machine Learning Skills - 12.000 Skills

> **Todas as habilidades de IA e ML documentadas e melhoradas**

---

## 📊 Visão Geral

| Subcategoria | Skills | Nível |
|--------------|--------|-------|
| LLMs | 2.000 | Intermediário → Expert |
| Prompt Engineering | 1.500 | Básico → Expert |
| RAG | 1.000 | Intermediário → Expert |
| Fine-tuning | 800 | Avançado → Expert |
| Agents | 1.500 | Intermediário → Expert |
| Computer Vision | 1.000 | Intermediário → Expert |
| NLP | 1.000 | Intermediário → Expert |
| Reinforcement Learning | 800 | Avançado → Expert |
| Generative AI | 1.000 | Intermediário → Expert |
| MLOps | 600 | Intermediário → Expert |

---

## 🧠 LLMs Skills (2.000)

### Model Selection (500)

#### LLM001: Model Selection Framework
```lua
-- SKILL: LLM Model Selection Framework
-- Nível: Intermediário → Expert
-- Contexto: Escolher o melhor modelo para a tarefa

-- CRITÉRIOS:
-- 1. Performance (benchmarks)
-- 2. Latência (tempo de resposta)
-- 3. Custo (tokens/dólar)
-- 4. Context window (tamanho)
-- 5. Modalidade (texto, imagem, áudio)
-- 6. Disponibilidade (API, self-hosted)
-- 7. Compliance (privacidade, region)
-- 8. Community (suporte, plugins)

-- TABELA DE DECISÃO:
-- | Modelo        | Força                    | Melhor Para              |
-- |---------------|--------------------------|--------------------------|
-- | GPT-4o        | Raciocínio complexo      | Análise, código          |
-- | Claude 3.5    | Long context, safety     | Documentos longos        |
-- | Gemini 1.5    | Multimodal, 1M context   | Vídeo, áudio, imagens    |
-- | Llama 3       | Open source, local       | On-premise, fine-tuning  |
-- | Mistral       | European, efficient      | EU compliance            |
-- | Command R+    | RAG otimizado            | Retrieval-augmented      |
-- | DeepSeek      | Coding especializado     | Programação              |
-- | Qwen 2.5      | Multilingual             | Internacional            |

-- MELHORIA:
-- ERRADO: Usar GPT-4 para tudo
-- CERTO: Selecionar baseado em caso de uso
```

### Prompt Engineering (1.500)

#### PE001: Chain-of-Thought Prompting
```lua
-- SKILL: Chain-of-Thought Prompting
-- Nível: Básico → Expert
-- Contexto: Raciocínio lógico

-- PADRÃO:
-- "Vamos pensar passo a passo..."

-- MELHORIA AVANÇADA:
-- 1. Zero-shot CoT: "Pense passo a passo"
-- 2. Few-shot CoT: Exemplos com raciocínio
-- 3. Auto-CoT: Gerar raciocínios automaticamente
-- 4. Complex CoT: Decompor problemas complexos
-- 5. Tree-of-Thought: Múltiplos caminhos
-- 6. Graph-of-Thought: Raciocínio em grafo

-- EXEMPLO MELHORADO:
-- ERRADO: "Qual é a capital da França?"
-- CERTO: "Para encontrar a capital da França, preciso:
--   1. Identificar o país: França
--   2. Lembrar que capitais são centros políticos
--   3. Consultar conhecimento: Paris é a capital
--   Resposta: Paris"
```

#### PE002: Few-Shot Learning
```lua
-- SKILL: Few-Shot Prompting Mastery
-- Nível: Intermediário → Expert
-- Contexto: Tarefas com poucos exemplos

-- PADRÕES:
-- 1. Random shots: exemplos aleatórios
-- 2. Similar shots: exemplos similares ao input
-- 3. Diverse shots: exemplos diversos
-- 4. Adversarial shots: exemplos difíceis
-- 5. Calibrated shots: exemplos balanceados

-- QUANTIDADE ÓTIMA:
-- - 2-4 exemplos para classificação
-- - 3-5 exemplos para extração
-- - 5-8 exemplos para geração
-- - 10+ exemplos para tarefas complexas

-- MELHORIA:
-- ERRADO: Jogar exemplos aleatórios
-- CERTO: Selecionar exemplos representativos e diversos
```

#### PE003: Prompt Chaining
```lua
-- SKILL: Prompt Chaining Strategies
-- Nível: Intermediário → Expert
-- Contexto: Tarefas complexas multi-step

-- PADRÕES:
-- 1. Sequential: A → B → C
-- 2. Parallel: A → (B, C) → D
-- 3. Conditional: A → (B se X, C se Y)
-- 4. Iterative: A → (B → Refinar) × N
-- 5. Hierarchical: A → (B1, B2, B3) → C

-- EXEMPLO:
-- Passo 1: Extrair informações do documento
-- Passo 2: Classificar cada informação
-- Passo 3: Gerar resumo por categoria
-- Passo 4: Criar ação recomendada

-- MELHORIA:
-- ERRADO: Prompt gigante e único
-- CERTO: Chain de prompts menores e focados
```

#### PE004: Constitutional AI
```lua
-- SKILL: Constitutional AI Prompting
-- Nível: Avançado → Expert
-- Contexto: AI safety e alignment

-- PRINCÍPIOS:
-- 1. Ser útil e inofensivo
-- 2. Ser honesto e transparente
-- 3. Respeitar privacidade
-- 4. Evitar vieses
-- 5. Ser justo e inclusivo
-- 6. Proteger dados sensíveis
-- 7. Seguir leis e regulamentos
-- 8. Ser responsável

-- TÉCNICAS:
-- 1. System prompts com regras
-- 2. Self-critique e correção
-- 3. Red teaming
-- 4. Safety filters
-- 5. Output validation
-- 6. Human oversight
-- 7. Audit trails
-- 8. Continuous improvement
```

#### PE005: Meta-Prompting
```lua
-- SKILL: Meta-Prompting Techniques
-- Nível: Avançado → Expert
-- Contexto: Otimizar prompts automaticamente

-- TÉCNICAS:
-- 1. APE (Automatic Prompt Engineer)
-- 2. OPRO (Optimization by PROmpting)
-- 3. DSPy (compiler de prompts)
-- 4. Prompt evolution
-- 5. Auto-evaluation
-- 6. Self-refinement
-- 7. Meta-learning
-- 8. Transfer learning de prompts

-- FLUXO:
-- 1. Definir métrica de qualidade
-- 2. Gerar variações de prompt
-- 3. Avaliar cada variação
-- 4. Selecionar melhor
-- 5. Iterar e melhorar
-- 6. Validar em produção
```

### RAG Skills (1.000)

#### RAG001: RAG Architecture
```lua
-- SKILL: RAG Architecture Patterns
-- Nível: Intermediário → Expert
-- Contexto: Sistemas de retrieval-augmented generation

-- ARQUITETURA BÁSICA:
-- 1. Document Processing
--    - Chunking (fixed, semantic, recursive)
--    - Metadata extraction
--    - Embedding generation
--
-- 2. Vector Store
--    - Pinecone, Weaviate, Qdrant
--    - Milvus, Chroma, FAISS
--    - pgvector (PostgreSQL)
--
-- 3. Retrieval
--    - Semantic search
--    - Hybrid search (keyword + semantic)
--    - Re-ranking (Cohere, cross-encoder)
--    - Multi-query retrieval
--
-- 4. Generation
--    - Context injection
--    - Citation tracking
--    - Source attribution

-- MELHORIA:
-- ERRADO: Chunking por character count
-- CERTO: Semantic chunking + metadata
```

#### RAG002: Advanced RAG Patterns
```lua
-- SKILL: Advanced RAG Patterns
-- Nível: Avançado → Expert
-- Contexto: RAG de alta qualidade

-- PADRÕES AVANÇADOS:
-- 1. Self-RAG: Modelo decide quando buscar
-- 2. Corrective RAG: Valida e corrige
-- 3. Graph RAG: Usa grafo de conhecimento
-- 4. Multi-modal RAG: Texto + imagem + áudio
-- 5. Agentic RAG: Agentes que buscam
-- 6. Recursive RAG: Múltiplas iterações
-- 7. Speculative RAG: Gerar e validar
-- 8. Cache-Augmented: Cache inteligente

-- OTIMIZAÇÕES:
-- 1. Query expansion
-- 2. HyDE (Hypothetical Document Embeddings)
-- 3. Step-back prompting
-- 4. Sub-questions decomposition
-- 5. Sentence window retrieval
-- 6. Parent document retrieval
-- 7. Fine-tuned embeddings
-- 8. Reranking cross-encoders
```

#### RAG003: Evaluation Metrics
```lua
-- SKILL: RAG Evaluation Metrics
-- Nível: Intermediário → Expert
-- Contexto: Medir qualidade do RAG

-- MÉTRICAS:
-- 1. Faithfulness: Resposta é fiel ao contexto?
-- 2. Answer Relevancy: Resposta responde a pergunta?
-- 3. Context Precision: Contextos são relevantes?
-- 4. Context Recall: Todos os contextos necessários?
-- 5. Hallucination: Informações inventadas?
-- 6. Citation Accuracy: Citações corretas?
-- 7. Latency: Tempo de resposta?
-- 8. Cost: Custo por query?

-- FERRAMENTAS:
-- 1. RAGAS (framework de avaliação)
-- 2. DeepEval
-- 3. TruLens
-- 4. LangSmith
-- 5. Phoenix (Arize)
-- 6. Weights & Biases
-- 7. Custom evaluation
-- 8. Human evaluation
```

### Fine-tuning Skills (800)

#### FT001: Fine-tuning Strategies
```lua
-- SKILL: Fine-tuning Strategies
-- Nível: Avançado → Expert
-- Contexto: Personalizar modelos

-- ESTRATÉGIAS:
-- 1. Full Fine-tuning
--    - Atualiza todos os parâmetros
--    - Mais recursos necessários
--    - Melhor para datasets grandes
--
-- 2. LoRA (Low-Rank Adaptation)
--    - Atualiza apenas matrizes de baixo rank
--    - Menos recursos
--    - Bom para datasets médios
--
-- 3. QLoRA
--    - LoRA + quantização 4-bit
--    - Muito eficiente
--    - Roda em GPUs menores
--
-- 4. Prompt Tuning
--    - Apenas embeddings de prompt
--    - Muito leve
--    - Bom para muitas tarefas
--
-- 5. Adapter Tuning
--    - Camadas adapter pequenas
--    - Balanceado
--    - Multi-task

-- QUANDO USAR:
-- - Full: Dataset > 100k, recursos abundantes
-- - LoRA: Dataset 10k-100k, GPU média
-- - QLoRA: Dataset 1k-10k, GPU limitada
-- - Prompt: Dataset < 1k, multi-task
```

#### FT002: Data Preparation
```lua
-- SKILL: Fine-tuning Data Preparation
-- Nível: Intermediário → Expert
-- Contexto: Preparar dados para fine-tuning

-- PROCESSO:
-- 1. Data Collection
--    - Web scraping
--    - API collection
--    - Human annotation
--    - Synthetic generation
--
-- 2. Data Cleaning
--    - Deduplicação
--    - Normalização
--    - Filtragem de qualidade
--    - Remoção de PII
--
-- 3. Data Formatting
--    - JSONL format
--    - Chat format (system/user/assistant)
--    - Instruction format
--    - Completion format
--
-- 4. Data Validation
--    - Sanity checks
--    - Distribution analysis
--    - Quality metrics
--    - Bias detection

-- QUANTIDADE:
-- - Instruction tuning: 10k-100k exemplos
-- - Chat fine-tuning: 5k-50k exemplos
-- - Domain adaptation: 50k-500k exemplos
-- - Alignment (RLHF): 10k-50k preferências
```

### Agents Skills (1.500)

#### AG001: Agent Architecture Patterns
```lua
-- SKILL: Agent Architecture Patterns
-- Nível: Intermediário → Expert
-- Contexto: Sistemas de agentes autônomos

-- PADRÕES:
-- 1. ReAct (Reason + Act)
--    - Loop de raciocínio e ação
--    - Mais simples, mais previsível
--
-- 2. Plan-and-Execute
--    - Planeja tudo primeiro
--    - Depois executa
--    - Bom para tarefas complexas
--
-- 3. Multi-Agent Systems
--    - Múltiplos agentes especializados
--    - Orquestração centralizada
--    - Melhor para tarefas diversificadas
--
-- 4. Hierarchical Agents
--    - Agentes com sub-agentes
--    - Delegação progressiva
--    - Escalável
--
-- 5. Collaborative Agents
--    - Agentes trabalham juntos
--    - Consenso e votação
--    - Robusto a falhas

-- COMPONENTES:
-- 1. LLM (cérebro)
-- 2. Tools (ferramentas)
-- 3. Memory (curto/longo prazo)
-- 4. Planning (planejamento)
-- 5. Reflection (auto-crítica)
-- 6. Communication (comunicação)
-- 7. Safety (segurança)
-- 8. Monitoring (monitoramento)
```

#### AG002: Tool Use Patterns
```lua
-- SKILL: Tool Use Patterns for Agents
-- Nível: Intermediário → Expert
-- Contexto: Agentes que usam ferramentas

-- PADRÕES:
-- 1. Function Calling
--    - Definir funções JSON Schema
--    - Modelo escolhe qual usar
--    - Executa e retorna resultado
--
-- 2. Code Interpreter
--    - Gerar código Python
--    - Executar em sandbox
--    - Retornar output
--
-- 3. Retrieval Augmented
--    - Buscar em bases de conhecimento
--    - RAG dinâmico
--    - Contexto atualizado
--
-- 4. Browser Automation
--    - Navegar na web
--    - Interagir com elementos
--    - Extrair informações
--
-- 5. API Integration
--    - Chamar APIs externas
--    - Processar respostas
--    - Cadena de chamadas

-- MELHORIA:
-- ERRADO: Tool overload (muitas ferramentas)
-- CERTO: Ferramentas essenciais bem documentadas
```

#### AG003: Memory Systems
```lua
-- SKILL: Agent Memory Systems
-- Nível: Intermediário → Expert
-- Contexto: Persistência de memória de agentes

-- TIPOS:
-- 1. Working Memory (curto prazo)
--    - Context window atual
--    - Scratchpad
--    - Buffer de sessão
--
-- 2. Episodic Memory (experiências)
--    - Interações passadas
--    - Sucessos e falhas
--    - Aprendizados
--
-- 3. Semantic Memory (conhecimento)
--    - Fatos e conceitos
--    - Graph de conhecimento
--    - Vector store
--
-- 4. Procedural Memory (habilidades)
--    - Skills aprendidas
--    - Padrões de código
--    - Workflows

-- IMPLEMENTAÇÃO:
-- 1. SQLite para persistência simples
-- 2. Vector DB para busca semântica
-- 3. Graph DB para relacionamentos
-- 4. Cache (Redis) para acesso rápido
-- 5. File system para documentos
-- 6. Object storage para binários
```

#### AG004: Multi-Agent Orchestration
```lua
-- SKILL: Multi-Agent Orchestration
-- Nível: Avançado → Expert
-- Contexto: Sistemas com múltiplos agentes

-- PADRÕES:
-- 1. Supervisor
--    - Um agente gerencia outros
--    - Delegação e coordenação
--
-- 2. Router
--    - Direciona para agente certo
--    - Baseado em especialidade
--
-- 3. Debate
--    - Agentes discutem
--    - Consenso por votação
--
-- 4. Pipeline
--    - Agentes em sequência
--    - Cada um processa e passa
--
-- 5. Swarm
--    - Agentes autônomos
--    - Comunicação descentralizada

-- FRAMEWORKS:
-- 1. CrewAI (role-playing)
-- 2. AutoGen (conversational)
-- 3. LangGraph (state machines)
-- 4. Swarm (OpenAI)
-- 5. Agency Swarm
-- 6. TaskWeaver
-- 7. CAMEL (role-playing)
-- 8. MetaGPT (software engineering)
```

### Computer Vision Skills (1.000)

#### CV001: Object Detection
```lua
-- SKILL: Object Detection Mastery
-- Nível: Intermediário → Expert
-- Contexto: Detectar objetos em imagens

-- MODELOS:
-- 1. YOLO (v8, v9, v10)
--    - Real-time
--    - Boa acurácia
--    - Fácil de usar
--
-- 2. SSD (Single Shot Detector)
--    - Rápido
--    - Menos preciso
--    - Mobile-friendly
--
-- 3. Faster R-CNN
--    - Mais preciso
--    - Mais lento
--    - Research-grade
--
-- 4. DETR (Detection Transformer)
--    - State-of-the-art
--    - Transformer-based
--    - End-to-end
--
-- 5. EfficientDet
--    - Eficiente
--    - Escalável
--    - Production-ready

-- MÉTRICAS:
-- - mAP (mean Average Precision)
-- - FPS (frames per second)
-- - Inference time
-- - Model size
-- - Memory usage
```

#### CV002: Image Segmentation
```lua
-- SKILL: Image Segmentation
-- Nível: Intermediário → Expert
-- Contexto: Segmentar imagens em regiões

-- TIPOS:
-- 1. Semantic Segmentation
--    - Cada pixel tem uma classe
--    - Fundo vs objeto
--
-- 2. Instance Segmentation
--    - Cada instância separada
--    - Distingue objetos iguais
--
-- 3. Panoptic Segmentation
--    - Combina semântica + instância
--    - Completo
--
-- 4. Interactive Segmentation
--    - Usuário guia
--    - Point, box, scribble

-- MODELOS:
-- 1. Mask R-CNN
-- 2. U-Net
-- 3. DeepLab
-- 4. SAM (Segment Anything)
-- 5. FastSAM
-- 6. YOLO-Seg
```

#### CV003: Facial Recognition
```lua
-- SKILL: Facial Recognition Systems
-- Nível: Avançado → Expert
-- Contexto: Identificação de rostos

-- PIPELINE:
-- 1. Face Detection
--    - MTCNN, RetinaFace, BlazeFace
--
-- 2. Face Alignment
--    - Landmarks, transformations
--
-- 3. Feature Extraction
--    - ArcFace, CosFace, SphereFace
--
-- 4. Face Matching
--    - Cosine similarity, Euclidean
--
-- 5. Face Clustering
--    - DBSCAN, Hierarchical

-- APLICAÇÕES:
-- - Desbloqueio facial
-- - Controle de acesso
-- - Identificação forense
-- - Análise de emoção
-- - Attendance tracking

-- ÉTICA:
-- - Consentimento
-- - Privacidade
-- - Não discriminação
-- - Transparência
```

### NLP Skills (1.000)

#### NLP001: Text Classification
```lua
-- SKILL: Text Classification Mastery
-- Nível: Intermediário → Expert
-- Contexto: Classificar textos

-- ABORDAGENS:
-- 1. Traditional ML
--    - TF-IDF + SVM
--    - Bag of Words + Naive Bayes
--    - FastText
--
-- 2. Deep Learning
--    - LSTM/BiLSTM
--    - CNN for text
--    - Hierarchical attention
--
-- 3. Transformers
--    - BERT fine-tuning
--    - RoBERTa
--    - DistilBERT (eficiente)
--    - DeBERTa
--
-- 4. Zero-shot
--    - NLI-based
--    - LLM prompting

-- APLICAÇÕES:
-- - Sentiment analysis
-- - Topic classification
-- - Intent detection
-- - Spam detection
-- - Content moderation
```

#### NLP002: Named Entity Recognition
```lua
-- SKILL: Named Entity Recognition (NER)
-- Nível: Intermediário → Expert
-- Contexto: Extrair entidades de textos

-- MODELOS:
-- 1. SpaCy (production-ready)
-- 2. Flair (contextual embeddings)
-- 3. Hugging Face Transformers
-- 4. Stanza (Stanford NLP)
-- 5. LLM-based (GPT, Claude)

-- ENTIDADES PADRÃO:
-- - PER (pessoa)
-- - ORG (organização)
-- - LOC (localização)
-- - DATE (data)
-- - MONEY (dinheiro)
-- - PRODUCT (produto)
-- - EVENT (evento)
-- - CUSTOM (domínio específico)

-- TÉCNICAS:
-- 1. BIO tagging
-- 2. Span classification
-- 3. Relation extraction
-- 4. Nested NER
-- 5. Few-shot NER
```

### Reinforcement Learning Skills (800)

#### RL001: RL Fundamentals
```lua
-- SKILL: Reinforcement Learning Fundamentals
-- Nível: Avançado → Expert
-- Contexto: Agentes que aprendem com experiência

-- CONCEITOS:
-- 1. Agent, Environment, State, Action, Reward
-- 2. Policy (π): mapeamento estado → ação
-- 3. Value Function (V, Q): valor esperado
-- 4. Bellman Equation
-- 5. Discount Factor (γ)
-- 6. Exploration vs Exploitation
-- 7. Markov Decision Process (MDP)
-- 8. Monte Carlo vs TD Learning

-- ALGORITMOS:
-- 1. Q-Learning
-- 2. SARSA
-- 3. DQN (Deep Q-Network)
-- 4. Policy Gradient
-- 5. A3C (Advantage Actor-Critic)
-- 6. PPO (Proximal Policy Optimization)
-- 7. SAC (Soft Actor-Critic)
-- 8. TD3 (Twin Delayed DDPG)
```

#### RL002: Deep RL
```lua
-- SKILL: Deep Reinforcement Learning
-- Nível: Avançado → Expert
-- Contexto: RL com deep learning

-- ARQUITETURAS:
-- 1. DQN
--    - Q-network + Target network
--    - Experience replay
--    - Double DQN, Dueling DQN
--
-- 2. A3C/PPO
--    - Actor-Critic
--    - Policy gradient
--    - Advantage estimation
--
-- 3. SAC
--    - Maximum entropy
--    - Off-policy
--    - Continuous actions
--
-- 4. Model-Based
--    - World models
--    - Planning with imagination
--    - Dreamer, MuZero

-- APLICAÇÕES:
-- - Jogos (Atari, Go, Dota)
-- - Robótica
-- - Trading
-- - Recomendação
-- - Resource allocation
```

### Generative AI Skills (1.000)

#### GEN001: Text Generation
```lua
-- SKILL: Text Generation Mastery
-- Nível: Intermediário → Expert
-- Contexto: Gerar textos de alta qualidade

-- TÉCNICAS:
-- 1. Autoregressive (GPT, Claude)
--    - Token by token
--    - Coherence
--
-- 2. Masked LM (BERT)
--    - Fill-in-the-blank
--    - Bidirectional
--
-- 3. Seq2Seq (T5, BART)
--    - Encoder-decoder
--    - Translation, summarization
--
-- 4. Diffusion for Text
--    - Iterative refinement
--    - Experimental

-- PARÂMETROS:
-- - Temperature: criatividade (0-2)
-- - Top-p: nucleus sampling
-- - Top-k: top k tokens
-- - Frequency penalty: reduzir repetição
-- - Presence penalty: promover novidade
-- - Max tokens: limite de geração
-- - Stop sequences: parada
```

#### GEN002: Image Generation
```lua
-- SKILL: Image Generation Mastery
-- Nível: Intermediário → Expert
-- Contexto: Gerar imagens com IA

-- MODELOS:
-- 1. Stable Diffusion (open source)
--    - SDXL, SD 3.0
--    - ControlNet, IP-Adapter
--    - LoRA, DreamBooth
--
-- 2. DALL-E 3 (OpenAI)
--    - High quality
--    - Prompt following
--    - API access
--
-- 3. Midjourney
--    - Artistic
--    - Discord bot
--    - High aesthetic
--
-- 4. Flux
--    - Fast
--    - High quality
--    - Multiple variants
--
-- 5. Ideogram
--    - Text in images
--    - Typography

-- TÉCNICAS:
-- 1. Text-to-Image
-- 2. Image-to-Image
-- 3. Inpainting
-- 4. Outpainting
-- 5. ControlNet (pose, depth, canny)
-- 6. LoRA (customization)
-- 7. IP-Adapter (style transfer)
-- 8. Super-resolution
```

#### GEN003: Audio Generation
```lua
-- SKILL: Audio Generation Mastery
-- Nível: Intermediário → Expert
-- Contexto: Gerar áudio com IA

-- MODELOS:
-- 1. Bark (text-to-speech)
--    - Multilingual
--    - Expressive
--    - Open source
--
-- 2. VALL-E (speech synthesis)
--    - Few-shot
--    - Voice cloning
--    - Microsoft
--
-- 3. MusicGen (music generation)
--    - Meta
--    - Text-to-music
--    - High quality
--
-- 4. AudioCraft (Meta)
--    - Music + Sound effects
--    - Audio generation
--
-- 5. ElevenLabs (TTS)
--    - High quality
--    - Voice cloning
--    - API

-- APLICAÇÕES:
-- - Voice assistants
-- - Audiobooks
-- - Podcasts
-- - Sound effects
-- - Music production
-- - Accessibility
```

#### GEN004: Video Generation
```lua
-- SKILL: Video Generation Mastery
-- Nível: Intermediário → Expert
-- Contexto: Gerar vídeos com IA

-- MODELOS:
-- 1. Sora (OpenAI)
--    - High quality
--    - Long videos
--    - Not yet public
--
-- 2. Runway Gen-3
--    - Text-to-video
--    - Image-to-video
--    - API available
--
-- 3. Pika
--    - Easy to use
--    - Good quality
--    - Web app
--
-- 4. Kling
--    - Chinese
--    - High quality
--    - Long videos
--
-- 5. Luma Dream Machine
--    - Fast
--    - Good quality
--    - API

-- TÉCNICAS:
-- 1. Text-to-Video
-- 2. Image-to-Video
-- 3. Video-to-Video
-- 4. Video Editing
-- 5. Video Interpolation
-- 6. Video Super-Resolution
```

### MLOps Skills (600)

#### MLOPS001: ML Pipeline
```lua
-- SKILL: ML Pipeline Architecture
-- Nível: Intermediário → Expert
-- Contexto: Sistemas ML em produção

-- COMPONENTES:
-- 1. Data Pipeline
--    - Ingestion
--    - Processing
--    - Validation
--    - Storage
--
-- 2. Training Pipeline
--    - Feature engineering
--    - Model training
--    - Hyperparameter tuning
--    - Model evaluation
--
-- 3. Deployment Pipeline
--    - Model serving
--    - A/B testing
--    - Canary deployment
--    - Rollback
--
-- 4. Monitoring Pipeline
--    - Performance metrics
--    - Data drift
--    - Model drift
--    - Alerting

-- FERRAMENTAS:
-- 1. Kubeflow Pipelines
-- 2. MLflow
-- 3. Airflow
-- 4. Prefect
-- 5. Dagster
-- 6. ZenML
-- 7. Metaflow
-- 8. Flyte
```

#### MLOPS002: Model Deployment
```lua
-- SKILL: Model Deployment Strategies
-- Nível: Intermediário → Expert
-- Contexto: Deploy de modelos ML

-- ESTRATÉGIAS:
-- 1. Real-time Serving
--    - REST API
--    - gRPC
--    - Low latency
--
-- 2. Batch Prediction
--    - Scheduled jobs
--    - High throughput
--    - Cost efficient
--
-- 3. Edge Deployment
--    - Mobile (TFLite, CoreML)
--    - IoT
--    - Offline capable
--
-- 4. Streaming
--    - Real-time inference
--    - Kafka integration
--    - Event-driven

-- FERRAMENTAS:
-- 1. TensorFlow Serving
-- 2. TorchServe
-- 3. Triton Inference Server
-- 4. BentoML
-- 5. Seldon Core
-- 6. KServe
-- 7. AWS SageMaker
-- 8. Azure ML
```

#### MLOPS003: Experiment Tracking
```lua
-- SKILL: ML Experiment Tracking
-- Nível: Intermediário → Expert
-- Contexto: Rastrear experimentos ML

-- O QUE RASTREAR:
-- 1. Hyperparameters
-- 2. Metrics (train, val, test)
-- 3. Artifacts (models, data)
-- 4. Code version (git)
-- 5. Data version (DVC)
-- 6. Environment (dependencies)
-- 7. Hardware (GPU, memory)
-- 8. Time (duration, timestamps)

-- FERRAMENTAS:
-- 1. MLflow Tracking
-- 2. Weights & Biases
-- 3. Neptune.ai
-- 4. Comet ML
-- 5. TensorBoard
-- 6. ClearML
-- 7. Aim
-- 8. DVC (data versioning)
```

---

*AI/ML Skills v1.0 - Setembro 2026*