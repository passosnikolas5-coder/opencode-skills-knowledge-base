# 🔮 Dify — Plataforma Open-Source para Desenvolvimento de Apps LLM

**Fonte:** https://github.com/langgenius/dify (90k+ estrelas)  
**Descrição:** Dify é uma plataforma open-source completa para desenvolver aplicações baseadas em LLMs. Oferece um construtor visual de workflows, IDE de prompts, pipeline RAG, suporte a múltiplos modelos e um ecossistema extensível de plugins.

---

## 1. Construtor Visual de Workflows (Drag & Drop)

Crie pipelines complexos de IA arrastando e conectando nós em uma interface visual.

```yaml
# Estrutura de um workflow Dify
workflow:
  name: "Atendente Virtual"
  nodes:
    - id: "inicio"
      type: "start"
      outputs:
        - nome: "mensagem"
          type: "string"
    
    - id: "llm_node"
      type: "llm"
      model: "gpt-4"
      prompt: "Responda como um atendente: {{mensagem}}"
      inputs:
        - "{{mensagem}}"
    
    - id: "condicao"
      type: "condition"
      variable: "{{resposta}}"
      conditions:
        - operator: "contains"
          value: "urgente"
          next_node: "escalar_humano"
        - operator: "default"
          next_node: "resposta_final"
    
    - id: "escalar_humano"
      type: "human_input"
      message: "Por favor, aguarde um atendente humano."
    
    - id: "resposta_final"
      type: "response"
      outputs:
        - "{{resposta}}"
```

### MELHORIA

❌ **ERRADO:** Criar workflows lineares sem tratamento de erros
```yaml
# Frágil - qualquer falha quebra tudo
nodes:
  - id: "llm"
    type: "llm"
    model: "gpt-4"
    prompt: "{{input}}"
  - id: "resposta"
    type: "response"
```

✅ **CORRETO:** Adicionar fallback e tratamento de erros
```yaml
# Robusto com fallback
nodes:
  - id: "llm_principal"
    type: "llm"
    model: "gpt-4"
    prompt: "{{input}}"
    error_handling:
      fallback_node: "llm_fallback"
      retry: 3
  
  - id: "llm_fallback"
    type: "llm"
    model: "gpt-3.5-turbo"
    prompt: "{{input}}"
    error_handling:
      fallback_node: "erro_final"
  
  - id: "erro_final"
    type: "response"
    output: "Desculpe, não consegui processar sua solicitação."
```

---

## 2. Prompt IDE — Chat, Completion e Agent

Gerencie prompts com versionamento, templates variáveis e publicação.

```yaml
# Prompt de Chat no Dify
prompt_config:
  name: "Assistente de Código"
  mode: "chat"
  model: "gpt-4"
  temperature: 0.3
  max_tokens: 2000
  system_prompt: |
    Você é um programador sênior especializado em {{linguagem}}.
    
    Regras:
    - Sempre documente o código
    - Inclua tratamento de erros
    - Sugira testes quando aplicável
    
    Exemplo de entrada:
    Usuário: Crie uma função de排序
    Assistente: ```python
    def sort_func(lista: list) -> list:
        """Ordena uma lista de forma crescente."""
        return sorted(lista)
    ```
  
  variables:
    - name: "linguagem"
      type: "select"
      options: ["Python", "JavaScript", "Go", "Rust"]
      required: true
  
  # Variáveis de output para parsing
  output_variables:
    - name: "codigo"
      type: "string"
      description: "Código gerado"
    - name: "explicacao"
      type: "string"
      description: "Explicação do código"
```

### MELHORIA

❌ **ERRADO:** Usar prompts hardcoded sem variáveis
```yaml
# Não reutilizável
system_prompt: "Você é um assistente Python. Responda sempre em português."
```

✅ **CORRETO:** Usar variáveis para personalização dinâmica
```yaml
# Reutilizável e configurável
system_prompt: |
  Você é um assistente especializado em {{area}}.
  
  - Idioma: {{idioma}}
  - Nível: {{nivel}}
  - Estilo: {{estilo}}
  
  Regras específicas:
  {{regras_adicionais}}

variables:
  - name: "area"
    type: "select"
    options: ["Python", "JavaScript", "DevOps", "Dados"]
  - name: "idioma"
    type: "select"
    options: ["Português", "Inglês", "Espanhol"]
    default: "Português"
  - name: "nivel"
    type: "select"
    options: ["Iniciante", "Intermediário", "Avançado"]
  - name: "estilo"
    type: "textarea"
    default: "Didático e claro"
  - name: "regras_adicionais"
    type: "textarea"
    default: ""
```

---

## 3. Pipeline RAG (Retrieval-Augmented Generation)

Pipeline completo de upload, indexação e recuperação de documentos.

```yaml
# Configuração de Knowledge Base no Dify
knowledge_base:
  name: "Base de Documentos Técnicos"
  description: "Documentação interna de APIs e sistemas"
  
  # Configuração de indexação
  indexing:
    # Estratégia de chunking
    chunking:
      method: "recursive"
      chunk_size: 500
      chunk_overlap: 50
      separators:
        - "\n\n"
        - "\n"
        - " "
        - ""
    
    # Embedding model
    embedding:
      model: "text-embedding-3-small"
      dimensions: 1536
    
    # Tipos de arquivo suportados
    supported_formats:
      - "pdf"
      - "docx"
      - "txt"
      - "md"
      - "html"
      - "csv"
      - "json"
  
  # Configuração de retrieval
  retrieval:
    mode: "hybrid"  # keyword, semantic, hybrid
    top_k: 5
    score_threshold: 0.7
    
    # Reranking
    reranking:
      enabled: true
      model: "rerank-v1"
      top_n: 3
    
    # Filtros metadata
    metadata_filters:
      - field: "departamento"
        operator: "eq"
        value: "engenharia"
  
  # Sincronização automática
  sync:
    enabled: true
    source:
      type: "s3"
      bucket: "docs-bucket"
      prefix: "documentos/"
    schedule: "0 2 * * *"  # 2:00 AM diariamente
```

### MELHORIA

❌ **ERRADO:** Chunking muito grande ou muito pequeno
```yaml
# Chunking inadequado - perde contexto ou fragmenta demais
chunking:
  method: "fixed"
  chunk_size: 5000  # Muito grande - irrelevante
  # OU
  chunk_size: 50  # Muito pequeno - perde contexto
```

✅ **CORRETO:** Chunking adaptativo com sobreposição inteligente
```yaml
chunking:
  method: "recursive"
  chunk_size: 1000  # Tamanho equilibrado
  chunk_overlap: 200  # Sobreposição para manter contexto
  separators:
    - "\n\n"  # Primeiro tenta por parágrafos
    - "\n"    # Depois por linhas
    - ". "    # Depois por frases
    - " "     # Último recurso - por palavras
  
  # Metadata para filtragem
  metadata_extraction:
    enabled: true
    auto_extract:
      - "titulo"
      - "autor"
      - "data"
      - "departamento"
  
  # Pré-processamento
  preprocessing:
    - type: "remove_headers"
    - type: "normalize_whitespace"
    - type: "remove_special_chars"
      pattern: "[^\w\s\.\,\;\:\-\(\)\[\]\{\}]"
```

---

## 4. Suporte a Múltiplos Modelos

Integre e gerencie diversos provedores de LLM em um só lugar.

```yaml
# Configuração de modelos no Dify
model_config:
  providers:
    - name: "openai"
      api_key: "${OPENAI_API_KEY}"
      models:
        - name: "gpt-4"
          alias: "GPT-4 Principal"
          max_tokens: 8192
          cost_per_1k: 0.03
          features: ["chat", "function_calling"]
        
        - name: "gpt-4o"
          alias: "GPT-4o Multimodal"
          max_tokens: 16384
          cost_per_1k: 0.015
          features: ["chat", "vision", "function_calling"]
        
        - name: "gpt-3.5-turbo"
          alias: "GPT-3.5 Econômico"
          max_tokens: 4096
          cost_per_1k: 0.0015
          features: ["chat"]
    
    - name: "anthropic"
      api_key: "${ANTHROPIC_API_KEY}"
      models:
        - name: "claude-3-opus"
          alias: "Claude Opus"
          max_tokens: 4096
          cost_per_1k: 0.015
          features: ["chat", "vision"]
        
        - name: "claude-3-sonnet"
          alias: "Claude Sonnet"
          max_tokens: 4096
          cost_per_1k: 0.003
          features: ["chat"]
    
    - name: "local"
      base_url: "http://localhost:11434"
      models:
        - name: "llama3"
          alias: "Llama 3 Local"
          max_tokens: 4096
          features: ["chat"]
    
    # Fallback automático
  fallback_chain:
    - "gpt-4"
    - "gpt-4o"
    - "claude-3-sonnet"
    - "llama3"
  
  # Rate limiting
  rate_limiting:
    openai:
      requests_per_minute: 60
      tokens_per_minute: 90000
    anthropic:
      requests_per_minute: 50
      tokens_per_minute: 80000
```

### MELHORIA

❌ **ERRADO:** Não configurar fallback entre modelos
```yaml
# Modelo único - falha é downtime
model: "gpt-4"
# Se API cair, aplicação para
```

✅ **CORRETO:** Cadeia de fallback com modelos alternativos
```yaml
# Resiliência via fallback chain
model_chain:
  - model: "gpt-4"
    priority: 1
    timeout: 30
  
  - model: "gpt-4o"
    priority: 2
    timeout: 15
  
  - model: "claude-3-sonnet"
    priority: 3
    timeout: 10
  
  - model: "llama3"
    priority: 4
    timeout: 60
    local: true

# Com métricas de custo
cost_control:
  daily_limit_usd: 50.00
  alert_threshold: 0.8  # Alerta aos 80%
  fallback_to_cheaper: true
```

---

## 5. Ecossistema de Tools e Plugins

Expanda as capacidades dos seus agentes com ferramentas externas.

```yaml
# Configuração de Tools no Dify
tools:
  - name: "web_search"
    type: "builtin"
    provider: "serper"
    config:
      api_key: "${SERPER_API_KEY}"
      max_results: 5
      safe_search: true
  
  - name: "code_execution"
    type: "builtin"
    provider: "jupyter"
    config:
      timeout: 60
      sandbox: true
  
  - name: "api_call"
    type: "custom"
    description: "Chama API externa"
    endpoint: "https://api.exemplo.com/v1"
    method: "POST"
    headers:
      Authorization: "Bearer ${API_TOKEN}"
    parameters:
      - name: "endpoint"
        type: "string"
        required: true
      - name: "data"
        type: "object"
        required: false
  
  - name: "database_query"
    type: "custom"
    description: "Consulta banco de dados"
    connector: "postgresql"
    config:
      host: "${DB_HOST}"
      database: "app_db"
      query_template: "SELECT * FROM {{tabela}} WHERE {{condicao}}"
      max_rows: 100

# Marketplace de plugins
marketplace:
  plugins:
    - name: "github"
      version: "1.0.0"
      config:
        token: "${GITHUB_TOKEN}"
    
    - name: "slack"
      version: "1.2.0"
      config:
        webhook_url: "${SLACK_WEBHOOK}"
    
    - name: "google_sheets"
      version: "1.1.0"
      config:
        credentials: "${GOOGLE_CREDENTIALS}"
```

### MELHORIA

❌ **ERRADO:** Expor chaves de API diretamente no config
```yaml
# PERIGOSO - credenciais no código
tools:
  - name: "github"
    config:
      token: "ghp_abc123def456"  # Chave exposta!
```

✅ **CORRETO:** Usar variáveis de ambiente e vault de segredos
```yaml
# Seguro - referências a variáveis
tools:
  - name: "github"
    config:
      token: "${GITHUB_TOKEN}"  # Referência segura
    
# Ou com vault integrado
vault:
  provider: "hashicorp"
  endpoint: "https://vault.empresa.com"
  auth:
    method: "approle"
    role_id: "${VAULT_ROLE_ID}"
    secret_id: "${VAULT_SECRET_ID}"

# Políticas de acesso
access_control:
  tools:
    web_search:
      allowed_roles: ["admin", "analista"]
    code_execution:
      allowed_roles: ["admin"]
      requires_approval: true
```

---

## 6. Capacidades de Agent

Agentes autônomos com function calling e reasoning.

```yaml
# Configuração de Agent no Dify
agent_config:
  name: "Agente de Vendas"
  model: "gpt-4"
  temperature: 0.7
  
  # Sistema prompt do agente
  system_prompt: |
    Você é um consultor de vendas especializado em produtos de tecnologia.
    
    Suas responsabilidades:
    - Qualificar leads baseado em informações fornecidas
    - Recomendar soluções adequadas ao perfil do cliente
    - Agendar demonstrações quando necessário
    - Registrar interações no CRM
    
    Ferramentas disponíveis:
    - Consulta CRM: para verificar dados do cliente
    - Consulta Catálogo: para encontrar produtos adequados
    - Agendar Demo: para agendar demonstrações
    - Enviar Email: para comunicação formal
    
    Sempre seja consultivo e focado em valor para o cliente.
  
  # Reasoning steps
  reasoning:
    enabled: true
    max_steps: 5
    strategy: "ReAct"  # Reasoning + Acting
  
  # Tools disponíveis para o agente
  tools:
    - "crm_lookup"
    - "catalog_search"
    - "schedule_demo"
    - "send_email"
  
  # Limites de segurança
  guardrails:
    max_iterations: 10
    max_tokens_per_tool: 1000
    blocked_actions:
      - "delete_account"
      - "change_password"
    
    # Human-in-the-loop para ações críticas
    human_approval:
      - tool: "schedule_demo"
        condition: "value > 10000"
      - tool: "send_email"
        condition: "always"
  
  # Memória do agente
  memory:
    type: "conversation_buffer"
    max_tokens: 4000
    summary_threshold: 3000
    
    # Memória persistente
    persistent_memory:
      enabled: true
      type: "key_value"
      prefix: "agente_vendas_"
```

### MELHORIA

❌ **ERRADO:** Agente sem limites de iteração
```yaml
# Pode entrar em loop infinito
agent:
  tools: ["search", "reason", "execute"]
  max_iterations: 999  # Perigoso
```

✅ **CORRETO:** Definir limites claros e human-in-the-loop
```yaml
agent:
  tools: ["search", "reason", "execute"]
  max_iterations: 10  # Limite seguro
  timeout: 120  # Timeout em segundos
  
  guardrails:
    # Bloquear ações perigosas
    blocked_patterns:
      - "DELETE"
      - "DROP TABLE"
      - "rm -rf"
    
    # Aprovação humana para ações críticas
    approval_required:
      - pattern: "payment"
        approvers: ["financeiro"]
      - pattern: "deploy"
        approvers: ["devops"]
    
    # Logging de todas as ações
    audit_log:
      enabled: true
      destination: "https://logs.empresa.com"
```

---

## 7. Publicação de APIs

Exponha seus workflows como endpoints RESTful consumíveis.

```yaml
# Configuração de API no Dify
api_config:
  # Endpoint principal
  endpoint: "https://api.seudominio.com/v1"
  
  # Autenticação
  auth:
    type: "bearer"
    tokens:
      - name: "Produção"
        token: "${API_TOKEN_PROD}"
        expires: "2025-12-31"
        scopes: ["read", "write"]
      
      - name: "Desenvolvimento"
        token: "${API_TOKEN_DEV}"
        scopes: ["read"]
  
  # Rate limiting
  rate_limit:
    requests_per_minute: 100
    requests_per_hour: 1000
    burst: 50
  
  # Endpoints disponíveis
  endpoints:
    - path: "/chat/completions"
      method: "POST"
      description: "Envia mensagem e retorna resposta"
      input:
        - name: "message"
          type: "string"
          required: true
        - name: "conversation_id"
          type: "string"
          required: false
        - name: "user"
          type: "string"
          required: true
      output:
        - name: "answer"
          type: "string"
        - name: "conversation_id"
          type: "string"
        - name: "metadata"
          type: "object"
    
    - path: "/conversations/{id}/history"
      method: "GET"
      description: "Retorna histórico da conversa"
      parameters:
        - name: "id"
          type: "string"
          location: "path"
        - name: "limit"
          type: "integer"
          default: 20
  
  # Webhooks
  webhooks:
    on_message:
      url: "https://seu-sistema.com/webhook/message"
      events: ["created", "updated"]
    
    on_error:
      url: "https://seu-sistema.com/webhook/error"
      events: ["failed", "timeout"]
```

### MELHORIA

❌ **ERRADO:** API sem autenticação ou rate limiting
```yaml
# Inseguro - qualquer um pode usar
api:
  endpoint: "https://api.exemplo.com"
  auth: none  # Sem proteção
```

✅ **CORRETO:** Múltiplas camadas de segurança
```yaml
api:
  auth:
    type: "oauth2"
    provider: "auth0"
    client_id: "${AUTH0_CLIENT_ID}"
    client_secret: "${AUTH0_CLIENT_SECRET}"
    scopes: ["api:read", "api:write"]
    
    # JWT validation
    jwt:
      issuer: "https://auth.empresa.com"
      audience: "https://api.empresa.com"
      algorithms: ["RS256"]
  
  # Rate limiting por tenant
  rate_limit:
    strategy: "sliding_window"
    tiers:
      free:
        requests_per_minute: 10
        requests_per_day: 100
      pro:
        requests_per_minute: 100
        requests_per_day: 10000
      enterprise:
        requests_per_minute: 1000
        requests_per_day: 100000
  
  # IP whitelist
  ip_whitelist:
    - "203.0.113.0/24"
    - "198.51.100.0/24"
  
  # CORS
  cors:
    allowed_origins:
      - "https://app.empresa.com"
      - "https://admin.empresa.com"
    allowed_methods: ["GET", "POST"]
    allowed_headers: ["Authorization", "Content-Type"]
```

---

## 8. Colaboração em Equipe

Gerencie projetos, permissões e workflow de aprovação.

```yaml
# Configuração de time no Dify
team_config:
  workspace:
    name: "Empresa Tech"
    plan: "enterprise"
    
  # Equipes
  teams:
    - name: "Engenharia de IA"
      members:
        - email: "ana@empresa.com"
          role: "admin"
        - email: "pedro@empresa.com"
          role: "developer"
        - email: "maria@empresa.com"
          role: "viewer"
      
      projects:
        - "Chatbot Atendimento"
        - "Análise de Documentos"
    
    - name: "Marketing"
      members:
        - email: "joao@empresa.com"
          role: "developer"
        - email: "lucia@empresa.com"
          role: "viewer"
      
      projects:
        - "Gerador de Conteúdo"
  
  # Workflow de aprovação
  approval_workflow:
    publishing:
      required_approvers: 2
      approvers:
        - "admin@empresa.com"
        - "tech_lead@empresa.com"
      timeout: 48h
    
    model_changes:
      required_approvers: 1
      approvers:
        - "admin@empresa.com"
  
  # Versionamento
  versioning:
    enabled: true
    auto_save: true
    save_interval: "5m"
    max_versions: 50
  
  # Audit log
  audit:
    enabled: true
    events:
      - "app.created"
      - "app.published"
      - "member.invited"
      - "api_key.rotated"
    retention: "1y"
```

---

## 9. Anotação e Feedback

Coleta e utilize feedback dos usuários para melhorar respostas.

```yaml
# Sistema de Feedback no Dify
feedback_config:
  # Tipos de feedback
  types:
    - id: "thumbs"
      label: "Útil/Não Útil"
      enabled: true
    
    - id: "rating"
      label: "Avaliação 1-5"
      enabled: true
    
    - id: "tags"
      label: "Tags"
      options:
        - "Resposta correta"
        - "Resposta incorreta"
        - "Resposta incompleta"
        - "Linguagem inadequada"
        - "Outro"
    
    - id: "comment"
      label: "Comentário"
      type: "textarea"
      max_length: 500
  
  # Anotação de respostas (annotation)
  annotation:
    enabled: true
    
    # Regras de auto-anotação
    auto_rules:
      - condition: "thumbs_down AND rating <= 2"
        action: "flag_for_review"
        priority: "high"
      
      - condition: "tag == 'Resposta incorreta'"
        action: "add_to_training_data"
      
      - condition: "thumbs_up AND rating >= 4"
        action: "mark_as_good_example"
    
    # Treinamento com anotações
    training:
      enabled: true
      min_samples: 10
      trigger: "weekly"
      model_fine_tune: false
      prompt_optimization: true
  
  # Dashboard de métricas
  analytics:
    metrics:
      - "satisfaction_rate"
      - "response_accuracy"
      - "common_issues"
      - "improvement_trends"
    export_format: "csv"
    schedule: "monthly"
```

### MELHORIA

❌ **ERRADO:** Ignorar feedback negativo
```yaml
# Perde oportunidades de melhoria
feedback:
  collect: false
  # Sem dados para melhorar
```

✅ **CORRETO:** Pipeline ativo de melhoria contínua
```yaml
feedback:
  collect: true
  
  # Ação imediata sobre feedback negativo
  real_time_alerts:
    enabled: true
    channels:
      - type: "slack"
        webhook: "${SLACK_ALERTS_WEBHOOK}"
        condition: "thumbs_down AND rating <= 2"
      
      - type: "email"
        to: "ia-team@empresa.com"
        condition: "tag == 'Resposta incorreta'"
  
  # Loop de melhoria
  improvement_loop:
    collect_negative_examples: true
    human_review_queue: true
    
    # Semanal: analisa padrões
    weekly_analysis:
      enabled: true
      output: "relatorio_melhorias"
    
    # Mensal: otimiza prompts
    monthly_optimization:
      enabled: true
      auto_update_prompts: false  # Requer aprovação
      min_confidence: 0.8
  
  # Dashboard
  dashboard:
    enabled: true
    widgets:
      - type: "satisfaction_trend"
        period: "30d"
      - type: "top_issues"
        limit: 10
      - type: "response_quality"
        compare: "last_month"
```

---

## 10. Monitoramento e Logging

Monitore performance, custos e comportamento em tempo real.

```yaml
# Configuração de Monitoramento
monitoring:
  # Métricas principais
  metrics:
    - name: "response_time"
      type: "histogram"
      labels: ["model", "endpoint"]
      buckets: [0.1, 0.5, 1.0, 2.0, 5.0]
    
    - name: "token_usage"
      type: "counter"
      labels: ["model", "user"]
    
    - name: "cost_usd"
      type: "gauge"
      labels: ["model", "project"]
    
    - name: "error_rate"
      type: "counter"
      labels: ["type", "model"]
  
  # Logging
  logging:
    level: "info"
    format: "json"
    
    destinations:
      - type: "file"
        path: "/var/log/dify/app.log"
        rotation: "daily"
        retention: "30d"
      
      - type: "elasticsearch"
        hosts: ["https://es.empresa.com:9200"]
        index: "dify-logs-%{+YYYY.MM.dd}"
        auth:
          username: "${ES_USER}"
          password: "${ES_PASS}"
      
      - type: "datadog"
        api_key: "${DD_API_KEY}"
        service: "dify"
        env: "production"
    
    # Logs específicos
    specific_logs:
      llm_calls:
        enabled: true
        include_prompt: false  # Privacidade
        include_response: false
        include_tokens: true
        include_latency: true
      
      user_actions:
        enabled: true
        include_ip: true
        include_user_agent: true
      
      api_calls:
        enabled: true
        include_request_body: false
        include_response_code: true
  
  # Alertas
  alerts:
    - name: "high_error_rate"
      condition: "error_rate > 0.05"
      window: "5m"
      action:
        - type: "slack"
          channel: "#ia-alertas"
        - type: "pagerduty"
          severity: "high"
    
    - name: "slow_responses"
      condition: "p95_response_time > 3.0"
      window: "10m"
      action:
        - type: "slack"
          channel: "#ia-performance"
    
    - name: "budget_exceeded"
      condition: "daily_cost > 100"
      action:
        - type: "email"
          to: "financeiro@empresa.com"
```

---

## 11. Suporte Multi-Idioma (i18n)

Implemente suporte a múltiplos idiomas nos seus aplicativos.

```yaml
# Configuração i18n no Dify
i18n_config:
  # Idiomas suportados
  supported_languages:
    - code: "pt-BR"
      name: "Português (Brasil)"
      is_default: true
      greeting: "Olá! Como posso ajudar?"
    
    - code: "en-US"
      name: "English (US)"
      greeting: "Hello! How can I help you?"
    
    - code: "es-ES"
      name: "Español (España)"
      greeting: "¡Hola! ¿Cómo puedo ayudar?"
    
    - code: "ja-JP"
      name: "日本語"
      greeting: "こんにちは！お手伝いできますか？"
  
  # Auto-detecção de idioma
  auto_detect:
    enabled: true
    fallback: "pt-BR"
    
    # Prompt de tradução
    translation_prompt: |
      Detecte o idioma da mensagem e responda no mesmo idioma.
      Se não conseguir detectar, responda em {{idioma_padrao}}.
  
  # Tradução automática de prompts
  prompt_translation:
    enabled: true
    target_languages: ["en-US", "es-ES"]
    auto_translate: false  # Requer aprovação
  
  # Respostas contextuais
  context_aware:
    # Adaptar conteúdo por região
    regional_adjustments:
      pt-BR:
        currency: "BRL"
        date_format: "DD/MM/YYYY"
        number_format: "1.234,56"
      en-US:
        currency: "USD"
        date_format: "MM/DD/YYYY"
        number_format: "1,234.56"
```

---

## 12. Marketplace de Templates

Publique e compartilhe templates prontos para acelerar o desenvolvimento.

```yaml
# Configuração do Marketplace
marketplace:
  # Templates disponíveis
  templates:
    - id: "customer_support"
      name: "Chatbot de Atendimento ao Cliente"
      description: "Template completo com RAG, tools e handoff humano"
      category: "atendimento"
      tags: ["chatbot", "rag", "suporte"]
      author: "Dify Team"
      version: "2.1.0"
      downloads: 15000
      rating: 4.8
      
      components:
        - "workflow_principal"
        - "knowledge_base_faq"
        - "tool_crm_lookup"
        - "human_handoff"
      
      config:
        models:
          primary: "gpt-4"
          fallback: "gpt-3.5-turbo"
    
    - id: "document_analyzer"
      name: "Analisador de Documentos"
      description: "Extrai informações de PDFs e documentos"
      category: "análise"
      tags: ["rag", "documents", "extraction"]
      
      components:
        - "workflow_extraction"
        - "knowledge_base_docs"
        - "tool_pdf_parser"
    
    - id: "content_generator"
      name: "Gerador de Conteúdo"
      description: "Gera posts, artigos e copies"
      category: "marketing"
      tags: ["content", "marketing", "copywriting"]
  
  # Publicar template
  publish:
    requirements:
      - "name: required"
      - "description: required"
      - "category: required"
      - "components: at_least_one"
      - "documentation: recommended"
    
    review_process:
      auto_check: true
      human_review: false
      quality_score_min: 3.5
```

---

## 13. Variáveis de Conversa

Gerencie estado e contexto ao longo de conversas.

```yaml
# Variáveis de Conversa no Dify
conversation_variables:
  # Variáveis pré-definidas
  predefined:
    - name: "user_name"
      source: "user_input"
      type: "string"
      description: "Nome do usuário"
    
    - name: "conversation_id"
      source: "system"
      type: "string"
      description: "ID único da conversa"
    
    - name: "message_count"
      source: "system"
      type: "integer"
      description: "Número de mensagens na conversa"
  
  # Variáveis customizadas
  custom:
    - name: "contexto_projeto"
      type: "string"
      scope: "conversation"
      description: "Contexto do projeto em discussão"
      initial_value: ""
    
    - name: "preferencias_usuario"
      type: "object"
      scope: "user"
      schema:
        idioma: "string"
        nivel_detalhe: "string"
        formato_saida: "string"
    
    - name: "historico_decisoes"
      type: "array"
      scope: "conversation"
      items:
        type: "object"
        properties:
          pergunta: "string"
          decisao: "string"
          timestamp: "datetime"
  
  # Uso em prompts
  prompt_integration: |
    Contexto da conversa:
    - Projeto: {{contexto_projeto}}
    - Preferências: {{preferencias_usuario}}
    - Decisões anteriores: {{historico_decisoes}}
    
    Mensagem do usuário: {{user_message}}
  
  # Persistência
  persistence:
    type: "redis"
    host: "${REDIS_HOST}"
    ttl: 3600  # 1 hora
    serialize: "json"
```

---

## 14. Triggers Agendados

Execute workflows automaticamente em horários ou eventos específicos.

```yaml
# Configuração de Triggers
scheduled_triggers:
  # Triggers baseados em tempo
  cron:
    - name: "relatorio_diario"
      schedule: "0 8 * * *"  # 8:00 AM diariamente
      workflow: "gerar_relatorio"
      params:
        periodo: "últimas 24h"
        destinatarios: ["gerencia@empresa.com"]
    
    - name: "limpeza_semanal"
      schedule: "0 2 * * 0"  # Domingos às 2:00 AM
      workflow: "limpar_conversas_antigas"
      params:
        dias_manter: 30
  
  # Triggers baseados em eventos
  event_based:
    - name: "novo_lead"
      event: "webhook_received"
      source: "crm"
      workflow: "qualificar_lead"
      filter: "event.type == 'lead.created'"
    
    - name: "ticket_urgente"
      event: "webhook_received"
      source: "zendesk"
      workflow: "responder_ticket"
      filter: "event.priority == 'urgent'"
  
  # Triggers de fila
  queue:
    - name: "processar_pedidos"
      queue: "pedidos_pendentes"
      workflow: "processar_pedido"
      concurrency: 5
      retry:
        max_attempts: 3
        delay: 60
  
  # Webhooks de entrada
  webhooks:
    - name: "stripe_payment"
      url: "/webhook/stripe"
      method: "POST"
      workflow: "processar_pagamento"
      auth:
        type: "signature"
        secret: "${STRIPE_WEBHOOK_SECRET}"
        header: "stripe-signature"
```

---

## 15. Integração com LangChain e Outros Frameworks

Combine Dify com outros frameworks para capacidades avançadas.

```python
# Integração via API do Dify
import requests

class DifyClient:
    def __init__(self, base_url: str, api_key: str):
        self.base_url = base_url
        self.headers = {
            "Authorization": f"Bearer {api_key}",
            "Content-Type": "application/json"
        }
    
    def chat(self, message: str, user: str, 
             conversation_id: str = None) -> dict:
        """Envia mensagem para o workflow Dify."""
        payload = {
            "inputs": {},
            "query": message,
            "response_mode": "blocking",
            "user": user
        }
        if conversation_id:
            payload["conversation_id"] = conversation_id
        
        response = requests.post(
            f"{self.base_url}/v1/chat-messages",
            json=payload,
            headers=self.headers
        )
        return response.json()
    
    def completion(self, prompt: str, user: str) -> dict:
        """Envia prompt de completion."""
        payload = {
            "inputs": {},
            "query": prompt,
            "response_mode": "blocking",
            "user": user
        }
        
        response = requests.post(
            f"{self.base_url}/v1/completion-messages",
            json=payload,
            headers=self.headers
        )
        return response.json()
    
    def upload_file(self, file_path: str, user: str) -> dict:
        """Faz upload de arquivo para o Dify."""
        with open(file_path, 'rb') as f:
            files = {'file': f}
            data = {'user': user}
            response = requests.post(
                f"{self.base_url}/v1/files/upload",
                files=files,
                data=data,
                headers={"Authorization": self.headers["Authorization"]}
            )
        return response.json()

# Uso
client = DifyClient(
    base_url="https://api.seu-dify.com",
    api_key="app-xxx"
)

# Chat interativo
resposta = client.chat(
    message="Quais são os planos disponíveis?",
    user="usuario123"
)
print(resposta["answer"])

# Completion
relatorio = client.completion(
    prompt="Gere um relatório de vendas do mês",
    user="analista"
)
```

### MELHORIA

❌ **ERRADO:** Não tratar erros de API
```python
# Pode falhar silenciosamente
resposta = client.chat("olá", "user")
print(resposta["answer"])  # KeyError se API falhar
```

✅ **CORRETO:** Tratamento robusto de erros
```python
import logging
from tenacity import retry, stop_after_attempt, wait_exponential

class DifyClientRobusto(DifyClient):
    @retry(
        stop=stop_after_attempt(3),
        wait=wait_exponential(multiplier=1, min=2, max=10)
    )
    def _request(self, method: str, endpoint: str, **kwargs) -> dict:
        """Request com retry e tratamento de erros."""
        try:
            response = requests.request(
                method,
                f"{self.base_url}{endpoint}",
                headers=self.headers,
                timeout=30,
                **kwargs
            )
            response.raise_for_status()
            return response.json()
        
        except requests.exceptions.Timeout:
            logging.error("Timeout na requisição Dify")
            raise
        
        except requests.exceptions.HTTPError as e:
            if e.response.status_code == 429:
                logging.warning("Rate limit atingido")
                raise
            elif e.response.status_code >= 500:
                logging.error(f"Erro servidor Dify: {e.response.status_code}")
                raise
            else:
                logging.error(f"Erro cliente: {e.response.text}")
                raise
        
        except requests.exceptions.ConnectionError:
            logging.error("Falha de conexão com Dify")
            raise
    
    def chat(self, message: str, user: str, **kwargs) -> dict:
        """Chat com tratamento de erros."""
        resultado = self._request(
            "POST",
            "/v1/chat-messages",
            json={
                "inputs": {},
                "query": message,
                "response_mode": "blocking",
                "user": user,
                **kwargs
            }
        )
        return resultado
```

---

## Referências

- **Documentação Oficial:** https://docs.dify.ai/
- **GitHub:** https://github.com/langgenius/dify
- **API Reference:** https://docs.dify.ai/guides/application-publishing/developing-with-apis
- **Community:** https://community.dify.ai/
