# 🐍 LangChain — Habilidades Avançadas para Construção de Aplicações com LLMs

**Fonte:** https://github.com/langchain-ai/langchain  
**Descrição:** Framework mais popular para criar aplicações potencializadas por LLMs — chains, agentes, memória, RAG, LangGraph, LCEL e muito mais.

---

## 📚 Índice de Categorias

1. [Chains e Composição](#1-chains-e-composição)
2. [LCEL — LangChain Expression Language](#2-lcel---langchain-expression-language)
3. [Agentes e Tool Calling](#3-agentes-e-tool-calling)
4. [Memória e Estado](#4-memória-e-estado)
5. [Document Loaders](#5-document-loaders)
6. [Text Splitters e Chunking](#6-text-splitters-e-chunking)
7. [Vector Stores](#7-vector-stores)
8. [Embeddings](#8-embeddings)
9. [Retrievers Avançados](#9-retrievers-avançados)
10. [RAG — Retrieval-Augmented Generation](#10-rag---retrieval-augmented-generation)
11. [Output Parsers](#11-output-parsers)
12. [Callbacks e Streaming](#12-callbacks-e-streaming)
13. [Avaliação de LLMs](#13-avaliação-de-llms)
14. LangSmith — Tracing e Monitoramento
15. LangGraph — Máquinas de Estado e Multi-Agentes
16. [Integrações e Tools](#16-integrações-e-tools)
17. [Tratamento de Erros e Resiliência](#17-tratamento-de-erros-e-resiliência)
18. [Otimização de Custos e Performance](#18-otimização-de-custos-e-performance)
19. [Padrões de Projeto com LangChain](#19-padrões-de-projeto-com-langchain)
20. [Deploy e Produção](#20-deploy-e-produção)

---

## 1. Chains e Composição

### 1.1 LLMChain Simples
```python
from langchain.chains import LLMChain
from langchain.prompts import PromptTemplate
from langchain_openai import ChatOpenAI

llm = ChatOpenAI(model="gpt-4o", temperature=0)
prompt = PromptTemplate.from_template(
    "Explique {topico} para um iniciante em 3 parágrafos."
)
chain = LLMChain(llm=llm, prompt=prompt, verbose=True)
resultado = chain.invoke({"topico": "transformers"})
print(resultado["text"])
```

> **❌ ERRADO:** Usar `LLMChain` sem `verbose=True` em desenvolvimento — fica difícil depurar.  
> **✅ CORRETO:** Sempre ativar `verbose=True` durante desenvolvimento e desativar em produção.

### 1.2 SequentialChain
```python
from langchain.chains import SequentialChain

chain_explain = LLMChain(llm=llm, prompt=PromptTemplate.from_template(
    "Explique brevemente: {assunto}"
), output_key="explicacao")

chain_quiz = LLMChain(llm=llm, prompt=PromptTemplate.from_template(
    "Crie 3 perguntas sobre: {explicacao}"
), output_key="quiz")

sequencial = SequentialChain(
    chains=[chain_explain, chain_quiz],
    input_variables=["assunto"],
    output_variables=["explicacao", "quiz"],
    verbose=True
)
resultado = sequencial.invoke({"assunto": "redes neurais"})
```

### 1.3 TransformChain
```python
from langchain.chains import TransformChain

def formatar_texto(inputs: dict) -> dict:
    texto = inputs["texto_bruto"]
    texto_limpo = " ".join(texto.split()).lower()
    return {"texto_formatado": texto_limpo}

chain = TransformChain(
    func=formatar_texto,
    input_variables=["texto_bruto"],
    output_variables=["texto_formatado"]
)
resultado = chain.invoke({"texto_bruto": "  Olá   Mundo   "})
print(resultado["texto_formatado"])  # "olá mundo"
```

---

## 2. LCEL — LangChain Expression Language

### 2.1 Pipeline Básico com Pipe
```python
from langchain_openai import ChatOpenAI
from langchain.prompts import ChatPromptTemplate
from langchain_core.output_parsers import StrOutputParser

prompt = ChatPromptTemplate.from_template(
    "Escreva uma história curta sobre {tema}."
)
llm = ChatOpenAI(model="gpt-4o")

# Composição com pipe (|)
chain = prompt | llm | StrOutputParser()
resultado = chain.invoke({"tema": "um robô solitário"})
print(resultado)
```

### 2.2 Composição Paralela com RunnableParallel
```python
from langchain_core.runnables import RunnableParallel

resumo_chain = ChatPromptTemplate.from_template("Resuma: {texto}") | llm | StrOutputParser()
pontos_chain = ChatPromptTemplate.from_template("Liste pontos-chave: {texto}") | llm | StrOutputParser()

parallel = RunnableParallel(resumo=resumo_chain, pontos=pontos_chain)
resultado = parallel.invoke({"texto": "Texto longo sobre IA..."})
print(resultado["resumo"])
print(resultado["pontos"])
```

> **❌ ERRADO:** Encadear许多 `|` sem organizar em `RunnableParallel` — código fica confuso.  
> **✅ CORRETO:** Usar `RunnableParallel` para operações independentes.

### 2.3 RunnableLambda para Lógica Customizada
```python
from langchain_core.runnables import RunnableLambda

def contar_palavras(texto: dict) -> dict:
    return {
        "texto": texto["texto"],
        "contagem": len(texto["texto"].split())
    }

chain = (
    ChatPromptTemplate.from_template("Analise: {texto}")
    | llm
    | StrOutputParser()
    | RunnableLambda(contar_palavras)
)
resultado = chain.invoke({"texto": "LangChain é incrível"})
print(f"Texto: {resultado['texto']}\nPalavras: {resultado['contagem']}")
```

### 2.4 Com Compat e Retries
```python
from langchain_core.runnables import RunnableConfig

chain = prompt | llm | StrOutputParser()
config = RunnableConfig(
    max_concurrency=5,
    tags=["producao", "v2"],
    metadata={"usuario_id": "12345"}
)
resultado = chain.invoke({"tema": "LLMs"}, config=config)
```

---

## 3. Agentes e Tool Calling

### 3.1 Agente ReAct com Tools
```python
from langchain.agents import create_tool_calling_agent, AgentExecutor
from langchain.tools import Tool
from langchain_community.tools import WikipediaQueryRun
from langchain_community.utilities import WikipediaAPIWrapper

wiki_tool = WikipediaQueryRun(
    api_wrapper=WikipediaAPIWrapper(top_k_results=2, load_all_available_meta=True)
)

calculator = Tool(
    name="calculadora",
    func=lambda x: str(eval(x)),
    description="Calcule expressões matemáticas"
)

tools = [wiki_tool, calculator]
agent = create_tool_calling_agent(llm, tools, ChatPromptTemplate.from_template(
    "{input}\n\nUse as ferramentas disponíveis para responder."
))
executor = AgentExecutor(agent=agent, tools=tools, verbose=True, max_iterations=5)
resultado = executor.invoke({"input": "Qual é a capital da França e 2+2?"})
```

### 3.2 Tool Calling Nativo do OpenAI
```python
from langchain_core.tools import tool
from langchain_openai import ChatOpenAI

@tool
def buscar_clima(cidade: str) -> str:
    """Retorna o clima atual de uma cidade."""
    return f"Clima em {cidade}: 22°C, ensolarado"

llm = ChatOpenAI(model="gpt-4o").bind_tools([buscar_clima])
resultado = llm.invoke("Como está o clima em Paris?")
print(resultado.tool_calls)
```

> **❌ ERRADO:** Não documentar a `description` da tool — o LLM não sabe quando usar.  
> **✅ CORRETO:** Sempre escrever descrições claras e específicas para cada tool.

### 3.3 Multi-Agent com LangGraph
```python
from langgraph.prebuilt import create_react_agent

agent = create_react_agent(
    llm,
    tools=[wiki_tool, calculator],
    prompt="Você é um assistente especializado em pesquisa e cálculos."
)
resultado = agent.invoke({"messages": [("human", "PI ao quadrado?")]})
print(resultado["messages"][-1].content)
```

---

## 4. Memória e Estado

### 4.1 ConversationBufferMemory
```python
from langchain.memory import ConversationBufferMemory
from langchain.chains import ConversationChain

memory = ConversationBufferMemory(return_messages=True)
conversation = ConversationChain(llm=llm, memory=memory, verbose=True)

conversation.predict(input="Olá, meu nome é Carlos!")
conversation.predict(input="Qual é o meu nome?")
print(conversation.predict(input="Como você me chama?"))
```

### 4.2 ConversationSummaryMemory
```python
from langchain.memory import ConversationSummaryMemory

summary_memory = ConversationSummaryMemory(llm=llm)
conversation = ConversationChain(llm=llm, memory=summary_memory, verbose=True)

for pergunta in ["Fale sobre Python", "E sobre JavaScript?", "Compare os dois"]:
    conversation.predict(input=pergunta)

print(summary_memory.buffer)
```

### 4.3 VectorStoreRetrieverMemory
```python
from langchain.memory import VectorStoreRetrieverMemory
from langchain_chroma import Chroma
from langchain_openai import OpenAIEmbeddings

vectorstore = Chroma(embedding_function=OpenAIEmbeddings())
retriever = vectorstore.as_retriever(search_kwargs={"k": 3})
vector_memory = VectorStoreRetrieverMemory(retriever=retriever)

vector_memory.save_context(
    {"input": "Prefiro Python para ML"},
    {"output": "Entendido, você gosta de Python para machine learning."}
)
resultado = vector_memory.load_memory_variables({"input": "minhas preferências"})
print(resultado["history"])
```

> **❌ ERRADO:** Usar `ConversationBufferMemory` em conversas longas — estoura o contexto.  
> **✅ CORRETO:** Usar `ConversationSummaryMemory` ou `VectorStoreRetrieverMemory` para conversas longas.

### 4.4 Combinando Múltiplas Memórias
```python
from langchain.memory import CombinedMemory

buffer_memory = ConversationBufferMemory(memory_key="chat_history", input_key="input")
summary_memory = ConversationSummaryMemory(llm=llm, memory_key="summary", input_key="input")

combined = CombinedMemory(memories=[buffer_memory, summary_memory])
chain = ConversationChain(llm=llm, memory=combined, verbose=True)
```

---

## 5. Document Loaders

### 5.1 Carregamento de PDF
```python
from langchain_community.document_loaders import PyPDFLoader, DirectoryLoader

loader = DirectoryLoader("./documentos/", glob="**/*.pdf", loader_cls=PyPDFLoader)
docs = loader.load()
print(f"Total de páginas: {len(docs)}")
print(docs[0].page_content[:200])
print(docs[0].metadata)
```

### 5.2 Carregamento Web
```python
from langchain_community.document_loaders import WebBaseLoader

loader = WebBaseLoader("https://python.langchain.com/docs/")
docs = loader.load()
print(f"Documentos carregados: {len(docs)}")
print(docs[0].page_content[:500])
```

### 5.3 Carregamento de CSV
```python
from langchain_community.document_loaders import CSVLoader

loader = CSVLoader(file_path="./dados.csv", encoding="utf-8", csv_args={"delimiter": ";"})
docs = loader.load()
for doc in docs[:3]:
    print(doc.page_content)
```

### 5.4 Carregamento de Banco de Dados
```python
from langchain_community.document_loaders import SQLDatabaseLoader
from langchain_community.utilities import SQLDatabase

db = SQLDatabase.from_uri("sqlite:///./meubanco.db")
loader = SQLDatabaseLoader(db=db, query="SELECT * FROM usuarios LIMIT 10")
docs = loader.load()
```

> **❌ ERRADO:** Carregar documentos inteiros sem chunking — sobrecarrega a memória do LLM.  
> **✅ CORRETO:** Sempre aplicar `TextSplitter` após carregar documentos.

---

## 6. Text Splitters e Chunking

### 6.1 RecursiveCharacterTextSplitter
```python
from langchain.text_splitter import RecursiveCharacterTextSplitter

splitter = RecursiveCharacterTextSplitter(
    chunk_size=1000,
    chunk_overlap=200,
    length_function=len,
    separators=["\n\n", "\n", ". ", " ", ""]
)
chunks = splitter.split_documents(docs)
print(f"Chunks criados: {len(chunks)}")
print(f"Primeiro chunk: {chunks[0].page_content[:200]}")
```

### 6.2 SemanticChunker
```python
from langchain_experimental.text_splitter import SemanticChunker
from langchain_openai import OpenAIEmbeddings

semantic_splitter = SemanticChunker(
    OpenAIEmbeddings(),
    breakpoint_threshold_type="percentile",
    breakpoint_threshold_amount=85
)
chunks = semantic_splitter.split_documents(docs)
print(f"Chunks semânticos: {len(chunks)}")
```

### 6.3 TokenTextSplitter
```python
from langchain.text_splitter import TokenTextSplitter

token_splitter = TokenTextSplitter(
    encoding_name="cl100k_base",
    chunk_size=500,
    chunk_overlap=50
)
chunks = token_splitter.split_documents(docs)
```

> **❌ ERRADO:** `chunk_size` muito grande (>2000 tokens) — perde contexto e custa caro.  
> **✅ CORRETO:** `chunk_size` entre 500-1000 tokens com `chunk_overlap` de 10-20%.

---

## 7. Vector Stores

### 7.1 Chroma
```python
from langchain_chroma import Chroma
from langchain_openai import OpenAIEmbeddings

vectorstore = Chroma.from_documents(
    documents=chunks,
    embedding=OpenAIEmbeddings(),
    persist_directory="./chroma_db",
    collection_name="meus_docs"
)
retriever = vectorstore.as_retriever(search_type="similarity", search_kwargs={"k": 5})
```

### 7.2 FAISS
```python
from langchain_community.vectorstores import FAISS

vectorstore = FAISS.from_documents(chunks, OpenAIEmbeddings())
vectorstore.save_local("./faiss_index")

vectorstore_loaded = FAISS.load_local("./faiss_index", OpenAIEmbeddings())
retriever = vectorstore_loaded.as_retriever(search_kwargs={"k": 3})
```

### 7.3 Pinecone
```python
from langchain_community.vectorstores import Pinecone
from pinecone import Pinecone

pc = Pinecone(api_key="YOUR_API_KEY")
index = pc.Index("meu-index")

vectorstore = Pinecone.from_documents(
    chunks, OpenAIEmbeddings(), index_name="meu-index"
)
retriever = vectorstore.as_retriever(search_kwargs={"k": 5})
```

### 7.4 Qdrant
```python
from langchain_community.vectorstores import Qdrant

vectorstore = Qdrant.from_documents(
    chunks,
    OpenAIEmbeddings(),
    url="http://localhost:6333",
    collection_name="meus_documentos"
)
```

> **❌ ERRADO:** Não configurar `search_kwargs` no retriever — retorna muitos ou poucos resultados.  
> **✅ CORRETO:** Ajustar `k` conforme a necessidade e usar `search_type` adequado.

---

## 8. Embeddings

### 8.1 OpenAI Embeddings
```python
from langchain_openai import OpenAIEmbeddings

embeddings = OpenAIEmbeddings(model="text-embedding-3-large")
vector = embeddings.embed_query("LangChain é um framework poderoso")
print(f"Dimensão: {len(vector)}")
```

### 8.2 HuggingFace Embeddings
```python
from langchain_huggingface import HuggingFaceEmbeddings

embeddings = HuggingFaceEmbeddings(
    model_name="BAAI/bge-large-en-v1.5",
    model_kwargs={"device": "cuda"},
    encode_kwargs={"normalize_embeddings": True}
)
vector = embeddings.embed_query("Embeddings locais sem API")
```

### 8.3 Cohere Embeddings
```python
from langchain_cohere import CohereEmbeddings

embeddings = CohereEmbeddings(model="embed-english-v3.0")
vector = embeddings.embed_query("Embeddings com Cohere")
```

> **❌ ERRADO:** Trocar modelos de embeddings em um pipeline já construído — vets ficam inconsistentes.  
> **✅ CORRETO:** Manter o mesmo modelo de embeddings em todo o pipeline.

---

## 9. Retrievers Avançados

### 9.1 ContextualCompressionRetriever
```python
from langchain.retrievers import ContextualCompressionRetriever
from langchain.retrievers.document_compressors import LLMChainExtractor

compressor = LLMChainExtractor.from_llm(llm)
compression_retriever = ContextualCompressionRetriever(
    base_compressor=compressor,
    base_retriever=vectorstore.as_retriever(search_kwargs={"k": 10})
)
docs_comprimidos = compression_retriever.invoke("O que é LangChain?")
print(f"Docs originais: 10 → Comprimidos: {len(docs_comprimidos)}")
```

### 9.2 MultiQueryRetriever
```python
from langchain.retrievers import MultiQueryRetriever

multi_query_retriever = MultiQueryRetriever.from_llm(
    retriever=vectorstore.as_retriever(),
    llm=llm
)
docs = multi_query_retriever.invoke("Avanços recentes em IA")
print(f"Documentos únicos recuperados: {len(docs)}")
```

### 9.3 SelfQueryRetriever
```python
from langchain.retrievers import SelfQueryRetriever
from langchain.chains.query_constructor.base import AttributeInfo

metadata_info = [
    FonteInfo(name="fonte", description="Fonte do documento", type="string"),
    FonteInfo(name="data", description="Data de publicação", type="string"),
    FonteInfo(name="autor", description="Autor do documento", type="string"),
]

self_query_retriever = SelfQueryRetriever.from_llm(
    llm=llm,
    vectorstore=vectorstore,
    document_contents="Documentos sobre IA",
    metadata_field_info=metadata_info,
    verbose=True
)
docs = self_query_retriever.invoke("Artigos de 2024 sobre transformers")
```

> **❌ ERRADO:** Usar `SelfQueryRetriever` sem definir `AttributeInfo` corretamente.  
> **✅ CORRETO:** Mapear todos os metadados do vectorstore com tipos corretos.

---

## 10. RAG — Retrieval-Augmented Generation

### 10.1 RAG Básico
```python
from langchain.chains import RetrievalQA

qa_chain = RetrievalQA.from_chain_type(
    llm=llm,
    chain_type="stuff",
    retriever=vectorstore.as_retriever(search_kwargs={"k": 4}),
    return_source_documents=True,
    verbose=True
)
resultado = qa_chain.invoke({"query": "O que é LangGraph?"})
print(resultado["result"])
print(f"Fontes: {len(resultado['source_documents'])}")
```

### 10.2 RAG com LCEL
```python
from langchain_core.prompts import ChatPromptTemplate
from langchain_core.runnables import RunnablePassthrough
from langchain_core.output_parsers import StrOutputParser

template = """Responda usando APENAS o contexto abaixo:
{context}

Pergunta: {question}"""

prompt = ChatPromptTemplate.from_template(template)
rag_chain = (
    {"context": vectorstore.as_retriever(search_kwargs={"k": 4}), "question": RunnablePassthrough()}
    | prompt
    | llm
    | StrOutputParser()
)
print(rag_chain.invoke("Explique LangChain Expression Language"))
```

### 10.3 RAG com Reranking
```python
from langchain.retrievers import ContextualCompressionRetriever
from langchain.retrievers.document_compressors import CohereRerank

compressor = CohereRerank(model="rerank-v3.5", top_n=3)
rerank_retriever = ContextualCompressionRetriever(
    base_compressor=compressor,
    base_retriever=vectorstore.as_retriever(search_kwargs={"k": 10})
)

qa_chain = RetrievalQA.from_chain_type(
    llm=llm, retriever=rerank_retriever, return_source_documents=True
)
```

> **❌ ERRADO:** RAG sem `return_source_documents=True` — não dá para verificar respostas.  
> **✅ CORRETO:** Sempre retornar documentos fonte para auditoria e verificação.

---

## 11. Output Parsers

### 11.1 PydanticOutputParser
```python
from langchain_core.output_parsers import PydanticOutputParser
from pydantic import BaseModel, Field

class RespostaAnalise(BaseModel):
    tema: str = Field(description="Tema principal analisado")
    pontos_positivos: list[str] = Field(description="Pontos positivos")
    pontos_negativos: list[str] = Field(description="Pontos negativos")
    nota: float = Field(description="Nota de 0 a 10")

parser = PydanticOutputParser(pydantic_object=RespostaAnalise)
prompt = ChatPromptTemplate.from_template(
    "Analise o tema: {tema}\n\n{format_instructions}"
)
chain = prompt | llm | parser
resultado = chain.invoke({
    "tema": "Inteligência Artificial",
    "format_instructions": parser.get_format_instructions()
})
print(f"Tema: {resultado.tema}, Nota: {resultado.nota}")
```

### 11.2 JsonOutputFunctionsParser
```python
from langchain_core.output_parsers import JsonOutputFunctionsParser

llm_com_funcao = llm.bind.functions([{
    "name": "extrair_info",
    "description": "Extrai informações do texto",
    "parameters": {
        "type": "object",
        "properties": {
            "nome": {"type": "string"},
            "idade": {"type": "integer"},
            "habilidades": {"type": "array", "items": {"type": "string"}}
        }
    }
}])

parser = JsonOutputFunctionsParser()
chain = ChatPromptTemplate.from_template("Extraia: {texto}") | llm_com_funcao | parser
resultado = chain.invoke({"texto": "Maria tem 30 anos e sabe Python, JS"})
print(resultado)
```

### 11.3 CommaSeparatedListOutputParser
```python
from langchain.output_parsers import CommaSeparatedListOutputParser

parser = CommaSeparatedListOutputParser()
prompt = ChatPromptTemplate.from_template(
    "Liste 5 {assunto}.\n{format_instructions}"
)
chain = prompt | llm | parser
resultado = chain.invoke({
    "assunto": "frameworks de Python",
    "format_instructions": parser.get_format_instructions()
})
print(resultado)  # ['Django', 'Flask', 'FastAPI', 'Pyramid', 'Bottle']
```

> **❌ ERRADO:** Não usar `get_format_instructions()` — o LLM não sabe o formato esperado.  
> **✅ CORRETO:** Sempre incluir as instruções de formato no prompt.

---

## 12. Callbacks e Streaming

### 12.1 Streaming de Tokens
```python
from langchain_openai import ChatOpenAI

llm = ChatOpenAI(model="gpt-4o", streaming=True)
prompt = ChatPromptTemplate.from_template("Escreva um poema sobre {tema}")

async def stream_poema():
    async for chunk in (prompt | llm).astream({"tema": "lua"}):
        print(chunk.content, end="", flush=True)

import asyncio
asyncio.run(stream_poema())
```

### 12.2 Callback Handler Customizado
```python
from langchain_core.callbacks import BaseCallbackHandler
import time

class TempoHandler(BaseCallbackHandler):
    def __init__(self):
        self.start_time = None
        self.tokens = 0

    def on_llm_start(self, serialized, prompts, **kwargs):
        self.start_time = time.time()
        print(f"🤖 Iniciando geração...")

    def on_llm_end(self, response, **kwargs):
        elapsed = time.time() - self.start_time
        print(f"✅ Concluído em {elapsed:.2f}s")

    def on_llm_new_token(self, token, **kwargs):
        self.tokens += 1

handler = TempoHandler()
llm = ChatOpenAI(model="gpt-4o", callbacks=[handler])
llm.invoke("Explique quantum computing")
print(f"Total de tokens: {handler.tokens}")
```

### 12.3 Token Counting
```python
from langchain.callbacks import get_openai_callback

with get_openai_callback() as cb:
    resultado = (prompt | llm).invoke({"tema": "宇宙"})
    print(f"Tokens: {cb.total_tokens}")
    print(f"Custo: ${cb.total_cost:.6f}")
```

> **❌ ERRADO:** Não usar callbacks em produção — fica impossível monitorar custos.  
> **✅ CORRETO:** Sempre registrar tokens e custos via callbacks em produção.

---

## 13. Avaliação de LLMs

### 13.1 Avaliação com Embedding Distance
```python
from langchain.evaluation import load_evaluator
from langchain.evaluation.embedding_distance import EmbeddingDistanceEvaluator

evaluator = load_evaluator("embedding_distance")
resultado = evaluator.evaluate_strings(
    prediction="Paris é a capital da França",
    reference="A capital da França é Paris"
)
print(f"Score: {resultado['score']}")
```

### 13.2 Avaliação de String (Exact Match)
```python
from langchain.evaluation import load_evaluator

evaluator = load_evaluator("string_distance", metric="exact_match")
resultado = evaluator.evaluate_strings(
    prediction="Python",
    reference="Python"
)
print(f"Match: {resultado['value']}")
```

### 13.3 QA Chain para Avaliação
```python
from langchain.evaluation import QAEvalChain

qa_eval = QAEvalChain.from_llm(llm)
evaluacao = qa_eval.evaluate([
    {"query": "Capital da França?", "result": "Paris", "answer": "Paris"},
    {"query": "Capital do Japão?", "result": "Tóquio", "answer": "Osaka"}
])
for e in evaluacao:
    print(f"Resultado: {e['results']}")
```

---

## 14. LangSmith — Tracing e Monitoramento

### 14.1 Configuração Básica
```python
import os
os.environ["LANGCHAIN_TRACING_V2"] = "true"
os.environ["LANGCHAIN_API_KEY"] = "YOUR_LANGSMITH_KEY"
os.environ["LANGCHAIN_PROJECT"] = "meu-projeto"

# Agora todas as chains serão rastreadas automaticamente
resultado = (prompt | llm).invoke({"tema": "Python"})
```

### 14.2 Runs com Metadados Customizados
```python
from langchain_core.runnables import RunnableConfig

config = RunnableConfig(
    tags=["v2.1", "produção"],
    metadata={"usuario_id": "user_123", "ambiente": "staging"},
    run_name="analise_customizada"
)
resultado = chain.invoke({"input": "teste"}, config=config)
```

> **❌ ERRADO:** Não configurar `LANGCHAIN_PROJECT` — traces ficam desorganizados.  
> **✅ CORRETO:** Usar projetos separados para dev, staging e produção.

---

## 15. LangGraph — Máquinas de Estado e Multi-Agentes

### 15.1 Grafo Básico com Estado
```python
from langgraph.graph import StateGraph, MessagesState, START, END
from langchain_core.messages import HumanMessage, AIMessage

def node_pesquisa(state: MessagesState):
    return {"messages": [AIMessage(content="Pesquisando...")]}

def node_analise(state: MessagesState):
    return {"messages": [AIMessage(content="Analisando resultados...")]}

graph = StateGraph(MessagesState)
graph.add_node("pesquisa", node_pesquisa)
graph.add_node("analise", node_analise)
graph.add_edge(START, "pesquisa")
graph.add_edge("pesquisa", "analise")
graph.add_edge("analise", END)

app = graph.compile()
resultado = app.invoke({"messages": [HumanMessage(content="Analise mercados")]})
```

### 15.2 Multi-Agent Orchestration
```python
from langgraph.prebuilt import create_react_agent

pesquisador = create_react_agent(llm, tools=[wiki_tool], prompt="Pesquise informações")
analista = create_react_agent(llm, tools=[calculator], prompt="Analise dados")

from langgraph.graph import StateGraph

class EstadoMultiAgentes(TypedDict):
    messages: Annotated[list, add_messages]
    proximo_agente: str

def roteador(state):
    return state["proximo_agente"]

graph = StateGraph(EstadoMultiAgentes)
graph.add_node("pesquisador", pesquisador)
graph.add_node("analista", analista)
graph.add_conditional_edges(START, roteador, {
    "pesquisador": "pesquisador",
    "analista": "analista"
})
graph.add_edge("pesquisador", "analista")
graph.add_edge("analista", END)
```

### 15.3 Persistência de Estado
```python
from langgraph.checkpoint.memory import MemorySaver

memory = MemorySaver()
app = graph.compile(checkpointer=memory)
config = {"configurable": {"thread_id": "conversa_1"}}

resultado = app.invoke(
    {"messages": [HumanMessage(content="Olá!")]},
    config=config
)
```

> **❌ ERRADO:** Não usar `checkpointer` — estado se perde entre invocações.  
> **✅ CORRETO:** Sempre configurar persistência em aplicações multi-turno.

---

## 16. Integrações e Tools

### 16.1 WebSearchTool
```python
from langchain_community.tools.tavily_search import TavilySearchResults

search_tool = TavilySearchResults(max_results=3)
resultado = search_tool.invoke("Últimas notícias sobre IA generativa 2024")
for r in resultado:
    print(f"📎 {r['title']}\n{r['url']}\n")
```

### 16.2 Calculator Tool
```python
from langchain_community.utilities import WikipediaAPIWrapper

wiki = WikipediaAPIWrapper(top_k_results=2)
resultado = wiki.run("Large Language Model")
print(resultado[:500])
```

### 16.3 Code Interpreter Tool
```python
from langchain_experimental.tools import PythonREPLTool

python_tool = PythonREPLTool()
resultado = python_tool.invoke("import pandas as pd; print(pd.__version__)")
print(resultado)
```

> **❌ ERRADO:** Usar `PythonREPLTool` em produção sem sandbox — risco de segurança.  
> **✅ CORRETO:** Usar apenas em ambientes controlados com Docker/sandbox.

---

## 17. Tratamento de Erros e Resiliência

### 17.1 Retry com Exponential Backoff
```python
from langchain_community.callbacks import get_openai_callback
from tenacity import retry, stop_after_attempt, wait_exponential

@retry(stop=stop_after_attempt(3), wait=wait_exponential(multiplier=1, min=4, max=10))
def invocar_com_retry(chain, input_data):
    return chain.invoke(input_data)

try:
    resultado = invocar_com_retry(chain, {"input": "teste"})
except Exception as e:
    print(f"Falhou após 3 tentativas: {e}")
```

### 17.2 Fallback para Outro Modelo
```python
from langchain_openai import ChatOpenAI

llm_primario = ChatOpenAI(model="gpt-4o", max_retries=2)
llm_fallback = ChatOpenAI(model="gpt-4o-mini")

chain_com_fallback = prompt | llm_primario.with_fallbacks([llm_fallback]) | StrOutputParser()
```

### 17.3 Output Parsing com Fallback
```python
from langchain_core.output_parsers import JsonOutputParser

parser = JsonOutputParser()
chain_com_fallback = (
    prompt | llm | parser.with_fallbacks([StrOutputParser()])
)
```

> **❌ ERRADO:** Não ter fallback — se o modelo principal falhar, a app inteira quebra.  
> **✅ CORRETO:** Configurar fallbacks para modelos menores e parsers alternativos.

---

## 18. Otimização de Custos e Performance

### 18.1 Cache de Respostas
```python
from langchain_openai import ChatOpenAI
from langchain.cache import SQLiteCache
import langchain

langchain.llm_cache = SQLiteCache(database_path=".langchain.db")

# Respostas idênticas serão cacheadas automaticamente
llm = ChatOpenAI(model="gpt-4o")
resultado1 = llm.invoke("O que é Python?")  # Custo: API call
resultado2 = llm.invoke("O que é Python?")  # Custo: 0 (cache hit)
```

### 18.2 Batch Processing
```python
from langchain_core.runnables import RunnableParallel

chain = prompt | llm | StrOutputParser()

# Processar múltiplas requisições em batch
temas = ["Python", "JavaScript", "Rust", "Go"]
resultados = chain.batch([{"tema": t} for t in temas], max_concurrency=3)
for t, r in zip(temas, resultados):
    print(f"{t}: {r[:50]}...")
```

### 18.3 Reduzir Custo com Modelos Menores
```python
# Usar modelo grande apenas para tarefas críticas
llm_grande = ChatOpenAI(model="gpt-4o")       # Para análises complexas
llm_pequeno = ChatOpenAI(model="gpt-4o-mini") # Para tarefas simples

chain_resumo = ChatPromptTemplate.from_template("Resuma: {texto}") | llm_pequeno
chain_analise = ChatPromptTemplate.from_template("Analise detalhadamente: {texto}") | llm_grande
```

> **❌ ERRADO:** Usar `gpt-4o` para todas as tarefas — desperdiça dinheiro.  
> **✅ CORRETO:** Classificar tarefas por complexidade e usar o modelo adequado.

---

## 19. Padrões de Projeto com LangChain

### 19.1 Router Chain
```python
from langchain.chains import MultiPromptChain, LLMRouterChain

prompt_infos = [
    {
        "name": "fisica",
        "description": "Perguntas sobre física",
        "prompt_template": "Responda como físico: {input}"
    },
    {
        "name": "historia",
        "description": "Perguntas sobre história",
        "prompt_template": "Responda como historiador: {input}"
    }
]

destinations = [f"{p['name']}: {p['description']}" for p in prompt_infos]
dest_str = "\n".join(destinations)

router_template = f"""Dada a entrada do usuário, escolha o melhor destino:
{dest_str}}

Entrada do usuário: {{input}}"""

router_prompt = PromptTemplate.from_template(router_template)
router_chain = LLMRouterChain.from_llm(llm, router_prompt)
```

### 19.2 Chain com Validação
```python
from pydantic import BaseModel, validator

class InputValidado(BaseModel):
    texto: str
    
    @validator("texto")
    def texto_nao_vazio(cls, v):
        if not v.strip():
            raise ValueError("Texto não pode ser vazio")
        if len(v) < 10:
            raise ValueError("Texto muito curto (min 10 caracteres)")
        return v

def validar_e_processar(inputs: dict) -> dict:
    validated = InputValidado(**inputs)
    return {"texto_validado": validated.texto.upper()}

chain_validada = RunnableLambda(validar_e_processar) | prompt | llm
```

### 19.3 Pattern: Human-in-the-Loop
```python
from langgraph.graph import StateGraph, END

def node_gerar_resposta(state):
    return {"resposta_llm": "Resposta gerada"}

def node_aprovacao(state):
    # Pausa para aprovação humana
    print(f"Resposta para aprovação: {state['resposta_llm']}")
    aprovado = input("Aprovar? (s/n): ") == "s"
    return {"aprovado": aprovado}

def node_publicar(state):
    if state.get("aprovado"):
        return {"status": "publicado"}
    return {"status": "rejeitado"}

graph = StateGraph(dict)
graph.add_node("gerar", node_gerar_resposta)
graph.add_node("aprovar", node_aprovacao)
graph.add_node("publicar", node_publicar)
graph.add_edge("gerar", "aprovar")
graph.add_edge("aprovar", "publicar")
```

---

## 20. Deploy e Produção

### 20.1 FastAPI com LangChain
```python
from fastapi import FastAPI
from pydantic import BaseModel

app = FastAPI()

class QueryRequest(BaseModel):
    pergunta: str

class QueryResponse(BaseModel):
    resposta: str
    tokens: int
    custo: float

@app.post("/perguntar", response_model=QueryResponse)
async def perguntar(req: QueryRequest):
    with get_openai_callback() as cb:
        resposta = rag_chain.invoke(req.pergunta)
        return QueryResponse(
            resposta=resposta,
            tokens=cb.total_tokens,
            custo=cb.total_cost
        )
```

### 20.2 LangServe
```python
from langserve import add_routes
from fastapi import FastAPI

app = FastAPI(title="Meu LangChain API")
add_routes(app, rag_chain, path="/chain")

# Rota disponível em: http://localhost:8000/chain/playground
```

### 20.3 Monitoramento com LangSmith
```python
import os
os.environ["LANGCHAIN_TRACING_V2"] = "true"
os.environ["LANGCHAIN_API_KEY"] = os.getenv("LANGSMITH_KEY")
os.environ["LANGCHAIN_PROJECT"] = "produção-v1"
os.environ["LANGCHAIN_ENDPOINT"] = "https://api.smith.langchain.com"
```

> **❌ ERRADO:** Deploy sem tracing — impossível debugar problemas em produção.  
> **✅ CORRETO:** Configurar LangSmith antes do deploy para rastreamento completo.

---

## 📋 Checklist de Boas Práticas

- [ ] Usar LCEL (`|`) ao invés de `LLMChain` para novos projetos
- [ ] Configurar memória adequada para o tipo de conversa
- [ ] Sempre aplicar `TextSplitter` antes de indexar documentos
- [ ] Manter `chunk_size` entre 500-1000 tokens
- [ ] Usar `return_source_documents=True` em RAG
- [ ] Configurar fallbacks para modelos e parsers
- [ ] Usar callbacks para monitorar custos e performance
- [ ] Configurar LangSmith para tracing em produção
- [ ] Usar `batch()` para processamento em massa
- [ ] Classificar tarefas por complexidade para escolher o modelo certo
- [ ] Validar inputs antes de enviar ao LLM
- [ ] Testar com dados reais antes do deploy
- [ ] Implementar rate limiting e timeout em APIs
- [ ] Versionar prompts e chains
- [ ] Documentar metadados de cada chain para auditoria

---

*Documento gerado em 2026 — Fonte: https://github.com/langchain-ai/langchain (146k+ stars)*
