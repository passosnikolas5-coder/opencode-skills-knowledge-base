# 🔍 Qdrant - Banco de Dados Vetorial de Alta Performance

**Fonte:** https://github.com/qdrant/qdrant (25k+ stars)
**Descrição:** Qdrant é um banco de dados vetorial open-source de alta performance, projetado para aplicações de IA que precisam de busca semântica, recomendação e análise de相似idade. Escrito em Rust, oferece performance excepcional com suporte a filtragem avançada, quantização e deploy distribuído.

---

## 1. Gerenciamento de Coleções

A coleção é a unidade principal de organização no Qdrant. Cada coleção contém vetores com payloads (metadados) associados.

```python
from qdrant_client import QdrantClient
from qdrant_client.models import (
    Distance, VectorParams, PointStruct, 
    PayloadSchemaType, TokenizerType
)

client = QdrantClient("localhost", port=6333)

# Criar coleção com configuração otimizada
client.create_collection(
    collection_name="documents",
    vectors_config=VectorParams(
        size=1536,  # Dimensão do modelo de embedding
        distance=Distance.COSINE,
        on_disk=True,  # Vetores em disco para economizar RAM
    ),
    shard_number=3,  # Distribuir em 3 shards
    replication_factor=2,  # Replicação para alta disponibilidade
    on_disk_payload=True,  # Payload em disco
)

# Verificar se coleção existe
collections = client.get_collections()
print([c.name for c in collections.collections])
```

---

## 2. Operações de Vetores (Upsert, Search, Delete)

Operações CRUD fundamentais para gerenciar vetores e metadados.

```python
# Upsert - Inserir ou atualizar vetores
client.upsert(
    collection_name="documents",
    points=[
        PointStruct(
            id=1,
            vector=[0.1, 0.2, 0.3, 0.4, 0.5] * 307,  # 1536 dims
            payload={
                "title": "Documentação Qdrant",
                "category": "tech",
                "language": "pt-br",
                "tags": ["vector", "database", "ai"]
            }
        ),
        PointStruct(
            id=2,
            vector=[0.5, 0.4, 0.3, 0.2, 0.1] * 307,
            payload={
                "title": "Guia de Embeddings",
                "category": "tutorial",
                "language": "pt-br",
                "tags": ["embeddings", "nlp"]
            }
        ),
    ]
)

# Busca por similaridade
results = client.search(
    collection_name="documents",
    query_vector=[0.1, 0.2, 0.3, 0.4, 0.5] * 307,
    limit=5,
    with_payload=True,
    with_vectors=False,
)

for result in results:
    print(f"ID: {result.id}, Score: {result.score:.4f}")
    print(f"  Título: {result.payload['title']}")
    print(f"  Categoria: {result.payload['category']}")

# Deletar vetores por IDs
client.delete(
    collection_name="documents",
    points_selector=[1, 2, 3]
)

# Deletar por filtro
from qdrant_client.models import Filter, FieldCondition, MatchValue

client.delete(
    collection_name="documents",
    points_selector=Filter(
        must=[
            FieldCondition(
                key="category",
                match=MatchValue(value="deprecated")
            )
        ]
    )
)
```

---

## 3. Filtragem de Payload (Metadados)

Filtragem avançada com condições complexas para refinar buscas.

```python
from qdrant_client.models import (
    Filter, FieldCondition, MatchValue, MatchAny,
    Range, GeoRadius, GeoPoint, ValuesCount
)

# Filtro com múltiplas condições
results = client.search(
    collection_name="documents",
    query_vector=[0.1] * 1536,
    query_filter=Filter(
        must=[
            FieldCondition(key="category", match=MatchValue(value="tech")),
            FieldCondition(key="language", match=MatchValue(value="pt-br")),
        ],
        must_not=[
            FieldCondition(key="deprecated", match=MatchValue(value=True)),
        ],
        should=[
            FieldCondition(key="priority", range=Range(gte=5)),
        ],
    ),
    limit=10,
)

# Filtro com arrays
results = client.search(
    collection_name="documents",
    query_vector=[0.1] * 1536,
    query_filter=Filter(
        must=[
            FieldCondition(
                key="tags",
                match=MatchAny(any=["vector", "ai"])
            ),
            FieldCondition(
                key="tags",
                match=MatchValue(value="database")
            ),
        ]
    ),
    limit=10,
)

# Filtro geográfico
results = client.search(
    collection_name="locations",
    query_vector=[0.1] * 1536,
    query_filter=Filter(
        must=[
            GeoRadius(
                center=GeoPoint(lat=-23.5505, lon=-46.6333),  # São Paulo
                radius=50000  # 50km
            )
        ]
    ),
    limit=10,
)
```

---

## 4. Named Vectors (Suporte Multi-Vetor)

Cada ponto pode conter múltiplos vetores, útil para modelos diferentes.

```python
from qdrant_client.models import VectorParams

# Criar coleção com vetores nomeados
client.create_collection(
    collection_name="multimodal",
    vectors_config={
        "title": VectorParams(size=768, distance=Distance.COSINE),
        "description": VectorParams(size=768, distance=Distance.COSINE),
        "image": VectorParams(size=512, distance=Distance.COSINE),
    },
)

# Upsert com múltiplos vetores
client.upsert(
    collection_name="multimodal",
    points=[
        PointStruct(
            id=1,
            vector={
                "title": [0.1] * 768,
                "description": [0.2] * 768,
                "image": [0.3] * 512,
            },
            payload={"text": "Documento exemplo", "type": "hybrid"}
        )
    ]
)

# Buscar usando vetores específicos
results = client.search(
    collection_name="multimodal",
    query_vector=("title", [0.1] * 768),
    limit=5,
)

# Buscar usando fusão de vetores (fusion)
from qdrant_client.models import Fusion

results = client.search(
    collection_name="multimodal",
    prefetch=[
        Prefetch(query=[0.1] * 768, using="title"),
        Prefetch(query=[0.2] * 768, using="description"),
    ],
    query=Fusion.Fusion,
    limit=5,
)
```

---

## 5. Vetores Esparsos (Sparse Vectors)

Vetores esparsos são ideiais para BM25, SPLADE e modelos de embedding esparsos.

```python
from qdrant_client.models import SparseVectorParams, SparseVector

# Criar coleção com vetores esparsos
client.create_collection(
    collection_name="hybrid_search",
    vectors_config={
        "dense": VectorParams(size=1536, distance=Distance.COSINE),
    },
    sparse_vectors_config={
        "sparse": SparseVectorParams(
            modifier=Modifier.IDF,  # IDF weighting
            on_disk=True,
        ),
    },
)

# Upsert com vetores esparsos
client.upsert(
    collection_name="hybrid_search",
    points=[
        PointStruct(
            id=1,
            vector={
                "dense": [0.1] * 1536,
                "sparse": SparseVector(
                    indices=[10, 25, 100, 500],
                    values=[0.5, 0.3, 0.8, 0.2]
                ),
            },
            payload={"text": "Qdrant é rápido"}
        )
    ]
)

# Busca híbrida (dense + sparse)
results = client.search(
    collection_name="hybrid_search",
    prefetch=[
        Prefetch(query=[0.1] * 1536, using="dense", limit=20),
        Prefetch(query=SparseVector(indices=[10, 25], values=[0.5, 0.3]), 
                 using="sparse", limit=20),
    ],
    query=Fusion.RRF,  # Reciprocal Rank Fusion
    limit=10,
)
```

---

## 6. Quantização de Produto (Product Quantization)

Reduz o tamanho dos vetores mantendo qualidade aceitável para buscas.

```python
from qdrant_client.models import (
    ProductQuantization, ProductQuantizationConfig,
    ScalarQuantization, ScalarQuantizationConfig,
    BinaryQuantization, BinaryQuantizationConfig,
)

# Product Quantization - melhor equilíbrio压缩/qualidade
client.create_collection(
    collection_name="pq_optimized",
    vectors_config=VectorParams(
        size=1536,
        distance=Distance.COSINE,
    ),
    quantization_config=ProductQuantization(
        product=ProductQuantizationConfig(
            compression_ratio=16,  # 16x compressão
            always_ram=True,  # Manter sempre em RAM
        )
    ),
)

# Scalar Quantization - mais rápido, menos compressão
client.create_collection(
    collection_name="sq_optimized",
    vectors_config=VectorParams(size=1536, distance=Distance.COSINE),
    quantization_config=ScalarQuantization(
        scalar=ScalarQuantizationConfig(
            type="int8",
            quantile=0.99,
            always_ram=True,
        )
    ),
)

# Binary Quantization - máxima compressão
client.create_collection(
    collection_name="bq_optimized",
    vectors_config=VectorParams(size=1536, distance=Distance.COSINE),
    quantization_config=BinaryQuantization(
        binary=BinaryQuantizationConfig(
            always_ram=True,
        )
    ),
)

# Busca com quantização + re-ranking
results = client.search(
    collection_name="pq_optimized",
    query_vector=[0.1] * 1536,
    limit=10,
    quantization=QuantizationSearchParams(
        rescore=True,  # Re-scoring com vetores originais
        rescore_accuracy_threshold=0.5,
    ),
)
```

---

## 7. Métricas de Distância

Escolha da métrica correta impacta diretamente a qualidade dos resultados.

```python
# Cosine - recomendado para embeddings normalizados
# Mede a similaridade angular entre vetores
client.create_collection(
    collection_name="cosine_collection",
    vectors_config=VectorParams(size=1536, distance=Distance.COSINE),
)

# Dot Product - para vetores não normalizados
# Ideal quando magnitude importa
client.create_collection(
    collection_name="dot_collection",
    vectors_config=VectorParams(size=1536, distance=Distance.DOT),
)

# Euclid (L2) - distância euclidiana
# Boa para clusters bem definidos
client.create_collection(
    collection_name="euclid_collection",
    vectors_config=VectorParams(size=1536, distance=Distance.EUCLID),
)

# Manhattan (L1) - soma das diferenças absolutas
# Mais robusta a outliers
client.create_collection(
    collection_name="manhattan_collection",
    vectors_config=VectorParams(size=1536, distance=Distance.MANHATTAN),
)
```

---

## 8. Multi-Tenancy

Isolamento de dados por tenant usando payload filtering ou coleções separadas.

```python
# Estratégia 1: Coleção por tenant (mais isolamento)
def create_tenant_collection(tenant_id: str):
    client.create_collection(
        collection_name=f"tenant_{tenant_id}",
        vectors_config=VectorParams(size=1536, distance=Distance.COSINE),
    )

# Estratégia 2: Filtragem por tenant (mais eficiente)
client.create_payload_index(
    collection_name="shared_collection",
    field_name="tenant_id",
    field_schema=PayloadSchemaType.KEYWORD,
)

def search_for_tenant(tenant_id: str, query_vector: list):
    return client.search(
        collection_name="shared_collection",
        query_vector=query_vector,
        query_filter=Filter(
            must=[
                FieldCondition(
                    key="tenant_id",
                    match=MatchValue(value=tenant_id)
                )
            ]
        ),
        limit=10,
    )

# Estratégia 3: Named vectors por tenant
client.create_collection(
    collection_name="multi_tenant_vectors",
    vectors_config={
        f"tenant_{tid}": VectorParams(size=768, distance=Distance.COSINE)
        for tid in ["org_1", "org_2", "org_3"]
    },
)
```

---

## 9. Deploy Distribuído

Qdrant suporta clustering para escala horizontal.

```yaml
# docker-compose-distributed.yml
version: '3.8'
services:
  qdrant_node_1:
    image: qdrant/qdrant:v1.10.0
    ports:
      - "6333:6333"
      - "6334:6334"
    volumes:
      - qdrant_1:/qdrant/storage
    environment:
      QDRANT__CLUSTER__ENABLED: "true"
      QDRANT__CLUSTER__CONSENSUS_PORT: 6335

  qdrant_node_2:
    image: qdrant/qdrant:v1.10.0
    ports:
      - "6336:6333"
      - "6337:6334"
    volumes:
      - qdrant_2:/qdrant/storage
    environment:
      QDRANT__CLUSTER__ENABLED: "true"

  qdrant_node_3:
    image: qdrant/qdrant:v1.10.0
    ports:
      - "6339:6333"
      - "6340:6334"
    volumes:
      - qdrant_3:/qdrant/storage
    environment:
      QDRANT__CLUSTER__ENABLED: "true"

volumes:
  qdrant_1:
  qdrant_2:
  qdrant_3:
```

```python
# Conectar ao cluster
from qdrant_client import QdrantClient

client = QdrantClient(
    host="qdrant_node_1",
    port=6333,
    prefer_grpc=True,  # gRPC para melhor performance
)

# Criar coleção distribuída
client.create_collection(
    collection_name="distributed_collection",
    vectors_config=VectorParams(size=1536, distance=Distance.COSINE),
    shard_number=3,
    replication_factor=2,
    write_consistency_factor=2,  # Escrever em 2 réplicas antes de confirmar
)

# Mover coleção entre nós
client.move_shard(
    collection_name="distributed_collection",
    shard_id=0,
    from_peer_id=1,
    to_peer_id=2,
)
```

---

## 10. Snapshots e Backup

Backup completo do estado do banco de dados.

```python
# Criar snapshot
snapshot_info = client.create_snapshot(
    collection_name="documents"
)
print(f"Snapshot criado: {snapshot_info.name}")

# Listar snapshots
snapshots = client.list_snapshots(collection_name="documents")
for snap in snapshots:
    print(f"  {snap.name} - {snap.size} bytes")

# Restaurar snapshot
client.restore_snapshot(
    snapshot_name="documents-2024-01-15.snapshot",
    collection_name="documents_restored",
)

# Backup automático com cron
import subprocess

backup_script = """
#!/bin/bash
DATE=$(date +%Y-%m-%d)
curl -X POST "http://localhost:6333/collections/documents/snapshots" \
  -o /backups/snapshot_$DATE.tar
find /backups -mtime +7 -delete
"""
```

---

## 11. API gRPC de Alta Performance

gRPC oferece 10x mais performance que REST para operações em lote.

```python
import grpc
from qdrant_client.grpc import QdrantStub

# Conectar via gRPC
channel = grpc.insecure_channel("localhost:6334")
stub = QdrantStub(channel)

# Upsert em lote via gRPC
from qdrant_client.grpc import PointsStub, UpsertPoints

points = UpsertPoints(
    collection_name="documents",
    points=[
        {
            "id": 1,
            "vector": [0.1] * 1536,
            "payload": {"title": "Doc 1"}
        }
    ]
)
response = stub.Upsert(points)

# Search via gRPC
search_result = stub.Search(
    SearchPoints(
        collection_name="documents",
        vector=[0.1] * 1536,
        limit=5,
        with_payload=True,
    )
)
```

---

## 12. Integração com LangChain

```python
from langchain_community.vectorstores import Qdrant
from langchain_openai import OpenAIEmbeddings
from langchain.text_splitter import RecursiveCharacterTextSplitter

# Embeddings
embeddings = OpenAIEmbeddings(model="text-embedding-3-small")

# Criar vector store
vectorstore = Qdrant.from_documents(
    documents=docs,
    embedding=embeddings,
    url="http://localhost:6333",
    collection_name="langchain_docs",
)

# Busca com filtros
results = vectorstore.similarity_search(
    "como usar Qdrant?",
    filter={"must": [{"key": "category", "match": {"value": "tutorial"}}]},
    k=5,
)

# RAG Chain
from langchain.chains import RetrievalQA

qa_chain = RetrievalQA.from_chain_type(
    llm=ChatOpenAI(model="gpt-4"),
    retriever=vectorstore.as_retriever(
        search_type="mmr",  # Maximal Marginal Relevance
        search_kwargs={"k": 5, "fetch_k": 20}
    ),
)
```

---

## 13. Integração com LlamaIndex

```python
from llama_index.vector_stores.qdrant import QdrantVectorStore
from llama_index.core import VectorStoreIndex, StorageContext

# Criar vector store
vector_store = QdrantVectorStore(
    url="http://localhost:6333",
    collection_name="llama_index_docs",
)

# Indexar documentos
storage_context = StorageContext.from_defaults(vector_store=vector_store)
index = VectorStoreIndex.from_documents(
    documents,
    storage_context=storage_context,
)

# Consultar
query_engine = index.as_query_engine(
    similarity_top_k=5,
    vector_store_kwargs={"filters": {"category": "tech"}},
)
response = query_engine.query("Explique embeddings vetoriais")
```

---

## 14. Batch Import e Performance

Técnicas para importação massiva de dados com performance.

```python
import numpy as np
from tqdm import tqdm

# Gerar dados de exemplo
NUM_POINTS = 1_000_000
BATCH_SIZE = 1000

# Batch upsert otimizado
for i in tqdm(range(0, NUM_POINTS, BATCH_SIZE)):
    batch = [
        PointStruct(
            id=i + j,
            vector=np.random.randn(1536).tolist(),
            payload={
                "batch": i // BATCH_SIZE,
                "timestamp": "2024-01-15T10:00:00Z"
            }
        )
        for j in range(min(BATCH_SIZE, NUM_POINTS - i))
    ]
    client.upsert(
        collection_name="large_collection",
        points=batch,
        parallel=4,  # Paralelizar operações
    )

# Configurar otimizações de performance
client.update_collection(
    collection_name="large_collection",
    optimizer_config={
        "deleted_threshold": 0.2,  # Threshold para cleanup
        "vacuum_min_vector_number": 1000,
        "max_segment_size": 20000,
        "memmap_threshold": 20000,
    },
)
```

---

## 15. Filtragem com Condições Complexas

Combinações avançadas de filtros para cenários reais.

```python
# Busca híbrida com filtros complexos
results = client.query_points(
    collection_name="products",
    query=[0.1] * 1536,
    query_filter=Filter(
        must=[
            # Condições AND
            FieldCondition(key="in_stock", match=MatchValue(value=True)),
            FieldCondition(key="category", match=MatchValue(value="electronics")),
        ],
        should=[
            # Condições OR (pelo menos uma deve ser verdade)
            FieldCondition(key="price", range=Range(lte=500)),
            FieldCondition(key="is_sale", match=MatchValue(value=True)),
        ],
        must_not=[
            FieldCondition(key="discontinued", match=MatchValue(value=True)),
        ],
    ),
    limit=10,
    score_threshold=0.7,  # Filtrar por score mínimo
)

# Usando $any (match em array)
results = client.query_points(
    collection_name="articles",
    query=[0.1] * 1536,
    query_filter=Filter(
        must=[
            FieldCondition(
                key="tags",
                match=MatchAny(any=["ai", "ml", "data-science"])
            ),
            FieldCondition(
                key="read_time",
                range=Range(lte=10)  # Até 10 minutos de leitura
            ),
        ]
    ),
    limit=10,
)
```

---

## 16. MELHORIA: Erros Comuns vs Práticas Corretas

### ❌ ERRADO - Criar coleção sem configuração adequada
```python
# Coleção padrão sem otimizações
client.create_collection("my_collection")
```

### ✅ CORRETO - Coleção otimizada para produção
```python
client.create_collection(
    collection_name="my_collection",
    vectors_config=VectorParams(
        size=1536,
        distance=Distance.COSINE,
        on_disk=True,  # Economizar RAM
    ),
    quantization_config=ProductQuantization(
        product=ProductQuantizationConfig(
            compression_ratio=16,
            always_ram=True,
        )
    ),
    on_disk_payload=True,
    shard_number=3,
    replication_factor=2,
    optimizers_config=OptimizersConfig(
        indexing_threshold=20000,
    ),
)
```

### ❌ ERRADO - Buscar sem limitar e sem filtro
```python
# Pode retornar milhões de resultados
results = client.search("collection", query_vector=[0.1]*1536)
```

### ✅ CORRETO - Busca paginada e filtrada
```python
results = client.query_points(
    collection_name="collection",
    query=[0.1]*1536,
    limit=10,
    query_filter=Filter(
        must=[FieldCondition(key="active", match=MatchValue(value=True))]
    ),
    score_threshold=0.5,
    with_payload=PayloadSelector(
        include=["title", "category"]  # Só campos necessários
    ),
)
```

### ❌ ERRADO - Conectar sem retry/timeout
```python
client = QdrantClient("localhost", port=6333)
```

### ✅ CORRETO - Conexão resiliente
```python
from qdrant_client import QdrantClient
import httpx

client = QdrantClient(
    host="localhost",
    port=6333,
    timeout=30,  # Timeout de 30s
    retries=3,   # 3 tentativas
    api_key="your-api-key",  # Autenticação
)
```

### ❌ ERRADO - Deletar coleção inteira sem backup
```python
client.delete_collection("important_collection")
```

### ✅ CORRETO - Backup antes de deletar
```python
# Criar snapshot primeiro
client.create_snapshot(collection_name="important_collection")

# Depois deletar
client.delete_collection("important_collection")
```

### ❌ ERRADO - Usar search em vez de query_points
```python
# API antiga (deprecated)
results = client.search("collection", [0.1]*1536)
```

### ✅ CORRETO - Usar query_points (API atual)
```python
from qdrant_client.models import Query

results = client.query_points(
    collection_name="collection",
    query=[0.1]*1536,
    limit=10,
)
```

---

## 17. Monitoreamento e Métricas

```python
# Verificar tamanho da coleção
collection_info = client.get_collection("documents")
print(f"Pontos: {collection_info.points_count}")
print(f"Vetores: {collection_info.vectors_count}")
print(f"Segmentos: {collection_info.segments_count")
print(f"RAM: {collection_info.ram_usage_bytes / 1024 / 1024:.2f} MB")
print(f"Disco: {collection_info.disk_usage_bytes / 1024 / 1024:.2f} MB")

# Métricas via Prometheus
# Endpoint: http://localhost:6333/metrics

# Health check
client.http.health
```

---

## 18. Segurança e Autenticação

```python
# Docker com autenticação
# docker-compose.yml
# environment:
#   QDRANT__SERVICE__API_KEY: "your-secret-key"

client = QdrantClient(
    host="localhost",
    port=6333,
    api_key="your-secret-key",
)

# TLS/SSL
client = QdrantClient(
    host="your-qdrant-url",
    port=443,
    https=True,
    api_key="your-api-key",
)
```

---

## 19. Configuração YAML Avançada

```yaml
# config/production.yml
storage:
  storage_path: /qdrant/storage
  snapshots_path: /qdrant/snapshots
  
  storage_optimizers:
    deleted_threshold: 0.2
    vacuum_min_vector_number: 1000
    max_segment_size: 20000
    memmap_threshold: 20000
    indexing_threshold: 20000
    
  performance:
    max_optimization_threads: 0
    
service:
  grpc_port: 6334
  http_port: 6333
  api_key: ${QDRANT_API_KEY}
  
cluster:
  enabled: false
  p2p:
    port: 6335
  consensus:
    tick_period_ms: 100
```

---

## 20. Checklist de Boas Práticas

- ✅ Use `on_disk=True` para coleções grandes (>1M vetores)
- ✅ Configure quantização (PQ/SQ/BQ) para reduzir custo de memória
- ✅ Use filtros de payload para multi-tenancy em vez de coleções separadas
- ✅ Implemente batch upsert com paralelismo para importações massivas
- ✅ Configure replicação (fator >= 2) para alta disponibilidade
- ✅ Use gRPC em vez de REST para operações em lote
- ✅ Monitore métricas de RAM e disco regularmente
- ✅ Crie snapshots antes de operações de manutenção
- ✅ Use `score_threshold` para filtrar resultados de baixa qualidade
- ✅ Prefira `query_points` sobre `search` (API mais recente)
