# 🗄️ Database & Data Skills - 4.000 Skills

> **Todas as habilidades de banco de dados documentadas**

---

## 📊 Visão Geral

| Subcategoria | Skills | Nível |
|--------------|--------|-------|
| SQL Databases | 800 | Básico → Expert |
| NoSQL Databases | 700 | Intermediário → Expert |
| Data Modeling | 500 | Intermediário → Expert |
| Performance Tuning | 400 | Avançado → Expert |
| Database Administration | 500 | Intermediário → Expert |
| Data Integration | 400 | Intermediário → Expert |
| Graph Databases | 300 | Intermediário → Expert |
| Time Series | 200 | Intermediário → Expert |
| NewSQL | 200 | Intermediário → Expert |
| Database Security | 200 | Avançado → Expert |

---

## 🗃️ SQL Databases (800)

### MySQL (200)

#### DB001: MySQL Mastery
```lua
-- SKILL: MySQL Mastery
-- Nível: Básico → Expert
-- Contexto: MySQL production

-- CONCEITOS:
-- 1. Storage Engines: InnoDB, MyISAM
-- 2. Indexing: B-Tree, Hash, Full-Text
-- 3. Replication: master-slave, group
-- 4. Partitioning: range, hash, list
-- 5. Query Optimization: EXPLAIN, hints

-- MELHORIA:
-- ERRADO: MyISAM para produção
-- CERTO: InnoDB + proper indexing
```

### PostgreSQL (200)

#### DB002: PostgreSQL Advanced
```lua
-- SKILL: PostgreSQL Advanced
-- Nível: Intermediário → Expert
-- Contexto: PostgreSQL avançado

-- FEATURES:
-- 1. JSON/JSONB: document storage
-- 2. Full-Text Search: tsvector, tsquery
-- 3. CTEs: Common Table Expressions
-- 4. Window Functions: OVER, PARTITION BY
-- 5. Foreign Data Wrappers: postgres_fdw
-- 6. Extensions: PostGIS, pg_stat

-- MELHORIA:
-- ERRADO: Apenas tabelas simples
-- CERTO: JSONB + full-text + extensions
```

### SQL Server (200)

#### DB003: SQL Server Production
```lua
-- SKILL: SQL Server Production
-- Nível: Intermediário → Expert
-- Contexto: SQL Server em produção

-- FEATURES:
-- 1. Always On: high availability
-- 2. Columnstore: analytics
-- 3. In-Memory OLTP: performance
-- 4. Query Store: plan analysis
-- 5. Temporal Tables: history
-- 6. Graph Tables: relationships

-- MELHORIA:
-- ERRADO: Apenas basic queries
-- CERTO: Advanced features + optimization
```

### SQLite (200)

#### DB004: SQLite Production
```lua
-- SKILL: SQLite Production
-- Nível: Intermediário → Expert
-- Contexto: SQLite em produção

-- CONCEITOS:
-- 1. WAL Mode: concurrent reads
-- 2. FTS5: full-text search
-- 3. JSON: document storage
-- 4. Backup: online backup API
-- 5. Extensions: custom functions

-- CASOS:
-- Mobile apps, Embedded systems
-- Testing, Prototyping
-- Read-heavy workloads

-- MELHORIA:
-- ERRADO: SQLite for multi-user write
-- CERTO: SQLite for edge/mobile + read-heavy
```

---

## 📦 NoSQL Databases (700)

### Document Databases (200)

#### DB005: MongoDB Production
```lua
-- SKILL: MongoDB Production
-- Nível: Intermediário → Expert
-- Contexto: MongoDB em produção

-- CONCEITOS:
-- 1. Schema Design: embedding vs referencing
-- 2. Indexing: compound, multikey, text
-- 3. Aggregation Pipeline: $match, $group
-- 4. Sharding: horizontal scaling
-- 5. Replica Sets: high availability

-- MELHORIA:
-- ERRADO: Schema-free chaos
-- CERTO: Schema design + proper indexing
```

### Key-Value Stores (150)

#### DB006: Redis Production
```lua
-- SKILL: Redis Production
-- Nível: Intermediário → Expert
-- Contexto: Redis em produção

-- CONCEITOS:
-- 1. Data Structures: strings, lists, sets
-- 2. Persistence: RDB, AOF
-- 3. Clustering: Redis Cluster
-- 4. Pub/Sub: messaging
-- 5. Lua Scripts: atomic operations

-- USE CASES:
-- Caching, Session Store
-- Rate Limiting, Leaderboards
-- Real-time Analytics

-- MELHORIA:
-- ERRADO: Redis as primary database
-- CERTO: Redis as cache + session store
```

### Column-Family (150)

#### DB007: Cassandra Production
```lua
-- SKILL: Cassandra Production
-- Nível: Intermediário → Expert
-- Contexto: Cassandra em produção

-- CONCEITOS:
-- 1. Data Model: partition keys, clustering
-- 2. Consistency: tunable levels
-- 3. Compaction: strategies
-- 4. Monitoring: nodetool, metrics
-- 5. Backup: snapshots, repairs

-- MELHORIA:
-- ERRADO: Anti-pattern data model
-- CERTO: Query-driven data modeling
```

### Search Engines (200)

#### DB008: Elasticsearch Production
```lua
-- SKILL: Elasticsearch Production
-- Nível: Intermediário → Expert
-- Contexto: Elasticsearch em produção

-- CONCEITOS:
-- 1. Index Design: mappings, settings
-- 2. Query DSL: bool, match, term
-- 3. Aggregations: metrics, buckets
-- 4. Cluster Management: shards, replicas
-- 5. Performance: caching, optimization

-- MELHORIA:
-- ERRADO: Over-sharding
-- CERTO: Proper index design + tuning
```

---

## 📐 Data Modeling (500)

### Conceptual Modeling (150)

#### DB009: Conceptual Data Modeling
```lua
-- SKILL: Conceptual Data Modeling
-- Nível: Intermediário → Expert
-- Contexto: Modelagem conceitual

-- TÉCNICAS:
-- 1. ER Diagrams: entities, relationships
-- 2. UML Class Diagrams: objects
-- 3. Dimensional Modeling: star, snowflake
-- 4. Data Vault: history, audit
-- 5. Anchor Modeling: temporal

-- MELHORIA:
-- ERRADO: Physical model first
-- CERTO: Conceptual → Logical → Physical
```

### Logical Modeling (150)

#### DB010: Logical Data Modeling
```lua
-- SKILL: Logical Data Modeling
-- Nível: Intermediário → Expert
-- Contexto: Modelagem lógica

-- CONCEITOS:
-- 1. Normalization: 1NF, 2NF, 3NF, BCNF
-- 2. Denormalization: read performance
-- 3. Surrogate Keys: artificial PKs
-- 4. Slowly Changing Dimensions: SCD Type 1-6
-- 5. Temporal Modeling: bitemporal

-- MELHORIA:
-- ERRADO: Over-normalization
-- CERTO: Balance normalization + performance
```

### Physical Modeling (100)

#### DB011: Physical Data Modeling
```lua
-- SKILL: Physical Data Modeling
-- Nível: Intermediário → Expert
-- Contexto: Modelagem física

-- CONCEITOS:
-- 1. Index Design: B-Tree, Hash, GIN, GiST
-- 2. Partitioning: range, hash, list
-- 3. Compression: columnar, row
-- 4. Storage: SSD vs HDD, RAID
-- 5. Caching: buffer pool, query cache

-- MELHORIA:
-- ERRADO: Default everything
-- CERTO: Tuned physical design
```

### Data Architecture (100)

#### DB012: Data Architecture
```lua
-- SKILL: Data Architecture
-- Nível: Avançado → Expert
-- Contexto: Arquitetura de dados

-- PADRÕES:
-- 1. Data Warehouse: Kimball, Inmon
-- 2. Data Lake: raw, curated, refined
-- 3. Data Mesh: domain ownership
-- 4. Data Fabric: metadata-driven
-- 5. Lakehouse: unified platform

-- MELHORIA:
-- ERRADO: Data swamp
-- CERTO: Governance + quality + catalog
```

---

## ⚡ Performance Tuning (400)

### Query Optimization (200)

#### DB013: Query Optimization
```lua
-- SKILL: Query Optimization
-- Nível: Intermediário → Expert
-- Contexto: Otimização de queries

-- TÉCNICAS:
-- 1. EXPLAIN: execution plans
-- 2. Index Hints: force index
-- 3. Query Rewriting: subquery → join
-- 4. Statistics: ANALYZE, UPDATE STATS
-- 5. Plan Cache: parameterized queries

-- MELHORIA:
-- ERRADO: SELECT *
-- CERTO: Specific columns + proper indexing
```

### Index Optimization (100)

#### DB014: Index Optimization
```lua
-- SKILL: Index Optimization
-- Nível: Intermediário → Expert
-- Contexto: Otimização de índices

-- TIPOS:
-- 1. B-Tree: range queries
-- 2. Hash: equality queries
-- 3. GIN: arrays, JSONB, full-text
-- 4. GiST: spatial, ranges
-- 5. Partial: conditional indexes
-- 6. Covering: index-only scans

-- MELHORIA:
-- ERRADO: Too many indexes
-- CERTO: Right indexes for queries
```

### Caching Strategies (100)

#### DB015: Database Caching
```lua
-- SKILL: Database Caching
-- Nível: Intermediário → Expert
-- Contexto: Cache de banco de dados

-- ESTRATÉGIAS:
-- 1. Application Cache: Redis, Memcached
-- 2. Query Cache: result caching
-- 3. Buffer Pool: in-memory pages
-- 4. Materialized Views: precomputed
-- 5. Read Replicas: distribute reads

-- MELHORIA:
-- ERRADO: No caching
-- CERTO: Multi-level caching strategy
```

---

## 🔧 Database Administration (500)

### Backup & Recovery (150)

#### DB016: Backup & Recovery
```lua
-- SKILL: Backup & Recovery
-- Nível: Intermediário → Expert
-- Contexto: Backup e recuperação

-- ESTRATÉGIAS:
-- 1. Full Backup: complete copy
-- 2. Incremental: changes since last
-- 3. Differential: changes since full
-- 4. Transaction Log: point-in-time
-- 5. Snapshots: storage-level

-- TESTES:
-- Regular restore tests
-- DR drills
-- Corruption detection

-- MELHORIA:
-- ERRADO: Backup sem teste
-- CERTO: Regular restore tests + DR drills
```

### High Availability (150)

#### DB017: High Availability
```lua
-- SKILL: High Availability
-- Nível: Intermediário → Expert
-- Contexto: Alta disponibilidade

-- SOLUÇÕES:
-- 1. Replication: master-slave, master-master
-- 2. Clustering: Galera, Always On
-- 3. Failover: automatic, manual
-- 4. Load Balancing: read replicas
-- 5. Multi-Region: geo-distribution

-- MÉTRICAS:
-- RPO (Recovery Point Objective)
-- RTO (Recovery Time Objective)
-- Uptime SLA

-- MELHORIA:
-- ERRADO: Single point of failure
-- CERTO: HA + failover + monitoring
```

### Monitoring (100)

#### DB018: Database Monitoring
```lua
-- SKILL: Database Monitoring
-- Nível: Intermediário → Expert
-- Contexto: Monitoramento de banco

-- MÉTRICAS:
-- 1. Performance: QPS, latency, throughput
-- 2. Resources: CPU, memory, disk, I/O
-- 3. Replication: lag, status
-- 4. Connections: active, idle, blocked
-- 5. Locks: waiting, deadlocks

-- FERRAMENTAS:
-- pg_stat (PostgreSQL)
-- SHOW STATUS (MySQL)
-- Performance Dashboard (SQL Server)
-- Datadog, New Relic

-- MELHORIA:
-- ERRADO: Reactive monitoring
-- CERTO: Proactive monitoring + alerting
```

### Migration (100)

#### DB019: Database Migration
```lua
-- SKILL: Database Migration
-- Nível: Intermediário → Expert
-- Contexto: Migração de banco

-- PROCESSO:
-- 1. Assessment: schema, data, dependencies
-- 2. Planning: timeline, rollback
-- 3. Schema Migration: tools, versioning
-- 4. Data Migration: ETL, validation
-- 5. Cutover: switch, verify

-- FERRAMENTAS:
-- Flyway, Liquibase (schema)
-- AWS DMS, Azure DMS (data)
-- pg_dump/pg_restore (PostgreSQL)

-- MELHORIA:
-- ERRADO: Big bang migration
-- CERTO: Phased migration with rollback
```

---

## 🔗 Data Integration (400)

### ETL/ELT (200)

#### DB020: ETL/ELT Patterns
```lua
-- SKILL: ETL/ELT Patterns
-- Nível: Intermediário → Expert
-- Contexto: Padrões ETL/ELT

-- PADRÕES:
-- 1. ETL: Extract, Transform, Load
-- 2. ELT: Extract, Load, Transform
-- 3. CDC: Change Data Capture
-- 4. Streaming: real-time integration
-- 5. Batch: scheduled processing

-- FERRAMENTAS:
-- Apache Airflow, dbt
-- Apache Spark, Flink
-- AWS Glue, Azure Data Factory

-- MELHORIA:
-- ERRADO: ETL monolithic
-- CERTO: Modular + incremental ETL
```

### Data Quality (100)

#### DB021: Data Quality Management
```lua
-- SKILL: Data Quality Management
-- Nível: Intermediário → Expert
-- Contexto: Qualidade de dados

-- DIMENSÕES:
-- 1. Accuracy: correct values
-- 2. Completeness: no missing
-- 3. Consistency: no conflicts
-- 4. Timeliness: up to date
-- 5. Validity: format rules
-- 6. Uniqueness: no duplicates

-- FERRAMENTAS:
-- Great Expectations, Deequ
-- Soda, dbt tests

-- MELHORIA:
-- ERRADO: Fix data after problems
-- CERTO: Preventive quality checks
```

### Data Catalog (100)

#### DB022: Data Catalog
```lua
-- SKILL: Data Catalog
-- Nível: Intermediário → Expert
-- Contexto: Catálogo de dados

-- FUNCIONALIDADES:
-- 1. Metadata Management: schemas, lineage
-- 2. Data Discovery: search, browse
-- 3. Data Lineage: upstream/downstream
-- 4. Business Glossary: definitions
-- 5. Data Quality: scores, rules

-- FERRAMENTAS:
-- Apache Atlas, Amundsen
-- DataHub, OpenMetadata
-- Alation, Collibra

-- MELHORIA:
-- ERRADO: No data catalog
-- CERTO: Automated catalog + governance
```

---

## 🕸️ Graph Databases (300)

### Neo4j (150)

#### DB023: Neo4j Mastery
```lua
-- SKILL: Neo4j Mastery
-- Nível: Intermediário → Expert
-- Contexto: Neo4j graph database

-- CONCEITOS:
-- 1. Cypher: graph query language
-- 2. Graph Data Modeling: nodes, relationships
-- 3. Indexes: property, full-text
-- 4. Constraints: uniqueness, existence
-- 5. APOC: procedural procedures

-- CASOS:
-- Social Networks, Fraud Detection
-- Knowledge Graphs, Recommendation
-- Master Data Management

-- MELHORIA:
-- ERRADO: RDBMS for graph problems
-- CERTO: Neo4j for relationship-heavy queries
```

### Graph Algorithms (150)

#### DB024: Graph Algorithms
```lua
-- SKILL: Graph Algorithms
-- Nível: Intermediário → Expert
-- Contexto: Algoritmos de grafo

-- ALGORITMOS:
-- 1. Path Finding: Dijkstra, A*, BFS
-- 2. Centrality: PageRank, Betweenness
-- 3. Community Detection: Louvain, Label Propagation
-- 4. Similarity: Jaccard, Cosine
-- 5. ML: Node2Vec, GraphSAGE

-- BIBLIOTECAS:
-- Graph Data Science (Neo4j)
-- NetworkX (Python)
-- igraph (R/Python)

-- MELHORIA:
-- ERRADO: SQL for graph traversal
-- CERTO: Graph algorithms for relationships
```

---

## 📈 Time Series (200)

### Time Series Databases (100)

#### DB025: Time Series Databases
```lua
-- SKILL: Time Series Databases
-- Nível: Intermediário → Expert
-- Contexto: Bancos de séries temporais

-- OPÇÕES:
-- 1. InfluxDB: open source
-- 2. TimescaleDB: PostgreSQL extension
-- 3. Prometheus: monitoring
-- 4. QuestDB: high performance
-- 5. ClickHouse: analytics

-- CONCEITOS:
-- Downsampling, Retention Policies
-- Continuous Queries
-- Time-based Partitioning

-- MELHORIA:
-- ERRADO: RDBMS for time series
-- CERTO: Specialized TSDB for metrics
```

### Time Series Analysis (100)

#### DB026: Time Series Analysis
```lua
-- SKILL: Time Series Analysis
-- Nível: Intermediário → Expert
-- Contexto: Análise de séries temporais

-- MÉTODAS:
-- 1. Decomposition: trend, seasonal, residual
-- 2. Smoothing: MA, EMA, Holt-Winters
-- 3. Forecasting: ARIMA, Prophet, LSTM
-- 4. Anomaly Detection: Z-score, Isolation Forest
-- 5. Correlation: cross-correlation, Granger

-- FERRAMENTAS:
-- statsmodels, Prophet (Python)
-- InfluxDB, Grafana (visualization)

-- MELHORIA:
-- ERRADO: Naive forecasting
-- CERTO: Proper decomposition + validation
```

---

## 🆕 NewSQL (200)

### CockroachDB (100)

#### DB027: CockroachDB
```lua
-- SKILL: CockroachDB
-- Nível: Intermediário → Expert
-- Contexto: Distributed SQL

-- CONCEITOS:
-- 1. Distributed SQL: ACID + scale
-- 2. Multi-Region: locality, follower reads
-- 3. Serializable isolation: strongest guarantee
-- 4. Automatic sharding: range-based
-- 5. Geo-partitioning: data locality

-- MELHORIA:
-- ERRADO: Single-node thinking
-- CERTO: Distributed SQL + geo-partitioning
```

### TiDB (100)

#### DB028: TiDB
```lua
-- SKILL: TiDB
-- Nível: Intermediário → Expert
-- Contexto: HTAP database

-- CONCEITOS:
-- 1. HTAP: OLTP + OLAP
-- 2. TiKV: distributed KV store
-- 3. TiFlash: columnar analytics
-- 4. Placement Rules: resource control
-- 5. TiCDC: change data capture

-- MELHORIA:
-- ERRADO: Separate OLTP/OLAP systems
-- CERTO: HTAP for unified workloads
```

---

## 🔐 Database Security (200)

### Access Control (100)

#### DB029: Database Security
```lua
-- SKILL: Database Security
-- Nível: Avançado → Expert
-- Contexto: Segurança de banco

-- CONCEITOS:
-- 1. Authentication: passwords, Kerberos
-- 2. Authorization: RBAC, GRANT/REVOKE
-- 3. Encryption: at-rest, in-transit
-- 4. Auditing: activity logging
-- 5. Masking: data obfuscation

-- COMPLIANCE:
-- GDPR, HIPAA, PCI DSS
-- SOC 2, ISO 27001

-- MELHORIA:
-- ERRADO: Default security
-- CERTO: Defense-in-depth security
```

### Data Masking (100)

#### DB030: Data Masking
```lua
-- SKILL: Data Masking
-- Nível: Intermediário → Expert
-- Contexto: Mascaramento de dados

-- TIPOS:
-- 1. Static: pre-masked copies
-- 2. Dynamic: real-time masking
-- 3. Tokenization: reversible
-- 4. Anonymization: irreversible

-- TÉCNICAS:
-- Full masking, Partial masking
-- Nullifying, Shuffling
-- Redaction, Blur

-- MELHORIA:
-- ERRADO: Production data in dev
-- CERTO: Masked data for non-prod
```

---

*Database & Data Skills v1.0 - Setembro 2026*