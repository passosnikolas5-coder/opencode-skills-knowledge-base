# 🦙 OLLAMA - Skills Avançadas

## 📋 Informações da Skill
- **Fonte:** https://github.com/ollama/ollama (140k+ stars)
- **Descrição:** Ferramenta para rodar LLMs localmente com facilidade
- **Categoria:** Local LLM Deployment
- **Versão:** 0.5.x
- **Última atualização:** 2025

---

## 🎯 Visão Geral

Ollama permite rodar modelos de linguagem grandes (LLMs) localmente no seu computador. Suporta uma ampla variedade de modelos, gerenciamento fácil, API REST completa, e integração com diversas ferramentas do ecossistema de IA.

---

## 📚 Habilidades Principais

### 1. Model Management - Gerenciamento de Modelos

Gerencie seus modelos de LLM com comandos simples.

```bash
# Listar todos os modelos instalados
ollama list

# Listar modelos detalhadamente
ollama list --format json

# Puxar um modelo da biblioteca
ollama pull llama3.2
ollama pull mistral
ollama pull codellama:13b

# Puxar modelo com tag especifica
ollama pull llama3.2:70b
ollama pull qwen2.5:14b

# Remover modelo
ollama rm llama3.2:7b

# Ver informacoes do modelo
ollama show llama3.2
ollama show llama3.2 --modelfile
ollama show llama3.2 --parameters
ollama show llama3.2 --template
```

### 2. Model Creation - Criacao de Modelos com Modelfile

Crie modelos personalizados com configuracoes especificas usando Modelfiles.

```dockerfile
# Modelfile para modelo personalizado
FROM llama3.2

# Configuracoes do sistema
SYSTEM Voce e um assistente especializado em programacao Python.
Responda sempre em portugues brasileiro.

# Parametros de geracao
PARAMETER temperature 0.7
PARAMETER top_p 0.9
PARAMETER top_k 40
PARAMETER num_ctx 4096
PARAMETER repeat_penalty 1.1
PARAMETER seed 42
```

```bash
# Criar modelo a partir do Modelfile
ollama create meu-assistente -f Modelfile

# Testar o modelo criado
ollama run meu-assistente "Explique closures em Python"

# Listar para confirmar criacao
ollama list
```

### 3. API Endpoints - Endpoints da API REST

Ollama expoe uma API REST completa para integracao com aplicacoes.

```bash
# Iniciar o servidor Ollama
ollama serve

# Verificar se o servidor esta rodando
curl http://localhost:11434/api/tags

# Geracao de texto simples
curl http://localhost:11434/api/generate -d '{"model":"llama3.2","prompt":"O que e ML?","stream":false}'

# Chat interativo
curl http://localhost:11434/api/chat -d '{"model":"llama3.2","messages":[{"role":"system","content":"Voce e util."},{"role":"user","content":"Explique REST"}],"stream":false}'

# Gerar embeddings
curl http://localhost:11434/api/embeddings -d '{"model":"llama3.2","prompt":"Texto para embedding"}'
```

```python
import requests

class OllamaClient:
    def __init__(self, base_url="http://localhost:11434"):
        self.base_url = base_url

    def generate(self, model, prompt, stream=False, **kwargs):
        payload = {"model": model, "prompt": prompt, "stream": stream, **kwargs}
        response = requests.post(f"{self.base_url}/api/generate", json=payload)
        return response.json()

    def chat(self, model, messages, stream=False, **kwargs):
        payload = {"model": model, "messages": messages, "stream": stream, **kwargs}
        response = requests.post(f"{self.base_url}/api/chat", json=payload)
        return response.json()

    def embeddings(self, model, prompt):
        payload = {"model": model, "prompt": prompt}
        response = requests.post(f"{self.base_url}/api/embeddings", json=payload)
        return response.json()

    def list_models(self):
        response = requests.get(f"{self.base_url}/api/tags")
        return response.json()

client = OllamaClient()
result = client.generate("llama3.2", "O que e Python?")
print(result["response"])
```

### 4. System Prompts - Prompts de Sistema

Configure o comportamento do modelo com prompts de sistema personalizados.

```python
import requests

class OllamaPromptManager:
    def __init__(self, model="llama3.2"):
        self.model = model
        self.base_url = "http://localhost:11434"
        self.system_prompts = {
            "coder": "Voce e um programador senior. Responda com codigo sempre que possivel.",
            "analyst": "Voce e um analista de dados. Forneca insights baseados em dados.",
            "teacher": "Voce e um professor paciente. Explique conceitos de forma simples.",
            "writer": "Voce e um escritor criativo. Escreva de forma envolvente.",
            "translator": "Voce e um tradutor profissional. Traduza mantendo o sentido."
        }

    def chat_with_role(self, role, user_message):
        system_prompt = self.system_prompts.get(role, "")
        messages = [
            {"role": "system", "content": system_prompt},
            {"role": "user", "content": user_message}
        ]
        response = requests.post(
            f"{self.base_url}/api/chat",
            json={"model": self.model, "messages": messages, "stream": False}
        )
        return response.json()["message"]["content"]

pm = OllamaPromptManager()
resposta = pm.chat_with_role("coder", "Como implementar um decorador em Python?")
print(resposta)
```

### 5. Parameters - Parametros de Geracao

Controle a geracao de texto ajustando parametros como temperatura, top_p, e mais.

```python
import requests

class OllamaParameterTuner:
    def __init__(self, model="llama3.2"):
        self.model = model
        self.base_url = "http://localhost:11434"

    def generate_with_params(self, prompt, params=None):
        if params is None:
            params = {}
        payload = {"model": self.model, "prompt": prompt, "stream": False, **params}
        response = requests.post(f"{self.base_url}/api/generate", json=payload)
        return response.json()

    def creative_writing(self, prompt):
        params = {"temperature": 0.9, "top_p": 0.95, "top_k": 60, "repeat_penalty": 1.2}
        return self.generate_with_params(prompt, params)

    def factual_answer(self, prompt):
        params = {"temperature": 0.3, "top_p": 0.8, "top_k": 20, "repeat_penalty": 1.1, "seed": 42}
        return self.generate_with_params(prompt, params)

    def code_generation(self, prompt):
        params = {"temperature": 0.2, "top_p": 0.85, "top_k": 30, "repeat_penalty": 1.05}
        return self.generate_with_params(prompt, params)

tuner = OllamaParameterTuner()
resultado = tuner.creative_writing("Escreva sobre um mundo futurista")
print(resultado["response"])
```

### 6. Multi-Model Support - Suporte a Multiplos Modelos

Gerencie e utilize multiplos modelos para diferentes tarefas.

```python
import requests
from typing import Dict, Optional
from dataclasses import dataclass
from enum import Enum

class ModelType(Enum):
    GENERAL = "general"
    CODE = "code"
    MATH = "math"
    VISION = "vision"
    EMBEDDING = "embedding"

@dataclass
class ModelConfig:
    name: str
    model_type: ModelType
    max_tokens: int
    description: str

class MultiModelManager:
    def __init__(self):
        self.base_url = "http://localhost:11434"
        self.models: Dict[str, ModelConfig] = {}
        self._register_default_models()

    def _register_default_models(self):
        self.register_model(ModelConfig("llama3.2", ModelType.GENERAL, 4096, "Modelo geral"))
        self.register_model(ModelConfig("codellama:13b", ModelType.CODE, 4096, "Modelo de codigo"))
        self.register_model(ModelConfig("llava", ModelType.VISION, 2048, "Modelo de visao"))
        self.register_model(ModelConfig("nomic-embed-text", ModelType.EMBEDDING, 8192, "Embeddings"))

    def register_model(self, config: ModelConfig):
        self.models[config.name] = config

    def get_model_for_task(self, task_type: ModelType) -> Optional[str]:
        for name, config in self.models.items():
            if config.model_type == task_type:
                return name
        return None

    def auto_select_model(self, prompt: str) -> str:
        code_keywords = ["code", "function", "class", "python", "javascript", "bug"]
        vision_keywords = ["image", "photo", "picture", "see", "look"]
        prompt_lower = prompt.lower()

        if any(kw in prompt_lower for kw in code_keywords):
            return self.get_model_for_task(ModelType.CODE) or "llama3.2"
        elif any(kw in prompt_lower for kw in vision_keywords):
            return self.get_model_for_task(ModelType.VISION) or "llama3.2"
        return self.get_model_for_task(ModelType.GENERAL) or "llama3.2"

manager = MultiModelManager()
resultado = manager.generate("Escreva uma funcao Python para fibonacci")
print(resultado["response"])
```

### 7. GPU Acceleration - Aceleracao por GPU

Configure e otimize Ollama para usar sua GPU para inferencia mais rapida.

```bash
# Verificar GPUs disponiveis
nvidia-smi

# Ollama detecta GPUs automaticamente
ollama serve

# Force CUDA no Linux
CUDA_VISIBLE_DEVICES=0 ollama serve

# Verificar se GPU esta sendo usada
curl http://localhost:11434/api/ps

# Configurar para ROCm (AMD)
HSA_OVERRIDE_GFX_VERSION=10.3.0 ollama serve
```

```python
import requests

def check_gpu_status():
    response = requests.get("http://localhost:11434/api/ps")
    data = response.json()

    if "models" in data:
        for model in data["models"]:
            print(f"Modelo: {model['name']}")
            print(f"VRAM: {model.get('size_vram', 'N/A')}")
            print(f"GPU: {model.get('details', {}).get('gpu', 'N/A')}")
    else:
        print("Nenhum modelo carregado na GPU")

    return data

status = check_gpu_status()
```

### 8. Docker Deployment - Deploy com Docker

Execute Ollama em containers Docker para ambientes isolados e portaveis.

```yaml
# docker-compose.yml
version: '3.8'

services:
  ollama:
    image: ollama/ollama:latest
    container_name: ollama
    ports:
      - "11434:11434"
    volumes:
      - ollama_data:/root/.ollama
    deploy:
      resources:
        reservations:
          devices:
            - driver: nvidia
              count: all
              capabilities: [gpu]
    restart: unless-stopped

  open-webui:
    image: ghcr.io/open-webui/open-webui:main
    container_name: open-webui
    ports:
      - "3000:8080"
    environment:
      - OLLAMA_BASE_URL=http://ollama:11434
    depends_on:
      - ollama
    restart: unless-stopped

volumes:
  ollama_data:
```

```bash
# Iniciar os containers
docker-compose up -d

# Puxar modelo dentro do container
docker exec -it ollama ollama pull llama3.2

# Verificar status
docker-compose ps
```

### 9. Streaming Responses - Respostas em Streaming

Implemente streaming de respostas para melhor experiencia do usuario.

```python
import requests
import json

class OllamaStreamer:
    def __init__(self, base_url="http://localhost:11434"):
        self.base_url = base_url

    def stream_generate(self, model, prompt, callback=None):
        payload = {"model": model, "prompt": prompt, "stream": True}
        response = requests.post(
            f"{self.base_url}/api/generate",
            json=payload,
            stream=True
        )

        full_response = ""
        for line in response.iter_lines():
            if line:
                chunk = json.loads(line)
                token = chunk.get("response", "")
                full_response += token

                if callback:
                    callback(token, chunk)

                if chunk.get("done", False):
                    break

        return full_response

    def stream_chat(self, model, messages, callback=None):
        payload = {"model": model, "messages": messages, "stream": True}
        response = requests.post(
            f"{self.base_url}/api/chat",
            json=payload,
            stream=True
        )

        full_response = ""
        for line in response.iter_lines():
            if line:
                chunk = json.loads(line)
                token = chunk.get("message", {}).get("content", "")
                full_response += token

                if callback:
                    callback(token, chunk)

                if chunk.get("done", False):
                    break

        return full_response

streamer = OllamaStreamer()

def print_token(token, chunk):
    print(token, end="", flush=True)

print("Resposta: ")
streamer.stream_generate("llama3.2", "Explique quantum computing", callback=print_token)
print()
```

### 10. Context Window Management - Gerenciamento de Janela de Contexto

Gerencie o tamanho do contexto para otimizar performance e uso de memoria.

```python
import requests

class ContextManager:
    def __init__(self, model="llama3.2", max_context=4096):
        self.model = model
        self.max_context = max_context
        self.base_url = "http://localhost:11434"
        self.conversation_history = []

    def estimate_tokens(self, text):
        return len(text) // 4

    def fit_to_context(self, messages, system_prompt=""):
        total_tokens = self.estimate_tokens(system_prompt)
        fitted_messages = []
        for msg in reversed(messages):
            msg_tokens = self.estimate_tokens(msg["content"])
            if total_tokens + msg_tokens < self.max_context * 0.8:
                fitted_messages.insert(0, msg)
                total_tokens += msg_tokens
            else:
                break
        return fitted_messages

    def chat(self, user_message, system_prompt=""):
        self.conversation_history.append({"role": "user", "content": user_message})
        fitted_messages = self.fit_to_context(self.conversation_history, system_prompt)

        messages = []
        if system_prompt:
            messages.append({"role": "system", "content": system_prompt})
        messages.extend(fitted_messages)

        response = requests.post(
            f"{self.base_url}/api/chat",
            json={"model": self.model, "messages": messages, "stream": False}
        )

        assistant_message = response.json()["message"]["content"]
        self.conversation_history.append({"role": "assistant", "content": assistant_message})
        return assistant_message

ctx = ContextManager(model="llama3.2", max_context=4096)
resposta = ctx.chat("O que e machine learning?", "Voce e um professor de IA.")
print(resposta)
```

### 11. Vision Models - Modelos de Visao (LLaVA)

Use modelos de visao para analise de imagens e perguntas sobre imagens.

```python
import base64
import requests

class VisionModel:
    def __init__(self, model="llava"):
        self.model = model
        self.base_url = "http://localhost:11434"

    def analyze_image(self, image_path, prompt="Descreva esta imagem"):
        with open(image_path, "rb") as f:
            image_data = base64.b64encode(f.read()).decode("utf-8")

        payload = {
            "model": self.model,
            "prompt": prompt,
            "images": [image_data],
            "stream": False
        }

        response = requests.post(f"{self.base_url}/api/generate", json=payload)
        return response.json()["response"]

    def compare_images(self, image_path1, image_path2, prompt):
        with open(image_path1, "rb") as f:
            img1 = base64.b64encode(f.read()).decode("utf-8")
        with open(image_path2, "rb") as f:
            img2 = base64.b64encode(f.read()).decode("utf-8")

        payload = {
            "model": self.model,
            "prompt": prompt,
            "images": [img1, img2],
            "stream": False
        }

        response = requests.post(f"{self.base_url}/api/generate", json=payload)
        return response.json()["response"]

vision = VisionModel(model="llava:13b")
descricao = vision.analyze_image("foto.jpg", "O que esta acontecendo nesta imagem?")
print(descricao)
```

### 12. Code Models - Modelos de Codigo

Use modelos especializados em geracao e analise de codigo.

```python
import requests

class CodeAssistant:
    def __init__(self, model="codellama:13b"):
        self.model = model
        self.base_url = "http://localhost:11434"

    def generate_code(self, description, language="python"):
        prompt = f"Escreva {language} para: {description}\nCodigo:"
        payload = {"model": self.model, "prompt": prompt, "stream": False, "temperature": 0.2}
        response = requests.post(f"{self.base_url}/api/generate", json=payload)
        return response.json()["response"]

    def explain_code(self, code):
        prompt = f"Explique este codigo linha por linha:\n\n{code}\n\nExplicacao:"
        payload = {"model": self.model, "prompt": prompt, "stream": False}
        response = requests.post(f"{self.base_url}/api/generate", json=payload)
        return response.json()["response"]

    def review_code(self, code):
        prompt = f"Revise este codigo e sugira melhorias:\n\n{code}\n\nRevisao:"
        payload = {"model": self.model, "prompt": prompt, "stream": False}
        response = requests.post(f"{self.base_url}/api/generate", json=payload)
        return response.json()["response"]

assistant = CodeAssistant()
codigo = assistant.generate_code("funcao para calcular fibonacci")
print(codigo)
```

### 13. Embedding Models - Modelos de Embedding

Gere embeddings para busca semantica e analise de texto.

```python
import numpy as np
import requests

class EmbeddingEngine:
    def __init__(self, model="nomic-embed-text"):
        self.model = model
        self.base_url = "http://localhost:11434"
        self.documents = []
        self.embeddings = []

    def get_embedding(self, text):
        payload = {"model": self.model, "prompt": text}
        response = requests.post(f"{self.base_url}/api/embeddings", json=payload)
        return response.json()["embedding"]

    def add_document(self, text, metadata=None):
        embedding = self.get_embedding(text)
        self.documents.append({"text": text, "metadata": metadata or {}})
        self.embeddings.append(embedding)

    def search(self, query, top_k=5):
        query_embedding = self.get_embedding(query)
        similarities = []
        for i, doc_embedding in enumerate(self.embeddings):
            similarity = self.cosine_similarity(query_embedding, doc_embedding)
            similarities.append((i, similarity))
        similarities.sort(key=lambda x: x[1], reverse=True)
        results = []
        for idx, score in similarities[:top_k]:
            results.append({
                "text": self.documents[idx]["text"],
                "metadata": self.documents[idx]["metadata"],
                "score": score
            })
        return results

    def cosine_similarity(self, a, b):
        a = np.array(a)
        b = np.array(b)
        return np.dot(a, b) / (np.linalg.norm(a) * np.linalg.norm(b))

engine = EmbeddingEngine()
engine.add_document("Python e uma linguagem de programacao")
engine.add_document("JavaScript e usada para web")
engine.add_document("Machine learning usa modelos")

results = engine.search("linguagem para machine learning")
for r in results:
    print(f"Score: {r['score']:.4f} - {r['text']}")
```

### 14. Model Quantization - Quantizacao de Modelos

Entenda e use quantizacao para rodar modelos maiores com menos memoria.

```bash
# Modelos quantizados disponiveis no Ollama
ollama pull llama3.2:8b-q4_0
ollama pull llama3.2:8b-q5_0
ollama pull llama3.2:8b-q8_0

# Comparar tamanhos
ollama list
```

```python
class QuantizationInfo:
    QUANT_MAP = {
        "q4_0": {"bits": 4, "quality": 0.85, "size_factor": 0.5},
        "q4_k_m": {"bits": 4, "quality": 0.88, "size_factor": 0.53},
        "q5_0": {"bits": 5, "quality": 0.92, "size_factor": 0.625},
        "q5_k_m": {"bits": 5, "quality": 0.94, "size_factor": 0.65},
        "q8_0": {"bits": 8, "quality": 0.99, "size_factor": 1.0},
        "f16": {"bits": 16, "quality": 1.0, "size_factor": 2.0},
    }

    @staticmethod
    def estimate_size(base_size_gb, quantization):
        info = QuantizationInfo.QUANT_MAP.get(quantization, {})
        return base_size_gb * info.get("size_factor", 1.0)

    @staticmethod
    def recommend_quantization(available_ram_gb, model_size_gb):
        if available_ram_gb >= model_size_gb * 2:
            return "q8_0"
        elif available_ram_gb >= model_size_gb * 1.2:
            return "q5_k_m"
        elif available_ram_gb >= model_size_gb * 0.7:
            return "q4_k_m"
        else:
            return "q4_0"

rec = QuantizationInfo.recommend_quantization(8, 13)
print(f"Recomendacao para 8GB RAM e modelo 13B: {rec}")

tamanho = QuantizationInfo.estimate_size(13, "q4_k_m")
print(f"Tamanho estimado Q4_K_M: {tamanho:.2f} GB")
```

### 15. Model Fine-tuning via Modelfile - Ajuste Fino

Ajuste o comportamento do modelo usando system prompts e parametros no Modelfile.

```dockerfile
# Modelfile para Fine-tuning comportamental
FROM llama3.2

# Template de conversa customizado
TEMPLATE "[INST] <<SYS>> {{ .System }} <</SYS>> {{ .Prompt }} [/INST]"

# Stop tokens
PARAMETER stop "[INST]"
PARAMETER stop "<<SYS>>"
PARAMETER stop "<</SYS>>"

# Parametros ajustados
PARAMETER temperature 0.6
PARAMETER top_p 0.9
PARAMETER repeat_penalty 1.1
PARAMETER num_ctx 8192

# System prompt padrao
SYSTEM Voce e um assistente especializado em React e Next.js.
```

```bash
# Criar modelo com fine-tuning
ollama create react-assistant -f Modelfile

# Testar
ollama run react-assistant "Crie um componente de botao em React"
```

### 16. Integration with Popular Tools - Integracao com Ferramentas Populares

Integre Ollama com as principais ferramentas do ecossistema de IA.

```python
# Integracao com LangChain
from langchain_community.llms import Ollama
from langchain_community.embeddings import OllamaEmbeddings
from langchain_community.vectorstores import Chroma
from langchain_community.document_loaders import TextLoader
from langchain.text_splitter import CharacterTextSplitter
from langchain.chains import RetrievalQA

llm = Ollama(model="llama3.2")
embeddings = OllamaEmbeddings(model="nomic-embed-text")

loader = TextLoader("documento.txt")
documents = loader.load()
text_splitter = CharacterTextSplitter(chunk_size=1000, chunk_overlap=0)
docs = text_splitter.split_documents(documents)

vectorstore = Chroma.from_documents(docs, embeddings)

qa_chain = RetrievalQA.from_chain_type(
    llm=llm,
    chain_type="stuff",
    retriever=vectorstore.as_retriever()
)

response = qa_chain.invoke({"query": "Qual e o tema principal do documento?"})
print(response["result"])
```

```python
# Integracao com OpenAI-compatible API
import openai

client = openai.OpenAI(
    base_url="http://localhost:11434/v1",
    api_key="ollama"
)

response = client.chat.completions.create(
    model="llama3.2",
    messages=[
        {"role": "system", "content": "Voce e um assistente util."},
        {"role": "user", "content": "O que e Python?"}
    ]
)

print(response.choices[0].message.content)
```

### 17. Integration with LlamaIndex - Integracao com LlamaIndex

Use Ollama com LlamaIndex para RAG (Retrieval-Augmented Generation).

```python
from llama_index.llms.ollama import Ollama
from llama_index.embeddings.ollama import OllamaEmbedding
from llama_index.core import VectorStoreIndex, SimpleDirectoryReader, Settings

Settings.llm = Ollama(model="llama3.2")
Settings.embed_model = OllamaEmbedding(model_name="nomic-embed-text")

documents = SimpleDirectoryReader("./data").load_data()
index = VectorStoreIndex.from_documents(documents)
query_engine = index.as_query_engine()

response = query_engine.query("Resuma os principais pontos deste documento")
print(response)
```

### 18. Error Handling e Debug - Tratamento de Erros

Implemente tratamento robusto de erros e debugging.

```python
import requests
import logging
from typing import Optional, Dict, Any

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger("OllamaClient")

class OllamaErrorHandler:
    def __init__(self, base_url="http://localhost:11434"):
        self.base_url = base_url

    def check_server_status(self) -> Dict[str, Any]:
        try:
            response = requests.get(f"{self.base_url}/", timeout=5)
            return {"status": "online", "status_code": response.status_code}
        except requests.ConnectionError:
            return {"status": "offline", "error": "Servidor nao esta rodando"}
        except requests.Timeout:
            return {"status": "timeout", "error": "Servidor nao respondeu"}

    def safe_generate(self, model: str, prompt: str, **kwargs) -> Optional[Dict]:
        try:
            payload = {"model": model, "prompt": prompt, "stream": False, **kwargs}
            response = requests.post(f"{self.base_url}/api/generate", json=payload, timeout=30)
            response.raise_for_status()
            return response.json()
        except requests.ConnectionError:
            logger.error("Erro de conexao. Verifique se o Ollama esta rodando.")
            return None
        except requests.Timeout:
            logger.error("Timeout na requisicao.")
            return None
        except requests.HTTPError as e:
            logger.error(f"Erro HTTP: {e.response.status_code}")
            return None
        except Exception as e:
            logger.error(f"Erro inesperado: {str(e)}")
            return None

handler = OllamaErrorHandler()
status = handler.check_server_status()
print(f"Status do servidor: {status}")
```

### 19. Performance Optimization - Otimizacao de Performance

Otimize o desempenho do Ollama para producao.

```python
import requests
import time
from concurrent.futures import ThreadPoolExecutor
from typing import List, Dict

class OllamaOptimizer:
    def __init__(self, base_url="http://localhost:11434"):
        self.base_url = base_url

    def benchmark(self, model: str, prompt: str, iterations: int = 5) -> Dict:
        times = []
        tokens_per_second = []

        for i in range(iterations):
            start = time.time()
            response = requests.post(
                f"{self.base_url}/api/generate",
                json={"model": model, "prompt": prompt, "stream": False}
            )
            end = time.time()

            result = response.json()
            elapsed = end - start
            times.append(elapsed)

            eval_count = result.get("eval_count", 0)
            if elapsed > 0:
                tokens_per_second.append(eval_count / elapsed)

        return {
            "model": model,
            "iterations": iterations,
            "avg_time": sum(times) / len(times),
            "avg_tokens_per_second": sum(tokens_per_second) / len(tokens_per_second) if tokens_per_second else 0,
            "min_time": min(times),
            "max_time": max(times)
        }

    def batch_process(self, model: str, prompts: List[str], max_workers: int = 3) -> List[Dict]:
        results = []

        def process_prompt(prompt):
            response = requests.post(
                f"{self.base_url}/api/generate",
                json={"model": model, "prompt": prompt, "stream": False}
            )
            return response.json()

        with ThreadPoolExecutor(max_workers=max_workers) as executor:
            futures = [executor.submit(process_prompt, p) for p in prompts]
            for future in futures:
                results.append(future.result())

        return results

optimizer = OllamaOptimizer()
benchmark_result = optimizer.benchmark("llama3.2", "O que e machine learning?")
print(f"Benchmark: {benchmark_result}")
```

### 20. MELHORIA - Padroes Corretos de Uso

```python
# ERRADO: Nao tratar erros de conexao
response = requests.post("http://localhost:11434/api/generate", json=payload)
print(response.json()["response"])

# CORRETO: Sempre tratar erros
try:
    response = requests.post("http://localhost:11434/api/generate", json=payload, timeout=30)
    response.raise_for_status()
    result = response.json()
    print(result["response"])
except requests.ConnectionError:
    print("Erro: Ollama nao esta rodando. Execute 'ollama serve'")
except requests.Timeout:
    print("Erro: Requisicao expirou.")
except requests.HTTPError as e:
    print(f"Erro HTTP: {e.response.status_code}")
except Exception as e:
    print(f"Erro inesperado: {e}")

# ERRADO: Nao verificar se o modelo existe
result = client.generate("modelo_inexistente", "prompt")

# CORRETO: Verificar modelo antes de usar
def validate_model(model):
    try:
        response = requests.get("http://localhost:11434/api/tags", timeout=5)
        models = response.json().get("models", [])
        return model in [m["name"] for m in models]
    except Exception:
        return False

if validate_model("llama3.2"):
    result = client.generate("llama3.2", "prompt")
else:
    print("Modelo nao encontrado. Execute: ollama pull llama3.2")

# ERRADO: Nao limitar historico de conversa
conversation_history.append(new_message)

# CORRETO: Limitar tamanho do historico
MAX_HISTORY = 20
conversation_history.append(new_message)
if len(conversation_history) > MAX_HISTORY:
    conversation_history = conversation_history[-MAX_HISTORY:]
```

---

## 📈 Metricas e Performance

| Metrica | Valor | Descricao |
|---------|-------|-----------|
| Tempo de Resposta | 1-5s | Dependendo do modelo e GPU |
| Uso de RAM | 4-32GB | Dependendo do modelo |
| VRAM Necessaria | 4-24GB | Para modelos quantizados |
| Throughput | 10-50 tokens/s | Com GPU dedicada |

---

## 🔗 Recursos Adicionais

- **Documentacao Oficial:** https://github.com/ollama/ollama/blob/main/docs
- **Biblioteca de Modelos:** https://ollama.com/library
- **GitHub:** https://github.com/ollama/ollama
- **Discord:** https://discord.gg/ollama

---

**Ultima atualizacao:** Janeiro 2026
**Autor:** Advanced Skills Library
**Licenca:** MIT
