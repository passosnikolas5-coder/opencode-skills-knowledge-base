# 🤖 AutoGen — Framework Multi-Agent da Microsoft

**Fonte:** https://github.com/microsoft/autogen (45k+ estrelas)  
**Descrição:** AutoGen é um framework open-source da Microsoft para construir aplicações com múltiplos agentes conversacionais. Permite criar agentes que colaboram, executam código, usam ferramentas e resolvem tarefas complexas de forma autônoma.

---

## 1. ConversableAgent — Classe Base

ConversableAgent é a classe fundamental de todos os agentes no AutoGen.

```python
from autogen import ConversableAgent

# Criar um agente básico
agente = ConversableAgent(
    name="assistente_geral",
    llm_config={"model": "gpt-4", "api_key": "sk-xxx"},
    human_input_mode="NEVER",
    system_message="Você é um assistente útil e prestativo."
)
```

### MELHORIA

❌ **ERRADO:** Definir system_message vazio ou genérico
```python
# Fraco - sem direcionamento
agente = ConversableAgent(
    name="bot",
    llm_config={"model": "gpt-4"},
    human_input_mode="NEVER",
    system_message=""
)
```

✅ **CORRETO:** System message claro com escopo definido
```python
# Forte - instruções específicas
agente = ConversableAgent(
    name="analista_financeiro",
    llm_config={"model": "gpt-4"},
    human_input_mode="NEVER",
    system_message="""Você é um analista financeiro especializado em:
    - Análise de demonstrativos contábeis
    - Projeções de fluxo de caixa
    - Indicadores fundamentalistas
    Responda sempre com dados quantitativos e fontes."""
)
```

---

## 2. AssistantAgent

AssistantAgent é otimizado para responder perguntas e gerar código, sem solicitar input humano.

```python
from autogen import AssistantAgent

assistente = AssistantAgent(
    name="coder_assistente",
    llm_config={"model": "gpt-4", "api_key": "sk-xxx"},
    system_message="""Você é um programador experiente.
    - Escreva código Python limpo e documentado
    - Inclua tratamento de erros
    - Sugira testes unitários"""
)
```

### MELHORIA

❌ **ERRADO:** Não configurar ferramentas para o assistant
```python
# Assistente sem capacidade de executar ações
assistente = AssistantAgent(
    name="coder",
    llm_config={"model": "gpt-4"}
)
```

✅ **CORRETO:** Registrar funções que o assistant pode chamar
```python
from autogen import register_function

def calcular_media(valores: list[float]) -> float:
    """Calcula a média de uma lista de valores."""
    return sum(valores) / len(valores)

def salvar_resultado(resultado: float, arquivo: str) -> str:
    """Salva o resultado em um arquivo JSON."""
    import json
    with open(arquivo, 'w') as f:
        json.dump({"media": resultado}, f)
    return f"Resultado salvo em {arquivo}"

# Registrar ferramentas
register_function(
    calcular_media,
    caller=assistente,
    executor=user_proxy,
    name="calcular_media",
    description="Calcula a média de uma lista de números"
)

register_function(
    salvar_resultado,
    caller=assistente,
    executor=user_proxy,
    name="salvar_resultado",
    description="Salva o resultado em arquivo JSON"
)
```

---

## 3. UserProxyAgent

UserProxyAgent recebe input do usuário e pode executar código automaticamente.

```python
from autogen import UserProxyAgent

user_proxy = UserProxyAgent(
    name="usuario_executor",
    human_input_mode="ALWAYS",
    code_execution_config={
        "work_dir": "coding",
        "use_docker": False
    },
    max_consecutive_auto_reply=10,
    is_termination_msg=lambda x: x.get("content", "").rstrip().endswith("TERMINATE")
)
```

### MELHORIA

❌ **ERRADO:** Usar human_input_mode="ALWAYS" em produção
```python
# Bloqueia automação - requer interação humana constante
user_proxy = UserProxyAgent(
    name="executor",
    human_input_mode="ALWAYS"  # Impraticável para automação
)
```

✅ **CORRETO:** Usar NEVER para automação completa ou TERMINATE para controle
```python
# Para automação total
user_proxy_auto = UserProxyAgent(
    name="executor_automatico",
    human_input_mode="NEVER",
    code_execution_config={
        "work_dir": "output",
        "use_docker": True,
        "timeout": 120
    }
)

# Para controle parcial com limite de iterações
user_proxy_controlado = UserProxyAgent(
    name="executor_controlado",
    human_input_mode="TERMINATE",
    max_consecutive_auto_reply=5,
    is_termination_msg=lambda x: "CONCLUIDO" in x.get("content", "")
)
```

---

## 4. GroupChat — Conversas em Grupo

GroupChat permite múltiplos agentes discutirem e colaborarem em um chat.

```python
from autogen import GroupChat, GroupChatManager

# Criar agentes
analista = AssistantAgent(name="analista", llm_config=config)
desenvolvedor = AssistantAgent(name="desenvolvedor", llm_config=config)
revisor = AssistantAgent(name="revisor", llm_config=config)

# Configurar chat em grupo
group_chat = GroupChat(
    agents=[analista, desenvolvedor, revisor],
    messages=[],
    max_round=12,
    speaker_selection_method="round_robin",
    allow_repeat_speaker=False
)

# Gerenciar o grupo
manager = GroupChatManager(
    groupchat=group_chat,
    llm_config=config
)

# Iniciar conversa
analista.initiate_chat(
    manager,
    message="Precisamos projetar uma API REST para gerenciamento de usuários."
)
```

### MELHORIA

❌ **ERRADO:** Não definir limite de rodadas (max_round)
```python
# Conversa pode nunca terminar
group_chat = GroupChat(
    agents=[agente1, agente2],
    messages=[],
    max_round=999  # Excessivo
)
```

✅ **CORRETO:** Limitar rodadas e usar método de seleção adequado
```python
# Conversa controlada e eficiente
group_chat = GroupChat(
    agents=[analista, dev, qa],
    messages=[],
    max_round=10,  # Limite razoável
    speaker_selection_method="auto",  # LLM decide quem fala
    allow_repeat_speaker=False,
    send_introductions=True  # Apresenta os participantes
)

# Para discussões estruturadas
group_chat_estruturado = GroupChat(
    agents=[lead, dev1, dev2],
    messages=[],
    max_round=15,
    speaker_selection_method="manual",  # Controle manual
    func_role_selection="lead"  # Lead decide quem fala
)
```

---

## 5. Execução de Código

AutoGen executa código em ambiente seguro (local, Docker ou sandbox).

```python
from autogen import UserProxyAgent

# Execução local
executor_local = UserProxyAgent(
    name="executor_local",
    human_input_mode="NEVER",
    code_execution_config={
        "work_dir": "./output",
        "use_docker": False,
        "timeout": 60
    }
)

# Execução em Docker (mais seguro)
executor_docker = UserProxyAgent(
    name="executor_docker",
    human_input_mode="NEVER",
    code_execution_config={
        "work_dir": "/workspace",
        "use_docker": True,
        "docker_image": "python:3.11-slim",
        "timeout": 120
    }
)
```

### MELHORIA

❌ **ERRADO:** Executar código sem validação ou restrições
```python
# Perigoso - sem sandbox
executor = UserProxyAgent(
    name="executor",
    human_input_mode="NEVER",
    code_execution_config={"use_docker": False}
)
# Código malicioso pode ser executado no sistema
```

✅ **CORRETO:** Usar Docker e limitar recursos
```python
# Seguro - Docker com limitações
executor_seguro = UserProxyAgent(
    name="executor_seguro",
    human_input_mode="NEVER",
    code_execution_config={
        "use_docker": True,
        "docker_image": "python:3.11-slim",
        "timeout": 30,  # Timeout curto
        "work_dir": "/tmp/sandbox",
        "blocked_code_executors": ["shell"],  # Bloquear shell
        "executor_kwargs": {
            "mount_docker": False,  # Sem acesso ao host
            "network_disabled": True  # Sem rede
        }
    }
)
```

---

## 6. Uso de Ferramentas e Function Calling

Agentes podem usar ferramentas externas como APIs, bancos de dados e serviços.

```python
import requests
from autogen import register_function

def consultar_clima(cidade: str) -> str:
    """Consulta a temperatura atual de uma cidade."""
    response = requests.get(
        f"https://api.openweathermap.org/data/2.5/weather",
        params={"q": cidade, "appid": "API_KEY", "units": "metric"}
    )
    data = response.json()
    return f"{cidade}: {data['main']['temp']}°C"

def buscar_noticias(termo: str) -> str:
    """Busca notícias recentes sobre um termo."""
    # Implementação real usaría NewsAPI
    return f"Notícias sobre '{termo}': [resultado da busca]"

# Registrar ferramentas com schemas
register_function(
    consultar_clima,
    caller=assistant,
    executor=user_proxy,
    name="consultar_clima",
    description="Retorna a temperatura atual de uma cidade",
    description_method="ydoc"  # Usa schema do docstring
)

register_function(
    buscar_noticias,
    caller=assistant,
    executor=user_proxy,
    name="buscar_noticias",
    description="Busca notícias recentes sobre um termo"
)
```

### MELHORIA

❌ **ERRADO:** Não documentar parâmetros das ferramentas
```python
# Função sem schema claro
def busca(query):
    return results

register_function(busca, caller=assistant, executor=user_proxy)
# LLM pode não entender quando/chamar corretamente
```

✅ **CORRETO:** Documentação rica com tipos e exemplos
```python
def busca_produtos(
    termo: str,
    categoria: str | None = None,
    preco_maximo: float | None = None
) -> list[dict]:
    """
    Busca produtos no catálogo.
    
    Args:
        termo: Termo de busca (ex: "notebook", "fone bluetooth")
        categoria: Filtrar por categoria (opcional)
        preco_maximo: Filtrar por preço máximo (opcional)
    
    Returns:
        Lista de produtos encontrados com nome, preço e link
    """
    # Implementação da busca
    return [{"nome": "...", "preco": 99.90, "link": "..."}]

# Schema gerado automaticamente do docstring
register_function(
    busca_produtos,
    caller=assistant,
    executor=user_proxy,
    name="busca_produtos",
    description_method="ydoc"
)
```

---

## 7. Modos de Input Humano

Controla como o agente recebe input durante a conversa.

```python
from autogen import ConversableAgent

# ALWAYS - Sempre pede input humano
agente_always = ConversableAgent(
    name="chatbot_interativo",
    human_input_mode="ALWAYS"
)

# TERMINATE - Para quando a conversa terminar
agente_terminate = ConversableAgent(
    name="assistente_auto",
    human_input_mode="TERMINATE",
    max_consecutive_auto_reply=5,
    is_termination_msg=lambda x: x.get("content", "").rstrip().endswith("TERMINATE")
)

# NEVER - Nunca pede input (100% autônomo)
agente_never = ConversableAgent(
    name="agente_autonomo",
    human_input_mode="NEVER"
)
```

### MELHORIA

❌ **ERRADO:** Usar ALWAYS em automações de produção
```python
# Impraticável - trava o pipeline
agente = ConversableAgent(
    name="bot",
    human_input_mode="ALWAYS",
    llm_config=config
)
# Automação falha sem input humano disponível
```

✅ **CORRETO:** Usar TERMINATE com critérios claros
```python
agente_controlado = ConversableAgent(
    name="bot_controlado",
    human_input_mode="TERMINATE",
    max_consecutive_auto_reply=3,
    is_termination_msg=lambda x: any([
        x.get("content", "").rstrip().endswith("TERMINATE"),
        "concluído" in x.get("content", "").lower(),
        "erro" in x.get("content", "").lower()
    ]),
    llm_config=config
)
```

---

## 8. Conversas Aninhadas (Nested Chat)

Permite que um agente invoque uma subconversa para resolver subtarefas.

```python
from autogen import ConversableAgent, NestedChat

# Criar agente principal
principal = ConversableAgent(
    name="coordenador",
    human_input_mode="NEVER",
    llm_config=config
)

# Criar sub-agente para tarefas específicas
analista_dados = ConversableAgent(
    name="analista_dados",
    human_input_mode="NEVER",
    llm_config=config
)

# Configurar chat aninhado
def initiation_message(recipient, messages, sender, config):
    return f"Por favor, analise os seguintes dados:\n{messages[-1]['content']}"

nested_chat = {
    "recipient": analista_dados,
    "message": initiation_message,
    "summary_method": "last_msg",
    "max_turns": 3
}

# Registrar chat aninhado
principal.register_nested_chats(
    [nested_chat],
    trigger=lambda sender: sender == user_proxy,
    position=0
)
```

### MELHORIA

❌ **ERRADO:** Criar muitos chats aninhados sem necessidade
```python
# Complexidade desnecessária
for i in range(10):
    principal.register_nested_chats([chat[i]], trigger=...)
# 10 chats aninhados - difícil de manter
```

✅ **CORRETO:** Usar no máximo 2-3 chats aninhados com trigger claro
```python
# Estrutura limpa e manutenível
nested_chat_dados = {
    "recipient": analista_dados,
    "message": "Analise: {msg}",
    "summary_method": "last_msg",
    "max_turns": 2
}

nested_chat_codigo = {
    "recipient": desenvolvedor,
    "message": "Implemente: {msg}",
    "summary_method": "last_msg",
    "max_turns": 3
}

principal.register_nested_chats(
    [nested_chat_dados],
    trigger=lambda msg: "analise" in msg.get("content", "").lower(),
    position=0
)

principal.register_nested_chats(
    [nested_chat_codigo],
    trigger=lambda msg: "implemente" in msg.get("content", "").lower(),
    position=0
)
```

---

## 9. Criação de Agentes Customizados

Crie agentes especializados para domínios específicos.

```python
from autogen import AssistantAgent

class AgenteAnaliseFinanceira(AssistantAgent):
    def __init__(self, **kwargs):
        super().__init__(**kwargs)
        self.dominio = "finanças"
        self.indicadores = ["ROE", "ROIC", "P/L", "EV/EBITDA"]
    
    def analyze(self, empresa: str, dados: dict) -> str:
        """Analisa dados financeiros de uma empresa."""
        resultado = f"Análise de {empresa}:\n"
        for indicador in self.indicadores:
            if indicador in dados:
                resultado += f"- {indicador}: {dados[indicador]}\n"
        return resultado

# Usar agente customizado
analista_financeiro = AgenteAnaliseFinanceira(
    name="analista_financeiro",
    llm_config=config,
    human_input_mode="NEVER"
)
```

### MELHORIA

❌ **ERRADO:** Não sobrescrever métodos padrão corretamente
```python
# Classe com comportamento inesperado
class AgenteRuim(AssistantAgent):
    def __init__(self):
        super().__init__()
        # Não passa kwargs - perde configuração
```

✅ **CORRETO:** Herdar corretamente e manter interface
```python
class AgenteSuporte(AssistantAgent):
    def __init__(self, nivel_sla: str = "premium", **kwargs):
        super().__init__(**kwargs)
        self.nivel_sla = nivel_sla
    
    def get_priority(self) -> int:
        """Retorna prioridade baseada no SLA."""
        prioridades = {"premium": 1, "standard": 2, "basic": 3}
        return prioridades.get(self.nivel_sla, 3)

# Uso correto
agente_suporte = AgenteSuporte(
    name="suporte_premium",
    nivel_sla="premium",
    llm_config=config,
    human_input_mode="TERMINATE"
)
```

---

## 10. Padrões de Workflow

AutoGen suporta vários padrões de orquestração de agentes.

```python
from autogen import AssistantAgent, UserProxyAgent, GroupChat, GroupChatManager

# Padrão 1: Pipeline sequencial
# Agente A → Agente B → Agente C

# Padrão 2: Debate/Discussão
# Agentes discutem até consenso

# Padrão 3: Delegação hierárquica
# Líder delega para especialistas

# Exemplo: Pipeline de revisão de código
desenvolvedor = AssistantAgent(
    name="dev",
    llm_config=config,
    system_message="Escreva código limpo e documentado."
)

revisor = AssistantAgent(
    name="revisor",
    llm_config=config,
    system_message="Revise o código para bugs, segurança e performance."
)

tester = AssistantAgent(
    name="tester",
    llm_config=config,
    system_message="Escreva testes unitários abrangentes."
)

# Configurar pipeline
user = UserProxyAgent(name="user", human_input_mode="NEVER")

group = GroupChat(
    agents=[user, desenvolvedor, revisor, tester],
    messages=[],
    max_round=15,
    speaker_selection_method="round_robin"
)

manager = GroupChatManager(groupchat=group, llm_config=config)
user.initiate_chat(manager, message="Crie uma função de validação de CPF.")
```

### MELHORIA

❌ **ERRADO:** Não definir ordem clara nos pipelines
```python
# Ordem indefinida - comportamento imprevisível
group = GroupChat(
    agents=[dev, qa, pm],
    speaker_selection_method="auto"  # Quem fala quando?
)
```

✅ **CORRETO:** Usar round_robin ou manual para controle
```python
# Pipeline claro e previsível
group = GroupChat(
    agents=[user, dev, qa, pm],
    messages=[],
    max_round=8,
    speaker_selection_method="round_robin",  # Ordem fixa
    allow_repeat_speaker=False,
    send_introductions=True
)
```

---

## 11. AutoGen Studio (Interface Visual)

Interface web para construir e testar workflows multi-agent sem código.

```python
# Instalação do AutoGen Studio
# pip install autogenstudio

# Iniciar o servidor
# autogenstudio ui --port 8080

# Configuração via API
import autogenstudio

# Criar agente via Studio API
studio_config = {
    "name": "analista_docs",
    "model": "gpt-4",
    "system_message": "Analise documentos e extraia informações-chave.",
    "temperature": 0.3
}

# Registrar no Studio
autogenstudio.register_agent(studio_config)
```

### MELHORIA

❌ **ERRADO:** Depender apenas do Studio sem entender o código
```python
# Gera código que não pode ser versionado
# ou customizado programaticamente
# Studio cria configurações no banco de dados
```

✅ **CORRETO:** Usar Studio para prototipação e código para produção
```python
# Studio para rapidamente testar ideias
# Depois migrar para código Python puro
# Versionar as configurações em repositório

# Exportar config do Studio e versionar
import json
config_export = {
    "agents": [...],
    "workflows": [...]
}
with open("autogen_config.json", "w") as f:
    json.dump(config_export, f, indent=2)
```

---

## 12. Suporte Cross-Platform

AutoGen funciona em diferentes ambientes e pode ser integrado com outros frameworks.

```python
# Integração com LangChain
from autogen.agentchat.contrib.retrieve_assistant_agent import RetrieveAssistantAgent

# Usar retrieval augmentation
rag_agent = RetrieveAssistantAgent(
    name="rag_assistant",
    llm_config=config,
    retrieve_config={
        "task": "qa",
        "docs_path": "./documentos",
        "chunk_token_size": 2000,
        "model": "gpt-4",
        "vector_db": "chroma"
    }
)

# Integração com Azure OpenAI
config_azure = {
    "model": "gpt-4",
    "api_key": "azure-key",
    "base_url": "https://your-resource.openai.azure.com/",
    "api_type": "azure",
    "api_version": "2024-02-15-preview"
}

agent_azure = AssistantAgent(
    name="agent_azure",
    llm_config=config_azure
)
```

### MELHORIA

❌ **ERRADO:** Não verificar compatibilidade de versões
```python
# Pode quebrar com atualizações
import autogen  # Versão incompatível
```

✅ **CORRETO:** Usar requirements.txt com versões fixas
```txt
# requirements.txt
autogen==0.2.35
openai==1.50.0
langchain==0.2.0
chromadb==0.5.0
```

---

## 13. Telemetria e Monitoramento

Monitore o desempenho e comportamento dos agentes em produção.

```python
from autogen import ConversableAgent
import logging

# Configurar logging detalhado
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s',
    handlers=[
        logging.FileHandler('autogen.log'),
        logging.StreamHandler()
    ]
)

# Monitorar mensagens
agente_monitorado = ConversableAgent(
    name="agente_monitorado",
    llm_config=config,
    human_input_mode="NEVER"
)

# Callback para logging
def log_message(recipient, messages, sender, config):
    logging.info(f"De: {sender.name} → Para: {recipient.name}")
    logging.info(f"Mensagem: {messages[-1]['content'][:200]}")
    return False  # Não bloqueia

agente_monitorado.register_reply(
    trigger=[agente_monitorado],
    reply_func=log_message,
    position=0
)
```

### MELHORIA

❌ **ERRADO:** Não monitorar custos de API
```python
# Custo cresce silenciosamente
# Chamadas LLM não rastreadas
```

✅ **CORRETO:** Implementar tracking de custos e limites
```python
import tiktoken

class CostTracker:
    def __init__(self, max_cost_usd: float = 10.0):
        self.max_cost = max_cost_usd
        self.total_tokens = 0
        self.total_cost = 0.0
    
    def count_tokens(self, text: str, model: str = "gpt-4") -> int:
        encoding = tiktoken.encoding_for_model(model)
        return len(encoding.encode(text))
    
    def estimate_cost(self, tokens: int, model: str = "gpt-4") -> float:
        prices = {"gpt-4": 0.03/1000, "gpt-3.5-turbo": 0.0015/1000}
        return tokens * prices.get(model, 0.03/1000)
    
    def check_limit(self):
        if self.total_cost >= self.max_cost:
            raise ValueError(f"Limite de custo atingido: ${self.total_cost:.2f}")
        return True

tracker = CostTracker(max_cost_usd=5.0)

# Hook no agent para contar tokens
def track_cost(recipient, messages, sender, config):
    tokens = tracker.count_tokens(messages[-1]['content'])
    cost = tracker.estimate_cost(tokens)
    tracker.total_tokens += tokens
    tracker.total_cost += cost
    tracker.check_limit()
    logging.info(f"Custo acumulado: ${tracker.total_cost:.4f}")
    return False
```

---

## 14. Gerenciamento de Estado

Mantenha contexto e estado entre conversas dos agentes.

```python
from autogen import ConversableAgent
import json

class AgenteComMemoria(ConversableAgent):
    def __init__(self, **kwargs):
        super().__init__(**kwargs)
        self.memoria = {
            "conversas": [],
            "decisoes": [],
            "preferencias": {}
        }
    
    def save_context(self, key: str, value: any):
        """Salva contexto na memória do agente."""
        self.memoria[key] = value
    
    def get_context(self, key: str):
        """Recupera contexto da memória."""
        return self.memoria.get(key)
    
    def to_dict(self):
        """Serializa estado do agente."""
        return self.memoria.copy()

# Uso
agente_memoria = AgenteComMemoria(
    name="agente_com_memoria",
    llm_config=config,
    human_input_mode="NEVER"
)

agente_memoria.save_context("projeto_atual", "Sistema de vagas")
agente_memoria.save_context("decisoes", ["Usar PostgreSQL", "Deploy na AWS"])
```

### MELHORIA

❌ **ERRADO:** Armazenar memória em variável global
```python
# Perde dados entre execuções
memoria_global = {}

def salvar(msg):
    memoria_global["ultimo"] = msg  # Volátil
```

✅ **CORRETO:** Usar persistência em arquivo ou banco
```python
import pickle
from pathlib import Path

class MemoriaPersistente:
    def __init__(self, caminho: str = "memoria.pkl"):
        self.caminho = Path(caminho)
        self.dados = self._carregar()
    
    def _carregar(self) -> dict:
        if self.caminho.exists():
            return pickle.loads(self.caminho.read_bytes())
        return {}
    
    def _salvar(self):
        self.caminho.write_bytes(pickle.dumps(self.dados))
    
    def set(self, chave: str, valor):
        self.dados[chave] = valor
        self._salvar()
    
    def get(self, chave: str):
        return self.dados.get(chave)

memoria = MemoriaPersistente("estado_agente.pkl")
memoria.set("historico", ["conversa1", "conversa2"])
```

---

## 15. Depuração e Tratamento de Erros

Estratégias robustas para lidar com falhas em workflows multi-agent.

```python
from autogen import AssistantAgent, UserProxyAgent
import traceback

class AgenteResiliente(AssistantAgent):
    def __init__(self, max_tentativas: int = 3, **kwargs):
        super().__init__(**kwargs)
        self.max_tentativas = max_tentativas
        self.erros_consecutivos = 0
    
    def generate_reply(self, messages=None, sender=None, **kwargs):
        try:
            reply = super().generate_reply(messages, sender, **kwargs)
            self.erros_consecutivos = 0
            return reply
        except Exception as e:
            self.erros_consecutivos += 1
            logging.error(f"Erro {self.erros_consecutivos}/{self.max_tentativas}: {e}")
            
            if self.erros_consecutivos >= self.max_tentativas:
                return f"ERRO FATAL: {str(e)}\n{traceback.format_exc()}"
            
            # Retry com mensagem de erro
            return f"Ocorreu um erro. Tentativa {self.erros_consecutivos}. Detalhes: {e}"
```

### MELHORIA

❌ **ERRADO:** Não tratar exceções em workflows
```python
# Falha em qualquer agente derruba tudo
def workflow():
    r1 = agente1.chat("tarefa1")
    r2 = agente2.chat(r1)  # Se agente1 falhar, agente2 nunca roda
```

✅ **CORRETO:** Implementar circuit breaker e fallback
```python
import time
from functools import wraps

class CircuitBreaker:
    def __init__(self, failure_threshold: int = 3, reset_timeout: int = 60):
        self.failure_threshold = failure_threshold
        self.reset_timeout = reset_timeout
        self.failures = 0
        self.last_failure = None
        self.state = "closed"  # closed, open, half-open
    
    def __call__(self, func):
        @wraps(func)
        def wrapper(*args, **kwargs):
            if self.state == "open":
                if time.time() - self.last_failure > self.reset_timeout:
                    self.state = "half-open"
                else:
                    raise Exception("Circuit breaker OPEN - servico indisponivel")
            
            try:
                result = func(*args, **kwargs)
                self.failures = 0
                self.state = "closed"
                return result
            except Exception as e:
                self.failures += 1
                self.last_failure = time.time()
                if self.failures >= self.failure_threshold:
                    self.state = "open"
                raise
        return wrapper

# Uso
@circuit_breaker(failure_threshold=3)
def executar_agente(msg):
    return agente.generate_reply(messages=[{"content": msg, "role": "user"}])
```

---

## 16. Integração com APIs Externas

Conecte agentes com serviços cloud, bancos de dados e APIs REST.

```python
import requests
from autogen import AssistantAgent

class IntegracaoAPI:
    def __init__(self, base_url: str, api_key: str):
        self.base_url = base_url
        self.headers = {"Authorization": f"Bearer {api_key}"}
    
    def get(self, endpoint: str) -> dict:
        response = requests.get(
            f"{self.base_url}/{endpoint}",
            headers=self.headers
        )
        response.raise_for_status()
        return response.json()
    
    def post(self, endpoint: str, data: dict) -> dict:
        response = requests.post(
            f"{self.base_url}/{endpoint}",
            json=data,
            headers=self.headers
        )
        response.raise_for_status()
        return response.json()

# Registrar como ferramenta
api = IntegracaoAPI("https://api.exemplo.com/v1", "token")

def consultar_usuario(usuario_id: str) -> dict:
    """Consulta dados de um usuário pelo ID."""
    return api.get(f"usuarios/{usuario_id}")

def criar_pedido(pedido: dict) -> dict:
    """Cria um novo pedido no sistema."""
    return api.post("pedidos", pedido)

from autogen import register_function

register_function(consultar_usuario, caller=assistant, executor=proxy,
                  name="consultar_usuario")
register_function(criar_pedido, caller=assistant, executor=proxy,
                  name="criar_pedido")
```

---

## 17. Agentes de Código com Sandboxing

Execução segura de código gerado por agentes LLM.

```python
from autogen import UserProxyAgent

# Configuração com Docker para isolamento
executor_sandbox = UserProxyAgent(
    name="sandbox_executor",
    human_input_mode="NEVER",
    code_execution_config={
        "work_dir": "/tmp/sandbox",
        "use_docker": True,
        "docker_image": "python:3.11-slim",
        "timeout": 120,
        "block": True,  # Bloqueia código perigoso
        "win_size": (120, 24)
    },
    is_termination_msg=lambda x: x.get("content", "").rstrip().endswith("TERMINATE")
)

# Monitorar saída do código
def monitorar_saida(messages, sender, config):
    last_msg = messages[-1]["content"]
    if "error" in last_msg.lower():
        logging.error(f"Erro no código: {last_msg}")
    return False

executor_sandbox.register_reply(
    trigger=[executor_sandbox],
    reply_func=monitorar_saida
)
```

---

## 18. Métricas e Avaliação

Meça a eficácia dos seus workflows multi-agent.

```python
import time
from dataclasses import dataclass
from typing import List

@dataclass
class MetricasWorkflow:
    tempo_inicio: float
    tempo_fim: float
    total_mensagens: int
    agentes_utilizados: List[str]
    tokens_utilizados: int
    custo_total: float
    
    @property
    def duracao(self) -> float:
        return self.tempo_fim - self.tempo_inicio
    
    @property
    def eficiencia(self) -> float:
        """Mensagens por segundo."""
        return self.total_mensagens / max(self.duracao, 0.01)

def avaliar_workflow(workflow_func):
    """Decorator para coletar métricas."""
    def wrapper(*args, **kwargs):
        inicio = time.time()
        resultado = workflow_func(*args, **kwargs)
        fim = time.time()
        
        metricas = MetricasWorkflow(
            tempo_inicio=inicio,
            tempo_fim=fim,
            total_mensagens=len(resultado.get("messages", [])),
            agentes_utilizados=resultado.get("agents", []),
            tokens_utilizados=resultado.get("tokens", 0),
            custo_total=resultado.get("cost", 0.0)
        )
        
        print(f"Relatório de Execução:")
        print(f"  Duração: {metricas.duracao:.2f}s")
        print(f"  Mensagens: {metricas.total_mensagens}")
        print(f"  Eficiência: {metricas.eficiencia:.2f} msg/s")
        print(f"  Custo: ${metricas.custo_total:.4f}")
        
        return resultado
    return wrapper
```

---

## Referências

- **Documentação Oficial:** https://microsoft.github.io/autogen/
- **Exemplos:** https://github.com/microsoft/autogen/tree/main/python/samples
- **Cookbook:** https://github.com/microsoft/autogen/tree/main/python/packages/pyautogen/docs
- **AutoGen Studio:** https://microsoft.github.io/autogen/docs/studio
