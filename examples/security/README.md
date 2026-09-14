# 🔒 Exemplos de Segurança

Este diretório contém exemplos práticos de skills de Segurança do **OpenCode Skills Knowledge Base**.

## 📋 Índice

- [Autenticação](#autenticação)
- [Validação de Input](#validação-de-input)
- [Criptografia](#criptografia)
- [Rate Limiting](#rate-limiting)
- [Headers de Segurança](#headers-de-segurança)

---

## Autenticação

### JWT Seguro

```python
# secure_jwt.py
from datetime import datetime, timedelta
from typing import Optional
import jwt
from passlib.context import CryptContext
from fastapi import HTTPException, status

# Configurações de segurança
SECRET_KEY = "sua-chave-secreta-muito-segura-aqui"  # Em produção, use variável de ambiente
ALGORITHM = "HS256"
ACCESS_TOKEN_EXPIRE_MINUTES = 30
REFRESH_TOKEN_EXPIRE_DAYS = 7

# Hash de senhas
pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")

def verify_password(plain_password: str, hashed_password: str) -> bool:
    """Verifica se a senha plain corresponde ao hash."""
    return pwd_context.verify(plain_password, hashed_password)

def get_password_hash(password: str) -> str:
    """Gera hash da senha."""
    return pwd_context.hash(password)

def create_access_token(data: dict, expires_delta: Optional[timedelta] = None) -> str:
    """Cria access token JWT."""
    to_encode = data.copy()
    if expires_delta:
        expire = datetime.utcnow() + expires_delta
    else:
        expire = datetime.utcnow() + timedelta(minutes=15)
    to_encode.update({"exp": expire, "type": "access"})
    encoded_jwt = jwt.encode(to_encode, SECRET_KEY, algorithm=ALGORITHM)
    return encoded_jwt

def create_refresh_token(data: dict) -> str:
    """Cria refresh token JWT."""
    to_encode = data.copy()
    expire = datetime.utcnow() + timedelta(days=REFRESH_TOKEN_EXPIRE_DAYS)
    to_encode.update({"exp": expire, "type": "refresh"})
    encoded_jwt = jwt.encode(to_encode, SECRET_KEY, algorithm=ALGORITHM)
    return encoded_jwt

def verify_token(token: str, token_type: str = "access") -> dict:
    """Verifica e decodifica token JWT."""
    try:
        payload = jwt.decode(token, SECRET_KEY, algorithms=[ALGORITHM])
        if payload.get("type") != token_type:
            raise HTTPException(
                status_code=status.HTTP_401_UNAUTHORIZED,
                detail="Tipo de token inválido"
            )
        return payload
    except jwt.ExpiredSignatureError:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Token expirado"
        )
    except jwt.JWTError:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Token inválido"
        )
```

### OAuth2 com Google

```python
# google_oauth.py
from fastapi import FastAPI, Depends, HTTPException
from fastapi.security import OAuth2AuthorizationCodeBearer
import httpx
import os

app = FastAPI()

# Configurações do Google OAuth
GOOGLE_CLIENT_ID = os.getenv("GOOGLE_CLIENT_ID")
GOOGLE_CLIENT_SECRET = os.getenv("GOOGLE_CLIENT_SECRET")
GOOGLE_REDIRECT_URI = os.getenv("GOOGLE_REDIRECT_URI")

oauth2_scheme = OAuth2AuthorizationCodeBearer(
    authorizationUrl="https://accounts.google.com/o/oauth2/auth",
    tokenUrl="https://oauth2.googleapis.com/token",
)

@app.get("/auth/google")
async def google_login():
    """Redireciona para login do Google."""
    google_auth_url = (
        f"https://accounts.google.com/o/oauth2/auth?"
        f"client_id={GOOGLE_CLIENT_ID}&"
        f"redirect_uri={GOOGLE_REDIRECT_URI}&"
        f"response_type=code&"
        f"scope=openid email profile"
    )
    return {"url": google_auth_url}

@app.get("/auth/google/callback")
async def google_callback(code: str):
    """Callback do Google OAuth."""
    async with httpx.AsyncClient() as client:
        # Trocar código por token
        token_response = await client.post(
            "https://oauth2.googleapis.com/token",
            data={
                "code": code,
                "client_id": GOOGLE_CLIENT_ID,
                "client_secret": GOOGLE_CLIENT_SECRET,
                "redirect_uri": GOOGLE_REDIRECT_URI,
                "grant_type": "authorization_code",
            },
        )
        
        if token_response.status_code != 200:
            raise HTTPException(status_code=400, detail="Erro ao obter token")
        
        token_data = token_response.json()
        access_token = token_data["access_token"]
        
        # Obter informações do usuário
        user_response = await client.get(
            "https://www.googleapis.com/oauth2/v2/userinfo",
            headers={"Authorization": f"Bearer {access_token}"},
        )
        
        if user_response.status_code != 200:
            raise HTTPException(status_code=400, detail="Erro ao obter informações do usuário")
        
        user_data = user_response.json()
        
        return {
            "email": user_data["email"],
            "name": user_data["name"],
            "picture": user_data.get("picture"),
        }
```

---

## Validação de Input

### Validação com Pydantic

```python
# input_validation.py
from pydantic import BaseModel, EmailStr, Field, validator
from typing import Optional
from datetime import datetime
import re

class UserCreate(BaseModel):
    """Modelo para criação de usuário com validação robusta."""
    username: str = Field(
        ...,
        min_length=3,
        max_length=50,
        regex=r"^[a-zA-Z0-9_-]+$",
        description="Nome de usuário (letras, números, _ e -)"
    )
    email: EmailStr = Field(
        ...,
        description="Email válido"
    )
    password: str = Field(
        ...,
        min_length=8,
        max_length=100,
        description="Senha com pelo menos 8 caracteres"
    )
    full_name: Optional[str] = Field(
        None,
        max_length=100,
        description="Nome completo"
    )
    age: Optional[int] = Field(
        None,
        ge=0,
        le=120,
        description="Idade (0-120)"
    )
    
    @validator('password')
    def validate_password(cls, v):
        """Valida complexidade da senha."""
        if not re.search(r"[A-Z]", v):
            raise ValueError("Senha deve conter pelo menos uma letra maiúscula")
        if not re.search(r"[a-z]", v):
            raise ValueError("Senha deve conter pelo menos uma letra minúscula")
        if not re.search(r"\d", v):
            raise ValueError("Senha deve conter pelo menos um número")
        if not re.search(r"[!@#$%^&*(),.?\":{}|<>]", v):
            raise ValueError("Senha deve conter pelo menos um caractere especial")
        return v
    
    @validator('username')
    def validate_username(cls, v):
        """Valida nome de usuário."""
        if v.startswith('-') or v.startswith('_'):
            raise ValueError("Nome de usuário não pode começar com - ou _")
        if v.endswith('-') or v.endswith('_'):
            raise ValueError("Nome de usuário não pode terminar com - ou _")
        return v

class UserUpdate(BaseModel):
    """Modelo para atualização de usuário."""
    full_name: Optional[str] = Field(None, max_length=100)
    email: Optional[EmailStr] = None
    bio: Optional[str] = Field(None, max_length=500)
    
    class Config:
        extra = "forbid"  # Não permite campos extras
```

### Sanitização de Output

```python
# output_sanitization.py
import html
import re
from typing import Any

def sanitize_string(value: str) -> str:
    """Sanitiza string para prevenir XSS."""
    # Escapar HTML
    sanitized = html.escape(value)
    
    # Remover scripts
    sanitized = re.sub(r'<script[^>]*>.*?</script>', '', sanitized, flags=re.DOTALL | re.IGNORECASE)
    
    # Remover event handlers
    sanitized = re.sub(r'on\w+\s*=', '', sanitized, flags=re.IGNORECASE)
    
    return sanitized

def sanitize_dict(data: dict) -> dict:
    """Sanitiza todos os valores de um dicionário."""
    sanitized = {}
    for key, value in data.items():
        if isinstance(value, str):
            sanitized[key] = sanitize_string(value)
        elif isinstance(value, dict):
            sanitized[key] = sanitize_dict(value)
        elif isinstance(value, list):
            sanitized[key] = [sanitize_string(item) if isinstance(item, str) else item for item in value]
        else:
            sanitized[key] = value
    return sanitized

def sanitize_output(data: Any) -> Any:
    """Sanitiza dados de saída."""
    if isinstance(data, dict):
        return sanitize_dict(data)
    elif isinstance(data, str):
        return sanitize_string(data)
    elif isinstance(data, list):
        return [sanitize_output(item) for item in data]
    return data
```

---

## Criptografia

### Criptografia de Dados

```python
# encryption.py
from cryptography.fernet import Fernet
from cryptography.hazmat.primitives import hashes
from cryptography.hazmat.primitives.kdf.pbkdf2 import PBKDF2HMAC
import base64
import os

class Encryption:
    """Classe para criptografia de dados."""
    
    def __init__(self, password: str):
        """Inicializa com senha."""
        self.salt = os.urandom(16)
        self.key = self._derive_key(password)
        self.cipher = Fernet(self.key)
    
    def _derive_key(self, password: str) -> bytes:
        """Deriva chave da senha."""
        kdf = PBKDF2HMAC(
            algorithm=hashes.SHA256(),
            length=32,
            salt=self.salt,
            iterations=100000,
        )
        key = base64.urlsafe_b64encode(kdf.derive(password.encode()))
        return key
    
    def encrypt(self, data: str) -> dict:
        """Criptografa dados."""
        encrypted = self.cipher.encrypt(data.encode())
        return {
            "encrypted": encrypted.decode(),
            "salt": base64.b64encode(self.salt).decode()
        }
    
    def decrypt(self, encrypted_data: dict) -> str:
        """Descriptografa dados."""
        encrypted = encrypted_data["encrypted"].encode()
        return self.cipher.decrypt(encrypted).decode()

# Uso
password = "minha_senha_segura"
encryption = Encryption(password)

# Criptografar
data = "Dados sensíveis"
encrypted = encryption.encrypt(data)
print(f"Criptografado: {encrypted}")

# Descriptografar
decrypted = encryption.decrypt(encrypted)
print(f"Descriptografado: {decrypted}")
```

### Hash de Senhas

```python
# password_hashing.py
import hashlib
import secrets
import string

def generate_salt(length: int = 32) -> str:
    """Gera salt aleatório."""
    alphabet = string.ascii_letters + string.digits
    return ''.join(secrets.choice(alphabet) for _ in range(length))

def hash_password(password: str, salt: str) -> str:
    """Gera hash da senha com salt."""
    # Usar PBKDF2 com SHA-256
    kdf = hashlib.pbkdf2_hmac(
        'sha256',
        password.encode('utf-8'),
        salt.encode('utf-8'),
        100000
    )
    return kdf.hex()

def verify_password(password: str, salt: str, stored_hash: str) -> bool:
    """Verifica se a senha está correta."""
    computed_hash = hash_password(password, salt)
    return secrets.compare_digest(computed_hash, stored_hash)

# Uso
password = "minha_senha_segura"
salt = generate_salt()
hashed = hash_password(password, salt)

print(f"Salt: {salt}")
print(f"Hash: {hashed}")

# Verificar senha
is_valid = verify_password(password, salt, hashed)
print(f"Senha válida: {is_valid}")
```

---

## Rate Limiting

### Rate Limiter com Redis

```python
# rate_limiter.py
import redis
import time
from typing import Optional
from fastapi import HTTPException, Request

class RateLimiter:
    """Rate limiter usando Redis."""
    
    def __init__(self, redis_url: str = "redis://localhost:6379"):
        """Inicializa conexão com Redis."""
        self.redis = redis.from_url(redis_url)
    
    def is_rate_limited(
        self,
        key: str,
        max_requests: int = 100,
        window_seconds: int = 60
    ) -> bool:
        """Verifica se a requisição deve ser limitada."""
        current_time = int(time.time())
        window_start = current_time - window_seconds
        
        # Usar pipeline para operações atômicas
        pipe = self.redis.pipeline()
        
        # Remover requisições antigas
        pipe.zremrangebyscore(key, 0, window_start)
        
        # Contar requisições atuais
        pipe.zcard(key)
        
        # Adicionar requisição atual
        pipe.zadd(key, {str(current_time): current_time})
        
        # Definir TTL
        pipe.expire(key, window_seconds)
        
        results = pipe.execute()
        current_requests = results[1]
        
        return current_requests >= max_requests
    
    def get_rate_limit_info(
        self,
        key: str,
        max_requests: int = 100,
        window_seconds: int = 60
    ) -> dict:
        """Retorna informações sobre o rate limit."""
        current_time = int(time.time())
        window_start = current_time - window_seconds
        
        # Contar requisições atuais
        current_requests = self.redis.zcount(key, window_start, current_time)
        
        # Calcular tempo até reset
        oldest_request = self.redis.zrange(key, 0, 0, withscores=True)
        if oldest_request:
            reset_time = int(oldest_request[0][1]) + window_seconds
            ttl = max(0, reset_time - current_time)
        else:
            ttl = 0
        
        return {
            "limit": max_requests,
            "remaining": max(0, max_requests - current_requests),
            "reset": ttl,
            "window": window_seconds
        }

# Middleware para FastAPI
async def rate_limit_middleware(request: Request, call_next):
    """Middleware de rate limiting."""
    limiter = RateLimiter()
    
    # Obter IP do cliente
    client_ip = request.client.host
    key = f"rate_limit:{client_ip}"
    
    # Verificar rate limit
    if limiter.is_rate_limited(key, max_requests=100, window_seconds=60):
        raise HTTPException(
            status_code=429,
            detail="Muitas requisições. Tente novamente mais tarde."
        )
    
    response = await call_next(request)
    
    # Adicionar headers de rate limit
    info = limiter.get_rate_limit_info(key)
    response.headers["X-RateLimit-Limit"] = str(info["limit"])
    response.headers["X-RateLimit-Remaining"] = str(info["remaining"])
    response.headers["X-RateLimit-Reset"] = str(info["reset"])
    
    return response
```

---

## Headers de Segurança

### Middleware de Headers

```python
# security_headers.py
from fastapi import Request, Response
from starlette.middleware.base import BaseHTTPMiddleware

class SecurityHeadersMiddleware(BaseHTTPMiddleware):
    """Middleware para adicionar headers de segurança."""
    
    async def dispatch(self, request: Request, call_next):
        response = await call_next(request)
        
        # Headers de segurança
        security_headers = {
            # Previne clickjacking
            "X-Frame-Options": "DENY",
            
            # Previne MIME sniffing
            "X-Content-Type-Options": "nosniff",
            
            # Habilita XSS Protection
            "X-XSS-Protection": "1; mode=block",
            
            # Previne caching de dados sensíveis
            "Cache-Control": "no-store, no-cache, must-revalidate, private",
            
            # Força HTTPS
            "Strict-Transport-Security": "max-age=31536000; includeSubDomains",
            
            # Política de referência
            "Referrer-Policy": "strict-origin-when-cross-origin",
            
            # Permissões de mídia
            "Permissions-Policy": "camera=(), microphone=(), geolocation=()",
            
            # CSP (Content Security Policy)
            "Content-Security-Policy": (
                "default-src 'self'; "
                "script-src 'self' 'unsafe-inline' 'unsafe-eval'; "
                "style-src 'self' 'unsafe-inline'; "
                "img-src 'self' data: https:; "
                "font-src 'self'; "
                "connect-src 'self'; "
                "frame-ancestors 'none'; "
                "form-action 'self'"
            ),
        }
        
        # Adicionar headers à resposta
        for header, value in security_headers.items():
            response.headers[header] = value
        
        return response
```

### Configuração NGINX

```nginx
# nginx.conf
server {
    listen 443 ssl http2;
    server_name example.com;
    
    # SSL Configuration
    ssl_certificate /etc/ssl/certs/example.com.crt;
    ssl_certificate_key /etc/ssl/private/example.com.key;
    ssl_protocols TLSv1.2 TLSv1.3;
    ssl_ciphers HIGH:!aNULL:!MD5;
    ssl_prefer_server_ciphers on;
    
    # Security Headers
    add_header X-Frame-Options "DENY" always;
    add_header X-Content-Type-Options "nosniff" always;
    add_header X-XSS-Protection "1; mode=block" always;
    add_header Strict-Transport-Security "max-age=31536000; includeSubDomains" always;
    add_header Referrer-Policy "strict-origin-when-cross-origin" always;
    add_header Content-Security-Policy "default-src 'self'; script-src 'self'; style-src 'self' 'unsafe-inline'" always;
    
    # Rate Limiting
    limit_req_zone $binary_remote_addr zone=api:10m rate=10r/s;
    
    location /api/ {
        limit_req zone=api burst=20 nodelay;
        proxy_pass http://backend:3000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
```

---

## 📚 Referências

- [OWASP Top 10](https://owasp.org/www-project-top-ten/)
- [NIST Cybersecurity Framework](https://www.nist.gov/cyberframework)
- [FastAPI Security](https://fastapi.tiangolo.com/tutorial/security/)
- [Pydantic Documentation](https://docs.pydantic.dev/)

---

*Última atualização: Setembro 2026*