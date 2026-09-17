# Agentes Personalizados de IA - Guia Completo 2026

> **Última atualização:** Setembro 2026 | **Status:** Referência técnica completa

---

## Índice

1. Arquitetura de Agentes Personalizados
2. Padrão ReAct
3. Memória de Agentes
4. Sistemas Multi-Agent
5. Personalização com PersonaAgent
6. PAHF (Personalized Agents from Human Feedback)
7. MAPLE Framework
8. AgentBake
9. FABLE Framework
10. Claude Code Sub-agents
11. OpenAI Agents SDK
12. LangGraph
13. CrewAI
14. AutoGen
15. MCP (Model Context Protocol)
16. Human-in-the-Loop
17. Observabilidade de Agentes
18. Segurança de Agentes
19. RAG para Agentes
20. No-Code Agent Builders
21. Agentes Multimodais
22. Deploy e Escala
23. Tendências 2026
24. Fontes e Referências

---

## 1. Arquitetura de Agentes Personalizados

### 1.1 Componentes Fundamentais

Um agente de IA personalizado é composto por quatro pilares:

```
┌─────────────────────────────────────────────┐
│              AGENTE PERSONALIZADO            │
├─────────────┬───────────┬─────────┬─────────┤
│    LLM      │  Tools    │ Memory  │ Planning│
│  (Cérebro)  │ (Mãos)    │ (Lugar) │ (Visão) │
├─────────────┼───────────┼─────────┼─────────┤
│ GPT-4o      │ APIs      │ Curto   │ ReAct   │
│ Claude 4    │ Databases │ Longo   │ ToT     │
│ Gemini 2.5  │ Code Exec │ Episód. │ GoT     │
│ Llama 4     │ Web Search│ Semânt. │ Plan    │
└─────────────┴───────────┴─────────┴─────────┘
```

### 1.2 Padrão Arquitetural em Camadas

```python
class PersonalizedAgent:
    def __init__(self, config: AgentConfig):
        self.llm = self._init_llm(config.model)
        self.memory = MemorySystem(
            short_term=BufferMemory(max_tokens=8192),
            long_term=VectorMemory(db="chromadb", collection=config.agent_id),
            episodic=EpisodicMemory(store="sqlite"),
            semantic=SemanticMemory(graph="neo4j")
        )
        self.tools = ToolRegistry(config.tools)
        self.planner = Planner(
            strategy=config.planning_strategy,  # "react", "tot", "plan-and-solve"
            max_iterations=config.max_steps
        )
        self.guardrails = GuardrailSystem(config.safety_rules)
        self.observer = Observer(config.tracing_config)

    async def run(self, task: str, user_context: dict) -> AgentResponse:
        self.observer.log_start(task)
        context = await self.memory.retrieve_relevant(task)
        plan = await self.planner.create_plan(task, context)

        for step in plan:
            self.observer.log_step(step)
            action = await self.llm.decide(step, self.tools.available())
            if self.guardrails.needs_approval(action):
                action = await self.human_approval(action)
            result = await self.tools.execute(action)
            await self.memory.store(step, result)

        return self._compile_response()
```

### 1.3 Checklist de Design

| Componente | Perguntas-chave | Opções 2026 |
|-----------|----------------|-------------|
| LLM | Latência vs qualidade? | GPT-4o-mini, Claude Haiku, Gemini Flash |
| Memória | Persistência necessária? | Redis, ChromaDB, Pinecone |
| Tools | Quantas integrações? | MCP, function calling, custom |
| Planning | Complexidade do task? | ReAct, Plan-and-Solve, Tree-of-Thought |
| Guardrails | Nível de segurança? | Regex, LLM judge, human approval |

---

## 2. Padrão ReAct

### 2.1 Ciclo Reason + Act

ReAct (Reasoning + Acting) é o padrão mais usado em 2026 para agentes autônomos.

```
Thought → Action → Observation → Thought → Action → ... → Final Answer
```

### 2.2 Implementação Completa

```python
from typing import TypedDict, Annotated
from langgraph.graph import StateGraph, END

class ReActState(TypedDict):
    input: str
    thought: str
    action: str
    action_input: dict
    observation: str
    iterations: int
    final_answer: str

def reason_node(state: ReActState) -> ReActState:
    prompt = f"""
    Task: {state['input']}
    Previous iterations: {state['iterations']}
    Observations: {state.get('observation', 'None yet')}
    
    Think about what to do next. Format:
    Thought: [your reasoning]
    Action: [tool name]
    Action Input: [JSON input]
    """
    response = llm.invoke(prompt)
    parsed = parse_react_output(response)
    return {
        "thought": parsed["thought"],
        "action": parsed["action"],
        "action_input": parsed["action_input"],
        "iterations": state["iterations"] + 1
    }

def act_node(state: ReActState) -> ReActState:
    result = tools.execute(state["action"], state["action_input"])
    return {"observation": str(result)}

def should_continue(state: ReActState) -> str:
    if state.get("final_answer"):
        return "end"
    if state["iterations"] >= 10:
        return "end"
    if state["observation"].startswith("Final Answer:"):
        return "end"
    return "continue"

graph = StateGraph(ReActState)
graph.add_node("reason", reason_node)
graph.add_node("act", act_node)
graph.add_conditional_edges("reason", should_continue, {
    "continue": "act",
    "end": END
})
graph.add_edge("act", "reason")
graph.set_entry_point("reason")

react_agent = graph.compile()
```

### 2.3 MELHORIA

```python
# ❌ ERRADO: Loop infinito sem limite
async def react_loop(task):
    while True:
        thought = await llm.think(task)
        result = await tools.execute(thought.action)
        # Pode rodar para sempre!

# ✅ CORRETO: Com limite e verificação
async def react_loop(task, max_iterations=10):
    for i in range(max_iterations):
        thought = await llm.think(task)
        if thought.is_final:
            return thought.answer
        result = await tools.execute(thought.action)
        task = update_context(task, thought, result)
    return "Max iterations reached"
```

---

## 3. Memória de Agentes

### 3.1 Taxonomia de Memória

```python
class MemorySystem:
    """
    Sistema de memória de 4 camadas para agentes personalizados.
    Referência: MemGPT (Packer et al., 2023), atualizado para 2026.
    """
    
    def __init__(self):
        # Memória de Curto Prazo - Context Window
        self.working_memory = WorkingMemory(max_tokens=16384)
        
        # Memória de Longo Prazo - Vector Database
        self.episodic = EpisodicMemory(
            backend="chromadb",
            embedding_model="text-embedding-3-large",
            collection="agent_experiences"
        )
        
        # Memória Semântica - Knowledge Graph
        self.semantic = SemanticMemory(
            graph_backend="neo4j",
            ontology="agent-knowledge"
        )
        
        # Memória Procedural - How to do things
        self.procedural = ProceduralMemory(
            store="sqlite",
            patterns=["react", "tool-use", "planning"]
        )

    async def retrieve(self, query: str, k: int = 5) -> MemoryContext:
        """Retrieval híbrido: semântico + temporal + relevância."""
        episodic_results = await self.episodic.search(query, k=k)
        semantic_results = await self.semantic.query(query, k=k)
        procedural = await self.procedural.match_pattern(query)
        
        ranked = self._recency_weighted_merge(
            episodic_results, 
            semantic_results,
            temporal_decay=0.95
        )
        return MemoryContext(
            working=self.working_memory.get(),
            long_term=ranked[:k],
            procedural=procedural
        )

    async def store(self, experience: Experience):
        """Armazena experiência com metadata de contexto."""
        await self.episodic.add(
            text=experience.summary,
            metadata={
                "task_type": experience.task_type,
                "success": experience.success,
                "timestamp": datetime.now().isoformat(),
                "user_id": experience.user_id,
                "tools_used": experience.tools_used
            }
        )
```

### 3.2 Padrão MemGPT para Auto-Retrieval

```python
class MemGPTStyleAgent:
    """
    Agente que gerencia sua própria memória como um sistema operacional.
    Baseado no paper MemGPT (ICLR 2024).
    """
    
    CORE_MEMORY = "core_memory"      # Always in context
    ARCHIVAL = "archival_memory"      # Vector DB
    RECALL = "recall_memory"          # Conversation history
    
    async def heartbeat(self, user_message: str):
        """Ciclo principal com gerenciamento automático de memória."""
        context_size = self.working_memory.size()
        
        if context_size > self.context_limit * 0.8:
            # Memória cheia → mover para archival
            old_entries = self.working_memory.evict(keep=5)
            for entry in old_entries:
                await self.archival_memory.insert(
                    entry.text, 
                    entry.metadata
                )
        
        relevant = await self.archival_memory.search(user_message, k=3)
        self.working_memory.inject(relevant)
        
        response = await self.llm.chat(
            system=self._build_system_prompt(),
            messages=self.working_memory.get_messages()
        )
        
        return response
```

### 3.3 MELHORIA

```python
# ❌ ERRADO: Apenas buffer de histórico
memory = SimpleBuffer(max_messages=50)
# Perde contexto antigo, sem busca semântica

# ✅ CORRETO: Memória híbrida com auto-gerenciamento
memory = MemorySystem(
    working=WorkingMemory(max_tokens=8192),
    episodic=EpisodicMemory(backend="chromadb"),
    semantic=SemanticMemory(graph="neo4j"),
    procedural=ProceduralMemory(store="sqlite"),
    auto_consolidate=True
)
```

---

## 4. Sistemas Multi-Agent

### 4.1 Arquiteturas Multi-Agente (2026)

```
┌──────────────────────────────────────────────────┐
│                 ORCHESTRATOR                      │
│            (Router / Manager)                     │
├──────────┬──────────┬──────────┬─────────────────┤
│ Agent A  │ Agent B  │ Agent C  │    Agent D      │
│ Research │ Coder    │ Reviewer │   Planner       │
├──────────┼──────────┼──────────┼─────────────────┤
│ Web Srch │ Code Gen │ Bug Chk  │  Task Decompose │
│ Analysis │ Testing  │ Lint     │  Prioritization │
└──────────┴──────────┴──────────┴─────────────────┘
         ↑                ↑
    Shared Memory    Message Bus
```

### 4.2 Padrões de Comunicação

```python
# Padrão 1: Supervisor (mais comum em 2026)
from langgraph.prebuilt import create_react_agent

supervisor_agent = create_react_agent(
    model="gpt-4o",
    tools=[delegate_to_researcher, delegate_to_coder],
    prompt="You are a supervisor. Delegate tasks to specialists."
)

# Padrão 2: Peer-to-Peer (CrewAI style)
from crewai import Agent, Task, Crew

researcher = Agent(
    role="Research Analyst",
    goal="Find comprehensive information",
    backstory="Expert researcher with 10 years experience",
    tools=[search_tool, scrape_tool],
    llm="gpt-4o"
)

coder = Agent(
    role="Senior Developer",
    goal="Write production-ready code",
    backstory="Full-stack developer specializing in Python/TypeScript",
    tools=[code_exec_tool, git_tool],
    llm="claude-4-sonnet"
)

reviewer = Agent(
    role="Code Reviewer",
    goal="Ensure code quality and security",
    backstory="Security-focused code reviewer",
    tools=[lint_tool, security_scan],
    llm="gpt-4o"
)

# Padrão 3: Debate (para decisões complexas)
class DebateSystem:
    def __init__(self, agents: list, rounds: int = 3):
        self.agents = agents
        self.rounds = rounds
    
    async def debate(self, topic: str) -> str:
        arguments = []
        for round in range(self.rounds):
            for agent in self.agents:
                arg = await agent.argue(topic, arguments)
                arguments.append(arg)
        return await self._synthesize(arguments)
```

### 4.3 AutoGen Pattern

```python
from autogen import AssistantAgent, UserProxyAgent, GroupChat, GroupChatManager

coder = AssistantAgent(
    name="Coder",
    system_message="You are an expert Python developer.",
    llm_config={"model": "gpt-4o"}
)

reviewer = AssistantAgent(
    name="Reviewer",
    system_message="You review code for bugs and improvements.",
    llm_config={"model": "gpt-4o"}
)

user = UserProxyAgent(
    name="User",
    human_input_mode="NEVER",
    code_execution_config={"work_dir": "coding", "use_docker": True}
)

group_chat = GroupChat(
    agents=[user, coder, reviewer],
    messages=[],
    max_round=12
)

manager = GroupChatManager(groupchat=group_chat, llm_config={"model": "gpt-4o"})
user.initiate_chat(manager, message="Write a REST API for user management")
```

---

## 5. Personalização com PersonaAgent

### 5.1 Conceito

PersonaAgent combina memória episódica e semântica para criar agentes que mantêm uma personalidade consistente e aprendem preferências do usuário ao longo do tempo.

```python
class PersonaAgent:
    def __init__(self, persona_config: dict):
        self.persona = Persona(
            name=persona_config["name"],
            traits=persona_config["traits"],       # ["formal", "technical", "patient"]
            communication_style=persona_config["style"],
            expertise_domains=persona_config["domains"]
        )
        self.user_profiles = UserProfileStore()
        self.episodic_memory = EpisodicMemory()
        self.semantic_memory = SemanticMemory()

    async def respond(self, user_id: str, message: str) -> str:
        # 1. Recuperar perfil do usuário
        profile = await self.user_profiles.get(user_id)
        
        # 2. Recuperar experiências passadas
        past = await self.episodic_memory.search(
            query=message,
            filter={"user_id": user_id},
            k=5
        )
        
        # 3. Recuperar conhecimento semântico
        knowledge = await self.semantic_memory.query(
            query=message,
            context=profile.interests
        )
        
        # 4. Gerar resposta personalizada
        response = await self.llm.generate(
            system=self.persona.to_system_prompt(),
            context={
                "user_profile": profile.to_dict(),
                "past_interactions": past,
                "relevant_knowledge": knowledge
            },
            message=message
        )
        
        # 5. Armazenar episódio
        await self.episodic_memory.store(
            user_id=user_id,
            interaction={"user": message, "agent": response},
            metadata={"sentiment": analyze_sentiment(response)}
        )
        
        return response
```

### 5.2 Atualização de Perfil do Usuário

```python
class UserProfileStore:
    async def update(self, user_id: str, interaction: dict):
        profile = await self.get(user_id) or UserProfile(user_id)
        
        # Extrair preferências do comportamento
        preferences = self.extract_preferences(interaction)
        profile.preferences.update(preferences)
        
        # Atualizar frequência de tópicos
        for topic in interaction.get("topics", []):
            profile.topic_frequency[topic] = profile.topic_frequency.get(topic, 0) + 1
        
        # Atualizar estilo preferido
        if interaction.get("feedback"):
            profile.communication_preference = self.infer_style(
                interaction["feedback"]
            )
        
        await self.save(profile)
```

---

## 6. PAHF (Personalized Agents from Human Feedback)

### 6.1 Dois Estágios de Feedback

PAHF introduz dois mecanismos para personalização contínua:

**Pre-action Clarification:** O agente pergunta antes de agir quando tem dúvida.
**Post-action Feedback:** O usuário avalia após o agente agir.

```python
class PAHFAgent:
    def __init__(self, llm, confidence_threshold: float = 0.7):
        self.llm = llm
        self.confidence_threshold = confidence_threshold
        self.feedback_history = []

    async def act(self, task: str, user_id: str) -> Action:
        # 1. Gerar plano de ação
        plan = await self.llm.plan_action(task)
        
        # 2. Verificar confiança
        confidence = self.evaluate_confidence(plan)
        
        # 3. Pre-action clarification se necessário
        if confidence < self.confidence_threshold:
            clarification = await self.generate_clarification(plan)
            user_response = await self.request_clarification(
                user_id, clarification
            )
            plan = await self.refine_plan(plan, user_response)
        
        # 4. Executar ação
        result = await self.execute_action(plan)
        
        # 5. Post-action feedback
        feedback = await self.request_feedback(user_id, result)
        self.store_feedback(user_id, task, plan, result, feedback)
        
        # 6. Aprender com feedback
        await self.update_preferences(user_id, feedback)
        
        return result

    def evaluate_confidence(self, plan: ActionPlan) -> float:
        """Avalia confiança baseada em padrões passados."""
        similar_past = self.feedback_history.filter(
            task_type=plan.task_type,
            action_type=plan.action_type
        )
        if not similar_past:
            return 0.5  # Neutro sem dados
        
        success_rate = sum(1 for f in similar_past if f.positive) / len(similar_past)
        return success_rate
```

---

## 7. MAPLE Framework

### 7.1 Decomposição Memory, Action, Personalization, Learning, Execution

MAPLE (Multi-Agent Personalized Learning Environment) é um framework para agentes que aprendem continuamente.

```python
class MAPLEAgent:
    """
    MAPLE Framework Implementation (2025-2026).
    Reference: "MAPLE: Multi-Agent Personalized Learning Environment"
    """
    
    def __init__(self):
        self.memory = MAPLEMemory()       # Memória de longo prazo estruturada
        self.action_space = ActionSpace() # Ações disponíveis
        self.personalizer = Personalizer()# Motor de personalização
        self.learner = OnlineLearner()    # Aprendizado contínuo
        self.executor = ActionExecutor()  # Execução com rollback
    
    async def process(self, input_data: dict) -> dict:
        # Memory: Recuperar contexto relevante
        context = await self.memory.retrieve(
            query=input_data["query"],
            user_id=input_data["user_id"],
            recency_weight=0.3,
            relevance_weight=0.5,
            diversity_weight=0.2
        )
        
        # Personalization: Adaptar ao perfil do usuário
        persona = self.personalizer.adapt(
            base_prompt=self.system_prompt,
            user_profile=context.user_profile,
            interaction_history=context.history
        )
        
        # Learning: Aprender com padrão atual
        pattern = self.learner.extract_pattern(input_data, context)
        self.memory.consolidate(pattern)
        
        # Action: Decidir e executar
        action = await self.action_space.select(
            context=context,
            persona=persona,
            available_actions=self.tools.list()
        )
        
        result = await self.executor.execute(action, rollback_on_failure=True)
        
        # Armazenar resultado para aprendizado futuro
        await self.memory.store_episode(
            input=input_data,
            action=action,
            result=result,
            feedback=None  # Coletado depois
        )
        
        return result
```

---

## 8. AgentBake

### 8.1 Drop-in Personalization Layer

AgentBake é uma camada de personalização que pode ser adicionada a qualquer agente existente. Usa bandit learning para adaptar comportamento sem re-treinar o LLM.

```python
class AgentBake:
    """
    AgentBake: Drop-in personalization for any LLM agent.
    Uses contextual bandits to learn user preferences.
    """
    
    def __init__(self, base_agent):
        self.base_agent = base_agent
        self.bandit = ContextualBandit(
            n_actions=10,  # Diferentes estilos de resposta
            context_dim=128,
            learning_rate=0.1
        )
        self.user_context_encoder = ContextEncoder()
    
    async def run(self, task: str, user_id: str) -> str:
        # Codificar contexto do usuário
        context = await self.user_context_encoder.encode(user_id)
        
        # Bandit seleciona "estilo" de resposta
        style_idx = self.bandit.select_action(context)
        style = self.STYLES[style_idx]
        
        # Injetar estilo no prompt
        styled_prompt = self.inject_style(task, style)
        
        # Executar agente base
        result = await self.base_agent.run(styled_prompt)
        
        return result
    
    async def update(self, user_id: str, reward: float):
        """Chamar após feedback do usuário."""
        context = await self.user_context_encoder.encode(user_id)
        self.bandit.update(context, self.last_action, reward)
    
    STYLES = [
        "concise", "detailed", "technical", "casual",
        "formal", "educational", "humorous", "empathetic",
        "action-oriented", "analytical"
    ]
```

---

## 9. FABLE (Factorized Adaptive Bandit Layer for Execution)

### 9.1 Arquitetura FABLE

FABLE decompõe decisões em fatores e usa bandits adaptativos por fator.

```python
class FABLELayer:
    """
    FABLE: Factorized Adaptive Bandit Layer for Execution.
    Decomposes agent decisions into independent factors,
    each optimized by a separate bandit.
    """
    
    def __init__(self):
        self.factor_bandits = {
            "tone": ThompsonSampling(n_arms=6),
            "verbosity": ThompsonSampling(n_arms=4),
            "tool_selection": ThompsonSampling(n_arms=8),
            "response_format": ThompsonSampling(n_arms=5),
            "complexity_level": ThompsonSampling(n_arms=3)
        }
        self.context_encoder = FactorEncoder()
    
    async def select_action(self, task: str, user_context: dict) -> dict:
        factors = self.context_encoder.encode(task, user_context)
        
        selected = {}
        for factor_name, bandit in self.factor_bandits.items():
            arm = bandit.select(factors[factor_name])
            selected[factor_name] = self.translate_arm(factor_name, arm)
        
        return selected
    
    def translate_arm(self, factor: str, arm: int) -> str:
        translations = {
            "tone": ["friendly", "professional", "empathetic", "neutral", "enthusiastic", "calm"],
            "verbosity": ["terse", "moderate", "detailed", "comprehensive"],
            "tool_selection": ["auto", "search", "code", "db", "api", "file", "web", "none"],
            "response_format": ["text", "markdown", "json", "code_block", "list"],
            "complexity_level": ["beginner", "intermediate", "advanced"]
        }
        return translations[factor][arm]
```

---

## 10. Claude Code Sub-agents

### 10.1 Custom Sub-agents

Claude Code permite criar sub-agentes especializados com ferramentas e permissões próprias.

```python
# Configuração de sub-agente Claude Code (.claude/agents/)
# Arquivo: .claude/agents/code-reviewer.md

"""
# Code Reviewer Agent

You are a specialized code review agent. Your ONLY job is to review code.

## Tools Allowed
- Read files
- Search codebase
- Run linters
- Run type checkers

## Tools NOT Allowed  
- Edit files
- Write files
- Run destructive commands

## Behavior
1. Always look for: security vulnerabilities, performance issues, bugs
2. Rate severity: critical, high, medium, low
3. Provide fix suggestions with code snippets
4. Never approve code with critical issues
"""

# Uso no agente principal
class ClaudeCodeOrchestrator:
    def __init__(self):
        self.sub_agents = {
            "reviewer": SubAgent(
                name="code-reviewer",
                config=".claude/agents/code-reviewer.md",
                permissions=["read", "search", "lint"]
            ),
            "coder": SubAgent(
                name="coder",
                config=".claude/agents/coder.md",
                permissions=["read", "write", "edit", "bash"]
            ),
            "tester": SubAgent(
                name="tester",
                config=".claude/agents/tester.md",
                permissions=["read", "bash"]
            )
        }
    
    async def workflow(self, task: str):
        code = await self.sub_agents["coder"].run(f"Implement: {task}")
        review = await self.sub_agents["reviewer"].run(f"Review: {code}")
        
        if review.has_critical_issues:
            code = await self.sub_agents["coder"].run(
                f"Fix critical issues: {review.issues}"
            )
        
        tests = await self.sub_agents["tester"].run(f"Test: {code}")
        return {"code": code, "review": review, "tests": tests}
```

### 10.2 Memory Persistente entre Sessions

```python
# Claude Code memory via CLAUDE.md
# Arquivo: CLAUDE.md

"""
# Project Memory

## Conventions
- Use TypeScript strict mode
- All APIs follow REST patterns
- Tests in __tests__/ directories
- Error handling: custom AppError class

## Active Refactors
- Migrating from Express to Hono (in progress)
- Moving from Jest to Vitest (completed)

## User Preferences  
- Prefers concise commits
- Wants all functions typed
- Uses British English in docs
"""
```

---

## 11. OpenAI Agents SDK

### 11.1 Harness e Sandbox

```python
from agents import Agent, Runner, function_tool, guardrail

@function_tool
def get_weather(city: str) -> str:
    """Get current weather for a city."""
    # API call
    return f"Weather in {city}: 25°C, sunny"

@guardrail
def check_city_name(ctx, agent, input_data):
    """Ensure city name is valid."""
    valid_cities = ["São Paulo", "Rio de Janeiro", "Tokyo", "New York"]
    if input_data["city"] not in valid_cities:
        return guardrail.GuardrailResult(
            tripwire_triggered=True,
            message=f"Invalid city. Valid: {valid_cities}"
        )
    return guardrail.GuardrailResult(tripwire_triggered=False)

weather_agent = Agent(
    name="Weather Assistant",
    instructions="You help users with weather information.",
    model="gpt-4o",
    tools=[get_weather],
    guardrails=[check_city_name]
)

# Runner com sandbox
result = Runner.run_sync(
    weather_agent,
    "What's the weather in Tokyo?",
    sandbox=SandboxConfig(
        enabled=True,
        timeout=30,
        memory_limit="256MB"
    )
)
```

### 11.2 Handoffs (Multi-Agent)

```python
from agents import Agent, Runner

triage_agent = Agent(
    name="Triage",
    instructions="Route users to the right specialist.",
    model="gpt-4o",
    handoffs=["billing_agent", "technical_agent", "sales_agent"]
)

billing_agent = Agent(
    name="Billing",
    instructions="Handle billing and payment questions.",
    model="gpt-4o"
)

technical_agent = Agent(
    name="Technical",
    instructions="Handle technical support issues.",
    model="gpt-4o"
)

result = Runner.run_sync(
    triage_agent,
    "I have a question about my last invoice"
)
```

---

## 12. LangGraph

### 12.1 StateGraph com Roteamento Condicional

```python
from langgraph.graph import StateGraph, END
from typing import TypedDict, Annotated
import operator

class AgentState(TypedDict):
    messages: Annotated[list, operator.add]
    next: str
    iterations: int

def research_node(state: AgentState) -> AgentState:
    response = research_llm.invoke(state["messages"])
    return {"messages": [response], "iterations": state["iterations"] + 1}

def code_node(state: AgentState) -> AgentState:
    response = code_llm.invoke(state["messages"])
    return {"messages": [response]}

def router(state: AgentState) -> str:
    last_message = state["messages"][-1].content
    if "research" in last_message.lower():
        return "research"
    elif "code" in last_message.lower():
        return "code"
    elif state["iterations"] > 5:
        return "end"
    return "end"

# Build graph
workflow = StateGraph(AgentState)
workflow.add_node("research", research_node)
workflow.add_node("code", code_node)
workflow.add_conditional_edges("research", router, {
    "research": "research",
    "code": "code",
    "end": END
})
workflow.add_conditional_edges("code", router, {
    "research": "research",
    "code": "code",
    "end": END
})
workflow.set_entry_point("research")

# Com checkpointing
from langgraph.checkpoint.sqlite import SqliteSaver
checkpointer = SqliteSaver.from_conn_string(":memory:")
app = workflow.compile(checkpointer=checkpointer)

# Run com persistência
config = {"configurable": {"thread_id": "user-123"}}
result = app.invoke({"messages": [user_msg], "iterations": 0}, config)
```

### 12.2 Human-in-the-Loop com LangGraph

```python
from langgraph.graph import StateGraph, END
from langgraph.types import Interrupt

def sensitive_action(state: AgentState) -> AgentState:
    # Pausa e aguarda aprovação humana
    approval = Interrupt(
        value={
            "action": "delete_record",
            "record_id": state["record_id"],
            "reason": "User requested deletion"
        }
    )
    return {"approval": approval}

# No frontend, aprovar/rejeitar
def resume_with_approval(thread_id: str, approved: bool):
    config = {"configurable": {"thread_id": thread_id}}
    if approved:
        app.invoke(Command(resume={"approved": True}), config)
    else:
        app.invoke(Command(resume={"approved": False}), config)
```

---

## 13. CrewAI

### 13.1 Crew com Memória e Delegação

```python
from crewai import Agent, Task, Crew, Process
from crewai.memory import LongTermMemory, ShortTermMemory, EntityMemory

# Configurar memória
long_term_memory = LongTermMemory(
    storage="sqlite",
    path="./memory/long_term.db"
)
short_term_memory = ShortTermMemory(
    storage="redis",
    host="localhost"
)
entity_memory = EntityMemory(
    storage="chromadb",
    collection="entities"
)

# Definir agentes
researcher = Agent(
    role="Senior Research Analyst",
    goal="Uncover cutting-edge developments in AI",
    backstory="You are an expert researcher at a leading tech think tank.",
    tools=[search_tool, scrape_tool],
    llm="gpt-4o",
    verbose=True,
    allow_delegation=True
)

writer = Agent(
    role="Tech Content Strategist",
    goal="Craft compelling content on tech advancements",
    backstory="You are a renowned Content Strategist.",
    llm="claude-4-sonnet",
    verbose=True
)

# Definir tarefas
research_task = Task(
    description="Research the latest AI agent frameworks in 2026",
    expected_output="Comprehensive report with pros/cons comparison",
    agent=researcher,
    context=[research_task]
)

write_task = Task(
    description="Write a blog post based on the research",
    expected_output="1500-word blog post in markdown",
    agent=writer,
    context=[research_task]
)

# Montar crew
crew = Crew(
    agents=[researcher, writer],
    tasks=[research_task, write_task],
    process=Process.sequential,
    memory=True,
    long_term_memory=long_term_memory,
    short_term_memory=short_term_memory,
    entity_memory=entity_memory,
    verbose=True
)

result = crew.kickoff(inputs={"topic": "AI Agent Frameworks 2026"})
```

---

## 14. AutoGen

### 14.1 ConversableAgent com Code Execution

```python
from autogen import (
    AssistantAgent, 
    UserProxyAgent,
    GroupChat,
    GroupChatManager,
    config_list_from_json
)

config_list = config_list_from_json(env_or_file="OAI_CONFIG_LIST")

# Criar agentes
assistant = AssistantAgent(
    name="assistant",
    system_message="You are a helpful AI assistant.",
    llm_config={"config_list": config_list, "temperature": 0.7}
)

# Proxy com execução de código
user_proxy = UserProxyAgent(
    name="user_proxy",
    human_input_mode="NEVER",
    max_consecutive_auto_reply=10,
    is_termination_msg=lambda x: x.get("content", "").rstrip().endswith("TERMINATE"),
    code_execution_config={
        "work_dir": "tmp",
        "use_docker": True,  # Sandboxing
        "timeout": 120
    }
)

# Chat bidirecional
user_proxy.initiate_chat(
    assistant,
    message="Write a Python function to calculate fibonacci and test it."
)
```

### 14.2 GroupChat para Discussão

```python
analyst = AssistantAgent(
    name="data_analyst",
    system_message="You analyze data and provide insights.",
    llm_config={"config_list": config_list}
)

critic = AssistantAgent(
    name="critic",
    system_message="You critically evaluate proposals and find weaknesses.",
    llm_config={"config_list": config_list}
)

facilitator = AssistantAgent(
    name="facilitator",
    system_message="You moderate discussions and ensure consensus.",
    llm_config={"config_list": config_list}
)

groupchat = GroupChat(
    agents=[user_proxy, analyst, critic, facilitator],
    messages=[],
    max_round=15,
    speaker_selection_method="auto"
)

manager = GroupChatManager(groupchat=groupchat, llm_config={"config_list": config_list})
user_proxy.initiate_chat(manager, message="Should we migrate from MongoDB to PostgreSQL?")
```

---

## 15. MCP (Model Context Protocol)

### 15.1 Padrão de Integração de Ferramentas

MCP é o padrão aberto (Anthropic, 2024-2026) para conectar LLMs a ferramentas e dados externos.

```python
# Servidor MCP em Python
from mcp import Server, Tool, Resource
import mcp.types as types

server = Server("my-tools")

@server.tool()
async def database_query(query: str) -> str:
    """Execute a read-only SQL query."""
    result = await db.execute(query)
    return str(result)

@server.tool()
async def file_read(path: str) -> str:
    """Read file contents."""
    with open(path, "r") as f:
        return f.read()

@server.resource("config://app")
async def get_config() -> str:
    """Return application configuration."""
    return json.dumps(app_config)

# Configuração no cliente (Claude, etc.)
{
    "mcpServers": {
        "database": {
            "command": "python",
            "args": ["-m", "mcp_server_db"],
            "env": {"DB_URL": "postgresql://localhost/mydb"}
        },
        "filesystem": {
            "command": "npx",
            "args": ["-y", "@modelcontextprotocol/server-filesystem", "/path/to/files"]
        }
    }
}
```

### 15.2 Cliente MCP para Agentes Customizados

```python
from mcp import ClientSession, StdioServerParameters
from mcp.client.stdio import stdio_client

class MCPAgent:
    def __init__(self):
        self.servers = {}
        self.tools = []
    
    async def connect_server(self, name: str, config: dict):
        server_params = StdioServerParameters(
            command=config["command"],
            args=config.get("args", []),
            env=config.get("env", {})
        )
        
        read_stream, write_stream = await stdio_client(server_params)
        session = ClientSession(read_stream, write_stream)
        await session.initialize()
        
        # Listar ferramentas disponíveis
        tools = await session.list_tools()
        self.tools.extend([
            MCPTool(name=f"{name}:{t.name}", session=session, schema=t.inputSchema)
            for t in tools.tools
        ])
        
        self.servers[name] = session
    
    async def use_tool(self, tool_name: str, **kwargs) -> str:
        tool = next(t for t in self.tools if t.name == tool_name)
        result = await tool.session.call_tool(tool.original_name, kwargs)
        return result.content[0].text
```

---

## 16. Human-in-the-Loop

### 16.1 Padrões de Aprovação

```python
from enum import Enum

class ApprovalLevel(Enum):
    NONE = "none"           # Sem aprovação
    NOTIFICATION = "notify" # Apenas notifica
    CONFIRMATION = "confirm"# Pede confirmação
    EXPLICIT = "explicit"   # Requer input detalhado

class HumanInTheLoop:
    def __init__(self):
        self.rules = {
            "file.delete": ApprovalLevel.EXPLICIT,
            "file.write": ApprovalLevel.CONFIRMATION,
            "api.call": ApprovalLevel.CONFIRMATION,
            "search": ApprovalLevel.NONE,
            "read": ApprovalLevel.NONE,
            "email.send": ApprovalLevel.EXPLICIT,
            "payment": ApprovalLevel.EXPLICIT,
        }
    
    async def check(self, action: str, context: dict) -> bool:
        level = self.rules.get(action, ApprovalLevel.CONFIRMATION)
        
        if level == ApprovalLevel.NONE:
            return True
        elif level == ApprovalLevel.NOTIFICATION:
            await self.notify(context)
            return True
        elif level == ApprovalLevel.CONFIRMATION:
            return await self.request_confirmation(context)
        elif level == ApprovalLevel.EXPLICIT:
            return await self.request_explicit_approval(context)
    
    async def request_confirmation(self, context: dict) -> bool:
        """Pede confirmação simples (sim/não)."""
        response = await self.interface.confirm(
            message=f"Approve: {context['description']}?",
            details=context.get("details", {})
        )
        return response.approved
    
    async def request_explicit_approval(self, context: dict) -> bool:
        """Pede aprovação com justificativa."""
        response = await self.interface.approve_with_reason(
            message=f"Action requires approval: {context['description']}",
            risk_level=context.get("risk_level", "high"),
            reversible=context.get("reversible", False)
        )
        return response.approved and response.reason is not None
```

### 16.2 Guardrails

```python
class GuardrailSystem:
    def __init__(self):
        self.rules = []
        self.add_rule(ContentFilter(
            blocked_patterns=["password", "secret", "api_key"],
            action="block"
        ))
        self.add_rule(SizeLimit(max_tokens=100000, action="truncate"))
        self.add_rule(RateLimiter(max_per_minute=60, action="queue"))
        self.add_rule(LLMJudge(
            criteria=["safety", "appropriateness", "accuracy"],
            threshold=0.8
        ))
    
    async def validate(self, content: str, context: dict) -> GuardrailResult:
        for rule in self.rules:
            result = await rule.check(content, context)
            if result.blocked:
                return result
        return GuardrailResult(passed=True)
```

---

## 17. Observabilidade de Agentes

### 17.1 Tracing e Logging

```python
import logging
from opentelemetry import trace
from opentelemetry.sdk.trace import TracerProvider
from opentelemetry.sdk.trace.export import BatchSpanProcessor

# Setup tracing
provider = TracerProvider()
processor = BatchSpanProcessor(OTLPExporter())
provider.add_span_processor(processor)
trace.set_tracer_provider(provider)
tracer = trace.get_tracer("agent-tracer")

class AgentObserver:
    def __init__(self, agent_id: str):
        self.agent_id = agent_id
        self.logger = logging.getLogger(f"agent.{agent_id}")
    
    async def trace_step(self, step_name: str, input_data: dict):
        with tracer.start_as_current_span(f"agent.{step_name}") as span:
            span.set_attribute("agent.id", self.agent_id)
            span.set_attribute("step.name", step_name)
            span.set_attribute("input.size", len(str(input_data)))
            
            self.logger.info(
                f"Step: {step_name}",
                extra={
                    "agent_id": self.agent_id,
                    "input_preview": str(input_data)[:200],
                    "trace_id": span.get_span_context().trace_id
                }
            )
            
            yield span  # Para adicionar atributos durante execução
    
    async def log_decision(self, decision: dict):
        self.logger.info(
            "Agent decision",
            extra={
                "action": decision["action"],
                "confidence": decision.get("confidence"),
                "reasoning": decision.get("reasoning", "")[:500],
                "tools_available": decision.get("tools_count", 0)
            }
        )
```

### 17.2 LangSmith Integration

```python
from langsmith import Client
from langsmith.run_helpers import trace

ls_client = Client()

@trace(name="agent_main_loop")
async def agent_main(task: str):
    # LangSmith captura automaticamente
    plan = await planner.create_plan(task)
    result = await executor.run(plan)
    
    # Adicionar metadata customizada
    from langsmith.run_helpers import get_current_run_tree
    rt = get_current_run_tree()
    rt.extra["metadata"]["task_type"] = classify_task(task)
    rt.extra["metadata"]["tools_used"] = len(plan.steps)
    
    return result
```

---

## 18. Segurança de Agentes

### 18.1 Modelo de Permissões

```python
class PermissionSystem:
    def __init__(self):
        self.roles = {
            "admin": {"*": "allow"},
            "developer": {
                "read": "allow",
                "write": "allow",
                "bash": "allow",
                "deploy": "confirm",
                "delete": "deny"
            },
            "viewer": {
                "read": "allow",
                "*": "deny"
            }
        }
    
    def check(self, role: str, action: str, resource: str) -> str:
        permissions = self.roles.get(role, {})
        
        # Exact match
        if action in permissions:
            return permissions[action]
        
        # Wildcard
        if "*" in permissions:
            return permissions["*"]
        
        return "deny"

class Sandbox:
    def __init__(self):
        self.allowed_paths = ["/workspace", "/tmp"]
        self.blocked_commands = ["rm -rf", "sudo", "chmod 777"]
    
    def validate_command(self, cmd: str) -> bool:
        for blocked in self.blocked_commands:
            if blocked in cmd:
                return False
        return True
    
    def validate_path(self, path: str) -> bool:
        return any(path.startswith(p) for p in self.allowed_paths)
```

### 18.2 Sandboxing com Docker

```python
class DockerSandbox:
    def __init__(self):
        self.docker = docker.from_env()
    
    async def execute(self, code: str, language: str = "python") -> str:
        image = f"agent-sandbox:{language}"
        
        container = self.docker.containers.run(
            image,
            command=f"execute {code}",
            detach=True,
            mem_limit="256m",
            cpu_period=100000,
            cpu_quota=50000,  # 50% CPU
            network_disabled=True,
            read_only=True,
            tmpfs={"/tmp": "size=64m"}
        )
        
        try:
            result = container.wait(timeout=30)
            logs = container.logs().decode()
            return logs
        finally:
            container.remove(force=True)
```

---

## 19. RAG para Agentes

### 19.1 Agentic RAG Pipeline

```python
class AgenticRAG:
    def __init__(self):
        self.retriever = HybridRetriever(
            vector_store="chromadb",
            bm25_index="elastic",
            reranker="cohere"
        )
        self.llm = ChatLLM(model="gpt-4o")
        self.query_planner = QueryPlanner()
    
    async def answer(self, question: str, context: dict) -> RAGResponse:
        # 1. Decompor query complexa em sub-queries
        sub_queries = await self.query_planner.decompose(question)
        
        # 2. Recuperar para cada sub-query
        all_docs = []
        for sq in sub_queries:
            docs = await self.retriever.retrieve(
                query=sq,
                top_k=5,
                filters=context.get("filters")
            )
            all_docs.extend(docs)
        
        # 3. Deduplicar e re-rankear
        unique_docs = self.deduplicate(all_docs)
        reranked = await self.retriever.rerank(
            question, unique_docs, top_k=10
        )
        
        # 4. Verificar se precisa de mais informação
        completeness = await self.assess_completeness(question, reranked)
        
        if completeness < 0.7:
            # Query expandida
            expanded = await self.expand_query(question, reranked)
            additional = await self.retriever.retrieve(expanded, top_k=5)
            reranked.extend(additional)
        
        # 5. Gerar resposta com citações
        response = await self.llm.generate(
            system="Answer based ONLY on provided context. Cite sources.",
            context=reranked,
            question=question
        )
        
        return RAGResponse(
            answer=response.content,
            sources=[doc.metadata["source"] for doc in reranked],
            confidence=self.estimate_confidence(response, reranked)
        )
```

---

## 20. No-Code Agent Builders

### 20.1 Comparativo de Plataformas

| Plataforma | Tipo | Agentes | Deploy | Preço |
|-----------|------|---------|--------|-------|
| **n8n** | Self-hosted/Cloud | Visual workflow | Docker/Vercel | Free / $20/mês |
| **Dify** | Open-source | Visual + Code | Docker/K8s | Free / Enterprise |
| **Flowise** | Open-source | LangChain visual | Docker/Vercel | Free |
| **Coze** | ByteDance | Bot builder | Cloud only | Free tier |
| **OpenAI GPTs** | Cloud | Custom GPTs | ChatGPT | Free / $20/mês |
| **Anthropic Claude Projects** | Cloud | Projects | claude.ai | Free / $20/mês |

### 20.2 Exemplo: Agente n8n

```json
{
  "nodes": [
    {
      "type": "n8n-nodes-base.webhook",
      "name": "Webhook",
      "parameters": {"httpMethod": "POST", "path": "agent"}
    },
    {
      "type": "n8n-nodes-base.openAi",
      "name": "LLM",
      "parameters": {
        "model": "gpt-4o",
        "messages": "={{$json.messages}}",
        "tools": "={{$json.tools}}"
      }
    },
    {
      "type": "n8n-nodes-base.code",
      "name": "Tool Router",
      "parameters": {
        "jsCode": "const tool = $input.first().json.tool_calls[0]; return [{json: tool}];"
      }
    },
    {
      "type": "n8n-nodes-base.httpRequest",
      "name": "Execute Tool",
      "parameters": {
        "url": "={{$json.url}}",
        "method": "={{$json.method}}",
        "body": "={{$json.params}}"
      }
    }
  ],
  "connections": {
    "Webhook": {"main": [[{"node": "LLM", "type": "main", "index": 0}]]},
    "LLM": {"main": [[{"node": "Tool Router", "type": "main", "index": 0}]]},
    "Tool Router": {"main": [[{"node": "Execute Tool", "type": "main", "index": 0}]]}
  }
}
```

---

## 21. Agentes Multimodais

### 21.1 Processamento de Voz, Imagem e Vídeo

```python
class MultimodalAgent:
    def __init__(self):
        self.voice = VoiceProcessor(
            stt="whisper-large-v3",
            tts="elevenlabs"
        )
        self.vision = VisionProcessor(
            model="gpt-4o",
            ocr="tesseract"
        )
        self.video = VideoProcessor(
            frame_extractor="ffmpeg",
            analyzer="gpt-4o"
        )
    
    async def process_input(self, input_data: MultimodalInput) -> str:
        # Processar baseado no tipo
        if input_data.has_audio:
            text = await self.voice.transcribe(input_data.audio)
            input_data.text = text
        
        if input_data.has_images:
            image_analysis = []
            for img in input_data.images:
                analysis = await self.vision.analyze(img)
                image_analysis.append(analysis)
            input_data.image_context = image_analysis
        
        if input_data.has_video:
            keyframes = await self.video.extract_keyframes(input_data.video)
            video_context = await self.video.analyze_frames(keyframes)
            input_data.video_context = video_context
        
        # Gerar resposta multimodal
        response = await self.llm.generate_multimodal(
            text=input_data.text,
            images=input_data.images,
            audio_context=input_data.audio_context,
            video_context=input_data.video_context
        )
        
        # Resposta pode incluir imagem ou áudio
        if input_data.expect_visual:
            response.image = await self.generate_image(response.text)
        if input_data.expect_audio:
            response.audio = await self.voice.synthesize(response.text)
        
        return response
```

---

## 22. Deploy e Escala

### 22.1 Padrões de Produção

```python
# docker-compose.yml para agente em produção
"""
services:
  agent-api:
    build: .
    ports:
      - "8000:8000"
    environment:
      - OPENAI_API_KEY=${OPENAI_API_KEY}
      - REDIS_URL=redis://redis:6379
      - DATABASE_URL=postgresql://db:5432/agents
    deploy:
      replicas: 3
      resources:
        limits:
          memory: 1G
          cpus: "0.5"
    
  redis:
    image: redis:7-alpine
    volumes:
      - redis_data:/data
  
  db:
    image: postgres:16-alpine
    volumes:
      - pg_data:/var/lib/postgresql/data
  
  worker:
    build: .
    command: celery -A agent worker --concurrency=4
    depends_on:
      - redis
      - db
  
  monitor:
    image: grafana/grafana
    ports:
      - "3000:3000"
"""
```

### 22.2 Otimização de Custo

```python
class CostOptimizer:
    def __init__(self):
        self.model_tiers = {
            "simple": {"model": "gpt-4o-mini", "cost_per_1k": 0.00015},
            "medium": {"model": "gpt-4o", "cost_per_1k": 0.005},
            "complex": {"model": "claude-4-opus", "cost_per_1k": 0.015}
        }
        self.cache = RedisCache(ttl=3600)
    
    async def route(self, task: str) -> str:
        # Cache hit?
        cached = await self.cache.get(task)
        if cached:
            return cached
        
        # Classificar complexidade
        complexity = await self.classify_complexity(task)
        
        # Rotear para modelo apropriado
        if complexity < 0.3:
            tier = "simple"
        elif complexity < 0.7:
            tier = "medium"
        else:
            tier = "complex"
        
        model = self.model_tiers[tier]["model"]
        result = await self.call_model(model, task)
        
        # Cache resultado
        await self.cache.set(task, result)
        
        return result
    
    def estimate_cost(self, task: str) -> dict:
        tokens = estimate_tokens(task)
        return {
            "simple": tokens * self.model_tiers["simple"]["cost_per_1k"] / 1000,
            "medium": tokens * self.model_tiers["medium"]["cost_per_1k"] / 1000,
            "complex": tokens * self.model_tiers["complex"]["cost_per_1k"] / 1000
        }
```

### 22.3 Monitoramento

```python
from prometheus_client import Counter, Histogram, Gauge

# Métricas
REQUEST_COUNT = Counter("agent_requests_total", "Total requests", ["agent_id", "status"])
REQUEST_LATENCY = Histogram("agent_request_duration_seconds", "Request latency")
ACTIVE_AGENTS = Gauge("agent_active_count", "Active agents")
TOOL_USAGE = Counter("agent_tool_usage_total", "Tool usage", ["tool_name"])
COST_TRACKER = Counter("agent_cost_dollars", "Cost in dollars", ["model"])

class MetricsMiddleware:
    async def __call__(self, request, call_next):
        ACTIVE_AGENTS.inc()
        start = time.time()
        
        try:
            response = await call_next(request)
            REQUEST_COUNT.labels(agent_id=request.agent_id, status="success").inc()
            return response
        except Exception as e:
            REQUEST_COUNT.labels(agent_id=request.agent_id, status="error").inc()
            raise
        finally:
            duration = time.time() - start
            REQUEST_LATENCY.observe(duration)
            ACTIVE_AGENTS.dec()
```

---

## 23. Tendências 2026

### 23.1 Small Language Models (SLMs)

- **Phi-4** (Microsoft): 14B params, performance próxima a GPT-4 em tarefas específicas
- **Gemma 3** (Google): Open-source, otimizado para edge devices
- **Llama 4** (Meta): 400B+ params, open-weight, competitivo com modelos fechados
- **Qwen 3** (Alibaba): Multilingual, forte em ásia-pacífico

**Impacto:** Agentes rodando em dispositivos locais, menor latência, custo zero para inferência.

### 23.2 MCP Standardization

- MCP tornou-se padrão de facto para integração de ferramentas
- Todos os principais provedores suportam MCP nativamente
- Marketplaces de servidores MCP emergindo (MCP Hub, Toolhouse)

### 23.3 Agent Marketplaces

```python
# Conceito de Agent Marketplace (2026)
agent_marketplace = {
    "categories": [
        "Customer Support",
        "Data Analysis",
        "Code Generation",
        "Content Creation",
        "Research",
        "Automation"
    ],
    "pricing_models": [
        "per_query",
        "subscription",
        "usage_based",
        "freemium"
    ],
    "examples": [
        "Vercel AI SDK Agent Marketplace",
        "LangChain Hub",
        "HuggingFace Agent Hub",
        "CrewAI Enterprise Agents"
    ]
}
```

### 23.4 Outras Tendências

- **Agentic Coding:** Claude Code, Cursor, Windsurf como IDEs nativas para agentes
- **Memory Persistence:** MemGPT v2, Zep, Letta como padrões de memória de longo prazo
- **Evaluation:** Benchmarks como AgentBench, SWE-bench, GAIA para avaliar agentes
- **Regulation:** EU AI Act implementando requisitos para agentes autônomos
- **Multimodal Agents:** GPT-4o, Gemini 2.5 como base para agentes com visão/áudio
- **Edge Agents:** SLMs rodando em dispositivos IoT e móveis

---

## 24. Fontes e Referências

### Papers Acadêmicos

1. **ReAct:** Yao et al., "ReAct: Synergizing Reasoning and Acting in Language Models" (ICLR 2023)
2. **MemGPT:** Packer et al., "MemGPT: Towards LLMs as Operating Systems" (ICLR 2024)
3. **PAHF:** Zhang et al., "Personalized Agents from Human Feedback" (NeurIPS 2025)
4. **MAPLE:** Liu et al., "MAPLE: Multi-Agent Personalized Learning Environment" (2025)
5. **AgentBake:** Chen et al., "AgentBake: Drop-in Personalization for LLM Agents" (2025)
6. **FABLE:** Wang et al., "Factorized Adaptive Bandit Layer for Agent Execution" (2026)
7. **Tree of Thought:** Yao et al., "Tree of Thoughts: Deliberate Problem Solving" (NeurIPS 2023)
8. **LATS:** Zhou et al., "Language Agent Tree Search" (ICML 2024)

### Frameworks e Bibliotecas

9. **LangGraph:** https://github.com/langchain-ai/langgraph
10. **CrewAI:** https://github.com/crewAIInc/crewAI
11. **AutoGen:** https://github.com/microsoft/autogen
12. **OpenAI Agents SDK:** https://github.com/openai/openai-agents-python
13. **MCP:** https://modelcontextprotocol.io
14. **Claude Code:** https://docs.anthropic.com/en/docs/claude-code
15. **Dify:** https://github.com/langgenius/dify
16. **n8n:** https://github.com/n8n-io/n8n

### Documentação e Guias

17. **Anthropic Prompt Engineering:** https://docs.anthropic.com/en/docs/build-with-claude/prompt-engineering
18. **OpenAI Cookbook:** https://cookbook.openai.com
19. **LangChain Documentation:** https://python.langchain.com
20. **Google AI Edge:** https://ai.google.dev/edge

### Benchmarks

21. **SWE-bench:** https://www.swebench.com
22. **AgentBench:** https://github.com/THUDM/AgentBench
23. **GAIA:** https://huggingface.co/gaia-benchmark
24. **τ-bench:** https://github.com/sierra-research/tau-bench

---

> **Nota:** Este documento é uma referência técnica abrangente. Para implementação específica, consulte a documentação oficial de cada framework e as melhores práticas atualizadas de cada ferramenta.

---

*Gerado em: Setembro 2026 | Manutenção: Atualizar trimestralmente com novos papers e releases*
