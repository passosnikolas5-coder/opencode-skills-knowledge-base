# 🧬 Chroma - Banco de Dados de Embeddings Open-Source

**Fonte:** https://github.com/chroma-core/chroma (18k+ stars)
**Descrição:** Chroma é um banco de dados de embeddings open-source focado em simplicidade e developer experience. Ideal para prototipagem e produção com integração nativa a frameworks de IA, suporte a múltiplos backends e modo client-server para escala.

---

## 1. Criação de Coleções

Coleções são o container principal para armazenar embeddings, documentos e metadados.

```python
import chromadb
from chromadb.utils import embedding_functions

# Conexão persistente
client = chromadb.PersistentClient(path="./chroma_db")

# Conexão in-memory
client = chromadb.Client()

# Criar coleção com função de embedding padrão
collection = client.get_or_create_collection(
    name="documents",
    metadata={
        "hnsw:space": "cosine",  # cosine, l2, ip
        "hnsw:M": 16,           # Conexões por nó
        "hnsw:construction_ef": 100,
        "hnsw:search_ef": 100,
    },
)

# Criar coleção com embedding function customizada
openai_ef = embedding_functions.OpenAIEmbeddingFunction(
    api_key="your-api-key",
    model_name="text-embedding-3-small",
)

collection = client.get_or_create_collection(
    name="documents_openai",
    embedding_function=openai_ef,
    metadata={"hnsw:space": "cosine"},
)

# Criar coleção com Sentence Transformers
sentence_ef = embedding_functions.SentenceTransformerEmbeddingFunction(
    model_name="all-MiniLM-L6-v2",
)

collection = client.get_or_create_collection(
    name="documents_st",
    embedding_function=sentence_ef,
)

# Listar coleções
collections = client.list_collections()
print([c.name for c in collections])
```

---

## 2. Operações Add/Upsert/Query

CRUD completo para embeddings, documentos e metadados.

```python
import chromadb

client = chromadb.PersistentClient(path="./chroma_db")
collection = client.get_collection("documents")

# Add - Inserir documentos
collection.add(
    documents=[
        "O que é machine learning?",
        "Como funcionam redes neurais?",
        "O que é processamento de linguagem natural?",
    ],
    metadatas=[
        {"category": "ml", "difficulty": "beginner", "tags": ["ml", "intro"]},
        {"category": "dl", "difficulty": "intermediate", "tags": ["neural", "deep-learning"]},
        {"category": "nlp", "difficulty": "advanced", "tags": ["nlp", "text"]},
    ],
    ids=["doc1", "doc2", "doc3"],
)

# Upsert - Inserir ou atualizar
collection.upsert(
    documents=["Documento atualizado"],
    metadatas=[{"category": "updated", "version": 2}],
    ids=["doc1"],  # Se existir, atualiza
)

# Query - Buscar por similaridade
results = collection.query(
    query_texts=["o que é IA?"],
    n_results=5,
    include=["documents", "metadatas", "distances"],
)

# Query com filtros
results = collection.query(
    query_texts=["machine learning"],
    n_results=5,
    where={"category": "ml"},  # Filtro exato
)

# Query com múltiplos filtros
results = collection.query(
    query_texts=["deep learning"],
    n_results=10,
    where={
        "$and": [
            {"category": {"$ne": "nlp"}},
            {"difficulty": {"$in": ["beginner", "intermediate"]}},
        ]
    },
)

# Query por IDs específicos
results = collection.get(
    ids=["doc1", "doc2"],
    include=["documents", "metadatas", "embeddings"],
)
```

---

## 3. Filtragem com Where Clauses

Filtros avançados para refinar buscas por metadados.

```python
import chromadb

client = chromadb.PersistentClient(path="./chroma_db")
collection = client.get_collection("documents")

# Filtro exato
results = collection.query(
    query_texts=["busca"],
    where={"category": "ml"},
)

# Operadores de comparação
results = collection.query(
    query_texts=["busca"],
    where={
        "$and": [
            {"view_count": {"$gte": 100}},
            {"rating": {"$lt": 4.5}},
        ]
    },
)

# Filtro em arrays
results = collection.query(
    query_texts=["busca"],
    where={
        "$or": [
            {"tags": {"$contains": "python"}},
            {"tags": {"$contains": "ml"}},
        ]
    },
)

# Filtro com regex
results = collection.query(
    query_texts=["busca"],
    where={"title": {"$regex": "^Introdução.*"}},
)

# Filtro com $in
results = collection.query(
    query_texts=["busca"],
    where={"category": {"$in": ["ml", "dl", "nlp"]}},
)

# Filtro com $nin (not in)
results = collection.query(
    query_texts=["busca"],
    where={"category": {"$nin": ["deprecated"]}},
)

# Filtro composto complexo
results = collection.query(
    query_texts=["machine learning avançado"],
    n_results=10,
    where={
        "$and": [
            {"category": {"$in": ["ml", "dl"]}},
            {"difficulty": {"$in": ["intermediate", "advanced"]}},
            {"view_count": {"$gte": 50}},
            {"$or": [
                {"tags": {"$contains": "python"}},
                {"tags": {"$contains": "tensorflow"}},
            ]},
        ]
    },
)
```

---

## 4. Funções de Embedding

Suporte a múltiplos provedores e modelos de embedding.

```python
import chromadb
from chromadb.utils import embedding_functions

# OpenAI
openai_ef = embedding_functions.OpenAIEmbeddingFunction(
    api_key="your-key",
    model_name="text-embedding-3-small",
    dimensions=1536,
)

# Cohere
cohere_ef = embedding_functions.CohereEmbeddingFunction(
    api_key="your-key",
    model_name="embed-multilingual-v3.0",
)

# HuggingFace
huggingface_ef = embedding_functions.HuggingFaceEmbeddingFunction(
    api_key="your-key",
    model_name="BAAI/bge-small-en-v1.5",
)

# Sentence Transformers (local)
sentence_ef = embedding_functions.SentenceTransformerEmbeddingFunction(
    model_name="all-MiniLM-L6-v2",
    device="cuda",  # GPU
)

# Google PaLM
palm_ef = embedding_functions.GoogleGenerativeAiEmbeddingFunction(
    api_key="your-key",
    model_name="models/text-embedding-004",
)

# Voyage AI
voyage_ef = embedding_functions.VoyageEmbeddingFunction(
    api_key="your-key",
    model_name="voyage-3",
)

# Usar embedding function
collection = client.get_or_create_collection(
    name="multimodal_embeddings",
    embedding_function=openai_ef,
)

# Embedding manual (desabilitar automático)
collection = client.get_or_create_collection(
    name="manual_embeddings",
    embedding_function=None,
)

# Fornecer embeddings manualmente
collection.add(
    documents=["Doc 1", "Doc 2"],
    embeddings=[
        [0.1] * 1536,  # Embedding pré-computado
        [0.2] * 1536,
    ],
    ids=["doc1", "doc2"],
)
```

---

## 5. Modo Persistente vs In-Memory

Dois modos de operação para diferentes necessidades.

```python
import chromadb

# Modo in-memory (dados perdem ao fechar)
client = chromadb.Client()
collection = client.get_or_create_collection("temp_data")

# Modo persistente (dados salvos em disco)
client = chromadb.PersistentClient(
    path="./chroma_production_db",
    settings=chromadb.Settings(
        anonymized_telemetry=False,  # Desabilitar telemetria
        allow_reset=True,
        is_persistent=True,
    ),
)

collection = client.get_or_create_collection("persistent_data")

# Backup e restore
import shutil

# Backup
shutil.copytree(
    "./chroma_production_db",
    "./chroma_backup_2024_01_15",
)

# Restore
shutil.copytree(
    "./chroma_backup_2024_01_15",
    "./chroma_restored",
    dirs_exist_ok=True,
)
```

---

## 6. Modo Client-Server

Chroma Client-Server para escala e multi-processo.

```python
# Servidor (iniciar com: chroma run --host 0.0.0.0 --port 8000)
import chromadb

# Conectar ao servidor
client = chromadb.HttpClient(
    host="localhost",
    port=8000,
)

# Conectar com autenticação
client = chromadb.HttpClient(
    host="localhost",
    port=8000,
    headers={
        "Authorization": "Bearer your-token",
    },
)

# Operações normais
collection = client.get_or_create_collection("server_data")
collection.add(
    documents=["Documento no servidor"],
    ids=["server_doc1"],
)

# Heartbeat
heartbeat = client.heartbeat()
print(f"Servidor ativo: {heartbeat}")
```

---

## 7. Python e JavaScript SDK

SDKs oficiais para diferentes linguagens.

```python
# Python - Uso básico
import chromadb

client = chromadb.Client()
collection = client.get_or_create_collection("example")

# Adicionar
collection.add(
    documents=["Olá mundo"],
    ids=["hello"],
)

# Buscar
results = collection.query(
    query_texts=["saudação"],
    n_results=1,
)
print(results["documents"])
```

```javascript
// JavaScript - Uso básico
import { ChromaClient } from 'chromadb';

const client = new ChromaClient();
const collection = await client.getOrCreateCollection({
  name: "example"
});

await collection.add({
  documents: ["Olá mundo"],
  ids: ["hello"],
});

const results = await collection.query({
  queryTexts: ["saudação"],
  nResults: 1,
});
console.log(results.documents);
```

---

## 8. Integração com LangChain

```python
from langchain_community.vectorstores import Chroma
from langchain_openai import OpenAIEmbeddings
from langchain.text_splitter import RecursiveCharacterTextSplitter
from langchain_community.document_loaders import DirectoryLoader

# Carregar documentos
loader = DirectoryLoader("./docs", glob="**/*.md")
docs = loader.load()

# Splitter
splitter = RecursiveCharacterTextSplitter(
    chunk_size=500,
    chunk_overlap=50,
)
chunks = splitter.split_documents(docs)

# Embeddings
embeddings = OpenAIEmbeddings(model="text-embedding-3-small")

# Criar vector store
vectorstore = Chroma.from_documents(
    documents=chunks,
    embedding=embeddings,
    persist_directory="./chroma_langchain",
    collection_name="langchain_docs",
)

# Busca simples
results = vectorstore.similarity_search(
    "como usar Chroma?",
    k=5,
)

# Busca com filtros
results = vectorstore.similarity_search(
    "machine learning",
    k=5,
    filter={"source": "tutorial.md"},
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

# Salvar e recarregar
vectorstore.persist()
vectorstore_loaded = Chroma(
    persist_directory="./chroma_langchain",
    embedding_function=embeddings,
)
```

---

## 9. Integração com LlamaIndex

```python
from llama_index.vector_stores.chroma import ChromaVectorStore
from llama_index.core import VectorStoreIndex, StorageContext
from llama_index.core import SimpleDirectoryReader
import chromadb

# Criar Chroma client
chroma_client = chromadb.PersistentClient(path="./chroma_llamaindex")
chroma_collection = chroma_client.get_or_create_collection("llamaindex_docs")

# Criar vector store
vector_store = ChromaVectorStore(chroma_collection=chroma_collection)
storage_context = StorageContext.from_defaults(vector_store=vector_store)

# Carregar e indexar documentos
documents = SimpleDirectoryReader("./data").load_data()
index = VectorStoreIndex.from_documents(
    documents,
    storage_context=storage_context,
)

# Consultar
query_engine = index.as_query_engine(
    similarity_top_k=5,
    vector_store_kwargs={"where": {"source": "docs"}},
)
response = query_engine.query("Explique Chroma")
print(response)

# Salvar índice
index.storage_context.persist()
```

---

## 10. Include Options e Campos Retornados

Controle preciso do que é retornado nas consultas.

```python
import chromadb

client = chromadb.PersistentClient(path="./chroma_db")
collection = client.get_collection("documents")

# Retornar tudo
results = collection.query(
    query_texts=["busca"],
    n_results=5,
    include=["documents", "metadatas", "distances", "embeddings"],
)

# Retornar apenas documentos
results = collection.query(
    query_texts=["busca"],
    n_results=5,
    include=["documents"],
)

# Retornar apenas metadados
results = collection.query(
    query_texts=["busca"],
    n_results=5,
    include=["metadatas"],
)

# Retornar apenas distâncias
results = collection.query(
    query_texts=["busca"],
    n_results=5,
    include=["distances"],
)

# Retornar apenas embeddings (para debug/análise)
results = collection.query(
    query_texts=["busca"],
    n_results=5,
    include=["embeddings"],
)

# Formato dos resultados
print(results["ids"])         # [[id1, id2, ...]]
print(results["documents"])   # [["doc1", "doc2", ...]]
print(results["metadatas"])   # [[{meta1}, {meta2}, ...]]
print(results["distances"])   # [[0.1, 0.3, ...]]
print(results["embeddings"])  # [[[0.1, ...], [0.2, ...]]]
```

---

## 11. Suporte Multi-Modal

Chroma suporta diferentes tipos de dados além de texto.

```python
import chromadb
from chromadb.utils import embedding_functions

client = chromadb.PersistentClient(path="./chroma_multimodal")

# Coleção para imagens + texto
image_ef = embedding_functions.OpenCLIPEmbeddingFunction(
    model_name="ViT-B-32",
    checkpoint="laion2b_s34b_b79k",
)

collection = client.get_or_create_collection(
    name="multimodal",
    embedding_function=image_ef,
)

# Adicionar imagens
from PIL import Image
import base64

# Converter imagem para base64
def image_to_base64(image_path: str) -> str:
    with open(image_path, "rb") as f:
        return base64.b64encode(f.read()).decode()

collection.add(
    documents=[
        "Gato sentado no sofá",
        "Cachorro correndo no parque",
    ],
    metadatas=[
        {"type": "cat", "color": "orange"},
        {"type": "dog", "color": "brown"},
    ],
    uris=[
        "https://example.com/cat.jpg",
        "https://example.com/dog.jpg",
    ],
    ids=["img1", "img2"],
)

# Buscar por similaridade de imagem
results = collection.query(
    query_uris=["https://example.com/test_cat.jpg"],
    n_results=3,
)
```

---

## 12. CORS Configuration

Configuração de CORS para aplicações web.

```python
# Servidor com CORS habilitado
import chromadb

client = chromadb.HttpClient(
    host="0.0.0.0",
    port=8000,
)

# Configurar CORS via Docker
# docker-compose.yml
# environment:
#   - CHROMA_SERVER_CORS_ALLOW_ORIGINS=["http://localhost:3000"]
#   - CHROMA_SERVER_CORS_ALLOW_METHODS=["GET", "POST", "OPTIONS"]
#   - CHROMA_SERVER_CORS_ALLOW_HEADERS=["*"]

# Configurar via settings
import chromadb
from chromadb.config import Settings

client = chromadb.HttpClient(
    host="localhost",
    port=8000,
    settings=Settings(
        chroma_server_cors_allow_origins=["http://localhost:3000"],
        chroma_server_auth_provider="chromadb.auth.token_auth.TokenAuthServerProvider",
    ),
)
```

---

## 13. Docker Deployment

```yaml
# docker-compose.yml
version: '3.8'
services:
  chroma:
    image: chromadb/chroma:latest
    ports:
      - "8000:8000"
    volumes:
      - chroma_data:/chroma/chroma
    environment:
      - IS_PERSISTENT=TRUE
      - ANONYMIZED_TELEMETRY=FALSE
      - CHROMA_SERVER_AUTHN_PROVIDER=chromadb.auth.token_auth.TokenAuthServerProvider
      - CHROMA_SERVER_AUTHN_TOKEN=your-secret-token
    restart: unless-stopped

  # Chroma com PostgreSQL (produção)
  chroma-postgres:
    image: chromadb/chroma:latest
    ports:
      - "8001:8000"
    environment:
      - IS_PERSISTENT=TRUE
      - ANONYMIZED_TELEMETRY=FALSE
      - CHROMA_PG_URL=postgresql://user:pass@postgres:5432/chroma
    depends_on:
      - postgres

  postgres:
    image: postgres:15
    environment:
      - POSTGRES_USER=user
      - POSTGRES_PASSWORD=pass
      - POSTGRES_DB=chroma
    volumes:
      - postgres_data:/var/lib/postgresql/data

  # Chroma com Redis
  chroma-redis:
    image: chromadb/chroma:latest
    ports:
      - "8002:8000"
    environment:
      - IS_PERSISTENT=TRUE
      - ANONYMIZED_TELEMETRY=FALSE
      - CHROMA_REDIS_URL=redis://redis:6379
    depends_on:
      - redis

  redis:
    image: redis:7-alpine
    volumes:
      - redis_data:/data

volumes:
  chroma_data:
  postgres_data:
  redis_data:
```

---

## 14. SQLite Backend

Chroma usa SQLite como backend padrão.

```python
import chromadb
import sqlite3

# SQLite configuração
client = chromadb.PersistentClient(
    path="./chroma_sqlite",
    settings=chromadb.Settings(
        sqlite3_path="./chroma_sqlite/chroma.sqlite3",
    ),
)

# Verificar SQLite diretamente
conn = sqlite3.connect("./chroma_sqlite/chroma.sqlite3")
cursor = conn.cursor()

# Listar tabelas
cursor.execute("SELECT name FROM sqlite_master WHERE type='table'")
tables = cursor.fetchall()
print("Tabelas:", tables)

# Verificar coleções
cursor.execute("SELECT * FROM collections")
for row in cursor.fetchall():
    print(f"Coleção: {row}")

# Índices
cursor.execute("SELECT name FROM sqlite_master WHERE type='index'")
print("Índices:", cursor.fetchall())

conn.close()
```

---

## 15. Performance Optimization

Técnicas para otimizar performance em produção.

```python
import chromadb
from chromadb.config import Settings

# Configurações de performance
client = chromadb.PersistentClient(
    path="./chroma_optimized",
    settings=Settings(
        # Otimizações de batch
        chroma_batch_size=100,
        chroma_max_batch_size=1000,
        # Otimizações de memória
        chroma_memory_limit_bytes=1024 * 1024 * 1024,  # 1GB
        # Telemetria
        anonymized_telemetry=False,
    ),
)

# Coleção com parâmetros HNSW otimizados
collection = client.get_or_create_collection(
    name="optimized",
    metadata={
        "hnsw:space": "cosine",
        "hnsw:M": 32,                    # Mais conexões = mais acurácia
        "hnsw:construction_ef": 200,     # Mais ef no build
        "hnsw:search_ef": 100,           # Ef no search
        "hnsw:num_threads": 4,           # Threads para build
    },
)

# Batch upsert otimizado
BATCH_SIZE = 100
for i in range(0, len(data), BATCH_SIZE):
    batch = data[i:i + BATCH_SIZE]
    collection.upsert(
        documents=[item["text"] for item in batch],
        metadatas=[item["meta"] for item in batch],
        ids=[item["id"] for item in batch],
    )

# Pré-computar embeddings
import numpy as np
from tqdm import tqdm

all_embeddings = []
for doc in tqdm(documents):
    embedding = embedding_function([doc])
    all_embeddings.append(embedding[0])

# Inserir embeddings pré-computados
collection.add(
    documents=documents,
    embeddings=all_embeddings,  # Mais rápido que gerar no add
    metadatas=metadatas,
    ids=ids,
)

# Delete em batch
collection.delete(ids=old_ids)

# Compactar banco
import os
os.system("sqlite3 ./chroma_db/chroma.sqlite3 'VACUUM;'")
```

---

## 16. MELHORIA: Erros Comuns vs Práticas Corretas

### ❌ ERRADO - Usar ID duplicado
```python
collection.add(documents=["Doc 1"], ids=["doc1"])
collection.add(documents=["Doc 2"], ids=["doc1"])  # ERRO!
```

### ✅ CORRETO - Usar upsert ou IDs únicos
```python
# Opção 1: upsert
collection.upsert(
    documents=["Doc atualizado"],
    ids=["doc1"],
)

# Opção 2: IDs únicos
import uuid
collection.add(
    documents=["Doc 1", "Doc 2"],
    ids=[str(uuid.uuid4()), str(uuid.uuid4())],
)
```

### ❌ ERRADO - Não definir espaço de distância
```python
# Espaço padrão pode não ser ideal
collection = client.get_or_create_collection("my_collection")
```

### ✅ CORRETO - Definir espaço explicitamente
```python
collection = client.get_or_create_collection(
    name="my_collection",
    metadata={
        "hnsw:space": "cosine",  # Recomendado para embeddings
    },
)
```

### ❌ ERRADO - Buscar sem limite
```python
# Pode retornar muitos resultados
results = collection.query(query_texts=["busca"])
```

### ✅ CORRETO - Limitar e filtrar resultados
```python
results = collection.query(
    query_texts=["busca"],
    n_results=10,
    where={"category": "relevante"},
    include=["documents", "metadatas", "distances"],
)
```

### ❌ ERRADO - Não persistir dados em produção
```python
# Dados perdem ao fechar o programa
client = chromadb.Client()
```

### ✅ CORRETO - Usar PersistentClient
```python
client = chromadb.PersistentClient(
    path="./chroma_production",
    settings=chromadb.Settings(
        anonymized_telemetry=False,
    ),
)
```

### ❌ ERRADO - Embeddings no loop
```python
# Lento - gera embedding para cada documento individualmente
for doc in documents:
    collection.add(documents=[doc])
```

### ✅ CORRETO - Batch upsert
```python
# Rápido - processa em lotes
collection.add(
    documents=documents,  # Lista de todos
    metadatas=metadatas,
    ids=ids,
)
```

### ❌ ERRADO - Não verificar coleções existentes
```python
# Pode criar duplicatas
collection = client.create_collection("my_collection")
```

### ✅ CORRETO - Usar get_or_create
```python
collection = client.get_or_create_collection(
    name="my_collection",
    metadata={"hnsw:space": "cosine"},
)
```

---

## 17. Monitoramento e Debug

```python
import chromadb

client = chromadb.PersistentClient(path="./chroma_db")

# Listar coleções e estatísticas
for collection in client.list_collections():
    print(f"Coleção: {collection.name}")
    print(f"  IDs: {collection.count()}")
    print(f"  Metadados: {collection.metadata}")

# Verificar contagem
collection = client.get_collection("documents")
print(f"Total de documentos: {collection.count()}")

# Verificar embedding function
print(f"Embedding function: {collection._embedding_function}")

# Debug de queries
results = collection.query(
    query_texts=["teste"],
    n_results=5,
    include=["documents", "metadatas", "distances", "embeddings"],
)

# Analisar distâncias
print(f"Distâncias: {results['distances'][0]}")
print(f"Média: {sum(results['distances'][0]) / len(results['distances'][0]):.4f}")
```

---

## 18. Segurança e Autenticação

```python
import chromadb
from chromadb.config import Settings

# Com autenticação de token
client = chromadb.HttpClient(
    host="localhost",
    port=8000,
    settings=Settings(
        chroma_server_auth_provider="chromadb.auth.token_auth.TokenAuthServerProvider",
        chroma_server_auth_token_provider="chromadb.auth.token_auth.TokenAuthConfiguration",
        chroma_server_auth_token_transport_header="Authorization",
        chroma_client_auth_provider="chromadb.auth.token_auth.TokenAuthClientProvider",
        chroma_client_auth_token_transport_header="Authorization",
        chroma_client_auth_credentials="your-secret-token",
    ),
)

# Com OAuth2
client = chromadb.HttpClient(
    host="localhost",
    port=8000,
    settings=Settings(
        chroma_server_auth_provider="chromadb.auth.oauth2_server.OAuth2ServerProvider",
        chroma_server_auth_oauth2_config={
            "provider": "chromadb.auth.oauth2_server.OAuth2ClientCredentialsTokenAuthConfiguration",
            "token_url": "http://localhost:8080/oauth2/token",
            "client_id": "your-client-id",
            "client_secret": "your-client-secret",
        },
    ),
)
```

---

## 19. Configuração Avançada

```python
import chromadb
from chromadb.config import Settings

# Configuração completa
settings = Settings(
    # Core
    chroma_api_impl="chromadb.api.segment.SegmentAPI",
    chroma_sysdb_impl="chromadb.db.impl.sqlite.SqliteDB",
    chroma_producer_impl="chromadb.db.impl.sqlite.SqliteDB",
    chroma_consumer_impl="chromadb.db.impl.sqlite.SqliteDB",
    
    # Persistência
    is_persistent=True,
    persist_directory="./chroma_data",
    
    # Performance
    chroma_server_thread_pool_size=10,
    chroma_max_batch_size=1000,
    
    # Telemetria
    anonymized_telemetry=False,
    
    # Segurança
    chroma_server_auth_provider="chromadb.auth.token_auth.TokenAuthServerProvider",
)

client = chromadb.PersistentClient(
    path="./chroma_config",
    settings=settings,
)
```

---

## 20. Checklist de Boas Práticas

- ✅ Use `PersistentClient` em produção (nunca `Client()`)
- ✅ Defina `hnsw:space: cosine` para embeddings normalizados
- ✅ Use `get_or_create_collection` em vez de `create_collection`
- ✅ Implemente batch add/upsert para grandes volumes
- ✅ Pré-compute embeddings antes de inserir (mais rápido)
- ✅ Use filtros `where` para reduzir escopo de busca
- ✅ Limite resultados com `n_results` sempre
- ✅ Inclua apenas campos necessários com `include`
- ✅ Desabilite telemetria em produção
- ✅ Use UUIDs únicos para IDs
- ✅ Implemente backup regular do diretório de persistência
- ✅ Configure CORS adequadamente para apps web
- ✅ Use Sentence Transformers local para evitar custos de API
- ✅ Configure HNSW parameters para sua necessidade (M, ef)
