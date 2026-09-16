# 🕸️ LangGraph — Framework Avançado para Grafos de Estado com LLMs

**Fonte:** https://github.com/langchain-ai/langgraph (15k+ stars)
**Descrição:** Biblioteca para construir aplicações stateful e multi-actor com LLMs usando grafos de estado com nós, arestas, checkpointing e suporte a human-in-the-loop.

---

## 1. 🏗️ StateGraph Fundamentals

O `StateGraph` é a estrutura central do LangGraph, definindo nós (funções) e arestas (transições) com um estado compartilhado.

```python
from typing import TypedDict, Annotated
from langgraph.graph import StateGraph, END
from langgraph.graph.message import add_messages

class AgentState(TypedDict):
    messages: Annotated[list, add_messages]

def chatbot(state: AgentState):
    return {"messages": [model.invoke(state["messages"])]}

graph = StateGraph(AgentState)
graph.add_node("chatbot", chatbot)
graph.set_entry_point("chatbot")
graph.add_edge("chatbot", END)

app = graph.compile()
result = app.invoke({"messages": [("human", "Olá!")]})
```

### Sub-skills:
- Definição de `TypedDict` para estados tipados
- `Annotated` com reducers para atualização automática
- `add_messages` para histórico conversacional
- `set_entry_point` e `set_finish_point`

---

## 2. 🔀 Conditional Routing e Branching

Roteamento condicional permite que o grafo tome decisões dinâmicas com base no estado atual.

```python
def should_continue(state: AgentState):
    last_message = state["messages"][-1]
    if last_message.tool_calls:
        return "tools"
    return END

graph.add_conditional_edges("agent", should_continue, {
    "tools": "tool_node",
    END: END
})
```

### Sub-skills:
- `add_conditional_edges` com funções de decisão
- Mapeamento de nomes para nós
- Lógica de fallback
- Verificação de tool_calls no estado

---

## 3. 🛠️ Tool Integration (Function Calling)

LangGraph integra nativamente com ferramentas LLM, executando tools selecionadas pelo modelo automaticamente.

```python
from langgraph.prebuilt import ToolNode

@tool
def search(query: str) -> str:
    """Busca informações na web."""
    return f"Resultado para: {query}"

tools = [search]
model = model.bind_tools(tools)

tool_node = ToolNode(tools)

graph.add_node("agent", agent_node)
graph.add_node("tools", tool_node)
graph.add_edge("tools", "agent")
```

### Sub-skills:
- Decorador `@tool` para definição
- `ToolNode` pré-construído
- `bind_tools` para vincular ao modelo
- Execução automática de tool_calls

---

## 4. 💾 Checkpointing e Persistence

O checkpointing permite salvar e restaurar o estado do grafo, habilitando conversas persistentes e debugging.

```python
from langgraph.checkpoint.memory import MemorySaver

memory = MemorySaver()
app = graph.compile(checkpointer=memory)

config = {"configurable": {"thread_id": "1"}}
result = app.invoke({"messages": [("human", "Oi")]}, config)

# Estado pode ser restaurado
snapshot = app.get_state(config)
```

### Sub-skills:
- `MemorySaver` para persistência em memória
- `SqliteSaver` e `PostgresSaver` para persistência em disco
- `thread_id` para identificar conversas
- `get_state()` e `update_state()` para manipulação manual
- `configurable` patterns

---

## 5. 🤖 Human-in-the-Loop

Padrões para interromper o fluxo e aguardar input humano antes de continuar.

```python
from langgraph.types import interrupt, Command

def sensitive_action(state: AgentState):
    result = interrupt(
        "Aprovação necessária para esta ação. Aprovar?"
    )
    if result == "approved":
        return {"status": "executado"}
    return {"status": "cancelado"}

graph.add_node("sensitive", sensitive_action)
graph.add_edge("agent", "sensitive")

# Após interrupção, retoma com Command
app.invoke(Command(resume="approved"), config)
```

### Sub-skills:
- `interrupt()` para pausar execução
- `Command(resume=...)` para retomar
- `Command(update=...)` para atualizar estado ao retomar
- Validação humana em ações críticas
- Aprovação de tool calls

---

## 6. 👥 Multi-Agent Workflows

Múltiplos agentes especializados trabalhando juntos com delegação e coordenação.

```python
from langgraph.prebuilt import create_react_agent

researcher = create_react_agent(
    model, tools=[search_tool], prompt="Pesquise informações"
)
writer = create_react_agent(
    model, tools=[], prompt="Escreva artigos"
)

graph = StateGraph(AgentState)
graph.add_node("researcher", researcher)
graph.add_node("writer", writer)
graph.add_edge("researcher", "writer")
```

### Sub-skills:
- Agentes pré-construídos com `create_react_agent`
- Delegação entre agentes
- Padrão supervisor/worker
- Padrão swarm para orquestração horizontal
- Comunicação via estado compartilhado

---

## 7. 📡 Streaming Support

Streaming de eventos em tempo real para interface responsiva e monitoramento.

```python
for event in app.stream({"messages": [("human", "Analise dados")]}, config):
    for node_name, output in event.items():
        print(f"Nó: {node_name}")
        print(f"Saída: {output}")

# Streaming por tokens
for msg, metadata in app.stream(
    {"messages": [("human", "Explique IA")]},
    config,
    stream_mode="messages"
):
    print(msg.content, end="", flush=True)
```

### Sub-skills:
- `stream()` para streaming por nó
- `stream_mode="messages"` para streaming por token
- `astream()` para versão assíncrona
- Metadados de streaming
- Filtros por nó

---

## 8. 🧠 Memory Management

Gerenciamento de memória de curto e longo prazo para agentes persistentes.

```python
from langgraph.checkpoint.postgres.aio import AsyncPostgresSaver

async with AsyncPostgresSaver.from_conn_string(conn_string) as memory:
    app = graph.compile(checkpointer=memory)

    # Memória de longo prazo
    config = {"configurable": {"thread_id": "user-123"}}
    result = await app.ainvoke(input_data, config)

    # Histórico de conversas
    history = [
        state
        for state in memory.list(config)
    ]
```

### Sub-skills:
- `MemorySaver` para testes e prototipagem
- `PostgresSaver` para produção
- `SqliteSaver` para persistência local
- Semântica de thread_id
- Limpeza e expiração de memória

---

## 9. 📦 Sub-Graphs Composition

Composição de grafos menores dentro de grafos maiores para modularidade.

```python
sub_builder = StateGraph(SubState)
sub_builder.add_node("process", process_node)
sub_builder.set_entry_point("process")
sub_builder.add_edge("process", END)
sub_graph = sub_builder.compile()

# Usar como nó em grafo principal
main_builder = StateGraph(MainState)
main_builder.add_node("sub_process", sub_graph)
main_builder.add_edge(START, "sub_process")
```

### Sub-skills:
- Sub-grafos como nós
- Mapeamento de estados entre grafos
- `Send` API para fan-out dinâmico
- Hierarquia de grafos
- Reutilização de componentes

---

## 10. ⏪ Time Travel Debugging

Replay e inspeção de estados anteriores para debug e análise.

```python
# Obter snapshot de um ponto específico
snapshot = app.get_state(config)

# Listar todos os checkpoints
history = list(memory.list(config))

# Re-executar a partir de um checkpoint
for state in memory.list(config):
    if state.config["configurable"]["checkpoint_id"] == target_id:
        app.invoke(None, state.config)
```

### Sub-skills:
- `get_state()` para snapshot atual
- `list()` no checkpointer para histórico
- Replay a partir de checkpoints
- Inspecionar estado de cada nó
- Comparar execuções

---

## 11. 📊 LangSmith Integration

Integração com LangSmith para tracing, avaliação e monitoramento.

```python
import os
os.environ["LANGCHAIN_TRACING_V2"] = "true"
os.environ["LANGCHAIN_API_KEY"] = "sua-chave"

app = graph.compile()

# Todas as execuções são rastreadas automaticamente
result = app.invoke(input_data)

# Avaliação de qualidade
from langsmith import Client
client = Client()
dataset = client.clone_public_dataset("dataset-id")
```

### Sub-skills:
- Tracing automático de chamadas
- Avaliação de qualidade com datasets
- Comparação de versões
- Métricas de performance
- Feedback humano

---

## 12. ⏰ Cron Scheduling

Agendamento de execuções periódicas para tarefas em background.

```python
from langgraph.pregel import Pregel

# Configurar execução periódica
app = graph.compile()

# Via LangGraph Platform
deploy_config = {
    "cron": {
        "expression": "0 */6 * * *",  # A cada 6 horas
        "payload": {"messages": [("system", "Relatório diário")]}
    }
}
```

### Sub-skills:
- Expressões cron para agendamento
- Payloads periódicos
- Integração com LangGraph Platform
- Monitoramento de execuções agendadas

---

## 13. 📨 Send API para Dynamic Fan-Out

Distribuição dinâmica de trabalho para múltiplos nós paralelos.

```python
from langgraph.types import Send

def router(state: AgentState):
    return [
        Send("process", {"item": item, "index": i})
        for i, item in enumerate(state["items"])
    ]

graph.add_conditional_edges("router", router)
```

### Sub-skills:
- `Send` para fan-out dinâmico
- Agregação de resultados
- Paralelismo por dados
- Mapeamento dinâmico

---

## 14. 🔧 Custom State Reducers

Redutores personalizados para controlar como o estado é atualizado.

```python
from operator import add
from typing import Annotated

class State(TypedDict):
    documents: Annotated[list[str], add]
    count: int

def count_reducer(current: int, update: int) -> int:
    return current + update

class StateV2(TypedDict):
    documents: Annotated[list[str], add]
    total: Annotated[int, count_reducer]
```

### Sub-skills:
- `Annotated` com função redutora
- `add` para listas
- Redutores customizados para contadores
- Conflitos e resolução
- `operator` module para redutores comuns

---

## 15. 🛡️ Error Handling e Recovery

Tratamento de erros e recuperação graceful em grafos complexos.

```python
def safe_node(state: AgentState):
    try:
        result = risky_operation(state)
        return {"output": result}
    except Exception as e:
        return {"error": str(e), "retry": True}

def should_retry(state: AgentState):
    if state.get("retry"):
        return "safe_node"
    return END

graph.add_conditional_edges("safe", should_retry)
```

### Sub-skills:
- Try/except em nós
- Nós de fallback
- Retry com backoff
- Logging de erros
- Circuit breaker patterns

---

## 16. 🔗 Multi-Modal Inputs

Suporte a diferentes tipos de entrada: texto, imagens, áudio.

```python
from langchain_core.messages import HumanMessage

# Texto
result = app.invoke({"messages": [HumanMessage(content="Olá")]})

# Imagem
result = app.invoke({
    "messages": [HumanMessage(content=[
        {"type": "text", "text": "O que é esta imagem?"},
        {"type": "image_url", "image_url": {"url": "url_da_imagem"}}
    ])]
})
```

### Sub-skills:
- `HumanMessage` com content multimodal
- Suporte a imagens
- Processamento de áudio
- Content blocks para tipos mistos

---

## 17. 📋 Output Parsing

Parsing estruturado de saídas LLM com Pydantic.

```python
from pydantic import BaseModel

class Analysis(BaseModel):
    summary: str
    confidence: float
    tags: list[str]

def parse_output(state: AgentState):
    structured = model.with_structured_output(Analysis)
    result = structured.invoke(state["messages"])
    return {"analysis": result}

graph.add_node("parser", parse_output)
```

### Sub-skills:
- `with_structured_output()` para Pydantic
- Validação automática
- Retry em parsing
- Union types para flexibilidade

---

## 18. 🚀 Async Operations

Operações assíncronas para performance em I/O-bound tasks.

```python
import asyncio

async def async_agent(state: AgentState):
    tasks = [process(item) for item in state["items"]]
    results = await asyncio.gather(*tasks)
    return {"results": results}

app = graph.compile()

# Execução assíncrona
result = await app.ainvoke(input_data, config)

# Streaming assíncrono
async for event in app.astream(input_data, config):
    print(event)
```

### Sub-skills:
- `ainvoke()` para chamadas assíncronas
- `astream()` para streaming assíncrono
- `asyncio.gather()` para paralelismo
- Retry com backoff assíncrono

---

## 19. 🧪 Testing Patterns

Padrões de teste para grafos LangGraph.

```python
from langgraph.graph import StateGraph

def test_simple_flow():
    graph = StateGraph(AgentState)
    graph.add_node("start", lambda s: {"output": "ok"})
    graph.set_entry_point("start")
    graph.add_edge("start", END)
    app = graph.compile()

    result = app.invoke({"messages": []})
    assert result["output"] == "ok"

def test_conditional_flow():
    # Testar cada branch do conditional routing
    pass
```

### Sub-skills:
- Testes unitários por nó
- Testes de integração do fluxo
- Mock de tools
- Snapshot testing com checkpoints
- Assert de estado final

---

## 20. 🌐 Deployment Patterns

Padrões de deploy para produção.

```python
# LangGraph Platform deployment
from langgraph.api import create_app

app = graph.compile()
api_app = create_app(
    app,
    env={
        "OPENAI_API_KEY": "sk-...",
        "REDIS_URL": "redis://localhost"
    }
)

# Docker deployment
# docker-compose.yml com Redis para persistence
# Health checks e auto-scaling
```

### Sub-skills:
- LangGraph Platform (Cloud e Self-Hosted)
- Docker containers
- Redis para persistence
- Load balancing
- Health checks
- Observabilidade em produção

---

## 📝 MELHORIA: Padrões Errado vs Correto

### ❌ ERRADO — Estado mutável direto
```python
def bad_node(state):
    state["messages"].append("novo")  # Mutação direta!
    return state
```

### ✅ CORRETO — Reducer com Annotated
```python
class State(TypedDict):
    messages: Annotated[list, add_messages]

def good_node(state):
    return {"messages": [AIMessage(content="novo")]}  # Retorna dict com reducer
```

---

### ❌ ERRADO — Criar grafo sem checkpointing
```python
app = graph.compile()  # Sem persistência!
# Estado perdido entre chamadas
```

### ✅ CORRETO — Sempre usar checkpointing em produção
```python
from langgraph.checkpoint.memory import MemorySaver
memory = MemorySaver()
app = graph.compile(checkpointer=memory)
# Estado persiste entre chamadas
```

---

### ❌ ERRADO — Condicional sem fallback
```python
def router(state):
    if state.get("type") == "A":
        return "node_a"
    # Sem fallback! Quebra se type não for "A"
```

### ✅ CORRETO — Sempre ter fallback
```python
def router(state):
    if state.get("type") == "A":
        return "node_a"
    return "fallback_node"  # Sempre retornar algo válido
```

---

### ❌ ERRADO — Tool sem tratamento de erro
```python
@tool
def search(query: str):
    return requests.get(url).json()  # Pode falhar silenciosamente
```

### ✅ CORRETO — Tool com tratamento de erro
```python
@tool
def search(query: str):
    """Busca informações."""
    try:
        response = requests.get(url, timeout=10)
        response.raise_for_status()
        return response.json()
    except requests.RequestException as e:
        return f"Erro na busca: {str(e)}"
```

---

### ❌ ERRADO — Usar invoke síncrono em produção
```python
result = app.invoke(input_data)  # Bloqueia thread
```

### ✅ CORRETO — Usar async em produção
```python
result = await app.ainvoke(input_data, config)  # Non-blocking
```

---

## 📚 Referências

- **Documentação:** https://langchain-ai.github.io/langgraph/
- **Tutoriais:** https://langchain-ai.github.io/langgraph/tutorials/
- **Exemplos:** https://github.com/langchain-ai/langgraph/tree/main/examples
- **LangGraph Platform:** https://langchain-ai.github.io/langgraph/concepts/langgraph_platform/
- **API Reference:** https://langchain-ai.github.io/langgraph/reference/
