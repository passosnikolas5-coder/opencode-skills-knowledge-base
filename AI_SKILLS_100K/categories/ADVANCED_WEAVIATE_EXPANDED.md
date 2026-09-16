# 🌐 Weaviate - Banco de Dados Vetorial com IA Integrada

**Fonte:** https://github.com/weaviate/weaviate (15k+ stars)
**Descrição:** Weaviate é um banco de dados vetorial open-source com ML integrado nativamente. Oferece busca vetorial, híbrida e generativa (RAG) com suporte a múltiplos módulos de vetORIZação, multi-tenancy e GraphQL API. Ideal para aplicações que precisam de busca semântica com pipelines completos.

---

## 1. Definição de Schema

Schema define a estrutura de classes, propriedades e vetORIZadores no Weaviate.

```python
import weaviate
from weaviate.classes.config import (
    Configure, Property, DataType, VectorDistances,
    Multi2VecOpenAI, Text2VecOpenAI
)

client = weaviate.connect_to_local()

# Criar classe com vetORIZação automática
client.collections.create(
    name="Document",
    description="Documentos para busca semântica",
    vectorizer_config=Configure.Vectorizer.text2vec_openai(
        model="text-embedding-3-small",
        vectorize_class_name=False,
    ),
    properties=[
        Property(
            name="title",
            dataType=DataType.TEXT,
            description="Título do documento",
            vectorize_config=Configure.Vectorizer.text2vec_openai(
                vectorize_property_name=False,
            ),
        ),
        Property(
            name="content",
            dataType=DataType.TEXT,
            description="Conteúdo completo",
        ),
        Property(
            name="category",
            dataType=DataType.TEXT,
            skip_vectorization=True,  # Não vetorizar
        ),
        Property(
            name="published_date",
            dataType=DataType.DATE,
        ),
        Property(
            name="tags",
            dataType=DataType.TEXT_ARRAY,
        ),
        Property(
            name="view_count",
            dataType=DataType.INT,
        ),
    ],
    vector_index_config=Configure.VectorIndex.hnsw(
        distance=VectorDistances.COSINE,
        ef_construction=128,
        max_connections=64,
    ),
)

# Criar classe para imagens
client.collections.create(
    name="Product",
    vectorizer_config=Configure.Vectorizer.multi2vec_openai(
        image_fields=["image"],
        text_fields=["name", "description"],
        model="text-embedding-3-small",
        image_model="clip-vit-base-patch32",
    ),
    properties=[
        Property(name="name", dataType=DataType.TEXT),
        Property(name="description", dataType=DataType.TEXT),
        Property(name="image", dataType=DataType.BLOB),
        Property(name="price", dataType=DataType.NUMBER),
    ],
)

print("Classes criadas:", client.collections.list_all())
```

---

## 2. Operações CRUD

Create, Read, Update e Delete com suporte a batch e vetORIZação automática.

```python
import weaviate
from datetime import datetime, timezone

client = weaviate.connect_to_local()
docs = client.collections.get("Document")

# Create - Inserir documento único
docs.data.insert({
    "title": "Introdução ao Weaviate",
    "content": "Weaviate é um banco de dados vetorial...",
    "category": "tutorial",
    "published_date": datetime.now(timezone.utc).isoformat(),
    "tags": ["weaviate", "vector", "tutorial"],
    "view_count": 0,
})

# Create - Inserir múltiplos (batch)
with docs.batch.dynamic() as batch:
    for i in range(100):
        batch.add_object({
            "title": f"Documento {i}",
            "content": f"Conteúdo do documento {i}...",
            "category": "auto-generated",
            "tags": ["batch", "generated"],
        })

# Read - Buscar por ID
doc = docs.query.get_object_by_id("doc-uuid-1234")
print(doc.properties["title"])

# Read - Buscar por propriedade
docs = docs.query.get(
    where=weaviate.classes.query.Filter.by_property("category").equal("tutorial"),
    limit=10,
)

# Update - Atualizar propriedades
docs.data.update(
    uuid="doc-uuid-1234",
    properties={
        "title": "Título Atualizado",
        "view_count": 100,
    }
)

# Update - Atualizar vetores (re-vetorizar)
docs.data.update(
    uuid="doc-uuid-1234",
    properties={"content": "Novo conteúdo para re-vetorizar"},
    vector=[0.1] * 1536,  # Vetor manual
)

# Delete - Deletar por ID
docs.data.delete_by_id("doc-uuid-1234")

# Delete - Deletar por filtro
docs.data.delete_many(
    where=weaviate.classes.query.Filter.by_property("category").equal("deprecated")
)

# Delete - Deletar todos
docs.data.delete_many()
```

---

## 3. Busca Vetorial

Diferentes modos de busca vetorial no Weaviate.

```python
import weaviate
from weaviate.classes.query import NearText, NearVector, NearImage

client = weaviate.connect_to_local()
docs = client.collections.get("Document")

# Near Text - Busca por texto (usa vetORIZador automático)
results = docs.query.near_text(
    query="como usar bancos de dados vetoriais",
    limit=5,
    distance=0.7,  # Threshold de distância
    return_metadata=weaviate.classes.query.MetadataQuery(distance=True),
)

for doc in objects.objects:
    print(f"Title: {doc.properties['title']}")
    print(f"Distance: {doc.metadata.distance:.4f}")

# Near Vector - Busca por vetor manual
results = docs.query.near_vector(
    near_vector=[0.1] * 1536,
    limit=5,
    distance=0.5,
)

# Near Image - Busca por imagem
results = client.collections.get("Product").query.near_image(
    near_image="path/to/image.jpg",  # ou base64
    limit=5,
    target_vector="image",  # Nome do vetor-alvo
)

# Busca por texto com peso
results = docs.query.near_text(
    query=["vetor", "banco de dados", "IA"],
    limit=5,
    certainty=0.7,  # Threshold de certeza
)

# Busca com filtros
results = docs.query.near_text(
    query="machine learning",
    limit=10,
    target_vector="default",
    filters=weaviate.classes.query.Filter.by_property("category").equal("tech"),
    return_metadata=weaviate.classes.query.MetadataQuery(
        distance=True,
        certainty=True,
        score=True,
    ),
)
```

---

## 4. Busca Híbrida (BM25 + Vetorial)

Combinação de busca lexical (BM25) e semântica (vetorial).

```python
import weaviate
from weaviate.classes.query import HybridSearch, Alpha

client = weaviate.connect_to_local()
docs = client.collections.get("Document")

# Busca híbrida padrão (50% BM25 + 50% vetorial)
results = docs.query.hybrid(
    query="banco de dados vetorial",
    limit=10,
    alpha=0.5,  # 0=puro BM25, 1=puro vetorial
    return_metadata=weaviate.classes.query.MetadataQuery(
        score=True,
        explain_score=True,
    ),
)

# BM25 puro (alpha=0)
results = docs.query.hybrid(
    query="banco de dados",
    alpha=0.0,  # 100% BM25
    limit=10,
)

# Vetorial puro (alpha=1)
results = docs.query.hybrid(
    query="similaridade semântica",
    alpha=1.0,  # 100% vetorial
    limit=10,
)

# Busca híbrida com filtros
results = docs.query.hybrid(
    query="inteligência artificial",
    alpha=0.7,  # Mais vetorial
    limit=10,
    filters=(
        weaviate.classes.query.Filter.by_property("category").equal("tech")
        & weaviate.classes.query.Filter.by_property("view_count").greater_than(100)
    ),
    target_vector="title",  # Vetor específico
    return_metadata=weaviate.classes.query.MetadataQuery(score=True),
)

# Hybrid Search com fusion
results = docs.query.hybrid(
    query="embeddings e similaridade",
    alpha=0.6,
    limit=10,
    fusion_type="ranked",  # ou "relativeScore"
)
```

---

## 5. Busca Generativa (RAG)

Busca vetorial + geração de resposta com LLM integrado.

```python
import weaviate
from weaviate.classes.query import Generate

client = weaviate.connect_to_local()
docs = client.collections.get("Document")

# RAG simples
results = docs.generate.near_text(
    query="O que é embedding vetorial?",
    single_prompt="""
    Responda a pergunta do usuário usando o contexto abaixo:
    
    Contexto: {content}
    Título: {title}
    
    Pergunta: {query}
    
    Responda em português de forma clara e concisa.
    """,
    limit=3,
)

# RAG com múltiplos prompts (grouped)
results = docs.generate.near_text(
    query="Explique o que são bancos de dados vetoriais",
    grouped_task="""
    Com base nos documentos encontrados, crie um resumo abrangente
    sobre bancos de dados vetoriais. Inclua:
    1. Definição
    2. Casos de uso
    3. Principais características
    4. Quando usar
    
    Documentos:
    {content}
    """,
    limit=5,
)

# RAG com filtros
results = docs.generate.near_text(
    query="Como configurar Weaviate em produção?",
    single_prompt="Responda: {content}",
    limit=3,
    filters=weaviate.classes.query.Filter.by_property("category").equal("production"),
)

# Extrair resposta gerada
for result in results.objects:
    print(f"Doc: {result.properties['title']}")
    print(f"Resposta: {result.generated}")
```

---

## 6. Multi-Tenancy

Isolamento completo de dados por tenant.

```python
import weaviate
from weaviate.classes.tenants import Tenant, TenantActivityStatus

client = weaviate.connect_to_local()

# Criar classe com multi-tenancy habilitado
client.collections.create(
    name="MultiTenantDoc",
    multi_tenancy_config=Configure.MultiTenancy(
        enabled=True,
        auto_tenant_creation=True,
    ),
    vectorizer_config=Configure.Vectorizer.text2vec_openai(
        model="text-embedding-3-small",
    ),
    properties=[
        Property(name="content", dataType=DataType.TEXT),
        Property(name="tenant_id", dataType=DataType.TEXT),
    ],
)

# Criar tenants
docs = client.collections.get("MultiTenantDoc")

docs.tenants.create(
    Tenant(name="org_1", activity_status=TenantActivityStatus.ACTIVE),
    Tenant(name="org_2", activity_status=TenantActivityStatus.ACTIVE),
    Tenant(name="org_3", activity_status=TenantActivityStatus.HOT),
)

# Inserir dados com tenant específico
docs.data.insert(
    {"content": "Documento da org 1"},
    tenant="org_1",
)

# Buscar por tenant específico
results = docs.query.near_text(
    query="documento importante",
    limit=5,
    tenant="org_1",
)

# Buscar em múltiplos tenants
results = docs.tenants.get_by_names(
    ["org_1", "org_2"]
).query.near_text(
    query="documento importante",
    limit=10,
)

# Gerenciar tenants
docs.tenants.update(
    Tenant(name="org_2", activity_status=TenantActivityStatus.INACTIVE)
)

# Deletar tenant
docs.tenants.remove("org_3")
```

---

## 7. Módulos e VetORIZadores

Weaviate oferece módulos para diferentes tipos de embedding.

```python
import weaviate
from weaviate.classes.config import Configure

client = weaviate.connect_to_local()

# Text2Vec - OpenAI
client.collections.create(
    name="DocOpenAI",
    vectorizer_config=Configure.Vectorizer.text2vec_openai(
        model="text-embedding-3-small",
        dimensions=1536,
    ),
)

# Text2Vec - Cohere
client.collections.create(
    name="DocCohere",
    vectorizer_config=Configure.Vectorizer.text2vec_cohere(
        model="embed-multilingual-v3.0",
    ),
)

# Text2Vec - HuggingFace
client.collections.create(
    name="DocHuggingFace",
    vectorizer_config=Configure.Vectorizer.text2vec_huggingface(
        model="BAAI/bge-small-en-v1.5",
    ),
)

# Text2Vec - Transformers (local)
client.collections.create(
    name="DocLocal",
    vectorizer_config=Configure.Vectorizer.text2vec_transformers(
        model="sentence-transformers/all-MiniLM-L6-v2",
    ),
)

# Img2Vec - para imagens
client.collections.create(
    name="ImageCollection",
    vectorizer_config=Configure.Vectorizer.img2vec_neural,
    properties=[
        Property(name="image", dataType=DataType.BLOB),
        Property(name="caption", dataType=DataType.TEXT),
    ],
)

# Multi2Vec - texto + imagem
client.collections.create(
    name="MultiModal",
    vectorizer_config=Configure.Vectorizer.multi2vec_openai(
        text_fields=["title", "description"],
        image_fields=["image"],
    ),
)

# Reranker - reranking com Cohere
# Usado pós-busca para melhorar relevância
results = docs.query.near_text(
    query="busca com reranking",
    limit=20,
    target_vector="default",
)
# O reranker é aplicado automaticamente se configurado
```

---

## 8. Weaviate Cloud

Deploy gerenciado na nuvem com alta disponibilidade.

```python
import weaviate
from weaviate.classes.init import Auth

# Conectar ao Weaviate Cloud
client = weaviate.connect_to_weaviate_cloud(
    cluster_url="https://your-cluster.weaviate.cloud",
    auth_credentials=Auth.api_key("your-api-key"),
)

# Operações normais
docs = client.collections.get("Document")

# Schema no cloud
client.collections.create(
    name="CloudDoc",
    vectorizer_config=Configure.Vectorizer.text2vec_openai(
        model="text-embedding-3-small",
    ),
    properties=[
        Property(name="content", dataType=DataType.TEXT),
    ],
)

# Uso normal do banco
docs.data.insert({"content": "Documento no cloud"})

# Verificar status do cluster
cluster_status = client.cluster.status
print(f"Status: {cluster_status}")
```

---

## 9. GraphQL API

Acesso direto via GraphQL para consultas complexas.

```python
import weaviate
import requests

client = weaviate.connect_to_local()

# Consulta GraphQL direta
graphql_query = """
{
  Get {
    Document(
      nearText: {concepts: ["inteligência artificial"], distance: 0.7}
      limit: 5
      where: {
        path: ["category"]
        operator: Equal
        valueText: "tech"
      }
    ) {
      title
      content
      category
      _additional {
        distance
        certainty
        id
      }
    }
  }
}
"""

response = requests.post(
    "http://localhost:8080/graphql",
    json={"query": graphql_query},
)
data = response.json()

# Batch GraphQL
batch_query = """
{
  Get {
    Document(
      limit: 100
    ) {
      title
      content
      _additional { id }
    }
  }
}
"""
```

---

## 10. Batch Import

Importação massiva de dados com controle de performance.

```python
import weaviate
from weaviate.classes.config import Configure
from weaviate.util import generate_uuid5

client = weaviate.connect_to_local()
docs = client.collections.get("Document")

# Batch dinâmico (recomendado)
import json

with open("documents.json", "r") as f:
    data = json.load(f)

with docs.batch.dynamic() as batch:
    for item in data:
        batch.add_object(
            properties={
                "title": item["title"],
                "content": item["content"],
                "category": item["category"],
            },
            uuid=generate_uuid5(item["id"]),  # UUID determinístico
        )

print(f"Lote processado: {docs.batch.failed_objects}")
print(f"Sucesso: {docs.batch.number_objects}")

# Batch com controle de tamanho
with docs.batch.fixed_size(batch_size=100, concurrent_workers=4) as batch:
    for item in data:
        batch.add_object(
            properties=item,
            uuid=generate_uuid5(item["id"]),
        )

# Batch por sharding
docs = client.collections.get("Document")

with docs.batch.fixed_size(batch_size=500) as batch:
    for i, item in enumerate(data):
        batch.add_object(
            properties=item,
            vector=None,  # Deixar o módulo gerar
            tenant=f"tenant_{i % 10}",  # Distribuir entre tenants
        )
```

---

## 11. Backup e Restore

```python
import weaviate
from weaviate.classes.backup import BackupStatus

client = weaviate.connect_to_local()

# Criar backup
backup_id = "backup_2024_01_15"
client.backup.create(
    backup_id=backup_id,
    include_classes=["Document", "Product"],
    backend="filesystem",
    backup_path="/backups",
)

# Verificar status do backup
status = client.backup.get_create_status(
    backup_id=backup_id,
    backend="filesystem",
)
print(f"Status: {status.status}")

# Listar backups
backups = client.backup.list(backend="filesystem")
for b in backups:
    print(f"  {b.id} - {b.status}")

# Restaurar backup
client.backup.restore(
    backup_id=backup_id,
    include_classes=["Document"],
    backend="filesystem",
    backup_path="/backups",
)

# Verificar restauração
status = client.backup.get_restore_status(
    backup_id=backup_id,
    backend="filesystem",
)
```

---

## 12. Replicação e Consistência

```python
import weaviate
from weaviate.classes.config import Configure, ReplicationConfig

client = weaviate.connect_to_local()

# Criar classe com replicação
client.collections.create(
    name="ReplicatedDoc",
    replication_config=Configure.Replication(
        factor=3,  # 3 réplicas
        async_enabled=True,
    ),
    vectorizer_config=Configure.Vectorizer.text2vec_openai(
        model="text-embedding-3-small",
    ),
)

# Configurar consistência
docs = client.collections.get("ReplicatedDoc")

# Insert com consistência forte
docs.data.insert(
    {"content": "Dado crítico"},
    consistency_level="ALL",  # ALL, ONE, QUORUM
)

# Search com consistência
results = docs.query.near_text(
    query="dado crítico",
    limit=5,
    consistency_level="QUORUM",
)

# Verificar réplicas
info = docs.config.get()
print(f"Réplicas: {info.replication_config.factor}")
```

---

## 13. Compressão e Caching

```python
import weaviate
from weaviate.classes.config import Configure

client = weaviate.connect_to_local()

# Vetores comprimidos via PQ
client.collections.create(
    name="CompressedDoc",
    vectorizer_config=Configure.Vectorizer.text2vec_openai(
        model="text-embedding-3-small",
    ),
    vector_index_config=Configure.VectorIndex.hnsw(
        quantizer=Configure.Vectorizer.pq(
            segments=8,
            training_limit=10000,
            centroids=256,
        ),
    ),
)

# Vetores comprimidos via SQ
client.collections.create(
    name="SQDoc",
    vectorizer_config=Configure.Vectorizer.text2vec_openai(
        model="text-embedding-3-small",
    ),
    vector_index_config=Configure.VectorIndex.flat(
        quantizer=Configure.Vectorizer.scalar_int8(),
    ),
)

# Caching via HNSW settings
docs = client.collections.get("CachedDoc")
docs.config.update(
    vector_index_config=Configure.VectorIndex.hnsw(
        ef_construction=128,
        max_connections=64,
        ef=64,  # Ef no búsqueda
        dynamic_ef_min=100,
        dynamic_ef_max=500,
    )
)
```

---

## 14. Controle de Acesso (RBAC)

```python
import weaviate
from weaviate.classes.rbac import Permissions

client = weaviate.connect_to_local()

# Criar role customizada
client.roles.create(
    name="reader",
    permissions=[
        Permissions.read(
            collection="Document",
            tenant="org_1",
        ),
    ],
)

# Atribuir role a usuário
client.users.assign_roles(
    user_id="user-123",
    role_names=["reader"],
)

# Verificar permissões
roles = client.users.get_user_roles(user_id="user-123")
for role in roles:
    print(f"Role: {role.name}")

# Conectar como usuário específico
reader_client = weaviate.connect_to_local(
    auth_client_secret=weaviate.classes.init.Auth.api_key("user-api-key"),
)
```

---

## 15. Integração com LangChain

```python
from langchain_community.vectorstores import Weaviate
from langchain_openai import OpenAIEmbeddings
from langchain.text_splitter import RecursiveCharacterTextSplitter

# Embeddings
embeddings = OpenAIEmbeddings(model="text-embedding-3-small")

# Criar vector store
vectorstore = Weaviate.from_documents(
    documents=docs,
    embedding=embeddings,
    weaviate_url="http://localhost:8080",
    index_name="LangchainDocs",
)

# Busca simples
results = vectorstore.similarity_search(
    "como funciona embedding",
    k=5,
)

# Busca com filtros
from langchain_community.vectorstores import Weaviate

results = vectorstore.similarity_search(
    "machine learning",
    k=5,
    filters={"path": ["category"], "operator": "Equal", "valueText": "tech"},
)

# RAG Chain
from langchain.chains import RetrievalQA

qa_chain = RetrievalQA.from_chain_type(
    llm=ChatOpenAI(model="gpt-4"),
    retriever=vectorstore.as_retriever(
        search_type="mmr",
        search_kwargs={"k": 5, "fetch_k": 20}
    ),
)
```

---

## 16. Integração com LlamaIndex

```python
from llama_index.vector_stores.weaviate import WeaviateVectorStore
from llama_index.core import VectorStoreIndex, StorageContext

# Criar vector store
vector_store = WeaviateVectorStore(
    weaviate_url="http://localhost:8080",
    index_name="LlamaIndexDocs",
)

# Indexar
storage_context = StorageContext.from_defaults(vector_store=vector_store)
index = VectorStoreIndex.from_documents(
    documents,
    storage_context=storage_context,
)

# Consultar
query_engine = index.as_query_engine(
    similarity_top_k=5,
    vector_store_kwargs={"alpha": 0.7},
)
response = query_engine.query("Explique RAG com Weaviate")
```

---

## 17. MELHORIA: Erros Comuns vs Práticas Corretas

### ❌ ERRADO - Schema sem vetORIZador
```python
# Schema sem configurar vetORIZação
client.collections.create(
    name="Document",
    properties=[
        Property(name="content", dataType=DataType.TEXT),
    ],
)
# Vetores não serão gerados automaticamente!
```

### ✅ CORRETO - Schema completo com vetORIZador
```python
client.collections.create(
    name="Document",
    description="Documentos vetORIZados",
    vectorizer_config=Configure.Vectorizer.text2vec_openai(
        model="text-embedding-3-small",
        vectorize_class_name=False,
    ),
    properties=[
        Property(
            name="content",
            dataType=DataType.TEXT,
            description="Conteúdo do documento",
        ),
        Property(
            name="category",
            dataType=DataType.TEXT,
            skip_vectorization=True,  # Não vetorizar campo filtro
        ),
    ],
    vector_index_config=Configure.VectorIndex.hnsw(
        distance=VectorDistances.COSINE,
    ),
)
```

### ❌ ERRADO - Inserir dados sem batch
```python
# Loop individual - lento para muitos dados
for item in data:
    docs.data.insert(item)  # MUITO LENTO!
```

### ✅ CORRETO - Usar batch
```python
with docs.batch.dynamic() as batch:
    for item in data:
        batch.add_object(item)

# Verificar erros
if docs.batch.failed_objects:
    print(f"Falhas: {len(docs.batch.failed_objects)}")
```

### ❌ ERRADO - Buscar sem limite
```python
# Pode retornar todos os dados
results = docs.query.near_text(query="busca", limit=None)
```

### ✅ CORRETO - Limite e filtros adequados
```python
results = docs.query.near_text(
    query="busca",
    limit=10,
    distance=0.7,
    filters=weaviate.classes.query.Filter.by_property("active").equal(True),
)
```

### ❌ ERRADO - Não verificar status do backup
```python
client.backup.create(backup_id="my_backup", backend="s3")
# Não verificar se completou
```

### ✅ CORRETO - Verificar status do backup
```python
import time

client.backup.create(backup_id="my_backup", backend="s3")

while True:
    status = client.backup.get_create_status(
        backup_id="my_backup",
        backend="s3",
    )
    if status.status in ["SUCCESS", "FAILED"]:
        break
    time.sleep(1)

print(f"Backup: {status.status}")
```

### ❌ ERRADO - Não usar multi-tenancy para multi-org
```python
# Cada org em coleção diferente - desperdício de recursos
client.collections.create(name="Org1_Docs", ...)
client.collections.create(name="Org2_Docs", ...)
```

### ✅ CORRETO - Multi-tenancy eficiente
```python
client.collections.create(
    name="Docs",
    multi_tenancy_config=Configure.MultiTenancy(enabled=True),
    # Uma coleção para todas as orgs
)

docs.data.insert({"content": "..."}, tenant="org_1")
docs.data.insert({"content": "..."}, tenant="org_2")
```

---

## 18. Monitoramento e Health Check

```python
import weaviate
import requests

client = weaviate.connect_to_local()

# Health check
health = client.is_live()
ready = client.is_ready()
print(f"Live: {health}, Ready: {ready}")

# Status do cluster
response = requests.get("http://localhost:8080/v1/meta")
meta = response.json()
print(f"Versão: {meta['version']}")
print(f"Módulos: {list(meta['modules'].keys())}")

# Métricas Prometheus
# http://localhost:8080/metrics
```

---

## 19. Docker Compose Completo

```yaml
# docker-compose.yml
version: '3.8'
services:
  weaviate:
    image: semitechnologies/weaviate:1.25.0
    ports:
      - "8080:8080"
      - "50051:50051"
    volumes:
      - weaviate_data:/var/lib/weaviate
    environment:
      QUERY_DEFAULTS_LIMIT: 25
      AUTHENTICATION_ANONYMOUS_ACCESS_ENABLED: 'false'
      PERSISTENCE_DATA_PATH: '/var/lib/weaviate'
      DEFAULT_VECTORIZER_MODULE: 'text2vec-openai'
      CLUSTER_HOSTNAME: 'node1'
      CLUSTER_DATA_BIND_PORT: 7000
      CLUSTER_GOSSIP_BIND_PORT: 7001
      CLUSTER_JOIN: 'node1:7001'
      ENABLE_MODULES: 'text2vec-openai,generative-openai'
      OPENAI_APIKEY: $OPENAI_APIKEY
      REPLICATION_MINIMUM_FACTOR: 2
    restart: unless-stopped

  prometheus:
    image: prom/prometheus
    ports:
      - "9090:9090"
    volumes:
      - ./prometheus.yml:/etc/prometheus/prometheus.yml

  grafana:
    image: grafana/grafana
    ports:
      - "3000:3000"
    environment:
      GF_SECURITY_ADMIN_PASSWORD: admin

volumes:
  weaviate_data:
```

---

## 20. Checklist de Boas Práticas

- ✅ Configure `text2vec-openai` ou `text2vec-huggingface` para vetORIZação automática
- ✅ Use `skip_vectorization=True` em campos que não precisam de embedding
- ✅ Implemente batch para importações > 100 documentos
- ✅ Use multi-tenancy em vez de coleções separadas para multi-org
- ✅ Configure HNSW com `ef_construction` e `max_connections` adequados
- ✅ Use busca híbrida (alpha=0.5-0.7) para melhor cobertura
- ✅ Implemente RAG com `generate` para respostas baseadas em contexto
- ✅ Configure replicação (factor >= 2) em produção
- ✅ Crie backups regulares e verifique status
- ✅ Use `score_threshold` para filtrar resultados de baixa qualidade
- ✅ Monitore métricas via Prometheus/Grafana
- ✅ Prefira `near_text` com vetORIZador automático sobre `near_vector`
