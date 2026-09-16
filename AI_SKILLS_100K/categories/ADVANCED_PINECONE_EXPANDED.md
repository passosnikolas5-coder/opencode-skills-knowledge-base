# 🌲 Pinecone — Banco de Dados Vetorial Gerenciado para Busca Semântica e RAG

**Fonte:** https://github.com/pinecone-io/pinecone  
**Descrição:** Pinecone é um banco de dados vetorial gerenciado, otimizado para busca semântica de alta performance. Suporta vetores densos e esparsos, metadata filtering avançado, namespaces para multi-tenancy, reranking, inference API para embeddings e geração, backup/restore, e integrações nativas com LangChain, LlamaIndex e outros frameworks de LLM. Escala de protótipo a produção sem infraestrutura gerenciada.

---

## 1. Setup e Configuração

```python
# Instalação
pip install pinecone pinecone-notebooks

# Configuração
from pinecone import Pinecone

pc = Pinecone(
    api_key="sua-chave-api-aqui"
)

# Verificar conexão
print(f"Index names: {pc.list_indexes().names()}")
```

## 2. Criação e Gerenciamento de Index

```python
from pinecone import Pinecone, ServerlessSpec

pc = Pinecone(api_key="sua-chave")

# Criar index serverless (novo padrão)
pc.create_index(
    name="produtos-embeddings",
    dimension=1536,  # OpenAI text-embedding-3-small
    metric="cosine",
    spec=ServerlessSpec(
        cloud="aws",
        region="us-east-1"
    )
)

# Criar index pod (para controle fino)
from pinecone import PodSpec

pc.create_index(
    name="documentos-legacy",
    dimension=768,
    metric="euclidean",
    spec=PodSpec(
        environment="us-east1-gcp",
        pod_type="s1.x1",
        pods=2
    )
)

# Listar indexes
for idx in pc.list_indexes():
    print(f"  {idx.name} — dim={idx.dimension} — status={idx.status}")

# Deletar index
pc.delete_index("documentos-legacy")
```

## 3. Upsert de Vetores

```python
from pinecone import Pinecone

pc = Pinecone(api_key="sua-chave")
index = pc.Index("produtos-embeddings")

# Upsert individual
index.upsert(vectors=[
    {
        "id": "produto-001",
        "values": [0.1, 0.2, 0.3, ...],  # 1536 dimensões
        "metadata": {
            "nome": "Notebook Dell XPS",
            "preco": 7999.90,
            "categoria": "eletrônicos",
            "em_estoque": True
        }
    }
])

# Upsert em lote
vetores = []
for i in range(1000):
    vetores.append({
        "id": f"doc-{i}",
        "values": [float(j) for j in range(1536)],  # Placeholder
        "metadata": {
            "fonte": f"documento-{i}.pdf",
            "pagina": i % 10 + 1,
            "data": "2025-01-15"
        }
    })

# Upsert em batches de 100
for i in range(0, len(vetores), 100):
    batch = vetores[i:i+100]
    index.upsert(vectors=batch)
    print(f"Upserted batch {i//100 + 1}")
```

## 4. Query e Busca Semântica

```python
from pinecone import Pinecone

pc = Pinecone(api_key="sua-chave")
index = pc.Index("produtos-embeddings")

# Query básica
results = index.query(
    vector=[0.1, 0.2, 0.3, ...],  # Vetor da query
    top_k=5,
    include_metadata=True
)

for match in results.matches:
    print(f"  ID: {match.id} — Score: {match.score:.4f}")
    print(f"  Metadata: {match.metadata}")
    print()

# Query com filtro de metadata
results = index.query(
    vector=[0.1, 0.2, 0.3, ...],
    top_k=10,
    filter={
        "categoria": {"$eq": "eletrônicos"},
        "preco": {"$lte": 5000}
    },
    include_metadata=True
)

# Query com sparse vector (busca híbrida)
results = index.query(
    dense_vector=[0.1, 0.2, 0.3, ...],
    sparse_vector={
        "indices": [0, 5, 10],
        "values": [0.5, 0.3, 0.8]
    },
    top_k=10
)
```

## 5. Namespaces para Multi-Tenancy

```python
from pinecone import Pinecone

pc = Pinecone(api_key="sua-chave")
index = pc.Index("documentos-multitenant")

# Cada tenant有自己的namespace
index.upsert(
    namespace="tenant-empresa-a",
    vectors=[
        {
            "id": "doc-001",
            "values": [0.1, ...] * 1536,
            "metadata": {"tipo": "contrato", "empresa": "A"}
        }
    ]
)

index.upsert(
    namespace="tenant-empresa-b",
    vectors=[
        {
            "id": "doc-002",
            "values": [0.2, ...] * 1536,
            "metadata": {"tipo": "fatura", "empresa": "B"}
        }
    ]
)

# Queries isoladas por tenant
resultados_a = index.query(
    vector=[0.1, ...] * 1536,
    top_k=5,
    namespace="tenant-empresa-a"
)

resultados_b = index.query(
    vector=[0.1, ...] * 1536,
    top_k=5,
    namespace="tenant-empresa-b"
)
# Dados completamente isolados!
```

## 6. Metadata Filtering Avançado

```python
from pinecone import Pinecone

pc = Pinecone(api_key="sua-chave")
index = pc.Index("produtos")

# Igualdade
filtro = {"categoria": {"$eq": "livros"}}

# Desigualdade
filtro = {"preco": {"$gte": 100, "$lte": 500}}

# IN (array)
filtro = {"categoria": {"$in": ["livros", "eletrônicos", "casa"]}}

# NÃO IN
filtro = {"categoria": {"$nin": ["proibido", "restrito"]}}

# Lógica AND/OR
filtro = {
    "$and": [
        {"categoria": {"$eq": "livros"}},
        {"preco": {"$lte": 100}},
        {"em_estoque": {"$eq": True}}
    ]
}

filtro_or = {
    "$or": [
        {"categoria": {"$eq": "livros"}},
        {"avaliacao": {"$gte": 4.5}}
    ]
}

# Filtros aninhados
filtro_complexo = {
    "$and": [
        {"$or": [
            {"categoria": {"$in": ["livros", "ebooks"]}},
            {"autor": {"$eq": "Machado de Assis"}}
        ]},
        {"preco": {"$gte": 20, "$lte": 200}},
        {"ano_publicacao": {"$gte": 2020}}
    ]
}

results = index.query(
    vector=[0.1, ...] * 1536,
    top_k=10,
    filter=filtro_complexo,
    include_metadata=True
)
```

## 7. Sparse-Dense Vectors (Busca Híbrida)

```python
from pinecone import Pinecone

pc = Pinecone(api_key="sua-chave")
index = pc.Index("documentos-hibrido")

# Upsert com sparse + dense
index.upsert(vectors=[
    {
        "id": "doc-001",
        "values": [0.1, ...] * 1536,  # Dense (semântico)
        "sparse_values": {
            "indices": [0, 42, 100, 500],
            "values": [0.8, 0.6, 0.9, 0.3]  # Sparse (palavras-chave)
        },
        "metadata": {"titulo": "Guia de Python"}
    }
])

# Query híbrida
results = index.query(
    dense_vector=[0.1, ...] * 1536,
    sparse_vector={
        "indices": [42, 100],
        "values": [0.7, 0.5]
    },
    top_k=10,
    include_metadata=True
)
```

## 8. Reranking

```python
from pinecone import Pinecone

pc = Pinecone(api_key="sua-chave")

# Usar reranking após query inicial
index = pc.Index("documentos")

# Busca inicial (recuperar mais candidatos)
results = index.query(
    vector=[0.1, ...] * 1536,
    top_k=50,  # Recuperar mais para reranquear
    include_metadata=True
)

# Reranking com Pinecone Inference
from pinecone import PineconeInference

inference = PineconeInference(api_key="sua-chave")

# Reordenar com modelo de reranking
reranked = inference.rerank(
    model="bge-reranker-v2-m3",
    query="Como criar uma API REST?",
    documents=[m.metadata["texto"] for m in results.matches],
    top_n=5
)

for item in reranked.data:
    print(f"  Score: {item.score:.4f} — Doc: {item.document[:100]}")
```

## 9. Inference API — Embeddings e Geração

```python
from pinecone import PineconeInference

inference = PineconeInference(api_key="sua-chave")

# Gerar embeddings
embeddings = inference.embed(
    model="llama-text-embed-v2",
    inputs=[
        "Como funcionam redes neurais?",
        "O que é machine learning?",
        "Explique deep learning"
    ]
)

for emb in embeddings.data:
    print(f"Dimensão: {len(emb.values)}")

# Geração de texto
resposta = inference.generate(
    model="llama-3.1-8b-instruct",
    prompt="O que é RAG em LLMs?",
    max_tokens=200
)

print(resposta.text)
```

## 10. Integração com LangChain

```python
from langchain_pinecone import PineconeVectorStore
from langchain_openai import OpenAIEmbeddings
from langchain_core.prompts import ChatPromptTemplate
from langchain_core.runnables import RunnablePassthrough
from langchain_core.output_parsers import StrOutputParser

# Configurar embeddings
embeddings = OpenAIEmbeddings(model="text-embedding-3-small")

# Conectar ao Pinecone
vectorstore = PineconeVectorStore(
    index_name="documentos-rag",
    embedding=embeddings,
    namespace="producao"
)

# Criar retriever
retriever = vectorstore.as_retriever(
    search_type="similarity",
    search_kwargs={"k": 5, "filter": {"idioma": {"$eq": "pt"}}}
)

# Criar chain RAG
prompt = ChatPromptTemplate.from_template("""
Contexto:
{context}

Pergunta: {pergunta}

Responda em português baseando-se no contexto.""")

def format_docs(docs):
    return "\n\n".join(d.page_content for d in docs)

chain = (
    {"context": retriever | format_docs, "pergunta": RunnablePassthrough()}
    | prompt
    | ChatOpenAI(model="gpt-4")
    | StrOutputParser()
)

resposta = chain.invoke("O que é Pinecone?")
```

## 11. Integração com LlamaIndex

```python
from llama_index.vector_stores.pinecone import PineconeVectorStore
from llama_index.core import VectorStoreIndex, StorageContext

# Conectar ao Pinecone
vector_store = PineconeVectorStore(
    index_name="documentos-llama",
    namespace="producao"
)

# Criar índice
storage_context = StorageContext.from_defaults(vector_store=vector_store)
index = VectorStoreIndex.from_vector_store(
    vector_store=vector_store,
    storage_context=storage_context
)

# Query
query_engine = index.as_query_engine(
    similarity_top_k=5,
    filters={"categoria": {"$eq": "técnico"}}
)

resposta = query_engine.query("Como funciona embedding?")
print(resposta)
```

## 12. Backup e Restore

```python
from pinecone import Pinecone

pc = Pinecone(api_key="sua-chave")

# Listar backups
backups = pc.list_backups()
for backup in backups:
    print(f"  {backup.name} — Status: {backup.status}")

# Criar backup de um index
backup = pc.create_backup(
    index_name="documentos-producao",
    backup_name="backup-2025-01-15"
)

# Restaurar de backup
pc.restore_backup(
    backup_name="backup-2025-01-15",
    index_name="documentos-restaurado"
)
```

## 13. Escala e Performance

```python
from pinecone import Pinecone

pc = Pinecone(api_key="sua-chave")

# Verificar status do index
stats = pc.Index("producao").describe_index_stats()
print(f"Total vetores: {stats.total_vector_count}")
print(f"Dimensão: {stats.dimension}")

# Configurar escala automática (serverless)
# Útil para tráfego variável

# Para pods — escalar horizontalmente
from pinecone import PodSpec

# Recriar com mais pods se necessário
pc.create_index(
    name="producao-escala",
    dimension=1536,
    metric="cosine",
    spec=PodSpec(
        environment="us-east1-gcp",
        pod_type="s1.x4",  # Tipo maior
        pods=4  # Mais réplicas
    )
)
```

## 14. Gerenciamento de Dados — Update e Delete

```python
from pinecone import Pinecone

pc = Pinecone(api_key="sua-chave")
index = pc.Index("produtos")

# Atualizar metadata (sem mudar o vetor)
index.update(
    id="produto-001",
    metadata={"preco": 6999.90, "em_estoque": False}
)

# Atualizar vetor
index.update(
    id="produto-001",
    values=[0.2, 0.3, 0.4, ...]  # Novo embedding
)

# Delete por ID
index.delete(ids=["produto-001", "produto-002"])

# Delete por filtro
index.delete(filter={"categoria": {"$eq": "descontinuado"}})

# Delete namespace inteiro
index.delete(delete_all=True, namespace="teste")

# Fetch por IDs
fetch_result = index.fetch(ids=["produto-001", "produto-002"])
for id, vetor in fetch_result.vectors.items():
    print(f"  {id}: metadata={vetor.metadata}")
```

## 15. Analytics e Monitoring

```python
from pinecone import Pinecone

pc = Pinecone(api_key="sua-chave")
index = pc.Index("producao")

# Estatísticas do index
stats = index.describe_index_stats()

print(f"Total vetores: {stats.total_vector_count}")
print(f"Dimensão: {stats.dimension}")

# Stats por namespace
for ns, ns_stats in stats.namespaces.items():
    print(f"  Namespace '{ns}': {ns_stats.vector_count} vetores")

# Monitorar latência de queries
import time

vetor_query = [0.1] * 1536

tempos = []
for i in range(10):
    start = time.time()
    index.query(vector=vetor_query, top_k=10)
    elapsed = time.time() - start
    tempos.append(elapsed)
    print(f"  Query {i+1}: {elapsed*1000:.1f}ms")

print(f"\nLatência média: {sum(tempos)/len(tempos)*1000:.1f}ms")
print(f"P95: {sorted(tempos)[int(len(tempos)*0.95)]*1000:.1f}ms")
```

## 16. SDK JavaScript/TypeScript

```javascript
// Instalação: npm install @pinecone-database/pinecone

import { Pinecone } from "@pinecone-database/pinecone";

const pc = new Pinecone({
  apiKey: "sua-chave-api"
});

// Criar index
await pc.createIndex({
  name: "documentos-ts",
  dimension: 1536,
  metric: "cosine",
  spec: {
    serverless: {
      cloud: "aws",
      region: "us-east-1"
    }
  }
});

const index = pc.index("documentos-ts");

// Upsert
await index.upsert([
  {
    id: "doc-001",
    values: Array(1536).fill(0.1),
    metadata: { titulo: "Guia TypeScript", idioma: "pt" }
  }
]);

// Query
const results = await index.query({
  vector: Array(1536).fill(0.1),
  topK: 5,
  includeMetadata: true,
  filter: { idioma: { $eq: "pt" } }
});

results.matches.forEach(match => {
  console.log(`${match.id}: ${match.score} — ${match.metadata.titulo}`);
});
```

## 17. Real-Time Data Ingestion

```python
from pinecone import Pinecone
from langchain_openai import OpenAIEmbeddings
import time

pc = Pinecone(api_key="sua-chave")
index = pc.Index("producao-realtime")
embeddings = OpenAIEmbeddings(model="text-embedding-3-small")

def ingerir_documento(texto: str, doc_id: str, metadata: dict):
    """Ingere um documento em tempo real"""
    # Gerar embedding
    embedding = embeddings.embed_query(texto)
    
    # Upsert imediato
    index.upsert(vectors=[{
        "id": doc_id,
        "values": embedding,
        "metadata": {
            **metadata,
            "texto_preview": texto[:200],
            "data_ingestao": time.strftime("%Y-%m-%d %H:%M:%S")
        }
    }])
    
    print(f"Documento {doc_id} ingerido com sucesso")

# Simular ingestion streaming
documentos = [
    ("Novo produto lançado", "doc-001", {"tipo": "noticia", "prioridade": "alta"}),
    ("Atualização de política", "doc-002", {"tipo": "documento", "prioridade": "media"}),
    ("Relatório trimestral", "doc-003", {"tipo": "relatorio", "prioridade": "alta"}),
]

for texto, doc_id, meta in documentos:
    ingerir_documento(texto, doc_id, meta)
```

## 18. Vetores Esparsos Avançados (BM25-like)

```python
from pinecone import Pinecone

pc = Pinecone(api_key="sua-chave")
index = pc.Index("busca-hibrida")

def gerar_sparse_vector(texto: str, vocabulario: dict) -> dict:
    """Gera sparse vector baseado em TF-IDF-like"""
    palavras = texto.lower().split()
    indices = []
    valores = []
    
    for i, (termo, idx) in enumerate(vocabulario.items()):
        count = palavras.count(termo)
        if count > 0:
            # TF simplificado
            tf = count / len(palavras)
            # IDF placeholder (usar corpus real em produção)
            idf = 1.0
            score = tf * idf
            indices.append(idx)
            valores.append(score)
    
    return {"indices": indices, "values": valores}

# Dicionário de vocabulário (mapear termos para índices)
vocab = {"python": 0, "api": 1, "rest": 2, "fastapi": 3, "django": 4}

# Upsert com sparse
index.upsert(vectors=[{
    "id": "doc-python-api",
    "values": [0.1, ...] * 1536,  # Dense
    "sparse_values": gerar_sparse_vector("Guia de API REST com Python FastAPI", vocab),
    "metadata": {"titulo": "Guia Python API"}
}])
```

## 19. Comparação de Index e Métricas

```python
from pinecone import Pinecone
import numpy as np

pc = Pinecone(api_key="sua-chave")

# Testar diferentes métricas
metricas = ["cosine", "euclidean", "dotproduct"]

for metrica in metricas:
    nome_idx = f"teste-{metrica}"
    
    try:
        pc.create_index(
            name=nome_idx,
            dimension=128,
            metric=metrica,
            spec=ServerlessSpec(cloud="aws", region="us-east-1")
        )
        
        index = pc.Index(nome_idx)
        
        # Inserir dados de teste
        np.random.seed(42)
        vetores = [{
            "id": f"vec-{i}",
            "values": np.random.randn(128).tolist(),
            "metadata": {"classe": i % 3}
        } for i in range(100)]
        
        index.upsert(vetores=vetores)
        
        # Query de teste
        query_vec = np.random.randn(128).tolist()
        results = index.query(vector=query_vec, top_k=5)
        
        print(f"Métrica {metrica}: top score = {results.matches[0].score:.4f}")
        
    except Exception as e:
        print(f"Erro com {metrica}: {e}")
```

## 20. Pipeline Completo de RAG com Pinecone

```python
from langchain_openai import ChatOpenAI, OpenAIEmbeddings
from langchain_pinecone import PineconeVectorStore
from langchain_core.prompts import ChatPromptTemplate
from langchain_core.runnables import RunnablePassthrough
from langchain_core.output_parsers import StrOutputParser
from langchain_text_splitters import RecursiveCharacterTextSplitter
from langchain_community.document_loaders import PyPDFLoader

# 1. Carregar documentos
loader = PyPDFLoader("documentos/base_conhecimento.pdf")
documents = loader.load()

# 2. Splitter
splitter = RecursiveCharacterTextSplitter(
    chunk_size=500,
    chunk_overlap=50,
    separators=["\n\n", "\n", ". ", " "]
)
chunks = splitter.split_documents(documents)

# 3. Embeddings e VectorStore
embeddings = OpenAIEmbeddings(model="text-embedding-3-small")
vectorstore = PineconeVectorStore.from_documents(
    documents=chunks,
    embedding=embeddings,
    index_name="rag-producao",
    namespace="base-conhecimento"
)

# 4. Retriever
retriever = vectorstore.as_retriever(
    search_type="mmr",  # Maximum Marginal Relevance
    search_kwargs={"k": 5, "fetch_k": 20, "lambda_mult": 0.7}
)

# 5. Prompt RAG
prompt = ChatPromptTemplate.from_template("""
Você é um assistente especializado. Use APENAS o contexto fornecido para responder.
Se a resposta não estiver no contexto, diga "Não tenho informações sobre isso."

Contexto:
{context}

Pergunta: {pergunta}

Resposta em português:""")

# 6. Chain completa
def format_docs(docs):
    return "\n\n---\n\n".join(d.page_content for d in docs)

chain = (
    {"context": retriever | format_docs, "pergunta": RunnablePassthrough()}
    | prompt
    | ChatOpenAI(model="gpt-4", temperature=0)
    | StrOutputParser()
)

# 7. Executar
resposta = chain.invoke("Como configurar um index Pinecone?")
print(resposta)
```

---

## 🚨 MELHORIA — Padrões Errados vs Corretos

### ❌ ERRADO: Usar embeddings aleatórios sem dimension check

```python
# Embedding errado — dimensão não bate com o index
embeddings_wrong = OpenAIEmbeddings(model="text-embedding-3-large")  # 3072 dim
index = pc.Index("meu-index-1536")  # Index com 1536 dim

# ERRO: Dimension mismatch!
index.upsert(vectors=[{"id": "x", "values": embeddings_wrong.embed_query("teste")}])
```

### ✅ CORRETO: Garantir consistência de dimensões

```python
embeddings = OpenAIEmbeddings(model="text-embedding-3-small")  # 1536 dim
index = pc.Index("meu-index-1536")  # Index com 1536 dim — compatível!

vetor = embeddings.embed_query("teste")
print(f"Dimensão do vetor: {len(vetor)}")  # 1536

index.upsert(vectors=[{"id": "x", "values": vetor}])
```

---

### ❌ ERRADO: Não usar namespaces em multi-tenant

```python
# Todos os tenants no mesmo namespace
index.upsert(vectors=[
    {"id": "doc-a", "values": v1, "metadata": {"empresa": "A"}},
    {"id": "doc-b", "values": v2, "metadata": {"empresa": "B"}}
])

# Query retorna dados de todas as empresas!
results = index.query(vector=q, top_k=5)
```

### ✅ CORRETO: Namespaces para isolamento

```python
index.upsert(
    namespace="empresa-a",
    vectors=[{"id": "doc-a", "values": v1, "metadata": {"empresa": "A"}}]
)
index.upsert(
    namespace="empresa-b",
    vectors=[{"id": "doc-b", "values": v2, "metadata": {"empresa": "B"}}]
)

# Cada tenant só vê seus dados
results_a = index.query(vector=q, top_k=5, namespace="empresa-a")
results_b = index.query(vector=q, top_k=5, namespace="empresa-b")
```

---

### ❌ ERRADO: Uploading sem batches

```python
# Upload de 100k vetores de uma vez
index.upsert(vectors=vetores_100k)  # Timeout ou rate limit!
```

### ✅ CORRETO: Batches adequados

```python
BATCH_SIZE = 100
for i in range(0, len(vetores_100k), BATCH_SIZE):
    batch = vetores_100k[i:i+BATCH_SIZE]
    index.upsert(vectors=batch)
    time.sleep(0.1)  # Evitar rate limits
```

---

### ❌ ERRADO: Ignorar metadata filtering

```python
# Query sem filtro — retorna tudo
results = index.query(vector=q, top_k=10)
# Se tem 1M de documentos, retorna os 10 mais próximos sem contexto
```

### ✅ CORRETO: Usar filtros para relevância

```python
results = index.query(
    vector=q,
    top_k=10,
    filter={
        "$and": [
            {"idioma": {"$eq": "pt"}},
            {"ativo": {"$eq": True}},
            {"data": {"$gte": "2024-01-01"}}
        ]
    },
    include_metadata=True
)
```

---

### ❌ ERRADO: Não monitorar performance

```python
# Rodar queries sem medir latência
# Se degradar, não saberá quando nem por quê
```

### ✅ CORRETO: Benchmark e monitoring

```python
import time

tempos = []
for _ in range(50):
    start = time.time()
    index.query(vector=q, top_k=10)
    tempos.append(time.time() - start)

p50 = sorted(tempos)[len(tempos)//2]
p99 = sorted(tempos)[int(len(tempos)*0.99)]
print(f"P50: {p50*1000:.1f}ms | P99: {p99*1000:.1f}ms")

if p99 > 0.5:
    print("⚠️ Latência P99 acima de 500ms — considerar otimização!")
```

---

> **Resumo:** Pinecone é a escolha dominante para vetores em produção. Use namespaces para multi-tenancy, sparse-dense para busca híbrida, metadata filtering para relevância, e batches para ingestion em larga escala. Sempre monitore latência e custos, e versione seus dados com backups regulares.