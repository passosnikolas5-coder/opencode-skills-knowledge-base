# 🎈 Streamlit — Skills Avançados Expandido

> **Fonte:** https://github.com/streamlit/streamlit (42k+ stars)
> **Descrição:** Framework Python para criar aplicativos de dados interativos com interfaces web elegantes e minimalistas.
> **Nível:** Intermediário → Avançado

---

## 1. Widgets Interativos Básicos

```python
import streamlit as st

# Slider
age = st.slider("Idade", min_value=0, max_value=100, value=25)
st.write(f"Você tem {age} anos")

# Selectbox
option = st.selectbox(
    "Qual sua linguagem favorita?",
    ["Python", "JavaScript", "TypeScript", "Rust", "Go"]
)
st.write(f"Você escolheu: {option}")

# Botão
if st.button("Clique aqui"):
    st.balloons()
    st.success("Botão pressionado!")

# Checkbox
agree = st.checkbox("Concordo com os termos")
if agree:
    st.write("Obrigado pela confiança!")

# Radio buttons
genre = st.radio(
    "Qual seu gênero musical?",
    ["Rock", "Pop", "Jazz", "Classical", "Eletrônica"]
)

# Multi-select
languages = st.multiselect(
    "Quais idiomas você fala?",
    ["Português", "Inglês", "Espanhol", "Francês", "Alemão"],
    default=["Português"]
)

# Text area
text = st.text_area("Escreva algo longo...", height=150)

# Number input
num = st.number_input("Insira um número", min_value=0.0, max_value=100.0, step=0.1)

# Date input
from datetime import date
date = st.date_input("Selecione uma data", value=date.today())

# Color picker
color = st.color_picker("Escolha uma cor", "#FF5733")
```

### ❌ ERRADO
```python
# Não usar variáveis normais para estado
option = "Python"
if st.button("Mudar"):
    option = "JavaScript"  # Não persiste entre re-renderizações
st.write(option)  # Sempre será "Python"
```

### ✅ CORRETO
```python
# Usar session_state para persistir valores
if "option" not in st.session_state:
    st.session_state.option = "Python"

if st.button("Mudar"):
    st.session_state.option = "JavaScript"

st.write(st.session_state.option)  # Persiste corretamente
```

---

## 2. Session State — Gerenciamento de Estado

```python
import streamlit as st

# Inicializar estado
if "counter" not in st.session_state:
    st.session_state.counter = 0

if "history" not in st.session_state:
    st.session_state.history = []

if "user" not in st.session_state:
    st.session_state.user = None

# Contador com botões
col1, col2, col3 = st.columns(3)
with col1:
    if st.button("➖"):
        st.session_state.counter -= 1
with col2:
    st.write(f"**{st.session_state.counter}**")
with col3:
    if st.button("➕"):
        st.session_state.counter += 1

# Adicionar ao histórico
if st.button("Registrar valor"):
    st.session_state.history.append(st.session_state.counter)
    st.rerun()  # Forçar re-renderização

# Exibir histórico
if st.session_state.history:
    st.line_chart(st.session_state.history)

# Callbacks para buttons
def increment():
    st.session_state.counter += 1

def decrement():
    st.session_state.counter -= 1

st.button("Incrementar", on_click=increment)
st.button("Decrementar", on_click=decrement)
```

### ❌ ERRADO
```python
# Não misturar estado local e session_state
count = 0
if st.button("Add"):
    count += 1  # Resetado a cada re-renderização
st.write(count)  # Sempre 0
```

### ✅ CORRETO
```python
# Usar session_state consistentemente
if "count" not in st.session_state:
    st.session_state.count = 0

if st.button("Add"):
    st.session_state.count += 1
    st.rerun()

st.write(st.session_state.count)
```

---

## 3. Cache — Performance e Reutilização

```python
import streamlit as st
import pandas as pd
import numpy as np
import time

# Cache de dados (mutável)
@st.cache_data
def load_data(file_path: str) -> pd.DataFrame:
    """Carrega e processa dados - executado apenas uma vez."""
    time.sleep(3)  # Simula operação lenta
    df = pd.read_csv(file_path)
    df['processed'] = df['value'] * 2
    return df

# Cache de recursos (imutável)
@st.cache_resource
def load_model(model_name: str):
    """Carrega modelo ML - singleton por sessão."""
    import joblib
    return joblib.load(f"models/{model_name}.pkl")

# Cache com TTL (time-to-live)
@st.cache_data(ttl=3600)  # Cache por 1 hora
def get_api_data():
    import requests
    return requests.get("https://api.example.com/data").json()

# Cache com hash de parâmetros
@st.cache_data(hash_funcs={pd.DataFrame: lambda df: df.shape[0]})
def process_dataframe(df: pd.DataFrame) -> pd.DataFrame:
    return df.groupby('category').agg({'value': 'mean'}).reset_index()

# Limpar cache
if st.button("🔄 Limpar Cache"):
    st.cache_data.clear()
    st.cache_resource.clear()
    st.success("Cache limpo!")
```

### ❌ ERRADO
```python
# Não fazer operações pesadas sem cache
@st.cache_data
def train_model(X, y):  # Modelo re-treinado a cada chamada sem necessidade
    from sklearn.ensemble import RandomForestClassifier
    model = RandomForestClassifier()
    model.fit(X, y)
    return model
```

### ✅ CORRETO
```python
# Usar cache_resource para objetos imutáveis como modelos
@st.cache_resource
def train_model():
    from sklearn.ensemble import RandomForestClassifier
    model = RandomForestClassifier()
    # Treinar uma vez e cachear
    return model

# Ou usar cache_data com parâmetros explícitos
@st.cache_data
def train_model_cached(n_samples: int):
    from sklearn.datasets import make_classification
    from sklearn.ensemble import RandomForestClassifier
    X, y = make_classification(n_samples=n_samples)
    model = RandomForestClassifier()
    model.fit(X, y)
    return model
```

---

## 4. Layout — Colunas, Sidebar, Tabs

```python
import streamlit as st

# Sidebar
with st.sidebar:
    st.title("⚙️ Configurações")
    model = st.selectbox("Modelo", ["GPT-4", "GPT-3.5", "Claude"])
    temperature = st.slider("Temperature", 0.0, 2.0, 0.7)
    max_tokens = st.number_input("Max Tokens", 100, 4000, 1000)
    st.divider()
    st.markdown("**Status:** ✅ Conectado")

# Colunas
col1, col2, col3 = st.columns(3)

with col1:
    st.metric("Vendas", "1.234", "+12%")
    st.metric("Receita", "R$ 45.678", "+8%")

with col2:
    st.metric("Usuários", "5.678", "+23%")
    st.metric("Conversão", "3.2%", "+0.5%")

with col3:
    st.metric("Satisfação", "4.8/5", "+0.2")
    st.metric("Churn", "2.1%", "-0.3%")

# Tabs
tab1, tab2, tab3 = st.tabs(["📊 Gráficos", "📋 Dados", "📈 Análise"])

with tab1:
    import pandas as pd
    import numpy as np
    chart_data = pd.DataFrame(
        np.random.randn(20, 3),
        columns=['A', 'B', 'C']
    )
    st.line_chart(chart_data)

with tab2:
    st.dataframe(chart_data, use_container_width=True)

with tab3:
    st.write("Análise detalhada aqui...")

# Expander
with st.expander("ℹ️ Mais informações"):
    st.write("Conteúdo oculto que pode ser expandido.")

# Container
with st.container():
    st.write("Container para agrupar elementos")

# Columns aninhadas
outer_col1, outer_col2 = st.columns(2)
with outer_col1:
    st.subheader("Coluna 1")
    inner_col1, inner_col2 = st.columns(2)
    with inner_col1:
        st.write("Sub-coluna 1")
    with inner_col2:
        st.write("Sub-coluna 2")

with outer_col2:
    st.subheader("Coluna 2")
```

---

## 5. Exibição de Dados

```python
import streamlit as st
import pandas as pd
import numpy as np

# DataFrame
df = pd.DataFrame({
    'Nome': ['Ana', 'Bruno', 'Carlos', 'Diana', 'Eduardo'],
    'Idade': [28, 35, 42, 31, 29],
    'Cidade': ['SP', 'RJ', 'BH', 'Curitiba', 'Porto Alegre'],
    'Salário': [5000, 7500, 8200, 6100, 5800]
})

st.dataframe(
    df,
    use_container_width=True,
    column_config={
        "Salário": st.column_config.NumberColumn(
            format="R$ %.2f",
            help="Salário mensal"
        ),
        "Idade": st.column_config.NumberColumn(
            min_value=18,
            max_value=100,
        )
    }
)

# Tabela simples
st.table(df.style.highlight_max(axis=0))

# Métricas
col1, col2, col3 = st.columns(3)
col1.metric("Vendas Hoje", "1.234", delta="12%")
col2.metric("Receita", "R$ 45.678", delta="-2%")
col3.metric("Pedidos", "89", delta="5", delta_color="inverse")

# JSON
st.json({"status": "ok", "data": df.to_dict()})

# Código
code = '''
def hello():
    print("Olá, Streamlit!")
'''
st.code(code, language='python')
```

---

## 6. Gráficos e Visualizações

```python
import streamlit as st
import pandas as pd
import numpy as np

# Dados de exemplo
chart_data = pd.DataFrame(
    np.random.randn(50, 3),
    columns=['Vendas', 'Despesas', 'Lucro']
)

# Streamlit Charts (built-in)
st.line_chart(chart_data)
st.area_chart(chart_data)
st.bar_chart(chart_data)

# Scatter plot com dados geográficos
map_data = pd.DataFrame(
    np.random.randn(100, 2) / [50, 50] + [-23.55, -46.63],
    columns=['lat', 'lon']
)
st.map(map_data)

# Altair (integração nativa)
import altair as alt
chart = alt.Chart(chart_data.reset_index()).mark_line().encode(
    x='index:Q',
    y='Vendas:Q',
    color='variable:N'
).properties(width=600, height=400)
st.altair_chart(chart, use_container_width=True)

# Plotly
import plotly.express as px
fig = px.scatter(
    chart_data,
    x='Vendas',
    y='Lucro',
    title='Vendas vs Lucro'
)
st.plotly_chart(fig, use_container_width=True)

# Matplotlib
import matplotlib.pyplot as plt
fig, ax = plt.subplots(figsize=(10, 6))
ax.plot(chart_data['Vendas'], label='Vendas')
ax.plot(chart_data['Despesas'], label='Despesas')
ax.legend()
st.pyplot(fig)
```

---

## 7. Formulários e Validação

```python
import streamlit as st

# Formulário com st.form
with st.form("cadastro"):
    st.subheader("📝 Formulário de Cadastro")
    
    col1, col2 = st.columns(2)
    with col1:
        nome = st.text_input("Nome completo *", max_chars=100)
        email = st.text_input("E-mail *")
    with col2:
        telefone = st.text_input("Telefone")
        nascimento = st.date_input("Data de nascimento")
    
    genero = st.selectbox("Gênero", ["Masculino", "Feminino", "Outro", "Prefiro não informar"])
    interesses = st.multiselect("Interesses", ["Tecnologia", "Esportes", "Música", "Arte"])
    
    aceito = st.checkbox("Aceito os termos de uso *")
    
    submitted = st.form_submit_button("Enviar")
    
    if submitted:
        # Validação
        erros = []
        if not nome:
            erros.append("Nome é obrigatório")
        if not email or "@" not in email:
            erros.append("E-mail inválido")
        if not aceito:
            erros.append("Aceite os termos")
        
        if erros:
            for erro in erros:
                st.error(f"❌ {erro}")
        else:
            st.success(f"✅ Cadastro realizado: {nome} ({email})")
            st.balloons()

# Botões fora do formulário
if st.button("Limpar formulário"):
    # Limpar campos do formulário
    st.rerun()
```

---

## 8. Upload e Download de Arquivos

```python
import streamlit as st
import pandas as pd

# Upload de arquivo
uploaded_file = st.file_uploader(
    "📤 Escolha um arquivo",
    type=['csv', 'xlsx', 'json', 'txt'],
    accept_multiple_files=True
)

if uploaded_file:
    for file in uploaded_file:
        st.write(f"**{file.name}** ({file.size} bytes)")
        
        if file.type == "text/csv":
            df = pd.read_csv(file)
            st.dataframe(df)
            
            # Botão de download processado
            csv = df.to_csv(index=False).encode('utf-8')
            st.download_button(
                label="📥 Download processado",
                data=csv,
                file_name=f"processed_{file.name}",
                mime="text/csv"
            )
        
        elif file.type == "application/json":
            import json
            data = json.load(file)
            st.json(data)

# Upload de imagem
uploaded_image = st.file_uploader("📸 Upload de imagem", type=['png', 'jpg', 'jpeg'])
if uploaded_image:
    from PIL import Image
    image = Image.open(uploaded_image)
    st.image(image, caption="Imagem enviada", use_column_width=True)

# Download de múltiplos formatos
if st.button("Gerar relatório"):
    df = pd.DataFrame({'A': [1, 2, 3], 'B': [4, 5, 6]})
    
    col1, col2, col3 = st.columns(3)
    with col1:
        st.download_button("📥 CSV", df.to_csv(), "relatorio.csv", "text/csv")
    with col2:
        st.download_button("📥 JSON", df.to_json(), "relatorio.json", "application/json")
    with col3:
        st.download_button("📥 Excel", df.to_excel(), "relatorio.xlsx", "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet")
```

---

## 9. Progresso e Status

```python
import streamlit as st
import time

# Barra de progresso
progress_bar = st.progress(0, text="Iniciando processamento...")
for i in range(100):
    time.sleep(0.01)
    progress_bar.progress(i + 1, text=f"Processando... {i+1}%")
progress_bar.empty()
st.success("✅ Processamento concluído!")

# Spinner
with st.spinner("Carregando dados..."):
    time.sleep(2)
    st.write("Dados carregados!")

# Status
status = st.status("🔍 Processando...", expanded=True)
status.write("📥 Baixando arquivo...")
time.sleep(1)
status.update(label="⚙️ Processando dados...", state="running")
time.sleep(1)
status.update(label="✅ Concluído!", state="complete")

# Toast
st.toast("Operação realizada com sucesso!", icon="✅")

# Alertas
st.info("ℹ️ Informação importante")
st.warning("⚠️ Atenção necessária")
st.error("❌ Erro encontrado")
st.success("✅ Operação bem-sucedida")

# Empty para atualização dinâmica
placeholder = st.empty()
placeholder.write("Carregando...")
time.sleep(2)
placeholder.write("Dados atualizados!")
```

---

## 10. Multi-Page Apps

```python
# Estrutura de diretórios:
# app/
# ├── main.py
# ├── pages/
# │   ├── 1_📊_Dashboard.py
# │   ├── 2_📋_Relatórios.py
# │   └── 3_⚙️_Configurações.py

# main.py
import streamlit as st

st.set_page_config(
    page_title="Meu App",
    page_icon="🚀",
    layout="wide",
    initial_sidebar_state="expanded"
)

st.title("🏠 Página Inicial")
st.write("Bem-vindo ao aplicativo multi-páginas!")

# Navegação via sidebar (alternativa)
page = st.sidebar.selectbox(
    "Navegação",
    ["Home", "Dashboard", "Relatórios", "Configurações"]
)

if page == "Dashboard":
    st.switch_page("pages/1_📊_Dashboard.py")
elif page == "Relatórios":
    st.switch_page("pages/2_📋_Relatórios.py")
```

```python
# pages/1_📊_Dashboard.py
import streamlit as st
import pandas as pd

st.set_page_config(page_title="Dashboard", page_icon="📊")

st.title("📊 Dashboard")

# Métricas do dashboard
col1, col2, col3, col4 = st.columns(4)
col1.metric("Receita", "R$ 1.2M", "+15%")
col2.metric("Clientes", "8.543", "+12%")
col3.metric("Pedidos", "23.456", "+8%")
col4.metric("Ticket Médio", "R$ 156", "+3%")

# Gráfico
df = pd.DataFrame(
    np.random.randn(100, 4),
    columns=['Receita', 'Despesas', 'Lucro', 'Investimento']
)
st.area_chart(df)
```

---

## 11. Autenticação e Segurança

```python
import streamlit as st
import hashlib
import json
from pathlib import Path

# Banco de dados de usuários (simulado)
USERS_FILE = "users.json"

def load_users():
    if Path(USERS_FILE).exists():
        return json.loads(Path(USERS_FILE).read_text())
    return {}

def save_users(users):
    Path(USERS_FILE).write_text(json.dumps(users))

def hash_password(password):
    return hashlib.sha256(password.encode()).hexdigest()

def login_page():
    st.title("🔐 Login")
    
    tab_login, tab_register = st.tabs(["Login", "Registrar"])
    
    with tab_login:
        with st.form("login_form"):
            username = st.text_input("Usuário")
            password = st.text_input("Senha", type="password")
            submitted = st.form_submit_button("Entrar")
            
            if submitted:
                users = load_users()
                if username in users and users[username] == hash_password(password):
                    st.session_state.authenticated = True
                    st.session_state.username = username
                    st.rerun()
                else:
                    st.error("Credenciais inválidas")
    
    with tab_register:
        with st.form("register_form"):
            new_user = st.text_input("Novo usuário")
            new_pass = st.text_input("Nova senha", type="password")
            confirm_pass = st.text_input("Confirmar senha", type="password")
            submitted = st.form_submit_button("Registrar")
            
            if submitted:
                if new_pass != confirm_pass:
                    st.error("Senhas não conferem")
                else:
                    users = load_users()
                    users[new_user] = hash_password(new_pass)
                    save_users(users)
                    st.success("Conta criada! Faça login.")

def check_auth():
    if "authenticated" not in st.session_state:
        st.session_state.authenticated = False
    
    if not st.session_state.authenticated:
        login_page()
        st.stop()

# Usar no início de cada página protegida
check_auth()

# Botão de logout
if st.sidebar.button("🚪 Sair"):
    st.session_state.authenticated = False
    st.session_state.username = None
    st.rerun()

st.sidebar.write(f"👤 Logado como: **{st.session_state.username}**")
```

---

## 12. Integração com Banco de Dados

```python
import streamlit as st
import pandas as pd
from sqlalchemy import create_engine

# Conexão com banco
@st.cache_resource
def get_database():
    return create_engine(
        "postgresql://user:password@localhost:5432/mydb"
    )

engine = get_database()

# Ler dados
if st.button("Carregar dados"):
    df = pd.read_sql("SELECT * FROM customers", engine)
    st.dataframe(df)

# Insert dados
with st.form("insert_form"):
    name = st.text_input("Nome")
    email = st.text_input("E-mail")
    
    if st.form_submit_button("Inserir"):
        with engine.connect() as conn:
            conn.execute(
                "INSERT INTO customers (name, email) VALUES (:name, :email)",
                {"name": name, "email": email}
            )
            conn.commit()
        st.success("Dados inseridos!")

# Query personalizada
query = st.text_area("SQL Query", "SELECT * FROM customers LIMIT 10")
if st.button("Executar"):
    try:
        result = pd.read_sql(query, engine)
        st.dataframe(result)
    except Exception as e:
        st.error(f"Erro: {e}")
```

---

## 13. Temas e Customização

```python
import streamlit as st

# Configuração da página (DEVE ser a primeira chamada)
st.set_page_config(
    page_title="App Customizado",
    page_icon="🎨",
    layout="wide",
    initial_sidebar_state="expanded",
    menu_items={
        'Get Help': 'https://github.com/meu-app',
        'Report a bug': "https://github.com/meu-app/issues",
        'About': "# Meu App Incrível!\nFeito com Streamlit"
    }
)

# CSS customizado
st.markdown("""
<style>
    /* Estilo do header */
    header[data-testid="stHeader"] {
        background-color: #262730;
    }
    
    /* Estilo dos botões */
    .stButton > button {
        background-color: #FF4B4B;
        color: white;
        border-radius: 20px;
        border: none;
        padding: 10px 24px;
        font-weight: bold;
    }
    
    .stButton > button:hover {
        background-color: #FF3333;
    }
    
    /* Estilo das métricas */
    [data-testid="stMetricValue"] {
        color: #00CC66;
    }
    
    /* Sidebar personalizada */
    [data-testid="stSidebar"] {
        background-color: #1E1E1E;
    }
    
    /* Remove padding do container principal */
    .block-container {
        padding-top: 2rem;
    }
</style>
""", unsafe_allow_html=True)

# Usando injetar HTML/JS
st.components.v1.html(
    """
    <script>
    document.addEventListener('DOMContentLoaded', function() {
        console.log('App carregado!');
    });
    </script>
    """,
    height=0
)
```

### 📄 .streamlit/config.toml
```toml
[theme]
primaryColor = "#FF4B4B"
backgroundColor = "#0E1117"
secondaryBackgroundColor = "#262730"
textColor = "#FAFAFA"
font = "sans serif"

[server]
headless = true
enableCORS = false
enableXsrfProtection = true

[browser]
gatherUsageStats = false
```

---

## 14. Componentes Customizados

```python
import streamlit as st
import streamlit.components.v1 as components

# Componente HTML/JS customizado
def custom_metric(label, value, delta=None):
    delta_html = f'<span style="color: {"green" if delta and delta > 0 else "red"}">{delta:+.1f}%</span>' if delta else ''
    return components.html(f"""
    <div style="padding: 10px; border-radius: 10px; background: #f0f2f6; text-align: center;">
        <p style="font-size: 14px; color: #666;">{label}</p>
        <p style="font-size: 28px; font-weight: bold; margin: 0;">{value}</p>
        <p style="font-size: 12px; color: #666; margin: 0;">{delta_html}</p>
    </div>
    """, height=100)

# Usar componente
custom_metric("Receita Total", "R$ 1.2M", delta=12.5)

# Componente com interação
def clickable_card(title, description, key=None):
    components.html(f"""
    <div style="padding: 20px; border: 1px solid #ddd; border-radius: 10px; cursor: pointer;"
         onclick="window.parent.postMessage({{type: 'streamlit:setComponentValue', value: '{key}'}}, '*')">
        <h3 style="margin: 0;">{title}</h3>
        <p style="color: #666;">{description}</p>
    </div>
    """, height=100)

# Google Charts
components.html("""
<script src="https://www.gstatic.com/charts/loader.js"></script>
<script>
google.charts.load('current', {'packages':['corechart']});
google.charts.setOnLoadCallback(drawChart);
function drawChart() {
    var data = google.visualization.arrayToDataTable([
        ['Month', 'Sales', 'Expenses'],
        ['Jan', 1000, 400],
        ['Feb', 1170, 460],
        ['Mar', 660, 1120],
        ['Apr', 1030, 540]
    ]);
    var options = { title: 'Company Performance' };
    var chart = new google.visualization.LineChart(document.getElementById('chart'));
    chart.draw(data, options);
}
</script>
<div id="chart" style="width: 100%; height: 300px;"></div>
""", height=320)
```

---

## 15. LLM / IA com Streamlit

```python
import streamlit as st
import openai

st.title("🤖 Chat com IA")

# Configurações na sidebar
with st.sidebar:
    api_key = st.text_input("OpenAI API Key", type="password")
    model = st.selectbox("Modelo", ["gpt-4o", "gpt-4o-mini", "gpt-3.5-turbo"])
    temperature = st.slider("Temperature", 0.0, 2.0, 0.7)

# Histórico do chat
if "messages" not in st.session_state:
    st.session_state.messages = []

# Exibir mensagens anteriores
for message in st.session_state.messages:
    with st.chat_message(message["role"]):
        st.markdown(message["content"])

# Input do usuário
if prompt := st.chat_input("Digite sua mensagem..."):
    if not api_key:
        st.error("⚠️ Insira sua API Key na sidebar")
        st.stop()
    
    # Adicionar mensagem do usuário
    st.session_state.messages.append({"role": "user", "content": prompt})
    with st.chat_message("user"):
        st.markdown(prompt)
    
    # Gerar resposta
    client = openai.OpenAI(api_key=api_key)
    
    with st.chat_message("assistant"):
        message_placeholder = st.empty()
        full_response = ""
        
        for chunk in client.chat.completions.create(
            model=model,
            messages=[{"role": m["role"], "content": m["content"]} for m in st.session_state.messages],
            temperature=temperature,
            stream=True
        ):
            if chunk.choices[0].delta.content:
                full_response += chunk.choices[0].delta.content
                message_placeholder.markdown(full_response + "▌")
        
        message_placeholder.markdown(full_response)
    
    st.session_state.messages.append({"role": "assistant", "content": full_response})

# Botões de controle
col1, col2 = st.columns(2)
with col1:
    if st.button("🗑️ Limpar Chat"):
        st.session_state.messages = []
        st.rerun()
with col2:
    if st.button("📥 Exportar Chat"):
        import json
        st.download_button(
            "Download",
            json.dumps(st.session_state.messages, ensure_ascii=False, indent=2),
            "chat_history.json",
            "application/json"
        )
```

---

## 16. Deploy no Streamlit Cloud

```python
# requirements.txt
streamlit>=1.32.0
pandas>=2.0.0
plotly>=5.18.0
openai>=1.0.0
sqlalchemy>=2.0.0
python-dotenv>=1.0.0

# .streamlit/secrets.toml (para variáveis secretas)
# [openai]
# api_key = "sk-..."
```

```yaml
# .github/workflows/deploy.yml (CI/CD opcional)
name: Deploy Streamlit

on:
  push:
    branches: [main]

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Deploy to Streamlit Cloud
        uses: Streamlit/cloud-action@main
        with:
          credentials: ${{ secrets.STREAMLIT_CREDENTIALS }}
```

### Estrutura recomendada
```
meu-app/
├── app.py                 # Arquivo principal
├── pages/                 # Páginas adicionais
│   ├── 1_📊_Dashboard.py
│   └── 2_⚙️_Settings.py
├── .streamlit/
│   ├── config.toml        # Configurações do tema
│   └── secrets.toml       # Variáveis secretas
├── utils/                 # Funções auxiliares
│   ├── database.py
│   └── helpers.py
├── requirements.txt       # Dependências
└── README.md
```

---

## 17. Testes e Qualidade

```python
import streamlit as st
import pytest

# Testes unitários para funções auxiliares
def test_process_data():
    import pandas as pd
    df = pd.DataFrame({'value': [1, 2, 3]})
    result = df['value'] * 2
    assert list(result) == [2, 4, 6]

# Testes de integração com Selenium/Playwright
from playwright.sync_api import sync_playwright

def test_streamlit_app():
    with sync_playwright() as p:
        browser = p.chromium.launch(headless=True)
        page = browser.new_page()
        page.goto("http://localhost:8501")
        
        # Verificar título
        assert page.title() == "Meu App"
        
        # Interagir com widget
        page.fill('input[type="text"]', 'Olá')
        page.click('button:has-text("Enviar")')
        
        # Verificar resultado
        assert page.locator("text=Resposta:").is_visible()
        
        browser.close()
```

---

## 18. Performance e Otimização

```python
import streamlit as st
import pandas as pd

# Lazy loading de módulos pesados
@st.cache_data
def load_heavy_library():
    import tensorflow as tf
    return tf.keras.models.load_model('model.h5')

# Fragmentos para atualização parcial
@st.fragment
def update_chart():
    import numpy as np
    data = pd.DataFrame(np.random.randn(100, 2), columns=['A', 'B'])
    st.line_chart(data)

# Usar st.fragment para atualizar apenas parte da página
col1, col2 = st.columns(2)
with col1:
    if st.button("Atualizar gráfico"):
        update_chart()

# Evitar re-execução desnecessária
if "data" not in st.session_state:
    st.session_state.data = pd.read_csv("large_file.csv")

# Usar containers para agrupar atualizações
with st.container():
    st.write("Conteúdo que não precisa ser re-renderizado")

# Profiling
import cProfile
import io

if st.button("Profilar app"):
    pr = cProfile.Profile()
    pr.enable()
    # Código para profilhar
    pr.disable()
    s = io.StringIO()
    pr.print_stats(sort='cumtime')
    st.code(s.getvalue())
```

---

## 19. Padrões e Anti-Padrões

```python
# ❌ ERRADO: Executar código pesado sem cache
def get_data():
    import time
    time.sleep(5)  # Executa a CADA re-renderização!
    return pd.read_csv("large_file.csv")

# ✅ CORRETO: Usar cache
@st.cache_data
def get_data():
    return pd.read_csv("large_file.csv")

# ❌ ERRADO: Não usar session_state
count = 0
if st.button("Add"):
    count += 1  # Resetado!
st.write(count)

# ✅ CORRETO: Usar session_state
if "count" not in st.session_state:
    st.session_state.count = 0
if st.button("Add"):
    st.session_state.count += 1
    st.rerun()
st.write(st.session_state.count)

# ❌ ERRADO: Chamar st.set_page_config() depois de outros comandos
st.write("Algo")
st.set_page_config(page_title="App")  # ERRO!

# ✅ CORRETO: set_page_config() como PRIMEIRA chamada
st.set_page_config(page_title="App")
st.write("Algo")

# ❌ ERRADO: Importar tudo no escopo global
import pandas as pd  # Pode causar conflitos
import numpy as np

# ✅ CORRETO: Importar dentro de funções ou usar aliases
import pandas as _pd
import numpy as _np
```

---

## 20. Referências e Recursos

- [Documentação Oficial](https://docs.streamlit.io)
- [Gallery de Apps](https://streamlit.io/gallery)
- [Componentes Community](https://streamlit.io/components)
- [Blog Streamlit](https://blog.streamlit.io)
- [GitHub](https://github.com/streamlit/streamlit)
- [Forum](https://discuss.streamlit.io)
- [Cheat Sheet](https://docs.streamlit.io/cheatsheet)
