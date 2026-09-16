# 🤖 CrewAI — Framework para Orquestração de Agentes IA com Papéis

**Fonte:** https://github.com/crewAIInc/crewAI (30k+ stars)
**Descrição:** Framework para orquestrar agentes IA especializados em papéis (roles), com memória, ferramentas, delegação e workflows complexos usando o padrão Crew.

---

## 1. 🎭 Agentes com Roles, Goals e Backstories

Agentes são personagens IA com identidades e objetivos específicos que influenciam seu comportamento.

```python
from crewai import Agent

researcher = Agent(
    role="Pesquisador Sênior",
    goal="Encontrar informações precisas e atualizadas sobre o tema",
    backstory="""Você é um pesquisador experente com 15 anos de experiência
    em análise de dados. Sempre verifica fontes e cruza informações.""",
    verbose=True,
    allow_delegation=False,
    llm="gpt-4o"
)
```

### Sub-skills:
- `role` — define o papel profissional
- `goal` — objetivo que direciona o comportamento
- `backstory` — contexto que molda personalidade
- `verbose` — modo detalhado para debug
- `allow_delegation` — controla delegação
- `llm` — modelo específico por agente

---

## 2. 📋 Tasks com Descrição e Expected Output

Tarefas são unidades de trabalho atribuídas a agentes com resultados esperados claros.

```python
from crewai import Task

research_task = Task(
    description="""Pesquise os 5 melhores frameworks de IA de 2026,
    incluindo: nome, principais features, caso de uso e números de stars no GitHub.
    Formate como tabela comparativa.""",
    expected_output="""Tabela markdown com colunas: Framework, Features, Caso de Uso, Stars.
    Mínimo 5 frameworks com dados atualizados.""",
    agent=researcher
)
```

### Sub-skills:
- `description` — descrição detalhada da tarefa
- `expected_output` — formato esperado do resultado
- `agent` — agente responsável
- `context` — tarefas que alimentam esta
- `output_file` — salvar resultado em arquivo
- `async_execution` — execução assíncrona

---

## 3. 👥 Crews — Padrão Sequential e Hierarchical

O Crew coordena agentes e tarefas seguindo um padrão de execução definido.

```python
from crewai import Crew, Process

# Padrão Sequencial
crew_sequential = Crew(
    agents=[researcher, writer, editor],
    tasks=[research_task, writing_task, editing_task],
    process=process.seQUENTIAL,
    verbose=True
)

# Padrão Hierárquico
crew_hierarchical = Crew(
    agents=[researcher, writer, editor],
    tasks=[research_task, writing_task, editing_task],
    process=Process.hierarchical,
    manager_llm="gpt-4o",
    verbose=True
)
```

### Sub-skills:
- `Process.seQUENTIAL` — execução em cadeia
- `Process.hierarchical` — manager coordena workers
- `verbose` — log detalhado
- `max_rpm` — limite de chamadas por minuto
- `memory` — habilitar memória do crew
- `cache` — cache de resultados

---

## 4. 🛠️ Tools Integration (Search, Code, Files)

Ferramentas estendem as capacidades dos agentes além do conhecimento do LLM.

```python
from crewai_tools import (
    SerperDevTool,
    ScrapeWebsiteTool,
    FileReadTool,
    CodeInterpreterTool
)

search_tool = SerperDevTool()
scrape_tool = ScrapeWebsiteTool()
code_tool = CodeInterpreterTool()

analyst = Agent(
    role="Analista de Dados",
    goal="Analisar e processar dados complexos",
    backstory="Especialista em análise de dados com Python",
    tools=[search_tool, code_tool]
)
```

### Sub-skills:
- `SerperDevTool` — busca na web
- `ScrapeWebsiteTool` — scraping de páginas
- `FileReadTool` — leitura de arquivos
- `CodeInterpreterTool` — execução de código
- `DirectoryReadTool` — leitura de diretórios
- `WebsiteSearchTool` — busca em sites específicos
- Tools customizadas com `@tool`

---

## 5. 🧠 Memory System (Short, Long, Entity, User)

Sistema de memória em 4 camadas para contexto entre tarefas e sessões.

```python
from crewai import Crew

crew = Crew(
    agents=[researcher, writer],
    tasks=[research_task, writing_task],
    memory=True,
    long_term_memory=True,
    entity_memory=True
)

# Após execução, a memória é persistida
result = crew.kickoff()

# Consultar memória
from crewai.memory import ShortTermMemory, LongTermMemory

stm = ShortTermMemory(crew)
ltm = LongTermMemory(crew)
```

### Sub-skills:
- **Short-Term Memory** — contexto da sessão atual
- **Long-Term Memory** — persistência entre sessões
- **Entity Memory** — informações sobre entidades (pessoas, empresas)
- **User Memory** — preferências do usuário
- `memory=True` — ativar todas as camadas
- `embedder_config` — modelo de embedding para memória

---

## 6. 📚 Knowledge Sources

Fontes de conhecimento externo que alimentam os agentes com informações específicas.

```python
from crewai import Agent, KnowledgeSource
from crewai.knowledge.source.text_file_knowledge_source import TextFileKnowledgeSource

file_source = TextFileKnowledgeSource(
    file_paths=["docs/manual.txt", "docs/regras.md"]
)

agent = Agent(
    role="Suporte Técnico",
    goal="Responder dúvidas usando a documentação",
    backstory="Especialista no produto com acesso à documentação",
    knowledge_sources=[file_source]
)
```

### Sub-skills:
- `TextFileKnowledgeSource` — arquivos de texto
- `CSVKnowledgeSource` — dados tabulares
- `PDFKnowledgeSource` — documentos PDF
- `URLKnowledgeSource` — páginas web
- `DirectoryKnowledgeSource` — diretórios inteiros
- Embeddings para busca semântica

---

## 7. 🔄 Process Types — Sequential vs Hierarchical

Dois modos de orquestração com trade-offs diferentes.

```python
# Sequencial: cada tarefa alimenta a próxima
from crewai import Crew, Process

sequential_crew = Crew(
    agents=[researcher, writer],
    tasks=[task1, task2],
    process=Process.seQUENTIAL
)

# Hierarchical: manager delega e coordena
hierarchical_crew = Crew(
    agents=[researcher, writer],
    tasks=[task1, task2],
    process=Process.hierarchical,
    manager_llm="gpt-4o"
)
```

### Sub-skills:
- **Sequential** — simples, previsível, cada tarefa é output da anterior
- **Hierarchical** — manager interpreta resultados e delega dinamicamente
- `manager_llm` — modelo do manager no modo hierarchical
- `manager_agent` — agente manager customizado
- Escolha baseada na complexidade do workflow

---

## 8. 🤝 Delegation Between Agents

Agentes podem delegar trabalho uns aos outros quando encontram tarefas fora de seu escopo.

```python
researcher = Agent(
    role="Pesquisador",
    goal="Pesquisar dados",
    backstory="Especialista em pesquisa",
    allow_delegation=True,  # Permite delegar
    tools=[search_tool]
)

writer = Agent(
    role="Escritor",
    goal="Escrever conteúdo",
    backstory="Redator profissional",
    allow_delegation=True
)

# O researcher pode delegar tarefas de escrita para o writer
```

### Sub-skills:
- `allow_delegation=True` — ativar delegação
- Delegação automática baseada no papel
- Comunicação entre agentes via mensagens
- Fallback quando agente delegado não disponível
- Controle granular de quem delega para quem

---

## 9. ⚡ Async Execution

Execução assíncrona de tarefas para performance em workflows paralelos.

```python
import asyncio
from crewai import Crew, Process

crew = Crew(
    agents=[researcher, writer],
    tasks=[task1, task2],
    process=Process.seQUENTIAL
)

# Execução assíncrona
async def run_crew():
    result = await crew.kickoff_async()
    return result

# Ou kickoff síncrono normal
result = crew.kickoff()
```

### Sub-skills:
- `kickoff_async()` — execução não-bloqueante
- Paralelismo com múltiplos crews
- `asyncio.gather()` para coordenação
- Callbacks assíncronos
- Monitoramento de progresso

---

## 10. 🌊 Flow — State Machine para Workflows Complexos

Flow permite criar state machines com transições controladas para workflows avançados.

```python
from crewai.flow.flow import Flow, listen, start, and_, or_
from pydantic import BaseModel

class ResearchState(BaseModel):
    topic: str = ""
    findings: list[str] = []
    report: str = ""

class ResearchFlow(Flow[ResearchState]):

    @start()
    def initiate_research(self):
        self.state.topic = "Inteligência Artificial"

    @listen(initiate_research)
    def gather_data(self):
        # Coleta dados
        self.state.findings = ["dado1", "dado2"]

    @listen(gather_data)
    def write_report(self):
        # Gera relatório
        self.state.report = "Relatório final"

flow = ResearchFlow()
result = flow.kickoff()
```

### Sub-skills:
- `@start()` — ponto de entrada
- `@listen()` — dependência de tarefas anteriores
- `and_()` — AND lógico (todas as dependências)
- `or_()` — OR lógico (qualquer dependência)
- `@router()` — roteamento condicional
- `@persist()` — persistência de estado
- Pydantic BaseModel para state

---

## 11. 📐 Planning Agents

Agentes que criam planos antes de executar, garantindo abordagem estruturada.

```python
from crewai import Agent, Crew, Task

planner = Agent(
    role="Planejador",
    goal="Criar planos detalhados antes da execução",
    backstory="Especialista em planejamento estratégico",
    llm="gpt-4o"
)

planning_task = Task(
    description="Crie um plano para analisar o mercado de IA",
    expected_output="Plano com 5 etapas e cronograma",
    agent=planner
)

crew = Crew(
    agents=[planner, researcher, writer],
    tasks=[planning_task, research_task, writing_task],
    planning=True  # Habilitar planning
)
```

### Sub-skills:
- `planning=True` — ativar fase de planejamento
- Agente planejador dedicado
- Plano como input para execução
- Validação do plano antes de executar
- Ajustes dinâmicos baseados em resultados

---

## 12. 🛡️ Guardrails para Validação de Output

Validação e correção automática de saídas para garantir qualidade.

```python
from pydantic import BaseModel, Field
from crewai import Agent, Task

class AnalysisOutput(BaseModel):
    summary: str = Field(description="Resumo em até 200 palavras")
    confidence: float = Field(ge=0, le=1, description="Nível de confiança")
    tags: list[str] = Field(min_length=1, description="Mínimo 1 tag")

analyst = Agent(
    role="Analista",
    goal="Produzir análises estruturadas",
    backstory="Analista de dados rigoroso"
)

task = Task(
    description="Analise os dados fornecidos",
    expected_output="Análise estruturada em formato JSON",
    agent=analyst,
    output_pydantic=AnalysisOutput  # Validação automática
)

crew = Crew(agents=[analyst], tasks=[task])
result = crew.kickoff()
# result.pydantic é um AnalysisOutput validado
```

### Sub-skills:
- `output_pydantic` — validação com Pydantic
- `output_json` — validação como JSON
- Retry automático em caso de falha
- `guardrail` — função customizada de validação
- Descrições em Fields para LLM entender formato

---

## 13. 📝 Template System

Templates reutilizáveis para agentes e tarefas comuns.

```python
from crewai import Agent, Task

# Template de agente
def create_analyst(expertise: str) -> Agent:
    return Agent(
        role=f"Analista de {expertise}",
        goal=f"Analisar dados de {expertise} com precisão",
        backstory=f"10 anos de experiência em análise de {expertise}",
        verbose=True
    )

# Template de tarefa
def analysis_task(agent: Agent, data_source: str) -> Task:
    return Task(
        description=f"Analise os dados de {data_source} e gere insights",
        expected_output="Relatório com 5 insights principais",
        agent=agent
    )

# Uso
data_analyst = create_analyst("Dados")
task = analysis_task(data_analyst, "vendas_Q4")
```

### Sub-skills:
- Funções factory para agentes
- Parâmetros reutilizáveis
- Templates de tarefa com variáveis
- Herança de configurações base
- Bibliotecas de templates compartilháveis

---

## 14. 🚀 CrewAI Enterprise

Plataforma gerenciada para produção com monitoramento e deploy.

```python
# Deploy via CrewAI Enterprise
from crewai.enterprise import EnterpriseCrew

enterprise_crew = EnterpriseCrew(
    crew=my_crew,
    config={
        "name": "Pesquisa de Mercado",
        "description": "Análise semanal de mercado",
        "schedule": "0 9 * * 1",  # Segunda às 9h
        "notifications": ["email", "slack"]
    }
)

# Kickoff via API
result = enterprise_crew.deploy()
```

### Sub-skills:
- Deploy gerenciado
- Agendamento de execuções
- Notificações (email, Slack, webhook)
- Dashboard de monitoramento
- Versionamento de crews
- Logs e auditoria
- Escalabilidade automática

---

## 15. 🔧 Custom Tools com @tool

Criação de ferramentas customizadas para necessidades específicas.

```python
from crewai import tool
import requests

@tool("Buscar CEP")
def search_cep(cep: str) -> str:
    """Busca informações de endereço pelo CEP brasileiro."""
    response = requests.get(f"https://viacep.com.br/ws/{cep}/json/")
    if response.status_code == 200:
        data = response.json()
        return f"{data['logradouro']}, {data['bairro']}, {data['localidade']}-{data['uf']}"
    return "CEP não encontrado"

# Usar em agente
agent = Agent(
    role="Assistente",
    tools=[search_cep]
)
```

### Sub-skills:
- Decorador `@tool` com nome amigável
- Docstring como descrição para o LLM
- Tipagem de parâmetros
- Validação de entrada
- Retorno formatado
- Tratamento de erros
- Rate limiting

---

## 16. 📊 Callbacks e Eventos

Hooks para monitoramento e personalização do fluxo de execução.

```python
from crewai import Crew, Task, Agent
from crewai.utilities.callbacks import CallbackHandler

class MyCallback(CallbackHandler):
    def on_agent_action(self, agent, action):
        print(f"Agente {agent.role} vai: {action}")

    def on_agent_finish(self, agent, output):
        print(f"Agente {agent.role} terminou: {output[:50]}")

    def on_task_complete(self, task, output):
        print(f"Tarefa '{task.description[:30]}' concluída")

crew = Crew(
    agents=[researcher],
    tasks=[research_task],
    callbacks=MyCallback()
)
```

### Sub-skills:
- `on_agent_action` — antes da ação
- `on_agent_finish` — após conclusão
- `on_task_complete` — tarefa finalizada
- `on_crew_finish` — crew finalizado
- Custom logging
- Métricas de performance
- Webhooks para integração

---

## 17. 💬 Conversational Agents

Agentes em modo conversacional para chatbots e assistentes.

```python
from crewai import Agent, Crew, Task

chatbot = Agent(
    role="Assistente de Suporte",
    goal="Ajudar usuários com dúvidas sobre o produto",
    backstory="Atendente experiente e simpático",
    verbose=True,
    allow_delegation=False
)

# Modo conversacional
crew = Crew(agents=[chatbot], tasks=[])
result = crew.kickoff(inputs={"user_message": "Como resetar minha senha?"})
```

### Sub-skills:
- Inputs dinâmicos via `kickoff(inputs={})`
- Memória entre mensagens
- Respostas contextuais
- Modo verbose para debug
- Integração com APIs de chat

---

## 18. 🧪 Testing Patterns

Padrões de teste para crews e agentes.

```python
import pytest
from unittest.mock import MagicMock, patch
from crewai import Agent, Crew, Task

def test_agent_creation():
    agent = Agent(
        role="Teste",
        goal="Testar",
        backstory="Tester"
    )
    assert agent.role == "Teste"

@patch('crewai.Agent.llm')
def test_crew_execution(mock_llm):
    mock_llm.invoke.return_value = MagicMock(content="ok")
    crew = Crew(
        agents=[agent],
        tasks=[task]
    )
    result = crew.kickoff()
    assert result is not None
```

### Sub-skills:
- Mock de LLMs para testes rápidos
- Testes de criação de Agent
- Testes de fluxo Crew
- Validação de outputs com Pydantic
- Testes de delegação
- Testes de memória
- Fixture factories

---

## 19. 🔄 Iterative Mode

Execução iterativa onde o agente pode refinar resultados múltiplas vezes.

```python
from crewai import Agent, Task, Crew

writer = Agent(
    role="Escritor",
    goal="Escrever conteúdo de alta qualidade",
    backstory="Redator premiado"
)

writing_task = Task(
    description="Escreva um artigo sobre IA",
    expected_output="Artigo completo com 1000 palavras",
    agent=writer
)

crew = Crew(
    agents=[writer],
    tasks=[writing_task],
    max_iter=5,  # Máximo de iterações
    max_rpm=10   # Limite de chamadas por minuto
)

result = crew.kickoff()
```

### Sub-skills:
- `max_iter` — limite de iterações
- `max_rpm` — rate limiting
- Refinamento automático
- Parada por convergência
- Controle de custo

---

## 20. 📦 Dependency Management

Gerenciamento de dependências entre tarefas e agentes.

```python
from crewai import Crew, Task, Agent, Process

task1 = Task(description="Pesquisar", agent=researcher)
task2 = Task(description="Escrever", agent=writer, context=[task1])
task3 = Task(description="Editar", agent=editor, context=[task2])

crew = Crew(
    agents=[researcher, writer, editor],
    tasks=[task1, task2, task3],
    process=Process.seQUENTIAL  # Respeita dependências
)

# Ou com Task em Crew
crew2 = Crew(
    agents=[researcher, writer],
    tasks=[task1, task2]
)
# task2 recebe output de task1 automaticamente no sequential
```

### Sub-skills:
- `context=[task]` — dependências explícitas
- `Process.seQUENTIAL` — dependências implícitas
- Grafo de dependências
- Paralelismo quando possível
- Tratamento de falhas em cadeia

---

## 📝 MELHORIA: Padrões Errado vs Correto

### ❌ ERRADO — Agente sem objetivo claro
```python
agent = Agent(
    role="AI",
    goal="Fazer coisas",
    backstory="É uma IA"
)
```

### ✅ CORRETO — Agente com objetivo específico
```python
agent = Agent(
    role="Analista de Dados Sênior",
    goal="Analisar dados de vendas Q4 e identificar 5 tendências principais",
    backstory="""Especialista em análise de dados com 10 anos de experiência
    em e-commerce. Conhecimento avançado em Python, SQL e visualização.""",
    verbose=True
)
```

---

### ❌ ERRADO — Task sem expected_output
```python
task = Task(
    description="Faz uma pesquisa",
    agent=researcher
)
```

### ✅ CORRETO — Task com output definido
```python
task = Task(
    description="Pesquise os 5 frameworks de IA mais populares do GitHub",
    expected_output="Tabela markdown com: Nome, Stars, Descrição, Caso de Uso",
    agent=researcher,
    output_file="resultados.md"
)
```

---

### ❌ ERRADO — Crew sem memória
```python
crew = Crew(
    agents=[researcher, writer],
    tasks=[task1, task2],
    memory=False  # Sem contexto entre tarefas
)
```

### ✅ CORRETO — Crew com memória habilitada
```python
crew = Crew(
    agents=[researcher, writer],
    tasks=[task1, task2],
    memory=True,
    verbose=True,
    max_rpm=10
)
```

---

### ❌ ERRADO — Tools sem tratamento de erro
```python
@tool("Buscar")
def search(query):
    return requests.get(url).json()  # Pode quebrar
```

### ✅ CORRETO — Tools com validação
```python
@tool("Buscar Preço")
def search_price(product: str) -> str:
    """Busca preço de produto. Requer nome do produto."""
    try:
        response = requests.get(f"{API_URL}/{product}", timeout=10)
        response.raise_for_status()
        return f"Preço: R$ {response.json()['price']}"
    except requests.RequestException as e:
        return f"Erro ao buscar preço: {str(e)}"
```

---

### ❌ ERRADO — Output sem validação
```python
task = Task(
    description="Gere um relatório",
    expected_output="Relatório",  # Vago demais
    agent=analyst
)
```

### ✅ CORRETO — Output com Pydantic validation
```python
from pydantic import BaseModel, Field

class Report(BaseModel):
    title: str = Field(min_length=5)
    summary: str = Field(max_length=500)
    findings: list[str] = Field(min_length=3)
    confidence: float = Field(ge=0, le=1)

task = Task(
    description="Gere um relatório estruturado",
    expected_output="Relatório em formato JSON",
    agent=analyst,
    output_pydantic=Report
)
```

---

### ❌ ERRADO — Delegation sem controle
```python
# Todos delegam para todos — caos!
agent1 = Agent(allow_delegation=True)
agent2 = Agent(allow_delegation=True)
agent3 = Agent(allow_delegation=True)
```

### ✅ CORRETO — Delegation controlada
```python
supervisor = Agent(role="Supervisor", allow_delegation=True)
worker1 = Agent(role="Worker", allow_delegation=False)  # Não delega
worker2 = Agent(role="Worker", allow_delegation=False)

# Supervisor delega, workers executam
```

---

## 📚 Referências

- **Documentação:** https://docs.crewai.com/
- **GitHub:** https://github.com/crewAIInc/crewAI
- **Exemplos:** https://github.com/crewAIInc/crewAI/tree/main/examples
- **CrewAI Enterprise:** https://www.crewai.com/
- **Templates:** https://docs.crewai.com/concepts/crews/
- **Tools:** https://docs.crewai.com/concepts/tools/
- **Memory:** https://docs.crewai.com/concepts/memory/
- **Flows:** https://docs.crewai.com/concepts/flows/
