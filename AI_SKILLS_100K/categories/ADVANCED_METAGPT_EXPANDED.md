# 🤖 MetaGPT - Framework Multi-Agent Avançado

> **Fonte:** https://github.com/geekan/MetaGPT (50k+ stars)
> **Descrição:** MetaGPT é um framework multi-agent que atribui diferentes roles aos agentes, seguindo procedimentos operacionais padronizados (SOPs) para gerar documentos, código e soluções completas de software.

---

## 📋 Índice de Skills

| # | Skill | Categoria |
|---|-------|-----------|
| 1 | Configuração do Ambiente | Setup |
| 2 | Definição de Roles dos Agentes | Agentes |
| 3 | Geração de PRD | Documentos |
| 4 | Análise de Requisitos | Requisitos |
| 5 | Design de Arquitetura | Arquitetura |
| 6 | Geração de Código | Código |
| 7 | Debug e Correção de Erros | Debug |
| 8 | Integração com LLMs | LLM |
| 9 | Gerenciamento de Memória | Memória |
| 10 | Execução Sequencial | Workflow |
| 11 | Geração de Testes | Testes |
| 12 | Estimativa de Custo | Custo |
| 13 | Integração com Conhecimento | Knowledge |
| 14 | Deploy e Publicação | Deploy |
| 15 | MetaGPT+ (Enhanced) | Avançado |

---

## 1. ⚙️ Configuração do Ambiente

### Instalação e Setup Básico

```python
# requirements.txt
metagpt==0.8.0
openai>=1.0.0
pydantic>=2.0.0
aiohttp>=3.9.0

# Instalação
# pip install metagpt

# Arquivo de configuração: config/config2.yaml
"""
llm:
  api_type: "openai"
  api_key: "sk-sua-chave-aqui"
  model: "gpt-4"
  base_url: "https://api.openai.com/v1"

workspace:
  path: "./workspace"
"""
```

```python
# init_project.py
from metagpt.const import WORKSPACE_ROOT
from metagpt.utils.common import read_file

def setup_metagpt():
    """Configura o ambiente MetaGPT"""
    import yaml

    config_path = "config/config2.yaml"
    with open(config_path, "r", encoding="utf-8") as f:
        config = yaml.safe_load(f)

    print(f"Modelo configurado: {config['llm']['model']}")
    print(f"Workspace: {WORKSPACE_ROOT}")
    return config

if __name__ == "__main__":
    setup_metagpt()
```

### 📌 MELHORIA

❌ **ERRADO:**
```python
# Não definir configuração corretamente
import os
os.environ["OPENAI_API_KEY"] = "chave-exposta"
# Não usar config file - configuração espalhada no código
from metagpt.software_company import generate_repo
# Sem tratar erros de conexão
```

✅ **CORRETO:**
```python
# Usar arquivo de configuração seguro
import yaml
from pathlib import Path
from metagpt.const import WORKSPACE_ROOT

def load_config():
    """Carrega configuração de forma segura"""
    config_path = Path("config/config2.yaml")
    if not config_path.exists():
        raise FileNotFoundError("Arquivo de configuração não encontrado")

    with open(config_path, "r", encoding="utf-8") as f:
        config = yaml.safe_load(f)

    # Nunca expor a chave - usar variável de ambiente
    if config["llm"].get("api_key") == "sk-sua-chave-aqui":
        import os
        config["llm"]["api_key"] = os.getenv("OPENAI_API_KEY", "")

    return config

config = load_config()
print("Ambiente MetaGPT configurado com sucesso")
```

---

## 2. 🎭 Definição de Roles dos Agentes

### Sistema de Roles MetaGPT

```python
from metagpt.actions import (
    WritePRD,
    WriteDesign,
    WriteTasks,
    WriteCode,
    ReviewAndPatch,
    FixBug
)
from metagpt.roles import (
    ProductManager,
    Architect,
    Engineer,
    QA
)

# Definir pipeline de roles
role_pipeline = {
    "product_manager": ProductManager(),
    "architect": Architect(),
    "engineer": Engineer(),
    "qa": QA()
}

# Executar pipeline
from metagpt.software_company import generate_repo

result = generate_repo(
    requirement="Criar uma API REST para gerenciamento de usuários",
    n_rounds=4
)
```

### Customização de Roles

```python
from metagpt.role import Role
from metagpt.actions import Action
from metagpt.schema import Message

class CustomResearcher(Role):
    """Role customizada para pesquisa"""
    name: str = "Pesquisador"
    profile: str = "Pesquisador especializado em análise de dados"

    def __init__(self):
        super().__init__()
        self._watch([WritePRD])  # Observa ações do ProductManager

    async def _act(self) -> Message:
        # Lógica customizada do pesquisador
        result = await self._rc.ii_sact(
            action=ResearchAction(),
            context=self._rc.latest_message
        )
        msg = Message(
            content=result,
            role=self.profile,
            cause_by=type(self._rc.current_action)
        )
        return msg

class ResearchAction(Action):
    """Ação customizada de pesquisa"""
    name: str = "Pesquisar"

    async def run(self, context: str) -> str:
        # Implementar lógica de pesquisa
        return f"Pesquisa realizada para: {context[:100]}..."
```

### 📌 MELHORIA

❌ **ERRADO:**
```python
# Não definir _watch corretamente
class BadRole(Role):
    def __init__(self):
        super().__init__()
        self._watch([])  # Sem observar nenhuma ação

    async def _act(self):
        return "ação sem contexto"
```

✅ **CORRETO:**
```python
# Definir observação e ação corretamente
from metagpt.actions import Action
from metagpt.schema import Message

class CorrectRole(Role):
    name: str = "Analista"
    profile: str = "Analista de requisitos"

    def __init__(self):
        super().__init__()
        # Observar ações específicas
        self._watch([WritePRD, WriteDesign])
        self._set_react_mode(react_mode="react")

    async def _act(self) -> Message:
        message = self._rc.latest_message
        result = await self._rc.ii_sact(
            action=AnalysisAction(),
            context=message
        )
        return Message(
            content=result,
            role=self.name,
            sent_from=self.profile
        )
```

---

## 3. 📄 Geração de PRD

### Documento de Requisitos de Produto

```python
from metagpt.actions import WritePRD
from metagpt.software_company import generate_repo

# Gerar PRD a partir de uma ideia
prd_action = WritePRD()

# Exemplo de requisito
requirement = """
Sistema de e-commerce com:
- Catálogo de produtos
- Carrinho de compras
- Pagamento integrado
- Painel administrativo
"""

# Executar geração de PRD
from metagpt.role import Role
from metagpt.actions import WritePRD

async def generate_prd(requirement: str):
    """Gera um PRD completo"""
    pm = ProductManager()
    pm._rc.occupation = "Product Manager"

    prd = await pm._rc.ii_sact(
        action=WritePRD(),
        context=requirement
    )

    # Salvar PRD em arquivo
    output_path = "output/prd.md"
    with open(output_path, "w", encoding="utf-8") as f:
        f.write(prd)

    return prd

# Executar
import asyncio
prd = asyncio.run(generate_prd(requirement))
print("PRD gerado com sucesso!")
```

### 📌 MELHORIA

❌ **ERRADO:**
```python
# Não tratar saída corretamente
async def bad_prd():
    pm = ProductManager()
    result = await pm._rc.ii_sact(
        action=WritePRD(),
        context="requisito vago"
    )
    # Não salvar resultado
    print(result)  # Apenas imprime
```

✅ **CORRETO:**
```python
# Gerar e persistir PRD corretamente
import asyncio
from pathlib import Path
from metagpt.actions import WritePRD

async def good_prd(requirement: str, output_dir: str = "output"):
    """Gera PRD e salva em arquivo"""
    pm = ProductManager()

    prd = await pm._rc.ii_sact(
        action=WritePRD(),
        context=requirement
    )

    # Criar diretório se não existir
    Path(output_dir).mkdir(parents=True, exist_ok=True)

    output_path = Path(output_dir) / "prd.md"
    with open(output_path, "w", encoding="utf-8") as f:
        f.write(f"# Documento de Requisitos\n\n")
        f.write(f"**Requisito Original:** {requirement}\n\n")
        f.write(f"## Conteúdo\n\n{prd}")

    print(f"PRD salvo em: {output_path}")
    return prd

prd = asyncio.run(good_prd(
    "Sistema de e-commerce com carrinho e pagamento"
))
```

---

## 4. 📊 Análise de Requisitos

### Processo de Análise

```python
from metagpt.actions import WritePRD
from metagpt.schema import Message

class RequirementAnalyzer:
    """Analisador de requisitos"""

    def __init__(self):
        self.requirements = []

    def analyze(self, raw_requirement: str) -> dict:
        """Analisa requisito bruto"""
        analysis = {
            "original": raw_requirement,
            "funcional": [],
            "nao_funcional": [],
            "restricoes": [],
            "prioridades": []
        }

        # Análise de palavras-chave
        keywords_funcional = ["sistema", "api", "interface", "banco", "login"]
        keywords_nao_funcional = ["performance", "segurança", "escalabilidade"]
        keywords_restricao = ["prazo", "orçamento", "tecnologia"]

        words = raw_requirement.lower().split()

        for word in words:
            if word in keywords_funcional:
                analysis["funcional"].append(word)
            elif word in keywords_nao_funcional:
                analysis["nao_funcional"].append(word)
            elif word in keywords_restricao:
                analysis["restricoes"].append(word)

        return analysis

# Uso
analyzer = RequirementAnalyzer()
result = analyzer.analyze("Criar sistema de login seguro com performance")
print(f"Funcional: {result['funcional']}")
print(f"Não-funcional: {result['nao_funcional']}")
```

---

## 5. 🏗️ Design de Arquitetura

### Geração de Arquitetura

```python
from metagpt.actions import WriteDesign
from metagpt.role import Architect

async def generate_architecture(prd: str):
    """Gera design de arquitetura a partir do PRD"""
    architect = Architect()

    design = await architect._rc.ii_sact(
        action=WriteDesign(),
        context=prd
    )

    return design

# Template de arquitetura
architecture_template = """
# Arquitetura do Sistema

## Componentes Principais
- API Gateway
- Service Layer
- Data Layer
- Cache Layer

## Padrões
- Microserviços
- Event-Driven
- CQRS

## Tecnologias
- Backend: Python/FastAPI
- Database: PostgreSQL
- Cache: Redis
- Queue: RabbitMQ
"""
```

---

## 6. 💻 Geração de Código

### Pipeline de Geração

```python
from metagpt.actions import WriteCode, ReviewAndPatch
from metagpt.role import Engineer

async def generate_code(design: str):
    """Gera código a partir do design"""
    engineer = Engineer()

    code = await engineer._rc.ii_sact(
        action=WriteCode(),
        context=design
    )

    return code

# Exemplo de código gerado
generated_code = """
from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
from typing import List, Optional

app = FastAPI(title="User Management API")

class User(BaseModel):
    id: Optional[int] = None
    name: str
    email: str
    password: str

users_db: List[User] = []

@app.post("/users/", response_model=User)
async def create_user(user: User):
    user.id = len(users_db) + 1
    users_db.append(user)
    return user

@app.get("/users/{user_id}", response_model=User)
async def get_user(user_id: int):
    for user in users_db:
        if user.id == user_id:
            return user
    raise HTTPException(status_code=404, detail="Usuário não encontrado")
"""
```

### 📌 MELHORIA

❌ **ERRADO:**
```python
# Código sem tratamento de erros
async def bad_code_gen(design):
    engineer = Engineer()
    # Sem validação do design
    code = await engineer._rc.ii_sact(
        action=WriteCode(),
        context=design  # Pode ser None
    )
    return code  # Sem verificação
```

✅ **CORRETO:**
```python
# Código com validação completa
async def good_code_gen(design: str, validate: bool = True):
    """Gera código com validação"""
    if not design or len(design.strip()) < 10:
        raise ValueError("Design inválido ou muito curto")

    engineer = Engineer()

    try:
        code = await engineer._rc.ii_sact(
            action=WriteCode(),
            context=design
        )

        if validate and not code:
            raise RuntimeError("Geração de código retornou vazio")

        # Salvar código gerado
        with open("output/generated_code.py", "w") as f:
            f.write(code)

        return code

    except Exception as e:
        print(f"Erro na geração: {e}")
        return None
```

---

## 7. 🐛 Debug e Correção de Erros

### Sistema de Debug Automático

```python
from metagpt.actions import FixBug
from metagpt.schema import Message

class AutoDebugger:
    """Debugger automático MetaGPT"""

    def __init__(self):
        self.error_log = []

    async def fix_buggy_code(self, code: str, error_msg: str):
        """Corrige código com erro"""
        fix_action = FixBug()

        fixed_code = await fix_action.run(
            buggy_code=code,
            error_message=error_msg
        )

        return fixed_code

    def log_error(self, error: str, context: str):
        """Registra erro para análise"""
        self.error_log.append({
            "error": error,
            "context": context,
            "timestamp": "2024-01-01"
        })

# Exemplo de uso
debugger = AutoDebugger()

buggy_code = """
def divide(a, b):
    return a / b  # Erro: divisão por zero não tratada
"""

error = "ZeroDivisionError: division by zero"

fixed = asyncio.run(debugger.fix_buggy_code(buggy_code, error))
print(fixed)
```

---

## 8. 🔗 Integração com LLMs

### Configuração de Modelos

```python
from metagpt.config import Config
from metagpt.provider import openai_api

class LLMManager:
    """Gerenciador de LLMs"""

    MODELS = {
        "gpt4": "gpt-4",
        "gpt35": "gpt-3.5-turbo",
        "claude": "claude-3-opus-20240229",
        "local": "llama-2-70b"
    }

    def __init__(self, model_key: str = "gpt4"):
        self.model = self.MODELS.get(model_key, "gpt-4")
        self.config = Config.default()

    def set_temperature(self, temp: float):
        """Define temperatura do modelo"""
        if 0.0 <= temp <= 2.0:
            self.config.temperature = temp
        else:
            raise ValueError("Temperatura deve estar entre 0.0 e 2.0")

    async def generate(self, prompt: str, context: str = ""):
        """Gera resposta usando o LLM"""
        full_prompt = f"Contexto: {context}\n\nPrompt: {prompt}"
        # Integração com MetaGPT
        return full_prompt

llm = LLMManager("gpt4")
llm.set_temperature(0.7)
```

---

## 9. 🧠 Gerenciamento de Memória

### Sistema de Memória

```python
from metagpt.schema import Message
from typing import List, Dict
import json
from pathlib import Path

class MemoryManager:
    """Gerenciador de memória MetaGPT"""

    def __init__(self, memory_file: str = "memory.json"):
        self.memory_file = Path(memory_file)
        self.memory: List[Dict] = []
        self.load_memory()

    def load_memory(self):
        """Carrega memória do disco"""
        if self.memory_file.exists():
            with open(self.memory_file, "r", encoding="utf-8") as f:
                self.memory = json.load(f)

    def save_memory(self):
        """Salva memória em disco"""
        with open(self.memory_file, "w", encoding="utf-8") as f:
            json.dump(self.memory, f, ensure_ascii=False, indent=2)

    def add_message(self, message: Message):
        """Adiciona mensagem à memória"""
        self.memory.append({
            "content": message.content,
            "role": message.role,
            "timestamp": str(message.timestamp)
        })
        self.save_memory()

    def get_context(self, limit: int = 10) -> str:
        """Retorna contexto das últimas N mensagens"""
        recent = self.memory[-limit:]
        return "\n".join([m["content"] for m in recent])

memory = MemoryManager()
memory.add_message(Message(content="Requisito definido", role="PM"))
context = memory.get_context(5)
```

---

## 10. ⚡ Execução Sequencial

### Pipeline Sequencial

```python
from metagpt.actions import (
    WritePRD,
    WriteDesign,
    WriteTasks,
    WriteCode,
    ReviewAndPatch
)
from metagpt.software_company import generate_repo
import asyncio

class SequentialPipeline:
    """Pipeline sequencial MetaGPT"""

    def __init__(self, requirement: str):
        self.requirement = requirement
        self.results = {}

    async def run(self):
        """Executa pipeline completo"""
        stages = [
            ("prd", WritePRD),
            ("design", WriteDesign),
            ("tasks", WriteTasks),
            ("code", WriteCode),
            ("review", ReviewAndPatch)
        ]

        current_input = self.requirement

        for stage_name, action_class in stages:
            print(f"Executando stage: {stage_name}")
            action = action_class()
            result = await action.run(context=current_input)
            self.results[stage_name] = result
            current_input = result

        return self.results

# Executar pipeline
pipeline = SequentialPipeline("Criar sistema de autenticação")
results = asyncio.run(pipeline.run())
```

---

## 11. 🧪 Geração de Testes

### Geração Automática de Testes

```python
from metagpt.actions import WriteCode
from pathlib import Path

class TestGenerator:
    """Gerador automático de testes"""

    def __init__(self, code_path: str):
        self.code_path = Path(code_path)
        self.test_dir = Path("tests")

    def generate_test(self, code: str, function_name: str) -> str:
        """Gera teste para uma função"""
        test_template = f"""
import pytest
from src.module import {function_name}

class Test{function_name.title()}:
    def test_{function_name}_basico(self):
        # Arrange
        # Act
        result = {function_name}()
        # Assert
        assert result is not None

    def test_{function_name}_edge_case(self):
        # Teste de caso extremo
        pass

    def test_{function_name}_erro(self):
        # Teste de tratamento de erro
        pass
"""
        return test_template

    def save_test(self, test_code: str, test_name: str):
        """Salva arquivo de teste"""
        self.test_dir.mkdir(exist_ok=True)
        test_file = self.test_dir / f"test_{test_name}.py"
        with open(test_file, "w", encoding="utf-8") as f:
            f.write(test_code)
        print(f"Teste salvo em: {test_file}")

generator = TestGenerator("src/module.py")
test = generator.generate_test("def calc(a,b): return a+b", "calc")
generator.save_test(test, "calc")
```

---

## 12. 💰 Estimativa de Custo

### Cálculo de Custo de LLM

```python
class CostEstimator:
    """Estimador de custo MetaGPT"""

    # Preços por 1K tokens (USD)
    PRICING = {
        "gpt-4": {"input": 0.03, "output": 0.06},
        "gpt-3.5-turbo": {"input": 0.001, "output": 0.002},
        "claude-3-opus": {"input": 0.015, "output": 0.075},
    }

    def __init__(self, model: str = "gpt-4"):
        self.model = model
        self.total_input_tokens = 0
        self.total_output_tokens = 0

    def add_usage(self, input_tokens: int, output_tokens: int):
        """Registra uso de tokens"""
        self.total_input_tokens += input_tokens
        self.total_output_tokens += output_tokens

    def estimate_cost(self) -> float:
        """Estima custo total"""
        pricing = self.PRICING.get(self.model, self.PRICING["gpt-4"])

        input_cost = (self.total_input_tokens / 1000) * pricing["input"]
        output_cost = (self.total_output_tokens / 1000) * pricing["output"]

        return input_cost + output_cost

    def summary(self) -> str:
        """Retorna resumo de custo"""
        cost = self.estimate_cost()
        return f"""
        Modelo: {self.model}
        Tokens Input: {self.total_input_tokens:,}
        Tokens Output: {self.total_output_tokens:,}
        Custo Estimado: ${cost:.4f}
        """

estimator = CostEstimator("gpt-4")
estimator.add_usage(5000, 2000)
print(estimator.summary())
```

---

## 13. 📚 Integração com Conhecimento

### Base de Conhecimento

```python
import json
from pathlib import Path
from typing import List, Dict

class KnowledgeBase:
    """Base de conhecimento MetaGPT"""

    def __init__(self, kb_path: str = "knowledge"):
        self.kb_path = Path(kb_path)
        self.kb_path.mkdir(exist_ok=True)
        self.documents: List[Dict] = []

    def add_document(self, title: str, content: str, tags: List[str]):
        """Adiciona documento à base"""
        doc = {
            "id": len(self.documents) + 1,
            "title": title,
            "content": content,
            "tags": tags
        }
        self.documents.append(doc)
        self._save_doc(doc)

    def search(self, query: str) -> List[Dict]:
        """Busca documentos por query"""
        results = []
        query_lower = query.lower()

        for doc in self.documents:
            if (query_lower in doc["title"].lower() or
                query_lower in doc["content"].lower()):
                results.append(doc)

        return results

    def _save_doc(self, doc: Dict):
        """Salva documento em disco"""
        doc_path = self.kb_path / f"doc_{doc['id']}.json"
        with open(doc_path, "w", encoding="utf-8") as f:
            json.dump(doc, f, ensure_ascii=False, indent=2)

kb = KnowledgeBase()
kb.add_document("API Design", "Guia de design de APIs REST", ["api", "rest"])
results = kb.search("API")
```

---

## 14. 🚀 Deploy e Publicação

### Script de Deploy

```python
from pathlib import Path
import subprocess
import json

class DeployManager:
    """Gerenciador de deploy MetaGPT"""

    def __init__(self, project_path: str):
        self.project_path = Path(project_path)

    def run_tests(self) -> bool:
        """Executa testes antes do deploy"""
        result = subprocess.run(
            ["python", "-m", "pytest", "tests/", "-v"],
            capture_output=True,
            text=True
        )
        return result.returncode == 0

    def build(self) -> bool:
        """Build do projeto"""
        # Verificar se há Dockerfile
        if (self.project_path / "Dockerfile").exists():
            result = subprocess.run(
                ["docker", "build", "-t", "metagpt-app", "."],
                capture_output=True,
                text=True
            )
            return result.returncode == 0
        return True

    def deploy(self, target: str = "local"):
        """Executa deploy"""
        if not self.run_tests():
            print("❌ Testes falharam - deploy cancelado")
            return False

        if not self.build():
            print("❌ Build falhou - deploy cancelado")
            return False

        print(f"✅ Deploy para {target} concluído!")
        return True

deployer = DeployManager("./my-project")
deployer.deploy("production")
```

---

## 15. 🚀 MetaGPT+ (Enhanced)

### Funcionalidades Avançadas

```python
# MetaGPT+ - Versão aprimorada com:
# 1. Melhor gerenciamento de contexto
# 2. Suporte a múltiplos LLMs
# 3. Cache inteligente
# 4. Paralelização de tarefas

class MetaGPTPlus:
    """MetaGPT+ - Versão aprimorada"""

    def __init__(self, config: dict):
        self.config = config
        self.cache = {}
        self.parallel_tasks = []

    def enable_cache(self, ttl: int = 3600):
        """Habilita cache com TTL"""
        self.cache_config = {"enabled": True, "ttl": ttl}

    def add_parallel_task(self, task: dict):
        """Adiciona tarefa para execução paralela"""
        self.parallel_tasks.append(task)

    async def execute_parallel(self):
        """Executa tarefas em paralelo"""
        import asyncio
        tasks = [self._run_task(t) for t in self.parallel_tasks]
        results = await asyncio.gather(*tasks)
        return results

    async def _run_task(self, task: dict):
        """Executa uma tarefa individual"""
        # Lógica de execução
        return {"status": "completed", "task": task}

# Uso
metagpt_plus = MetaGPTPlus({"model": "gpt-4"})
metagpt_plus.enable_cache(ttl=1800)
```

---

## 📊 Resumo dos Comandos MetaGPT

| Comando | Descrição |
|---------|-----------|
| `metagpt "requisito"` | Gera software completo |
| `metagpt "requisito" --n_rounds 5` | Gera com 5 rounds |
| `metagpt "requisito" --code_review` | Gera com review de código |
| `metagpt "requisito" --dump` | Salva logs detalhados |

---

## 🔗 Referências

- **Repositório:** https://github.com/geekan/MetaGPT
- **Documentação:** https://docs.deepwisdom.ai/
- **Exemplos:** https://github.com/geekan/MetaGPT/tree/main/examples
- **Discord:** https://discord.gg/nwHgDS6W5e

---

> **Versão:** 2.0 | **Atualizado:** 2024 | **Licença:** MIT
