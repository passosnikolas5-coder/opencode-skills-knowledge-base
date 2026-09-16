# ☁️ E2B — Sandbox Cloud para Execução de Código AI

> **Fonte:** https://github.com/e2b-dev/E2B (9k+ stars)
> **Descrição:** E2B é uma plataforma de sandboxes cloud para execução segura de código gerado por AI, suportando Python, JavaScript e TypeScript com controle granular de acesso e ciclo de vida.

---

## 📋 Índice de Habilidades

1. [Sandboxed Code Execution](#1)
2. [Custom Sandbox Templates](#2)
3. [File System Operations](#3)
4. [Network Access Control](#4)
5. [Environment Variables](#5)
6. [Sandbox Lifecycle Management](#6)
7. [Team Management](#7)
8. [Usage Monitoring](#8)
9. [SDK (Python, JS)](#9)
10. [AI Code Interpreter Integration](#10)
11. [Long-running Sandboxes](#11)
12. [Snapshots](#12)
13. [Template Customization](#13)
14. [Billing and Limits](#14)

---

## 1. Sandboxed Code Execution

### Exemplo: Execução Básica com Python SDK

```python
from e2b_code_interpreter import Sandbox

# Criar e executar sandbox
sandbox = Sandbox()
execution = sandbox.run_code("""
import pandas as pd
import numpy as np

# Gerar dados de exemplo
np.random.seed(42)
data = pd.DataFrame({
    'produto': [f'Produto_{i}' for i in range(100)],
    'preco': np.random.uniform(10, 500, 100),
    'vendas': np.random.randint(1, 100, 100)
})

# Análise
resumo = data.describe()
top_vendas = data.nlargest(5, 'vendas')

print("Resumo Estatístico:")
print(resumo)
print("\\nTop 5 Produtos por Vendas:")
print(top_vendas.to_string())
""")

print("Saída:", execution.logs.stdout)
print("Erros:", execution.logs.stderr)
print("Exit code:", execution.exit_code)
```

### Exemplo: Execução com JavaScript/TypeScript

```typescript
import { Sandbox } from 'e2b';

const sandbox = await Sandbox.create({
  template: 'node-js',
  timeout: 30000
});

// Executar código JavaScript
const result = await sandbox.runCode(`
  const axios = require('axios');

  async function fetchGitHubStars(repo) {
    const response = await axios.get(
      \`https://api.github.com/repos/\${repo}\`
    );
    return {
      name: response.data.full_name,
      stars: response.data.stargazers_count,
      language: response.data.language
    };
  }

  const repos = [
    'facebook/react',
    'vercel/next.js',
    'microsoft/vscode'
  ];

  const results = await Promise.all(
    repos.map(fetchGitHubStars)
  );
  console.log(JSON.stringify(results, null, 2));
`);

console.log("Resultado:", result.stdout);
```

### Exemplo: Sandbox com Bibliotecas Pré-instaladas

```python
from e2b_code_interpreter import Sandbox

# Template com bibliotecas de data science
sandbox = Sandbox(
    template="data-science",  # pandas, numpy, scikit-learn, matplotlib
    on_stdout=lambda line: print(f"[STDOUT] {line}"),
    on_stderr=lambda line: print(f"[STDERR] {line}")
)

execution = sandbox.run_code("""
import matplotlib.pyplot as plt
import seaborn as sns
from sklearn.datasets import load_iris
from sklearn.cluster import KMeans

# Carregar dados
iris = load_iris()
X = iris.data

# K-Means clustering
kmeans = KMeans(n_clusters=3, random_state=42)
clusters = kmeans.fit_predict(X)

# Visualizar
plt.figure(figsize=(10, 6))
sns.scatterplot(x=X[:, 0], y=X[:, 1], hue=clusters, palette='viridis')
plt.title('K-Means Clustering - Iris Dataset')
plt.savefig('/tmp/clusters.png')
print("Gráfico salvo em /tmp/clusters.png")
""")

# Listar arquivos gerados
files = sandbox.list_files("/tmp")
print("Arquivos:", files)
```

### ❌ ERRADO / ✅ CORRETO

❌ Executar código do usuário sem sandbox → vulnerabilidade de segurança
✅ Sempre usar sandbox isolado com recursos limitados

❌ Não configurar timeout → execução indefinida
✅ Definir timeout adequado: 30s para scripts, 5min para treinamento

---

## 2. Custom Sandbox Templates

### Exemplo: Template Docker Personalizado

```dockerfile
# Dockerfile para template customizado
FROM e2b/base:latest

# Instalar dependências do sistema
RUN apt-get update && apt-get install -y \
    ffmpeg \
    imagemagick \
    poppler-utils \
    && rm -rf /var/lib/apt/lists/*

# Instalar bibliotecas Python
RUN pip install \
    pandas numpy scipy scikit-learn \
    matplotlib seaborn plotly \
    flask fastapi uvicorn \
    boto3 google-cloud-storage \
    pillow opencv-python-headless \
    sqlalchemy psycopg2-binary

# Instalar Node.js e pacotes
RUN npm install -g typescript ts-node
RUN npm install express axios lodash moment

# Configurar diretório de trabalho
WORKDIR /home/user

# Copiar scripts auxiliares
COPY scripts/ /home/user/scripts/

# Configurar variáveis de ambiente
ENV PYTHONPATH=/home/user
ENV NODE_ENV=sandbox
```

### Exemplo: Registro de Template via SDK

```python
from e2b import SandboxTemplate

# Criar template customizado
template = SandboxTemplate.create(
    name="my-data-science-template",
    dockerfile="""
FROM e2b/base:latest
RUN pip install pandas numpy scikit-learn matplotlib seaborn
RUN npm install -g typescript
""",
    metadata={
        "description": "Template com bibliotecas de data science",
        "version": "1.0.0",
        "author": "equipe-ml"
    }
)

print(f"Template criado: {template.id}")
print(f"Build ID: {template.build_id}")

# Usar template
sandbox = Sandbox(template_id=template.id)
```

### Exemplo: Template com Serviços

```yaml
# docker-compose para template com serviços
version: '3.8'
services:
  sandbox:
    build: .
    environment:
      - DB_HOST=postgres
      - REDIS_HOST=redis
    depends_on:
      - postgres
      - redis

  postgres:
    image: postgres:16-alpine
    environment:
      POSTGRES_DB: sandbox
      POSTGRES_USER: sandbox
      POSTGRES_PASSWORD: sandbox_pass

  redis:
    image: redis:7-alpine
    ports:
      - "6379:6379"
```

### ❌ ERRADO / ✅ CORRETO

❌ Template base gigante com tudo instalado → lento para iniciar
✅ Template enxuto com apenas as dependências necessárides

❌ Não versionar templates
✅ Sempre versionar e documentar mudanças nos templates

---

## 3. File System Operations

### Exemplo: Manipulação de Arquivos

```python
from e2b_code_interpreter import Sandbox

sandbox = Sandbox()

# Criar arquivo
sandbox.files.write("/home/user/data.csv", """
id,nome,valor
1,Produto A,100.50
2,Produto B,250.00
3,Produto C,75.25
""")

# Ler arquivo
content = sandbox.files.read("/home/user/data.csv")
print("Conteúdo:", content)

# Listar diretório
files = sandbox.files.list("/home/user")
print("Arquivos:", files)

# Criar diretório
sandbox.files.make_dir("/home/user/output")

# Copiar arquivo
sandbox.files.copy(
    "/home/user/data.csv",
    "/home/user/output/data_backup.csv"
)

# Deletar arquivo
sandbox.files.remove("/home/user/data_backup.csv")

# Upload de arquivo local
sandbox.files.upload(
    local_path="./relatorio.pdf",
    remote_path="/home/user/relatorio.pdf"
)

# Download de arquivo
sandbox.files.download(
    remote_path="/home/user/output/resultado.json",
    local_path="./resultado.json"
)
```

### Exemplo: Operações Assíncronas de Arquivo

```python
import asyncio
from e2b_code_interpreter import AsyncSandbox

async def process_large_dataset():
    sandbox = await AsyncSandbox.create()

    # Upload assíncrono
    await sandbox.files.write_async(
        "/home/user/large_dataset.csv",
        open("large_dataset.csv", "r").read()
    )

    # Processar em background
    execution = await sandbox.run_code_async("""
        import pandas as pd
        import json

        df = pd.read_csv('/home/user/large_dataset.csv')

        # Processamento pesado
        result = df.groupby('categoria').agg({
            'valor': ['sum', 'mean', 'count']
        }).to_json()

        with open('/home/user/output/result.json', 'w') as f:
            f.write(result)

        print("Processamento concluído!")
    """)

    # Verificar resultado
    output = await sandbox.files.read_async("/home/user/output/result.json")
    await sandbox.close()

    return json.loads(output)

asyncio.run(process_large_dataset())
```

### ❌ ERRADO / ✅ CORRETO

❌ Arquivos temporários sem cleanup → consumo de disco
✅ Sempre deletar arquivos temporários após uso

❌ Paths hardcoded sem validação
✅ Usar paths relativos a /home/user e validar input

---

## 4. Network Access Control

### Exemplo: Configuração de Rede

```python
from e2b_code_interpreter import Sandbox

# Sandbox com acesso restrito
sandbox = Sandbox(
    # Bloquear todo acesso externo por padrão
    block_internet=True,
    # Permitir apenas domínios específicos
    allowed_domains=[
        "api.github.com",
        "api.openai.com",
        "*.amazonaws.com"
    ],
    # Portas permitidas
    allowed_ports=[443, 80],  # HTTPS e HTTP
)

# Sandbox para scraping web
scraping_sandbox = Sandbox(
    block_internet=False,
    allowed_domains=["*"],
    # Rate limiting para evitar abuso
    rate_limit={
        "requests_per_minute": 60,
        "bandwidth_mb_per_hour": 100
    }
)

# Sandbox isolado (sem rede)
isolated_sandbox = Sandbox(
    block_internet=True,
    block_dns=True,
    block_incoming=True
)
```

### Exemplo: Proxy Configurável

```python
from e2b_code_interpreter import Sandbox

sandbox = Sandbox(
    # Configurar proxy corporativo
    proxy={
        "http": "http://proxy.empresa.com:8080",
        "https": "http://proxy.empresa.com:8080",
        "no_proxy": "localhost,127.0.0.1"
    },
    # Certificados CA customizados
    ca_certificates="/home/user/certs/corporate-ca.crt",
    # DNS customizado
    dns_servers=["8.8.8.8", "8.8.4.4"]
)

# Testar conectividade
execution = sandbox.run_code("""
import requests

# Testar acesso permitido
response = requests.get("https://api.github.com/repos/e2b-dev/E2B")
print(f"GitHub API: {response.status_code}")

# Testar acesso bloqueado (vai falhar)
try:
    response = requests.get("https://evil.com/data")
except Exception as e:
    print(f"Acesso bloqueado: {type(e).__name__}")
""")
```

### ❌ ERRADO / ✅ CORRETO

❌ Sandbox com acesso total à internet → risco de exfiltração
✅ Restringir domínios e portas apenas para necessidade real

❌ Não configurar DNS → possível poisoning
✅ Usar DNS confiável e monitorar queries

---

## 5. Environment Variables

### Exemplo: Gerenciamento de Variáveis

```python
from e2b_code_interpreter import Sandbox

# Variáveis de ambiente para o sandbox
sandbox = Sandbox(
    env_vars={
        # Credenciais (usar secrets em produção)
        "API_KEY": "sk-1234567890",
        "DATABASE_URL": "postgresql://user:pass@host/db",

        # Configuração da aplicação
        "APP_ENV": "sandbox",
        "LOG_LEVEL": "INFO",
        "MAX_RETRIES": "3",

        # Features flags
        "ENABLE_CACHING": "true",
        "ENABLE_LOGGING": "true"
    }
)

# Sandbox com secrets do E2B
sandbox = Sandbox(
    secrets={
        "OPENAI_API_KEY": "{{secret:openai_key}}",
        "AWS_ACCESS_KEY": "{{secret:aws_access}}",
        "STRIPE_KEY": "{{secret:stripe_sk}}"
    }
)

# Acessar variáveis no código
execution = sandbox.run_code("""
import os

api_key = os.environ.get('API_KEY')
db_url = os.environ.get('DATABASE_URL')
app_env = os.environ.get('APP_ENV', 'production')

print(f"Environment: {app_env}")
print(f"DB URL: {db_url[:30]}...")
print(f"API Key exists: {api_key is not None}")
""")
```

### ❌ ERRADO / ✅ CORRETO

❌ Secrets hardcoded no código do sandbox
✅ Usar secrets do E2B ou variáveis de ambiente criptografadas

❌ Variáveis sensíveis em logs
✅ Filtrar variáveis sensíveis antes de logar: `***REDACTED***`

---

## 6. Sandbox Lifecycle Management

### Exemplo: Gerenciamento de Ciclo de Vida

```python
from e2b_code_interpreter import Sandbox
import time

# Criar sandbox
sandbox = Sandbox(
    template="python",
    timeout=300000,  # 5 minutos
    metadata={
        "user_id": "user_123",
        "session_id": "session_456",
        "purpose": "data_analysis"
    }
)

print(f"Sandbox ID: {sandbox.id}")

# Executar código
sandbox.run_code("print('Olá do sandbox!')")

# Verificar status
print(f"Status: {sandbox.is_running()}")
print(f"Uptime: {sandbox.uptime()}")

# Pausar sandbox (economizar recursos)
sandbox.pause()
print(f"Pausado: {sandbox.is_paused()}")

# Retomar sandbox
sandbox.resume()
print(f"Retomado: {sandbox.is_running()}")

# Listar todos os sandboxes ativos
active_sandboxes = Sandbox.list()
for sb in active_sandboxes:
    print(f"  {sb.id} - {sb.metadata} - {sb.uptime()}")

# Finalizar sandbox
sandbox.kill()
print("Sandbox finalizado")
```

### Exemplo: Auto-cleanup com Timer

```python
from e2b_code_interpreter import Sandbox
import threading

class SandboxManager:
    def __init__(self):
        self.sandboxes = {}
        self.cleanup_interval = 300  # 5 minutos

    def create_sandbox(self, user_id, timeout=300000):
        sandbox = Sandbox(timeout=timeout)
        self.sandboxes[sandbox.id] = {
            "sandbox": sandbox,
            "user_id": user_id,
            "created_at": time.time(),
            "last_activity": time.time()
        }
        return sandbox

    def cleanup_idle_sandboxes(self):
        now = time.time()
        idle_threshold = 600  # 10 minutos

        for sb_id, info in list(self.sandboxes.items()):
            idle_time = now - info["last_activity"]
            if idle_time > idle_threshold:
                info["sandbox"].kill()
                del self.sandboxes[sb_id]
                print(f"Cleaned up idle sandbox: {sb_id}")

    def start_cleanup_timer(self):
        def cleanup_loop():
            while True:
                time.sleep(self.cleanup_interval)
                self.cleanup_idle_sandboxes()

        timer = threading.Thread(target=cleanup_loop, daemon=True)
        timer.start()

# Uso
manager = SandboxManager()
manager.start_cleanup_timer()

sandbox = manager.create_sandbox("user_123")
```

### ❌ ERRADO / ✅ CORRETO

❌ Sandboxes esquecidos rodando → custos crescentes
✅ Auto-cleanup com threshold de inatividade

❌ Não monitorar uso de recursos
✅ Alertas para sandboxes com uso excessivo de CPU/memória

---

## 7. Team Management

### Exemplo: Configuração de Equipe

```python
from e2b import Client

client = Client(api_key="your-api-key")

# Criar organização
org = client.organizations.create(
    name="Empresa X",
    billing_email="admin@empresa.com"
)

# Adicionar membros
client.organizations.members.add(
    org_id=org.id,
    email="dev1@empresa.com",
    role="developer"  # admin, developer, viewer
)

client.organizations.members.add(
    org_id=org.id,
    email="dev2@empresa.com",
    role="developer"
)

client.organizations.members.add(
    org_id=org.id,
    email="stakeholder@empresa.com",
    role="viewer"
)

# Criar projeto
project = client.projects.create(
    org_id=org.id,
    name="Projeto AI",
    description="Sandbox para testes de AI"
)

# Configurar permissões por projeto
client.projects.permissions.update(
    project_id=project.id,
    permissions={
        "create_sandbox": ["developer", "admin"],
        "view_sandbox": ["developer", "admin", "viewer"],
        "delete_sandbox": ["admin"],
        "manage_team": ["admin"]
    }
)
```

### ❌ ERRADO / ✅ CORRETO

❌ Todos com acesso de admin → risco de segurança
✅ Princípio do menor privilégio: viewer para stakeholders

❌ Sem audit log de ações
✅ Log de todas as ações: quem criou/deletou/pausou sandboxes

---

## 8. Usage Monitoring

### Exemplo: Métricas de Uso

```python
from e2b import Client

client = Client(api_key="your-api-key")

# Obter métricas de uso
usage = client.billing.get_usage(
    period="current_month",
    granularity="daily"
)

print(f"CPU Hours: {usage.cpu_hours}")
print(f"RAM GB-Hours: {usage.ram_gb_hours}")
print(f"Storage GB: {usage.storage_gb}")
print(f"Custo estimado: ${usage.estimated_cost}")

# Métricas por sandbox
sandbox_usage = client.sandboxes.get_usage(
    sandbox_id="sb_123"
)

print(f"Uptime: {sandbox_usage.uptime_hours}h")
print(f"Peak RAM: {sandbox_usage.peak_ram_mb}MB")
print(f"Total executions: {sandbox_usage.executions}")

# Alertas de limite
limits = client.billing.get_limits()
for limit in limits:
    pct_used = (limit.used / limit.total) * 100
    if pct_used > 80:
        print(f"⚠️ Limite de {limit.name} em {pct_used:.1f}%")
```

### Exemplo: Dashboard de Monitoramento

```javascript
const monitoringDashboard = {
  metrics: {
    realtime: {
      activeSandboxes: { type: "gauge", current: 12 },
      cpuUsage: { type: "gauge", current: 45, unit: "%" },
      memoryUsage: { type: "gauge", current: 60, unit: "%" },
      activeConnections: { type: "gauge", current: 8 }
    },
    historical: {
      dailyExecutions: { type: "counter", period: "daily" },
      avgExecutionTime: { type: "histogram", period: "hourly" },
      errorRate: { type: "percentage", period: "daily" },
      costPerUser: { type: "sum", groupBy: "user_id", period: "monthly" }
    }
  },
  alerts: [
    { condition: "cpuUsage > 90%", action: "notify", channel: "slack" },
    { condition: "errorRate > 5%", action: "page", channel: "pagerduty" },
    { condition: "cost > budget * 0.9", action: "notify", channel: "email" }
  ]
};
```

### ❌ ERRADO / ✅ CORRETO

❌ Não monitorar custos → surpresas na fatura
✅ Alertas de custo em 80% e 90% do orçamento

❌ Métricas sem contexto de negócio
✅ correlacionar métricas técnicas com impacto no negócio

---

## 9. SDK (Python, JS)

### Exemplo: SDK Python Avançado

```python
from e2b_code_interpreter import Sandbox
import json

class CodeExecutor:
    def __init__(self, template="python"):
        self.template = template
        self.sandbox = None

    def __enter__(self):
        self.sandbox = Sandbox(
            template=self.template,
            on_stdout=self._handle_stdout,
            on_stderr=self._handle_stderr
        )
        return self

    def __exit__(self, exc_type, exc_val, exc_tb):
        if self.sandbox:
            self.sandbox.kill()

    def _handle_stdout(self, line):
        print(f"[STDOUT] {line}")

    def _handle_stderr(self, line):
        print(f"[STDERR] {line}")

    def execute(self, code, timeout=30000):
        execution = self.sandbox.run_code(code, timeout=timeout)
        return {
            "stdout": execution.logs.stdout,
            "stderr": execution.logs.stderr,
            "exit_code": execution.exit_code,
            "results": [r.text for r in execution.results] if execution.results else []
        }

# Uso do context manager
with CodeExecutor("python") as executor:
    result = executor.execute("""
        import json
        data = {"status": "ok", "message": "Execução concluída"}
        print(json.dumps(data, indent=2))
    """)
    print(json.dumps(result, indent=2))
```

### Exemplo: SDK JavaScript/TypeScript

```typescript
import { Sandbox } from 'e2b';

class SandboxPool {
  private sandboxes: Map<string, Sandbox> = new Map();
  private maxPoolSize: number;

  constructor(maxPoolSize: number = 5) {
    this.maxPoolSize = maxPoolSize;
  }

  async acquire(template: string = 'python'): Promise<Sandbox> {
    if (this.sandboxes.size >= this.maxPoolSize) {
      throw new Error('Pool is full');
    }

    const sandbox = await Sandbox.create({
      template,
      timeout: 300000
    });

    this.sandboxes.set(sandbox.id, sandbox);
    return sandbox;
  }

  async release(sandboxId: string): Promise<void> {
    const sandbox = this.sandboxes.get(sandboxId);
    if (sandbox) {
      await sandbox.kill();
      this.sandboxes.delete(sandboxId);
    }
  }

  async releaseAll(): Promise<void> {
    for (const [id, sandbox] of this.sandboxes) {
      await sandbox.kill();
    }
    this.sandboxes.clear();
  }
}

// Uso
const pool = new SandboxPool(3);

async function runUserCode(code: string) {
  const sandbox = await pool.acquire('python');
  try {
    const result = await sandbox.runCode(code);
    return result.stdout;
  } finally {
    await pool.release(sandbox.id);
  }
}
```

### ❌ ERRADO / ✅ CORRETO

❌ Não fechar sandboxes → memory leak e custos
✅ Usar context manager ou try/finally para garantir cleanup

❌ Pool sem limite de tamanho → exaustão de recursos
✅ Pool com tamanho máximo configurável

---

## 10. AI Code Interpreter Integration

### Exemplo: Code Interpreter para Chatbot

```python
from e2b_code_interpreter import Sandbox
import openai

class AICodeInterpreter:
    def __init__(self):
        self.sandbox = Sandbox(
            template="python",
            on_stdout=self._on_stdout,
            on_stderr=self._on_stderr
        )
        self.conversation_history = []

    def _on_stdout(self, line):
        print(f"Code output: {line}")

    def _on_stderr(self, line):
        print(f"Code error: {line}")

    def execute_with_ai(self, user_request):
        # Gerar código com AI
        code_prompt = f"""
        Gere código Python para: {user_request}
        Contexto anterior: {self.conversation_history[-3:]}
        """

        response = openai.chat.completions.create(
            model="gpt-4",
            messages=[{"role": "user", "content": code_prompt}]
        )

        code = response.choices[0].message.content

        # Executar código no sandbox
        execution = self.sandbox.run_code(code)

        # Registrar na conversa
        self.conversation_history.append({
            "request": user_request,
            "code": code,
            "output": execution.logs.stdout,
            "error": execution.logs.stderr
        })

        return {
            "code": code,
            "output": execution.logs.stdout,
            "error": execution.logs.stderr,
            "success": execution.exit_code == 0
        }

# Uso
interpreter = AICodeInterpreter()
result = interpreter.execute_with_ai(
    "Crie um gráfico de barras mostrando vendas por região"
)
```

### Exemplo: Code Interpreter com Sandbox Persistente

```python
from e2b_code_interpreter import Sandbox

class PersistentInterpreter:
    def __init__(self, user_id):
        self.user_id = user_id
        self.sandbox = Sandbox(
            template="python",
            metadata={"user_id": user_id}
        )
        # Estado persistente no sandbox
        self.sandbox.run_code("""
import json
import os

# Carregar estado anterior se existir
STATE_FILE = '/home/user/state.json'
if os.path.exists(STATE_FILE):
    with open(STATE_FILE) as f:
        state = json.load(f)
    print(f"Estado carregado: {len(state)} variáveis")
else:
    state = {}
    print("Novo estado criado")
""")

    def execute(self, code):
        # Injetar código de persistência
        full_code = f"""
{code}

# Salvar estado
import json
with open('/home/user/state.json', 'w') as f:
    json.dump(locals(), f, default=str)
"""
        return self.sandbox.run_code(full_code)

    def get_state(self):
        execution = self.sandbox.run_code("""
import json
with open('/home/user/state.json') as f:
    state = json.load(f)
print(json.dumps(state, indent=2, default=str))
""")
        return execution.logs.stdout
```

### ❌ ERRADO / ✅ CORRETO

❌ Executar código AI sem supervisão
✅ Validar código antes de executar e monitorar execução

❌ Sandbox sem persistência entre interações
✅ Manter sandbox vivo durante sessão do usuário

---

## 11. Long-running Sandboxes

### Exemplo: Sandbox para Tarefas Longas

```python
from e2b_code_interpreter import Sandbox
import time

# Sandbox para treinamento de modelo
training_sandbox = Sandbox(
    template="ml-training",
    timeout=3600000,  # 1 hora
    resources={
        "cpu": 4,
        "ram": 8192,  # 8GB
        "gpu": "nvidia-t4"  # se disponível
    }
)

# Executar treinamento
execution = training_sandbox.run_code("""
import time

print("Iniciando treinamento...")
for epoch in range(10):
    time.sleep(6)  # Simular treinamento
    loss = 1.0 / (epoch + 1)
    print(f"Epoch {epoch + 1}/10 - Loss: {loss:.4f}")

print("Treinamento concluído!")

# Salvar modelo
import pickle
model = {"weights": [0.1, 0.2, 0.3], "bias": 0.5}
with open('/home/user/model.pkl', 'wb') as f:
    pickle.dump(model, f)

print("Modelo salvo em /home/user/model.pkl")
""")

# Download do modelo treinado
training_sandbox.files.download(
    remote_path="/home/user/model.pkl",
    local_path="./trained_model.pkl"
)
```

### Exemplo: Monitoramento de Sandbox Longo

```python
from e2b_code_interpreter import Sandbox
import threading
import time

class LongRunningSandbox:
    def __init__(self, task_name, timeout=3600000):
        self.task_name = task_name
        self.sandbox = Sandbox(timeout=timeout)
        self.metrics = {"start_time": time.time(), "status": "running"}
        self._start_monitor()

    def _start_monitor(self):
        def monitor():
            while self.metrics["status"] == "running":
                stats = self.sandbox.get_stats()
                self.metrics.update({
                    "cpu_percent": stats.get("cpu_percent", 0),
                    "ram_mb": stats.get("ram_mb", 0),
                    "uptime": time.time() - self.metrics["start_time"]
                })
                print(f"[{self.task_name}] CPU: {self.metrics['cpu_percent']}% | "
                      f"RAM: {self.metrics['ram_mb']}MB | "
                      f"Uptime: {self.metrics['uptime']:.0f}s")
                time.sleep(30)

        thread = threading.Thread(target=monitor, daemon=True)
        thread.start()

    def execute(self, code):
        execution = self.sandbox.run_code(code)
        self.metrics["status"] = "completed" if execution.exit_code == 0 else "failed"
        return execution

    def get_metrics(self):
        return self.metrics

# Uso
task = LongRunningSandbox("model_training", timeout=3600000)
result = task.execute("print('Tarefa concluída!')")
print(f"Métricas finais: {task.get_metrics()}")
```

### ❌ ERRADO / ✅ CORRETO

❌ Sandbox longo sem monitoramento
✅ Monitorar CPU, RAM e status periodicamente

❌ Não ter mecanismo de cancelamento
✅ Implementar timeout e ability de kill remoto

---

## 12. Snapshots

### Exemplo: Criar e Usar Snapshots

```python
from e2b_code_interpreter import Sandbox

# Criar sandbox base
base_sandbox = Sandbox(template="python")

# Instalar dependências e configurar
base_sandbox.run_code("""
!pip install pandas numpy scikit-learn matplotlib seaborn plotly

import json
config = {
    "data_dir": "/home/user/data",
    "output_dir": "/home/user/output",
    "model_dir": "/home/user/models"
}
with open('/home/user/config.json', 'w') as f:
    json.dump(config, f)

print("Configuração concluída!")
""")

# Criar snapshot do estado
snapshot = base_sandbox.snapshot(
    name="data-science-env",
    description="Ambiente com pandas, sklearn e configuração",
    metadata={
        "version": "1.0",
        "packages": ["pandas", "numpy", "sklearn", "matplotlib"]
    }
)

print(f"Snapshot criado: {snapshot.id}")

# Criar novo sandbox a partir do snapshot
restored_sandbox = Sandbox(snapshot_id=snapshot.id)

# Verificar que estado foi restaurado
restored_sandbox.run_code("""
import json
with open('/home/user/config.json') as f:
    config = json.load(f)
print(f"Config restaurada: {config}")
""")

# Listar snapshots
snapshots = Sandbox.list_snapshots()
for snap in snapshots:
    print(f"  {snap.name} - {snap.description}")

# Deletar snapshot antigo
snapshot.delete()
```

### Exemplo: Snapshots com Versionamento

```python
from e2b_code_interpreter import Sandbox

class SnapshotVersioner:
    def __init__(self):
        self.sandbox = Sandbox()

    def create_versioned_snapshot(self, version, notes):
        # Salvar estado atual
        self.sandbox.run_code(f"""
import json
version_info = {{
    "version": "{version}",
    "notes": "{notes}",
    "timestamp": __import__('datetime').datetime.now().isoformat()
}}
with open('/home/user/VERSION', 'w') as f:
    json.dump(version_info, f, indent=2)
""")

        # Criar snapshot
        snapshot = self.sandbox.snapshot(
            name=f"v{version}",
            description=notes,
            metadata={"version": version, "notes": notes}
        )

        return snapshot

    def rollback(self, snapshot_id):
        # Criar novo sandbox do snapshot
        self.sandbox = Sandbox(snapshot_id=snapshot_id)

        # Verificar versão
        self.sandbox.run_code("""
import json
with open('/home/user/VERSION') as f:
    version = json.load(f)
print(f"Rollback para versão: {version['version']}")
""")

# Uso
versioner = SnapshotVersioner()
v1 = versioner.create_versioned_snapshot("1.0", "Versão inicial")
v2 = versioner.create_versioned_snapshot("1.1", "Adicionado plotly")

# Rollback se necessário
versioner.rollback(v1.id)
```

### ❌ ERRADO / ✅ CORRETO

❌ Snapshots sem versionamento
✅ Versionar snapshots com notas e timestamps

❌ Não limpar snapshots antigos → custos de armazenamento
✅ Politica de retenção: manter últimos 5 snapshots

---

## 13. Template Customization

### Exemplo: Template com Build Customizado

```python
from e2b import SandboxTemplate

# Template com build customizado
template = SandboxTemplate.create(
    name="custom-ml-template",
    dockerfile="""
FROM python:3.11-slim

# Dependências do sistema
RUN apt-get update && apt-get install -y \\
    gcc g++ libffi-dev \\
    && rm -rf /var/lib/apt/lists/*

# Dependências Python
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Código auxiliar
COPY scripts/ /opt/scripts/

# Configuração
ENV PYTHONPATH=/opt/scripts
ENV PYTHONUNBUFFERED=1

WORKDIR /home/user
""",
    build_context={
        "requirements.txt": """
pandas==2.1.0
numpy==1.25.0
scikit-learn==1.3.0
matplotlib==3.7.0
seaborn==0.12.0
plotly==5.15.0
fastapi==0.100.0
uvicorn==0.23.0
""",
        "scripts/": {
            "utils.py": """
def load_data(path):
    import pandas as pd
    return pd.read_csv(path)

def save_results(data, path):
    import json
    with open(path, 'w') as f:
        json.dump(data, f, indent=2)
""",
            "visualize.py": """
def plot_bar(data, title, xlabel, ylabel):
    import matplotlib.pyplot as plt
    plt.figure(figsize=(10, 6))
    plt.bar(data.index, data.values)
    plt.title(title)
    plt.xlabel(xlabel)
    plt.ylabel(ylabel)
    plt.savefig('/home/user/output/plot.png')
"""
        }
    }
)
```

### Exemplo: Template com Variáveis Dinâmicas

```python
from e2b import SandboxTemplate

# Template com placeholders
template = SandboxTemplate.create(
    name="configurable-template",
    dockerfile="""
FROM python:3.11-slim
RUN pip install {{PYTHON_PACKAGES}}
ENV APP_NAME={{APP_NAME}}
ENV APP_VERSION={{APP_VERSION}}
""",
    variables={
        "PYTHON_PACKAGES": "pandas numpy scikit-learn",
        "APP_NAME": "MyApp",
        "APP_VERSION": "1.0.0"
    }
)

# Criar sandbox com variáveis específicas
sandbox = Sandbox(
    template_id=template.id,
    variables={
        "PYTHON_PACKAGES": "pandas numpy flask",
        "APP_NAME": "DataProcessor",
        "APP_VERSION": "2.1.0"
    }
)
```

### ❌ ERRADO / ✅ CORRETO

❌ Templates sem documentação
✅ README detalhado com exemplos de uso e parâmetros

❌ Build não cacheável → lento para rebuilds
✅ Multi-stage builds e layers otimizadas para cache

---

## 14. Billing and Limits

### Exemplo: Configuração de Limites

```python
from e2b import Client

client = Client(api_key="your-api-key")

# Configurar limites por projeto
client.projects.limits.update(
    project_id="proj_123",
    limits={
        # Limites de sandbox
        "max_sandboxes": 10,
        "max_concurrent_sandboxes": 5,
        "sandbox_timeout": 3600000,  # 1 hora

        # Limites de recursos
        "max_cpu": 8,
        "max_ram_mb": 16384,  # 16GB
        "max_storage_gb": 100,

        # Limites de rede
        "max_bandwidth_gb": 50,
        "allowed_egress": ["api.openai.com", "api.github.com"],

        # Limites de execução
        "max_code_executions": 1000,
        "max_code_length": 50000  # caracteres
    }
)

# Configurar alertas de billing
client.billing.alerts.create(
    org_id="org_123",
    alerts=[
        {"type": "cost_threshold", "threshold": 50, "currency": "USD"},
        {"type": "usage_percent", "metric": "cpu_hours", "threshold": 80},
        {"type": "usage_percent", "metric": "storage", "threshold": 90}
    ],
    channels=["email:admin@empresa.com", "slack:billing-alerts"]
)

# Consultar uso atual
usage = client.billing.get_current_usage()
print(f"CPU Hours: {usage.cpu_hours}/{usage.limits.cpu_hours}")
print(f"Storage: {usage.storage_gb}/{usage.limits.storage_gb}")
print(f"Custo este mês: ${usage.current_cost}")
print(f"Projeção fim do mês: ${usage.projected_cost}")
```

### Exemplo: Controle de Custos

```python
from e2b_code_interpreter import Sandbox
import time

class CostAwareSandbox:
    COST_PER_CPU_HOUR = 0.01
    COST_PER_GB_RAM_HOUR = 0.005
    COST_PER_GB_STORAGE = 0.001

    def __init__(self, budget_limit=10.0):
        self.budget_limit = budget_limit
        self.start_time = time.time()
        self.sandbox = Sandbox()
        self.resources = {"cpu": 2, "ram_gb": 4}

    def calculate_cost(self):
        elapsed_hours = (time.time() - self.start_time) / 3600
        cpu_cost = self.resources["cpu"] * elapsed_hours * self.COST_PER_CPU_HOUR
        ram_cost = self.resources["ram_gb"] * elapsed_hours * self.COST_PER_GB_RAM_HOUR
        return cpu_cost + ram_cost

    def check_budget(self):
        current_cost = self.calculate_cost()
        if current_cost >= self.budget_limit:
            print(f"⚠️ Orçamento atingido: ${current_cost:.2f}/{self.budget_limit}")
            self.sandbox.kill()
            return False
        return True

    def execute(self, code):
        if not self.check_budget():
            raise Exception("Budget exceeded")

        execution = self.sandbox.run_code(code)

        print(f"Custo atual: ${self.calculate_cost():.4f}")
        print(f"Restante: ${self.budget_limit - self.calculate_cost():.4f}")

        return execution

# Uso
sandbox = CostAwareSandbox(budget_limit=5.0)
for i in range(10):
    if not sandbox.check_budget():
        break
    sandbox.execute(f"print('Execução {i+1}')")
```

### ❌ ERRADO / ✅ CORRETO

❌ Sem limite de orçamento → custos inesperados
✅ Definir budget limit e alertas em 80% e 90%

❌ Não monitorar custos em tempo real
✅ Dashboard de custos com projeção e alertas automáticos

❌ Sandboxes idle consumindo recursos
✅ Auto-kill sandboxes idle após 10 minutos

---

> **Total de habilidades documentadas:** 14 categorias com exemplos práticos e comparações ERRADO/CORRETO
