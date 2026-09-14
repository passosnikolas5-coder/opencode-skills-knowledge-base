# Catálogo Completo de Skills de Data — v2 Aprimorada

> Gerado em: 2026-09-14
> Fonte: Arquivos SKILL.md dos category-pointers do OpenCode
> Total de skills documentadas: **69**
> Categorias: **7**
> Versão aprimorada com: exemplos práticos, casos de uso avançados, integrações, padrões/anti-padrões, dicas de performance, comandos úteis e referências.

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

**Descrição:** Acesso a 20+ anos de dados financeiros globais: ações, opções, forex, criptomoedas, commodities, indicadores econômicos e 50+ indicadores técnicos.

**Quando usar:**
- Consultar histórico de preços de ações para análise técnica
- Obter cotações de moedas (forex) em tempo real
- Construir dashboards financeiros com dados históricos
- Alimentar modelos de previsão financeira

**Exemplos práticos:**

```python
# Exemplo 1: Buscar histórico de preços de uma ação
import requests

API_KEY = "sua_chave"
symbol = "AAPL"
url = f"https://www.alphavantage.co/query?function=TIME_SERIES_DAILY&symbol={symbol}&apikey={API_KEY}"
response = requests.get(url)
data = response.json()
print(data["Time Series (Daily)"])
```

```python
# Exemplo 2: Obter indicador técnico RSI
url = f"https://www.alphavantage.co/query?function=RSI&symbol={symbol}&interval=daily&time_period=14&series_type=close&apikey={API_KEY}"
rsi_data = requests.get(url).json()
print(rsi_data["Technical Analysis: RSI"])
```

```python
# Exemplo 3: Cotação forex em tempo real
url = f"https://www.alphavantage.co/query?function=CURRENCY_EXCHANGE_RATE&from_currency=USD&to_currency=BRL&apikey={API_KEY}"
fx_data = requests.get(url).json()
print(fx_data["Realtime Currency Exchange Rate"])
```

**Casos de uso avançados:**
- **Sistema de sinais de trading:** Combinar RSI, MACD e Bollinger Bands para gerar sinais automáticos de compra/venda
- **Backtesting de estratégias:** Usar dados históricos de 10+ anos para simular estratégias de investimento
- **Alertas de mercado:** Monitorar indicadores técnicos e disparar notificações quando atingirem limiares críticos

**Integração com outras skills:**
- `data-scientist`: para construir modelos preditivos com os dados obtidos
- `plotly`: para criar dashboards interativos de análise técnica
- `spark-optimization`: para processar grandes volumes de dados financeiros

**Padrões e anti-padrões:**
✅ Fazer: Cache de dados para evitar exceder rate limits (5 requests/minuto no plano gratuito)
✅ Fazer: Validar dados antes de usar em modelos
❌ Evitar: Fazer múltiplas requests simultâneas (viola rate limit)
❌ Evitar: Usar dados sem verificar qualidade e completude

**Dicas de performance:**
- Implementar cache local (Redis ou SQLite) para dados consultados frequentemente
- Usar batch requests quando disponível
- Consultar dados intraday apenas quando necessário (mais pesados)

**Comandos úteis:**
```bash
# Instalar dependências
pip install requests pandas alpha-vantage

# Script rápido de teste
python -c "
from alpha_vantage.timeseries import TimeSeries
ts = TimeSeries(key='SUA_CHAVE')
data, meta = ts.get_daily('AAPL', outputsize='compact')
print(data.head())
"
```

**Referências:**
- [Documentação Alpha Vantage](https://www.alphavantage.co/documentation/)
- [Lista de indicadores técnicos](https://www.alphavantage.co/documentation/#technical-indicators)
- [Exemplos de uso](https://github.com/RomelTorres/alpha_vantage)

---

### 1.2 amplitude-automation

**Descrição:** Automatizar tarefas no Amplitude via Rube MCP (Composio): eventos, atividade de usuários, coortes, identificação de usuários.

**Quando usar:**
- Criar automações de extração de dados do Amplitude
- Analisar coortes de retenção semanalmente
- Identificar padrões de comportamento de usuários
- Integrar dados do Amplitude com sistemas externos

**Exemplos práticos:**

```python
# Exemplo 1: Extrair dados de coorte de retenção
# Via Composio/Rube MCP
coorte_data = amplitude.get_cohort(
    cohort_id="retention_weekly",
    start_date="2026-01-01",
    end_date="2026-03-31"
)
```

```python
# Exemplo 2: Identificar usuários churned
users = amplitude.query_users(
    event="App Open",
    last_seen_before="2026-06-01",
    last_seen_after="2026-03-01"
)
```

```python
# Exemplo 3: Criar evento customizado
amplitude.create_event(
    name="Feature Used",
    user_properties={"plan": "premium"},
    event_properties={"feature": "export_csv"}
)
```

**Casos de uso avançados:**
- **Pipeline de retenção automatizado:** Extrair dados de coorte semanal, processar e gerar relatório executivo automaticamente
- **Segmentação dinâmica:** Criar segmentos baseados em comportamento e sincronizar com ferramentas de marketing
- **Alertas de engajamento:** Monitorar queda de engajamento e disparar notificações para a equipe de produto

**Integração com outras skills:**
- `analytics-product`: para complementar com funis e métricas de produto
- `segment-cdp`: para enviar dados do Amplitude para outros destinos
- `data-storytelling`: para transformar os dados em narrativas executivas

**Padrões e anti-padrões:**
✅ Fazer: Documentar todos os eventos rastreados em um tracking plan
✅ Fazer: Usar IDs de usuário consistentes entre sistemas
❌ Evitar: Enviar eventos sem propriedades contextuais
❌ Evitar: Criar eventos duplicados com nomes similares

**Dicas de performance:**
- Usar batch API para enviar múltiplos eventos de uma vez
- Implementar retry com backoff exponencial para falhas de conexão
- Limitar frequência de queries para não sobrecarregar a API

**Comandos úteis:**
```bash
# Via Composio CLI
composio add amplitude
composio execute amplitude.get_cohort --cohort_id="retention_weekly"
```

**Referências:**
- [Amplitude API Docs](https://developers.amplitude.com/)
- [Composio Integration](https://docs.composio.dev/)
- [Amplitude Cohort Analysis](https://amplitude.com/docs/analytics/charts/cohort-analysis)

---

### 1.3 analytics-product

**Descrição:** Analytics de produto — PostHog, Mixpanel, eventos, funnels, coortes, retenção, north star metric, OKRs e dashboards de produto.

**Quando usar:**
- Configurar e analisar funis de conversão
- Medir retenção de usuários por cohort
- Definir e acompanhar OKRs de produto
- Criar dashboards de métricas de produto

**Exemplos práticos:**

```python
# Exemplo 1: Analisar funil de conversão no PostHog
from posthog import PostHog

client = PostHog("sua_chave_api")
funnel = client.post("/api/projects/1/funnels/", json={
    "events": [
        {"id": "pageview", "name": "Pageview"},
        {"id": "signup", "name": "Signup"},
        {"id": "purchase", "name": "Purchase"}
    ],
    "date_from": "2026-01-01",
    "date_to": "2026-03-31"
})
```

```python
# Exemplo 2: Calcular taxa de retenção
retention = client.post("/api/projects/1/retentions/", json={
    "period": "week",
    "date_range": {"date_from": "2026-01-01"},
    "actions": [{"id": "signup", "type": "actions"}],
    "returning_actions": [{"id": "purchase", "type": "actions"}]
})
```

```python
# Exemplo 3: Criar métrica North Star
north_star = {
    "name": "Weekly Active Users",
    "definition": "Distinct users with at least 1 session",
    "target": 10000,
    "current": 8500,
    "trend": "growing"
}
```

**Casos de uso avançados:**
- **Análise de liberarção de features:** Medir impacto de uma nova feature na retenção e engajamento
- **Otimização de onboarding:** Usar funis para identificar onde usuários abandonam e testar melhorias
- **Score de produto:** Criar um score composto de engajamento para priorizar investimentos

**Integração com outras skills:**
- `amplitude-automation`: para automações avançadas no Amplitude
- `mixpanel-automation`: para workflows no Mixpanel
- `data-storytelling`: para comunicar insights para stakeholders

**Padrões e anti-padrões:**
✅ Fazer: Definir um tracking plan antes de implementar eventos
✅ Fazer: Usar naming consistente para eventos (snake_case)
❌ Evitar: Rastrear cada clique sem critério (noise nos dados)
❌ Evitar: Mudar definições de métricas sem documentar

**Dicas de performance:**
- Usar batch imports para dados históricos
- Configurar sampling para eventos de alta frequência
- Implementar aggregation servers para métricas em tempo real

**Comandos úteis:**
```bash
# PostHog CLI
posthog export --token=SUA_CHAVE --project=1 --start=2026-01-01

# Mixpanel CLI
mixpanel export --from 2026-01-01 --to 2026-03-31 --event "Purchase"
```

**Referências:**
- [PostHog Documentation](https://posthog.com/docs)
- [Mixpanel Documentation](https://docs.mixpanel.com/)
- [Product Analytics Best Practices](https://posthog.com/blog/product-analytics-guide)

---

### 1.4 analytics-tracking

**Descrição:** Projetar, auditar e melhorar sistemas de rastreamento de analytics que produzem dados confiáveis e prontos para decisão.

**Quando usar:**
- Auditar tracking existente para identificar gaps
- Projetar tracking do zero para novo produto
- Corrigir dados inconsistentes ou duplicados
- Implementar tracking server-side

**Exemplos práticos:**

```javascript
// Exemplo 1: Tracking server-side com Schema Validation
const trackEvent = (event) => {
  const schema = {
    event_name: { type: 'string', required: true },
    user_id: { type: 'string', required: true },
    timestamp: { type: 'date', required: true },
    properties: { type: 'object', required: false }
  };
  
  // Validar antes de enviar
  const isValid = validateSchema(event, schema);
  if (!isValid) {
    console.error('Evento inválido:', event);
    return;
  }
  
  // Enviar para analytics
  analytics.track(event.event_name, event);
};
```

```python
# Exemplo 2: Auditoria de tracking
def audit_tracking(events_log):
    issues = []
    
    # Verificar eventos duplicados
    event_names = [e['name'] for e in events_log]
    duplicates = [name for name in event_names if event_names.count(name) > 1]
    if duplicates:
        issues.append(f"Eventos duplicados: {set(duplicates)}")
    
    # Verificar eventos sem user_id
    missing_user = [e for e in events_log if not e.get('user_id')]
    if missing_user:
        issues.append(f"Eventos sem user_id: {len(missing_user)}")
    
    return issues
```

```sql
-- Exemplo 3: Query de auditoria no data warehouse
SELECT 
  event_name,
  COUNT(*) as total_events,
  COUNT(DISTINCT user_id) as unique_users,
  COUNT(CASE WHEN user_id IS NULL THEN 1 END) as missing_user_id,
  MIN(created_at) as first_seen,
  MAX(created_at) as last_seen
FROM events
WHERE created_at >= CURRENT_DATE - 30
GROUP BY event_name
ORDER BY total_events DESC;
```

**Casos de uso avançados:**
- **Migração de tracking:** Migrar de Segment para Amplitude mantendo consistência de dados
- **Compliance de dados:** Implementar tracking que respeite LGPD/GDPR com consent management
- **Tracking de attribution:** Implementar multi-touch attribution para campanhas de marketing

**Integração com outras skills:**
- `segment-cdp`: para implementar tracking com Segment
- `analytics-product`: para usar os dados rastreados em análises
- `database-security`: para garantir que tracking não exponha dados sensíveis

**Padrões e anti-padrões:**
✅ Fazer: Documentar cada evento em um tracking plan centralizado
✅ Fazer: Usar validação de schema antes de enviar eventos
❌ Evitar: Rastrear dados pessoais sem consentimento
❌ Evitar: Usar nomes de eventos ambíguos ou inconsistentes

**Dicas de performance:**
- Implementar batching de eventos (enviar a cada 30 segundos ou 50 eventos)
- Usar sampling para eventos de alta frequência (>1M/dia)
- Implementar circuit breaker para falhas de envio

**Comandos úteis:**
```javascript
// Validador de schema de eventos
const validateEvent = (event, schema) => {
  const errors = [];
  for (const [key, rules] of Object.entries(schema)) {
    if (rules.required && !event[key]) {
      errors.push(`${key} é obrigatório`);
    }
    if (event[key] && typeof event[key] !== rules.type) {
      errors.push(`${key} deve ser do tipo ${rules.type}`);
    }
  }
  return errors.length === 0 ? null : errors;
};
```

**Referências:**
- [Segment Tracking Plan](https://segment.com/docs/protocols/tracking-plan/)
- [Snowplow Analytics](https://docs.snowplow.io/)
- [Analytics Implementation Guide](https://www.cookieserve.com/guides/tracking-guide/)

---

### 1.5 arrowspace

**Descrição:** Busca vetorial espectral usando autoestrutura de laplaciano de grafos. Usar quando similaridade coseno/L2 falha em capturar estrutura latente em embeddings.

**Quando usar:**
- Técnicas tradicionais (coseno, L2) não capturam relações semânticas profundas
- Precisa de agrupamentos temáticos latentes em embeddings
- Busca semântica com estrutura de grafo

**Exemplos práticos:**

```python
# Exemplo 1: Busca espectral em embeddings
import numpy as np
from arrowspace import SpectralSearch

# Carregar embeddings
embeddings = np.load("document_embeddings.npy")

# Inicializar busca espectral
searcher = SpectralSearch(embeddings)

# Buscar documentos similares
query_embedding = model.encode("machine learning algorithms")
results = searcher.search(query_embedding, k=10)
```

```python
# Exemplo 2: Construir grafo de similaridade
from arrowspace import build_graph

# Construir grafo a partir de embeddings
graph = build_graph(
    embeddings=embeddings,
    threshold=0.7,  # Similaridade mínima
    method="knn",   # k-nearest neighbors
    k=20
)

# Obter comunidades temáticas
communities = graph.detect_communities()
```

```python
# Exemplo 3: Clustering espectral
from arrowspace import SpectralClustering

clustering = SpectralClustering(
    n_clusters=5,
    affinity="rbf",
    gamma=1.0
)
labels = clustering.fit_predict(embeddings)
```

**Casos de uso avançados:**
- **Sistema de recomendação de conteúdo:** Usar busca espectral para encontrar conteúdo relacionado não óbvio
- **Deduplicação semântica:** Identificar documentos com conteúdo similar mas vocabulário diferente
- **Análise de tópicos:** Descobrir tópicos latentes em coleções de documentos

**Integração com outras skills:**
- `embedding-strategies`: para escolher o melhor modelo de embedding
- `similarity-search-patterns`: para comparar com métodos tradicionais
- `vector-database-engineer`: para armazenar e indexar os resultados

**Padrões e anti-padrões:**
✅ Fazer: Pré-processar embeddings antes de aplicar busca espectral
✅ Fazer: Ajustar parâmetros de threshold baseado no domínio
❌ Evitar: Usar em datasets muito pequenos (<100 documentos)
❌ Evitar: Ignorar custo computacional de grafos grandes

**Dicas de performance:**
- Usar aproximações para grafos com >100k nós
- Implementar indexação de grafos para consultas rápidas
- Pré-computar decomposição espectral para dados estáticos

**Comandos úteis:**
```bash
pip install arrowspace numpy scipy
```

**Referências:**
- [Spectral Methods in ML](https://scikit-learn.org/stable/modules/clustering.html#spectral-clustering)
- [Graph Laplacian](https://en.wikipedia.org/wiki/Laplacian_matrix)
- [Arrowspace Documentation](https://github.com/arrowspace/arrowspace)

---

### 1.6 data-engineer

**Descrição:** Construir pipelines de dados escaláveis, data warehouses modernos e arquiteturas de streaming em tempo real. Implementa Apache Spark, dbt, Airflow e plataformas de dados nativas da nuvem.

**Quando usar:**
- Projetar pipelines de dados em produção
- Migrar para arquiteturas modernas de dados
- Resolver problemas de performance em ETL
- Implementar data lakes ou lakehouses

**Exemplos práticos:**

```python
# Exemplo 1: Pipeline de streaming com Spark Structured Streaming
from pyspark.sql import SparkSession
from pyspark.sql.functions import *

spark = SparkSession.builder \
    .appName("ClickStreamProcessing") \
    .getOrCreate()

# Ler de Kafka
raw_stream = spark.readStream \
    .format("kafka") \
    .option("kafka.bootstrap.servers", "localhost:9092") \
    .option("subscribe", "click_events") \
    .load()

# Processar e escrever em Delta Lake
processed = raw_stream \
    .select(from_json(col("value").cast("string"), schema).alias("data")) \
    .select("data.*") \
    .withWatermark("timestamp", "10 minutes") \
    .groupBy(window("timestamp", "5 minutes"), "page") \
    .count()

processed.writeStream \
    .format("delta") \
    .outputMode("update") \
    .option("checkpointLocation", "/checkpoint/clicks") \
    .start("/delta/clicks_agg")
```

```python
# Exemplo 2: dbt model incremental
# models/staging/stg_orders.sql
{{ config(
    materialized='incremental',
    unique_key='order_id',
    incremental_strategy='merge'
) }}

with source as (
    select * from {{ source('raw', 'orders') }}
),
transformed as (
    select
        order_id,
        customer_id,
        order_date,
        total_amount,
        status,
        _loaded_at
    from source
    where _loaded_at > (select max(_loaded_at) from {{ this }})
)
select * from transformed
```

```python
# Exemplo 3: DAG Airflow
from airflow import DAG
from airflow.operators.python import PythonOperator
from datetime import datetime, timedelta

default_args = {
    'owner': 'data-team',
    'retries': 3,
    'retry_delay': timedelta(minutes=5)
}

with DAG(
    'daily_etl_pipeline',
    default_args=default_args,
    schedule_interval='0 2 * * *',
    start_date=datetime(2026, 1, 1),
    catchup=False
) as dag:
    
    extract = PythonOperator(task_id='extract', python_callable=extract_data)
    transform = PythonOperator(task_id='transform', python_callable=transform_data)
    load = PythonOperator(task_id='load', python_callable=load_data)
    
    extract >> transform >> load
```

**Casos de uso avançados:**
- **Data Lakehouse:** Implementar arquitetura Delta Lake com camadas bronze/silver/gold
- **CDC Real-time:** Configurar Change Data Capture com Debezium + Kafka para replicação em tempo real
- **Data Quality Pipeline:** Implementar pipeline com Great Expectations + dbt para validação contínua

**Integração com outras skills:**
- `dbt-transformation-patterns`: para padrões avançados de dbt
- `spark-optimization`: para otimizar jobs Spark
- `snowflake-development`: para integração com Snowflake
- `data-quality-frameworks`: para qualidade de dados

**Padrões e anti-padrões:**
✅ Fazer: Implementar monitoramento e alertas em todos os pipelines
✅ Fazer: Usar schema registry para gerenciar schemas de dados
❌ Evitar: ETL monolítico que faz tudo em um único job
❌ Evitar: Ignorar idempotência nas transformações

**Dicas de performance:**
- Usar particionamento correto em tabelas Delta/Iceberg
- Implementar caching de dados frequentemente acessados
- Usar broadcast joins para tabelas pequenas em Spark
- Configurar auto-optimize em Delta Lake

**Comandos úteis:**
```bash
# Spark submit
spark-submit --master yarn --deploy-mode cluster \
  --executor-memory 8g --executor-cores 4 \
  --num-executors 10 etl_job.py

# dbt run
dbt run --select tag:daily --full-refresh

# Airflow
airflow dags list
airflow tasks test daily_etl_pipeline extract 2026-01-01
```

**Referências:**
- [Apache Spark Documentation](https://spark.apache.org/docs/latest/)
- [dbt Documentation](https://docs.getdbt.com/)
- [Apache Airflow](https://airflow.apache.org/docs/)
- [Delta Lake](https://docs.delta.io/latest/)

---

### 1.7 dbt-transformation-patterns

**Descrição:** Padrões de transformação production-ready para dbt (data build tool): organização de modelos, estratégias de teste, documentação e processamento incremental.

**Quando usar:**
- Desenvolver ou revisar projetos dbt
- Configurar modelos incrementais
- Definir estratégias de teste e documentação
- Refatorar projetos dbt existentes

**Exemplos práticos:**

```sql
-- Exemplo 1: Modelo incremental com merge strategy
{{ config(
    materialized='incremental',
    unique_key='order_id',
    incremental_strategy='merge',
    on_schema_change='sync_all_columns'
) }}

with orders as (
    select * from {{ ref('stg_orders') }}
),
customers as (
    select * from {{ ref('stg_customers') }}
),
joined as (
    select
        o.order_id,
        o.order_date,
        o.total_amount,
        c.customer_name,
        c.segment
    from orders o
    join customers c on o.customer_id = c.customer_id
)
select * from joined

{% if is_incremental() %}
where order_date > (select max(order_date) from {{ this }})
{% endif %}
```

```sql
-- Exemplo 2: Testes customizados
-- tests/test_positive_amount.sql
select *
from {{ ref('fct_orders') }}
where total_amount <= 0
```

```yaml
# Exemplo 3: Schema.yml com testes completos
version: 2

models:
  - name: fct_orders
    description: "Tabela de fatos de pedidos"
    columns:
      - name: order_id
        description: "Chave primária do pedido"
        tests:
          - unique
          - not_null
      - name: customer_id
        description: "FK para dimensão de clientes"
        tests:
          - not_null
          - relationships:
              to: ref('dim_customers')
              field: customer_id
      - name: total_amount
        description: "Valor total do pedido"
        tests:
          - not_null
          - dbt_utils.accepted_range:
              min_value: 0
              max_value: 1000000

sources:
  - name: raw
    database: raw
    schema: ecommerce
    tables:
      - name: orders
        loaded_at_field: _loaded_at
        freshness:
          warn_after: {count: 6, period: hour}
          error_after: {count: 24, period: hour}
```

**Casos de uso avançados:**
- **Multi-warehouse:** Configurar dbt para rodar em múltiplos warehouses (BigQuery + Snowflake)
- **Data Mesh:** Implementar domínios de dados com dbt packages para cada equipe
- **Cost Optimization:** Usar projetos dbt para otimizar custos de BigQuery com partição e clustering

**Integração com outras skills:**
- `data-quality-frameworks`: para testes avançados de qualidade
- `snowflake-development`: para otimizações específicas do Snowflake
- `postgres-best-practices`: para padrões PostgreSQL
- `monte-carlo-validation-notebook`: para validação antes de merge

**Padrões e anti-padrões:**
✅ Fazer: Usar staging models para camada de extração
✅ Fazer: Implementar testes em todos os modelos
✅ Fazer: Documentar modelos com descrições claras
❌ Evitar: Lógica de negócio complexa em modelos de staging
❌ Evitar: Usar select * em produção

**Dicas de performance:**
- Usar `dbt run --select tag:incremental` para rodar apenas incrementais
- Configurar `profiles.yml` com threads apropriados
- Usar `dbt compile` para verificar SQL antes de rodar

**Comandos úteis:**
```bash
# Rodar modelos específicos
dbt run --select model_name

# Rodar testes
dbt test --select model_name

# Gerar documentação
dbt docs generate
dbt docs serve

# Depurar query
dbt compile --select model_name
```

**Referências:**
- [dbt Documentation](https://docs.getdbt.com/)
- [dbt Best Practices](https://docs.getdbt.com/guides/best-practices)
- [dbt Package Hub](https://hub.getdbt.com/)

---

### 1.8 firecrawl-scraper

**Descrição:** Web scraping profundo, capturas de tela, parsing de PDFs e crawling de sites usando a API Firecrawl.

**Quando usar:**
- Extrair conteúdo de páginas que requerem JavaScript
- Obter screenshots de páginas web
- Fazer parsing de PDFs
- Crawling de sites inteiros

**Exemplos práticos:**

```python
# Exemplo 1: Scraping de página com JavaScript
from firecrawl import FirecrawlApp

app = FirecrawlApp(api_key="sua_chave")

result = app.scrape_url(
    url="https://example.com/dynamic-page",
    params={
        'formats': ['markdown', 'html'],
        'waitFor': 2000  # Esperar JS renderizar
    }
)
print(result['markdown'])
```

```python
# Exemplo 2: Crawl de site inteiro
crawl_result = app.crawl_url(
    url="https://example.com",
    params={
        'limit': 100,
        'scrapeOptions': {
            'formats': ['markdown'],
            'onlyMainContent': True
        }
    }
)

for page in crawl_result['data']:
    print(f"URL: {page['metadata']['sourceURL']}")
    print(f"Content: {page['markdown'][:200]}...")
```

```python
# Exemplo 3: Captura de screenshot
screenshot = app.scrape_url(
    url="https://example.com",
    params={
        'formats': ['screenshot'],
        'screenshotQuality': 'high'
    }
)
# Salvar screenshot
with open('page_screenshot.png', 'wb') as f:
    f.write(screenshot['screenshot'])
```

**Casos de uso avançados:**
- **Monitoramento de concorrência:** Crawling periódico de páginas de produtos de concorrentes para análise de preços
- **Indexação de conteúdo:** Extrair e indexar conteúdo de documentação técnica para busca interna
- **Análise de sentimento:** Coletar reviews e comentários de múltiplas páginas para análise

**Integração com outras skills:**
- `web-scraper`: para compilar resultados com outros métodos de scraping
- `exa-search`: para encontrar páginas relevantes antes de fazer crawl
- `rag-engineer`: para alimentar knowledge bases com conteúdo extraído

**Padrões e anti-padrões:**
✅ Fazer: Respetar robots.txt e limitar taxa de requests
✅ Fazer: Implementar retry com backoff para falhas
❌ Evitar: Fazer crawl agressivo que sobrecarrega o servidor
❌ Evitar: Extrair dados pessoais sem consentimento

**Dicas de performance:**
- Usar crawling seletivo (apenas URLs relevantes)
- Implementar cache de páginas já visitadas
- Usar parallel crawling para sites grandes

**Comandos úteis:**
```bash
# Instalar SDK
pip install firecrawl

# Teste rápido
python -c "
from firecrawl import FirecrawlApp
app = FirecrawlApp(api_key='SUA_CHAVE')
result = app.scrape_url('https://example.com', params={'formats': ['markdown']})
print(result['markdown'][:500])
"
```

**Referências:**
- [Firecrawl Documentation](https://docs.firecrawl.dev/)
- [Firecrawl API Reference](https://docs.firecrawl.dev/api-reference)
- [GitHub Firecrawl](https://github.com/mendableai/firecrawl)

---

### 1.9 mixpanel-automation

**Descrição:** Automatizar tarefas no Mixpanel via Rube MCP (Composio): eventos, segmentação, funnels, coortes, perfis de usuários, consultas JQL.

**Quando usar:**
- Extrair dados de funis do Mixpanel
- Segmentar usuários por comportamento
- Consultar eventos via JQL
- Automatizar relatórios semanais

**Exemplos práticos:**

```python
# Exemplo 1: Extrair dados de funnel
from mixpanel import Mixpanel

mp = Mixpanel("sua_chave")

funnel = mp.funnel(
    funnel_id=12345,
    from_date="2026-01-01",
    to_date="2026-03-31"
)
print(f"Conversão: {funnel['overall_conversion_rate']}%")
```

```python
# Exemplo 2: Consulta JQL para segmentação
query = """
return Events({
    from_date: '2026-01-01',
    to_date: '2026-03-31',
    event_selectors: [{event: 'Purchase'}],
    on_selectors_clone: ['$last_touch']
}).groupBy(
    Mixpanel.Events.properties.$country,
    function(event) { return event.length; }
);
"""

results = mp.jql(query)
```

```python
# Exemplo 3: Buscar perfil de usuário
user_profile = mp.people_get("user_123")
print(f"Plano: {user_profile['$properties']['plan']}")
print(f"Último login: {user_profile['$properties']['$last_login']}")
```

**Casos de uso avançados:**
- **Análise de coortes avançada:** Criar coortes baseadas em comportamento e medir LTV
- **Attribution modeling:** Usar JQL para implementar multi-touch attribution
- **Auditoria de dados:** Verificar consistência entre eventos e perfis de usuários

**Integração com outras skills:**
- `analytics-product`: para complementar com outras ferramentas de produto
- `data-storytelling`: para comunicar insights de produto
- `segment-cdp`: para enviar dados do Mixpanel para outros destinos

**Padrões e anti-padrões:**
✅ Fazer: Documentar consultas JQL para reutilização
✅ Fazer: Usar aliases em eventos para consistência
❌ Evitar: Consultas JQL complexas que consomem muitos recursos
❌ Evitar: Exportar dados pessoais sem necessidade

**Dicas de performance:**
- Usar export API para grandes volumes de dados
- Implementar cache de consultas frequentes
- Agendar exportações em horários de baixo uso

**Comandos úteis:**
```bash
# Via Composio
composio add mixpanel
composio execute mixpanel.get_funnel --funnel_id=12345
```

**Referências:**
- [Mixpanel JQL Documentation](https://docs.mixpanel.com/docs/analysis-tools/queries/jql)
- [Mixpanel API](https://docs.mixpanel.com/docs/api)
- [Composio Mixpanel](https://docs.composio.dev/integrations/mixpanel)

---

### 1.10 monte-carlo-monitor-creation

**Descrição:** Guia para criação de monitores Monte Carlo via ferramentas MCP, produzindo YAML de monitores-as-code para deploy via CI/CD.

**Quando usar:**
- Criar monitores de qualidade de dados
- Integrar monitores em pipelines de CI/CD
- Detectar anomalias em volumes de dados
- Monitorar freshness e schema de tabelas

**Exemplos práticos:**

```yaml
# Exemplo 1: Monitor de volume de dados
# monte_carlo_monitors/production/orders_volume.yaml
name: "orders_volume_monitor"
description: "Monitora volume diário de pedidos"
table: "production.analytics.orders"
type: "volume"
schedule: "daily"
threshold:
  type: "percentage"
  value: 20  # Alerta se variar mais de 20%
notification:
  slack: "#data-alerts"
  email: ["data-team@company.com"]
```

```yaml
# Exemplo 2: Monitor de freshness
# monte_carlo_monitors/production/customers_freshness.yaml
name: "customers_freshness"
description: "Verifica se tabela de clientes está atualizada"
table: "production.analytics.customers"
type: "freshness"
schedule: "hourly"
threshold:
  max_hours: 6  # Alerta se dados tiverem mais de 6 horas
notification:
  slack: "#data-alerts"
```

```yaml
# Exemplo 3: Monitor de schema
# monte_carlo_monitors/production/orders_schema.yaml
name: "orders_schema_monitor"
description: "Detecta mudanças inesperadas no schema"
table: "production.analytics.orders"
type: "schema"
schedule: "daily"
allowed_changes:
  - "add_column"
  - "nullable_to_not_null"
blocked_changes:
  - "drop_column"
  - "type_change"
notification:
  slack: "#data-engineering"
```

**Casos de uso avançados:**
- **Data Observability completo:** Configurar monitores para todas as tabelas críticas do data warehouse
- **Integração com PR:** Verificar se mudanças de schema em PRs não quebram monitores existentes
- **SLA de dados:** Criar monitores que garantem que dados chegam antes de SLAs específicos

**Integração com outras skills:**
- `data-quality-frameworks`: para complementar com Great Expectations
- `dbt-transformation-patterns`: para monitorar modelos dbt
- `snowflake-development`: para monitores em Snowflake

**Padrões e anti-padrões:**
✅ Fazer: Versionar monitores em repositório Git
✅ Fazer: Testar monitores em staging antes de produção
❌ Evitar: Criar muitos monitores sem priorização
❌ Evitar: Configurar thresholds muito sensíveis (causam alertas desnecessários)

**Dicas de performance:**
- Usar amostragem para monitores de volume em tabelas muito grandes
- Configurar horários de execução em baixo uso
- Agrupar monitores relacionados para reduzir overhead

**Comandos úteis:**
```bash
# Deploy de monitores via CI/CD
monte-carlo-cli deploy --env production --path ./monitors/

# Testar monitor localmente
monte-carlo-cli test --config ./monitors/orders_volume.yaml
```

**Referências:**
- [Monte Carlo Documentation](https://docs.montecarlodata.com/)
- [Monitors as Code](https://docs.montecarlodata.com/docs/monitors-as-code)
- [Monte Carlo CLI](https://github.com/montecarlodata/mc-cli)

---

### 1.11 monte-carlo-validation-notebook

**Descrição:** Gera notebooks SQL de validação para mudanças PR no dbt com queries de comparação antes/depois.

**Quando usar:**
- Antes de fazer merge de mudanças em modelos dbt
- Validar que transformações não quebram dados existentes
- Comparar resultados antes e depois de refatorações

**Exemplos práticos:**

```sql
-- Exemplo 1: Query de comparação antes/depois
-- validation_query.sql

-- Contagem de registros ANTES
SELECT 
  'BEFORE' as version,
  COUNT(*) as total_rows,
  COUNT(DISTINCT customer_id) as unique_customers,
  SUM(total_amount) as total_revenue
FROM {{ ref('fct_orders') }}

UNION ALL

-- Contagem de registros DEPOIS (modelo modificado)
SELECT 
  'AFTER' as version,
  COUNT(*) as total_rows,
  COUNT(DISTINCT customer_id) as unique_customers,
  SUM(total_amount) as total_revenue
FROM {{ ref('fct_orders_v2') }}
```

```python
# Exemplo 2: Notebook de validação automático
# validation_notebook.py
import pandas as pd
from sqlalchemy import create_engine

engine = create_engine('bigquery://project/dataset')

# Executar queries antes/depois
query_before = """
SELECT 
  DATE_TRUNC(order_date, MONTH) as month,
  COUNT(*) as orders,
  SUM(total_amount) as revenue
FROM fct_orders
WHERE order_date >= '2026-01-01'
GROUP BY 1
ORDER BY 1
"""

query_after = """
SELECT 
  DATE_TRUNC(order_date, MONTH) as month,
  COUNT(*) as orders,
  SUM(total_amount) as revenue
FROM fct_orders_v2
WHERE order_date >= '2026-01-01'
GROUP BY 1
ORDER BY 1
"""

df_before = pd.read_sql(query_before, engine)
df_after = pd.read_sql(query_after, engine)

# Comparar resultados
comparison = df_before.merge(df_after, on='month', suffixes=('_before', '_after'))
comparison['orders_diff'] = comparison['orders_after'] - comparison['orders_before']
comparison['revenue_diff'] = comparison['revenue_after'] - comparison['revenue_before']

print(comparison)
```

**Casos de uso avançados:**
- **CI/CD Integration:** Automatizar validação em cada PR que modifica modelos dbt
- **Data Diffing:** Detectar diferenças granulares em colunas específicas
- **Regression Testing:** Criar suite de testes que rodam antes de cada deploy

**Integração com outras skills:**
- `dbt-transformation-patterns`: para validação de modelos dbt
- `data-quality-frameworks`: para testes de qualidade
- `monte-carlo-monitor-creation`: para monitoramento pós-deploy

**Padrões e anti-padrões:**
✅ Fazer: Validar em dados representativos (não só contagens)
✅ Fazer: Automatizar validação no CI/CD
❌ Evitar: Validar apenas em dados de teste (podem não representar produção)
❌ Evitar: Ignorar diferenças pequenas (podem indicar bugs)

**Dicas de performance:**
- Usar amostragem para validação em tabelas muito grandes
- Cache de resultados de queries de validação
- Executar validações em paralelo quando possível

**Comandos úteis:**
```bash
# Gerar notebook de validação
dbt compile --select model_name > compiled.sql
python generate_validation.py --model model_name
```

**Referências:**
- [Monte Carlo Data Validation](https://docs.montecarlodata.com/)
- [dbt Testing](https://docs.getdbt.com/docs/build/data-tests)
- [Great Expectations](https://docs.greatexpectations.io/)

---

### 1.12 optim-agent

**Descrição:** Guia de otimização de parâmetros por agente para sistemas configuráveis com objetivos mensuráveis. Usar para HPO, tuning de inferência, simulações, ou experimentos RL/controle.

**Quando usar:**
- Otimizar hiperparâmetros de modelos de ML
- Ajustar configurações de sistemas baseado em métricas
- Executar experimentos de otimização
- Automatizar tuning de pipelines

**Exemplos práticos:**

```python
# Exemplo 1: Otimização com Optuna
import optuna
from sklearn.ensemble import RandomForestClassifier
from sklearn.model_selection import cross_val_score
from sklearn.datasets import load_iris

def objective(trial):
    # Sugerir hiperparâmetros
    n_estimators = trial.suggest_int('n_estimators', 50, 500)
    max_depth = trial.suggest_int('max_depth', 3, 20)
    min_samples_split = trial.suggest_float('min_samples_split', 0.1, 1.0)
    
    # Criar modelo
    clf = RandomForestClassifier(
        n_estimators=n_estimators,
        max_depth=max_depth,
        min_samples_split=min_samples_split,
        random_state=42
    )
    
    # Avaliar com cross-validation
    X, y = load_iris(return_X_y=True)
    score = cross_val_score(clf, X, y, cv=5, scoring='accuracy').mean()
    
    return score

# Criar estudo e otimizar
study = optuna.create_study(direction='maximize')
study.optimize(objective, n_trials=100)

print(f"Melhores parâmetros: {study.best_params}")
print(f"Melhor acurácia: {study.best_value:.4f}")
```

```python
# Exemplo 2: Otimização de pipeline ETL
from optim_agent import PipelineOptimizer

optimizer = PipelineOptimizer(
    objective="minimize_latency",
    constraints={
        "max_memory_gb": 16,
        "max_cost_usd": 100
    }
)

# Definir espaço de busca
search_space = {
    "parallelism": {"type": "int", "low": 1, "high": 20},
    "batch_size": {"type": "int", "low": 1000, "high": 100000},
    "compression": {"type": "categorical", "choices": ["snappy", "gzip", "lz4"]}
}

# Otimizar
result = optimizer.optimize(
    config_space=search_space,
    n_trials=50,
    timeout=3600  # 1 hora
)

print(f"Melhor configuração: {result.best_config}")
print(f"Latência mínima: {result.best_value:.2f}s")
```

```python
# Exemplo 3: Otimização de inferência LLM
from optim_agent import LLMInferenceOptimizer

llm_optimizer = LLMInferenceOptimizer(
    model="llama-3-70b",
    objective="maximize_throughput",
    hardware_constraints={"gpu_memory": 80, "gpu_count": 4}
)

# Otimizar parâmetros de inferência
inference_params = {
    "batch_size": {"type": "int", "low": 1, "high": 32},
    "tensor_parallel": {"type": "int", "low": 1, "high": 4},
    "quantization": {"type": "categorical", "choices": ["fp16", "int8", "fp8"]}
}

result = llm_optimizer.optimize(inference_params, n_trials=30)
```

**Casos de uso avançados:**
- **Multi-objective optimization:** Otimizar múltiplas métricas simultaneamente (latência vs custo vs qualidade)
- **Transfer learning de hiperparâmetros:** Usar resultados de otimizações anteriores para acelerar novas
- **A/B testing automatizado:** Usar otimização bayesiana para testes A/B

**Integração com outras skills:**
- `spark-optimization`: para otimizar configurações de Spark
- `database-optimizer`: para otimizar queries e configurações de banco
- `vector-index-tuning`: para otimizar índices vetoriais

**Padrões e anti-padrões:**
✅ Fazer: Definir métricas claras e mensuráveis
✅ Fazer: Usar early stopping para trials não promissores
❌ Evitar: Otimizar muitos parâmetros simultaneamente
❌ Evitar: Ignorar custo computacional da otimização

**Dicas de performance:**
- Usar pruning de trails (ASHA, Hyperband)
- Paralelizar avaliações quando possível
- Usar surrogate models para funções caras

**Comandos úteis:**
```bash
pip install optuna
python -m optuna.visualization --study-name my_study
```

**Referências:**
- [Optuna Documentation](https://optuna.org/)
- [Ray Tune](https://docs.ray.io/en/latest/tune/index.html)
- [Hyperopt](https://hyperopt.github.io/hyperopt/)

---

### 1.13 postgres-readonly-queries

**Descrição:** Executar queries SQL read-only seguras contra bancos PostgreSQL com suporte multi-conexão e proteção defensiva contra escrita.

**Quando usar:**
- Consultar dados em PostgreSQL de forma segura
- Executar queries analíticas em produção
- Gerar relatórios sem risco de alterar dados
- Explorar dados de forma interativa

**Exemplos práticos:**

```python
# Exemplo 1: Conexão read-only segura
import psycopg2
from psycopg2 import sql

def create_readonly_connection(host, database, user, password):
    conn = psycopg2.connect(
        host=host,
        database=database,
        user=user,
        password=password,
        options='-c default_transaction_isolation=read-only'
    )
    return conn

# Usar conexão read-only
conn = create_readonly_connection('localhost', 'analytics', 'reader', 'senha')
cursor = conn.cursor()

# Esta query funciona
cursor.execute("""
    SELECT 
        DATE_TRUNC('month', order_date) as month,
        COUNT(*) as orders,
        SUM(total_amount) as revenue
    FROM orders
    WHERE order_date >= '2026-01-01'
    GROUP BY 1
    ORDER BY 1
""")
results = cursor.fetchall()

# Esta query FALHA (tentativa de escrita)
try:
    cursor.execute("DELETE FROM orders WHERE id = 1")
except psycopg2.errors.ReadOnlySqlTransaction:
    print("Operação bloqueada: conexão é read-only")
```

```python
# Exemplo 2: Query parameterizada segura
def safe_query(conn, table, filters=None, limit=1000):
    """
    Executa query read-only com parâmetros sanitizados
    """
    query = sql.SQL("SELECT * FROM {}").format(sql.Identifier(table))
    
    if filters:
        conditions = []
        for key, value in filters.items():
            conditions.append(sql.SQL("{} = {}").format(
                sql.Identifier(key),
                sql.Placeholder()
            ))
        query = query + sql.SQL(" WHERE ") + sql.SQL(" AND ").join(conditions)
    
    query = query + sql.SQL(" LIMIT {}").format(sql.Literal(limit))
    
    with conn.cursor() as cur:
        cur.execute(query, list(filters.values()) if filters else [])
        return cur.fetchall()
```

```sql
-- Exemplo 3: View materializada para consultas analíticas
CREATE MATERIALIZED VIEW mv_monthly_sales AS
SELECT 
    DATE_TRUNC('month', o.order_date) as month,
    p.category,
    COUNT(DISTINCT o.customer_id) as unique_customers,
    COUNT(*) as total_orders,
    SUM(o.total_amount) as revenue
FROM orders o
JOIN order_items oi ON o.id = oi.order_id
JOIN products p ON oi.product_id = p.id
GROUP BY 1, 2;

-- Refresh periódico
REFRESH MATERIALIZED VIEW CONCURRENTLY mv_monthly_sales;
```

**Casos de uso avançados:**
- **Data Exploration Seguro:** Criar conexões read-only para cientistas de dados explorarem dados de produção
- **API de Dados:** Criar endpoints que expõem dados via queries read-only
- **Auditoria de Queries:** Logar todas as queries executadas em conexões read-only

**Integração com outras skills:**
- `postgres-best-practices`: para otimizar queries
- `sql-pro`: para queries complexas
- `warehouse`: para análises em data warehouses

**Padrões e anti-padrões:**
✅ Fazer: Usar conexões read-only para análise
✅ Fazer: Implementar timeout para queries longas
❌ Evitar: Usar credenciais de escrita em scripts de análise
❌ Evitar: Executar queries sem LIMIT em tabelas grandes

**Dicas de performance:**
- Usar prepared statements para queries frequentes
- Criar índices específicos para queries analíticas
- Usar materialized views para consultas complexas

**Comandos úteis:**
```bash
# Conectar ao PostgreSQL em modo read-only
psql "postgresql://user:pass@host/db?options=-c%20default_transaction_isolation%3Dread-only"

# Verificar se está em read-only
SHOW default_transaction_isolation;
```

**Referências:**
- [PostgreSQL Read-Only Transactions](https://www.postgresql.org/docs/current/transaction-iso.html)
- [psql Options](https://www.postgresql.org/docs/current/app-psql.html)
- [psycopg2 Documentation](https://www.psycopg.org/docs/)

---

### 1.14 posthog-automation

**Descrição:** Automatizar tarefas no PostHog via Rube MCP (Composio): eventos, feature flags, projetos, perfis de usuários, anotações.

**Quando usar:**
- Criar feature flags automaticamente
- Gerenciar projetos no PostHog
- Extrair dados de usuários
- Automatizar workflows de produto

**Exemplos práticos:**

```python
# Exemplo 1: Criar feature flag via API
import requests

POSTHOG_API_KEY = "sua_chave"
POSTHOG_HOST = "https://app.posthog.com"

response = requests.post(
    f"{POSTHOG_HOST}/api/projects/1/feature_flags/",
    headers={"Authorization": f"Bearer {POSTHOG_API_KEY}"},
    json={
        "key": "new-checkout-flow",
        "name": "Novo fluxo de checkout",
        "description": "Ativa o novo design do checkout",
        "active": True,
        "rollout_percentage": 10,
        "filters": {
            "groups": [
                {
                    "rollout_percentage": 10,
                    "properties": [
                        {
                            "key": "plan",
                            "value": "premium",
                            "operator": "exact"
                        }
                    ]
                }
            ]
        }
    }
)
print(f"Feature flag criada: {response.json()['key']}")
```

```python
# Exemplo 2: Extrair dados de usuários
users = requests.get(
    f"{POSTHOG_HOST}/api/projects/1/persons/",
    headers={"Authorization": f"Bearer {POSTHOG_API_KEY}"},
    params={"search": "user@example.com"}
).json()

for user in users['results']:
    print(f"ID: {user['id']}")
    print(f"Properties: {user['properties']}")
```

```python
# Exemplo 3: Criar anotação para marcar evento
response = requests.post(
    f"{POSTHOG_HOST}/api/projects/1/annotations/",
    headers={"Authorization": f"Bearer {POSTHOG_API_KEY}"},
    json={
        "content": "Deploy da versão 2.0 em produção",
        "date_marker": "2026-09-01T10:00:00Z",
        "scope": "global"
    }
)
```

**Casos de uso avançados:**
- **Feature flagging automatizado:** Criar flags baseado em métricas de engajamento
- **User segmentation:** Criar segmentos dinâmicos baseados em comportamento
- **Release management:** Gerenciar rollout de features com feature flags

**Integração com outras skills:**
- `analytics-product`: para usar dados do PostHog em análises
- `segment-cdp`: para enviar eventos do PostHog para outros destinos
- `data-storytelling`: para comunicar impacto de features

**Padrões e anti-padrões:**
✅ Fazer: Usar feature flags para releases progressivos
✅ Fazer: Documentar feature flags com descrições claras
❌ Evitar: Criar muitas flags sem processo de cleanup
❌ Evitar: Usar flags para features permanentes

**Dicas de performance:**
- Usar local evaluation para feature flags em SDKs
- Implementar cache de flags no cliente
- Usar cohorts pre-computed para filtros complexos

**Comandos úteis:**
```bash
# Via Composio
composio add posthog
composio execute posthog.create_feature_flag --key="new-feature" --rollout=10
```

**Referências:**
- [PostHog API Documentation](https://posthog.com/docs/api)
- [PostHog Feature Flags](https://posthog.com/docs/feature-flags)
- [Composio PostHog](https://docs.composio.dev/integrations/posthog)

---

### 1.15 segment-automation

**Descrição:** Automatizar tarefas no Segment via Rube MCP (Composio): track events, identify users, manage groups, page views, aliases, batch operations.

**Quando usar:**
- Automatizar tracking de eventos no Segment
- Gerenciar identidades de usuários
- Processar operações em lote
- Integrar dados com múltiplos destinos

**Exemplos práticos:**

```python
# Exemplo 1: Enviar evento via Segment
from segment.analytics import Analytics

analytics = WriteKey("sua_write_key")

analytics.track(
    user_id="user_123",
    event="Item Purchased",
    properties={
        "item_id": "abc-123",
        "item_name": "Camiseta Premium",
        "price": 99.90,
        "quantity": 2
    },
    context={
        "ip": "127.0.0.1",
        "user_agent": "Mozilla/5.0"
    }
)
```

```python
# Exemplo 2: Identify user com traits
analytics.identify(
    user_id="user_123",
    traits={
        "name": "João Silva",
        "email": "joao@example.com",
        "plan": "premium",
        "company": "Tech Corp"
    }
)
```

```python
# Exemplo 3: Batch operations
from segment.analytics import Analytics
import json

analytics = Analytics("sua_write_key", flush_at=100)

# Enviar múltiplos eventos
events = [
    {"user_id": f"user_{i}", "event": "Page Viewed", "properties": {"page": f"/product/{i}"}}
    for i in range(1000)
]

for event in events:
    analytics.track(**event)

analytics.flush()
```

**Casos de uso avançados:**
- **Identity resolution:** Implementar cross-device tracking com aliases
- **Data governance:** Usar tracking plans para validar qualidade de eventos
- **Multi-destination routing:** Configurar regras de roteamento para diferentes destinos

**Integração com outras skills:**
- `segment-cdp`: para configuração avançada do CDP
- `analytics-tracking`: para projetar tracking plans
- `data-quality-frameworks`: para validar qualidade de dados

**Padrões e anti-padrões:**
✅ Fazer: Usar tracking plans para governança
✅ Fazer: Implementar retry para falhas de envio
❌ Evitar: Enviar eventos sem contexto (user_agent, ip)
❌ Evitar: Identificar usuários com PII sem criptografia

**Dicas de performance:**
- Usar batch API para grandes volumes
- Implementar buffering local antes de enviar
- Usar connection pooling para múltiplas conexões

**Comandos úteis:**
```bash
# Via Composio
composio add segment
composio execute segment.track --user_id="user_123" --event="Purchase"

# Teste rápido
python -c "
from segment.analytics import Analytics
analytics = Analytics('WRITE_KEY')
analytics.track(user_id='test', event='Test Event')
analytics.flush()
"
```

**Referências:**
- [Segment Documentation](https://segment.com/docs/)
- [Segment Sources](https://segment.com/docs/connections/sources/)
- [Composio Segment](https://docs.composio.dev/integrations/segment)

---

### 1.16 segment-cdp

**Descrição:** Padrões de expertise para Segment Customer Data Platform incluindo Analytics.js, tracking server-side, tracking plans com Protocols, resolução de identidade, configuração de destinos e boas práticas de governança de dados.

**Quando usar:**
- Implementar infraestrutura completa de CDP com Segment
- Configurar tracking server-side
- Criar tracking plans com Protocols
- Implementar resolução de identidade

**Exemplos práticos:**

```javascript
// Exemplo 1: Tracking client-side com Analytics.js
// No HTML
<script>
  !function(){var i="analytics",analytics=window[i]=window[i]||[];if(!analytics.initialize)if(analytics.invoked)window.console&&console.error&&console.error("Segment snippet included twice.");else{analytics.invoked=!0;analytics.methods=["trackSubmit","trackClick","trackLink","trackForm","pageview","identify","reset","group","track","ready","alias","debug","page","screen","once","off","on","addSourceMiddleware","addIntegrationMiddleware","setAnonymousId","addDestinationMiddleware","register"];analytics.factory=function(e){return function(){if(window[i].initialized)return window[i][e].apply(window[i],arguments);var n=Array.prototype.slice.call(arguments);if(["track","screen","alias","group","page","identify"].indexOf(e)>-1){var c=document.querySelector("link[rel='canonical']");n.push({__t:"bpc",c:c&&c.getAttribute("href")||void 0,p:location.pathname,u:location.href,s:location.search,t:document.title,r:document.referrer})}n.unshift(e);analytics.push(n);return analytics}};for(var n=0;n<analytics.methods.length;n++){var key=analytics.methods[n];analytics[key]=analytics.factory(key)}analytics.load=function(key,n){analytics._writeKey=key;analytics._cdnURL=n||"https://cdn.segment.com";var t=document.createElement("script");t.type="text/javascript";t.async=!0;t.setAttribute("data-global-segment-analytics-analytics",i);t.src=analytics._cdnURL+"/analytics.js/v1/" + key + "/analytics.min.js";var r=document.getElementsByTagName("script")[0];r.parentNode.insertBefore(t,r);analytics._loadOptions=n};analytics._writeKey="SUA_WRITE_KEY";analytics.SNIPPET_VERSION="5.2.1";
  analytics.load("SUA_WRITE_KEY");
  analytics.page();
  }}();
</script>
```

```python
# Exemplo 2: Tracking server-side
from segment.analytics import Analytics

analytics = Analytics("write_key", debug=True, flush_at=20)

# Track event
analytics.track(
    user_id="user_123",
    event="Subscription Created",
    properties={
        "plan": "enterprise",
        "amount": 999.00,
        "billing_period": "annual"
    },
    context={
        "ip": "203.0.113.1",
        "user_agent": "Mozilla/5.0...",
        "library": {"name": "analytics-python", "version": "2.2.0"}
    }
)
```

```yaml
# Exemplo 3: Tracking Plan (Protocols)
# tracking_plan.yaml
name: "Ecommerce Events"
description: "Tracking plan for ecommerce events"
rules:
  - event_name: "Product Viewed"
    description: "When a user views a product page"
    rules:
      - path: "properties.product_id"
        type: "string"
        required: true
      - path: "properties.price"
        type: "number"
        required: true
        minimum: 0
      - path: "properties.category"
        type: "string"
        required: true
```

**Casos de uso avançados:**
- **Privacy compliance:** Implementar GDPR/CCPA com consent management no Segment
- **Data enrichment:** Configurar enrichment para enriquecer dados de usuários
- **Reverse ETL:** Usar Segment para enviar dados do data warehouse para ferramentas de negócio

**Integração com outras skills:**
- `segment-automation`: para automações avançadas
- `analytics-tracking`: para projetar tracking plans
- `data-quality-frameworks`: para validar qualidade de dados

**Padrões e anti-padrões:**
✅ Fazer: Usar tracking plans para validar eventos
✅ Fazer: Implementar consent management
❌ Evitar: Enviar PII sem criptografia
❌ Evitar: Configurar destinos sem testar em sandbox primeiro

**Dicas de performance:**
- Usar batch methods para grandes volumes
- Implementar retry com exponential backoff
- Usar connection pooling em server-side

**Comandos úteis:**
```bash
# Instalar SDK
pip install segment-analytics-python
npm install @segment/analytics-next

# Teste rápido
python -c "
from segment.analytics import Analytics
a = Analytics('WRITE_KEY', debug=True)
a.track(user_id='test', event='Test')
a.flush()
"
```

**Referências:**
- [Segment Documentation](https://segment.com/docs/)
- [Segment Protocols](https://segment.com/docs/protocols/)
- [Analytics.js](https://segment.com/docs/connections/sources/catalog/libraries/website/javascript/)
- [Server-side SDKs](https://segment.com/docs/connections/sources/catalog/libraries/server-python/)

---

### 1.17 spark-optimization

**Descrição:** Otimizar jobs Apache Spark com particionamento, cache, otimização de shuffle e tuning de memória.

**Quando usar:**
- Jobs Spark estão lentos
- Consumo excessivo de memória
- Precisa escalar para volumes maiores
- Otimizar custos de cluster

**Exemplos práticos:**

```python
# Exemplo 1: Otimização de particionamento
from pyspark.sql import SparkSession

spark = SparkSession.builder \
    .appName("OptimizedJob") \
    .config("spark.sql.shuffle.partitions", "200") \
    .config("spark.sql.adaptive.enabled", "true") \
    .config("spark.sql.adaptive.coalescePartitions.enabled", "true") \
    .getOrCreate()

# Ler dados com particionamento correto
df = spark.read.parquet("s3://data/events/")
df = df.repartition(200, "user_id")  # Reparticionar por chave de join

# Usar broadcast join para tabela pequena
from pyspark.sql.functions import broadcast

small_table = spark.read.parquet("s3://data/dimensions/countries/")
large_table = spark.read.parquet("s3://data/fact/events/")

# Spark usa broadcast automaticamente para tabelas < 10MB
result = large_table.join(broadcast(small_table), "country_code")
```

```python
# Exemplo 2: Cache e persistência
from pyspark import StorageLevel

# Cache DataFrame que será reutilizado
events_df = spark.read.parquet("s3://data/events/")
events_df.persist(StorageLevel.MEMORY_AND_DISK_SER)

# Usar múltiplas vezes
daily_events = events_df.groupBy("date").count()
user_events = events_df.groupBy("user_id").count()

# Liberar cache quando não precisar mais
events_df.unpersist()
```

```python
# Exemplo 3: Otimização de memória
# Configurações de tuning
spark.conf.set("spark.executor.memory", "8g")
spark.conf.set("spark.executor.memoryFraction", "0.8")
spark.conf.set("spark.sql.shuffle.partitions", "100")
spark.conf.set("spark.sql.autoBroadcastJoinThreshold", "10485760")  # 10MB

# Uso de salting para skew de dados
from pyspark.sql.functions import rand, lit

# Adicionar salt para quebrar skew
salted_events = events_df.withColumn(
    "salt",
    (rand() * 10).cast("int")
)

# Join com salt
result = salted_events.join(
    broadcast(dim_table),
    (salted_events.country_code == dim_table.code) & 
    (salted_events.salt == lit(0))
)
```

**Casos de uso avançados:**
- **Adaptive Query Execution:** Configurar AQE para otimização automática
- **Dynamic Partition Pruning:** Otimizar joins com pruning dinâmico
- **Cost-based Optimization:** Usar estatísticas de colunas para otimizar planos

**Integração com outras skills:**
- `data-engineer`: para pipelines de dados completos
- `sql-pro`: para otimização de queries SQL
- `database-optimizer`: para comparação de técnicas

**Padrões e anti-padrões:**
✅ Fazer: Monitorar métricas de Spark (GC time, shuffle write)
✅ Fazer: Usar AQE para otimização adaptativa
❌ Evitar: Usar collect() em DataFrames grandes
❌ Evitar: Ignorar skew de dados em joins

**Dicas de performance:**
- Usar Kryo serializer para melhor performance
- Configurar garbage collector para G1GC
- Usar arrow para interoperabilidade com Pandas

**Comandos úteis:**
```bash
# Spark submit otimizado
spark-submit \
  --master yarn \
  --deploy-mode cluster \
  --executor-memory 8g \
  --executor-cores 4 \
  --num-executors 20 \
  --conf spark.sql.shuffle.partitions=200 \
  --conf spark.sql.adaptive.enabled=true \
  optimized_job.py

# Monitorar job
spark-history-server --properties-file spark-defaults.conf
```

**Referências:**
- [Spark Performance Tuning](https://spark.apache.org/docs/latest/tuning.html)
- [Spark Configuration](https://spark.apache.org/docs/latest/configuration.html)
- [Adaptive Query Execution](https://spark.apache.org/docs/latest/sql-performance-tuning.html#adaptive-query-execution)

---

### 1.18 sql-pro

**Descrição:** Domínio de SQL moderno com bancos nativos da nuvem, otimização OLTP/OLAP e técnicas avançadas de queries. Expertise em tuning de performance, modelagem de dados e sistemas analíticos híbridos.

**Quando usar:**
- Escrever queries SQL complexas
- Otimizar performance de consultas
- Modelar esquemas analíticos em bancos cloud
- Implementar window functions avançadas

**Exemplos práticos:**

```sql
-- Exemplo 1: Window functions complexas
WITH daily_metrics AS (
    SELECT 
        user_id,
        DATE_TRUNC('day', event_date) as day,
        COUNT(*) as events,
        SUM(amount) as revenue,
        -- Running total
        SUM(SUM(amount)) OVER (
            PARTITION BY user_id 
            ORDER BY DATE_TRUNC('day', event_date)
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) as cumulative_revenue,
        -- Rank within day
        RANK() OVER (
            PARTITION BY DATE_TRUNC('day', event_date) 
            ORDER BY SUM(amount) DESC
        ) as daily_rank,
        -- Lag/Lead
        LAG(SUM(amount), 1) OVER (
            PARTITION BY user_id 
            ORDER BY DATE_TRUNC('day', event_date)
        ) as prev_day_revenue
    FROM transactions
    GROUP BY 1, 2
)
SELECT * FROM daily_metrics
WHERE daily_rank <= 10;
```

```sql
-- Exemplo 2: Pivot dinâmico com CTEs
WITH pivoted AS (
    SELECT 
        product_id,
        SUM(CASE WHEN DATE_TRUNC('month', order_date) = '2026-01-01' THEN amount ELSE 0 END) as jan_2026,
        SUM(CASE WHEN DATE_TRUNC('month', order_date) = '2026-02-01' THEN amount ELSE 0 END) as feb_2026,
        SUM(CASE WHEN DATE_TRUNC('month', order_date) = '2026-03-01' THEN amount ELSE 0 END) as mar_2026
    FROM orders
    GROUP BY 1
)
SELECT 
    product_id,
    jan_2026,
    feb_2026,
    mar_2026,
    (feb_2026 - jan_2026) / NULLIF(jan_2026, 0) * 100 as jan_feb_growth,
    (mar_2026 - feb_2026) / NULLIF(feb_2026, 0) * 100 as feb_mar_growth
FROM pivoted;
```

```sql
-- Exemplo 3: Recursive CTE para hierarquia
WITH RECURSIVE org_chart AS (
    -- Caso base: CEO (sem manager)
    SELECT 
        employee_id,
        name,
        manager_id,
        1 as level,
        ARRAY[name] as path
    FROM employees
    WHERE manager_id IS NULL
    
    UNION ALL
    
    -- Caso recursivo: subordinados
    SELECT 
        e.employee_id,
        e.name,
        e.manager_id,
        oc.level + 1,
        oc.path || e.name
    FROM employees e
    JOIN org_chart oc ON e.manager_id = oc.employee_id
)
SELECT 
    employee_id,
    name,
    level,
    path,
    ARRAY_TO_STRING(path, ' > ') as hierarchy_path
FROM org_chart
ORDER BY path;
```

**Casos de uso avançados:**
- **Query optimization:** Usar EXPLAIN ANALYZE para otimizar queries complexas
- **Materialized views:** Criar views materializadas para consultas frequentes
- **Partitioning strategies:** Implementar partitioning por data ou categoria

**Integração com outras skills:**
- `sql-sentinel`: para auditar e otimizar queries
- `postgres-best-practices`: para padrões PostgreSQL
- `snowflake-development`: para otimizações Snowflake

**Padrões e anti-padrões:**
✅ Fazer: Usar CTEs para queries complexas
✅ Fazer: Criar índices baseado em padrões de query
❌ Evitar: Usar SELECT * em produção
❌ Evitar: Subqueries correlacionadas desnecessárias

**Dicas de performance:**
- Usar EXPLAIN ANALYZE para entender planos de execução
- Criar índices compostos para queries frequentes
- Usar materialized views para agregações complexas

**Comandos úteis:**
```sql
-- Analisar query
EXPLAIN (ANALYZE, BUFFERS, FORMAT TEXT)
SELECT * FROM large_table WHERE condition;

-- Criar índice
CREATE INDEX CONCURRENTLY idx_orders_date ON orders (order_date);

-- Estatísticas de tabela
ANALYZE VERBOSE orders;
```

**Referências:**
- [PostgreSQL Window Functions](https://www.postgresql.org/docs/current/tutorial-window.html)
- [BigQuery SQL Reference](https://cloud.google.com/bigquery/docs/reference/standard-sql/)
- [Snowflake SQL](https://docs.snowflake.com/en/sql-reference/sql-all.html)

---

### 1.19 sql-sentinel

**Descrição:** Auditar SQL para anti-padrões de custo e performance que consomem créditos de warehouse. Pontua a saúde do warehouse de 0-100 e gera plano priorizado de redução de custos para BigQuery, Snowflake, Redshift e Postgres.

**Quando usar:**
- Queries SQL consumindo recursos excessivos
- Auditoria periódica de custos de queries
- Otimização de performance em data warehouses
- Redução de custos de BigQuery/Snowflake

**Exemplos práticos:**

```sql
-- Exemplo 1: Identificar queries custosas no BigQuery
SELECT
  query,
  user_email,
  total_bytes_processed / POW(1024, 3) as gb_processed,
  total_bytes_billed / POW(1024, 3) as gb_billed,
  cache_hit,
  creation_time,
  TIMESTAMP_DIFF(end_time, creation_time, SECOND) as duration_sec
FROM `region-us`.INFORMATION_SCHEMA.JOBS_BY_PROJECT
WHERE creation_time >= TIMESTAMP_SUB(CURRENT_TIMESTAMP(), INTERVAL 7 DAY)
  AND total_bytes_processed > 10 * POW(1024, 3)  -- > 10GB processados
ORDER BY total_bytes_processed DESC
LIMIT 20;
```

```python
# Exemplo 2: Auditoria automatizada com sql-sentinel
from sql_sentinel import WarehouseAuditor

auditor = WarehouseAuditor(
    warehouse="bigquery",
    project_id="meu-projeto"
)

# Auditar queries dos últimos 7 dias
report = auditor.audit(
    period_days=7,
    min_bytes_processed=1024**3  # 1GB
)

# Gerar relatório
print(f"Score de saúde: {report.health_score}/100")
print(f"Custo total estimado: ${report.total_cost:.2f}")
print(f"Queries problemáticas: {len(report.problematic_queries)}")

# Plano de otimização
for recommendation in report.recommendations:
    print(f"\n[{recommendation.priority}] {recommendation.title}")
    print(f"  Impacto: {recommendation.estimated_savings}")
    print(f"  Solução: {recommendation.solution}")
```

```sql
-- Exemplo 3: Query otimizada vs não otimizada
-- ANTES (lenta e custosa)
SELECT *
FROM large_table
WHERE EXTRACT(YEAR FROM date_column) = 2026;

-- DEPOIS (otimizada)
SELECT *
FROM large_table
WHERE date_column >= '2026-01-01'
  AND date_column < '2027-01-01';
```

**Casos de uso avançados:**
- **Cost allocation:** Alocar custos de queries por time/departamento
- **Query governance:** Implementar políticas para limitar queries caras
- **Capacity planning:** Prever necessidade de capacidade baseado em uso histórico

**Integração com outras skills:**
- `sql-pro`: para otimizar queries identificadas
- `database-optimizer`: para configurações de performance
- `database-cloud-optimization-cost-optimize`: para otimização de custos cloud

**Padrões e anti-padrões:**
✅ Fazer: Auditar queries regularmente
✅ Fazer: Usar partitioning para reduzir dados escaneados
❌ Evitar: Queries SELECT * em tabelas grandes
❌ Evitar: JOINs sem índices adequados

**Dicas de performance:**
- Usar partition pruning sempre que possível
- Criar índices em colunas filtradas frequentemente
- Usar materialized views para agregações frequentes

**Comandos úteis:**
```bash
# BigQuery: verificar custo de query
bq query --use_legacy_sql=false --dry_run "
SELECT * FROM dataset.large_table WHERE condition
"

# Snowflake: verificar query history
SELECT * FROM TABLE(INFORMATION_SCHEMA.QUERY_HISTORY())
WHERE START_TIME >= DATEADD(day, -7, CURRENT_DATE())
ORDER BY TOTAL_ELAPSED_TIME DESC;
```

**Referências:**
- [BigQuery Pricing](https://cloud.google.com/bigquery/pricing)
- [Snowflake Credit Consumption](https://docs.snowflake.com/en/user-guide/credits.html)
- [Redshift Spectrum Pricing](https://aws.amazon.com/redshift/pricing/)

---

### 1.20 warehouse

**Descrição:** Planejar e revisar análises read-only de data warehouse com escopo explícito, privacidade, proveniência e verificações de validação.

**Quando usar:**
- Conduzir análises exploratórias em data warehouses
- Documentar proveniência de dados
- Validar resultados de análises
- Criar relatórios com rastreabilidade

**Exemplos práticos:**

```python
# Exemplo 1: Análise com proveniência documentada
class WarehouseAnalysis:
    def __init__(self, warehouse_connection):
        self.conn = warehouse_connection
        self.provenance = []
    
    def query(self, sql, description):
        """Executa query e registra proveniência"""
        result = pd.read_sql(sql, self.conn)
        self.provenance.append({
            'step': len(self.provenance) + 1,
            'sql': sql,
            'description': description,
            'rows_affected': len(result),
            'columns': list(result.columns)
        })
        return result
    
    def generate_report(self):
        """Gera relatório com proveniência completa"""
        report = {
            'analysis_steps': self.provenance,
            'data_sources': list(set([
                step['sql'] for step in self.provenance
                if 'FROM' in step['sql'].upper()
            ]))
        }
        return report

# Usar
analysis = WarehouseAnalysis(bigquery_conn)
df = analysis.query("""
    SELECT customer_id, SUM(amount) as total
    FROM orders
    GROUP BY 1
""", "Calcular total por cliente")
```

```python
# Exemplo 2: Validação de dados
def validate_warehouse_data(conn, table, rules):
    """Valida dados contra regras definidas"""
    results = {}
    
    for rule_name, rule in rules.items():
        if rule['type'] == 'not_null':
            query = f"SELECT COUNT(*) FROM {table} WHERE {rule['column']} IS NULL"
        elif rule['type'] == 'unique':
            query = f"SELECT COUNT(*) - COUNT(DISTINCT {rule['column']}) FROM {table}"
        elif rule['type'] == 'range':
            query = f"SELECT COUNT(*) FROM {table} WHERE {rule['column']} NOT BETWEEN {rule['min']} AND {rule['max']}"
        
        count = pd.read_sql(query, conn).iloc[0, 0]
        results[rule_name] = {
            'passed': count == 0,
            'violations': count
        }
    
    return results
```

```sql
-- Exemplo 3: Documentação de schema
SELECT 
    table_name,
    column_name,
    data_type,
    is_nullable,
    column_default,
    CAST(character_maximum_length AS VARCHAR) as max_length
FROM information_schema.columns
WHERE table_schema = 'analytics'
ORDER BY table_name, ordinal_position;
```

**Casos de uso avançados:**
- **Data lineage:** Implementar rastreabilidade completa de dados
- **Privacy compliance:** Garantir que análises não exponham dados sensíveis
- **Reproducibility:** Criar análises reproduzíveis com documentação completa

**Integração com outras skills:**
- `postgres-readonly-queries`: para consultas seguras
- `data-quality-frameworks`: para validação de dados
- `monte-carlo-monitor-creation`: para monitoramento de qualidade

**Padrões e anti-padrões:**
✅ Fazer: Documentar proveniência de cada passo
✅ Fazer: Validar dados antes de analisar
❌ Evitar: Executar queries sem documentar
❌ Evitar: Ignorar outliers sem investigar

**Dicas de performance:**
- Usar materialized views para consultas frequentes
- Implementar cache de resultados
- Usar partitioning para reduzir dados escaneados

**Comandos úteis:**
```bash
# Documentar schema
pg_dump --schema-only --no-owner database_name > schema.sql

# Analisar uso de queries
SELECT query, calls, mean_time, total_time
FROM pg_stat_statements
ORDER BY total_time DESC
LIMIT 10;
```

**Referências:**
- [Data Warehouse Best Practices](https://docs.snowflake.com/en/guide-platform/data-warehouse.html)
- [Data Lineage](https://www.atlan.com/data-lineage/)
- [Data Governance](https://www.informatica.com/services/data-governance.html)

---

### 1.21 web-scraper

**Descrição:** Web scraping inteligente multi-estratégia. Extrai dados estruturados de páginas web (tabelas, listas, preços). Paginação, monitoramento e export CSV/JSON.

**Quando usar:**
- Extrair dados estruturados de sites
- Coletar listas de preços
- Monitorar mudanças em páginas
- Exportar dados para análise

**Exemplos práticos:**

```python
# Exemplo 1: Extração de tabela de preços
import requests
from bs4 import BeautifulSoup
import pandas as pd

def scrape_prices(url):
    response = requests.get(url)
    soup = BeautifulSoup(response.content, 'html.parser')
    
    # Encontrar tabela de preços
    table = soup.find('table', {'class': 'prices-table'})
    
    # Extrair dados
    data = []
    for row in table.find_all('tr')[1:]:  # Pular cabeçalho
        cols = row.find_all('td')
        data.append({
            'product': cols[0].text.strip(),
            'price': float(cols[1].text.strip().replace('$', '').replace(',', '')),
            'availability': cols[2].text.strip()
        })
    
    return pd.DataFrame(data)

df = scrape_prices('https://example.com/prices')
df.to_csv('prices.csv', index=False)
```

```python
# Exemplo 2: Scraping com paginação
def scrape_with_pagination(base_url, max_pages=10):
    all_data = []
    
    for page in range(1, max_pages + 1):
        url = f"{base_url}?page={page}"
        response = requests.get(url)
        soup = BeautifulSoup(response.content, 'html.parser')
        
        # Extrair itens da página
        items = soup.find_all('div', {'class': 'product-item'})
        
        if not items:
            break  # Não há mais páginas
        
        for item in items:
            data = {
                'name': item.find('h3').text.strip(),
                'price': item.find('span', {'class': 'price'}).text.strip(),
                'rating': item.find('span', {'class': 'rating'}).text.strip()
            }
            all_data.append(data)
        
        print(f"Página {page}: {len(items)} itens extraídos")
    
    return pd.DataFrame(all_data)
```

```python
# Exemplo 3: Monitoramento de mudanças
import hashlib
import time

def monitor_page(url, check_interval=3600):
    """Monitora mudanças em uma página"""
    last_hash = None
    
    while True:
        response = requests.get(url)
        current_hash = hashlib.md5(response.content).hexdigest()
        
        if last_hash and current_hash != last_hash:
            print(f"Mudança detectada em {url}!")
            # Enviar notificação
            send_notification(url)
        
        last_hash = current_hash
        time.sleep(check_interval)
```

**Casos de uso avançados:**
- **Price intelligence:** Monitorar preços de concorrentes em tempo real
- **Lead generation:** Coletar informações de contato de diretórios
- **Content aggregation:** Agregar conteúdo de múltiplas fontes

**Integração com outras skills:**
- `firecrawl-scraper`: para sites que requerem JavaScript
- `x-twitter-scraper`: para redes sociais
- `rag-engineer`: para indexar conteúdo extraído

**Padrões e anti-padrões:**
✅ Fazer: Respetar robots.txt
✅ Fazer: Implementar delays entre requests
❌ Evitar: Sobrecarregar servidores com requests
❌ Evitar: Extrair dados pessoais sem consentimento

**Dicas de performance:**
- Usar caching para páginas que não mudam frequentemente
- Implementar retry com backoff
- Usar proxies para sites que bloqueiam IPs

**Comandos úteis:**
```bash
# Instalar dependências
pip install beautifulsoup4 requests pandas

# Teste rápido
python -c "
import requests
from bs4 import BeautifulSoup
r = requests.get('https://example.com')
soup = BeautifulSoup(r.content, 'html.parser')
print(soup.title.text)
"
```

**Referências:**
- [BeautifulSoup Documentation](https://www.crummy.com/software/BeautifulSoup/bs4/doc/)
- [Scrapy Documentation](https://docs.scrapy.org/)
- [Web Scraping Best Practices](https://www.scrapingbee.com/blog/web-scraping-with-python/)

---

### 1.22 x-twitter-scraper

**Descrição:** Usar Xquik para workflows de dados do X (Twitter): busca de tweets, lookup de usuários, export de seguidores, downloads de mídia, monitores, webhooks, REST API, MCP, SDK setup e ações de conta com aprovação.

**Quando usar:**
- Analisar engajamento de tweets
- Monitorar menções de uma marca
- Exportar seguidores de um perfil
- Coletar dados para análise de sentimento

**Exemplos práticos:**

```python
# Exemplo 1: Buscar tweets por keyword
from xquik import Xquik

client = Xquik(api_key="sua_chave")

# Buscar tweets sobre um tópico
tweets = client.search_tweets(
    query="#sustentabilidade",
    max_results=100,
    lang="pt"
)

for tweet in tweets.data:
    print(f"Autor: {tweet.author_id}")
    print(f"Texto: {tweet.text}")
    print(f"Likes: {tweet.public_metrics['like_count']}")
    print("---")
```

```python
# Exemplo 2: Analisar engajamento
def analyze_engagement(tweets):
    """Analisa métricas de engajamento"""
    total_likes = sum(t.public_metrics['like_count'] for t in tweets)
    total_retweets = sum(t.public_metrics['retweet_count'] for t in tweets)
    total_replies = sum(t.public_metrics['reply_count'] for t in tweets)
    
    avg_engagement = (total_likes + total_retweets + total_replies) / len(tweets)
    
    return {
        'total_tweets': len(tweets),
        'total_likes': total_likes,
        'total_retweets': total_retweets,
        'total_replies': total_replies,
        'avg_engagement': avg_engagement
    }
```

```python
# Exemplo 3: Monitoramento de menções
def monitor_mentions(brand_name, check_interval=300):
    """Monitora menções de uma marca"""
    last_mention_id = None
    
    while True:
        mentions = client.search_tweets(
            query=f"@{brand_name}",
            since_id=last_mention_id,
            max_results=50
        )
        
        for mention in mentions.data:
            # Processar menção
            process_mention(mention)
            
            # Analisar sentimento
            sentiment = analyze_sentiment(mention.text)
            
            # Alertar se negativo
            if sentiment == 'negative':
                alert_team(mention)
        
        if mentions.data:
            last_mention_id = mentions.data[0].id
        
        time.sleep(check_interval)
```

**Casos de uso avançados:**
- **Brand monitoring:** Monitorar menções e sentiment em tempo real
- **Competitor analysis:** Analisar engajamento de concorrentes
- **Influencer identification:** Identificar influenciadores em nichos específicos

**Integração com outras skills:**
- `rag-engineer`: para indexar tweets para busca semântica
- `data-storytelling`: para comunicar insights de redes sociais
- `exa-search`: para encontrar conteúdo relevante além do X

**Padrões e anti-padrões:**
✅ Fazer: Respetar rate limits da API
✅ Fazer: Documentar Queries de busca
❌ Evitar: Coletar dados de usuários sem consentimento
❌ Evitar: Automatizar likes/follows (viola ToS)

**Dicas de performance:**
- Usar streaming API para monitoramento em tempo real
- Implementar cache de tweets já coletados
- Usar batch operations para exportações grandes

**Comandos úteis:**
```bash
# Instalar SDK
pip install xquik

# Teste rápido
python -c "
from xquik import Xquik
client = Xquik(api_key='SUA_CHAVE')
tweets = client.search_tweets(query='#tech', max_results=10)
print(f'Encontrados {len(tweets.data)} tweets')
"
```

**Referências:**
- [X API Documentation](https://developer.twitter.com/en/docs/twitter-api)
- [Xquik Documentation](https://docs.xquik.com/)
- [Twitter Rate Limits](https://developer.twitter.com/en/docs/twitter-api/rate-limits)

---

## 2. Data AI (14 skills)

> Fonte: `data-ai-category-pointer/SKILL.md`
> Vault: `C:/Users/Alendaviva007/.config/opencode/skill-libraries/data-ai`

### 2.1 ai-engineering-toolkit

**Descrição:** 6 workflows prontos de engenharia AI: avaliação de prompts (scoring em 8 dimensões), planejamento de orçamento de contexto, design de pipelines RAG, auditoria de segurança de agentes (checklist de 65 pontos), construção de eval harness e coaching de product sense.

**Quando usar:**
- Implementar boas práticas de engenharia AI
- Avaliar qualidade de prompts
- Projetar sistemas RAG
- Auditar segurança de agentes

**Exemplos práticos:**

```python
# Exemplo 1: Avaliação de prompt em 8 dimensões
prompt_evaluator = PromptEvaluator()

prompt = "Explique o que é machine learning para um iniciante"

scores = prompt_evaluator.evaluate(prompt, dimensions=[
    'clarity',        # Clareza da instrução
    'specificity',    # Especificidade
    'context',        # Contexto fornecido
    'constraints',    # Restrições definidas
    'format',         # Formato de saída esperado
    'examples',       # Exemplos incluídos
    'safety',         # Segurança
    'efficiency'      # Eficiência de tokens
])

print(f"Score total: {scores['total']}/100")
print(f"Dimensão mais fraca: {scores['weakest_dimension']}")
```

```python
# Exemplo 2: Auditoria de segurança de agente
from ai_toolkit import AgentSecurityAuditor

auditor = AgentSecurityAuditor()

# Auditar agente
report = auditor.audit(
    agent_config={
        "tools": ["database_query", "file_read", "web_search"],
        "permissions": ["read", "write"],
        "data_access": ["customer_data", "financial_data"]
    },
    checklist_level="comprehensive"  # 65 pontos
)

print(f"Score de segurança: {report.security_score}/100")
print(f"Vulnerabilidades encontradas: {len(report.vulnerabilities)}")

for vuln in report.vulnerabilities:
    print(f"\n[{vuln.severity}] {vuln.title}")
    print(f"  Descrição: {vuln.description}")
    print(f"  Solução: {vuln.recommendation}")
```

```python
# Exemplo 3: Design de pipeline RAG
rag_designer = RAGPipelineDesigner()

pipeline = rag_designer.design(
    use_case="customer_support",
    documents=[
        {"type": "pdf", "source": "manual.pdf"},
        {"type": "html", "source": "faq.html"},
        {"type": "markdown", "source": "docs.md"}
    ],
    requirements={
        "latency_ms": 500,
        "accuracy": 0.9,
        "cost_per_query": 0.01
    }
)

print(f"Chunking strategy: {pipeline.chunking}")
print(f"Embedding model: {pipeline.embedding_model}")
print(f"Vector store: {pipeline.vector_store}")
print(f"Retrieval method: {pipeline.retrieval_method}")
```

**Casos de uso avançados:**
- **Prompt engineering systemático:** Usar avaliador para iterar e melhorar prompts
- **Security-first AI:** Auditar agentes antes de deploy em produção
- **RAG cost optimization:** Projetar pipelines que balanceiam qualidade e custo

**Integração com outras skills:**
- `rag-engineer`: para implementar o pipeline projetado
- `clarity-gate`: para validar qualidade de documentos antes de indexar
- `local-llm-expert`: para deploy local com foco em segurança

**Padrões e anti-padrões:**
✅ Fazer: Avaliar prompts sistematicamente antes de usar em produção
✅ Fazer: Auditar segurança de agentes regularmente
❌ Evitar: Usar prompts sem validação
❌ Evitar: Deploy de agentes sem auditoria de segurança

**Dicas de performance:**
- Usar caching de prompts avaliados
- Automatizar auditorias de segurança no CI/CD
- Usar métricas de custo para otimizar pipelines

**Comandos úteis:**
```bash
# Instalar toolkit
pip install ai-engineering-toolkit

# Avaliar prompt
ai-toolkit evaluate-prompt --prompt "Explique ML" --dimensions clarity,specificity
```

**Referências:**
- [Prompt Engineering Guide](https://www.promptingguide.ai/)
- [AI Security Best Practices](https://owasp.org/www-project-top-10-for-large-language-model-applications/)
- [RAG Architecture](https://docs.llamaindex.ai/en/stable/understanding/rag/)

---

### 2.2 clarity-gate

**Descrição:** Verificação pré-ingestão para qualidade epistêmica em sistemas RAG. Garante que documentos são qualificados antes de entrarem em knowledge bases. Produz CGD (Clarity-Gated Documents) e valida arquivos SOT (Source of Truth).

**Quando usar:**
- Construir ou manter sistemas RAG
- Garantir qualidade de documentos antes de indexar
- Filtrar conteúdo irrelevante ou desatualizado
- Validar fontes confiáveis

**Exemplos práticos:**

```python
# Exemplo 1: Validar documento antes de indexar
from clarity_gate import DocumentQualifier

qualifier = DocumentQualifier()

# Avaliar documento
result = qualifier.qualify(
    document_path="docs/api_reference.md",
    criteria={
        "accuracy": 0.8,      # Precisão mínima
        "freshness": 30,      # Máximo 30 dias desatualizado
        "completeness": 0.7,  # Completude mínima
        "authority": 0.9      # Fonte autoritativa
    }
)

print(f"Documento qualificado: {result.is_qualified}")
print(f"Score: {result.score}/100")
print(f"Issues: {result.issues}")
```

```python
# Exemplo 2: Criar CGD (Clarity-Gated Document)
from clarity_gate import CGD

cgd = CGD(
    source_document="manual_usuario.pdf",
    metadata={
        "author": "Tech Team",
        "last_updated": "2026-09-01",
        "version": "2.1",
        "audience": "developers"
    }
)

# Processar e qualificar
cgd.process()
cgd.validate()

if cgd.is_qualified:
    # Adicionar ao knowledge base
    vector_store.add(cgd.to_embedding())
    print(f"Documento adicionado: {cgd.title}")
else:
    print(f"Documento rejeitado: {cgd.rejection_reasons}")
```

```python
# Exemplo 3: Validação de Source of Truth
from clarity_gate import SOTValidator

validator = SOTValidator()

# Validar se documento é SOT
is_sot = validator.validate(
    document="docs/authentication.md",
    reference_sources=[
        "https://auth0.com/docs",
        "https://oauth.net/2/"
    ],
    required_elements=[
        "authentication flow",
        "token refresh",
        "error handling"
    ]
)

print(f"É Source of Truth: {is_sot.is_valid}")
print(f"Cobertura: {is_sot.coverage}%")
print(f"Referências faltantes: {is_sot.missing_references}")
```

**Casos de uso avançados:**
- **Knowledge base governance:** Implementar pipeline de qualidade para KBs corporativas
- **Document lifecycle:** Gerenciar ciclo de vida de documentos com validação contínua
- **Multi-source reconciliation:** Resolver conflitos entre múltiplas fontes

**Integração com outras skills:**
- `rag-engineer`: para integrar no pipeline RAG
- `embedding-strategies`: para escolher modelos de embedding adequados
- `data-quality-frameworks`: para framework de qualidade unificado

**Padrões e anti-padrões:**
✅ Fazer: Validar todos os documentos antes de indexar
✅ Fazer: Implementar pipeline de revisão para documentos críticos
❌ Evitar: Indexar documentos sem validação
❌ Evitar: Ignorar fontes desatualizadas

**Dicas de performance:**
- Usar cache de documentos já validados
- Implementar validação assíncrona para documentos grandes
- Usar batch processing para múltiplos documentos

**Comandos úteis:**
```bash
# Validar documento
clarity-gate validate --document docs/api.md --criteria accuracy:0.8,freshness:30

# Gerar relatório de qualidade
clarity-gate report --kb production --format markdown
```

**Referências:**
- [RAG Quality Metrics](https://docs.llamaindex.ai/en/stable/evaluation/)
- [Document Quality Assessment](https://www.greatexpectations.io/docs/)
- [Knowledge Base Best Practices](https://docs.pinecone.io/docs/guides/get-started)

---

### 2.3 embedding-strategies

**Descrição:** Guia para selecionar e otimizar modelos de embedding para aplicações de busca vetorial.

**Quando usar:**
- Escolher modelo de embedding para caso de uso específico
- Otimizar qualidade de embeddings
- Comparar modelos diferentes
- Implementar busca semântica

**Exemplos práticos:**

```python
# Exemplo 1: Comparar embeddings de diferentes modelos
from sentence_transformers import SentenceTransformer
import numpy as np

# Carregar modelos
models = {
    'miniLM': SentenceTransformer('all-MiniLM-L6-v2'),
    'mpnet': SentenceTransformer('all-mpnet-base-v2'),
    'e5': SentenceTransformer('intfloat/e5-large-v2')
}

# Documentos de teste
documents = [
    "Machine learning is a subset of artificial intelligence",
    "Deep learning uses neural networks with multiple layers",
    "Natural language processing deals with text data",
    "Computer vision analyzes images and videos"
]

# Gerar embeddings
embeddings = {}
for name, model in models.items():
    embeddings[name] = model.encode(documents)

# Comparar similaridades
for name, emb in embeddings.items():
    similarities = []
    for i in range(len(documents)):
        for j in range(i+1, len(documents)):
            sim = np.dot(emb[i], emb[j]) / (np.linalg.norm(emb[i]) * np.linalg.norm(emb[j]))
            similarities.append(sim)
    print(f"{name}: avg similarity = {np.mean(similarities):.3f}")
```

```python
# Exemplo 2: Otimizar chunking para embeddings
from langchain.text_splitter import RecursiveCharacterTextSplitter

text = "Seu documento longo aqui..."

# Diferentes estratégias de chunking
strategies = {
    'fixed_size': RecursiveCharacterTextSplitter(chunk_size=500, chunk_overlap=50),
    'semantic': SemanticChunker(embedding_model="all-MiniLM-L6-v2"),
    'recursive': RecursiveCharacterTextSplitter(chunk_size=1000, chunk_overlap=200)
}

for name, splitter in strategies.items():
    chunks = splitter.split_text(text)
    print(f"{name}: {len(chunks)} chunks")
```

```python
# Exemplo 3: Avaliar qualidade de embeddings
from embedding_eval import EmbeddingEvaluator

evaluator = EmbeddingEvaluator()

# Avaliar embeddings em tarefa de retrieval
results = evaluator.evaluate(
    embeddings=your_embeddings,
    queries=test_queries,
    expected_results=expected_documents,
    metrics=['precision@5', 'recall@10', 'ndcg@10']
)

print(f"Precision@5: {results['precision@5']:.3f}")
print(f"Recall@10: {results['recall@10']:.3f}")
print(f"NDCG@10: {results['ndcg@10']:.3f}")
```

**Casos de uso avançados:**
- **Domain-specific embeddings:** Treinar modelos para domínios específicos (médico, jurídico)
- **Multilingual embeddings:** Usar modelos multilíngues para busca cross-lingual
- **Hybrid search:** Combinar embeddings densos com sparse vectors

**Integração com outras skills:**
- `similarity-search-patterns`: para implementar busca com embeddings
- `vector-database-engineer`: para armazenar e indexar embeddings
- `rag-engineer`: para integrar em pipelines RAG

**Padrões e anti-padrões:**
✅ Fazer: Testar múltiplos modelos antes de escolher
✅ Fazer: Avaliar embeddings com métricas relevantes
❌ Evitar: Usar modelo genérico para domínio específico
❌ Evitar: Ignorar custo de inferência de embeddings

**Dicas de performance:**
- Usar modelos quantizados para inferência mais rápida
- Implementar batch encoding para múltiplos documentos
- Usar cache de embeddings para documentos estáticos

**Comandos úteis:**
```bash
# Instalar sentence-transformers
pip install sentence-transformers

# Gerar embeddings
python -c "
from sentence_transformers import SentenceTransformer
model = SentenceTransformer('all-MiniLM-L6-v2')
embeddings = model.encode(['Hello world', 'Test sentence'])
print(f'Embeddings shape: {embeddings.shape}')
"
```

**Referências:**
- [Sentence Transformers](https://www.sbert.net/)
- [MTEB Leaderboard](https://huggingface.co/spaces/mteb/leaderboard)
- [Embedding Models Comparison](https://www.pinecone.io/learn/series/faiss/similarity-search/)

---

### 2.4 exa-search

**Descrição:** Busca semântica, descoberta de conteúdo similar e pesquisa estruturada usando a API Exa.

**Quando usar:**
- Busca baseada em embeddings/semântica
- Encontrar conteúdo similar
- Pesquisar por categorias (empresas, pessoas, papers)

**Exemplos práticos:**

```python
# Exemplo 1: Busca semântica com Exa
from exa import ExaClient

client = ExaClient(api_key="sua_chave")

# Buscar conteúdo similar a um texto
results = client.search(
    query="como implementar autenticação OAuth 2.0",
    num_results=10,
    use_autoprompt=True,
    type="neural"  # Busca neural/semântica
)

for result in results.results:
    print(f"Título: {result.title}")
    print(f"URL: {result.url}")
    print(f"Score: {result.score}")
    print("---")
```

```python
# Exemplo 2: Buscar papers de pesquisa
results = client.search(
    query="transformer architecture for time series forecasting",
    num_results=5,
    include_domains=["arxiv.org", "semanticscholar.org"],
    start_published_date="2025-01-01"
)

for paper in results.results:
    print(f"Paper: {paper.title}")
    print(f"Published: {paper.published_date}")
    print(f"Abstract: {paper.text[:200]}...")
```

```python
# Exemplo 3: Encontrar empresas similares
results = client.search(
    query="startup de fintech que trabalha com pagamentos digitais na América Latina",
    num_results=10,
    category="company"
)

for company in results.results:
    print(f"Empresa: {company.title}")
    print(f"Descrição: {company.text[:150]}...")
```

**Casos de uso avançados:**
- **Competitive intelligence:** Encontrar concorrentes e comparar produtos
- **Research automation:** Coletar e resumir papers de pesquisa
- **Content discovery:** Encontrar conteúdo relevante para nichos específicos

**Integração com outras skills:**
- `rag-engineer`: para alimentar knowledge bases com conteúdo encontrado
- `firecrawl-scraper`: para extrair conteúdo completo das URLs encontradas
- `data-storytelling`: para comunicar insights de pesquisa

**Padrões e anti-padrões:**
✅ Fazer: Usar filtros de domínio para resultados relevantes
✅ Fazer: Combinar busca neural com filtros de data
❌ Evitar: Buscar sem filtros (muitos resultados irrelevantes)
❌ Evitar: Usar para scraping em massa (viola ToS)

**Dicas de performance:**
- Usar autoprompt para queries mais precisas
- Filtrar por domínio para reduzir ruído
- Usar cache para queries frequentes

**Comandos úteis:**
```bash
# Instalar SDK
pip install exa-py

# Teste rápido
python -c "
from exa import ExaClient
client = ExaClient(api_key='SUA_CHAVE')
results = client.search('machine learning', num_results=3)
print(f'Encontrados {len(results.results)} resultados')
"
```

**Referências:**
- [Exa API Documentation](https://docs.exa.ai/)
- [Exa Python SDK](https://github.com/exa-labs/exa-python)
- [Search Best Practices](https://docs.exa.ai/docs/search-best-practices)

---

### 2.5 llm-app-patterns

**Descrição:** Esboços de arquitetura e integração para aplicações LLM, com limites explícitos de recuperação, ferramentas, privacidade e verificação.

**Quando usar:**
- Projetar arquitetura de nova aplicação LLM
- Definir boundaries de segurança
- Implementar RAG com restrições
- Logging e verificação de respostas

**Exemplos práticos:**

```python
# Exemplo 1: Arquitetura básica de aplicação LLM
from llm_patterns import LLMApp, SecurityBoundary

app = LLMApp(
    model="gpt-4",
    security=SecurityBoundary(
        allowed_domains=["company.com", "docs.company.com"],
        blocked_topics=["competitor_analysis", "financial_projections"],
        data_classification="confidential"
    ),
    logging={
        "enabled": True,
        "destination": "s3://logs/llm-app/",
        "redact_pii": True
    }
)

# Definir ferramentas disponíveis
app.add_tool("database_query", schema=db_schema)
app.add_tool("web_search", allowed_domains=["company.com"])

# Usar
response = app.query(
    "Qual foi o faturamento do último trimestre?",
    context={"user_role": "analyst", "department": "finance"}
)
```

```python
# Exemplo 2: RAG com restrições de acesso
from llm_patterns import RestrictedRAG

rag = RestrictedRAG(
    vector_store="pinecone",
    embedding_model="text-embedding-3-small",
    access_control={
        "user_levels": ["public", "internal", "confidential", "secret"],
        "user_clearance": "internal"  # Nível do usuário atual
    }
)

# Buscar apenas documentos que o usuário pode acessar
results = rag.search(
    query="políticas de segurança da informação",
    user_clearance="internal",
    max_results=5
)

# Gerar resposta
response = rag.generate(
    query="Quais são as políticas de segurança?",
    context=results,
    citations=True  # Incluir citações
)
```

```python
# Exemplo 3: Verificação de respostas
from llm_patterns import ResponseVerifier

verifier = ResponseVerifier(
    rules=[
        {"type": "no_hallucination", "source": "knowledge_base"},
        {"type": "citation_required", "min_citations": 2},
        {"type": "no_sensitive_data", "patterns": ["SSN", "credit_card"]}
    ]
)

# Verificar resposta
result = ver
# Verificar resposta
response_text = "O faturamento do Q3 foi de R$ 5M com crescimento de 15%"
result = verifier.verify(response_text, context=results)

print(f"Válido: {result.is_valid}")
print(f"Score: {result.score}/100")
if result.issues:
    for issue in result.issues:
        print(f"  - {issue}")
`

**Casos de uso avançados:**
- **Multi-tenant LLM:** Implementar isolamento de dados entre tenants
- **Audit trail:** Manter registro completo de todas as interações LLM
- **Fallback chains:** Implementar fallback entre múltiplos modelos

**Integração com outras skills:**
- ag-engineer: para implementar RAG production-ready
- local-llm-expert: para deploy local com privacidade
- i-engineering-toolkit: para workflows de engenharia AI

**Padrões e anti-padrões:**
✅ Fazer: Implementar logging completo de todas as interações
✅ Fazer: Usar streaming para respostas longas
❌ Evitar: Expor dados sensíveis em prompts
❌ Evitar: Usar LLM para decisões críticas sem verificação humana

**Dicas de performance:**
- Usar caching de respostas para queries frequentes
- Implementar batch processing para múltiplas queries
- Usar modelos menores para tarefas simples

**Comandos úteis:**
`ash
# Instalar SDK
pip install llm-app-patterns

# Testar aplicação
llm-app test --config app_config.yaml --query "Test query"
`

**Referências:**
- [LLM Application Architecture](https://docs.smith.langchain.com/)
- [Building LLM Apps](https://docs.llamaindex.ai/)
- [OpenAI Best Practices](https://platform.openai.com/docs/guides/production-best-practices)

---

### 2.6 local-llm-expert

**Descrição:** Domínio de inferência LLM local, seleção de modelos, otimização de VRAM e deploy local usando Ollama, llama.cpp, vLLM e LM Studio. Expertise em formatos de quantização (GGUF, EXL2) e privacidade de AI local.

**Quando usar:**
- Rodar modelos LLM localmente
- Otimizar para hardware disponível
- Garantir privacidade de dados
- Reduzir custos de API

**Exemplos práticos:**

`python
# Exemplo 1: Inferência com Ollama
import ollama

# Chat simples
response = ollama.chat(
    model='llama3:70b',
    messages=[
        {'role': 'user', 'content': 'Explique o que é machine learning'}
    ]
)
print(response['message']['content'])
`

`python
# Exemplo 2: Inferência com llama.cpp
from llama_cpp import Llama

# Carregar modelo quantizado
llm = Llama(
    model_path="./models/llama-3-8b-instruct.Q4_K_M.gguf",
    n_ctx=4096,
    n_gpu_layers=35  # Offload para GPU
)

# Gerar texto
output = llm(
    "Qual são as vantagens de Python?",
    max_tokens=512,
    temperature=0.7,
    stop=["\n\n"]
)
print(output['choices'][0]['text'])
`

`python
# Exemplo 3: Benchmark de modelos
import time

models = [
    "llama3:8b",
    "llama3:70b",
    "mistral:7b",
    "codellama:13b"
]

prompts = [
    "Explique o conceito de OOP",
    "Escreva uma função para ordenar uma lista",
    "O que é REST API?"
]

for model in models:
    print(f"\nBenchmarking {model}...")
    for prompt in prompts:
        start = time.time()
        response = ollama.chat(model=model, messages=[{'role': 'user', 'content': prompt}])
        elapsed = time.time() - start
        tokens = len(response['message']['content'].split())
        print(f"  Prompt: {prompt[:30]}... | Tokens: {tokens} | Time: {elapsed:.2f}s")
`

**Casos de uso avançados:**
- **Edge deployment:** Rodar modelos em dispositivos边缘设备
- **Hybrid inference:** Combinar modelos locais e cloud
- **Fine-tuning local:** Treinar modelos para domínios específicos

**Integração com outras skills:**
- mbedding-strategies: para embeddings locais
- ector-database-engineer: para armazenamento vetorial local
- i-engineering-toolkit: para avaliação de prompts locais

**Padrões e anti-padrões:**
✅ Fazer: Testar modelos em hardware alvo antes de deploy
✅ Fazer: Monitorar uso de VRAM durante inferência
❌ Evitar: Rodar modelos muito grandes para hardware disponível
❌ Evitar: Ignorar latência de carregamento de modelos

**Dicas de performance:**
- Usar quantização Q4_K_M para balancear qualidade e velocidade
- Implementar batching para múltiplas requests
- Usar GPU offload quando disponível

**Comandos úteis:**
`ash
# Ollama
ollama pull llama3:70b
ollama run llama3:70b

# llama.cpp
./main -m models/llama-3-70b.Q4_K_M.gguf -n 256 --gpu-layers 35

# vLLM
python -m vllm.entrypoints.openai.api_server --model meta-llama/Llama-3-70B
`

**Referências:**
- [Ollama Documentation](https://ollama.com/)
- [llama.cpp](https://github.com/ggerganov/llama.cpp)
- [vLLM](https://docs.vllm.ai/)
- [Hugging Face GGUF](https://huggingface.co/docs/hub/en-gb/gguf)

---

### 2.7 notebooklm

**Descrição:** Interagir com o Google NotebookLM para consultar documentação com respostas fundamentadas do Gemini.

**Quando usar:**
- Consultar documentação extensa de forma conversacional
- Obter respostas fundamentadas em documentos específicos
- Explorar knowledge bases de forma interativa

**Exemplos práticos:**

`python
# Exemplo 1: Consultar NotebookLM via browser automation
from playwright.sync_api import sync_playwright

def query_notebooklm(question, notebook_url):
    with sync_playwright() as p:
        browser = p.chromium.launch(headless=False)
        page = browser.new_page()
        
        # Navegar para o notebook
        page.goto(notebook_url)
        page.wait_for_load_state('networkidle')
        
        # Encontrar campo de input e fazer pergunta
        input_field = page.locator('textarea[aria-label="Ask a question"]')
        input_field.fill(question)
        input_field.press('Enter')
        
        # Esperar resposta
        page.wait_for_selector('.response-container', timeout=30000)
        
        # Extrair resposta
        response = page.locator('.response-container').inner_text()
        
        browser.close()
        return response

# Usar
answer = query_notebooklm(
    "Quais são as APIs disponíveis no SDK?",
    "https://notebooklm.google.com/notebook/abc123"
)
print(answer)
`

**Casos de uso avançados:**
- **Documentation QA:** Criar sistema de Q&A sobre documentação técnica
- **Knowledge discovery:** Explorar insights em documentos não estruturados

**Integração com outras skills:**
- ag-engineer: para comparar com sistemas RAG customizados
- clarity-gate: para validar qualidade dos documentos antes de carregar

**Padrões e anti-padrões:**
✅ Fazer: Documentar perguntas frequentes para reutilização
❌ Evitar: Confiar cegamente nas respostas sem verificação

**Dicas de performance:**
- Ser específico nas perguntas para obter respostas mais precisas
- Usar linguagem similar à dos documentos

**Comandos úteis:**
`ash
pip install playwright
playwright install chromium
`

**Referências:**
- [NotebookLM](https://notebooklm.google.com/)
- [Google AI Studio](https://aistudio.google.com/)

---

### 2.8 rag-engineer

**Descrição:** Expertise em construir sistemas Retrieval-Augmented Generation (RAG). Domínio em modelos de embedding, bancos de dados vetoriais, estratégias de chunking e otimização de recuperação para aplicações LLM.

**Quando usar:**
- Construir ou otimizar sistemas RAG
- Escolher banco vetorial
- Definir chunking strategies
- Otimizar recall e precisão

**Exemplos práticos:**

`python
# Exemplo 1: Pipeline RAG completo
from langchain_community.document_loaders import PyPDFLoader
from langchain.text_splitter import RecursiveCharacterTextSplitter
from langchain_openai import OpenAIEmbeddings, ChatOpenAI
from langchain_community.vectorstores import Chroma
from langchain.chains import RetrievalQA

# 1. Carregar documentos
loader = PyPDFLoader("docs/manual.pdf")
documents = loader.load()

# 2. Chunking
text_splitter = RecursiveCharacterTextSplitter(
    chunk_size=1000,
    chunk_overlap=200,
    length_function=len,
    separators=["\n\n", "\n", ". ", " ", ""]
)
chunks = text_splitter.split_documents(documents)

# 3. Embeddings e Vector Store
embeddings = OpenAIEmbeddings(model="text-embedding-3-small")
vectorstore = Chroma.from_documents(
    documents=chunks,
    embedding=embeddings,
    persist_directory="./chroma_db"
)

# 4. RAG Chain
llm = ChatOpenAI(model="gpt-4", temperature=0)
qa_chain = RetrievalQA.from_chain_type(
    llm=llm,
    chain_type="stuff",
    retriever=vectorstore.as_retriever(
        search_type="mmr",
        search_kwargs={"k": 5, "fetch_k": 20}
    ),
    return_source_documents=True
)

# 5. Consultar
result = qa_chain.invoke({"query": "Como configurar autenticação?"})
print(result["result"])
for doc in result["source_documents"]:
    print(f"Fonte: {doc.metadata['source']}, Página: {doc.metadata.get('page', 'N/A')}")
`

`python
# Exemplo 2: Avaliação de RAG
from rag_evaluator import RAGEvaluator

evaluator = RAGEvaluator()

# Avaliar qualidade de retrieval
retrieval_results = evaluator.evaluate_retrieval(
    retriever=vectorstore.as_retriever(),
    test_queries=[
        {"query": "Como fazer login?", "expected_docs": ["auth_guide.pdf"]},
        {"query": "Configurar banco de dados", "expected_docs": ["db_setup.pdf"]}
    ],
    metrics=["precision@5", "recall@10", "mrr"]
)

print(f"Retrieval Precision@5: {retrieval_results['precision@5']:.3f}")
`

`python
# Exemplo 3: RAG com hybrid search
from langchain.retrievers import EnsembleRetriever
from langchain.retrievers import BM25Retriever

# BM25 para keyword search
bm25_retriever = BM25Retriever.from_documents(chunks)
bm25_retriever.k = 5

# Vector search
vector_retriever = vectorstore.as_retriever(search_kwargs={"k": 5})

# Hybrid search
ensemble_retriever = EnsembleRetriever(
    retrievers=[bm25_retriever, vector_retriever],
    weights=[0.3, 0.7]
)
`

**Casos de uso avançados:**
- **Multi-modal RAG:** Indexar e recuperar imagens, tabelas e código
- **Agentic RAG:** Usar agentes para orquestrar recuperação e geração
- **Streaming RAG:** Implementar respostas streaming com referências

**Integração com outras skills:**
- ector-database-engineer: para otimizar armazenamento vetorial
- mbedding-strategies: para escolher melhores embeddings
- clarity-gate: para validar documentos antes de indexar

**Padrões e anti-padrões:**
✅ Fazer: Avaliar RAG com métricas objetivas
✅ Fazer: Implementar hybrid search (dense + sparse)
❌ Evitar: Chunking muito pequeno (perde contexto)
❌ Evitar: Ignorar re-ranking dos resultados

**Dicas de performance:**
- Usar HNSW para indexação eficiente
- Implementar cache de embeddings
- Usar small-to-big retrieval para contexto rico

**Comandos úteis:**
`ash
pip install langchain langchain-openai chromadb
chroma run --path ./chroma_db
`

**Referências:**
- [LangChain RAG](https://python.langchain.com/docs/concepts/rag/)
- [ChromaDB](https://docs.trychroma.com/)
- [RAG Metrics](https://docs.ragas.io/)

---

### 2.9 recsys-pipeline-architect

**Descrição:** Projetar pipelines composáveis de recomendação, ranking e feed usando o framework de 6 estágios: Source → Hydrator → Filter → Scorer → Selector → SideEffect.

**Quando usar:**
- Projetar sistemas de recomendação escaláveis
- Criar feeds personalizados
- Implementar sistemas de ranking

**Exemplos práticos:**

`python
# Exemplo 1: Pipeline de recomendação completo
from recsys_pipeline import (
    Source, Hydrator, Filter, Scorer, Selector, SideEffect
)

# 1. Source - Buscar itens candidatos
class ProductSource(Source):
    def get_candidates(self, user_id):
        return self.db.query("SELECT * FROM products WHERE active = true")

# 2. Hydrator - Enriquecer com dados do usuário
class UserHydrator(Hydrator):
    def hydrate(self, candidates, user_id):
        user_profile = self.get_user_profile(user_id)
        for candidate in candidates:
            candidate['user_preferences'] = user_profile['preferences']
        return candidates

# 3. Filter - Filtrar itens irrelevantes
class RelevanceFilter(Filter):
    def filter(self, candidates, user_id):
        return [c for c in candidates if c['category'] in self.get_user_interests(user_id)]

# 4. Scorer - Pontuar relevância
class MLScorer(Scorer):
    def score(self, candidates):
        features = self.extract_features(candidates)
        scores = self.model.predict_proba(features)
        for i, candidate in enumerate(candidates):
            candidate['score'] = scores[i]
        return candidates

# 5. Selector - Selecionar top-N
class TopNSelector(Selector):
    def select(self, scored_items, n=10):
        return sorted(scored_items, key=lambda x: x['score'], reverse=True)[:n]

# Montar pipeline
pipeline = (
    ProductSource(db) >>
    UserHydrator(user_service) >>
    RelevanceFilter(interest_service) >>
    MLScorer(model) >>
    TopNSelector(n=10)
)

recommendations = pipeline.execute(user_id="user_123")
`

**Casos de uso avançados:**
- **Multi-objective optimization:** Balancear relevância, diversidade e novelty
- **Real-time personalization:** Atualizar recomendações em tempo real

**Integração com outras skills:**
- ector-database-engineer: para retrieval vetorial
- data-scientist: para treinar modelos de ranking

**Padrões e anti-padrões:**
✅ Fazer: Modularizar cada estágio do pipeline
✅ Fazer: Implementar fallbacks em cada estágio
❌ Evitar: Pipelines monolíticos sem separação de responsabilidades

**Dicas de performance:**
- Usar caching em estágios de hydratedados
- Implementar pre-computation para features estáticas

**Comandos úteis:**
`ash
pip install recsys-pipeline
recsys run --config pipeline.yaml --user user_123
`

**Referências:**
- [Designing Machine Learning Systems](https://www.oreilly.com/library/view/designing-machine-learning/9781098107956/)
- [Feast Feature Store](https://docs.feast.dev/)

---

### 2.10 seek-and-analyze-video

**Descrição:** Buscar e analisar conteúdo de vídeo usando o Modelo de Memória Visual Grande (Memories.ai) para inteligência de vídeo persistente.

**Quando usar:**
- Analisar conteúdo de vídeo
- Detectar cenas específicas
- Extrair informações visuais

**Exemplos práticos:**

`python
# Exemplo 1: Buscar cenas específicas em vídeos
from memories_ai import VideoAnalyzer

analyzer = VideoAnalyzer(api_key="sua_chave")

results = analyzer.search(
    video_url="https://example.com/video.mp4",
    query="pessoa apresentando gráfico",
    time_range={"start": "00:05:00", "end": "00:30:00"}
)

for scene in results.scenes:
    print(f"Timestamp: {scene.start_time} - {scene.end_time}")
    print(f"Confiança: {scene.confidence:.2f}")
`

`python
# Exemplo 2: Extração de informações visuais
analysis = analyzer.analyze(
    video_url="https://example.com/presentation.mp4",
    features=["ocr", "objects", "faces", "actions", "scenes"]
)

print(f"Texto detectado: {analysis.ocr_texts}")
print(f"Pessoas detectadas: {analysis.detected_faces}")
`

**Casos de uso avançados:**
- **Content moderation:** Detectar conteúdo inappropriate
- **Video summarization:** Criar resumos automáticos

**Integração com outras skills:**
- ag-engineer: para indexar informações de vídeos
- data-storytelling: para comunicar insights de vídeo

**Padrões e anti-padrões:**
✅ Fazer: Respetar direitos autorais de vídeos
❌ Evitar: Analisar vídeos sem permissão

**Dicas de performance:**
- Usar transcrição de áudio para acelerar processamento
- Implementar batch processing para múltiplos vídeos

**Referências:**
- [Memories.ai Documentation](https://docs.memories.ai/)

---

### 2.11 similarity-search-patterns

**Descrição:** Implementar busca de similaridade eficiente com bancos de dados vetoriais.

**Quando usar:**
- Implementar busca por similaridade em embeddings
- Sistemas de recomendação
- Deduplicação de dados

**Exemplos práticos:**

`python
# Exemplo 1: Busca por similaridade com FAISS
import faiss
import numpy as np

dimension = 768
index = faiss.IndexFlatIP(dimension)

embeddings = np.random.rand(10000, dimension).astype('float32')
index.add(embeddings)

query = np.random.rand(1, dimension).astype('float32')
distances, indices = index.search(query, k=10)

print(f"Top 10 resultados: {indices[0]}")
`

`python
# Exemplo 2: HNSW para busca eficiente
import hnswlib

index = hnswlib.Index(space='cosine', dim=768)
index.init_index(max_elements=100000, ef_construction=200, M=16)

for i, emb in enumerate(embeddings):
    index.add_items(emb, i)

labels, distances = index.knn_query(query, k=10)
print(f"Similaridades: {1 - distances}")
`

**Casos de uso avançados:**
- **Approximate Nearest Neighbor (ANN):** Usar HNSW ou IVF para escalabilidade
- **Cross-modal search:** Buscar imagens usando texto

**Integração com outras skills:**
- ector-database-engineer: para implementação de índices
- ector-index-tuning: para otimizar parâmetros

**Padrões e anti-padrões:**
✅ Fazer: Usar normalização para embeddings
❌ Evitar: Usar busca exata para grandes volumes

**Dicas de performance:**
- Usar quantização de embeddings para reduzir memória
- Implementar caching de queries frequentes

**Referências:**
- [FAISS](https://faiss.ai/)
- [HNSW](https://github.com/nmslib/hnswlib)

---

### 2.12 tavily-web

**Descrição:** Busca web, extração de conteúdo, crawling e capacidades de pesquisa usando a API Tavily.

**Quando usar:**
- Buscar informações atualizadas na web
- Extrair conteúdo de URLs
- Alimentar LLMs com dados atualizados

**Exemplos práticos:**

`python
# Exemplo 1: Busca web com Tavily
from tavily import TavilyClient

client = TavilyClient(api_key="sua_chave")

results = client.search(
    query="últimas notícias sobre inteligência artificial 2026",
    search_depth="advanced",
    include_answer=True,
    max_results=10
)

print(f"Resposta: {results['answer']}")

for result in results['results']:
    print(f"Fonte: {result['title']}")
    print(f"URL: {result['url']}")
`

`python
# Exemplo 2: Extração de conteúdo de URL
extracted = client.extract(
    urls=["https://example.com/article1", "https://example.com/article2"],
    include_images=True,
    extract_depth="advanced"
)

for page in extracted['results']:
    print(f"URL: {page['url']}")
    print(f"Conteúdo: {page['raw_content'][:500]}...")
`

**Casos de uso avançados:**
- **Research automation:** Coletar e sintetizar informações
- **Knowledge base enrichment:** Atualizar knowledge bases com dados atuais

**Integração com outras skills:**
- ag-engineer: para alimentar RAG com dados atualizados
- xa-search: para busca semântica complementar

**Padrões e anti-padrões:**
✅ Fazer: Usar include_answer para respostas rápidas
❌ Evitar: Buscar sem query específica

**Dicas de performance:**
- Usar search_depth="basic" para buscas rápidas
- Cache de resultados para queries frequentes

**Referências:**
- [Tavily Documentation](https://docs.tavily.com/)

---

### 2.13 vector-database-engineer

**Descrição:** Expertise em bancos de dados vetoriais, estratégias de embedding e implementação de busca semântica. Domínio em Pinecone, Weaviate, Qdrant, Milvus e pgvector.

**Quando usar:**
- Escolher banco vetorial para caso de uso
- Configurar e otimizar clusters
- Implementar busca semântica escalável

**Exemplos práticos:**

`python
# Exemplo 1: Configurar Qdrant
from qdrant_client import QdrantClient
from qdrant_client.models import Distance, VectorParams, PointStruct

client = QdrantClient(host="localhost", port=6333)

client.create_collection(
    collection_name="documents",
    vectors_config=VectorParams(size=1536, distance=Distance.COSINE)
)

points = [
    PointStruct(
        id=i,
        vector=embedding.tolist(),
        payload={"text": doc["text"], "metadata": doc["metadata"]}
    )
    for i, (embedding, doc) in enumerate(zip(embeddings, documents))
]

client.upsert(collection_name="documents", points=points)
`

`python
# Exemplo 2: Configurar Pinecone
import pinecone

pinecone.init(api_key="sua_chave", environment="us-east1-gcp")

pinecone.create_index(
    name="documents",
    dimension=1536,
    metric="cosine",
    metadata_config={"indexed": ["category", "source"]}
)

index = pinecone.Index("documents")

index.upsert(vectors=[
    {
        "id": f"doc_{i}",
        "values": embedding.tolist(),
        "metadata": {"category": "technical", "text": doc["text"][:1000]}
    }
    for i, (embedding, doc) in enumerate(zip(embeddings, documents))
])
`

**Casos de uso avançados:**
- **Multi-tenancy:** Implementar isolamento por tenant
- **Real-time indexing:** Atualizar embeddings em tempo real

**Integração com outras skills:**
- ector-index-tuning: para otimizar índices
- ag-engineer: para integrar em pipelines RAG

**Padrões e anti-padrões:**
✅ Fazer: Escolher banco baseado em requisitos de escala
❌ Evitar: Ignorar custos de armazenamento vetorial

**Dicas de performance:**
- Usar HNSW para busca eficiente
- Configurar parâmetros de batch para upserts

**Referências:**
- [Qdrant Documentation](https://qdrant.tech/documentation/)
- [Pinecone Documentation](https://docs.pinecone.io/)

---

### 2.14 vector-index-tuning

**Descrição:** Otimizar performance de índices vetoriais para latência, recall e memória.

**Quando usar:**
- Latência de busca vetorial acima do ideal
- Recall abaixo do esperado
- Custo de memória excessivo

**Exemplos práticos:**

`python
# Exemplo 1: Otimizar parâmetros HNSW
import optuna
from qdrant_client import QdrantClient
import numpy as np

def objective(trial):
    m = trial.suggest_int('m', 8, 64)
    ef_construction = trial.suggest_int('ef_construction', 100, 500)
    ef_search = trial.suggest_int('ef_search', 10, 200)
    
    # Criar índice e medir performance
    # ... (código de benchmark)
    return avg_latency

study = optuna.create_study(direction='minimize')
study.optimize(objective, n_trials=50)

print(f"Melhores parâmetros: {study.best_params}")
`

**Casos de uso avançados:**
- **Multi-tier indexing:** Usar índices diferentes para diferentes requisitos
- **Sharding:** Distribuir índices em múltiplos shards

**Integração com outras skills:**
- ector-database-engineer: para implementação de índices
- similarity-search-patterns: para padrões de busca

**Padrões e anti-padrões:**
✅ Fazer: Benchmark antes e depois de mudanças
❌ Evitar: Otimizar apenas para latência

**Dicas de performance:**
- Usar HNSW para busca eficiente
- Configurar parâmetros de batch para upserts

**Referências:**
- [HNSW Paper](https://arxiv.org/abs/1603.09320)
- [Qdrant Optimization](https://qdrant.tech/documentation/guides/optimization/)

---

## Resumo Estatístico

| Categoria | Qtd Skills | Vault Path |
|---|---|---|
| Data | 22 | skill-libraries/data |
| Data AI | 14 | skill-libraries/data-ai |
| Data Science | 8 | skill-libraries/data-science |
| Data Engineering | 1 | skill-libraries/data-engineering |
| Database | 16 | skill-libraries/database |
| Database Processing | 6 | skill-libraries/database-processing |
| Databases | 2 | skill-libraries/databases |
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
2. Use o comando iew_file para ler o SKILL.md do vault correspondente.
3. Siga as instruções do arquivo para completar a solicitação.

> **Aviso:** Não adivinhe boas práticas — sempre leia do vault primeiro.
> **Anti-loop:** Não invoque skills recursivamente. Cada skill deve ser carregada no máximo uma vez por solicitação do usuário.
