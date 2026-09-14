# 📚 Documentação Completa: Skills de AI e Machine Learning

**Data de Geração:** 13/09/2026  
**Total de Skills Documentadas:** 153  
**Fonte:** Sistema de Skills do OpenCode

---

## 📋 Índice

1. [AI Agents (20 skills)](#1-ai-agents)
2. [AI Geral (1 skill)](#2-ai-geral)
3. [AI/ML (129 skills)](#3-aiml)
4. [AI Research (1 skill)](#4-ai-research)
5. [AI Testing (1 skill)](#5-ai-testing)
6. [MLOps (1 skill)](#6-mlops)

---

## 1. AI Agents

**Categoria:** ai-agents-category-pointer  
**Vault:** `C:/Users/Alendaviva007/.config/opencode/skill-libraries/ai-agents`

### 1.1 agent-evaluation
- **Descrição:** Avalia comportamento de agentes com casos versionados e verificadores explícitos
- **Quando usar:** Comparar mudanças em agentes/prompts, reproduzir falhas, rodar testes de regressão
- **Exemplo:** Criar suite de testes para validar se um agente de atendimento responde corretamente a 50 cenários padrão

### 1.2 agent-manager-skill
- **Descrição:** Gerencia múltiplos agentes CLI locais via sessões tmux (iniciar/parar/monitorar/atribuir)
- **Quando usar:** Orquestrar vários agentes rodando simultaneamente, agendamento com cron
- **Exemplo:** Gerenciar 5 agentes de processamento de dados em paralelo, cada um tratando uma fonte diferente

### 1.3 ai-agents-architect
- **Descrição:** Expert em projetar e construir agentes autônomos de IA. Domina uso de ferramentas, sistemas de memória, estratégias de planejamento e orquestração multi-agente
- **Quando usar:** Projetar arquiteturas de agentes complexos, definir fluxos de memória e planejamento
- **Exemplo:** Projetar um agente de pesquisa que usa memória de longo prazo para acumular conhecimento

### 1.4 dispatching-parallel-agents
- **Descrição:** Despacha tarefas independentes para múltiplos agentes em paralelo
- **Quando usar:** 2+ tarefas independentes que podem ser executadas sem estado compartilhado
- **Exemplo:** Processar 10 documentos diferentes simultaneamente com agentes especializados em cada tipo

### 1.5 hosted-agents
- **Descrição:** Constrói agentes em background em ambientes sandboxed
- **Quando usar:** Agentes de codificação hospedados, VMs sandboxed, ambientes remotos
- **Exemplo:** Criar um agente que roda em container Docker para processar código de forma isolada

### 1.6 hosted-agents-v2-py
- **Descrição:** Agentes hospedados usando Azure AI Projects SDK com ImageBasedHostedAgentDefinition
- **Quando usar:** Criar agentes baseados em container no Azure AI Foundry
- **Exemplo:** Deploy de agente de processamento de imagens no Azure com GPU dedicada

### 1.7 lambda-lang
- **Descrição:** Linguagem nativa agent-to-agent para mensagens compactas multi-agente
- **Quando usar:** Comunicação eficiente entre agentes com vocabulário de 340+ átomos em 7 domínios
- **Exemplo:** Dois agentes coordenando tarefas usando mensagens 3x menores que linguagem natural

### 1.8 langgraph
- **Descrição:** Framework production-grade para aplicações AI multi-actor com estado
- **Quando usar:** Construção de grafos de estado, ciclos, branches, persistência, human-in-the-loop
- **Exemplo:** Criar um workflow de aprovação humana onde o agente pausa等待等待等待输入

### 1.9 llm-council
- **Descrição:** Conselhos de modelos open-weight hospedados no Fireworks que comparam respostas
- **Quando usar:** Comparação de múltiplos modelos para uma mesma pergunta, síntese de respostas
- **Exemplo:** Enviar a mesma pergunta para 3 modelos diferentes e gerar uma resposta consolidada

### 1.10 loop-library
- **Descrição:** Biblioteca de loops de feedback delimitados para agentes AI com verificações explícitas
- **Quando usar:** Criar ciclos de melhoria contínua com regras de parada e guardrails
- **Exemplo:** Loop que melhora prompts automaticamente até atingir qualidade satisfatória

### 1.11 m365-agents-dotnet
- **Descrição:** Microsoft 365 Agents SDK para .NET - agentes multichannel para Teams/M365
- **Quando usar:** Construir agentes para ambiente corporativo Microsoft
- **Exemplo:** Bot de helpdesk que integra com Teams e SharePoint

### 1.12 m365-agents-ts
- **Descrição:** Microsoft 365 Agents SDK para TypeScript/Node.js
- **Quando usar:** Agentes Microsoft 365 em ecossistema JavaScript
- **Exemplo:** Assistente de produtividade para Outlook com interface web

### 1.13 mcp-builder
- **Descrição:** Cria servidores MCP (Model Context Protocol) para LLMs interagirem com serviços externos
- **Quando usar:** Integrar LLMs com APIs externas, criar ferramentas personalizadas
- **Exemplo:** Criar servidor MCP que permite ao Claude acessar banco de dados PostgreSQL

### 1.14 mcp-builder-ms
- **Descrição:** Construção de servidores MCP para integrar APIs externas (Python FastMCP ou Node/TypeScript)
- **Quando usar:** Criação de ferramentas MCP em qualquer linguagem suportada
- **Exemplo:** Wrapper MCP para API do Mercado Pago que permite ao agente processar pagamentos

### 1.15 multi-advisor
- **Descrição:** Conselho de especialistas - consulta múltiplos agentes em paralelo para análise multi-perspectiva
- **Quando usar:** Análise que requer visões de diferentes especialistas simultaneamente
- **Exemplo:** Analisar uma arquitetura de software com opiniões de segurança, performance e UX

### 1.16 multi-agent-patterns
- **Descrição:** Padrões de sistemas multi-agente (supervisor, swarm, coordenação)
- **Quando usar:** Projetar sistemas com múltiplos agentes coordenados
- **Exemplo:** Implementar padrão supervisor onde um agente delega tarefas para sub-agentes

### 1.17 open-dynamic-workflows
- **Descrição:** Planeja, orquestra e verifica adversarialmente agentes de codificação paralelos
- **Quando usar:** Workflows dinâmicos com verificação de qualidade entre agentes
- **Exemplo:** 3 agentes编写代码并相互审查，确保质量

### 1.18 parallel-agents
- **Descrição:** Padrões de orquestração multi-agente para tarefas independentes
- **Quando usar:** Múltiplas perspectivas ou expertise de domínios diferentes
- **Exemplo:** Análise completa de um repositório com agentes de frontend, backend e DevOps

### 1.19 pilot-protocol
- **Descrição:** Dá ao agente AI endereço de rede permanente, mensagens P2P criptografadas e app store
- **Quando usar:** Agentes que precisam de identidade de rede e comunicação segura
- **Exemplo:** Agente que recebe tarefas via mensagem criptografada e distribui apps

### 1.20 pydantic-ai
- **Descrição:** Agentes AI production-ready com PydanticAI - type-safe, structured outputs, dependency injection
- **Quando usar:** Construção de agentes com tipagem forte e suporte multi-modelo
- **Exemplo:** Agente de processamento de documentos com validação rigorosa de outputs

---

## 2. AI Geral

**Categoria:** ai-category-pointer  
**Vault:** `C:/Users/Alendaviva007/.config/opencode/skill-libraries/ai`

### 2.1 weaviate-cookbooks
- **Descrição:** Construção de apps AI com Weaviate usando cookbooks oficiais para RAG, agentic RAG, exploração de dados
- **Quando usar:** Criar sistemas RAG com Weaviate, busca multimodal, frontends de dados
- **Exemplo:** Sistema de busca semântica em documentos PDF com interface Gradio

---

## 3. AI/ML

**Categoria:** ai-ml-category-pointer  
**Vault:** `C:/Users/Alendaviva007/.config/opencode/skill-libraries/ai-ml`  
**Total: 129 skills**

### 3.1 Evaluation & Testing

#### 3.1.1 advanced-evaluation
- **Descrição:** LLM-as-judge, comparação de outputs, rubricas de avaliação, mitigação de viés
- **Quando usar:** Avaliação automatizada de qualidade de respostas LLM
- **Exemplo:** Criar pipeline que compara respostas de GPT-4 vs Claude usando rubrica padronizada

#### 3.1.2 evaluation
- **Descrição:** Frameworks de avaliação para sistemas de agentes
- **Quando usar:** Testar performance de agentes sistematicamente
- **Exemplo:** Suite de testes que mede taxa de sucesso de um agente em 100 tarefas

#### 3.1.3 llm-evaluation
- **Descrição:** Estratégias abrangentes de avaliação para aplicações LLM
- **Quando usar:** Métricas automáticas, avaliação humana, A/B testing
- **Exemplo:** Medir qualidade de summarization usando ROUGE e avaliação humana

### 3.2 Agentes & Orquestração

#### 3.2.1 agent-creator
- **Descrição:** Cria subagentes AI personalizados com estrutura de plugins e persona
- **Quando usar:** Criar agentes especializados para tarefas específicas
- **Exemplo:** Criar agente de código que entende apenas Python e tem persona de senior developer

#### 3.2.2 agent-framework-azure-ai-py
- **Descrição:** Agentes persistentes no Azure AI Foundry usando Microsoft Agent Framework Python SDK
- **Quando usar:** Deploy de agentes em cloud Azure com persistência
- **Exemplo:** Agente de atendimento que mantém contexto entre sessões no Azure

#### 3.2.3 agent-memory
- **Descrição:** Sistema de memória híbrida para gerenciamento de conhecimento persistente e pesquisável
- **Quando usar:** Agentes que precisam lembrar informações entre sessões
- **Exemplo:** Agente de suporte que acessa base de conhecimento de problemas anteriores

#### 3.2.4 agent-memory-mcp
- **Descrição:** Memória híbrida via MCP para arquitetura, padrões e decisões
- **Quando usar:** Knowledge management estruturado para agentes
- **Exemplo:** Agente que consulta decisões arquiteturais anteriores antes de propor mudanças

#### 3.2.5 agent-orchestration-improve-agent
- **Descrição:** Melhoria sistemática de agentes existentes via análise de performance e engenharia de prompts
- **Quando usar:** Otimizar agentes que já estão em produção
- **Exemplo:** Analisar logs de um bot e melhorar suas respostas em 30%

#### 3.2.6 agent-orchestration-multi-agent-optimize
- **Descrição:** Otimização de sistemas multi-agente com distribuição de carga consciente de custo
- **Quando usar:** Melhorar throughput e confiabilidade de sistemas multi-agente
- **Exemplo:** Reduzir custo de API em 40% redistribuindo tarefas entre modelos

#### 3.2.7 agent-orchestrator
- **Descrição:** Meta-skill que orquestra todos os agentes do ecossistema com scan automático
- **Quando usar:** Coordenar workflows que usam múltiplas skills
- **Exemplo:** Workflow que usa skills de código, dados e deploy automaticamente

#### 3.2.8 agent-squad
- **Descrição:** Orquestrador principal que coordena um squad especializado de agentes
- **Quando usar:** Sistemas com equipe de agentes especializados
- **Exemplo:** Squad com agentes de frontend, backend, QA e DevOps trabalhando juntos

#### 3.2.9 agent-tool-builder
- **Descrição:** Design de ferramentas para agentes AI interagirem com o mundo
- **Quando usar:** Criar ferramentas que agentes podem usar de forma eficaz
- **Exemplo:** API REST bem documentada que o agente pode chamar para buscar dados

#### 3.2.10 agentfolio
- **Descrição:** Descoberta e pesquisa de agentes AI autônomos usando diretório AgentFolio
- **Quando usar:** Encontrar agentes prontos para necessidades específicas
- **Exemplo:** Buscar agente de tradução no diretório e integrar ao projeto

#### 3.2.11 agentic-actions-auditor
- **Descrição:** Auditoria de workflows GitHub Actions para vulnerabilidades em integrações de agentes AI
- **Quando usar:** Verificar segurança de pipelines CI/CD com agentes
- **Exemplo:** Auditar repositório que usa Claude Code Action para detectar vetores de ataque

#### 3.2.12 agentmail
- **Descrição:** Infraestrutura de email para agentes AI via AgentMail API
- **Quando usar:** Agentes que precisam enviar/receber emails programaticamente
- **Exemplo:** Agente que monitora inbox e responde automaticamente

#### 3.2.13 agentphone
- **Descrição:** Agentes telefônicos AI com AgentPhone API (chamadas, SMS, voicemail)
- **Quando usar:** Criar agentes de voz,IVR,SMS automation
- **Exemplo:** Assistente virtual que faz ligação de confirmação de agendamento

#### 3.2.14 agents-v2-py
- **Descrição:** Agentes baseados em container com Azure AI Projects SDK
- **Quando usar:** Hosted agents com imagens customizadas no Azure
- **Exemplo:** Agente de processamento de vídeo com GPU containerizado

#### 3.2.15 autonomous-agent-patterns
- **Descrição:** Padrões de design para agentes de codificação autônomos (inspirado em Cline e Codex)
- **Quando usar:** Construir agentes que decompoem objetivos e executam sozinhos
- **Exemplo:** Agente que recebe "crie uma API REST" e implementa tudo automaticamente

#### 3.2.16 autonomous-agents
- **Descrição:** Agentes que decompõem objetivos, planejam ações, executam e auto-corrigem
- **Quando usar:** Sistemas que precisam de pouca supervisão humana
- **Exemplo:** Agente de deploy que detecta erros e faz rollback automaticamente

#### 3.2.17 context-agent
- **Descrição:** Agente de contexto para continuidade entre sessões
- **Quando usar:** Manter resumos, decisões e tarefas pendentes entre sessões
- **Exemplo:** Assistente que carrega automaticamente o briefing do projeto ao iniciar

#### 3.2.18 infinite-gratitude
- **Descrição:** Skill de pesquisa multi-agente para execução paralela (10 agentes)
- **Quando usar:** Pesquisas complexas que benefit de múltiplas perspectivas simultâneas
- **Exemplo:** Pesquisar 10 tópicos diferentes sobre um mercado e consolidar resultados

#### 3.2.19 multi-agent-architect
- **Descrição:** Design e otimização de sistemas multi-agente production-grade com LangGraph
- **Quando usar:** Workflows AI complexos que requerem múltiplos agentes
- **Exemplo:** Sistema de aprovação com agente de análise, aprovação e auditoria

#### 3.2.20 multi-agent-brainstorming
- **Descrição:** Simula peer review estruturado usando múltiplos agentes especializados
- **Quando usar:** Validação de designs antes da implementação
- **Exemplo:** 3 agentes revisam uma arquitetura e identificam pontos cegos

#### 3.2.21 odw
- **Descrição:** Workflows dinâmicos multi-agente com verificação adversarial via daemon local
- **Quando usar:** Tarefas que benefit de agentes paralelos com verificação cruzada
- **Exemplo:** Refatoração de código onde múltiplos agentes editam e verificam uns aos outros

### 3.3 Engenharia de Contexto

#### 3.3.1 context-compression
- **Descrição:** Compressão de histórico de conversas para reduzir consumo de tokens
- **Quando usar:** Sessões longas que geram milhões de tokens
- **Exemplo:** Comprimir 100K tokens de conversa para 10K sem perder informação crítica

#### 3.3.2 context-degradation
- **Descrição:** Padrões de degradação de LLMs com aumento do tamanho do contexto
- **Quando usar:** Diagnosticar falhas relacionadas a contexto longo
- **Exemplo:** Identificar por que um agente falha em tarefas complexas com contexto extenso

#### 3.3.3 context-driven-development
- **Descrição:** Contexto como artefato gerenciado ao lado do código
- **Quando usar:** Documentação estruturada para interações AI consistentes
- **Exemplo:** Manter CLAUDE.md atualizado com regras do projeto

#### 3.3.4 context-engineering
- **Descrição:** Otimiza configuração de contexto para agentes
- **Quando usar:** Iniciar nova sessão, qualidade de output degradada, trocar de tarefa
- **Exemplo:** Configurar regras e contexto para projeto de e-commerce

#### 3.3.5 context-fundamentals
- **Descrição:** Estado completo disponível para LLM em inferência (instruções, tools, docs, histórico)
- **Quando usar:** Entender o que compõe o contexto de um LLM
- **Exemplo:** Mapear todos os componentes que influenciam a resposta de um agente

#### 3.3.6 context-guardian
- **Descrição:** Guardião que preserva dados críticos antes de compactação automática
- **Quando usar:** Garantir zero perda de informação em compressão
- **Exemplo:** Snapshot de dados críticos antes de resumir conversa longa

#### 3.3.7 context-management-context-restore
- **Descrição:** Restauração de contexto salvo
- **Quando usar:** Recuperar contexto de sessões anteriores
- **Exemplo:** Restaurar estado do projeto após reinício do agente

#### 3.3.8 context-management-context-save
- **Descrição:** Salvamento de contexto para persistência
- **Quando usar:** Preservar estado entre sessões
- **Exemplo:** Salvar progresso de uma tarefa complexa de refatoração

#### 3.3.9 context-manager
- **Descrição:** Engenheiro elite em context engineering com bancos vetoriais e knowledge graphs
- **Quando usar:** Gerenciamento dinâmico de contexto em escala
- **Exemplo:** Sistema que busca contexto relevante automaticamente de knowledge graph

#### 3.3.10 context-optimization
- **Descrição:** Otimização de capacidade de contexto via compressão, mascaramento, cache e particionamento
- **Quando usar:** Melhorar uso de janelas de contexto limitadas
- **Exemplo:** Estratégia de cache que reduz chamadas à API em 60%

### 3.4 Frameworks & Ferramentas

#### 3.4.1 langchain-architecture
- **Descrição:** Framework LangChain para aplicações LLM sofisticadas com agents, chains, memory
- **Quando usar:** Construção de aplicações LLM com componentes modulares
- **Exemplo:** Chain que combina busca + resumo + tradução em pipeline

#### 3.4.2 llm-application-dev-langchain-agent
- **Descrição:** Desenvolvimento de agentes LangChain production-grade com LangGraph
- **Quando usar:** Sistemas AI em produção usando LangChain 0.1+
- **Exemplo:** Agente de customer support com tools de busca e CRM

#### 3.4.3 llm-application-dev-ai-assistant
- **Descrição:** Expert em interfaces conversacionais e aplicações AI
- **Quando usar:** Criar chatbots e assistentes inteligentes
- **Exemplo:** Assistente de código que entende contexto do projeto

#### 3.4.4 llm-application-dev-prompt-optimize
- **Descrição:** Engenharia de prompts avançada com constitutional AI e chain-of-thought
- **Quando usar:** Otimizar prompts para máxima performance
- **Exemplo:** Refinar prompt de classificação de 70% para 95% de acurácia

#### 3.4.5 llm-ops
- **Descrição:** LLM Operations - RAG, embeddings, fine-tuning, custos, evals, arquiteturas de IA para produção
- **Quando usar:** Operacionalizar aplicações LLM em escala
- **Exemplo:** Setup completo de pipeline RAG com monitoring de custos

#### 3.4.6 llm-prompt-optimizer
- **Descrição:** Técnicas comprovadas de engenharia de prompts para melhorar qualidade e reduzir alucinações
- **Quando usar:** Melhorar prompts existentes para qualquer LLM
- **Exemplo:** Otimizar prompt de geração de código para reduzir erros em 50%

#### 3.4.7 llm-structured-output
- **Descrição:** Output estruturado (JSON, enums, objetos tipados) via response_format e tool_use
- **Quando usar:** Obter respostas parseáveis de LLMs
- **Exemplo:** Extrair dados de produto em formato JSON validado

#### 3.4.8 prompt-caching
- **Descrição:** Estratégias de cache para prompts LLM incluindo Anthropic prompt caching e CAG
- **Quando usar:** Reduzir custos e latência de chamadas repetidas
- **Exemplo:** Cache de system prompt que reduz custo em 90% para queries similares

#### 3.4.9 prompt-engineering
- **Descrição:** Guia expert de padrões e otimização de prompts
- **Quando usar:** Melhorar prompts, aprender estratégias, debugar comportamento
- **Exemplo:** Aplicar few-shot prompting para classificação de sentimentos

#### 3.4.10 prompt-engineering-patterns
- **Descrição:** Técnicas avançadas de engenharia de prompts para maximizar performance
- **Quando usar:** Maximizar confiabilidade e controle de LLMs
- **Exemplo:** Usar chain-of-thought para problemas de raciocínio complexo

#### 3.4.11 routerbase-model-gateway
- **Descrição:** Integração RouterBase como gateway de modelos compatível com OpenAI
- **Quando usar:** Roteamento inteligente entre GPT, Claude, Gemini, áudio e embeddings
- **Exemplo:** Gateway que roteia automaticamente para o modelo mais barato

#### 3.4.12 unified-ai-gateway
- **Descrição:** Sistema AI unificado com 9 tools MCP governados
- **Quando usar:** Gateway centralizado para múltiplos providers de IA
- **Exemplo:** Sistema que gerencia acesso a OpenAI, Anthropic e Google com controle de acesso

#### 3.4.13 sandbase-mcp
- **Descrição:** Descobre e invoca 2000+ modelos e APIs via SandBase MCP bridge
- **Quando usar:** Acesso a grande variedade de modelos com verificação de custo
- **Exemplo:** Testar 5 modelos diferentes para uma tarefa comparando custo/benefício

### 3.5 ML Engineering

#### 3.5.1 ml-engineer
- **Descrição:** Sistemas ML production com PyTorch 2.x, TensorFlow, model serving, feature engineering
- **Quando usar:** Construção de pipelines ML completos
- **Exemplo:** Deploy de modelo de classificação com A/B testing e monitoring

#### 3.5.2 mlops-engineer
- **Descrição:** Pipelines ML, experiment tracking e model registries com MLflow e Kubeflow
- **Quando usar:** Operacionalizar ciclo de vida completo de modelos
- **Exemplo:** Pipeline automatizado de treinamento → validação → deploy

#### 3.5.3 scikit-learn
- **Descrição:** Machine learning em Python com scikit-learn para classificação, regressão, clustering
- **Quando usar:** Tarefas clássicas de ML supervisionado e não-supervisionado
- **Exemplo:** Modelo de classificação de churn usando Random Forest

#### 3.5.4 train-sentence-transformers
- **Descrição:** Treinamento/fine-tuning de SentenceTransformer, CrossEncoder e SparseEncoder
- **Quando usar:** Modelos de embedding para retrieval, similaridade, clustering
- **Exemplo:** Fine-tune modelo de embeddings para busca semântica em português

#### 3.5.5 trl-training
- **Descrição:** Treinamento de modelos de linguagem com TRL (SFT, DPO, GRPO, KTO, RLOO)
- **Quando usar:** Fine-tuning de LLMs com técnicas de alinhamento
- **Exemplo:** Fine-tune Llama para dominar linguagem técnica de medicina

#### 3.5.6 unsloth-finetuning
- **Descrição:** Fine-tuning de LLMs com Unsloth em GPU consumer: LoRA/QLoRA, GRPO/DPO, GGUF export
- **Quando usar:** Treinar modelos localmente com hardware limitado
- **Exemplo:** Fine-tune modelo 7B em GPU RTX 3090 com 24GB VRAM

#### 3.5.7 hybrid-search-implementation
- **Descrição:** Combinação de busca vetorial e keyword para retrieval melhorado
- **Quando usar:** Sistemas RAG onde uma abordagem isolada não basta
- **Exemplo:** Busca em catálogo de produtos usando similaridade semântica + filtros textuais

### 3.6 Hugging Face Ecosystem

#### 3.6.1 hugging-face-cli
- **Descrição:** CLI do Hugging Face Hub para gerenciar modelos, datasets, spaces
- **Quando usar:** Download, upload e gerenciamento de assets no HF Hub
- **Exemplo:** Baixar modelo quantizado e fazer upload de dataset processado

#### 3.6.2 hugging-face-community-evals
- **Descrição:** Executa evaluations usando inspect-ai e lighteval em hardware local
- **Quando usar:** Avaliação local de modelos com GPU
- **Exemplo:** Rodar benchmark MMLU em modelo local para comparar performance

#### 3.6.3 hugging-face-dataset-viewer
- **Descrição:** Visualizador de datasets do Hugging Face
- **Quando usar:** Explorar e inspecionar datasets antes de usar
- **Exemplo:** Verificar qualidade e distribuição de dados em dataset de treinamento

#### 3.6.4 hugging-face-datasets
- **Descrição:** Criação e gerenciamento de datasets no HF Hub com streaming e SQL
- **Quando usar:** Criar, transformar e compartilhar datasets
- **Exemplo:** Criar dataset de pares de tradução PT→EN com 1M de exemplos

#### 3.6.5 hugging-face-evaluation
- **Descrição:** Gerencia resultados de avaliação em model cards do HF
- **Quando usar:** Adicionar métricas de avaliação documentadas
- **Exemplo:** Adicionar scores de HumanEval e MMLU ao model card

#### 3.6.6 hugging-face-gradio
- **Descrição:** Construção de UIs web Gradio em Python
- **Quando usar:** Criar demos e interfaces para modelos
- **Exemplo:** Interface de chat para modelo fine-tune com upload de imagens

#### 3.6.7 hugging-face-jobs
- **Descrição:** Execução de workloads no HF Jobs com GPUs gerenciadas
- **Quando usar:** Treinar modelos em hardware dedicado sem configurar infra
- **Exemplo:** Rodar fine-tuning de modelo 13B em A100 por 4 horas

#### 3.6.8 hugging-face-model-trainer
- **Descrição:** Treinamento/fine-tuning com TRL ou Unsloth via HF Jobs
- **Quando usar:** Treinar modelos com SFT, DPO, GRPO e converter para GGUF
- **Exemplo:** Fine-tune modelo para domínio jurídico e exportar para llama.cpp

#### 3.6.9 hugging-face-paper-publisher
- **Descrição:** Publicação e gerenciamento de papers de pesquisa no HF Hub
- **Quando usar:** Compartilhar resultados de pesquisa
- **Exemplo:** Publicar paper sobre nova técnica de fine-tuning com modelos linkados

#### 3.6.10 hugging-face-papers
- **Descrição:** Busca e leitura de papers do HF com metadados estruturados
- **Quando usar:** Acessar pesquisa最新 sobre modelos
- **Exemplo:** Encontrar paper sobre técnica nova de RLHF e seus modelos associados

#### 3.6.11 hugging-face-tool-builder
- **Descrição:** Criação de scripts CLI reutilizáveis para API do Hugging Face
- **Quando usar:** Automatizar tarefas repetitivas no HF
- **Exemplo:** Script que baixa modelo, processa dados e faz upload automaticamente

#### 3.6.12 hugging-face-trackio
- **Descrição:** Tracking e visualização de experimentos ML com Trackio
- **Quando usar:** Logar métricas durante treinamento e analisar depois
- **Exemplo:** Comparar 5 runs de fine-tuning e selecionar o melhor checkpoint

#### 3.6.13 hugging-face-vision-trainer
- **Descrição:** Treino de detecção de objetos, classificação e segmentação (SAM/SAM2)
- **Quando usar:** Modelos de visão computacional com validação de dataset
- **Exemplo:** Treinar modelo YOLO para detectar produtos em imagens

#### 3.6.14 huggingface-best
- **Descrição:** Encontra o melhor modelo para uma tarefa específica
- **Quando usar:** Escolher modelo por benchmark scores
- **Exemplo:** Descobrir qual modelo de tradução PT→EN tem melhor BLEU score

#### 3.6.15 huggingface-local-models
- **Descrição:** Seleciona modelos para rodar localmente com llama.cpp e GGUF
- **Quando usar:** Rodar modelos em CPU, Mac Metal, CUDA ou ROCm
- **Exemplo:** Configurar servidor local com modelo 7B quantizado para uso offline

#### 3.6.16 huggingface-spaces
- **Descrição:** Deploy e manutenção de aplicações em HF Spaces
- **Quando usar:** Publicar demos com Gradio/Docker/Static SDKs
- **Exemplo:** Deploy de app de classificação de imagens com ZeroGPU

#### 3.6.17 huggingface-zerogpu
- **Descrição:** Demos AI e compute GPU com Gradio Spaces ZeroGPU
- **Quando usar:** Acesso temporário a GPU sem configurar infra
- **Exemplo:** Demo de geração de imagens com acesso free a GPU

#### 3.6.18 hf-mcp
- **Descrição:** Hugging Face Hub via MCP server tools - busca de modelos, datasets, papers
- **Quando usar:** Integração HF com agentes via MCP
- **Exemplo:** Agente que busca modelos automaticamente baseado em requisitos

#### 3.6.19 hf-mem
- **Descrição:** Estimativa de memória para carregar pesos Safetensors ou GGUF
- **Quando usar:** Verificar se modelo cabe na GPU antes de baixar
- **Exemplo:** Calcular se modelo 13B cabe em GPU com 24GB VRAM

### 3.7 Segurança & Auditoria

#### 3.7.1 llm-security
- **Descrição:** Assessment de segurança autorizado de aplicações LLM e agentes AI
- **Quando usar:** Testar resistência a prompt injection, tool abuse, RAG exposure
- **Exemplo:** Auditoria de agente de atendimento contra ataques de prompt injection

### 3.8 Persona & Simulação

#### 3.8.1 ilya-sutskever
- **Descrição:** Agente que simula Ilya Sutskever (co-fundador OpenAI, ex-Chief Scientist)
- **Quando usar:** Perspectivas sobre AGI safety, scaling laws, deep learning
- **Exemplo:** Consultar visão sobre superinteligência segura

#### 3.8.2 sam-altman
- **Descrição:** Agente que simula Sam Altman (CEO OpenAI, ex-presidente Y Combinator)
- **Quando usar:** Perspectivas sobre era AGI e estratégia de empresas AI
- **Exemplo:** Debater roadmap de desenvolvimento de AGI

#### 3.8.3 yann-lecun
- **Descrição:** Agente que simula Yann LeCun (inventor CNNs, Chief AI Scientist Meta)
- **Quando usar:** Perspectivas sobre deep learning, visão computacional
- **Exemplo:** Consultar opinião sobre arquiteturas de modelos de visão

#### 3.8.4 yann-lecun-debate
- **Descrição:** Sub-skill de debates e posições técnicas de Yann LeCun
- **Quando usar:** Críticas a LLMs, rivalidades intelectuais, posição sobre risco existencial
- **Exemplo:** Debater se LLMs são o caminho certo para AGI

#### 3.8.5 yann-lecun-filosofia
- **Descrição:** Sub-skill filosófica e pedagógica de Yann LeCun
- **Quando usar:** Explicações didáticas sobre conceitos fundamentais
- **Exemplo:** Explicar por que self-supervised learning é importante

#### 3.8.6 yann-lecun-tecnico
- **Descrição:** Sub-skill técnica de Yann LeCun (CNNs, JEPA, Self-Supervised Learning, EBMs)
- **Quando usar:** Implementar técnicas específicas como I-JEPA, V-JEPA, SimCLR, MAE
- **Exemplo:** Código PyTorch completo para implementar JEPA

### 3.9 Produtos & Negócios AI

#### 3.9.1 ai-product
- **Descrição:** Construção de produtos AI-powered para produção, não demos
- **Quando usar:** Garantir que produto AI funcione em escala real
- **Exemplo:** Arquitetar sistema de recomendação para 1M de usuários

#### 3.9.2 ai-seo
- **Descrição:** Otimização para AI search e citações LLM (AI Overviews, ChatGPT, Perplexity)
- **Quando usar:** Melhorar visibilidade em buscas AI
- **Exemplo:** Otimizar site para aparecer em respostas do ChatGPT

#### 3.9.3 ai-wrapper-product
- **Descrição:** Construção de produtos que wrapping APIs AI em ferramentas focadas
- **Quando usar:** Criar SaaS que resolve problemas específicos com AI
- **Exemplo:** Ferramenta de geração de contratos jurídicos usando Claude API

#### 3.9.4 ai-studio-image
- **Descrição:** Geração de imagens humanizadas via Google AI Studio (Gemini)
- **Quando usar:** Fotos realistas estilo influencer ou educacional
- **Exemplo:** Gerar imagem de produto com iluminação natural para catálogo

#### 3.9.5 brave-man
- **Descrição:** Entrevista estruturada para novos projetos antes de construir
- **Quando usar:** Evitar erros caros em escopo de projeto
- **Exemplo:** Gerar prompt.md completo antes de iniciar desenvolvimento

#### 3.9.6 computer-use-agents
- **Descrição:** Agentes AI que interagem com computadores como humanos (visão, cursor, clique)
- **Quando usar:** Automação de tarefas desktop via AI
- **Exemplo:** Agente que preenche formulários web automaticamente

#### 3.9.7 computer-vision-expert
- **Descrição:** Expert em Computer Vision 2026 (YOLO26, SAM 3, VLMs)
- **Quando usar:** Detecção, segmentação, análise espacial em tempo real
- **Exemplo:** Sistema de qualidade industrial usando visão computacional

#### 3.9.8 voice-agents
- **Descrição:** Agentes de voz - interação natural humano-AI via fala
- **Quando usar:** Interfaces de voz, IVR inteligente
- **Exemplo:** Assistente de driving que responde comandos de voz

#### 3.9.9 voice-ai-engine-development
- **Descrição:** Motores de conversação AI voice com streaming, TTS e interrupt handling
- **Quando usar:** Construção de engines de voz real-time
- **Exemplo:** Sistema de atendimento telefônico com transcrição ao vivo

#### 3.9.10 aomi-transact
- **Descrição:** Agentes de crypto/DeFi natural-language para EVM chains
- **Quando usar:** Transações blockchain via linguagem natural
- **Exemplo:** "Swap 1 ETH por USDC no Uniswap" executado automaticamente

#### 3.9.11 fal-generate / fal-image-edit / fal-platform / fal-upscale / fal-workflow
- **Descrição:** Suite completa de geração/edição de imagens e vídeos via fal.ai
- **Quando usar:** Geração, edição, upscale e workflows de mídia AI
- **Exemplo:** Gerar thumbnails de produto e melhorar resolução automaticamente

### 3.10 Claude Específico

#### 3.10.1 claude-api
- **Descrição:** Construção de apps com Claude API ou Anthropic SDK
- **Quando usar:** Código que importa `anthropic` ou usa Agent SDK
- **Exemplo:** Chatbot que usa Claude para análise de documentos

#### 3.10.2 claude-code-expert
- **Descrição:** Expert profundo em Claude Code CLI da Anthropic
- **Quando usar:** Maximizar produtividade com atalhos, hooks, MCPs, configurações
- **Exemplo:** Configurar hooks que rodam linting automaticamente após cada edição

#### 3.10.3 claude-code-guide
- **Descrição:** Referência abrangente para configurar e usar Claude Code
- **Quando usar:** Templates de configuração e padrões avançados
- **Exemplo:** Setup de CLAUDE.md otimizado para projeto monorepo

#### 3.10.4 claude-settings-audit
- **Descrição:** Analisa repositório para gerar permissões recomendadas para settings.json
- **Quando usar:** Configurar novo projeto ou auditar existente
- **Exemplo:** Gerar lista de comandos bash permitidos baseada no tech stack

#### 3.10.5 claude-monitor
- **Descrição:** Monitor de performance do Claude Code e sistema local
- **Quando usar:** Diagnosticar lentidão, medir recursos, verificar latência API
- **Exemplo:** Relatório de saúde do sistema durante sessão de código longa

#### 3.10.6 claude-speed-reader
- **Descrição:** Speed read responses a 600+ WPM com RSVP highlighting
- **Quando usar:** Consumir respostas longas rapidamente
- **Exemplo:** Ler documentação extensa gerada pelo Claude em tempo reduzido

### 3.11 Orquestração & Gestão

#### 3.11.1 app-builder
- **Descrição:** Orquestrador principal de construção de aplicações full-stack
- **Quando usar:** Criar apps completas a partir de linguagem natural
- **Exemplo:** "Crie um blog com autenticação" → projeto completo gerado

#### 3.11.2 manage-skills
- **Descrição:** Gerencia skills AI em 11 ferramentas (Cursor, Claude, Agents, Windsurf, etc.)
- **Quando usar:** Descobrir, criar, editar, alternar, copiar skills
- **Exemplo:** Listar todas as skills ativas no Cursor e Claude Code

#### 3.11.3 project-development
- **Descrição:** Princípios para identificar tarefas adequadas para LLM e iteração rápida
- **Quando usar:** Planejar projetos que benefit de assistência AI
- **Exemplo:** Decompor projeto em tarefas que podem ser delegadas para agentes

#### 3.11.4 tool-design
- **Descrição:** Construção de ferramentas eficazes para agentes com redução arquitetural
- **Quando usar:** Criar, debugar ou otimizar tools para agentes
- **Exemplo:** Reduzir conjunto de 20 tools para 8 essenciais sem perda de funcionalidade

### 3.12 Outros

#### 3.12.1 ai-analyzer
- **Descrição:** Sistema de análise de saúde AI-driven com dados multidimensionais
- **Quando usar:** Análise de padrões, previsão de riscos, recomendações personalizadas
- **Exemplo:** Dashboard de saúde que prevê riscos baseado em histórico médico

#### 3.12.2 ai-md
- **Descrição:** Converte CLAUDE.md escrito por humanos em formato AI-native com labels estruturados
- **Quando usar:** Otimizar documentação para consumo por LLMs
- **Exemplo:** Transformar README em formato que LLMs entendem 3x melhor

#### 3.12.3 ai-native-cli
- **Descrição:** Especificação com 98 regras para CLIs que agentes AI podem usar com segurança
- **Quando usar:** Construir ferramentas CLI amigáveis para agentes
- **Exemplo:** CLI com JSON estruturado, exit codes claros e auto-descrição

#### 3.12.4 claude-ally-health
- **Descrição:** Assistente de saúde para análise de informações médicas e rastreamento
- **Quando usar:** Orientação de saúde, tracking de sintomas
- **Exemplo:** Analisar sintomas e sugerir possíveis causas (não diagnóstico)

#### 3.12.5 claude-d3js-skill
- **Descrição:** Visualizações de dados interativas sophisticated com D3.js
- **Quando usar:** Gráficos e visualizações customizadas
- **Exemplo:** Dashboard interativo com gráficos de vendas animados

#### 3.12.6 claude-in-chrome-troubleshooting
- **Descrição:** Diagnóstico de problemas de conexão da extensão Claude in Chrome
- **Quando usar:** MCP tools falham ou extensão não conecta
- **Exemplo:** Resolver erro "Browser extension is not connected"

#### 3.12.7 claude-scientific-skills
- **Descrição:** Habilidades de pesquisa e análise científica
- **Quando usar:** Análise de dados científicos, revisão de literatura
- **Exemplo:** Analisar resultado de experimento e sugerir próximos passos

#### 3.12.8 claude-win11-speckit-update-skill
- **Descrição:** Gerenciamento de sistema Windows 11
- **Quando usar:** Configuração e manutenção do sistema operacional
- **Exemplo:** Automatizar atualizações e configurações do Windows

#### 3.12.9 context-agent / context-engineering / context-guardian / etc.
- **Descrição:** (Já documentados na seção 3.3)

#### 3.12.10 deep-research
- **Descrição:** Tarefas de pesquisa autônomas que planejam, buscam, leem e sintetizam
- **Quando usar:** Pesquisa profunda que require múltiplas fontes
- **Exemplo:** Relatório completo sobre mercado de AI em saúde

#### 3.12.11 ejentum-reasoning-harness
- **Descrição:** MCP server com 4 modos cognitivos (reasoning, code, anti-deception, memory)
- **Quando usar:** Scaffold cognitivo antes de gerar respostas
- **Exemplo:** Modo anti-deception que detecta tentativas de manipulação

#### 3.12.12 faf-go
- **Descrição:** Entrevista guiada para Gold Code (100% AI-Readiness)
- **Quando usar:** Melhorar arquivo .faf através de perguntas guiadas
- **Exemplo:** Responder perguntas até ter .faf otimizado para Claude Code

#### 3.12.13 hf-mcp / hf-mem / etc.
- **Descrição:** (Já documentados na seção 3.6)

#### 3.12.14 loki-mode
- **Descrição:** PRD to Production sem intervenção humana
- **Quando usar:** Pipeline completo de conceito a deploy automatizado
- **Exemplo:** Do documento de requisitos até deploy em produção

#### 3.12.15 loopy
- **Descrição:** Descobre, compara, audita, adapta e executa loops de feedback para agentes
- **Quando usar:** Criar e gerenciar ciclos de melhoria contínua
- **Exemplo:** Loop que melhora prompts automaticamente até atingir KPI

#### 3.12.16 m365-agents-py
- **Descrição:** Microsoft 365 Agents SDK para Python com aiohttp hosting
- **Quando usar:** Agentes Microsoft 365 em Python
- **Exemplo:** Bot de Teams que responde a comandos slash

#### 3.12.17 mesh-memory
- **Descrição:** Memória semântica self-hosted para agentes via MCP com Postgres + pgvector
- **Quando usar:** Recall de worklogs, decisões e notas por significado
- **Exemplo:** Agente que busca "decisões sobre arquitetura" e encontra notas relevantes

#### 3.12.18 molykit
- **Descrição:** Toolkit de chat AI MolyKit com BotClient, OpenAI, SSE streaming
- **Quando usar:** Chat widgets cross-platform async
- **Exemplo:** Widget de chat em React que usa SSE para streaming

#### 3.12.19 monte-carlo-monitoring-advisor
- **Descrição:** Análise de cobertura de dados e criação de monitores para tabelas e agentes AI
- **Quando usar:** Observabilidade de dados e agentes
- **Exemplo:** Criar alertas quando qualidade de dados cai abaixo de 95%

#### 3.12.20 moyu
- **Descrição:** Guardrail anti-over-engineering que ativa quando agente expande escopo
- **Quando usar:** Evitar abstrações desnecessárias e mudanças não solicitadas
- **Exemplo:** Bloquear adição de framework não pedido pelo usuário

#### 3.12.21 runaway-guard
- **Descrição:** Disciplina de custo para APIs de inferência pagas
- **Quando usar:** Definir limits de custo antes de escrever código que chama APIs
- **Exemplo:** Forçar definição de $-cap diário antes de rodar pipeline LLM

#### 3.12.22 unslop-commit
- **Descrição:** Reescreve commit messages para soar como engenheiro humano
- **Quando usar:** Limpar jargão de marketing/AI de commits
- **Exemplo:** Transformar "comprehensive solution" em "fix login validation"

#### 3.12.23 ui-skills
- **Descrição:** Restrições opinionated para guiar agentes na construção de interfaces
- **Quando usar:** Manter consistência visual em projetos
- **Exemplo:** Aplicar design system automaticamente em componentes

#### 3.12.24 bdistill-knowledge-extraction
- **Descrição:** Extração de conhecimento de domínio estruturado de modelos AI (session ou local via Ollama)
- **Quando usar:** Extrair conhecimento especializado de LLMs sem API key
- **Exemplo:** Extrair regras de negócio de modelo fine-tuned

#### 3.12.25 bdistill-behavioral-xray
- **Descrição:** Raio-X comportamental de qualquer modelo AI (limites, alucinações, estilo)
- **Quando usar:** Entender comportamento de um modelo antes de usar em produção
- **Exemplo:** Mapear limites de refusal do Claude em contexto jurídico

---

## 4. AI Research

**Categoria:** ai-research-category-pointer  
**Vault:** `C:/Users/Alendaviva007/.config/opencode/skill-libraries/ai-research`

### 4.1 bdistill-knowledge-extraction
- **Descrição:** Extração de conhecimento de domínio estruturado de modelos AI em sessão ou via Ollama local
- **Quando usar:** Extrair conhecimento especializado sem necessidade de API key
- **Exemplo:** Extrair regras de diagnóstico médico de um modelo fine-tuned

---

## 5. AI Testing

**Categoria:** ai-testing-category-pointer  
**Vault:** `C:/Users/Alendaviva007/.config/opencode/skill-libraries/ai-testing`

### 5.1 bdistill-behavioral-xray
- **Descrição:** Análise comportamental profunda de qualquer modelo AI - limites de refusal, tendências de alucinação, estilo de raciocínio
- **Quando usar:** Mapear comportamento de um modelo antes de deploy em produção
- **Exemplo:** Testar como o GPT-4 responde a prompts adversariais em contexto bancário

---

## 6. MLOps

**Categoria:** ml-ops-category-pointer  
**Vault:** `C:/Users/Alendaviva007/.config/opencode/skill-libraries/ml-ops`

### 6.1 remote-gpu-trainer
- **Descrição:** Deploy, monitoramento e debug de jobs GPU longos em instâncias remotas/alugadas (AutoDL, RunPod, vast.ai, Lambda, Slurm, K8s)
- **Quando usar:** Treinar modelos em GPUs remotas com segurança de billing e checkpointing
- **Exemplo:** Rodar fine-tuning de modelo 70B em RunPod spot instance com checkpointing automático

---

## 📊 Resumo Estatístico

| Categoria | Total de Skills |
|-----------|-----------------|
| AI Agents | 20 |
| AI Geral | 1 |
| AI/ML | 129 |
| AI Research | 1 |
| AI Testing | 1 |
| MLOps | 1 |
| **TOTAL** | **153** |

### Subcategorias Mais Populares (AI/ML):
- **Agentes & Orquestração:** ~30 skills
- **Hugging Face Ecosystem:** ~20 skills
- **Engenharia de Contexto:** ~10 skills
- **Frameworks & Ferramentas:** ~13 skills
- **ML Engineering:** ~7 skills
- **Persona & Simulação:** ~6 skills
- **Produtos & Negócios AI:** ~12 skills

---

## 🚀 Como Usar Esta Documentação

1. **Identifique a necessidade** → Busque pela subcategoria relevante
2. **Leia a descrição** → Verifique se a skill atende seu caso de uso
3. **Acesse a skill** → Use o caminho do vault para carregar o SKILL.md completo
4. **Aplique o exemplo** → Adapte o exemplo prático ao seu contexto

---

*Documento gerado automaticamente em 13/09/2026*
