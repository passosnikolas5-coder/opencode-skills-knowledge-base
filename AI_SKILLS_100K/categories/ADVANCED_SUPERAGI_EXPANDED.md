# 🦸 SuperAGI - Framework de Agentes Autônomos

> **Fonte:** https://github.com/TransformerOptimus/SuperAGI (17k+ stars)
> **Descrição:** SuperAGI é um framework de agentes autônomos de código aberto que permite criar, gerenciar e executar agentes de IA com ferramentas, memória e workflows personalizados.

---

## 📋 Índice de Skills

| # | Skill | Categoria |
|---|-------|-----------|
| 1 | Configuração do Ambiente | Setup |
| 2 | Criação de Agentes | Agentes |
| 3 | Configuração de Tools | Tools |
| 4 | Integração Vector DB | Vector DB |
| 5 | Sistema de Memória | Memória |
| 6 | Spawning de Agentes | Multi-Agent |
| 7 | Workflows de Agentes | Workflow |
| 8 | Loop Ação/Observação | A/O Loop |
| 9 | Navegação Web | Web |
| 10 | Interpretação de Código | Code |
| 11 | Operações com Arquivos | Files |
| 12 | Gestão de Knowledge Base | Knowledge |
| 13 | Alocação de Recursos | Resources |
| 14 | Fine-Tuning | Fine-Tuning |
| 15 | Dashboard UI | UI |

---

## 1. ⚙️ Configuração do Ambiente

### Setup Básico do SuperAGI

```bash
# Clone do repositório
git clone https://github.com/TransformerOptimus/SuperAGI.git
cd SuperAGI

# Instalação via Docker
docker-compose up -d

# Ou instalação manual
pip install -r requirements.txt
```

```python
# config.py
import os
from pathlib import Path

class SuperAGIConfig:
    """Configuração do SuperAGI"""

    def __init__(self):
        self.base_dir = Path(__file__).parent
        self.config_path = self.base_dir / "config.yaml"

    def load_config(self):
        """Carrega configuração"""
        import yaml

        default_config = {
            "openai_api_key": os.getenv("OPENAI_API_KEY"),
            "anthropic_api_key": os.getenv("ANTHROPIC_API_KEY"),
            "pinecone_api_key": os.getenv("PINECONE_API_KEY"),
            "vector_db": "pinecone",
            "embedding_model": "text-embedding-ada-002",
            "max_tokens": 4000,
            "temperature": 0.7
        }

        if self.config_path.exists():
            with open(self.config_path, "r") as f:
                user_config = yaml.safe_load(f)
                default_config.update(user_config)

        return default_config

config = SuperAGIConfig()
print(f"Configuração carregada: {config.load_config().keys()}")
```

### 📌 MELHORIA

❌ **ERRADO:**
```python
# Configuração hardcoded e insegura
import os
os.environ["OPENAI_API_KEY"] = "sk-chave-exposta"

# Não usar variáveis de ambiente
config = {
    "api_key": "sk-chave-direta",
    "model": "gpt-4"
}
```

✅ **CORRETO:**
```python
# Configuração segura com validação
import os
from pathlib import Path
from typing import Optional

class SecureConfig:
    """Configuração segura do SuperAGI"""

    def __init__(self):
        self._validate_environment()

    def _validate_environment(self):
        """Valida variáveis de ambiente necessárias"""
        required = ["OPENAI_API_KEY"]
        missing = [var for var in required if not os.getenv(var)]

        if missing:
            raise EnvironmentError(
                f"Variáveis de ambiente faltando: {missing}"
            )

    def get_api_key(self, provider: str = "openai") -> Optional[str]:
        """Obtém chave de API de forma segura"""
        env_var = f"{provider.upper()}_API_KEY"
        return os.getenv(env_var)

    def get_config(self) -> dict:
        """Retorna configuração completa"""
        return {
            "openai_api_key": self.get_api_key("openai"),
            "anthropic_api_key": self.get_api_key("anthropic"),
            "pinecone_api_key": self.get_api_key("pinecone"),
            "vector_db": os.getenv("VECTOR_DB", "pinecone"),
            "embedding_model": "text-embedding-ada-002"
        }

secure_config = SecureConfig()
config = secure_config.get_config()
```

---

## 2. 🤖 Criação de Agentes

### Definição de Agentes

```python
from superagi.agent import Agent
from superagi.tools.base_tool import BaseTool
from typing import List, Dict

class CustomAgent:
    """Agente personalizado SuperAGI"""

    def __init__(self, name: str, goals: List[str]):
        self.name = name
        self.goals = goals
        self.tools: List[BaseTool] = []
        self.memory = None

    def add_tool(self, tool: BaseTool):
        """Adiciona ferramenta ao agente"""
        self.tools.append(tool)

    def set_memory(self, memory):
        """Define sistema de memória"""
        self.memory = memory

    def create_agent(self) -> Agent:
        """Cria instância do agente"""
        return Agent(
            name=self.name,
            goals=self.goals,
            tools=self.tools,
            memory=self.memory
        )

# Criar agente de pesquisa
research_agent = CustomAgent(
    name="Pesquisador",
    goals=[
        "Pesquisar informações relevantes",
        "Analisar dados coletados",
        "Gerar relatórios detalhados"
    ]
)

# Adicionar ferramentas
from superagi.tools.web.web_search import WebSearchTool
from superagi.tools.file.file_writer import FileWriterTool

research_agent.add_tool(WebSearchTool())
research_agent.add_tool(FileWriterTool())

# Criar agente
agent = research_agent.create_agent()
```

### Configuração de Goals

```python
from superagi.agent import Agent
from superagi.models.agent import AgentModel

class GoalManager:
    """Gerenciador de goals do agente"""

    def __init__(self):
        self.goals = []
        self.constraints = []

    def add_goal(self, goal: str, priority: int = 1):
        """Adiciona goal com prioridade"""
        self.goals.append({
            "goal": goal,
            "priority": priority,
            "status": "pending"
        })

    def add_constraint(self, constraint: str):
        """Adiciona restrição"""
        self.constraints.append(constraint)

    def get_prioritized_goals(self) -> List[Dict]:
        """Retorna goals ordenados por prioridade"""
        return sorted(
            self.goals,
            key=lambda x: x["priority"],
            reverse=True
        )

    def format_goals_for_agent(self) -> str:
        """Formata goals para o agente"""
        prioritized = self.get_prioritized_goals()
        formatted = "Goals:\n"
        for i, g in enumerate(prioritized, 1):
            formatted += f"{i}. {g['goal']}\n"

        if self.constraints:
            formatted += "\nConstraints:\n"
            for c in self.constraints:
                formatted += f"- {c}\n"

        return formatted

goal_manager = GoalManager()
goal_manager.add_goal("Coletar dados de vendas", priority=1)
goal_manager.add_goal("Gerar relatório mensal", priority=2)
goal_manager.add_constraint("Não acessar dados pessoais")

print(goal_manager.format_goals_for_agent())
```

---

## 3. 🔧 Configuração de Tools

### Marketplace de Tools

```python
from superagi.tools.base_tool import BaseTool
from superagi.tools import ToolType
from typing import Optional
from pydantic import BaseModel

class WebSearchInput(BaseModel):
    """Input para busca web"""
    query: str

class WebSearchTool(BaseTool):
    """Ferramenta de busca web"""
    name: str = "web_search"
    description: str = "Busca informações na web"
    args_schema: type[BaseModel] = WebSearchInput
    tool_type: ToolType = ToolType.ACTION

    def _execute(self, query: str) -> str:
        """Executa busca web"""
        import requests
        # Implementação simplificada
        return f"Resultados para: {query}"

class FileWriterInput(BaseModel):
    """Input para escrita de arquivo"""
    filename: str
    content: str

class FileWriterTool(BaseTool):
    """Ferramenta de escrita de arquivo"""
    name: str = "file_writer"
    description: str = "Escreve conteúdo em arquivo"
    args_schema: type[BaseModel] = FileWriterInput
    tool_type: ToolType = ToolType.FILE

    def _execute(self, filename: str, content: str) -> str:
        """Escreve arquivo"""
        from pathlib import Path
        Path(filename).parent.mkdir(parents=True, exist_ok=True)
        with open(filename, "w", encoding="utf-8") as f:
            f.write(content)
        return f"Arquivo {filename} criado com sucesso"

# Registrar tools
available_tools = {
    "web_search": WebSearchTool(),
    "file_writer": FileWriterTool()
}
```

### 📌 MELHORIA

❌ **ERRADO:**
```python
# Tools sem validação de input
class BadTool:
    def execute(self, **kwargs):
        # Sem schema de validação
        return "executado"

    # Sem tratamento de erros
    def run(self, data):
        result = data["field"]  # P KeyError
        return result
```

✅ **CORRETO:**
```python
# Tools com validação completa
from superagi.tools.base_tool import BaseTool
from pydantic import BaseModel, Field
from typing import Optional

class GoodToolInput(BaseModel):
    """Schema de input validado"""
    query: str = Field(..., min_length=1, max_length=1000)
    max_results: int = Field(default=10, ge=1, le=100)

class GoodTool(BaseTool):
    """Tool com validação completa"""
    name: str = "good_tool"
    description: str = "Tool com validação"
    args_schema: type[BaseModel] = GoodToolInput

    def _execute(self, query: str, max_results: int = 10) -> str:
        """Executa com tratamento de erros"""
        try:
            # Validação adicional
            if not query.strip():
                raise ValueError("Query não pode estar vazia")

            # Lógica principal
            results = self._process_query(query, max_results)

            return f"Encontrados {len(results)} resultados"

        except Exception as e:
            return f"Erro ao executar tool: {str(e)}"

    def _process_query(self, query: str, max_results: int):
        """Processa query"""
        # Implementação
        return [{"result": f"Item {i}"} for i in range(max_results)]
```

---

## 4. 🗄️ Integração Vector DB

### Configuração de Vector Store

```python
from superagi.vector_store.base import VectorStore
from typing import List, Dict, Optional
import os

class VectorDBManager:
    """Gerenciador de Vector Database"""

    def __init__(self, provider: str = "pinecone"):
        self.provider = provider
        self.config = self._get_config()

    def _get_config(self) -> Dict:
        """Obtém configuração do provider"""
        configs = {
            "pinecone": {
                "api_key": os.getenv("PINECONE_API_KEY"),
                "environment": os.getenv("PINECONE_ENV", "us-east1-gcp"),
                "index_name": "superagi-knowledge"
            },
            "weaviate": {
                "url": os.getenv("WEAVIATE_URL", "http://localhost:8080"),
                "api_key": os.getenv("WEAVIATE_API_KEY")
            },
            "qdrant": {
                "url": os.getenv("QDRANT_URL", "http://localhost:6333"),
                "api_key": os.getenv("QDRANT_API_KEY")
            }
        }
        return configs.get(self.provider, configs["pinecone"])

    def connect(self) -> VectorStore:
        """Conecta ao Vector Store"""
        if self.provider == "pinecone":
            import pinecone
            pinecone.init(
                api_key=self.config["api_key"],
                environment=self.config["environment"]
            )
            # Criar ou conectar ao index
            if self.config["index_name"] not in pinecone.list_indexes():
                pinecone.create_index(
                    name=self.config["index_name"],
                    dimension=1536
                )
            return pinecone.Index(self.config["index_name"])

        elif self.provider == "weaviate":
            import weaviate
            return weaviate.Client(self.config["url"])

        elif self.provider == "qdrant":
            from qdrant_client import QdrantClient
            return QdrantClient(url=self.config["url"])

    def upsert(self, collection: str, documents: List[Dict]):
        """Insere documentos no vector store"""
        client = self.connect()
        # Implementação específica do provider
        print(f"Inseridos {len(documents)} documentos em {collection}")

    def search(self, collection: str, query: str, limit: int = 5):
        """Busca documentos similares"""
        client = self.connect()
        # Implementação específica do provider
        return []

vector_db = VectorDBManager("pinecone")
vector_db.upsert("knowledge", [{"text": "documento exemplo"}])
```

---

## 5. 🧠 Sistema de Memória

### Memória Vector + Episódica

```python
from typing import List, Dict, Optional
from datetime import datetime
import json
from pathlib import Path

class MemorySystem:
    """Sistema de memória SuperAGI"""

    def __init__(self, agent_id: str):
        self.agent_id = agent_id
        self.vector_memory = []
        self.episodic_memory = []
        self.memory_dir = Path(f"memory/{agent_id}")
        self.memory_dir.mkdir(parents=True, exist_ok=True)

    def add_to_vector(self, content: str, metadata: Dict = None):
        """Adiciona à memória vetorial"""
        entry = {
            "content": content,
            "metadata": metadata or {},
            "timestamp": datetime.now().isoformat(),
            "agent_id": self.agent_id
        }
        self.vector_memory.append(entry)
        self._save_vector_memory()

    def add_episodic(self, event: str, context: Dict, outcome: str):
        """Adiciona episódio à memória"""
        episode = {
            "event": event,
            "context": context,
            "outcome": outcome,
            "timestamp": datetime.now().isoformat()
        }
        self.episodic_memory.append(episode)
        self._save_episodic_memory()

    def recall_similar(self, query: str, limit: int = 5) -> List[Dict]:
        """Recupera memórias similares"""
        # Simplificado - em produção usar similarity search
        results = []
        for entry in self.vector_memory:
            if query.lower() in entry["content"].lower():
                results.append(entry)
        return results[:limit]

    def recall_episodes(self, event_type: str = None) -> List[Dict]:
        """Recupera episódios"""
        if event_type:
            return [e for e in self.episodic_memory
                   if e["event"] == event_type]
        return self.episodic_memory

    def _save_vector_memory(self):
        """Salva memória vetorial"""
        path = self.memory_dir / "vector_memory.json"
        with open(path, "w", encoding="utf-8") as f:
            json.dump(self.vector_memory, f, ensure_ascii=False, indent=2)

    def _save_episodic_memory(self):
        """Salva memória episódica"""
        path = self.memory_dir / "episodic_memory.json"
        with open(path, "w", encoding="utf-8") as f:
            json.dump(self.episodic_memory, f, ensure_ascii=False, indent=2)

# Uso
memory = MemorySystem("agent_001")
memory.add_to_vector("O usuário prefere relatórios em PDF")
memory.add_episodic(
    event="gerar_relatorio",
    context={"formato": "PDF", "periodo": "mensal"},
    outcome="Relatório gerado com sucesso"
)

recalled = memory.recall_similar("relatório")
episodes = memory.recall_episodes("gerar_relatorio")
```

---

## 6. 🔄 Spawning de Agentes

### Criação de Múltiplos Agentes

```python
from superagi.agent import Agent
from superagi.apm.tracing import AgentSpawn
from typing import List
import asyncio

class AgentSpawner:
    """Spawner de múltiplos agentes"""

    def __init__(self):
        self.spawned_agents = []
        self.agent_configs = []

    def configure_agent(self, name: str, goals: List[str], tools: List):
        """Configura um agente"""
        config = {
            "name": name,
            "goals": goals,
            "tools": tools,
            "status": "configured"
        }
        self.agent_configs.append(config)

    async def spawn_agents(self, parallel: bool = True):
        """Spawn agents em paralelo ou sequencial"""
        if parallel:
            tasks = [self._spawn_single(config)
                    for config in self.agent_configs]
            results = await asyncio.gather(*tasks)
        else:
            results = []
            for config in self.agent_configs:
                result = await self._spawn_single(config)
                results.append(result)

        return results

    async def _spawn_single(self, config: dict):
        """Spawn um único agente"""
        agent = Agent(
            name=config["name"],
            goals=config["goals"],
            tools=config["tools"]
        )
        self.spawned_agents.append(agent)
        print(f"Agente {config['name']} spawned com sucesso")
        return agent

    def get_agent_status(self) -> List[Dict]:
        """Retorna status dos agentes"""
        return [
            {"name": a.name, "status": "running"}
            for a in self.spawned_agents
        ]

# Uso
spawner = AgentSpawner()

spawner.configure_agent(
    name="Pesquisador",
    goals=["Pesquisar dados"],
    tools=["web_search"]
)

spawner.configure_agent(
    name="Escritor",
    goals=["Escrever relatórios"],
    tools=["file_writer"]
)

agents = asyncio.run(spawner.spawn_agents(parallel=True))
print(f"Agentes spawnados: {len(agents)}")
```

---

## 7. 📋 Workflows de Agentes

### Definição de Workflows

```python
from typing import List, Dict, Callable
from enum import Enum
import asyncio

class WorkflowStep:
    """Step do workflow"""

    def __init__(self, name: str, action: Callable,
                 dependencies: List[str] = None):
        self.name = name
        self.action = action
        self.dependencies = dependencies or []
        self.status = "pending"
        self.result = None

class AgentWorkflow:
    """Workflow de agentes"""

    def __init__(self, name: str):
        self.name = name
        self.steps: Dict[str, WorkflowStep] = {}
        self.execution_order = []

    def add_step(self, name: str, action: Callable,
                 dependencies: List[str] = None):
        """Adiciona step ao workflow"""
        step = WorkflowStep(name, action, dependencies)
        self.steps[name] = step
        self.execution_order.append(name)

    def _check_dependencies(self, step_name: str) -> bool:
        """Verifica se dependências foram concluídas"""
        step = self.steps[step_name]
        for dep in step.dependencies:
            if self.steps[dep].status != "completed":
                return False
        return True

    async def execute(self):
        """Executa workflow completo"""
        print(f"Iniciando workflow: {self.name}")

        for step_name in self.execution_order:
            step = self.steps[step_name]

            if not self._check_dependencies(step_name):
                print(f"Aguardando dependências de {step_name}")
                continue

            print(f"Executando step: {step_name}")
            step.status = "running"

            try:
                step.result = await step.action()
                step.status = "completed"
                print(f"Step {step_name} concluído")
            except Exception as e:
                step.status = "failed"
                print(f"Step {step_name} falhou: {e}")

        return self.get_results()

    def get_results(self) -> Dict:
        """Retorna resultados dos steps"""
        return {
            name: {
                "status": step.status,
                "result": step.result
            }
            for name, step in self.steps.items()
        }

# Criar workflow
workflow = AgentWorkflow("Pesquisa e Relatório")

async def step_pesquisar():
    return "Dados coletados"

async def step_analisar():
    return "Análise concluída"

async def step_gerar_relatorio():
    return "Relatório gerado"

workflow.add_step("pesquisar", step_pesquisar)
workflow.add_step("analisar", step_analisar, ["pesquisar"])
workflow.add_step("relatorio", step_gerar_relatorio, ["analisar"])

results = asyncio.run(workflow.execute())
```

---

## 8. 🔄 Loop Ação/Observação

### Implementação do Loop

```python
from typing import Callable, Dict, List
import asyncio

class ActionObservationLoop:
    """Loop Ação/Observação SuperAGI"""

    def __init__(self, max_iterations: int = 10):
        self.max_iterations = max_iterations
        self.actions = {}
        self.observations = []
        self.current_iteration = 0

    def register_action(self, name: str, action: Callable):
        """Registra uma ação disponível"""
        self.actions[name] = action

    async def think(self, observation: Dict) -> str:
        """Fase de pensamento"""
        # Lógica de raciocínio do agente
        # Em produção, isso seria chamada ao LLM
        return "ação_recomendada"

    async def act(self, action_name: str, params: Dict) -> Dict:
        """Executa uma ação"""
        if action_name not in self.actions:
            return {"error": f"Ação {action_name} não encontrada"}

        try:
            result = await self.actions[action_name](params)
            return {"status": "success", "result": result}
        except Exception as e:
            return {"status": "error", "error": str(e)}

    async def observe(self, action_result: Dict) -> Dict:
        """Fase de observação"""
        observation = {
            "iteration": self.current_iteration,
            "result": action_result,
            "timestamp": "2024-01-01"
        }
        self.observations.append(observation)
        return observation

    async def run(self, initial_task: str):
        """Executa loop completo"""
        print(f"Iniciando loop com tarefa: {initial_task}")

        observation = {"task": initial_task}

        while self.current_iteration < self.max_iterations:
            self.current_iteration += 1
            print(f"Iteração {self.current_iteration}")

            # Think
            action_name = await self.think(observation)
            print(f"Ação escolhida: {action_name}")

            # Act
            action_result = await self.act(action_name, {})

            # Observe
            observation = await self.observe(action_result)

            # Verificar se tarefa está completa
            if self._is_task_complete(observation):
                print("Tarefa concluída!")
                break

        return self.observations

    def _is_task_complete(self, observation: Dict) -> bool:
        """Verifica se tarefa está completa"""
        # Lógica de conclusão
        return observation.get("result", {}).get("status") == "success"

# Uso
loop = ActionObservationLoop(max_iterations=5)
loop.register_action("search", lambda x: "resultados")
loop.register_action("write", lambda x: "escrito")

observations = asyncio.run(loop.run("Pesquisar e documentar"))
```

---

## 9. 🌐 Navegação Web

### Web Browsing Tool

```python
from superagi.tools.web.base_web import BaseWeb
from typing import Optional
from pydantic import BaseModel

class WebBrowseInput(BaseModel):
    """Input para navegação web"""
    url: str
    action: str = "read"  # read, click, fill, submit

class WebBrowseTool(BaseWeb):
    """Ferramenta de navegação web"""

    name: str = "web_browse"
    description: str = "Navega e interage com páginas web"
    args_schema: type[BaseModel] = WebBrowseInput

    def _execute(self, url: str, action: str = "read") -> str:
        """Executa navegação web"""
        import requests
        from bs4 import BeautifulSoup

        try:
            response = requests.get(url, timeout=10)
            response.raise_for_status()

            if action == "read":
                soup = BeautifulSoup(response.content, "html.parser")
                # Extrair texto principal
                for script in soup(["script", "style"]):
                    script.decompose()
                text = soup.get_text(separator="\n", strip=True)
                return text[:5000]  # Limitar tamanho

            elif action == "links":
                soup = BeautifulSoup(response.content, "html.parser")
                links = []
                for link in soup.find_all("a", href=True):
                    links.append({
                        "text": link.get_text(strip=True),
                        "href": link["href"]
                    })
                return str(links[:20])

            return f"Ação {action} não suportada"

        except Exception as e:
            return f"Erro na navegação: {str(e)}"

web_tool = WebBrowseTool()
content = web_tool._execute("https://example.com", "read")
print(content[:200])
```

---

## 10. 💻 Interpretação de Código

### Code Interpreter

```python
import sys
import io
from contextlib import redirect_stdout, redirect_stderr
from typing import Dict
import ast

class CodeInterpreter:
    """Interpretador de código SuperAGI"""

    def __init__(self):
        self.execution_history = []
        self.available_modules = [
            "math", "json", "datetime", "collections",
            "re", "os", "pathlib"
        ]

    def validate_code(self, code: str) -> Dict:
        """Valida código antes de executar"""
        try:
            ast.parse(code)
            return {"valid": True, "error": None}
        except SyntaxError as e:
            return {"valid": False, "error": str(e)}

    def execute(self, code: str, timeout: int = 30) -> Dict:
        """Executa código Python de forma segura"""
        # Validar código
        validation = self.validate_code(code)
        if not validation["valid"]:
            return {
                "status": "error",
                "error": validation["error"]
            }

        # Capturar saída
        stdout_capture = io.StringIO()
        stderr_capture = io.StringIO()

        try:
            with redirect_stdout(stdout_capture), \
                 redirect_stderr(stderr_capture):

                # Executar código
                exec(code, {"__builtins__": {}}, {})

            stdout_val = stdout_capture.getvalue()
            stderr_val = stderr_capture.getvalue()

            result = {
                "status": "success",
                "stdout": stdout_val,
                "stderr": stderr_val
            }

        except Exception as e:
            result = {
                "status": "error",
                "error": str(e),
                "type": type(e).__name__
            }

        # Salvar no histórico
        self.execution_history.append({
            "code": code,
            "result": result
        })

        return result

    def get_history(self) -> list:
        """Retorna histórico de execuções"""
        return self.execution_history

interpreter = CodeInterpreter()

code = """
import math
result = math.sqrt(144)
print(f"Raiz quadrada de 144: {result}")
"""

output = interpreter.execute(code)
print(output)
```

---

## 11. 📁 Operações com Arquivos

### File Operations Tool

```python
from superagi.tools.file.base_file import BaseFileTool
from pathlib import Path
from typing import Optional
from pydantic import BaseModel
import shutil
import os

class FileOpsInput(BaseModel):
    """Input para operações de arquivo"""
    operation: str  # read, write, list, delete, copy
    path: str
    content: Optional[str] = None
    destination: Optional[str] = None

class FileOperationsTool(BaseFileTool):
    """Ferramenta de operações com arquivos"""

    name: str = "file_operations"
    description: str = "Realiza operações com arquivos"
    args_schema: type[BaseModel] = FileOpsInput

    def _execute(self, operation: str, path: str,
                 content: str = None, destination: str = None) -> str:
        """Executa operação de arquivo"""
        try:
            file_path = Path(path)

            if operation == "read":
                if not file_path.exists():
                    return f"Arquivo não encontrado: {path}"
                with open(file_path, "r", encoding="utf-8") as f:
                    return f.read()[:10000]  # Limitar

            elif operation == "write":
                file_path.parent.mkdir(parents=True, exist_ok=True)
                with open(file_path, "w", encoding="utf-8") as f:
                    f.write(content or "")
                return f"Arquivo {path} criado/atualizado"

            elif operation == "list":
                if not file_path.is_dir():
                    return f"Não é diretório: {path}"
                items = list(file_path.iterdir())
                return "\n".join([str(i.name) for i in items])

            elif operation == "delete":
                if file_path.is_file():
                    file_path.unlink()
                elif file_path.is_dir():
                    shutil.rmtree(file_path)
                return f"Deletado: {path}"

            elif operation == "copy":
                if not destination:
                    return "Destino não especificado"
                if file_path.is_file():
                    shutil.copy2(file_path, destination)
                elif file_path.is_dir():
                    shutil.copytree(file_path, destination)
                return f"Copiado para: {destination}"

            return f"Operação {operation} não suportada"

        except Exception as e:
            return f"Erro: {str(e)}"

file_tool = FileOperationsTool()
result = file_tool._execute("write", "test.txt", "Olá Mundo")
print(result)
```

---

## 12. 📚 Gestão de Knowledge Base

### Knowledge Base Manager

```python
from typing import List, Dict, Optional
from pathlib import Path
import json

class KnowledgeBaseManager:
    """Gerenciador de Knowledge Base"""

    def __init__(self, kb_path: str = "knowledge_base"):
        self.kb_path = Path(kb_path)
        self.kb_path.mkdir(exist_ok=True)
        self.documents = self._load_documents()

    def _load_documents(self) -> List[Dict]:
        """Carrega documentos existentes"""
        docs_file = self.kb_path / "documents.json"
        if docs_file.exists():
            with open(docs_file, "r", encoding="utf-8") as f:
                return json.load(f)
        return []

    def _save_documents(self):
        """Salva documentos"""
        docs_file = self.kb_path / "documents.json"
        with open(docs_file, "w", encoding="utf-8") as f:
            json.dump(self.documents, f, ensure_ascii=False, indent=2)

    def add_document(self, title: str, content: str,
                     category: str, tags: List[str] = None):
        """Adiciona documento à base"""
        doc = {
            "id": len(self.documents) + 1,
            "title": title,
            "content": content,
            "category": category,
            "tags": tags or [],
            "created_at": "2024-01-01"
        }
        self.documents.append(doc)
        self._save_documents()
        return doc["id"]

    def search(self, query: str, category: str = None) -> List[Dict]:
        """Busca documentos"""
        results = []
        query_lower = query.lower()

        for doc in self.documents:
            if category and doc["category"] != category:
                continue

            if (query_lower in doc["title"].lower() or
                query_lower in doc["content"].lower()):
                results.append(doc)

        return results

    def get_by_category(self, category: str) -> List[Dict]:
        """Obtém documentos por categoria"""
        return [d for d in self.documents if d["category"] == category]

    def update_document(self, doc_id: int, updates: Dict):
        """Atualiza documento"""
        for doc in self.documents:
            if doc["id"] == doc_id:
                doc.update(updates)
                self._save_documents()
                return True
        return False

    def delete_document(self, doc_id: int):
        """Deleta documento"""
        self.documents = [d for d in self.documents if d["id"] != doc_id]
        self._save_documents()

kb = KnowledgeBaseManager()
kb.add_document("API Guide", "Como criar APIs REST", "docs", ["api", "rest"])
results = kb.search("API")
```

---

## 13. 📊 Alocação de Recursos

### Resource Manager

```python
from typing import Dict, List
from dataclasses import dataclass
from datetime import datetime

@dataclass
class Resource:
    """Recurso do sistema"""
    name: str
    type: str  # cpu, memory, api_call
    allocated: float
    used: float
    limit: float

class ResourceManager:
    """Gerenciador de recursos SuperAGI"""

    def __init__(self):
        self.resources: Dict[str, Resource] = {}
        self.usage_history: List[Dict] = []

    def register_resource(self, name: str, resource_type: str,
                          limit: float):
        """Registra um recurso"""
        self.resources[name] = Resource(
            name=name,
            type=resource_type,
            allocated=0.0,
            used=0.0,
            limit=limit
        )

    def allocate(self, name: str, amount: float) -> bool:
        """Aloca recurso"""
        if name not in self.resources:
            return False

        resource = self.resources[name]
        if resource.allocated + amount > resource.limit:
            return False

        resource.allocated += amount
        self._log_usage(name, "allocate", amount)
        return True

    def deallocate(self, name: str, amount: float) -> bool:
        """Libera recurso"""
        if name not in self.resources:
            return False

        resource = self.resources[name]
        resource.allocated = max(0, resource.allocated - amount)
        self._log_usage(name, "deallocate", amount)
        return True

    def check_availability(self, name: str) -> Dict:
        """Verifica disponibilidade do recurso"""
        if name not in self.resources:
            return {"available": False, "error": "Recurso não encontrado"}

        resource = self.resources[name]
        available = resource.limit - resource.allocated

        return {
            "available": available > 0,
            "total": resource.limit,
            "allocated": resource.allocated,
            "available_amount": available
        }

    def _log_usage(self, resource_name: str, action: str, amount: float):
        """Registra uso de recurso"""
        self.usage_history.append({
            "resource": resource_name,
            "action": action,
            "amount": amount,
            "timestamp": datetime.now().isoformat()
        })

# Uso
rm = ResourceManager()
rm.register_resource("api_calls", "api_call", 1000)
rm.register_resource("memory", "memory", 8192)

rm.allocate("api_calls", 100)
print(rm.check_availability("api_calls"))
```

---

## 14. 🎯 Fine-Tuning

### Suporte a Fine-Tuning

```python
from typing import Dict, List, Optional
from pathlib import Path
import json

class FineTuningManager:
    """Gerenciador de Fine-Tuning"""

    def __init__(self, output_dir: str = "fine_tuning"):
        self.output_dir = Path(output_dir)
        self.output_dir.mkdir(exist_ok=True)
        self.training_data = []

    def prepare_training_data(self, examples: List[Dict]):
        """Prepara dados para treinamento"""
        formatted = []
        for example in examples:
            formatted.append({
                "messages": [
                    {"role": "system", "content": example.get("system", "")},
                    {"role": "user", "content": example["input"]},
                    {"role": "assistant", "content": example["output"]}
                ]
            })
        return formatted

    def create_jsonl(self, data: List[Dict], filename: str):
        """Cria arquivo JSONL para fine-tuning"""
        output_path = self.output_dir / filename
        with open(output_path, "w", encoding="utf-8") as f:
            for item in data:
                f.write(json.dumps(item, ensure_ascii=False) + "\n")

        print(f"Arquivo criado: {output_path}")
        return output_path

    def upload_to_openai(self, file_path: str) -> str:
        """Upload para OpenAI (simulado)"""
        # Em produção, usar a API da OpenAI
        print(f"Upload de {file_path} para OpenAI...")
        return "file-abc123"

    def create_fine_tune_job(self, file_id: str,
                              model: str = "gpt-3.5-turbo") -> Dict:
        """Cria job de fine-tuning (simulado)"""
        job = {
            "id": f"ftjob-{len(self.training_data)}",
            "model": model,
            "file_id": file_id,
            "status": "validating_files",
            "created_at": "2024-01-01"
        }
        self.training_data.append(job)
        return job

    def get_job_status(self, job_id: str) -> Optional[Dict]:
        """Obtém status do job"""
        for job in self.training_data:
            if job["id"] == job_id:
                return job
        return None

# Uso
ft_manager = FineTuningManager()

examples = [
    {
        "system": "Você é um assistente de código",
        "input": "Como criar uma API?",
        "output": "Use FastAPI para criar endpoints REST..."
    }
]

training_data = ft_manager.prepare_training_data(examples)
ft_manager.create_jsonl(training_data, "training.jsonl")
```

---

## 15. 🖥️ Dashboard UI

### Interface do SuperAGI

```python
from typing import Dict, List
import json

class DashboardManager:
    """Gerenciador do Dashboard SuperAGI"""

    def __init__(self):
        self.agents = []
        self.workflows = []
        self.metrics = {}

    def add_agent(self, agent_name: str, status: str, goals: List[str]):
        """Adiciona agente ao dashboard"""
        self.agents.append({
            "name": agent_name,
            "status": status,
            "goals": goals,
            "tasks_completed": 0,
            "uptime": "0h"
        })

    def update_metrics(self, metrics: Dict):
        """Atualiza métricas"""
        self.metrics.update(metrics)

    def get_dashboard_data(self) -> Dict:
        """Retorna dados para o dashboard"""
        return {
            "agents": self.agents,
            "total_agents": len(self.agents),
            "active_agents": len([a for a in self.agents
                                 if a["status"] == "active"]),
            "metrics": self.metrics,
            "workflows": self.workflows
        }

    def render_summary(self) -> str:
        """Renderiza resumo do dashboard"""
        data = self.get_dashboard_data()
        summary = f"""
=== SuperAGI Dashboard ===
Total de Agentes: {data['total_agents']}
Agentes Ativos: {data['active_agents']}

Agentes:
"""
        for agent in data["agents"]:
            summary += f"  - {agent['name']}: {agent['status']}\n"

        return summary

dashboard = DashboardManager()
dashboard.add_agent("Pesquisador", "active", ["Pesquisar dados"])
dashboard.add_agent("Escritor", "idle", ["Escrever relatórios"])
dashboard.update_metrics({"tasks_completed": 42})

print(dashboard.render_summary())
```

---

## 📊 Resumo dos Comandos SuperAGI

| Comando | Descrição |
|---------|-----------|
| `superagi run "goal"` | Executa agente com goal |
| `superagi spawn --agents 3` | Spawna 3 agentes |
| `superagi workflow create` | Cria workflow |
| `superagi dashboard` | Abre dashboard |

---

## 🔗 Referências

- **Repositório:** https://github.com/TransformerOptimus/SuperAGI
- **Documentação:** https://docs.superagi.com/
- **Discord:** https://discord.gg/dvaBhE9Q9P
- **Blog:** https://superagi.com/blog

---

> **Versão:** 2.0 | **Atualizado:** 2024 | **Licença:** AGPL-3.0
