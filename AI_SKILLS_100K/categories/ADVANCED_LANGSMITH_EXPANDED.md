# 🔍 LangSmith — Plataforma Avançada para Debug, Teste, Avaliação e Monitoramento de LLMs

**Fonte:** https://github.com/langchain-ai/langsmith-sdk  
**Descrição:** LangSmith é a plataforma oficial da LangChain para tracing, avaliação, monitoramento e debug de aplicações LLM. Com SDKs em Python e JavaScript, integra-se nativamente com LangChain, LangGraph e qualquer framework custom. Suporta tracing em tempo real, evaluation com rubrics customizadas, playground interativo, A/B testing, tracking de custos e tokens, alertas, e dashboards completos.

---

## 1. Setup e Configuração

```python
# Instalação
pip install langsmith

# Configuração via variável de ambiente
import os
os.environ["LANGCHAIN_TRACING_V2"] = "true"
os.environ["LANGCHAIN_API_KEY"] = "ls__sua-chave-aqui"
os.environ["LANGCHAIN_PROJECT"] = "meu-projeto"

# Ou via Client diretamente
from langsmith import Client
client = Client(
    api_key="ls__sua-chave-aqui",
    api_url="https://api.smith.langchain.com"
)
```

## 2. Tracing Manual de Runs

```python
from langsmith import traceable
from langsmith import Client

client = Client()

@traceable(name="processar_documento")
def processar_documento(texto: str) -> dict:
    tokens = len(texto.split())
    resultado = texto.upper()
    return {"resultado": resultado, "tokens": tokens}

# Chama a função — trace é criado automaticamente
resultado = processar_documento("Olá, mundo!")
print(resultado)

# Tracing com metadados e tags
@traceable(
    name="classificar_texto",
    metadata={"modelo": "gpt-4", "versao": "2.1"},
    tags=["classificacao", "producao"]
)
def classificar_texto(texto: str) -> str:
    return "positivo"

result = classificar_texto("Este produto é excelente!")
```

## 3. Tracing de Cadeias LangChain

```python
from langchain_openai import ChatOpenAI
from langchain_core.prompts import ChatPromptTemplate
from langchain_core.output_parsers import StrOutputParser

# Tracing automático — basta ter LANGCHAIN_TRACING_V2=true
llm = ChatOpenAI(model="gpt-4")
prompt = ChatPromptTemplate.from_template(
    "Responda em português: {pergunta}"
)
chain = prompt | llm | StrOutputParser()

resultado = chain.invoke({"pergunta": "O que é machine learning?"})
# A run aparece automaticamente no dashboard LangSmith
```

## 4. Tracing com LangGraph

```python
from langgraph.graph import StateGraph, END
from typing import TypedDict, Annotated

class EstadoChat(TypedDict):
    mensagem: str
    resposta: str

# Cada nó do grafo gera spans no trace
graph = StateGraph(EstadoChat)
graph.add_node("processar", processar_mensagem)
graph.add_node("responder", gerar_resposta)
graph.add_edge("processar", "responder")
graph.add_edge("responder", END)

app = graph.compile()
resultado = app.invoke({"mensagem": "Olá!"})
# LangSmith captura a estrutura completa do grafo
```

## 5. Criação e Gestão de Datasets

```python
from langsmith import Client

client = Client()

# Criar dataset
dataset = client.create_dataset(
    name="avaliacao-chatbot-v2",
    description="Pares de pergunta-resposta para teste"
)

# Adicionar exemplos
client.create_examples(
    dataset_id=dataset.id,
    examples=[
        {
            "inputs": {"pergunta": "Qual a capital do Brasil?"},
            "outputs": {"resposta": "Brasília"}
        },
        {
            "inputs": {"pergunta": "O que é Python?"},
            "outputs": {"resposta": "Uma linguagem de programação"}
        }
    ]
)

# Versionar dataset
client.update_dataset(
    dataset_id=dataset.id,
    description="Versão 2 — com exemplos adicionais"
)

# Listar datasets
datasets = list(client.list_datasets(limit=10))
for ds in datasets:
    print(f"{ds.name} — {ds.description}")
```

## 6. Evaluation com Evaluator Customizado

```python
from langsmith import Client, evaluate

client = Client()

# Função alvo (o que está sendo avaliado)
def minha_chain(pergunta: str) -> str:
    return "Resposta simulada do modelo"

# Evaluator customizado
def avaliar_resposta(run, example):
    entrada = example.inputs["pergunta"]
    saida_esperada = example.outputs["resposta"]
    saida_obtida = run.outputs.get("output", "")

    # Verificar se contém palavras-chave
    palavras_chave = saida_esperada.lower().split()
    score = sum(1 for p in palavras_chave if p in saida_obtida.lower())
    score_normalizado = score / max(len(palavras_chave), 1)

    return {
        "key": "acuracia_palavras",
        "score": score_normalizado,
        "comment": f"Acertou {score}/{len(palavras_chave)} palavras"
    }

# Executar avaliação
results = evaluate(
    minha_chain,
    data="avaliacao-chatbot-v2",
    evaluators=[avaliar_resposta],
    experiment_prefix="exp-v2-gpt4"
)

print(results)
```

## 7. Evaluation Reference-Free (Sem Resposta Esperada)

```python
def avaliar_compatibilidade(run, example):
    """Avalia sem ter resposta esperada — usa julgamento do LLM"""
    pergunta = example.inputs["pergunta"]
    resposta = run.outputs.get("output", "")

    # Critérios automáticos
    score_comprimento = min(len(resposta) / 100, 1.0)
    score_formato = 1.0 if resposta[0].isupper() else 0.5
    score_geral = (score_comprimento + score_formato) / 2

    return {
        "key": "qualidade_geral",
        "score": score_geral,
        "comment": "Avaliação reference-free"
    }

results = evaluate(
    minha_chain,
    data="avaliacao-chatbot-v2",
    evaluators=[avaliar_compatibilidade]
)
```

## 8. Evaluation Comparativa (A vs B)

```python
def chain_v1(pergunta: str) -> str:
    return f"V1: Resposta para {pergunta}"

def chain_v2(pergunta: str) -> str:
    return f"V2: Resposta melhorada para {pergunta}"

def comparar_respostas(run_a, run_b, example):
    """Compara duas versões da chain"""
    resp_a = run_a.outputs.get("output", "")
    resp_b = run_b.outputs.get("output", "")

    # Preferir respostas mais longas e detalhadas
    score_b = len(resp_b) / max(len(resp_a), 1)

    return {
        "key": "vencedor",
        "score": 1 if score_b > 1 else 0,
        "comment": "V2 é mais detalhada" if score_b > 1 else "V1 é igual ou melhor"
    }

results = evaluate(
    lambda x: chain_v1(x["pergunta"]),
    data="avaliacao-chatbot-v2",
    evaluators=[comparar_respostas],
    experiment_prefix="comparacao-v1-vs-v2"
)
```

## 9. Playground — Teste de Prompts

```python
# Via SDK — simula o Playground do LangSmith
from langsmith import Client

client = Client()

# Criar experimento no Playground
# (Normalmente feito via interface web, mas via API:)
dataset = client.create_dataset(name="playground-test")

# Testar diferentes versões de prompt
prompts = [
    "Responda de forma objetiva: {input}",
    "Seja conciso e direto. Responda: {input}",
    "Em 3 frases, responda: {input}"
]

for i, prompt in enumerate(prompts):
    client.create_example(
        dataset_id=dataset.id,
        inputs={"input": "O que é API?"},
        outputs={"prompt_version": f"v{i+1}"}
    )

# Cada prompt pode ser avaliado individualmente
```

## 10. Monitoring — Latência, Custos e Tokens

```python
from langsmith import Client

client = Client()

# Consultar runs de um projeto
runs = client.list_runs(
    project_name="meu-projeto",
    is_root=True,  # Apenas runs raiz (não spans filhos)
    limit=100
)

total_tokens = 0
total_custo = 0.0
latencias = []

for run in runs:
    # Tokens
    if run.total_tokens:
        total_tokens += run.total_tokens
    
    # Custo (se disponível)
    if run.total_cost:
        total_custo += run.total_cost
    
    # Latência
    if run.end_time and run.start_time:
        latencia = (run.end_time - run.start_time).total_seconds()
        latencias.append(latencia)

print(f"Total tokens: {total_tokens}")
print(f"Custo total: ${total_custo:.4f}")
print(f"Latência média: {sum(latencias)/len(latencias):.2f}s")
```

## 11. Alertas e Notificações

```python
# Configurar alertas via API (exemplo simplificado)
from langsmith import Client

client = Client()

# Consultar runs com erros
runs_com_erro = client.list_runs(
    project_name="producao",
    error=True
)

for run in runs_com_erro:
    print(f"ERRO: {run.name}")
    print(f"  Mensagem: {run.error}")
    print(f"  Timestamp: {run.start_time}")

# Verificar se taxa de erro excedeu threshold
total_runs = len(list(client.list_runs(project_name="producao")))
erros = len(list(runs_com_erro))
taxa_erro = erros / max(total_runs, 1)

if taxa_erro > 0.05:
    print("⚠️ ALERTA: Taxa de erro acima de 5%!")
```

## 12. Tracking de Custo por Modelo e Operação

```python
from langsmith import Client
from collections import defaultdict

client = Client()

runs = client.list_runs(project_name="producao", limit=500)
custo_por_modelo = defaultdict(float)
custo_por_operacao = defaultdict(float)

for run in runs:
    modelo = run.extra.get("metadata", {}).get("model", "desconhecido")
    custo = run.total_cost or 0
    
    custo_por_modelo[modelo] += custo
    custo_por_operacao[run.name] += custo

print("=== Custo por Modelo ===")
for modelo, custo in sorted(custo_por_modelo.items(), key=lambda x: -x[1]):
    print(f"  {modelo}: ${custo:.4f}")

print("\n=== Custo por Operação ===")
for op, custo in sorted(custo_por_operacao.items(), key=lambda x: -x[1]):
    print(f"  {op}: ${custo:.4f}")
```

## 13. Annotations e Feedback

```python
from langsmith import Client

client = Client()

# Adicionar feedback manual a uma run
run_id = "id-da-run"

client.create_feedback(
    run_id=run_id,
    key="qualidade_humana",
    score=4,  # Escala 1-5
    comment="Resposta bem estruturada, mas poderia ser mais concisa"
)

# Feedback com valor contínuo
client.create_feedback(
    run_id=run_id,
    key="similaridade_semantica",
    score=0.87
)

# Consultar feedbacks
feedbacks = client.list_feedbacks(run_id=run_id)
for fb in feedbacks:
    print(f"{fb.key}: {fb.score} — {fb.comment}")
```

## 14. A/B Testing entre Versões

```python
from langsmith import Client, evaluate
import random

client = Client()

def chain_v1(pergunta: str) -> str:
    return f"Resposta v1 para: {pergunta}"

def chain_v2(pergunta: str) -> str:
    return f"Resposta v2 aprimorada para: {pergunta}"

# Dividir tráfego aleatoriamente
def chain_com_ab(pergunta: str) -> str:
    if random.random() < 0.5:
        resultado = chain_v1(pergunta)
    else:
        resultado = chain_v2(pergunta)
    return resultado

def avaliar_ab(run, example):
    # Avaliar com base em critérios específicos
    resposta = run.outputs.get("output", "")
    score = 1.0 if "aprimorada" in resposta else 0.5
    return {"key": "versao_vencedora", "score": score}

results = evaluate(
    chain_com_ab,
    data="avaliacao-chatbot-v2",
    evaluators=[avaliar_ab],
    experiment_prefix="ab-test-v1-vs-v2"
)
```

## 15. Online Evaluation (Avaliação em Tempo Real)

```python
from langsmith import Client, traceable

client = Client()

@traceable(name="responder_usuario")
def responder_usuario(pergunta: str) -> str:
    # Simula chamada ao modelo
    resposta = f"Resposta para: {pergunta}"
    return resposta

# Evaluation online — avalia cada run automaticamente
def evaluator_online(run, example):
    """Avaliação executada em cada run de produção"""
    resposta = run.outputs.get("output", "")
    
    # Critérios de qualidade
    score_comprimento = min(len(resposta) / 50, 1.0)
    score_relevancia = 1.0 if len(resposta) > 10 else 0.0
    
    return {
        "key": "qualidade_online",
        "score": (score_comprimento + score_relevancia) / 2
    }

# Configurar evaluation no dashboard ou via SDK
# Runs são avaliadas conforme chegam
```

## 16. Custom Dimensions para Análise

```python
from langsmith import Client

client = Client()

# Criar run com dimensões customizadas
run = client.create_run(
    project_name="producao",
    name="classificar_documento",
    run_type="chain",
    extra={
        "metadata": {
            "dimensao_tipo_documento": "juridico",
            "dimensao_idioma": "pt-br",
            "dimensao_tamanho": "grande",
            "dimensao_complexidade": "alta"
        }
    }
)

# Consultar runs por dimensão
runs_juridicos = client.list_runs(
    project_name="producao",
    filter='metadata.dimensao_tipo_documento = "juridico"'
)

# Analisar performance por dimensão
for r in runs_juridicos:
    print(f"Run {r.name}: {r.total_tokens} tokens")
```

## 17. Integração com LangChain Expression Language

```python
from langchain_openai import ChatOpenAI
from langchain_core.prompts import ChatPromptTemplate
from langchain_core.output_parsers import JsonOutputParser
from langsmith import traceable

# Tudo é traced automaticamente quando LANGCHAIN_TRACING_V2=true
llm = ChatOpenAI(model="gpt-4", temperature=0)

prompt = ChatPromptTemplate.from_messages([
    ("system", "Você é um assistente especializado em {dominio}."),
    ("human", "{pergunta}")
])

chain = prompt | llm | JsonOutputParser()

# Cada invoke gera trace completo
resultado = chain.invoke({
    "dominio": "finanças",
    "pergunta": "O que é ROI?"
})
```

## 18. Export e Análise de Dados

```python
from langsmith import Client
import json

client = Client()

# Exportar runs para análise externa
runs = list(client.list_runs(
    project_name="producao",
    limit=1000
))

dados_exportacao = []
for run in runs:
    dados_exportacao.append({
        "id": str(run.id),
        "name": run.name,
        "start_time": run.start_time.isoformat() if run.start_time else None,
        "end_time": run.end_time.isoformat() if run.end_time else None,
        "tokens": run.total_tokens,
        "cost": run.total_cost,
        "error": run.error,
        "inputs": run.inputs,
        "outputs": run.outputs
    })

with open("runs_export.json", "w") as f:
    json.dump(dados_exportacao, f, indent=2, default=str)

print(f"Exportadas {len(dados_exportacao)} runs")
```

## 19. Gerenciamento de Projetos

```python
from langsmith import Client

client = Client()

# Criar projeto
projeto = client.create_project(
    project_name="chatbot-v3",
    description="Versão 3 do chatbot com RAG",
    reference_dataset_id=None
)

# Listar projetos
projetos = client.list_projects(limit=20)
for p in projetos:
    runs_count = len(list(client.list_runs(project_name=p.name, limit=100)))
    print(f"  {p.name}: {runs_count} runs recentes")

# Deletar projeto (cuidado!)
# client.delete_project(project_name="projeto-antigo")
```

## 20. SDK JavaScript/TypeScript

```javascript
// Instalação: npm install langsmith

import { Client } from "langsmith";

const client = new Client({
  apiKey: "ls__sua-chave-aqui"
});

// Criar dataset
const dataset = await client.createDataset({
  name: "avaliacao-frontend",
  description: "Testes para chain de frontend"
});

// Adicionar exemplos
await client.createExamples({
  datasetId: dataset.id,
  examples: [
    {
      inputs: { pergunta: "Como criar um componente React?" },
      outputs: { resposta: "Use useState e JSX" }
    }
  ]
});

// Evaluation
import { evaluate } from "langsmith";

const results = await evaluate(
  async (input) => {
    return `Resposta para: ${input.pergunta}`;
  },
  {
    data: "avaliacao-frontend",
    evaluators: [
      (run, example) => ({
        key: "comprimento",
        score: Math.min(run.outputs.length / 50, 1)
      })
    ]
  }
);

console.log(results);
```

---

## 🚨 MELHORIA — Padrões Errados vs Corretos

### ❌ ERRADO: Não configurar tracing

```python
# Sem LANGCHAIN_TRACING_V2, nada é rastreado
from langchain_openai import ChatOpenAI

llm = ChatOpenAI()
resultado = llm.invoke("Olá")  # Sem trace!
```

### ✅ CORRETO: Sempre configurar tracing

```python
import os
os.environ["LANGCHAIN_TRACING_V2"] = "true"
os.environ["LANGCHAIN_API_KEY"] = "ls__sua-chave"

from langchain_openai import ChatOpenAI
llm = ChatOpenAI()
resultado = llm.invoke("Olá")  # Trace criado automaticamente!
```

---

### ❌ ERRADO: Ignorar custos e tokens

```python
# Rodar chains sem monitorar custo
for pergunta in mil_perguntas:
    chain.invoke(pergunta)  # Custo acumula silenciosamente
```

### ✅ CORRETO: Monitorar custos por run

```python
from langsmith import Client

client = Client()
for pergunta in mil_perguntas:
    resultado = chain.invoke(pergunta)
    runs = list(client.list_runs(project_name="producao", limit=1))
    if runs and runs[0].total_cost:
        print(f"Custo desta run: ${runs[0].total_cost:.6f}")
```

---

### ❌ ERRADO: Evaluation apenas manual

```python
# Testar prompts sem dados estruturados
prompt_v1 = "Responda: {input}"
prompt_v2 = "Seja direto. Responda: {input}"
# Qual é melhor? Sem dados, é chute.
```

### ✅ CORRETO: Evaluation automatizada com datasets

```python
from langsmith import Client, evaluate

client = Client()
dataset = client.create_dataset(name="testes-prompts")

# Adicionar casos de teste
client.create_examples(
    dataset_id=dataset.id,
    examples=[
        {"inputs": {"input": "O que é API?"}, "outputs": {"ideal": "Interface de programação"}},
        {"inputs": {"input": "O que é Docker?"}, "outputs": {"ideal": "Plataforma de containerização"}}
    ]
)

# Avaliar cada versão do prompt
results_v1 = evaluate(chain_v1, data="testes-prompts", evaluators=[...])
results_v2 = evaluate(chain_v2, data="testes-prompts", evaluators=[...])
# Agora temos dados para decidir!
```

---

### ❌ ERRADO: Spans manuais confusos

```python
# Muitos traces aninhados sem organização
@traceable(name="passo1")
def passo1(): ...

@traceable(name="passo1_sub")
def passo1_sub(): ...
# Trace fica bagunçado no dashboard
```

### ✅ CORRETO: Hierarquia clara de traces

```python
@traceable(name="processar_pedido")
def processar_pedido(pedido):
    resultado_validacao = validar_pedido(pedido)  # Sub-span
    resultado_pagamento = processar_pagamento(pedido)  # Sub-span
    return enviar_confirmacao(resultado_pagamento)
```

---

### ❌ ERRADO: Não versionar datasets

```python
# Usar sempre o mesmo dataset sem versionar
# Se mudar os dados, perde o histórico de evaluation
client.create_examples(dataset_id=antigo, examples=[...])  # Mistura versões
```

### ✅ CORRETO: Versionar datasets para rastreabilidade

```python
# Criar novo dataset para cada versão significativa
dataset_v2 = client.create_dataset(
    name="avaliacao-v2",
    description="Versão 2 — com mais casos extremos"
)
# Manter v1 para comparação histórica
```

---

> **Resumo:** LangSmith é essencial para qualquer aplicação LLM em produção. Configure tracing desde o início, crie datasets versionados para evaluation automatizada, monitore custos e tokens, e use annotations para feedback humano. A combinação de tracing + evaluation + monitoring permite iteração segura e baseada em dados.