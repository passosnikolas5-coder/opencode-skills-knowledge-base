# Catálogo Completo de Skills de Data

> Gerado em: 2026-09-14  
> Fonte: Arquivos SKILL.md dos category-pointers do OpenCode  
> Total de skills documentadas: **69**  
> Categorias: **7**

---

## Índice

1. [Data (22 skills)](#1-data-22-skills)
2. [Data AI (14 skills)](#2-data-ai-14-skills)
3. [Data Science (8 skills)](#3-data-science-8-skills)
4. [Data Engineering (1 skill)](#4-data-engineering-1-skill)
5. [Database (16 skills)](#5-database-16-skills)
6. [Database Processing (6 skills)](#6-database-processing-6-skills)
7. [Databases (2 skills)](#7-databases-2-skills)

---

## 1. Data (22 skills)

> Fonte: `data-category-pointer/SKILL.md`  
> Vault: `C:/Users/Alendaviva007/.config/opencode/skill-libraries/data`

### 1.1 alpha-vantage
- **Descrição:** Acesso a 20+ anos de dados financeiros globais: ações, opções, forex, criptomoedas, commodities, indicadores econômicos e 50+ indicadores técnicos.
- **Quando usar:** Ao trabalhar com dados financeiros históricos, análise técnica de mercado, obter cotações de ações/moedas/commodities, ou construir dashboards financeiros.
- **Exemplo:** Consultar o histórico de preços de uma ação nos últimos 5 anos para treinar um modelo de previsão financeira, ou obter a cotação do dólar em tempo real.

### 1.2 amplitude-automation
- **Descrição:** Automatizar tarefas no Amplitude via Rube MCP (Composio): eventos, atividade de usuários, coortes, identificação de usuários.
- **Quando usar:** Quando precisar integrar e automatizar workflows no Amplitude — criar eventos, analisar coortes de usuários, ou identificar padrões de comportamento.
- **Exemplo:** Criar uma automação que extrai dados de uma coorte de retenção semanal no Amplitude e alimenta um relatório externo.

### 1.3 analytics-product
- **Descrição:** Analytics de produto — PostHog, Mixpanel, eventos, funnels, coortes, retenção, north star metric, OKRs e dashboards de produto.
- **Quando usar:** Para configurar ou analisar métricas de produto como funis de conversão, retenção de usuários, ou definir e acompanhar OKRs de produto.
- **Exemplo:** Configurar um dashboard no PostHog que monitora a taxa de conversão de um funil de onboarding de usuários.

### 1.4 analytics-tracking
- **Descrição:** Projetar, auditar e melhorar sistemas de rastreamento de analytics que produzem dados confiáveis e prontos para decisão.
- **Quando usar:** Quando o tracking de eventos não está confiável, ou precisa projetar do zero um sistema de tracking para um novo produto.
- **Exemplo:** Auditar o tracking de eventos de um e-commerce para identificar eventos ausentes ou duplicados e corrigir o schema.

### 1.5 arrowspace
- **Descrição:** Busca vetorial espectral usando autoestrutura de laplaciano de grafos. Usar quando similaridade coseno/L2 falha em capturar estrutura latente em embeddings.
- **Quando usar:** Quando técnicas tradicionais de similaridade (coseno, L2) não estão capturando relações semânticas profundas nos embeddings.
- **Exemplo:** Melhorar a qualidade de um sistema de busca semântica de documentos usando busca espectral para agrupamentos temáticos latentes.

### 1.6 data-engineer
- **Descrição:** Construir pipelines de dados escaláveis, data warehouses modernos e arquiteturas de streaming em tempo real. Implementa Apache Spark, dbt, Airflow e plataformas de dados nativas da nuvem.
- **Quando usar:** Para projetar ou implementar pipelines de dados em produção, migrar para arquiteturas modernas de dados, ou resolver problemas de performance em ETL.
- **Exemplo:** Projetar um pipeline de streaming com Apache Kafka + Spark para processar eventos de clique em tempo real.

### 1.7 dbt-transformation-patterns
- **Descrição:** Padrões de transformação production-ready para dbt (data build tool): organização de modelos, estratégias de teste, documentação e processamento incremental.
- **Quando usar:** Quando estiver desenvolvendo ou revisando projetos dbt, configurando modelos incrementais, ou definindo estratégias de teste e documentação.
- **Exemplo:** Refatorar um projeto dbt com 200+ models para usar incremental models e adicionar testes de integridade referencial.

### 1.8 firecrawl-scraper
- **Descrição:** Web scraping profundo, capturas de tela, parsing de PDFs e crawling de sites usando a API Firecrawl.
- **Quando usar:** Quando precisar extrair conteúdo de páginas web que requerem interação (cliques, scroll), obter screenshots de páginas, ou fazer parsing de PDFs.
- **Exemplo:** Extrair conteúdo detalhado de páginas de produto de um e-commerce que utiliza JavaScript para renderizar o conteúdo.

### 1.9 mixpanel-automation
- **Descrição:** Automatizar tarefas no Mixpanel via Rube MCP (Composio): eventos, segmentação, funnels, coortes, perfis de usuários, consultas JQL.
- **Quando usar:** Para automatizar consultas e workflows no Mixpanel — extrair dados de funis, segmentar usuários, ou consultar eventos via JQL.
- **Exemplo:** Automatizar a extração semanal de dados de um funnel de purchase do Mixpanel para um relatório executivo.

### 1.10 monte-carlo-monitor-creation
- **Descrição:** Guia para criação de monitores Monte Carlo via ferramentas MCP, produzindo YAML de monitores-as-code para deploy via CI/CD.
- **Quando usar:** Quando precisar criar monitores de qualidade de dados observáveis, ou integrar monitores de dados em pipelines de CI/CD.
- **Exemplo:** Criar um monitor que detecta anomalias em volume de dados de uma tabela critical do data warehouse.

### 1.11 monte-carlo-validation-notebook
- **Descrição:** Gera notebooks SQL de validação para mudanças PR no dbt com queries de comparação antes/depois.
- **Quando usar:** Antes de fazer merge de mudanças em modelos dbt, para validar que a transformação não quebrou dados existentes.
- **Exemplo:** Gerar um notebook que compara os resultados de um modelo dbt antes e depois de uma refatoração, verificando integridade dos dados.

### 1.12 optim-agent
- **Descrição:** Guia de otimização de parâmetros por agente para sistemas configuráveis com objetivos mensuráveis. Usar para HPO, tuning de inferência, simulações, ou experimentos RL/controle.
- **Quando usar:** Quando precisar otimizar hiperparâmetros de um modelo, ajustar configurações de um sistema baseado em métricas mensuráveis.
- **Exemplo:** Otimizar hiperparâmetros de um modelo XGBoost usando Optuna para maximizar a métrica F1 em um dataset de classificação.

### 1.13 postgres-readonly-queries
- **Descrição:** Executar queries SQL read-only seguras contra bancos PostgreSQL com suporte multi-conexão e proteção defensiva contra escrita.
- **Quando usar:** Quando precisar consultar dados em PostgreSQL de forma segura, sem risco de alterar dados, em ambientes de produção ou análise.
- **Exemplo:** Executar uma query analítica complexa contra um banco de produção PostgreSQL para gerar um relatório de vendas, garantindo que nenhuma alteração será feita.

### 1.14 posthog-automation
- **Descrição:** Automatizar tarefas no PostHog via Rube MCP (Composio): eventos, feature flags, projetos, perfis de usuários, anotações.
- **Quando usar:** Para automatizar workflows no PostHog — criar feature flags, gerenciar projetos, ou extrair dados de usuários.
- **Exemplo:** Criar uma feature flag no PostHog automaticamente quando um novo recurso é deployado em staging.

### 1.15 segment-automation
- **Descrição:** Automatizar tarefas no Segment via Rube MCP (Composio): track events, identify users, manage groups, page views, aliases, batch operations.
- **Quando usar:** Para automatizar o tracking de eventos no Segment, gerenciar identidades de usuários, ou processar operações em lote.
- **Exemplo:** Automatizar o envio de eventos de compra do Segment para múltiplos destinos (Amplitude, BigQuery) via uma única integração.

### 1.16 segment-cdp
- **Descrição:** Padrões de expertise para Segment Customer Data Platform incluindo Analytics.js, tracking server-side, tracking plans com Protocols, resolução de identidade, configuração de destinos e boas práticas de governança de dados.
- **Quando usar:** Quando precisar implementar ou otimizar uma infraestrutura completa de CDP com Segment, incluindo tracking server-side e governança de dados.
- **Exemplo:** Configurar um tracking plan no Segment Protocols para validar a qualidade dos eventos antes de serem enviados aos destinos.

### 1.17 spark-optimization
- **Descrição:** Otimizar jobs Apache Spark com particionamento, cache, otimização de shuffle e tuning de memória.
- **Quando usar:** Quando jobs Spark estão lentos, consumindo muita memória, ou precisam escalar para volumes maiores de dados.
- **Exemplo:** Otimizar um job Spark que processa 50GB de dados reduzindo o tempo de execução de 2h para 20min via particionamento correto e cache.

### 1.18 sql-pro
- **Descrição:** Domínio de SQL moderno com bancos nativos da nuvem, otimização OLTP/OLAP e técnicas avançadas de queries. Expertise em tuning de performance, modelagem de dados e sistemas analíticos híbridos.
- **Quando usar:** Para escrever queries SQL complexas, otimizar performance de consultas, ou modelar esquemas analíticos em bancos cloud (BigQuery, Snowflake, Redshift).
- **Exemplo:** Escrever uma query window function complexa para calcular running totals e comparar performance entre abordagens em BigQuery.

### 1.19 sql-sentinel
- **Descrição:** Auditar SQL para anti-padrões de custo e performance que consomem créditos de warehouse. Pontua a saúde do warehouse de 0-100 e gera plano priorizado de redução de custos para BigQuery, Snowflake, Redshift e Postgres.
- **Quando usar:** Quando queries SQL estão consumindo recursos excessivos em data warehouses, ou para auditoria periódica de custos de queries.
- **Exemplo:** Auditar um projeto inteiro de dbt identificando queries que poderiam ser otimizadas para reduzir custo de BigQuery em 30%.

### 1.20 warehouse
- **Descrição:** Planejar e revisar análises read-only de data warehouse com escopo explícito, privacidade, proveniência e verificações de validação.
- **Quando usar:** Para conduzir análises exploratórias em data warehouses de forma segura e estruturada, com rastreabilidade de dados.
- **Exemplo:** Realizar uma análise de cohort de clientes em um data warehouse BigQuery, documentando a proveniência de cada métrica e validando os resultados.

### 1.21 web-scraper
- **Descrição:** Web scraping inteligente multi-estratégia. Extrai dados estruturados de páginas web (tabelas, listas, preços). Paginação, monitoramento e export CSV/JSON.
- **Quando usar:** Quando precisar extrair dados estruturados de sites — listas de preços, tabelas de dados, catálogos de produtos.
- **Exemplo:** Extrair uma tabela de preços de 500 produtos de um site de e-commerce e exportar como CSV para análise.

### 1.22 x-twitter-scraper
- **Descrição:** Usar Xquik para workflows de dados do X (Twitter): busca de tweets, lookup de usuários, export de seguidores, downloads de mídia, monitores, webhooks, REST API, MCP, SDK setup e ações de conta com aprovação.
- **Quando usar:** Para extrair dados do X/Twitter — analisar engajamento de tweets, monitorar menções, exportar seguidores de um perfil.
- **Exemplo:** Monitorar menções de uma marca no X e gerar um relatório semanal de sentimento com base nos tweets extraídos.

---

## 2. Data AI (14 skills)

> Fonte: `data-ai-category-pointer/SKILL.md`  
> Vault: `C:/Users/Alendaviva007/.config/opencode/skill-libraries/data-ai`

### 2.1 ai-engineering-toolkit
- **Descrição:** 6 workflows prontos de engenharia AI: avaliação de prompts (scoring em 8 dimensões), planejamento de orçamento de contexto, design de pipelines RAG, auditoria de segurança de agentes (checklist de 65 pontos), construção de eval harness e coaching de product sense.
- **Quando usar:** Para implementar boas práticas de engenharia AI — avaliar qualidade de prompts, projetar sistemas RAG, auditar segurança de agentes.
- **Exemplo:** Realizar uma auditoria de 65 pontos na segurança de um agente AI que acessa dados sensíveis de clientes.

### 2.2 clarity-gate
- **Descrição:** Verificação pré-ingestão para qualidade epistêmica em sistemas RAG. Garante que documentos são qualificados antes de entrarem em knowledge bases. Produz CGD (Clarity-Gated Documents) e valida arquivos SOT (Source of Truth).
- **Quando usar:** Quando estiver construindo ou mantendo um sistema RAG e precisa garantir que apenas documentos de alta qualidade entrem no knowledge base.
- **Exemplo:** Configurar um pipeline que filtra e qualifica documentos antes de indexá-los em um vector store para um assistente corporativo.

### 2.3 embedding-strategies
- **Descrição:** Guia para selecionar e otimizar modelos de embedding para aplicações de busca vetorial.
- **Quando usar:** Quando precisar escolher o melhor modelo de embedding para um caso de uso específico (busca semântica, classificação, clustering).
- **Exemplo:** Comparar embeddings do OpenAI, Cohere e modelos open-source para determinar qual produz os melhores resultados de busca semântica para um catálogo de produtos.

### 2.4 exa-search
- **Descrição:** Busca semântica, descoberta de conteúdo similar e pesquisa estruturada usando a API Exa.
- **Quando usar:** Quando precisar de busca baseada em embeddings/semântica, encontrar conteúdo similar, ou pesquisar por categorias (empresas, pessoas, papers de pesquisa).
- **Exemplo:** Encontrar artigos de pesquisa similares a um paper específico usando busca semântica, em vez de apenas palavras-chave.

### 2.5 llm-app-patterns
- **Descrição:** Esboços de arquitetura e integração para aplicações LLM, com limites explícitos de recuperação, ferramentas, privacidade e verificação.
- **Quando usar:** Para projetar a arquitetura de uma nova aplicação LLM, definindo boundaries de segurança, recuperação de dados e integração com ferramentas externas.
- **Exemplo:** Projetar a arquitetura de um chatbot corporativo que usa RAG com acesso restrito a documentos internos e logging de todas as respostas.

### 2.6 local-llm-expert
- **Descrição:** Domínio de inferência LLM local, seleção de modelos, otimização de VRAM e deploy local usando Ollama, llama.cpp, vLLM e LM Studio. Expertise em formatos de quantização (GGUF, EXL2) e privacidade de AI local.
- **Quando usar:** Quando precisar rodar modelos LLM localmente — para privacidade, custo, ou latência — e precisa de orientação sobre hardware, quantização e otimização.
- **Exemplo:** Configurar um modelo Llama 3 70B quantizado em GGUF para rodar localmente com llama.cpp em um servidor com 2 GPUs.

### 2.7 notebooklm
- **Descrição:** Interagir com o Google NotebookLM para consultar documentação com respostas fundamentadas do Gemini. Cada pergunta abre uma sessão de browser, recupera a resposta exclusivamente dos documentos carregados e fecha.
- **Quando usar:** Para consultar documentação extensa de forma conversacional usando o NotebookLM como interface.
- **Exemplo:** Perguntar ao NotebookLM sobre padrões de segurança de uma API específica a partir da documentação oficial carregada.

### 2.8 rag-engineer
- **Descrição:** Expertise em construir sistemas Retrieval-Augmented Generation (RAG). Domínio em modelos de embedding, bancos de dados vetoriais, estratégias de chunking e otimização de recuperação para aplicações LLM.
- **Quando usar:** Quando precisar construir ou otimizar um sistema RAG — escolher banco vetorial, definir chunking, otimizar recall.
- **Exemplo:** Implementar um pipeline RAG completo: chunking semântico, embeddings com Cohere, busca em Qdrant e geração com GPT-4 para um assistente de suporte técnico.

### 2.9 recsys-pipeline-architect
- **Descrição:** Projetar pipelines composáveis de recomendação, ranking e feed usando o framework de 6 estágios: Source → Hydrator → Filter → Scorer → Selector → SideEffect.
- **Quando usar:** Para projetar sistemas de recomendação escaláveis — feeds personalizados, sistemas de ranking, ou motores de sugestão.
- **Exemplo:** Projetar um pipeline de recomendação para um feed de notícias que filtra, pontua e seleciona conteúdo relevante para cada usuário.

### 2.10 seek-and-analyze-video
- **Descrição:** Buscar e analisar conteúdo de vídeo usando o Modelo de Memória Visual Grande (Memories.ai) para inteligência de vídeo persistente.
- **Quando usar:** Quando precisar analisar conteúdo de vídeo — detectar cenas específicas, extrair informações visuais, ou monitorar conteúdo de vídeo.
- **Exemplo:** Analisar um catálogo de 1000 vídeos para identificar todos os momentos que contêm apresentadores falando sobre "sustentabilidade".

### 2.11 similarity-search-patterns
- **Descrição:** Implementar busca de similaridade eficiente com bancos de dados vetoriais. Usar ao construir busca semântica, implementar queries nearest neighbor ou otimizar performance de recuperação.
- **Quando usar:** Para implementar ou otimizar sistemas de busca por similaridade em embeddings — recomendação, deduplicação, ou matching.
- **Exemplo:** Implementar um sistema de busca de imagens similares usando embeddings CLIP e um vector store Pinecone.

### 2.12 tavily-web
- **Descrição:** Busca web, extração de conteúdo, crawling e capacidades de pesquisa usando a API Tavily.
- **Quando usar:** Quando precisar buscar informações atualizadas na web, extrair conteúdo de URLs, ou fazer crawling de sites para pesquisa.
- **Exemplo:** Pesquisar as últimas notícias sobre um tópico de tecnologia e extrair o conteúdo completo dos 5 artigos mais relevantes.

### 2.13 vector-database-engineer
- **Descrição:** Expertise em bancos de dados vetoriais, estratégias de embedding e implementação de busca semântica. Domínio em Pinecone, Weaviate, Qdrant, Milvus e pgvector para aplicações RAG, sistemas de recomendação e busca por similaridade.
- **Quando usar:** Quando precisar escolher, configurar ou otimizar um banco de dados vetorial para um caso de uso específico.
- **Exemplo:** Configurar um cluster Qdrant para armazenar 10M embeddings e servir buscas semânticas com latência < 50ms.

### 2.14 vector-index-tuning
- **Descrição:** Otimizar performance de índices vetoriais para latência, recall e memória. Usar ao ajustar parâmetros HNSW, selecionar estratégias de quantização ou escalar infraestrutura de busca vetorial.
- **Quando usar:** Quando o desempenho de busca vetorial está abaixo do ideal — latência alta, recall baixo, ou custo de memória excessivo.
- **Exemplo:** Otimizar parâmetros HNSW de um índice Qdrant para reduzir latência de 200ms para 30ms mantendo recall > 95%.

---

## 3. Data Science (8 skills)

> Fonte: `data-science-category-pointer/SKILL.md`  
> Vault: `C:/Users/Alendaviva007/.config/opencode/skill-libraries/data-science`

### 3.1 data-engineering-data-driven-feature
- **Descrição:** Construir features guiadas por insights de dados, testes A/B e medição contínua usando agentes especializados para análise, implementação e experimentação.
- **Quando usar:** Quando precisar desenvolver funcionalidades de produto baseadas em dados, com ciclo de medição e experimentação contínuo.
- **Exemplo:** Desenvolver uma feature de recomendação de produto usando dados de comportamento do usuário, validar com A/B test e medir impacto na conversão.

### 3.2 data-engineering-data-pipeline
- **Descrição:** Expertise em arquitetura de pipelines de dados escaláveis, confiáveis e econômicos para processamento de dados em batch e streaming.
- **Quando usar:** Para projetar, construir ou otimizar pipelines de dados — batch ou streaming — focando em escalabilidade, confiabilidade e custo.
- **Exemplo:** Projetar um pipeline de dados que ingere eventos de 500GB/dia de múltiplas fontes, transforma em camada gold e alimenta dashboards.

### 3.3 data-quality-frameworks
- **Descrição:** Implementar validação de qualidade de dados com Great Expectations, testes dbt e data contracts.
- **Quando usar:** Quando precisar estabelecer ou melhorar a qualidade de dados — definir regras de validação, implementar testes de dados, ou criar contratos de dados.
- **Exemplo:** Implementar uma suíte de testes de qualidade com Great Expectations que valida 50 regras de dados antes de cada pipeline de carga.

### 3.4 data-scientist
- **Descrição:** Cientista de dados expert para analytics avançado, machine learning e modelagem estatística. Lida com análise complexa de dados, modelagem preditiva e business intelligence.
- **Quando usar:** Para problemas de ciência de dados — classificação, regressão, clustering, análise estatística, ou modelagem preditiva.
- **Exemplo:** Construir um modelo de churn prediction para uma SaaS usando XGBoost, com feature engineering, validação cruzada e explicabilidade SHAP.

### 3.5 data-storytelling
- **Descrição:** Transformar dados brutos em narrativas convincentes que impulsionam decisões e inspiram ação.
- **Quando usar:** Quando precisar comunicar resultados de dados para stakeholders não-técnicos, ou criar apresentações baseadas em dados.
- **Exemplo:** Transformar os resultados de uma análise de cohort em uma apresentação executiva com narrativa clara e ações recomendadas.

### 3.6 data-structure-protocol
- **Descrição:** Dar aos agentes memória estrutural persistente de um codebase — navegar dependências, rastrear APIs públicas e entender por que conexões existem sem reler o repositório inteiro.
- **Quando usar:** Quando agentes de IA precisam de contexto persistente sobre a estrutura de um projeto de software para navegar e modificar código.
- **Exemplo:** Criar um protocolo de memória estrutural para um agente que mantém um monolito de 200k linhas, permitindo navegar dependências sem reler o código inteiro.

### 3.7 plotly
- **Descrição:** Biblioteca de visualização interativa. Usar quando precisar de info ao hover, zoom, pan ou gráficos incorporáveis na web. Melhor para dashboards, análise exploratória e apresentações. Para figuras estáticas de publicação usar matplotlib ou scientific-visualization.
- **Quando usar:** Para criar gráficos interativos que permitam exploração de dados — dashboards web, apresentações, ou análise exploratória.
- **Exemplo:** Criar um dashboard Plotly com gráficos de dispersão, barras e line charts interativos que permite drill-down nos dados de vendas por região.

### 3.8 polars
- **Descrição:** Biblioteca de DataFrame rápida para dados que cabem em RAM. Usar quando pandas é lento mas os dados ainda cabem em memória. Avaliação lazy, execução paralela, backend Apache Arrow. Melhor para datasets de 1-100GB, pipelines ETL, substituto mais rápido do pandas. Para dados maiores que RAM usar dask ou vaex.
- **Quando usar:** Quando precisar processar datasets grandes (1-100GB) que são lentos em pandas mas ainda cabem em memória.
- **Exemplo:** Processar um dataset de 50GB de transações com Polars para calcular métricas de vendas, obtendo 10x de speedup sobre pandas.

---

## 4. Data Engineering (1 skill)

> Fonte: `data-engineering-category-pointer/SKILL.md`  
> Vault: `C:/Users/Alendaviva007/.config/opencode/skill-libraries/data-engineering`

### 4.1 snowflake-development
- **Descrição:** Assistente abrangente de desenvolvimento Snowflake cobrindo boas práticas SQL, design de pipelines de dados (Dynamic Tables, Streams, Tasks, Snowpipe), funções Cortex AI, Cortex Agents, Snowpark Python, integração dbt, tuning de performance e hardening de segurança.
- **Quando usar:** Quando precisar trabalhar com Snowflake — criar Dynamic Tables, configurar Snowpipe, usar funções Cortex AI, ou otimizar queries Snowflake.
- **Exemplo:** Configurar uma Dynamic Table no Snowflake que atualiza incrementalmente uma tabela de agregação de vendas, com Snowpipe para ingestão automática e Streams para mudanças.

---

## 5. Database (16 skills)

> Fonte: `database-category-pointer/SKILL.md`  
> Vault: `C:/Users/Alendaviva007/.config/opencode/skill-libraries/database`

### 5.1 database-cloud-optimization-cost-optimize
- **Descrição:** Expert em otimização de custos cloud especializado em reduzir despesas de infraestrutura mantendo performance e confiabilidade. Analisa gastos cloud, identifica oportunidades de economia e implementa arquiteturas eficientes em custo em AWS, Azure e GCP.
- **Quando usar:** Quando custos de banco de dados na nuvem estão acima do esperado, ou para auditoria proativa de otimização de custos.
- **Exemplo:** Analisar custos de RDS + ElastiCache em uma conta AWS e propor arquitetura que reduz custos em 40% mantendo performance.

### 5.2 database-migration
- **Descrição:** Domínio de migrações de schema e dados em ORMs (Sequelize, TypeORM, Prisma), incluindo estratégias de rollback e deploys com zero downtime.
- **Quando usar:** Para migrar schemas de banco de dados de forma segura, entre diferentes bancos ou versões, com zero downtime.
- **Exemplo:** Migrar um schema Prisma de PostgreSQL para MySQL, criando scripts de migração reversíveis e validando integridade dos dados.

### 5.3 database-migrations-migration-observability
- **Descrição:** Monitoramento de migrações, CDC (Change Data Capture) e infraestrutura de observabilidade.
- **Quando usar:** Quando precisar monitorar migrações de banco em tempo real, implementar CDC, ou criar observabilidade sobre mudanças de schema.
- **Exemplo:** Configurar CDC com Debezium para capturar mudanças em uma tabela PostgreSQL e replicar para um data warehouse em tempo real.

### 5.4 database-migrations-sql-migrations
- **Descrição:** Migrações SQL com estratégias de zero downtime para PostgreSQL, MySQL e SQL Server. Foco na integridade dos dados e planos de rollback.
- **Quando usar:** Para executar migrações SQL em produção com garantia de zero downtime e possibilidade de rollback.
- **Exemplo:** Executar uma migração que adiciona uma coluna NOT NULL a uma tabela de 10M de registros em PostgreSQL com zero downtime, usando default value e backfill assíncrono.

### 5.5 database-security
- **Descrição:** Avaliação autorizada de segurança de banco de dados em PostgreSQL, MySQL, MSSQL, MongoDB e Redis: exposição, gaps de autorização, caminhos de execução UDF/comando e revisão de configuração incorreta.
- **Quando usar:** Para auditoria de segurança de bancos de dados — identificar vulnerabilidades, configurações inseguras, ou permissões inadequadas.
- **Exemplo:** Realizar assessment de segurança em um cluster PostgreSQL identificando 15 configurações inseguras e 3 usuários com permissões excessivas.

### 5.6 drizzle-orm-expert
- **Descrição:** Expert em Drizzle ORM para TypeScript — design de schema, queries relacionais, migrações e integração com bancos serverless.
- **Quando usar:** Quando estiver construindo uma camada de banco de dados type-safe com Drizzle ORM em projetos TypeScript.
- **Exemplo:** Projetar um schema Drizzle ORM para uma aplicação SaaS multi-tenant com relações complexas e migrações automáticas.

### 5.7 neon-postgres-branches
- **Descrição:** Escolher e criar o tipo correto de branch Neon para testes e desenvolvimento. Usar quando o usuário perguntar sobre branching Neon, teste de migrações com dados reais, ambientes de teste isolados, workflows de schema-only para dados sensíveis, ou criação de branches via Neon CLI ou Neon MCP.
- **Quando usar:** Quando precisar usar branches do Neon para testes isolados, testes de migração, ou ambientes de staging com dados reais.
- **Exemplo:** Criar uma branch schema-only no Neon para testar uma migração de schema sem expor dados de produção.

### 5.8 nosql-expert
- **Descrição:** Orientação expertise para bancos NoSQL distribuídos (Cassandra, DynamoDB). Foco em modelos mentais, modelagem query-first, design de tabela single-table e evitação de hot partitions em sistemas de alta escala.
- **Quando usar:** Para projetar ou otimizar schemas em bancos NoSQL como Cassandra ou DynamoDB, especialmente em sistemas de alta escala.
- **Exemplo:** Projetar um design de tabela single-table no DynamoDB que suporte 100k requisições/segundo sem hot partitions.

### 5.9 postgres-best-practices
- **Descrição:** Otimização de performance e boas práticas do Postgres do Supabase. Usar ao escrever, revisar ou otimizar queries Postgres, design de schemas ou configurações de banco.
- **Quando usar:** Para escrever queries PostgreSQL mais rápidas, revisar schemas, ou otimizar configurações de performance.
- **Exemplo:** Revisar 20 queries PostgreSQL identificando oportunidades de indexação e rewriting que reduzem tempo de execução em 80%.

### 5.10 postgresql
- **Descrição:** Projetar schema específico para PostgreSQL. Cobre boas práticas, tipos de dados, indexação, constraints, padrões de performance e funcionalidades avançadas.
- **Quando usar:** Para projetar um schema PostgreSQL do zero ou revisar um existente, com foco em boas práticas e performance.
- **Exemplo:** Projetar um schema PostgreSQL para um sistema de e-commerce com constraints, índices compostos e particionamento por data.

### 5.11 postgresql-cli
- **Descrição:** Referência e guia de uso do terminal interativo do PostgreSQL (psql).
- **Quando usar:** Quando precisar usar o psql para interagir com PostgreSQL — queries ad-hoc, administração, ou debugging.
- **Exemplo:** Usar comandos psql avançados para analisar o plano de execução de uma query lenta e identificar gargalos de performance.

### 5.12 prisma-expert
- **Descrição:** Expert em Prisma ORM com conhecimento profundo em design de schema, migrações, otimização de queries, modelagem de relações e operações de banco em PostgreSQL, MySQL e SQLite.
- **Quando usar:** Quando estiver trabalhando com Prisma ORM — definir schemas, escrever queries otimizadas, ou resolver problemas de performance.
- **Exemplo:** Otimizar queries Prisma que estão causando N+1, refatorando para usar includes e selects otimizados.

### 5.13 saas-multi-tenant
- **Descrição:** Projetar e implementar arquiteturas SaaS multi-tenant com row-level security, queries com escopo de tenant, isolamento de schema compartilhado e padrões seguros de admin cross-tenant em PostgreSQL e TypeScript.
- **Quando usar:** Para implementar isolamento multi-tenant em um SaaS, garantindo que cada tenant acesse apenas seus dados.
- **Exemplo:** Implementar row-level security em PostgreSQL para um SaaS multi-tenant que compartilha uma única tabela entre 1000 clientes.

### 5.14 sql-optimization-patterns
- **Descrição:** Diagnosticar SQL lento com planos de execução, preservar resultados de queries e verificar mudanças de indexação ou query contra dados representativos.
- **Quando usar:** Quando queries SQL estão lentas e precisam de diagnóstico e otimização baseados em planos de execução reais.
- **Exemplo:** Diagnosticar uma query lenta analisando o EXPLAIN ANALYZE, identificando que um seq scan poderia ser substituído por um index scan, e validando a melhoria.

### 5.15 sqlmap-database-pentesting
- **Descrição:** Metodologias sistemáticas para detecção e exploração automatizada de SQL injection usando SQLMap.
- **Quando usar:** Para testes de penetração autorizados em bancos de dados, identificando vulnerabilidades de SQL injection.
- **Exemplo:** Realizar pentest automatizado em uma aplicação web usando SQLMap para detectar e explora SQL injection em parâmetros de URL.

### 5.16 supabase-postgres-best-practices
- **Descrição:** Otimização de performance e boas práticas do Postgres do Supabase. Usar ao escrever, revisar ou otimizar queries Postgres, design de schemas ou configurações de banco.
- **Quando usar:** Para otimizar queries e schemas PostgreSQL com foco em boas práticas do ecossistema Supabase.
- **Exemplo:** Configurar RLS policies no Supabase que sejam seguras e performáticas, evitando full table scans.

---

## 6. Database Processing (6 skills)

> Fonte: `database-processing-category-pointer/SKILL.md`  
> Vault: `C:/Users/Alendaviva007/.config/opencode/skill-libraries/database-processing`

### 6.1 base
- **Descrição:** Gerenciamento de banco de dados, formulários, relatórios e operações de dados com LibreOffice Base.
- **Quando usar:** Para trabalhar com bancos de dados usando LibreOffice Base — criar formulários, relatórios, ou gerenciar dados.
- **Exemplo:** Criar um formulário no LibreOffice Base para entrada de dados de vendas e um relatório consolidado mensal.

### 6.2 database-admin
- **Descrição:** DBA expert especializado em bancos de dados modernos na nuvem, automação e engenharia de confiabilidade.
- **Quando usar:** Para administração de bancos de dados em produção — monitoramento, backups, recuperação, automação de tarefas rotineiras.
- **Exemplo:** Configurar automação de backups incrementais para um cluster PostgreSQL com retenção de 30 dias e testes de restauração semanais.

### 6.3 database-architect
- **Descrição:** Arquiteto de banco de dados expert especializado no design da camada de dados do zero, seleção de tecnologia, modelagem de schema e arquiteturas de banco escaláveis.
- **Quando usar:** Para projetar a arquitetura de dados de um novo sistema — escolher tecnologias, modelar schemas, definir padrões de acesso.
- **Exemplo:** Projetar a arquitetura de dados completa para um marketplace: PostgreSQL para transações, Redis para cache, Elasticsearch para busca.

### 6.4 database-design
- **Descrição:** Princípios de design de banco de dados e tomada de decisão. Design de schema, estratégia de indexação, seleção de ORM, bancos serverless.
- **Quando usar:** Para tomar decisões de design de banco — escolher entre Normalização vs Denormalização, definir índices, selecionar ORM.
- **Exemplo:** Decidir entre MongoDB e PostgreSQL para um sistema de catálogo de produtos, considerando schema flexível vs integridade referencial.

### 6.5 database-optimizer
- **Descrição:** Expert em otimização de banco de dados especializado em tuning de performance moderno, otimização de queries e arquiteturas escaláveis.
- **Quando usar:** Quando bancos de dados estão com performance abaixo do ideal — queries lentas, latência alta, ou gargalos de throughput.
- **Exemplo:** Otimizar um cluster PostgreSQL que está com CPU em 95%, identificando queries problemáticas e aplicando configurações de tuning.

### 6.6 using-neon
- **Descrição:** Neon é uma plataforma serverless de PostgreSQL que separa compute e storage para oferecer autoscaling, branching, instant restore e scale-to-zero. Totalmente compatível com Postgres e funciona com qualquer linguagem, framework ou ORM que suporte Postgres.
- **Quando usar:** Para configurar ou usar o Neon como plataforma serverless de PostgreSQL — branching, autoscaling, ou scale-to-zero.
- **Exemplo:** Configurar um projeto Neon com branching automático para cada PR no GitHub, permitindo testes isolados de migrações.

---

## 7. Databases (2 skills)

> Fonte: `databases-category-pointer/SKILL.md`  
> Vault: `C:/Users/Alendaviva007/.config/opencode/skill-libraries/databases`

### 7.1 drizzle-migration-conflict
- **Descrição:** Diagnosticar, reparar e prevenir conflitos de migração do Drizzle Kit envolvendo SQL gerado, snapshots, journals, filas de merge e workflows de equipe.
- **Quando usar:** Quando surgem conflitos de migração do Drizzle Kit — SQL gerado inconsistente, snapshots desatualizados, ou problemas de merge em equipe.
- **Exemplo:** Resolver um conflito de migração do Drizzle onde dois desenvolvedores criaram migrações que modificam a mesma tabela, reparando o snapshot e journal.

### 7.2 weaviate
- **Descrição:** Buscar, consultar, inspecionar, criar e importar dados em coleções do banco vetorial Weaviate usando scripts oficiais e referências.
- **Quando usar:** Para trabalhar com o Weaviate como banco vetorial — criar coleções, importar embeddings, ou executar buscas semânticas.
- **Exemplo:** Criar uma coleção no Weaviate com o módulo text2vec-openAI e importar 100k documentos com embeddings para um sistema de busca semântica.

---

## Resumo Estatístico

| Categoria | Qtd Skills | Vault Path |
|---|---|---|
| Data | 22 | `skill-libraries/data` |
| Data AI | 14 | `skill-libraries/data-ai` |
| Data Science | 8 | `skill-libraries/data-science` |
| Data Engineering | 1 | `skill-libraries/data-engineering` |
| Database | 16 | `skill-libraries/database` |
| Database Processing | 6 | `skill-libraries/database-processing` |
| Databases | 2 | `skill-libraries/databases` |
| **TOTAL** | **69** | — |

---

## Domínios Cobertos

- **Finanças:** Alpha Vantage, dados financeiros globais
- **Analytics de Produto:** PostHog, Mixpanel, Amplitude, Segment
- **Web Scraping:** Firecrawl, web-scraper, X-Twitter scraper, Exa Search, Tavily
- **Engenharia de Dados:** Spark, dbt, Airflow, pipelines batch/streaming, Snowflake
- **Bancos de Dados Relacionais:** PostgreSQL, MySQL, SQL Server, Neon
- **Bancos NoSQL:** Cassandra, DynamoDB, MongoDB, Redis
- **Bancos Vetoriais:** Pinecone, Weaviate, Qdrant, Milvus, pgvector
- **ORMs:** Prisma, Drizzle ORM, Sequelize, TypeORM
- **AI/ML:** RAG, embeddings, LLM local, otimização de prompts, recomendação
- **Data Science:** Análise estatística, ML, visualização (Plotly, Polars), storytelling
- **Qualidade de Dados:** Great Expectations, data contracts, Monte Carlo
- **Segurança:** Auditoria de bancos, pentest SQL injection, row-level security
- **Cloud Cost:** Otimização de custos AWS, Azure, GCP
- **Serverless:** Neon, Supabase, bancos serverless

---

## Como Carregar uma Skill

1. Identifique o nome da skill acima que corresponde à sua tarefa.
2. Use o comando `view_file` para ler o `SKILL.md` do vault correspondente.
3. Siga as instruções do arquivo para completar a solicitação.

> **Aviso:** Não adivinhe boas práticas — sempre leia do vault primeiro.  
> **Anti-loop:** Não invoque skills recursivamente. Cada skill deve ser carregada no máximo uma vez por solicitação do usuário.
