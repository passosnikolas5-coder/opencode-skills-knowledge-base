# 🤖 Exemplos de AI/ML

Este diretório contém exemplos práticos de skills de AI/ML do **OpenCode Skills Knowledge Base**.

## 📋 Índice

- [LangChain](#langchain)
- [Hugging Face](#hugging-face)
- [PyTorch](#pytorch)
- [Prompt Engineering](#prompt-engineering)
- [RAG](#rag)

---

## LangChain

### Chat com Memória

```python
# chat_with_memory.py
from langchain.chat_models import ChatOpenAI
from langchain.memory import ConversationBufferWindowMemory
from langchain.chains import ConversationChain
from langchain.prompts import PromptTemplate

# Configurar modelo
llm = ChatOpenAI(model="gpt-3.5-turbo", temperature=0.7)

# Configurar memória
memory = ConversationBufferWindowMemory(k=10, return_messages=True)

# Criar template
template = """Você é um assistente prestativo e amigável.

Histórico da conversa:
{history}

Humano: {input}
Assistente:"""

prompt = PromptTemplate(input_variables=["history", "input"], template=template)

# Criar cadeia de conversa
conversation = ConversationChain(
    llm=llm,
    memory=memory,
    prompt=prompt,
    verbose=True
)

# Função principal
def chat():
    print("Chat iniciado! Digite 'sair' para encerrar.")
    while True:
        user_input = input("\nVocê: ")
        if user_input.lower() == 'sair':
            print("Até logo!")
            break
        
        response = conversation.predict(input=user_input)
        print(f"\nAssistente: {response}")

if __name__ == "__main__":
    chat()
```

### RAG (Retrieval-Augmented Generation)

```python
# rag_example.py
from langchain.document_loaders import TextLoader
from langchain.text_splitter import RecursiveCharacterTextSplitter
from langchain.embeddings import OpenAIEmbeddings
from langchain.vectorstores import FAISS
from langchain.chains import RetrievalQA
from langchain.chat_models import ChatOpenAI

# Carregar documentos
loader = TextLoader("documentos.txt")
documents = loader.load()

# Dividir em chunks
text_splitter = RecursiveCharacterTextSplitter(
    chunk_size=1000,
    chunk_overlap=200,
    length_function=len,
)
chunks = text_splitter.split_documents(documents)

# Criar embeddings
embeddings = OpenAIEmbeddings()
vectorstore = FAISS.from_documents(chunks, embeddings)

# Criar cadeia QA
llm = ChatOpenAI(model="gpt-3.5-turbo")
qa_chain = RetrievalQA.from_chain_type(
    llm=llm,
    chain_type="stuff",
    retriever=vectorstore.as_retriever(),
    return_source_documents=True,
)

# Função principal
def ask_question(question: str):
    result = qa_chain({"query": question})
    print(f"Resposta: {result['result']}")
    print(f"\nFontes:")
    for doc in result['source_documents']:
        print(f"- {doc.metadata['source']}: {doc.page_content[:100]}...")

if __name__ == "__main__":
    question = input("Digite sua pergunta: ")
    ask_question(question)
```

---

## Hugging Face

### Classificação de Texto

```python
# text_classification.py
from transformers import pipeline

# Carregar modelo de classificação
classifier = pipeline("text-classification", model="nlptown/bert-base-multilingual-uncased-sentiment")

# Textos para classificar
texts = [
    "Este produto é incrível! Super recomendo!",
    "Terrível experiência. Não recomendo.",
    "Produto ok, nada excepcional.",
    "Adorei! Superou minhas expectativas!",
]

# Classificar textos
for text in texts:
    result = classifier(text)
    print(f"Texto: {text}")
    print(f"Sentimento: {result[0]['label']}, Score: {result[0]['score']:.2f}")
    print("-" * 50)
```

### Geração de Texto

```python
# text_generation.py
from transformers import pipeline

# Carregar modelo de geração
generator = pipeline("text-generation", model="gpt2")

# Prompt para gerar texto
prompt = "Once upon a time in a land far away,"

# Gerar texto
result = generator(
    prompt,
    max_length=100,
    num_return_sequences=3,
    temperature=0.8,
    do_sample=True,
)

# Exibir resultados
for i, text in enumerate(result):
    print(f"\n--- Resultado {i+1} ---")
    print(text['generated_text'])
```

### Sumarização

```python
# summarization.py
from transformers import pipeline

# Carregar modelo de sumarização
summarizer = pipeline("summarization", model="facebook/bart-large-cnn")

# Texto para sumarizar
text = """
A inteligência artificial (IA) é uma área da computação que busca criar 
sistemas capazes de realizar tarefas que normalmente requerem inteligência 
humana. Isso inclui aprendizado, raciocínio, percepção, compreensão de 
linguagem e tomada de decisões. A IA tem sido aplicada em diversos campos, 
desde assistentes virtuais até veículos autônomos, revolucionando a forma 
como vivemos e trabalhamos.
"""

# Gerar sumário
result = summarizer(text, max_length=50, min_length=10, do_sample=False)

print("Texto original:")
print(text)
print("\nSumário:")
print(result[0]['summary_text'])
```

---

## PyTorch

### Rede Neural Simples

```python
# simple_neural_network.py
import torch
import torch.nn as nn
import torch.optim as optim
from sklearn.datasets import make_classification
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import StandardScaler

# Criar dados sintéticos
X, y = make_classification(n_samples=1000, n_features=10, n_classes=2, random_state=42)
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

# Normalizar dados
scaler = StandardScaler()
X_train = scaler.fit_transform(X_train)
X_test = scaler.transform(X_test)

# Converter para tensores PyTorch
X_train_tensor = torch.FloatTensor(X_train)
y_train_tensor = torch.FloatTensor(y_train).unsqueeze(1)
X_test_tensor = torch.FloatTensor(X_test)
y_test_tensor = torch.FloatTensor(y_test).unsqueeze(1)

# Definir modelo
class SimpleNN(nn.Module):
    def __init__(self, input_size):
        super(SimpleNN, self).__init__()
        self.layer1 = nn.Linear(input_size, 64)
        self.layer2 = nn.Linear(64, 32)
        self.layer3 = nn.Linear(32, 1)
        self.relu = nn.ReLU()
        self.sigmoid = nn.Sigmoid()
    
    def forward(self, x):
        x = self.relu(self.layer1(x))
        x = self.relu(self.layer2(x))
        x = self.sigmoid(self.layer3(x))
        x = self.layer3(x)
        x = self.sigmoid(self.layer3(x))
        return x

# Instanciar modelo
model = SimpleNN(input_size=10)
criterion = nn.BCELoss()
optimizer = optim.Adam(model.parameters(), lr=0.001)

# Treinar modelo
epochs = 100
for epoch in range(epochs):
    model.train()
    optimizer.zero_grad()
    outputs = model(X_train_tensor)
    loss = criterion(outputs, y_train_tensor)
    loss.backward()
    optimizer.step()
    
    if (epoch + 1) % 10 == 0:
        print(f"Epoch [{epoch+1}/{epochs}], Loss: {loss.item():.4f}")

# Avaliar modelo
model.eval()
with torch.no_grad():
    test_outputs = model(X_test_tensor)
    predicted = (test_outputs > 0.5).float()
    accuracy = (predicted == y_test_tensor).float().mean()
    print(f"\nAcurácia no teste: {accuracy.item():.4f}")
```

### CNN para Classificação de Imagens

```python
# cnn_image_classification.py
import torch
import torch.nn as nn
import torch.optim as optim
from torchvision import datasets, transforms
from torch.utils.data import DataLoader

# Definir transformações
transform = transforms.Compose([
    transforms.ToTensor(),
    transforms.Normalize((0.5,), (0.5,))
])

# Carregar dataset MNIST
train_dataset = datasets.MNIST(root='./data', train=True, download=True, transform=transform)
test_dataset = datasets.MNIST(root='./data', train=False, download=True, transform=transform)

train_loader = DataLoader(train_dataset, batch_size=64, shuffle=True)
test_loader = DataLoader(test_dataset, batch_size=64, shuffle=False)

# Definir modelo CNN
class CNN(nn.Module):
    def __init__(self):
        super(CNN, self).__init__()
        self.conv1 = nn.Conv2d(1, 32, kernel_size=3, padding=1)
        self.conv2 = nn.Conv2d(32, 64, kernel_size=3, padding=1)
        self.pool = nn.MaxPool2d(2, 2)
        self.fc1 = nn.Linear(64 * 7 * 7, 128)
        self.fc2 = nn.Linear(128, 10)
        self.relu = nn.ReLU()
    
    def forward(self, x):
        x = self.pool(self.relu(self.conv1(x)))
        x = self.pool(self.relu(self.conv2(x)))
        x = x.view(-1, 64 * 7 * 7)
        x = self.relu(self.fc1(x))
        x = self.fc2(x)
        return x

# Instanciar modelo
model = CNN()
criterion = nn.CrossEntropyLoss()
optimizer = optim.Adam(model.parameters(), lr=0.001)

# Treinar modelo
epochs = 5
for epoch in range(epochs):
    model.train()
    for batch_idx, (data, target) in enumerate(train_loader):
        optimizer.zero_grad()
        output = model(data)
        loss = criterion(output, target)
        loss.backward()
        optimizer.step()
        
        if batch_idx % 100 == 0:
            print(f"Epoch [{epoch+1}/{epochs}], Batch [{batch_idx}/{len(train_loader)}], Loss: {loss.item():.4f}")

# Avaliar modelo
model.eval()
correct = 0
total = 0
with torch.no_grad():
    for data, target in test_loader:
        output = model(data)
        _, predicted = torch.max(output.data, 1)
        total += target.size(0)
        correct += (predicted == target).sum().item()

print(f"\nAcurácia no teste: {100 * correct / total:.2f}%")
```

---

## Prompt Engineering

### Prompt para Análise de Código

```python
# code_analysis_prompt.py
from langchain.chat_models import ChatOpenAI
from langchain.prompts import ChatPromptTemplate

# Configurar modelo
llm = ChatOpenAI(model="gpt-4", temperature=0)

# Template para análise de código
template = """
Você é um engenheiro de software sênior especializado em revisão de código.

Analise o seguinte código e forneça:
1. Pontos fortes do código
2. Problemas potenciais
3. Sugestões de melhoria
4. Boas práticas aplicáveis

Código para análise:
```{language}
{code}
```

Forneça uma análise detalhada e construtiva.
"""

prompt = ChatPromptTemplate.from_template(template)

# Código para analisar
code = """
def calculate_fibonacci(n):
    if n <= 0:
        return []
    elif n == 1:
        return [0]
    elif n == 2:
        return [0, 1]
    
    fib = [0, 1]
    for i in range(2, n):
        fib.append(fib[i-1] + fib[i-2])
    return fib
"""

# Executar análise
chain = prompt | llm
result = chain.invoke({"language": "python", "code": code})
print(result.content)
```

### Prompt para Geração de Testes

```python
# test_generation_prompt.py
from langchain.chat_models import ChatOpenAI
from langchain.prompts import ChatPromptTemplate

# Configurar modelo
llm = ChatOpenAI(model="gpt-4", temperature=0)

# Template para geração de testes
template = """
Você é um especialista em testes de software.

Gere testes unitários abrangentes para a seguinte função:
```{language}
{code}
```

Requisitos:
1. Use pytest para Python ou Jest para JavaScript
2. Inclua testes para casos normais
3. Inclua testes para casos extremos
4. Inclua testes para tratamento de erros
5. Adicione comentários explicativos

Forneça o código dos testes completos.
"""

prompt = ChatPromptTemplate.from_template(template)

# Função para testar
code = """
def divide_numbers(a, b):
    if b == 0:
        raise ValueError("Divisão por zero não é permitida")
    return a / b
"""

# Gerar testes
chain = prompt | llm
result = chain.invoke({"language": "python", "code": code})
print(result.content)
```

---

## RAG

### RAG com ChromaDB

```python
# rag_chromadb.py
from langchain.document_loaders import PyPDFLoader
from langchain.text_splitter import RecursiveCharacterTextSplitter
from langchain.embeddings import OpenAIEmbeddings
from langchain.vectorstores import Chroma
from langchain.chains import RetrievalQA
from langchain.chat_models import ChatOpenAI
from langchain.prompts import PromptTemplate

# Carregar PDF
loader = PyPDFLoader("documento.pdf")
documents = loader.load()

# Dividir em chunks
text_splitter = RecursiveCharacterTextSplitter(
    chunk_size=1000,
    chunk_overlap=200,
)
chunks = text_splitter.split_documents(documents)

# Criar vectorstore
embeddings = OpenAIEmbeddings()
vectorstore = Chroma.from_documents(chunks, embeddings, persist_directory="./chroma_db")

# Criar retriever
retriever = vectorstore.as_retriever(search_kwargs={"k": 3})

# Template personalizado
template = """
Você é um assistente especializado em responder perguntas sobre documentos.
Use apenas as informações fornecidas no contexto abaixo para responder.
Se a resposta não estiver no contexto, diga que não sabe.

Contexto:
{context}

Pergunta: {question}

Resposta:"
"""

prompt = PromptTemplate(template=template, input_variables=["context", "question"])

# Criar cadeia QA
llm = ChatOpenAI(model="gpt-3.5-turbo")
qa_chain = RetrievalQA.from_chain_type(
    llm=llm,
    chain_type="stuff",
    retriever=retriever,
    chain_type_kwargs={"prompt": prompt},
    return_source_documents=True,
)

# Função principal
def ask_document(question: str):
    result = qa_chain({"query": question})
    print(f"Pergunta: {question}")
    print(f"Resposta: {result['result']}")
    print(f"\nFontes:")
    for doc in result['source_documents']:
        print(f"- Página {doc.metadata.get('page', 'N/A')}")

if __name__ == "__main__":
    question = input("Digite sua pergunta sobre o documento: ")
    ask_document(question)
```

---

## 📚 Referências

- [LangChain Documentation](https://python.langchain.com/docs/get_started/introduction)
- [Hugging Face Documentation](https://huggingface.co/docs)
- [PyTorch Documentation](https://pytorch.org/docs/stable/)
- [OpenAI API Documentation](https://platform.openai.com/docs)

---

*Última atualização: Setembro 2026*