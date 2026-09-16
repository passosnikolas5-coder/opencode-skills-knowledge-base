# ⚡ FastAPI — Framework Web Moderno e Assíncrono

**Fonte:** https://github.com/tiangolo/fastapi (85k+ stars)
**Descrição:** FastAPI é um framework Python de alta performance para APIs REST, com suporte nativo a async/await, validação automática via Pydantic, documentação interativa e injeção de dependências.

---

## 🚀 1. Aplicação Básica

```python
from fastapi import FastAPI

app = FastAPI(title="Minha API", version="1.0.0")

@app.get("/")
async def root():
    return {"message": "Olá, Mundo!"}

@app.get("/items/{item_id}")
async def read_item(item_id: int, q: str | None = None):
    return {"item_id": item_id, "q": q}
```

```bash
uvicorn main:app --reload
# Docs: http://localhost:8000/docs (Swagger)
# Docs: http://localhost:8000/redoc (ReDoc)
```

---

## 📍 2. Parâmetros de Rota e Query

```python
from fastapi import FastAPI, Query

app = FastAPI()

@app.get("/users/{user_id}")
async def get_user(
    user_id: int,
    q: str | None = Query(default=None, min_length=3, max_length=50),
    skip: int = Query(default=0, ge=0),
    limit: int = Query(default=10, le=100),
):
    return {
        "user_id": user_id,
        "q": q,
        "skip": skip,
        "limit": limit,
    }
```

---

## 📦 3. Corpo da Requisição (Pydantic)

```python
from fastapi import FastAPI
from pydantic import BaseModel, EmailStr
from datetime import date

class UserCreate(BaseModel):
    name: str
    email: EmailStr
    birth_date: date | None = None
    is_active: bool = True

app = FastAPI()

@app.post("/users/")
async def create_user(user: UserCreate):
    return {
        "id": 1,
        "name": user.name,
        "email": user.email,
        "birth_date": user.birth_date,
    }
```

---

## 📤 4. Modelos de Resposta

```python
from fastapi import FastAPI
from pydantic import BaseModel

class UserOut(BaseModel):
    id: int
    name: str
    email: str

class UserInternal(BaseModel):
    id: int
    name: str
    email: str
    password_hash: str

app = FastAPI()

@app.get("/users/{user_id}", response_model=UserOut)
async def get_user(user_id: int) -> UserInternal:
    # Retorna dados internos, mas expõe apenas UserOut
    return UserInternal(
        id=user_id,
        name="João",
        email="joao@email.com",
        password_hash="hash_secreto",
    )
```

---

## 🔗 5. Injeção de Dependências

```python
from fastapi import FastAPI, Depends, HTTPException
from sqlalchemy.orm import Session

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

def get_current_user(token: str = Depends(oauth2_scheme), db: Session = Depends(get_db)):
    user = db.query(User).filter(User.token == token).first()
    if not user:
        raise HTTPException(status_code=401, detail="Token inválido")
    return user

app = FastAPI()

@app.get("/me")
async def read_current_user(current_user: User = Depends(get_current_user)):
    return current_user
```

---

## ⏱️ 6. Background Tasks

```python
from fastapi import FastAPI, BackgroundTasks

def send_email(email: str, message: str):
    # Simula envio de email
    print(f"Email enviado para {email}: {message}")

app = FastAPI()

@app.post("/send-notification/")
async def send_notification(email: str, background_tasks: BackgroundTasks):
    background_tasks.add_task(send_email, email, "Sua conta foi criada!")
    return {"message": "Notificação enviada em segundo plano"}
```

---

## 🛡️ 7. Middleware e CORS

```python
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["http://localhost:3000", "https://meusite.com"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.middleware("http")
async def add_custom_header(request, call_next):
    response = await call_next(request)
    response.headers["X-Custom-Header"] = "valor"
    return response
```

---

## 🔐 8. Autenticação OAuth2 + JWT

```python
from fastapi import FastAPI, Depends, HTTPException, status
from fastapi.security import OAuth2PasswordBearer
from jose import JWTError, jwt
from passlib.context import CryptContext
from datetime import datetime, timedelta

SECRET_KEY = "sua-chave-secreta"
ALGORITHM = "HS256"
ACCESS_TOKEN_EXPIRE_MINUTES = 30

pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")
oauth2_scheme = OAuth2PasswordBearer(tokenUrl="token")

def create_access_token(data: dict, expires_delta: timedelta | None = None):
    to_encode = data.copy()
    expire = datetime.utcnow() + (expires_delta or timedelta(minutes=15))
    to_encode.update({"exp": expire})
    return jwt.encode(to_encode, SECRET_KEY, algorithm=ALGORITHM)

def verify_password(plain_password: str, hashed_password: str) -> bool:
    return pwd_context.verify(plain_password, hashed_password)

def get_password_hash(password: str) -> str:
    return pwd_context.hash(password)

app = FastAPI()

@app.post("/token")
async def login(email: str, password: str):
    # Validar credenciais (simplificado)
    if email != "user@email.com" or password != "123456":
        raise HTTPException(status_code=401, detail="Credenciais inválidas")
    access_token = create_access_token(data={"sub": email}, expires_delta=timedelta(minutes=ACCESS_TOKEN_EXPIRE_MINUTES))
    return {"access_token": access_token, "token_type": "bearer"}

@app.get("/users/me")
async def read_users_me(token: str = Depends(oauth2_scheme)):
    try:
        payload = jwt.decode(token, SECRET_KEY, algorithms=[ALGORITHM])
        email: str = payload.get("sub")
        if email is None:
            raise HTTPException(status_code=401, detail="Token inválido")
    except JWTError:
        raise HTTPException(status_code=401, detail="Token inválido")
    return {"email": email}
```

---

## 🗄️ 9. SQLAlchemy + PostgreSQL

```python
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker, declarative_base
from sqlalchemy import Column, Integer, String

SQLALCHEMY_DATABASE_URL = "postgresql://user:password@localhost/dbname"

engine = create_engine(SQLALCHEMY_DATABASE_URL)
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)
Base = declarative_base()

class User(Base):
    __tablename__ = "users"
    id = Column(Integer, primary_key=True, index=True)
    name = Column(String, index=True)
    email = Column(String, unique=True, index=True)

Base.metadata.create_all(bind=engine)
```

---

## 🧪 10. Testes com TestClient

```python
from fastapi.testclient import TestClient
from main import app

client = TestClient(app)

def test_read_main():
    response = client.get("/")
    assert response.status_code == 200
    assert response.json() == {"message": "Olá, Mundo!"}

def test_create_user():
    response = client.post(
        "/users/",
        json={"name": "Maria", "email": "maria@email.com"},
    )
    assert response.status_code == 200
    data = response.json()
    assert data["name"] == "Maria"
    assert data["id"] is not None
```

---

## 🔄 11. Async/Await

```python
import httpx
from fastapi import FastAPI

app = FastAPI()

@app.get("/fetch-data")
async def fetch_data():
    async with httpx.AsyncClient() as client:
        response = await client.get("https://api.example.com/data")
        return response.json()

@app.get("/parallel")
async def parallel_fetch():
    async with httpx.AsyncClient() as client:
        # Duas requisições em paralelo
        import asyncio
        r1, r2 = await asyncio.gather(
            client.get("https://api.example.com/users"),
            client.get("https://api.example.com/posts"),
        )
        return {"users": r1.json(), "posts": r2.json()}
```

---

## 🔌 12. WebSocket

```python
from fastapi import FastAPI, WebSocket, WebSocketDisconnect

app = FastAPI()

class ConnectionManager:
    def __init__(self):
        self.active_connections: list[WebSocket] = []

    async def connect(self, websocket: WebSocket):
        await websocket.accept()
        self.active_connections.append(websocket)

    def disconnect(self, websocket: WebSocket):
        self.active_connections.remove(websocket)

    async def send_message(self, message: str, websocket: WebSocket):
        await websocket.send_text(message)

manager = ConnectionManager()

@app.websocket("/ws/{client_id}")
async def websocket_endpoint(websocket: WebSocket, client_id: str):
    await manager.connect(websocket)
    try:
        while True:
            data = await websocket.receive_text()
            await manager.send_message(f"Mensagem: {data} de {client_id}", websocket)
    except WebSocketDisconnect:
        manager.disconnect(websocket)
```

---

## 📂 13. Upload de Arquivos

```python
from fastapi import FastAPI, File, UploadFile
import shutil

app = FastAPI()

@app.post("/uploadfile/")
async def create_upload_file(file: UploadFile = File(...)):
    contents = await file.read()
    with open(f"uploads/{file.filename}", "wb") as buffer:
        shutil.copyfileobj(file.file, buffer)
    return {"filename": file.filename, "size": len(contents)}

@app.post("/upload-multiple/")
async def upload_multiple(files: list[UploadFile] = File(...)):
    return {"files": [f.filename for f in files]}
```

---

## ✅ 14. Validação Avançada

```python
from pydantic import BaseModel, Field, field_validator
from enum import Enum

class OrderStatus(str, Enum):
    pending = "pending"
    shipped = "shipped"
    delivered = "delivered"

class Order(BaseModel):
    product_id: int = Field(..., gt=0)
    quantity: int = Field(..., ge=1, le=1000)
    status: OrderStatus = OrderStatus.pending
    notes: str | None = None

    @field_validator("notes")
    @classmethod
    def validate_notes(cls, v: str | None) -> str | None:
        if v and len(v) < 5:
            raise ValueError("Observações devem ter pelo menos 5 caracteres")
        return v
```

---

## 📄 15. Documentação (Swagger/ReDoc)

```python
from fastapi import FastAPI

app = FastAPI(
    title="API de E-commerce",
    description="API completa para gerenciamento de loja virtual",
    version="2.0.0",
    docs_url="/docs",
    redoc_url="/redoc",
    openapi_tags=[
        {"name": "users", "description": "Operações de usuários"},
        {"name": "orders", "description": "Gerenciamento de pedidos"},
    ],
)

@app.get("/users/", tags=["users"])
async def list_users():
    """Lista todos os usuários do sistema."""
    return []

@app.post("/orders/", tags=["orders"])
async def create_order():
    """Cria um novo pedido."""
    return {}
```

---

## 🚨 16. Tratamento de Erros

```python
from fastapi import FastAPI, HTTPException
from fastapi.responses import JSONResponse

app = FastAPI()

class CustomError(Exception):
    def __init__(self, name: str, detail: str):
        self.name = name
        self.detail = detail

@app.exception_handler(CustomError)
async def custom_error_handler(request, exc: CustomError):
    return JSONResponse(
        status_code=400,
        content={"error": exc.name, "detail": exc.detail},
    )

@app.get("/items/{item_id}")
async def read_item(item_id: int):
    if item_id == 0:
        raise HTTPException(status_code=404, detail="Item não encontrado")
    if item_id < 0:
        raise CustomError(name="ID Inválido", detail="ID deve ser positivo")
    return {"item_id": item_id}
```

---

## 🔄 17. Lifespan Events

```python
from contextlib import asynccontextmanager
from fastapi import FastAPI

@asynccontextmanager
async def lifespan(app: FastAPI):
    # Startup
    print("Conectando ao banco de dados...")
    db = await create_connection()
    app.state.db = db

    yield

    # Shutdown
    print("Fechando conexão...")
    await db.close()

app = FastAPI(lifespan=lifespan)

@app.get("/")
async def root():
    return {"db_status": "conectado"}
```

---

## 🚦 18. Rate Limiting

```python
from fastapi import FastAPI, Request
from fastapi.middleware import Middleware
from slowapi import Limiter
from slowapi.util import get_remote_address

limiter = Limiter(key_func=get_remote_address)
app = FastAPI()
app.state.limiter = limiter

@app.get("/api/data")
@limiter.limit("5/minute")
async def get_data(request: Request):
    return {"data": "informação valiosa"}

@app.get("/api/public")
@limiter.limit("100/minute")
async def public_endpoint(request: Request):
    return {"message": "Acesso público"}
```

---

## 🎨 19. GraphQL com Strawberry

```python
import strawberry
from fastapi import FastAPI
from strawberry.fastapi import GraphQLRouter

@strawberry.type
class User:
    id: int
    name: str
    email: str

@strawberry.type
class Query:
    @strawberry.field
    def users(self) -> list[User]:
        return [
            User(id=1, name="João", email="joao@email.com"),
            User(id=2, name="Maria", email="maria@email.com"),
        ]

schema = strawberry.Schema(query=Query)
graphql_app = GraphQLRouter(schema)

app = FastAPI()
app.include_router(graphql_app, prefix="/graphql")
```

---

## ⚙️ 20. SQLite para Desenvolvimento

```python
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker

# SQLite para testes/desenvolvimento
SQLALCHEMY_DATABASE_URL = "sqlite:///./test.db"

engine = create_engine(
    SQLALCHEMY_DATABASE_URL,
    connect_args={"check_same_thread": False}  # Necessário para SQLite
)
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

# Para PostgreSQL em produção:
# SQLALCHEMY_DATABASE_URL = "postgresql://user:password@localhost/dbname"
# engine = create_engine(SQLALCHEMY_DATABASE_URL)
```

---

## ❌ ERRADO vs ✅ CORRETO

### 🚫 Usar models Pydantic v1 em FastAPI novo
```python
# ❌ ERRADO — Sintaxe deprecated
from pydantic import BaseModel
class User(BaseModel):
    class Config:
        orm_mode = True

# ✅ CORRETO — Pydantic v2 com model_config
from pydantic import BaseModel, ConfigDict
class User(BaseModel):
    model_config = ConfigDict(from_attributes=True)
```

### 🚫 Não usar async em rotas que fazem I/O
```python
# ❌ ERRADO — Bloqueia o event loop
@app.get("/users")
def get_users():
    result = requests.get("https://api.example.com/users")
    return result.json()

# ✅ CORRETO — Async com httpx
@app.get("/users")
async def get_users():
    async with httpx.AsyncClient() as client:
        result = await client.get("https://api.example.com/users")
        return result.json()
```

### 🚫 Ignorar Depends em dependências
```python
# ❌ ERRADO — Conexão criada manualmente
@app.get("/users")
def get_users():
    db = SessionLocal()
    users = db.query(User).all()
    db.close()
    return users

# ✅ CORRETO — Using Depends com yield
def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

@app.get("/users")
def get_users(db: Session = Depends(get_db)):
    return db.query(User).all()
```

### 🚫 Não validar dados de entrada
```python
# ❌ ERRADO — Aceita qualquer dado
@app.post("/users")
async def create_user(data: dict):
    return {"id": 1, **data}

# ✅ CORRETO — Modelo Pydantic com validação
class UserCreate(BaseModel):
    name: str = Field(..., min_length=1, max_length=100)
    email: EmailStr

@app.post("/users")
async def create_user(user: UserCreate):
    return {"id": 1, "name": user.name, "email": user.email}
```

### 🚫 Responder sem modelo de resposta
```python
# ❌ ERRADO — Expõe dados internos (password_hash, etc.)
@app.get("/users/{id}")
async def get_user(id: int):
    return db.query(User).filter(User.id == id).first()

# ✅ CORRETO — response_model filtra campos
class UserOut(BaseModel):
    id: int
    name: str
    email: str

@app.get("/users/{id}", response_model=UserOut)
async def get_user(id: int):
    return db.query(User).filter(User.id == id).first()
```

### 🚫 Não tratar exceções HTTP
```python
# ❌ ERRADO — Erro 500 genérico
@app.get("/items/{id}")
async def get_item(id: int):
    item = db.query(Item).get(id)
    if not item:
        return {"error": "não encontrado"}  # Status 200 com erro!
    return item

# ✅ CORRETO — HTTPException com status code
@app.get("/items/{id}")
async def get_item(id: int):
    item = db.query(Item).get(id)
    if not item:
        raise HTTPException(status_code=404, detail="Item não encontrado")
    return item
```

### 🚫 Esquecer CORS em produção
```python
# ❌ ERRADO — Sem CORS, frontend não acessa
app = FastAPI()

# ✅ CORRETO — CORS configurado
app = FastAPI()
app.add_middleware(
    CORSMiddleware,
    allow_origins=["https://meusite.com"],
    allow_credentials=True,
    allow_methods=["GET", "POST", "PUT", "DELETE"],
    allow_headers=["*"],
)
```

### 🚫 Testes sem TestClient
```python
# ❌ ERRADO — Testar manualmente com curl
# curl -X POST http://localhost:8000/users/

# ✅ CORRETO — Testes automatizados
from fastapi.testclient import TestClient

client = TestClient(app)

def test_create_user():
    response = client.post("/users/", json={"name": "Teste", "email": "teste@email.com"})
    assert response.status_code == 200
    assert response.json()["name"] == "Teste"
```

### 🚫 Credentials hardcoded
```python
# ❌ ERRADO — Chave secreta no código
SECRET_KEY = "minha-chave-secreta-123"

# ✅ CORRETO — Usar variáveis de ambiente
import os
SECRET_KEY = os.getenv("SECRET_KEY")
if not SECRET_KEY:
    raise RuntimeError("SECRET_KEY não definida")
```

---

## 📋 Resumo dos Comandos Essenciais

| Comando | Descrição |
|---------|-----------|
| `uvicorn main:app --reload` | Iniciar servidor com hot reload |
| `uvicorn main:app --host 0.0.0.0 --port 80` | Servidor de produção |
| `pip install fastapi[all]` | Instalar com todas as dependências |
| `fastapi generate-schema` | Gerar schema OpenAPI |
| `pytest tests/` | Executar testes |

---

## 📊 Comparação de Endpoints

| Método | Rota | Descrição |
|--------|------|-----------|
| GET | `/docs` | Swagger UI |
| GET | `/redoc` | ReDoc |
| GET | `/openapi.json` | Schema OpenAPI |
| POST | `/token` | Autenticação |
| GET | `/users/me` | Usuário atual |
| POST | `/users/` | Criar usuário |

---

*Documento gerado para uso como skill de referência avançada.*
