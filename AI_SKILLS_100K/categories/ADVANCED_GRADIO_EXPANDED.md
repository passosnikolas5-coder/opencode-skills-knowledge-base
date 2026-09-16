# 🤖 GRADIO - Skills Avançadas

## 📋 Informações da Skill
- **Fonte:** https://github.com/gradio-app/gradio (40k+ stars)
- **Descrição:** Framework para criar aplicativos web de Machine Learning com interface interativa
- **Categoria:** AI/ML Web Development
- **Versão:** 5.x
- **Última atualização:** 2025

---

## 🎯 Visão Geral

Gradio permite criar interfaces web para modelos de ML de forma rápida e simples. Suporta desde APIs simples até interfaces complexas com Blocks, permitindo upload de arquivos, processamento em tempo real, e geração automática de APIs REST.

---

## 📚 Habilidades Principais

### 1. Blocks API - Layouts Customizados

A API Blocks permite criar interfaces complexas com layout personalizado usando componentes empilhados e em grade.

```python
import gradio as gr

with gr.Blocks(title="App Avançado") as demo:
    gr.Markdown("## Sistema de Análise de Imagens")
    
    with gr.Row():
        with gr.Column(scale=1):
            input_image = gr.Image(label="Imagem de Entrada", type="filepath")
            modelo = gr.Dropdown(
                choices=["ResNet50", "VGG16", "MobileNet"],
                label="Modelo",
                value="ResNet50"
            )
            btn_processar = gr.Button("Processar", variant="primary")
        
        with gr.Column(scale=1):
            output_image = gr.Image(label="Resultado")
            label_resultado = gr.Label(label="Classificação")
    
    historico = gr.Dataframe(
        headers=["Data", "Modelo", "Confiança"],
        label="Histórico"
    )

def processar_imagem(imagem, modelo):
    # Processamento aqui
    return imagem, {"gato": 0.95, "cachorro": 0.05}

btn_processar.click(
    fn=processar_imagem,
    inputs=[input_image, modelo],
    outputs=[output_image, label_resultado]
)

demo.launch()
```

### 2. Interface Simples - Criando Rapidamente

A API Interface é ideal para prototipagem rápida com poucos componentes.

```python
import gradio as gr
import numpy as np
from PIL import Image

def classificar_imagem(imagem):
    if imagem is None:
        return "Nenhuma imagem fornecida"
    
    # Simular classificação
    resultado = np.random.choice(["Gato", "Cachorro", "Pássaro"])
    confianca = np.random.uniform(0.7, 0.99)
    
    return {resultado: confianca}

def processar_texto(texto, idioma):
    if idioma == "Português":
        return texto.upper()
    elif idioma == "Inglês":
        return texto.lower()
    return texto

# Interface de imagem
iface_imagem = gr.Interface(
    fn=classificar_imagem,
    inputs=gr.Image(label="Imagem", type="pil"),
    outputs=gr.Label(label="Classificação"),
    title="Classificador de Imagens",
    description="Envie uma imagem para classificar"
)

# Interface de texto
iface_texto = gr.Interface(
    fn=processar_texto,
    inputs=[
        gr.Textbox(label="Texto", placeholder="Digite algo..."),
        gr.Radio(["Português", "Inglês"], label="Idioma")
    ],
    outputs=gr.Textbox(label="Resultado"),
    title="Processador de Texto"
)

# Combinar interfaces
demo = gr.TabbedInterface(
    [iface_imagem, iface_texto],
    ["Classificar Imagem", "Processar Texto"]
)

demo.launch()
```

### 3. Chatbot Interface - Conversas com IA

Implemente chatbots com memória de contexto e diferentes modelos.

```python
import gradio as gr
from transformers import pipeline

class ChatbotGradio:
    def __init__(self):
        self.historico = []
        self.gerador = pipeline(
            "text-generation", 
            model="gpt2",
            device=0 if gr.utils.is_colab() else -1
        )
    
    def responder(self, mensagem, historico_chat):
        # Construir contexto do histórico
        contexto = "\n".join([f"Usuário: {m}\nBot: {r}" for m, r in historico_chat])
        prompt = f"{contexto}\nUsuário: {mensagem}\nBot:"
        
        # Gerar resposta
        resposta = self.gerador(
            prompt,
            max_length=150,
            num_return_sequences=1,
            temperature=0.7,
            pad_token_id=50256
        )[0]["generated_text"]
        
        # Extrair apenas a resposta do bot
        resposta_final = resposta.split("Bot:")[-1].strip()
        
        historico_chat.append((mensagem, resposta_final))
        return "", historico_chat

chatbot = ChatbotGradio()

with gr.Blocks(title="Chatbot IA") as demo:
    gr.Markdown("## 💬 Chatbot com IA")
    
    chatbot_ui = gr.Chatbot(label="Conversa", height=400)
    msg = gr.Textbox(
        label="Mensagem",
        placeholder="Digite sua mensagem aqui...",
        submit_btn=True
    )
    
    with gr.Row():
        btn_limpar = gr.Button("🗑️ Limpar Conversa")
        btn_exportar = gr.Button("📥 Exportar Chat")
    
    def limpar_conversa():
        return [], ""
    
    msg.submit(
        fn=chatbot.responder,
        inputs=[msg, chatbot_ui],
        outputs=[msg, chatbot_ui]
    )
    
    btn_limpar.click(
        fn=limpar_conversa,
        outputs=[chatbot_ui, msg]
    )

demo.launch()
```

### 4. State Management - Gerenciamento de Estado

Gerencie estado entre interações mantendo dados persistentes durante a sessão.

```python
import gradio as gr
from datetime import datetime

class AppState:
    def __init__(self):
        self.contador = 0
        self.historico_acoes = []
        self.usuario_atual = None
        self.pedidos = []
    
    def incrementar(self):
        self.contador += 1
        self.historico_acoes.append({
            "acao": "incrementar",
            "timestamp": datetime.now().isoformat(),
            "valor": self.contador
        })
        return self.contador
    
    def adicionar_pedido(self, produto, quantidade):
        pedido = {
            "id": len(self.pedidos) + 1,
            "produto": produto,
            "quantidade": quantidade,
            "status": "pendente",
            "data": datetime.now().isoformat()
        }
        self.pedidos.append(pedido)
        return pedido["id"]
    
    def listar_pedidos(self):
        return self.pedidos

def criar_app():
    estado = gr.State(value=AppState())
    
    with gr.Blocks(title="Sistema de Pedidos") as demo:
        gr.Markdown("## 🛒 Sistema de Gerenciamento de Pedidos")
        
        with gr.Row():
            with gr.Column():
                gr.Markdown("### Adicionar Pedido")
                produto = gr.Textbox(label="Produto")
                quantidade = gr.Number(label="Quantidade", value=1)
                btn_adicionar = gr.Button("Adicionar Pedido", variant="primary")
                id_pedido = gr.Number(label="ID do Pedido", interactive=False)
            
            with gr.Column():
                gr.Markdown("### Pedidos")
                lista_pedidos = gr.Dataframe(
                    headers=["ID", "Produto", "Quantidade", "Status", "Data"],
                    label="Lista de Pedidos"
                )
        
        gr.Markdown("### Estatísticas")
        with gr.Row():
            total_pedidos = gr.Number(label="Total de Pedidos", interactive=False)
            contador = gr.Number(label="Ações Realizadas", interactive=False)
        
        def adicionar_novo_pedido(produto, quantidade, estado_atual):
            id_pedido = estado_atual.adicionar_pedido(produto, quantidade)
            return (
                estado_atual.listar_pedidos(),
                id_pedido,
                len(estado_atual.pedidos),
                estado_atual.contador
            )
        
        btn_adicionar.click(
            fn=adicionar_novo_pedido,
            inputs=[produto, quantidade, estado],
            outputs=[lista_pedidos, id_pedido, total_pedidos, contador]
        )
    
    return demo

if __name__ == "__main__":
    demo = criar_app()
    demo.launch()
```

### 5. File Upload/Download - Upload e Download de Arquivos

Gerencie upload e download de arquivos com validação e processamento.

```python
import gradio as gr
import os
from pathlib import Path
import hashlib

class FileManager:
    def __init__(self, upload_dir="./uploads"):
        self.upload_dir = Path(upload_dir)
        self.upload_dir.mkdir(exist_ok=True)
        self.max_size = 100 * 1024 * 1024  # 100MB
        self.allowed_types = {
            "imagens": [".jpg", ".jpeg", ".png", ".gif", ".bmp"],
            "documentos": [".pdf", ".doc", ".docx", ".txt", ".csv"],
            "dados": [".json", ".xml", ".yaml", ".yml"],
            "codigo": [".py", ".js", ".ts", ".html", ".css"]
        }
    
    def validate_file(self, file_path):
        if not file_path:
            return False, "Nenhum arquivo selecionado"
        
        file_size = os.path.getsize(file_path)
        if file_size > self.max_size:
            return False, f"Arquivo muito grande. Máximo: {self.max_size // (1024*1024)}MB"
        
        ext = Path(file_path).suffix.lower()
        allowed = False
        for category, extensions in self.allowed_types.items():
            if ext in extensions:
                allowed = True
                break
        
        if not allowed:
            return False, f"Tipo de arquivo não permitido: {ext}"
        
        return True, "Arquivo válido"
    
    def processar_arquivo(self, file_path):
        valid, message = self.validate_file(file_path)
        if not valid:
            return None, message
        
        # Calcular hash
        with open(file_path, "rb") as f:
            file_hash = hashlib.md5(f.read()).hexdigest()
        
        # Mover para diretório de upload
        filename = Path(file_path).name
        dest = self.upload_dir / filename
        os.rename(file_path, dest)
        
        info = {
            "nome": filename,
            "tamanho": os.path.getsize(dest),
            "hash": file_hash,
            "tipo": Path(filename).suffix,
            "caminho": str(dest)
        }
        
        return info, "Arquivo processado com sucesso"
    
    def gerar_estatisticas(self):
        stats = {
            "total_arquivos": 0,
            "tamanho_total": 0,
            "por_tipo": {}
        }
        
        for file in self.upload_dir.rglob("*"):
            if file.is_file():
                stats["total_arquivos"] += 1
                stats["tamanho_total"] += file.stat().st_size
                
                ext = file.suffix.lower()
                stats["por_tipo"][ext] = stats["por_tipo"].get(ext, 0) + 1
        
        return stats

def criar_app():
    manager = FileManager()
    
    with gr.Blocks(title="Gerenciador de Arquivos") as demo:
        gr.Markdown("## 📁 Gerenciador de Arquivos Inteligente")
        
        with gr.Tabs():
            with gr.TabItem("📤 Upload"):
                with gr.Row():
                    arquivo = gr.File(
                        label="Selecionar Arquivo",
                        file_types=["*"],
                        type="filepath"
                    )
                    btn_upload = gr.Button("Processar", variant="primary")
                
                resultado_upload = gr.JSON(label="Informações do Arquivo")
                status_upload = gr.Textbox(label="Status", interactive=False)
            
            with gr.TabItem("📊 Estatísticas"):
                btn_stats = gr.Button("Atualizar Estatísticas")
                stats_output = gr.JSON(label="Estatísticas")
            
            with gr.TabItem("📋 Metadados"):
                gr.Markdown("### Tipos de Arquivo Permitidos")
                gr.JSON(value=manager.allowed_types)
        
        def processar(file_path):
            info, message = manager.processar_arquivo(file_path)
            return info, message
        
        btn_upload.click(
            fn=processar,
            inputs=[arquivo],
            outputs=[resultado_upload, status_upload]
        )
        
        btn_stats.click(
            fn=manager.gerar_estatisticas,
            outputs=[stats_output]
        )
    
    return demo

if __name__ == "__main__":
    demo = criar_app()
    demo.launch()
```

### 6. API Generation - Geração Automática de REST API

Gere APIs REST automáticas para seus modelos com documentação OpenAPI.

```python
import gradio as gr
import numpy as np
from pydantic import BaseModel
from typing import List, Optional

class PredictionRequest(BaseModel):
    features: List[float]
    model_name: str = "default"

class PredictionResponse(BaseModel):
    prediction: float
    confidence: float
    model_used: str

class MLModelAPI:
    def __init__(self):
        self.models = {}
        self.load_models()
    
    def load_models(self):
        # Simular carregamento de modelos
        self.models["linear"] = lambda x: sum(x) / len(x) if x else 0
        self.models["decision_tree"] = lambda x: max(x) if x else 0
        self.models["neural_net"] = lambda x: np.mean(x) if x else 0
    
    def predict(self, features: List[float], model_name: str = "linear"):
        if model_name not in self.models:
            raise ValueError(f"Modelo não encontrado: {model_name}")
        
        model = self.models[model_name]
        prediction = model(features)
        confidence = np.random.uniform(0.8, 0.99)
        
        return {
            "prediction": prediction,
            "confidence": confidence,
            "model_used": model_name
        }
    
    def batch_predict(self, batch_features: List[List[float]], model_name: str):
        results = []
        for features in batch_features:
            result = self.predict(features, model_name)
            results.append(result)
        return results

api = MLModelAPI()

def criar_api():
    with gr.Blocks(title="ML API Generator") as demo:
        gr.Markdown("## 🔌 API de Machine Learning")
        gr.Markdown("Esta API gera endpoints REST automáticos para modelos de ML")
        
        with gr.Tabs():
            with gr.TabItem("📊 Predição Simples"):
                with gr.Row():
                    features_input = gr.Textbox(
                        label="Features (JSON Array)",
                        placeholder="[1.0, 2.0, 3.0, 4.0]",
                        lines=3
                    )
                    model_select = gr.Dropdown(
                        choices=["linear", "decision_tree", "neural_net"],
                        label="Modelo",
                        value="linear"
                    )
                
                btn_predict = gr.Button("Predizer", variant="primary")
                resultado = gr.JSON(label="Resultado")
                
                def fazer_predicao(features_str, model_name):
                    try:
                        features = eval(features_str)
                        return api.predict(features, model_name)
                    except Exception as e:
                        return {"error": str(e)}
                
                btn_predict.click(
                    fn=fazer_predicao,
                    inputs=[features_input, model_select],
                    outputs=[resultado]
                )
            
            with gr.TabItem("📦 Batch Prediction"):
                batch_input = gr.Textbox(
                    label="Batch de Features (JSON Array of Arrays)",
                    placeholder="[[1.0, 2.0], [3.0, 4.0], [5.0, 6.0]]",
                    lines=5
                )
                batch_model = gr.Dropdown(
                    choices=["linear", "decision_tree", "neural_net"],
                    label="Modelo",
                    value="linear"
                )
                btn_batch = gr.Button("Processar Batch", variant="primary")
                batch_result = gr.JSON(label="Resultados")
                
                def fazer_batch(batch_str, model_name):
                    try:
                        batch = eval(batch_str)
                        return api.batch_predict(batch, model_name)
                    except Exception as e:
                        return {"error": str(e)}
                
                btn_batch.click(
                    fn=fazer_batch,
                    inputs=[batch_input, batch_model],
                    outputs=[batch_result]
                )
            
            with gr.TabItem("📖 Documentação API"):
                gr.Markdown("""
                ## Endpoints Disponíveis
                
                ### POST /predict
                ```json
                {
                    "features": [1.0, 2.0, 3.0],
                    "model_name": "linear"
                }
                ```
                
                ### POST /batch_predict
                ```json
                {
                    "batch_features": [[1.0, 2.0], [3.0, 4.0]],
                    "model_name": "linear"
                }
                ```
                
                ### GET /models
                Lista todos os modelos disponíveis
                
                ### GET /health
                Verifica status da API
                """)
    
    return demo

if __name__ == "__main__":
    demo = criar_api()
    demo.launch()
```

### 7. Queue System - Sistema de Filas para Tarefas Longas

Implemente um sistema de filas para processar tarefas de longa duração sem bloquear a interface.

```python
import gradio as gr
import time
import threading
from queue import Queue
from dataclasses import dataclass
from typing import Any, Callable
from datetime import datetime

@dataclass
class Task:
    id: int
    func: Callable
    args: tuple
    kwargs: dict
    status: str = "pending"
    result: Any = None
    error: str = None
    created_at: datetime = None
    started_at: datetime = None
    completed_at: datetime = None

class TaskQueue:
    def __init__(self, max_workers=3):
        self.queue = Queue()
        self.tasks = {}
        self.max_workers = max_workers
        self.workers = []
        self.task_counter = 0
        self.running = False
    
    def start(self):
        self.running = True
        for i in range(self.max_workers):
            worker = threading.Thread(target=self._worker, daemon=True)
            worker.start()
            self.workers.append(worker)
    
    def stop(self):
        self.running = False
    
    def _worker(self):
        while self.running:
            try:
                task = self.queue.get(timeout=1)
                self._process_task(task)
                self.queue.task_done()
            except:
                continue
    
    def _process_task(self, task):
        task.status = "running"
        task.started_at = datetime.now()
        
        try:
            task.result = task.func(*task.args, **task.kwargs)
            task.status = "completed"
        except Exception as e:
            task.error = str(e)
            task.status = "failed"
        finally:
            task.completed_at = datetime.now()
    
    def add_task(self, func, *args, **kwargs):
        self.task_counter += 1
        task = Task(
            id=self.task_counter,
            func=func,
            args=args,
            kwargs=kwargs,
            created_at=datetime.now()
        )
        self.tasks[task.id] = task
        self.queue.put(task)
        return task.id
    
    def get_task_status(self, task_id):
        return self.tasks.get(task_id)
    
    def get_all_tasks(self):
        return list(self.tasks.values())

# Funções de processamento pesado
def processar_dados_grandes(dados):
    """Simula processamento de dados grandes"""
    time.sleep(3)  # Simular processamento
    return {"status": "concluido", "registros": len(dados)}

def treinar_modelo(epochs):
    """Simula treinamento de modelo"""
    for i in range(epochs):
        time.sleep(0.5)
    return {"acuracia": 0.95, "loss": 0.05}

def gerar_relatorio(tipo):
    """Simula geração de relatório"""
    time.sleep(2)
    return {"arquivo": f"relatorio_{tipo}.pdf", "tamanho": "2.5MB"}

# Criar instância da fila
task_queue = TaskQueue(max_workers=2)
task_queue.start()

def criar_app():
    with gr.Blocks(title="Sistema de Filas") as demo:
        gr.Markdown("## ⚙️ Sistema de Filas de Tarefas")
        
        with gr.Tabs():
            with gr.TabItem("📤 Nova Tarefa"):
                tipo_tarefa = gr.Dropdown(
                    choices=["Processar Dados", "Treinar Modelo", "Gerar Relatório"],
                    label="Tipo de Tarefa",
                    value="Processar Dados"
                )
                
                with gr.Row():
                    dados_input = gr.Textbox(
                        label="Dados/Parâmetros",
                        placeholder="JSON ou parâmetros",
                        lines=3
                    )
                    prioridade = gr.Slider(
                        minimum=1, maximum=5, value=3,
                        label="Prioridade (1-5)"
                    )
                
                btn_enviar = gr.Button("Enviar Tarefa", variant="primary")
                status_output = gr.Textbox(label="Status", interactive=False)
            
            with gr.TabItem("📊 Monitor"):
                btn_atualizar = gr.Button("🔄 Atualizar Status")
                lista_tarefas = gr.Dataframe(
                    headers=["ID", "Tipo", "Status", "Criado", "Concluído"],
                    label="Tarefas"
                )
                
                metricas = gr.Row()
                with metricas:
                    total_tarefas = gr.Number(label="Total", interactive=False)
                    tarefas_pendentes = gr.Number(label="Pendentes", interactive=False)
                    tarefas_concluidas = gr.Number(label="Concluídas", interactive=False)
            
            with gr.TabItem("📈 Métricas"):
                grafico_performance = gr.Plot(label="Performance")
        
        def enviar_tarefa(tipo, dados, prioridade):
            try:
                if tipo == "Processar Dados":
                    dados_list = eval(dados) if dados else [1, 2, 3]
                    task_id = task_queue.add_task(processar_dados_grandes, dados_list)
                elif tipo == "Treinar Modelo":
                    epochs = int(dados) if dados else 10
                    task_id = task_queue.add_task(treinar_modelo, epochs)
                elif tipo == "Gerar Relatório":
                    task_id = task_queue.add_task(gerar_relatorio, dados or "mensal")
                
                return f"Tarefa #{task_id} enviada com sucesso!"
            except Exception as e:
                return f"Erro ao enviar tarefa: {str(e)}"
        
        def atualizar_status():
            tasks = task_queue.get_all_tasks()
            
            dados = []
            for task in tasks[-10:]:  # Últimas 10 tarefas
                dados.append([
                    task.id,
                    task.func.__name__,
                    task.status,
                    task.created_at.strftime("%H:%M:%S") if task.created_at else "-",
                    task.completed_at.strftime("%H:%M:%S") if task.completed_at else "-"
                ])
            
            total = len(tasks)
            pendentes = sum(1 for t in tasks if t.status in ["pending", "running"])
            concluidas = sum(1 for t in tasks if t.status == "completed")
            
            return dados, total, pendentes, concluidas
        
        btn_enviar.click(
            fn=enviar_tarefa,
            inputs=[tipo_tarefa, dados_input, prioridade],
            outputs=[status_output]
        )
        
        btn_atualizar.click(
            fn=atualizar_status,
            outputs=[lista_tarefas, total_tarefas, tarefas_pendentes, tarefas_concluidas]
        )
    
    return demo

if __name__ == "__main__":
    demo = criar_app()
    demo.launch()
```

### 8. Custom Themes - Temas Personalizados

Crie e aplique temas personalizados para customizar a aparência da interface.

```python
import gradio as gr

class CustomTheme:
    def __init__(self):
        self.colors = {
            "primary": "#6366f1",
            "secondary": "#8b5cf6",
            "accent": "#a855f7",
            "background": "#0f172a",
            "surface": "#1e293b",
            "text": "#f8fafc",
            "text_secondary": "#94a3b8",
            "border": "#334155",
            "success": "#22c55e",
            "warning": "#eab308",
            "error": "#ef4444"
        }
    
    def create_theme(self):
        return gr.themes.Base(
            primary_hue="indigo",
            secondary_hue="violet",
            neutral_hue="slate",
            font=gr.themes.GoogleFont("Inter"),
            font_mono=gr.themes.GoogleFont("JetBrains Mono")
        ).set(
            body_background_fill=self.colors["background"],
            body_background_fill_dark=self.colors["background"],
            block_background_fill=self.colors["surface"],
            block_background_fill_dark=self.colors["surface"],
            block_border_color=self.colors["border"],
            block_border_color_dark=self.colors["border"],
            block_label_text_color=self.colors["text_secondary"],
            block_label_text_color_dark=self.colors["text_secondary"],
            block_title_text_color=self.colors["text"],
            block_title_text_color_dark=self.colors["text"],
            input_background_fill=self.colors["background"],
            input_background_fill_dark=self.colors["background"],
            input_border_color=self.colors["border"],
            input_border_color_dark=self.colors["border"],
            button_primary_background_fill=self.colors["primary"],
            button_primary_background_fill_dark=self.colors["primary"],
            button_primary_text_color=self.colors["text"],
            button_primary_text_color_dark=self.colors["text"],
            button_secondary_background_fill=self.colors["surface"],
            button_secondary_background_fill_dark=self.colors["surface"],
            button_secondary_text_color=self.colors["text"],
            button_secondary_text_color_dark=self.colors["text"],
            checkbox_background_color=self.colors["surface"],
            checkbox_background_color_dark=self.colors["surface"],
            checkbox_border_color=self.colors["border"],
            checkbox_border_color_dark=self.colors["border"],
            slider_color=self.colors["primary"],
            slider_color_dark=self.colors["primary"],
        )

def criar_app_com_tema():
    theme = CustomTheme()
    
    with gr.Blocks(
        title="App com Tema Personalizado",
        theme=theme.create_theme(),
        css="""
        .gradio-container {
            max-width: 1200px;
            margin: auto;
        }
        .header {
            text-align: center;
            padding: 20px;
            background: linear-gradient(135deg, #6366f1, #8b5cf6);
            border-radius: 10px;
            margin-bottom: 20px;
        }
        .card {
            background: #1e293b;
            border-radius: 10px;
            padding: 20px;
            margin: 10px 0;
        }
        """
    ) as demo:
        gr.HTML("""
        <div class="header">
            <h1 style="color: white; margin: 0;">🎨 Tema Personalizado</h1>
            <p style="color: #e2e8f0; margin: 10px 0 0 0;">Interface estilizada com cores customizadas</p>
        </div>
        """)
        
        with gr.Tabs():
            with gr.TabItem("🎨 Cores"):
                with gr.Row():
                    with gr.Column():
                        color_picker = gr.ColorPicker(
                            label="Cor Primária",
                            value="#6366f1"
                        )
                        cor_secundaria = gr.ColorPicker(
                            label="Cor Secundária",
                            value="#8b5cf6"
                        )
                        cor_fundo = gr.ColorPicker(
                            label="Cor de Fundo",
                            value="#0f172a"
                        )
                    
                    with gr.Column():
                        preview = gr.HTML(
                            label="Preview",
                            value="""
                            <div style="background: #1e293b; padding: 20px; border-radius: 10px;">
                                <h3 style="color: #f8fafc;">Card de Preview</h3>
                                <p style="color: #94a3b8;">Este é um exemplo de como os componentes ficarão</p>
                                <button style="background: #6366f1; color: white; padding: 10px 20px; border: none; border-radius: 5px; cursor: pointer;">
                                    Botão de Exemplo
                                </button>
                            </div>
                            """
                        )
            
            with gr.TabItem("📊 Componentes"):
                gr.Markdown("### Exemplos de Componentes")
                
                with gr.Row():
                    text_input = gr.Textbox(label="Texto", placeholder="Digite algo...")
                    number_input = gr.Number(label="Número", value=42)
                
                slider = gr.Slider(minimum=0, maximum=100, value=50, label="Slider")
                checkbox = gr.Checkbox(label="Checkbox")
                radio = gr.Radio(["Opção 1", "Opção 2", "Opção 3"], label="Radio")
                
                with gr.Row():
                    btn_primario = gr.Button("Primário", variant="primary")
                    btn_secundario = gr.Button("Secundário", variant="secondary")
            
            with gr.TabItem("📝 Formulário"):
                with gr.Form():
                    nome = gr.Textbox(label="Nome", placeholder="Seu nome")
                    email = gr.Textbox(label="Email", placeholder="seu@email.com")
                    idade = gr.Number(label="Idade", value=25)
                    bio = gr.Textbox(label="Bio", lines=3)
                    
                    with gr.Row():
                        btn_salvar = gr.Button("Salvar", variant="primary")
                        btn_cancelar = gr.Button("Cancelar")
    
    return demo

if __name__ == "__main__":
    demo = criar_app_com_tema()
    demo.launch()
```

### 9. Authentication - Sistema de Autenticação

Implemente autenticação segura com diferentes métodos de login.

```python
import gradio as gr
import hashlib
import secrets
from datetime import datetime, timedelta
from typing import Dict, Optional
import json

class AuthSystem:
    def __init__(self):
        self.users = {}
        self.sessions = {}
        self.session_duration = timedelta(hours=24)
        self._load_default_users()
    
    def _load_default_users(self):
        self.create_user("admin", "admin123", "admin")
        self.create_user("user", "user123", "user")
    
    def create_user(self, username: str, password: str, role: str = "user"):
        password_hash = hashlib.sha256(password.encode()).hexdigest()
        self.users[username] = {
            "password": password_hash,
            "role": role,
            "created_at": datetime.now().isoformat(),
            "last_login": None,
            "active": True
        }
    
    def authenticate(self, username: str, password: str) -> Optional[str]:
        if username not in self.users:
            return None
        
        user = self.users[username]
        password_hash = hashlib.sha256(password.encode()).hexdigest()
        
        if user["password"] != password_hash:
            return None
        
        if not user["active"]:
            return None
        
        # Gerar token de sessão
        token = secrets.token_hex(32)
        self.sessions[token] = {
            "username": username,
            "role": user["role"],
            "created_at": datetime.now(),
            "expires_at": datetime.now() + self.session_duration
        }
        
        user["last_login"] = datetime.now().isoformat()
        
        return token
    
    def validate_session(self, token: str) -> Optional[Dict]:
        if token not in self.sessions:
            return None
        
        session = self.sessions[token]
        
        if datetime.now() > session["expires_at"]:
            del self.sessions[token]
            return None
        
        return session
    
    def logout(self, token: str):
        if token in self.sessions:
            del self.sessions[token]
    
    def get_user_info(self, username: str) -> Optional[Dict]:
        if username not in self.users:
            return None
        
        user = self.users[username].copy()
        del user["password"]
        return user

class ProtectedApp:
    def __init__(self):
        self.auth = AuthSystem()
        self.current_token = None
    
    def login(self, username, password):
        token = self.auth.authenticate(username, password)
        if token:
            self.current_token = token
            return True, "Login realizado com sucesso!"
        return False, "Credenciais inválidas"
    
    def logout(self):
        if self.current_token:
            self.auth.logout(self.current_token)
            self.current_token = None
        return "Logout realizado com sucesso"
    
    def get_session_info(self):
        if not self.current_token:
            return None
        
        session = self.auth.validate_session(self.current_token)
        if session:
            return {
                "usuario": session["username"],
                "funcao": session["role"],
                "expira_em": session["expires_at"].isoformat()
            }
        return None

app = ProtectedApp()

def criar_app_protegida():
    with gr.Blocks(title="App Protegido") as demo:
        gr.Markdown("## 🔐 Sistema de Autenticação")
        
        with gr.Tabs():
            with gr.TabItem("🔑 Login"):
                with gr.Row():
                    username = gr.Textbox(label="Usuário", placeholder="Digite seu usuário")
                    password = gr.Textbox(label="Senha", type="password", placeholder="Digite sua senha")
                
                btn_login = gr.Button("Entrar", variant="primary")
                status_login = gr.Textbox(label="Status", interactive=False)
                
                gr.Markdown("""
                **Usuários padrão:**
                - admin / admin123 (Administrador)
                - user / user123 (Usuário comum)
                """)
            
            with gr.TabItem("👤 Perfil"):
                btn_info = gr.Button("Carregar Informações")
                info_usuario = gr.JSON(label="Informações do Usuário")
                btn_logout = gr.Button("Sair", variant="stop")
                status_logout = gr.Textbox(label="Status", interactive=False)
            
            with gr.TabItem("📊 Área Protegida"):
                gr.Markdown("### Conteúdo Exclusivo para Usuários Autenticados")
                dados_exclusivos = gr.JSON(label="Dados Exclusivos")
                btn_carregar = gr.Button("Carregar Dados Exclusivos")
        
        def fazer_login(user, pwd):
            sucesso, mensagem = app.login(user, pwd)
            return mensagem
        
        def obter_info():
            info = app.get_session_info()
            if info:
                return info
            return {"error": "Sessão inválida ou expirada"}
        
        def fazer_logout():
            return app.logout()
        
        def carregar_dados():
            if app.current_token:
                return {"dados": "Informações sensíveis", "status": "acesso permitido"}
            return {"error": "Acesso negado. Faça login primeiro."}
        
        btn_login.click(
            fn=fazer_login,
            inputs=[username, password],
            outputs=[status_login]
        )
        
        btn_info.click(fn=obter_info, outputs=[info_usuario])
        btn_logout.click(fn=fazer_logout, outputs=[status_logout])
        btn_carregar.click(fn=carregar_dados, outputs=[dados_exclusivos])
    
    return demo

if __name__ == "__main__":
    demo = criar_app_protegida()
    demo.launch()
```

### 10. Sharing - URLs Públicas

Compartilhe suas aplicações com URLs públicas temporárias.

```python
import gradio as gr
from datetime import datetime, timedelta
import secrets

class SharingManager:
    def __init__(self):
        self.shares = {}
    
    def create_share_link(self, app_name, duration_hours=24, password=None):
        share_id = secrets.token_urlsafe(16)
        
        self.shares[share_id] = {
            "app_name": app_name,
            "created_at": datetime.now(),
            "expires_at": datetime.now() + timedelta(hours=duration_hours),
            "password": password,
            "access_count": 0,
            "max_access": None
        }
        
        return f"https://gradio.app/{share_id}"
    
    def validate_share(self, share_id, password=None):
        if share_id not in self.shares:
            return False, "Link não encontrado"
        
        share = self.shares[share_id]
        
        if datetime.now() > share["expires_at"]:
            return False, "Link expirado"
        
        if share["password"] and share["password"] != password:
            return False, "Senha incorreta"
        
        if share["max_access"] and share["access_count"] >= share["max_access"]:
            return False, "Limite de acessos atingido"
        
        share["access_count"] += 1
        return True, "Acesso permitido"
    
    def get_share_info(self, share_id):
        return self.shares.get(share_id)

sharing = SharingManager()

def criar_app_compartilhamento():
    with gr.Blocks(title="Sistema de Compartilhamento") as demo:
        gr.Markdown("## 🔗 Compartilhamento de Aplicativos")
        
        with gr.Tabs():
            with gr.TabItem("📤 Criar Link"):
                app_name = gr.Textbox(label="Nome do App", placeholder="Meu App ML")
                
                with gr.Row():
                    duration = gr.Slider(
                        minimum=1, maximum=168, value=24,
                        label="Duração (horas)"
                    )
                    max_access = gr.Number(
                        label="Máximo de Acessos (0 = ilimitado)",
                        value=0
                    )
                
                password = gr.Textbox(
                    label="Senha (opcional)",
                    type="password"
                )
                
                btn_criar = gr.Button("Criar Link", variant="primary")
                link_gerado = gr.Textbox(label="Link Gerado", interactive=False)
                info_link = gr.JSON(label="Informações do Link")
            
            with gr.TabItem("📊 Links Ativos"):
                btn_atualizar = gr.Button("Atualizar Lista")
                lista_links = gr.Dataframe(
                    headers=["App", "Criado", "Expira", "Acessos"],
                    label="Links Ativos"
                )
            
            with gr.TabItem("🔍 Verificar Link"):
                link_verificar = gr.Textbox(
                    label="Link para Verificar",
                    placeholder="https://gradio.app/..."
                )
                senha_verificar = gr.Textbox(
                    label="Senha",
                    type="password"
                )
                btn_verificar = gr.Button("Verificar")
                resultado_verificacao = gr.JSON(label="Resultado")
        
        def criar_link(nome, duracao, max_acessos, senha):
            url = sharing.create_share_link(
                nome, 
                int(duracao),
                senha if senha else None
            )
            
            share_id = url.split("/")[-1]
            info = sharing.get_share_info(share_id)
            
            return url, info
        
        def listar_links():
            links = []
            for share_id, info in sharing.shares.items():
                links.append([
                    info["app_name"],
                    info["created_at"].strftime("%d/%m/%Y %H:%M"),
                    info["expires_at"].strftime("%d/%m/%Y %H:%M"),
                    info["access_count"]
                ])
            return links
        
        def verificar_link(url, senha):
            share_id = url.split("/")[-1] if "/" in url else url
            valido, mensagem = sharing.validate_share(share_id, senha)
            return {"valido": valido, "mensagem": mensagem}
        
        btn_criar.click(
            fn=criar_link,
            inputs=[app_name, duration, max_access, password],
            outputs=[link_gerado, info_link]
        )
        
        btn_atualizar.click(fn=listar_links, outputs=[lista_links])
        
        btn_verificar.click(
            fn=verificar_link,
            inputs=[link_verificar, senha_verificar],
            outputs=[resultado_verificacao]
        )
    
    return demo

if __name__ == "__main__":
    demo = criar_app_compartilhamento()
    demo.launch()
```

### 11. Mounting - Integração com FastAPI/Flask

Monte aplicações Gradio em frameworks existentes como FastAPI ou Flask.

```python
import gradio as gr
from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
import uvicorn
from pydantic import BaseModel
from typing import List, Optional
import numpy as np

# Criar app FastAPI
app_fastapi = FastAPI(
    title="ML API com Gradio",
    description="API de Machine Learning com interface Gradio",
    version="1.0.0"
)

app_fastapi.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Modelos Pydantic
class PredictionRequest(BaseModel):
    features: List[float]
    model: str = "default"

class PredictionResponse(BaseModel):
    prediction: float
    confidence: float
    model_used: str
    timestamp: str

# Simular modelo ML
class MLModel:
    def __init__(self):
        self.models = {
            "linear": lambda x: np.mean(x),
            "polynomial": lambda x: np.sum(x ** 2) / len(x),
            "neural": lambda x: np.tanh(np.mean(x))
        }
    
    def predict(self, features: List[float], model_name: str):
        if model_name not in self.models:
            raise ValueError(f"Modelo não encontrado: {model_name}")
        
        model = self.models[model_name]
        prediction = model(np.array(features))
        confidence = np.random.uniform(0.85, 0.99)
        
        return prediction, confidence

ml_model = MLModel()

# Endpoints FastAPI
@app_fastapi.get("/")
async def root():
    return {"message": "Bem-vindo à API de ML"}

@app_fastapi.get("/health")
async def health():
    return {"status": "healthy", "models": list(ml_model.models.keys())}

@app_fastapi.post("/predict", response_model=PredictionResponse)
async def predict(request: PredictionRequest):
    try:
        prediction, confidence = ml_model.predict(request.features, request.model)
        return PredictionResponse(
            prediction=float(prediction),
            confidence=float(confidence),
            model_used=request.model,
            timestamp=datetime.now().isoformat()
        )
    except Exception as e:
        raise HTTPException(status_code=400, detail=str(e))

@app_fastapi.get("/models")
async def list_models():
    return {"models": list(ml_model.models.keys())}

# Interface Gradio
def predict_gradio(features_text, model_name):
    try:
        features = [float(x.strip()) for x in features_text.split(",")]
        prediction, confidence = ml_model.predict(features, model_name)
        return {
            "predicao": float(prediction),
            "confianca": float(confidence),
            "modelo": model_name
        }
    except Exception as e:
        return {"erro": str(e)}

gradio_interface = gr.Interface(
    fn=predict_gradio,
    inputs=[
        gr.Textbox(label="Features (separadas por vírgula)", placeholder="1.0, 2.0, 3.0"),
        gr.Dropdown(choices=["linear", "polynomial", "neural"], label="Modelo")
    ],
    outputs=gr.JSON(label="Resultado"),
    title="ML Predictor",
    description="Faça predições usando diferentes modelos de ML"
)

# Montar Gradio no FastAPI
app_gradio = gr.mount_gradio_app(
    app_fastapi,
    gradio_interface,
    path="/gradio"
)

if __name__ == "__main__":
    uvicorn.run(app_gradio, host="0.0.0.0", port=8000)
```

### 12. Streaming Output - Saída em Tempo Real

Implemente streaming de dados para atualizações em tempo real na interface.

```python
import gradio as gr
import time
import random
from typing import Generator
from datetime import datetime

class StreamingProcessor:
    def __init__(self):
        self.is_streaming = False
    
    def stream_text(self, text: str, speed: float = 0.05) -> Generator[str, None, None]:
        """Stream texto caractere por caractere"""
        self.is_streaming = True
        result = ""
        
        for char in text:
            if not self.is_streaming:
                break
            result += char
            yield result
            time.sleep(speed)
        
        self.is_streaming = False
    
    def stream_progress(self, steps: int = 10) -> Generator[dict, None, None]:
        """Stream progresso de uma tarefa"""
        self.is_streaming = True
        
        for i in range(steps + 1):
            if not self.is_streaming:
                break
            
            progress = i / steps
            yield {
                "progresso": progress,
                "percentual": f"{progress * 100:.1f}%",
                "passo": f"{i}/{steps}",
                "status": "Concluído" if i == steps else "Processando...",
                "timestamp": datetime.now().strftime("%H:%M:%S")
            }
            time.sleep(0.3)
        
        self.is_streaming = False
    
    def stream_data_points(self, num_points: int = 50) -> Generator[dict, None, None]:
        """Stream pontos de dados simulados"""
        self.is_streaming = True
        
        for i in range(num_points):
            if not self.is_streaming:
                break
            
            yield {
                "x": i,
                "y": random.gauss(0, 1),
                "z": random.uniform(0, 10),
                "timestamp": datetime.now().strftime("%H:%M:%S.%f")[:-3]
            }
            time.sleep(0.1)
        
        self.is_streaming = False
    
    def stop_streaming(self):
        self.is_streaming = False

processor = StreamingProcessor()

def criar_app_streaming():
    with gr.Blocks(title="Streaming em Tempo Real") as demo:
        gr.Markdown("## 📡 Streaming de Dados em Tempo Real")
        
        with gr.Tabs():
            with gr.TabItem("📝 Texto"):
                gr.Markdown("### Stream de Texto")
                texto_input = gr.Textbox(
                    label="Texto para Stream",
                    value="Esta é uma mensagem de exemplo para demonstrar streaming de texto em tempo real.",
                    lines=3
                )
                velocidade = gr.Slider(
                    minimum=0.01, maximum=0.2, value=0.05,
                    label="Velocidade (segundos por caractere)"
                )
                
                with gr.Row():
                    btn_iniciar_texto = gr.Button("▶️ Iniciar Stream", variant="primary")
                    btn_parar_texto = gr.Button("⏹️ Parar")
                
                output_texto = gr.Textbox(label="Output", lines=5, interactive=False)
            
            with gr.TabItem("📊 Progresso"):
                gr.Markdown("### Stream de Progresso")
                num_passos = gr.Slider(
                    minimum=5, maximum=50, value=20,
                    label="Número de Passos"
                )
                
                with gr.Row():
                    btn_iniciar_progresso = gr.Button("▶️ Iniciar Progresso", variant="primary")
                    btn_parar_progresso = gr.Button("⏹️ Parar")
                
                progresso_output = gr.JSON(label="Status do Progresso")
                barra_progresso = gr.Progress(track_tqdm=True)
            
            with gr.TabItem("📈 Dados"):
                gr.Markdown("### Stream de Dados")
                num_pontos = gr.Slider(
                    minimum=10, maximum=200, value=50,
                    label="Número de Pontos"
                )
                
                with gr.Row():
                    btn_iniciar_dados = gr.Button("▶️ Iniciar Dados", variant="primary")
                    btn_parar_dados = gr.Button("⏹️ Parar")
                
                dados_output = gr.Dataframe(
                    headers=["X", "Y", "Z", "Timestamp"],
                    label="Dados em Tempo Real"
                )
        
        def iniciar_stream_texto(texto, vel):
            return processor.stream_text(texto, vel)
        
        def iniciar_stream_progresso(num):
            return processor.stream_progress(int(num))
        
        def iniciar_stream_dados(num):
            return processor.stream_data_points(int(num))
        
        def parar_stream():
            processor.stop_streaming()
            return "Stream interrompido"
        
        btn_iniciar_texto.click(
            fn=iniciar_stream_texto,
            inputs=[texto_input, velocidade],
            outputs=[output_texto]
        )
        btn_parar_texto.click(fn=parar_stream)
        
        btn_iniciar_progresso.click(
            fn=iniciar_stream_progresso,
            inputs=[num_passos],
            outputs=[progresso_output]
        )
        btn_parar_progresso.click(fn=parar_stream)
        
        btn_iniciar_dados.click(
            fn=iniciar_stream_dados,
            inputs=[num_pontos],
            outputs=[dados_output]
        )
        btn_parar_dados.click(fn=parar_stream)
    
    return demo

if __name__ == "__main__":
    demo = criar_app_streaming()
    demo.launch()
```

### 13. Real-time Updates - Atualizações em Tempo Real

Implemente atualizações automáticas da interface com dados em tempo real.

```python
import gradio as gr
import time
import threading
from datetime import datetime
from queue import Queue
import random

class RealtimeUpdater:
    def __init__(self):
        self.data_queue = Queue()
        self.is_running = False
        self.update_interval = 1.0
        self.thread = None
        self.callbacks = []
    
    def start(self):
        self.is_running = True
        self.thread = threading.Thread(target=self._update_loop, daemon=True)
        self.thread.start()
    
    def stop(self):
        self.is_running = False
        if self.thread:
            self.thread.join(timeout=2)
    
    def _update_loop(self):
        while self.is_running:
            data = {
                "timestamp": datetime.now().strftime("%H:%M:%S"),
                "cpu": random.uniform(20, 80),
                "memoria": random.uniform(40, 90),
                "disco": random.uniform(30, 70),
                "rede": random.uniform(0, 100),
                "processos": random.randint(50, 200)
            }
            self.data_queue.put(data)
            
            for callback in self.callbacks:
                try:
                    callback(data)
                except:
                    pass
            
            time.sleep(self.update_interval)
    
    def add_callback(self, callback):
        self.callbacks.append(callback)
    
    def get_latest_data(self):
        if not self.data_queue.empty():
            return self.data_queue.get()
        return None
    
    def set_interval(self, interval):
        self.update_interval = max(0.1, interval)

updater = RealtimeUpdater()

class DashboardMetrics:
    def __init__(self):
        self.history = []
        self.max_history = 100
    
    def add_metric(self, data):
        self.history.append(data)
        if len(self.history) > self.max_history:
            self.history.pop(0)
    
    def get_statistics(self):
        if not self.history:
            return {}
        
        cpus = [d["cpu"] for d in self.history]
        memorias = [d["memoria"] for d in self.history]
        
        return {
            "cpu_medio": sum(cpus) / len(cpus),
            "cpu_maximo": max(cpus),
            "cpu_minimo": min(cpus),
            "memoria_media": sum(memorias) / len(memorias),
            "total_coletas": len(self.history)
        }

dashboard = DashboardMetrics()

def criar_app_realtime():
    with gr.Blocks(title="Dashboard Tempo Real") as demo:
        gr.Markdown("## 📊 Dashboard em Tempo Real")
        
        with gr.Row():
            with gr.Column(scale=2):
                with gr.Row():
                    btn_iniciar = gr.Button("▶️ Iniciar Monitoramento", variant="primary")
                    btn_parar = gr.Button("⏹️ Parar")
                    intervalo = gr.Slider(
                        minimum=0.5, maximum=5.0, value=1.0,
                        label="Intervalo de Atualização (s)"
                    )
                
                with gr.Row():
                    with gr.Column():
                        cpu_gauge = gr.Number(label="CPU %", interactive=False)
                        memoria_gauge = gr.Number(label="Memória %", interactive=False)
                    
                    with gr.Column():
                        disco_gauge = gr.Number(label="Disco %", interactive=False)
                        rede_gauge = gr.Number(label="Rede MB/s", interactive=False)
                
                processos = gr.Number(label="Processos Ativos", interactive=False)
            
            with gr.Column(scale=1):
                estatisticas = gr.JSON(label="📊 Estatísticas Acumuladas")
                btn_stats = gr.Button("Calcular Estatísticas")
        
        historico = gr.Dataframe(
            headers=["Timestamp", "CPU", "Memória", "Disco", "Rede", "Processos"],
            label="📈 Histórico"
        )
        
        def atualizar_dados(data):
            dashboard.add_metric(data)
            return (
                data["cpu"],
                data["memoria"],
                data["disco"],
                data["rede"],
                data["processos"]
            )
        
        updater.add_callback(atualizar_dados)
        
        def iniciar_monitoramento():
            updater.set_interval(intervalo.value)
            updater.start()
            return "Monitoramento iniciado"
        
        def parar_monitoramento():
            updater.stop()
            return "Monitoramento parado"
        
        def obter_estatisticas():
            return dashboard.get_statistics()
        
        def atualizar_historico():
            return dashboard.history[-20:] if dashboard.history else []
        
        btn_iniciar.click(fn=iniciar_monitoramento)
        btn_parar.click(fn=parar_monitoramento)
        btn_stats.click(fn=obter_estatisticas, outputs=[estatisticas])
        
        # Auto-refresh para dados em tempo real
        demo.load(fn=lambda: None, every=1)
    
    return demo

if __name__ == "__main__":
    demo = criar_app_realtime()
    demo.launch()
```

### 14. Error Handling - Tratamento de Erros

Implemente tratamento robusto de erros com mensagens amigáveis e logging.

```python
import gradio as gr
import traceback
import logging
from datetime import datetime
from typing import Any, Optional, Dict
from dataclasses import dataclass
from enum import Enum

class ErrorSeverity(Enum):
    LOW = "low"
    MEDIUM = "medium"
    HIGH = "high"
    CRITICAL = "critical"

@dataclass
class AppError:
    code: str
    message: str
    severity: ErrorSeverity
    timestamp: datetime
    details: Optional[Dict] = None
    stack_trace: Optional[str] = None

class ErrorHandler:
    def __init__(self):
        self.errors = []
        self.max_errors = 1000
        self.setup_logging()
    
    def setup_logging(self):
        self.logger = logging.getLogger("GradioApp")
        self.logger.setLevel(logging.DEBUG)
        
        # Console handler
        ch = logging.StreamHandler()
        ch.setLevel(logging.DEBUG)
        formatter = logging.Formatter(
            '%(asctime)s - %(name)s - %(levelname)s - %(message)s'
        )
        ch.setFormatter(formatter)
        self.logger.addHandler(ch)
    
    def handle_error(self, error: Exception, context: str = "") -> AppError:
        severity = self._determine_severity(error)
        
        app_error = AppError(
            code=self._generate_error_code(error),
            message=str(error),
            severity=severity,
            timestamp=datetime.now(),
            details={"context": context},
            stack_trace=traceback.format_exc()
        )
        
        self.errors.append(app_error)
        
        if len(self.errors) > self.max_errors:
            self.errors = self.errors[-self.max_errors:]
        
        self._log_error(app_error)
        
        return app_error
    
    def _determine_severity(self, error: Exception) -> ErrorSeverity:
        critical_errors = [MemoryError, SystemExit, KeyboardInterrupt]
        high_errors = [ValueError, TypeError, RuntimeError]
        medium_errors = [FileNotFoundError, PermissionError]
        
        if type(error) in critical_errors:
            return ErrorSeverity.CRITICAL
        elif type(error) in high_errors:
            return ErrorSeverity.HIGH
        elif type(error) in medium_errors:
            return ErrorSeverity.MEDIUM
        else:
            return ErrorSeverity.LOW
    
    def _generate_error_code(self, error: Exception) -> str:
        error_type = type(error).__name__
        timestamp = datetime.now().strftime("%Y%m%d%H%M%S")
        return f"ERR_{error_type}_{timestamp}"
    
    def _log_error(self, error: AppError):
        log_message = f"[{error.severity.value.upper()}] {error.code}: {error.message}"
        
        if error.severity in [ErrorSeverity.HIGH, ErrorSeverity.CRITICAL]:
            self.logger.error(log_message)
        elif error.severity == ErrorSeverity.MEDIUM:
            self.logger.warning(log_message)
        else:
            self.logger.info(log_message)
    
    def get_error_stats(self) -> Dict:
        if not self.errors:
            return {"total": 0}
        
        stats = {
            "total": len(self.errors),
            "por_severidade": {},
            "por_tipo": {},
            "ultimas_24h": 0
        }
        
        now = datetime.now()
        
        for error in self.errors:
            # Por severidade
            severity = error.severity.value
            stats["por_severidade"][severity] = stats["por_severidade"].get(severity, 0) + 1
            
            # Por tipo
            error_type = error.code.split("_")[1]
            stats["por_tipo"][error_type] = stats["por_tipo"].get(error_type, 0) + 1
            
            # Últimas 24h
            if (now - error.timestamp).total_seconds() < 86400:
                stats["ultimas_24h"] += 1
        
        return stats

error_handler = ErrorHandler()

def criar_app_com_tratamento_erros():
    with gr.Blocks(title="App com Tratamento de Erros") as demo:
        gr.Markdown("## 🛡️ Tratamento de Erros Robusto")
        
        with gr.Tabs():
            with gr.TabItem("🧪 Testar Erros"):
                tipo_erro = gr.Dropdown(
                    choices=[
                        "ValueError",
                        "TypeError",
                        "FileNotFoundError",
                        "MemoryError",
                        "Custom Error"
                    ],
                    label="Tipo de Erro",
                    value="ValueError"
                )
                
                mensagem_erro = gr.Textbox(
                    label="Mensagem Personalizada",
                    placeholder="Digite uma mensagem de erro (opcional)"
                )
                
                btn_testar = gr.Button("Testar Erro", variant="stop")
                resultado_erro = gr.JSON(label="Erro Capturado")
            
            with gr.TabItem("📊 Estatísticas"):
                btn_stats = gr.Button("Atualizar Estatísticas")
                stats_output = gr.JSON(label="Estatísticas de Erros")
                lista_erros = gr.Dataframe(
                    headers=["Código", "Tipo", "Severidade", "Mensagem", "Data"],
                    label="Histórico de Erros"
                )
            
            with gr.TabItem("⚙️ Configurações"):
                max_erros = gr.Number(label="Máximo de Erros Armazenados", value=1000)
                btn_aplicar = gr.Button("Aplicar Configurações")
                status_config = gr.Textbox(label="Status", interactive=False)
        
        def testar_erro(tipo, mensagem):
            try:
                if tipo == "ValueError":
                    raise ValueError(mensagem or "Erro de valor inválido")
                elif tipo == "TypeError":
                    raise TypeError(mensagem or "Tipo de dado incorreto")
                elif tipo == "FileNotFoundError":
                    raise FileNotFoundError(mensagem or "Arquivo não encontrado")
                elif tipo == "MemoryError":
                    raise MemoryError(mensagem or "Memória insuficiente")
                else:
                    raise Exception(mensagem or "Erro personalizado")
            except Exception as e:
                error = error_handler.handle_error(e, "Teste de interface")
                return {
                    "codigo": error.code,
                    "mensagem": error.message,
                    "severidade": error.severity.value,
                    "timestamp": error.timestamp.isoformat(),
                    "stack_trace": error.stack_trace[:500] if error.stack_trace else None
                }
        
        def obter_estatisticas():
            stats = error_handler.get_error_stats()
            
            recent_errors = error_handler.errors[-10:]
            historico = []
            for err in recent_errors:
                historico.append([
                    err.code,
                    err.code.split("_")[1],
                    err.severity.value,
                    err.message[:50],
                    err.timestamp.strftime("%d/%m/%Y %H:%M")
                ])
            
            return stats, historico
        
        def aplicar_configuracoes(max_erros_val):
            error_handler.max_errors = int(max_erros_val)
            return f"Configurações aplicadas. Máximo de erros: {int(max_erros_val)}"
        
        btn_testar.click(
            fn=testar_erro,
            inputs=[tipo_erro, mensagem_erro],
            outputs=[resultado_erro]
        )
        
        btn_stats.click(
            fn=obter_estatisticas,
            outputs=[stats_output, lista_erros]
        )
        
        btn_aplicar.click(
            fn=aplicar_configuracoes,
            inputs=[max_erros],
            outputs=[status_config]
        )
    
    return demo

if __name__ == "__main__":
    demo = criar_app_com_tratamento_erros()
    demo.launch()
```

### 15. Gallery Components - Componentes de Galeria

Crie galerias de imagens interativas com diferentes layouts e funcionalidades.

```python
import gradio as gr
from PIL import Image, ImageDraw, ImageFont
import random
from datetime import datetime
from typing import List, Dict
import os

class ImageGallery:
    def __init__(self):
        self.images = []
        self.categories = set()
        self.tags = {}
    
    def generate_sample_images(self, num_images: int = 12):
        """Gerar imagens de exemplo"""
        colors = [
            ("#FF6B6B", "Vermelho"),
            ("#4ECDC4", "Verde Água"),
            ("#45B7D1", "Azul"),
            ("#96CEB4", "Verde"),
            ("#FFEAA7", "Amarelo"),
            ("#DDA0DD", "Lavanda"),
            ("#98D8C8", "Menta"),
            ("#F7DC6F", "Dourado")
        ]
        
        categories = ["Natureza", "Retratos", "Abstrato", "Arquitetura"]
        
        for i in range(num_images):
            color_hex, color_name = random.choice(colors)
            category = random.choice(categories)
            
            # Criar imagem
            img = Image.new('RGB', (400, 300), color_hex)
            draw = ImageDraw.Draw(img)
            
            # Adicionar elementos visuais
            for _ in range(5):
                x1 = random.randint(0, 350)
                y1 = random.randint(0, 250)
                x2 = x1 + random.randint(20, 80)
                y2 = y1 + random.randint(20, 80)
                shape_color = random.choice(["#FFFFFF", "#000000", color_hex])
                draw.rectangle([x1, y1, x2, y2], fill=shape_color, outline="#333333")
            
            # Adicionar texto
            try:
                font = ImageFont.truetype("arial.ttf", 20)
            except:
                font = ImageFont.load_default()
            
            draw.text((10, 10), f"Imagem {i+1}", fill="#FFFFFF", font=font)
            draw.text((10, 270), color_name, fill="#FFFFFF", font=font)
            
            image_data = {
                "id": i + 1,
                "image": img,
                "title": f"Imagem {i+1} - {color_name}",
                "category": category,
                "tags": [color_name.lower(), category.lower()],
                "created_at": datetime.now().isoformat(),
                "size": f"{random.randint(100, 500)}KB"
            }
            
            self.images.append(image_data)
            self.categories.add(category)
            
            for tag in image_data["tags"]:
                if tag not in self.tags:
                    self.tags[tag] = []
                self.tags[tag].append(i + 1)
    
    def get_images_by_category(self, category: str) -> List[Dict]:
        return [img for img in self.images if img["category"] == category]
    
    def search_images(self, query: str) -> List[Dict]:
        query_lower = query.lower()
        results = []
        
        for img in self.images:
            if (query_lower in img["title"].lower() or
                query_lower in img["category"].lower() or
                any(query_lower in tag for tag in img["tags"])):
                results.append(img)
        
        return results

gallery = ImageGallery()
gallery.generate_sample_images(16)

def criar_app_galeria():
    with gr.Blocks(title="Galeria de Imagens") as demo:
        gr.Markdown("## 🖼️ Galeria de Imagens Interativa")
        
        with gr.Row():
            with gr.Column(scale=3):
                # Filtros
                with gr.Row():
                    busca = gr.Textbox(
                        label="🔍 Buscar",
                        placeholder="Pesquisar imagens...",
                        scale=3
                    )
                    categoria = gr.Dropdown(
                        choices=["Todas"] + list(gallery.categories),
                        label="Categoria",
                        value="Todas",
                        scale=1
                    )
                
                # Galeria
                galeria_output = gr.Gallery(
                    label="Imagens",
                    columns=4,
                    rows=2,
                    height="auto",
                    object_fit="contain",
                    preview=True
                )
                
                # Paginação
                with gr.Row():
                    btn_anterior = gr.Button("⬅️ Anterior")
                    page_info = gr.Textbox(label="Página", value="1/2", interactive=False)
                    btn_proximo = gr.Button("Próximo ➡️")
            
            with gr.Column(scale=1):
                gr.Markdown("### 📋 Detalhes da Imagem")
                imagem_selecionada = gr.Image(label="Imagem Selecionada", interactive=False)
                
                titulo = gr.Textbox(label="Título", interactive=False)
                desc_categoria = gr.Textbox(label="Categoria", interactive=False)
                tags = gr.Textbox(label="Tags", interactive=False)
                tamanho = gr.Textbox(label="Tamanho", interactive=False)
                
                with gr.Row():
                    btn_editar = gr.Button("✏️ Editar")
                    btn_excluir = gr.Button("🗑️ Excluir", variant="stop")
                
                # Estatísticas
                gr.Markdown("### 📊 Estatísticas")
                stats = gr.JSON(label="Estatísticas da Galeria")
        
        def buscar_imagens(query, cat):
            if cat != "Todas":
                images = gallery.get_images_by_category(cat)
            elif query:
                images = gallery.search_images(query)
            else:
                images = gallery.images
            
            return [img["image"] for img in images[:16]]
        
        def obter_detalhes(evt: gr.SelectData):
            idx = evt.index
            if idx < len(gallery.images):
                img = gallery.images[idx]
                return (
                    img["image"],
                    img["title"],
                    img["category"],
                    ", ".join(img["tags"]),
                    img["size"]
                )
            return None, "", "", "", ""
        
        def obter_estatisticas():
            return {
                "total_imagens": len(gallery.images),
                "categorias": len(gallery.categories),
                "tags": len(gallery.tags)
            }
        
        busca.change(
            fn=buscar_imagens,
            inputs=[busca, categoria],
            outputs=[galeria_output]
        )
        
        categoria.change(
            fn=buscar_imagens,
            inputs=[busca, categoria],
            outputs=[galeria_output]
        )
        
        galeria_output.select(
            fn=obter_detalhes,
            outputs=[imagem_selecionada, titulo, desc_categoria, tags, tamanho]
        )
        
        # Carregar imagens iniciais
        demo.load(
            fn=lambda: ([img["image"] for img in gallery.images[:16]], obter_estatisticas()),
            outputs=[galeria_output, stats]
        )
    
    return demo

if __name__ == "__main__":
    demo = criar_app_galeria()
    demo.launch()
```

---

## 📈 Métricas e Performance

| Métrica | Valor | Descrição |
|---------|-------|-----------|
| Tempo de Início | < 2s | Inicialização rápida |
| Uso de Memória | ~50MB | Para apps simples |
| Latência API | < 100ms | Para predições simples |
| Concurrent Users | 100+ | Com queue habilitada |

---

## 🔗 Recursos Adicionais

- **Documentação Oficial:** https://www.gradio.app/docs
- **Exemplos:** https://www.gradio.app/gallery
- **GitHub:** https://github.com/gradio-app/gradio
- **Discord:** https://discord.gg/gradio

---

**Última atualização:** Janeiro 2026
**Autor:** Advanced Skills Library
**Licença:** MIT
