# 🐳 Docker Avançado — Skills Expandidas

> **Fonte:** https://github.com/docker/cli (6k+ estrelas)
> **Descrição:** Plataforma para construir, compartilhar e executar containers. Inclui orquestração de containers, gerenciamento de imagens, redes, volumes e muito mais.

---

## 📋 Índice de Skills

1. Dockerfile Best Practices
2. Multi-Stage Builds
3. Docker Compose
4. Container Lifecycle
5. Image Management
6. Volume Management
7. Networking
8. Docker BuildKit
9. Docker Scout (Security)
10. Docker Desktop
11. Container Orchestration
12. Health Checks
13. Resource Limits
14. Log Management
15. Docker Hub & Private Registries
16. Docker Init
17. Multi-Platform Builds
18. Docker Init & Scaffolding
19. Container Security Hardening
20. Debugging Containers

---

## 1. Dockerfile Best Practices

### Construção Eficiente de Imagens

```dockerfile
# USAR IMAGENS BASE MÍNIMAS
FROM node:20-alpine AS builder

WORKDIR /app

# COPIAR DEPENDÊNCIAS PRIMEIRO (cache layer)
COPY package*.json ./
RUN npm ci --only=production

# DEPOIS COPIAR O CÓDIGO
COPY . .

# PRODUCTION IMAGE
FROM node:20-alpine
WORKDIR /app
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app .

EXPOSE 3000
CMD ["node", "server.js"]
```

### Uso de .dockerignore

```dockerignore
node_modules
npm-debug.log
.git
.env
docker-compose*.yml
Dockerfile
.dockerignore
README.md
```

### Variáveis de Ambiente e Secrets

```dockerfile
# NUNCA HARDCODAR SECRETS NO DOCKERFILE
FROM python:3.11-slim

# USAR ARG PARA BUILD-TIME
ARG APP_VERSION=1.0.0
ENV APP_VERSION=${APP_VERSION}

# SECRETS VIA --build-arg OU secrets mount
RUN --mount=type=secret,id=db_password \
    DB_PASS=$(cat /run/secrets/db_password) && \
    echo "Database configured"

COPY . /app
WORKDIR /app
CMD ["python", "app.py"]
```

### MELHORIA

```
❌ ERRADO: Copiar tudo antes de instalar dependências
COPY . .
RUN npm install
# Qualquer mudança no código invalida o cache

✅ CORRETO: Copiar package.json primeiro
COPY package*.json ./
RUN npm ci --only=production
COPY . .
# Cache preservado enquanto dependências não mudarem
```

---

## 2. Multi-Stage Builds

### Build Fases Múltiplas

```dockerfile
# FASE 1: Build
FROM golang:1.21-alpine AS build
WORKDIR /src
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 go build -o /bin/server .

# FASE 2: Runtime
FROM gcr.io/distroless/static-debian12
COPY --from=build /bin/server /server
EXPOSE 8080
ENTRYPOINT ["/server"]
```

### Build com Compilação Condicional

```dockerfile
FROM node:20-alpine AS base
WORKDIR /app
COPY package*.json ./

# FASE DE DESENVOLVIMENTO
FROM base AS development
RUN npm install
COPY . .
CMD ["npm", "run", "dev"]

# FASE DE TESTES
FROM base AS testing
RUN npm ci
COPY . .
RUN npm test

# FASE DE PRODUÇÃO
FROM base AS production
RUN npm ci --only=production
COPY --from=development /app/dist ./dist
EXPOSE 3000
CMD ["node", "dist/index.js"]
```

### Multi-Platform Build

```bash
# Criar builder multi-plataforma
docker buildx create --name multiplatform --use

# Build para múltiplas plataformas
docker buildx build \
  --platform linux/amd64,linux/arm64,linux/arm/v7 \
  -t myapp:latest \
  --push .
```

### MELHORIA

```
❌ ERRADO: Uma única stage monolítica
FROM node:20
COPY . .
RUN npm install && npm run build
# Imagem final enorme com ferramentas de build

✅ CORRETO: Multi-stage com imagem mínima
FROM node:20-alpine AS build
RUN npm run build

FROM node:20-alpine
COPY --from=build /app/dist ./dist
# Imagem de produção leve e segura
```

---

## 3. Docker Compose

### Compose Completo para App Full-Stack

```yaml
version: '3.9'

services:
  frontend:
    build:
      context: ./frontend
      dockerfile: Dockerfile
      target: production
    ports:
      - "3000:3000"
    environment:
      - API_URL=http://backend:8080
    depends_on:
      backend:
        condition: service_healthy
    networks:
      - frontend-net
    deploy:
      replicas: 2
      resources:
        limits:
          cpus: '0.5'
          memory: 256M

  backend:
    build: ./backend
    ports:
      - "8080:8080"
    environment:
      - DATABASE_URL=postgres://user:pass@db:5432/mydb
      - REDIS_URL=redis://redis:6379
    depends_on:
      db:
        condition: service_healthy
      redis:
        condition: service_healthy
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:8080/health"]
      interval: 30s
      timeout: 10s
      retries: 3
      start_period: 40s
    networks:
      - frontend-net
      - backend-net

  db:
    image: postgres:16-alpine
    environment:
      POSTGRES_DB: mydb
      POSTGRES_USER: user
      POSTGRES_PASSWORD: pass
    volumes:
      - postgres_data:/var/lib/postgresql/data
      - ./init.sql:/docker-entrypoint-initdb.d/init.sql
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U user -d mydb"]
      interval: 10s
      timeout: 5s
      retries: 5
    networks:
      - backend-net

  redis:
    image: redis:7-alpine
    command: redis-server --appendonly yes
    volumes:
      - redis_data:/data
    healthcheck:
      test: ["CMD", "redis-cli", "ping"]
      interval: 10s
      timeout: 5s
      retries: 5
    networks:
      - backend-net

volumes:
  postgres_data:
  redis_data:

networks:
  frontend-net:
  backend-net:
```

### Comandos Essenciais Compose

```bash
# Iniciar tudo em background
docker compose up -d

# Reconstruir imagens
docker compose up -d --build

# Ver logs
docker compose logs -f backend

# Parar e remover tudo
docker compose down -v

# Escalar serviço
docker compose up -d --scale backend=3

# Executar comando em container
docker compose exec backend sh

# Ver status
docker compose ps
```

### MELHORIA

```
❌ ERRADO: Usar links obsoletos
version: '2'
services:
  web:
    links:
      - db
    image: nginx

✅ CORRETO: Usar networks e depends_on
services:
  web:
    depends_on:
      db:
        condition: service_healthy
    networks:
      - app-net
  db:
    networks:
      - app-net
```

---

## 4. Container Lifecycle

### Gerenciamento Completo de Containers

```bash
# Criar container a partir de imagem
docker create --name myapp -p 8080:80 nginx:alpine

# Iniciar container
docker start myapp

# Pausar container
docker pause myapp

# Despausar container
docker unpause myapp

# Parar container graceful
docker stop -t 30 myapp

# Matar container forçado
docker kill myapp

# Remover container
docker rm myapp

# Remover container rodando
docker rm -f myapp

# Remover todos containers parados
docker container prune

# Renomear container
docker rename old_name new_name

# Copiar arquivos
docker cp myapp:/var/log/app.log ./logs/

# Inspect detalhado
docker inspect myapp

# Ver portas mapeadas
docker port myapp

# Ver processos
docker top myapp

# Ver mudanças no filesystem
docker diff myapp
```

### Commit de Container

```bash
# Criar imagem a partir de container modificado
docker commit -a "Autor" -m "Mensagem" myapp myapp:v1.2

# Criar imagem com comando
docker commit --change='CMD ["node", "server.js"]' myapp myapp:prod
```

### MELHORIA

```
❌ ERRADO: Não limpar containers parados
docker stop myapp
# Container para mas continua ocupando espaço

✅ CORRETO: Remover container após parar
docker stop myapp && docker rm myapp
# Ou usar --rm para remoção automática
docker run --rm nginx:alpine
```

---

## 5. Image Management

### Gerenciamento Avançado de Imagens

```bash
# Listar imagens
docker images
docker images -a  # incluir imagens intermediárias

# Taggear imagem
docker tag myapp:latest myregistry.com/myapp:1.0

# Push para registry
docker push myregistry.com/myapp:1.0

# Pull de registry privado
docker pull myregistry.com/myapp:1.0

# Salvar imagem para arquivo
docker save myapp:latest -o myapp.tar

# Carregar imagem de arquivo
docker load -i myapp.tar

# Remover imagem
docker rmi myapp:latest

# Forçar remoção
docker rmi -f myapp:latest

# Remover imagens dangling
docker image prune

# Remover todas imagens não usadas
docker image prune -a

# Ver histórico da imagem
docker history myapp:latest

# Ver camadas da imagem
docker inspect myapp:latest

# Build com label
docker build -t myapp:1.0 \
  --label "version=1.0" \
  --label "maintainer=dev@company.com" .
```

### Multi-Registry Push

```bash
# Taggear para múltiplos registries
docker tag myapp:latest docker.io/myorg/myapp:1.0
docker tag myapp:latest ghcr.io/myorg/myapp:1.0
docker tag myapp:latest registry.gitlab.com/myorg/myapp:1.0

# Push para todos
docker push docker.io/myorg/myapp:1.0
docker push ghcr.io/myorg/myapp:1.0
docker push registry.gitlab.com/myorg/myorg/myapp:1.0
```

### MELHORIA

```
❌ ERRADO: Manter muitas tags desnecessárias
docker images  # lista enorme de tags

✅ CORRETO: Limpar imagens não utilizadas
docker image prune -a  # remove tudo não usado
# Usar .dockerignore para reduzir tamanho
```

---

## 6. Volume Management

### Tipos de Volumes

```bash
# Volume nomeado (recomendado)
docker volume create mydata
docker run -v mydata:/app/data myapp

# Bind mount (diretório do host)
docker run -v /host/path:/container/path myapp

# Bind mount somente leitura
docker run -v /host/path:/container/path:ro myapp

# tmpfs (memória apenas)
docker run --tmpfs /app/temp myapp

# Volume com driver específico
docker volume create \
  --driver local \
  --opt type=nfs \
  --opt o=addr=192.168.1.1,rw \
  --opt device=:/path/to/dir \
  nfsvolume
```

### Backup e Restore de Volumes

```bash
# Backup de volume
docker run --rm \
  -v mydata:/source:ro \
  -v $(pwd):/backup \
  alpine tar czf /backup/mydata-backup.tar.gz -C /source .

# Restore de volume
docker run --rm \
  -v mydata:/target \
  -v $(pwd):/backup \
  alpine tar xzf /backup/mydata-backup.tar.gz -C /target

# Migrar volume para novo host
docker run --rm \
  -v source_vol:/data:ro \
  -v /mnt/nfs:/backup \
  alpine tar czf /backup/vol.tar.gz -C /data .
```

### Docker Compose com Volumes

```yaml
services:
  db:
    image: postgres:16
    volumes:
      - db_data:/var/lib/postgresql/data
      - ./init-scripts:/docker-entrypoint-initdb.d:ro
      - ./certs:/etc/ssl/certs:ro
    environment:
      POSTGRES_PASSWORD_FILE: /run/secrets/db_password
    secrets:
      - db_password

volumes:
  db_data:
    driver: local
    driver_opts:
      type: none
      o: bind
      device: /mnt/fast-ssd/postgres

secrets:
  db_password:
    file: ./secrets/db_password.txt
```

### MELHORIA

```
❌ ERRADO: Usar bind mounts para dados persistentes
docker run -v /host/data:/app/data postgres
# Se o host falhar, dados podem ser perdidos

✅ CORRETO: Usar volumes nomeados
docker volume create pgdata
docker run -v pgdata:/var/lib/postgresql/data postgres
# Gerenciado pelo Docker, portável e seguro
```

---

## 7. Networking

### Redes Docker

```bash
# Criar rede bridge personalizada
docker network create \
  --driver bridge \
  --subnet 172.20.0.0/16 \
  --gateway 172.20.0.1 \
  mybridge

# Criar rede overlay (Swarm)
docker network create \
  --driver overlay \
  --attachable \
  myoverlay

# Criar rede macvlan
docker network create \
  --driver macvlan \
  --subnet 192.168.1.0/24 \
  --gateway 192.168.1.1 \
  -o parent=eth0 \
  mymacvlan

# Conectar container a múltiplas redes
docker network connect mybridge myapp
docker network connect myoverlay myapp

# Desconectar de rede
docker network disconnect mybridge myapp

# Ver redes
docker network ls
docker network inspect mybridge
```

### Comunicação Entre Containers

```bash
# Containers na mesma rede se comunicam por nome
docker run -d --name web --network mynet nginx
docker run -d --name app --network mynet myapp
# app pode acessar web via "http://web:80"

# Criar rede e sub-rede
docker network create \
  --driver bridge \
  --subnet 10.0.1.0/24 \
  frontend

docker network create \
  --driver bridge \
  --subnet 10.0.2.0/24 \
  backend
```

### MELHORIA

```
❌ ERRADO: Usar a rede padrão do Docker
docker run -p 8080:80 nginx
# Containers não isolados, conflitos de nomes

✅ CORRETO: Criar redes específicas
docker network create app-net
docker run --network app-net --name web nginx
docker run --network app-net --name api myapi
# Isolamento e resolução de nomes por container
```

---

## 8. Docker BuildKit

### Recursos Avançados do BuildKit

```bash
# Habilitar BuildKit
export DOCKER_BUILDKIT=1
docker build .  # BuildKit automático

# Build com cache mount
docker build \
  --build-arg BUILDKIT_INLINE_CACHE=1 \
  -t myapp:latest .

# Build secreto
docker build \
  --secret id=npmrc,src=.npmrc \
  -t myapp:latest .
```

### Dockerfile com BuildKit

```dockerfile
# syntax=docker/dockerfile:1

FROM node:20-alpine AS builder

WORKDIR /app

# Cache mount para npm
RUN --mount=type=cache,target=/root/.npm \
    npm ci

# Cache mount para go build
FROM golang:1.21-alpine AS gobuild
RUN --mount=type=cache,target=/go/pkg/mod \
    --mount=type=cache,target=/root/.cache/go-build \
    go build -o /app/server .

# Secrets no build
RUN --mount=type=secret,id=npmrc,target=/root/.npmrc \
    npm ci --production

COPY . .
RUN npm run build
```

### Build Compressão e Exportação

```dockerfile
# Exportar resultado como tarball
FROM node:20-alpine AS build
RUN npm run build

# Usar exporter para exportar artefatos
RUN --mount=type=bind,from=build,source=/app/dist,target=/dist \
    tar -czf /dist.tar.gz -C /dist .
```

### MELHORIA

```
❌ ERRADO: Não usar cache mounts
FROM node:20
COPY package*.json ./
RUN npm install  # Reinstala tudo a cada build

✅ CORRETO: Usar cache mounts com BuildKit
FROM node:20
RUN --mount=type=cache,target=/root/.npm \
    npm install
# npm reutiliza cache, builds muito mais rápidos
```

---

## 9. Docker Scout (Security)

### Varredura de Vulnerabilidades

```bash
# Instalar Docker Scout
docker scout --version

# Varredura de imagem
docker scout cves myapp:latest

# Varredura com severidade
docker scout cves --only-severity critical,high myapp:latest

# Comparar com versão anterior
docker scout compare myapp:latest --to myapp:v1.0

# Recomendações de fix
docker scout recommendations myapp:latest

# SBOM (Software Bill of Materials)
docker scout sbom myapp:latest
```

### Integração com CI/CD

```yaml
# GitHub Actions
name: Security Scan
on: push

jobs:
  scan:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      
      - name: Build image
        run: docker build -t myapp:${{ github.sha }} .
      
      - name: Scan with Docker Scout
        uses: docker/scout-action@v1
        with:
          command: cves
          image: myapp:${{ github.sha }}
          only-severities: critical,high
          exit-code: true
```

### MELHORIA

```
❌ ERRADO: Não verificar vulnerabilidades antes de deploy
docker build -t myapp:prod .
docker push myapp:prod  # Possível código vulnerável

✅ CORRETO: Escanear antes de push
docker build -t myapp:prod .
docker scout cves myapp:prod --only-severity critical,high
# Falhar build se vulnerabilidades críticas
```

---

## 10. Docker Desktop

### Configuração e Uso

```bash
# Abrir Docker Desktop
open -a Docker  # macOS
start "" "C:\Program Files\Docker\Docker\Docker Desktop.exe"  # Windows

# Verificar status
docker info
docker version

# Configurar proxy
# Settings > Resources > Proxies

# Configurar DNS
# Settings > Docker Engine

# Kubernetes no Docker Desktop
# Settings > Kubernetes > Enable Kubernetes
```

### Docker Desktop Extensions

```bash
# Listar extensões
docker extension ls

# Instalar extensão
docker extension install USERNAME/EXTENSION

# Desinstalar extensão
docker extension uninstall USERNAME/EXTENSION
```

### MELHORIA

```
❌ ERRADO: Manter Docker Desktop com configurações padrão
# Recursos insuficientes, sem otimização

✅ CORRETO: Ajustar recursos conforme necessidade
# Settings > Resources:
# - CPU: 4+ cores
# - Memory: 8GB+
# - Disk: 60GB+
# - Disk image size: 64GB
```

---

## 11. Container Orchestration

### Docker Swarm

```bash
# Inicializar swarm
docker swarm init

# Adicionar worker
docker swarm join --token <token> <manager-ip>:2377

# Criar serviço
docker service create \
  --name web \
  --replicas 3 \
  --publish 80:80 \
  nginx:alpine

# Atualizar serviço
docker service update \
  --image nginx:1.25 \
  --update-parallelism 1 \
  --update-delay 10s \
  web

# Rollback
docker service rollback web

# Ver serviços
docker service ls
docker service ps web
docker service logs web
```

### Docker Compose para Deploy

```yaml
# docker-compose.prod.yml
version: '3.9'

services:
  web:
    image: myapp:latest
    deploy:
      replicas: 3
      update_config:
        parallelism: 1
        delay: 10s
        failure_action: rollback
        order: start-first
      rollback_config:
        parallelism: 1
        delay: 5s
      restart_policy:
        condition: on-failure
        delay: 5s
        max_attempts: 3
        window: 120s
      resources:
        limits:
          cpus: '0.5'
          memory: 512M
        reservations:
          cpus: '0.25'
          memory: 256M
      placement:
        constraints:
          - node.role == manager
```

### MELHORIA

```
❌ ERRADO: Atualizar todos containers de uma vez
docker service update --image myapp:v2 web
# Pode causar downtime se algo falhar

✅ CORRETO: Rolling update com paralelismo controlado
docker service update \
  --image myapp:v2 \
  --update-parallelism 1 \
  --update-delay 30s \
  --update-failure-action rollback \
  web
```

---

## 12. Health Checks

### Definição de Health Checks

```dockerfile
# Dockerfile
FROM nginx:alpine

# Health check básico
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD curl -f http://localhost/ || exit 1

# Health check com wget
HEALTHCHECK --interval=30s --timeout=5s --retries=3 \
  CMD wget -q --spider http://localhost/health || exit 1

# Health check com comando customizado
HEALTHCHECK --interval=15s --timeout=5s --retries=3 \
  CMD python -c "import urllib.request; urllib.request.urlopen('http://localhost/health')" || exit 1
```

### Health Checks no Compose

```yaml
services:
  api:
    build: .
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:8080/health"]
      interval: 30s
      timeout: 10s
      retries: 3
      start_period: 40s
      start_interval: 5s

  db:
    image: postgres:16
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U ${POSTGRES_USER}"]
      interval: 10s
      timeout: 5s
      retries: 5
      start_period: 30s
```

### MELHORIA

```
❌ ERRADO: Não definir health checks
services:
  web:
    image: nginx
  api:
    image: myapi
    depends_on:
      - web
# API pode iniciar antes do web estar pronto

✅ CORRETO: Definir health checks e conditions
services:
  web:
    image: nginx
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost/"]
      interval: 10s
      retries: 3
  api:
    image: myapi
    depends_on:
      web:
        condition: service_healthy
```

---

## 13. Resource Limits

### Limites de CPU e Memória

```bash
# CPU limits
docker run -d \
  --cpus="1.5" \
  --cpu-shares=512 \
  --cpuset-cpus="0,1" \
  myapp

# Memory limits
docker run -d \
  --memory=512m \
  --memory-swap=1g \
  --memory-reservation=256m \
  --oom-kill-disable=false \
  myapp

# GPU access
docker run -d \
  --gpus all \
  myapp:gpu

docker run -d \
  --gpus '"device=0,1"' \
  myapp:gpu
```

### Recursos no Compose

```yaml
services:
  web:
    image: nginx
    deploy:
      resources:
        limits:
          cpus: '2.0'
          memory: 1G
        reservations:
          cpus: '1.0'
          memory: 512M
          devices:
            - capabilities: [gpu]
              count: 1

  worker:
    image: myworker
    deploy:
      resources:
        limits:
          cpus: '4.0'
          memory: 4G
```

### MELHORIA

```
❌ ERRADO: Sem limites de recursos
docker run -d myapp
# Container pode consumir todos os recursos do host

✅ CORRETO: Definir limites claros
docker run -d \
  --cpus="1" \
  --memory=512m \
  myapp
# Previne OOM kills e garante distribuição justa
```

---

## 14. Log Management

### Configuração de Logs

```bash
# Ver logs de container
docker logs myapp

# Logs com timestamp
docker logs -t myapp

# Logs em tempo real
docker logs -f myapp

# Últimas 100 linhas
docker logs --tail 100 myapp

# Logs desde timestamp
docker logs --since 2024-01-01T00:00:00 myapp

# Logs até timestamp
docker logs --until 2024-01-01T23:59:59 myapp
```

### Configuração de Driver de Logs

```json
// /etc/docker/daemon.json
{
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "10m",
    "max-file": "3",
    "compress": "true",
    "labels": "service",
    "tag": "{{.ImageName}}/{{.Name}}"
  }
}
```

### Logs no Compose

```yaml
services:
  web:
    image: nginx
    logging:
      driver: json-file
      options:
        max-size: "10m"
        max-file: "3"
        compress: "true"

  # Usando fluentd para log aggregation
  api:
    image: myapi
    logging:
      driver: fluentd
      options:
        fluentd-address: localhost:24224
        fluentd-async: "true"
        tag: "docker.{{.Name}}"
```

### MELHORIA

```
❌ ERRADO: Logs infinitos sem rotação
docker run -d myapp
# Logs crescem indefinidamente, disco enche

✅ CORRETO: Configurar rotação de logs
docker run -d \
  --log-opt max-size=10m \
  --log-opt max-file=3 \
  myapp
# Logs rotacionados, espaço controlado
```

---

## 15. Docker Hub & Private Registries

### Docker Hub

```bash
# Login no Docker Hub
docker login

# Push para Docker Hub
docker tag myapp:latest myuser/myapp:latest
docker push myuser/myapp:latest

# Pull
docker pull myuser/myapp:latest

# Buscar imagens
docker search nginx

# Criar organization
# Via Docker Hub web interface
```

### Private Registry

```bash
# Rodar registry privado
docker run -d -p 5000:5000 \
  -v registry-data:/var/lib/registry \
  registry:2

# Push para registry privado
docker tag myapp:latest localhost:5000/myapp:v1
docker push localhost:5000/myapp:v1

# Com autenticação
docker run -d -p 5000:5000 \
  -v auth:/auth \
  -v certs:/certs \
  -e REGISTRY_AUTH=htpasswd \
  -e REGISTRY_AUTH_HTPASSWD_REALM="Registry Realm" \
  -e REGISTRY_AUTH_HTPASSWD_PATH=/auth/htpasswd \
  -e REGISTRY_HTTP_TLS_CERTIFICATE=/certs/domain.crt \
  -e REGISTRY_HTTP_TLS_KEY=/certs/domain.key \
  registry:2

# Login no registry privado
docker login myregistry.com:5000
```

### MELHORIA

```
❌ ERRADO: Não usar registry para produção
docker save myapp:latest -o myapp.tar
# Transferir manualmente entre máquinas

✅ CORRETO: Usar registry privado
docker push myregistry.com/myapp:1.0
# Versionamento, acesso controlado, distribuição fácil
```

---

## 16. Docker Init

### Scaffolding de Projetos

```bash
# Criar novo projeto com Docker Init
docker init

# O que é gerado:
# - Dockerfile
# - docker-compose.yml
# - .dockerignore
# - README.docker.md

# Suporta:
# - Node.js
# - Python
# - Go
# - Rust
# - Java
# - ASP.NET
# - PHP
```

### Docker Init Interativo

```bash
# Criar projeto Node.js
mkdir my-app && cd my-app
docker init

# Responder perguntas:
# What language do you want to use? -> Node
# What version of Node do you want? -> 20
# What port does your server listen on? -> 3000
# What command do you use to start the app? -> npm start
```

### MELHORIA

```
❌ ERRADO: Escrever Dockerfile do zero sem padrão
# Erros comuns, configurações inseguras

✅ CORRETO: Usar docker init como ponto de partida
docker init
# Dockerfile otimizado, seguro e seguindo best practices
# Depois personalizar conforme necessidade
```

---

## 17. Multi-Platform Builds

### Build para Múltiplas Arquiteturas

```bash
# Criar builder multi-plataforma
docker buildx create \
  --name multiplatform \
  --driver docker-container \
  --use

# Ver builders disponíveis
docker buildx ls

# Build multi-plataforma
docker buildx build \
  --platform linux/amd64,linux/arm64,linux/arm/v7 \
  -t myapp:latest \
  --push .

# Build e output local
docker buildx build \
  --platform linux/amd64 \
  -t myapp:latest \
  --output type=docker .
```

### Dockerfile Multi-Platform

```dockerfile
FROM --platform=$BUILDPLATFORM node:20-alpine AS builder

ARG TARGETPLATFORM
ARG TARGETOS
ARG TARGETARCH

WORKDIR /app
COPY package*.json ./
RUN npm ci

COPY . .
RUN npm run build

# Runtime
FROM node:20-alpine

WORKDIR /app
COPY --from=builder /app/dist ./dist

EXPOSE 3000
CMD ["node", "dist/index.js"]
```

### MELHORIA

```
❌ ERRADO: Build apenas para uma arquitetura
docker build -t myapp:amd64 .
# Não roda em ARM (Apple Silicon, Raspberry Pi)

✅ CORRETO: Build multi-plataforma
docker buildx build \
  --platform linux/amd64,linux/arm64 \
  -t myapp:latest --push .
# Compatível com todas as arquiteturas
```

---

## 18. Container Security Hardening

### Práticas de Segurança

```dockerfile
# Usar usuário não-root
FROM node:20-alpine
RUN addgroup -g 1001 -S appgroup && \
    adduser -S appuser -u 1001 -G appgroup
WORKDIR /app
COPY --chown=appuser:appgroup . .
USER appuser

# Usar apenas leitura
FROM nginx:alpine
COPY nginx.conf /etc/nginx/nginx.conf
VOLUME /var/cache/nginx /var/run

# Não instalar pacotes desnecessários
FROM python:3.11-slim
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
```

### Security Scanning e Best Practices

```bash
# Scan de imagem
docker scout cves --only-severity critical myapp:latest

# Verificar se roda como root
docker run --rm myapp whoami  # deve ser appuser

# Usar secrets em vez de variáveis
docker run --secret db_pass myapp

# Verificar permissões
docker run --rm myapp ls -la /app

# Usar AppArmor
docker run --security-opt apparmor=docker-default myapp

# Usar Seccomp
docker run --security-opt seccomp=profile.json myapp
```

### MELHORIA

```
❌ ERRADO: Rodar container como root
FROM node:20
COPY . .
RUN npm install
CMD ["node", "server.js"]
# Vulnerabilidade: container como root

✅ CORRETO: Usar usuário não-root
FROM node:20-alpine
RUN addgroup -g 1001 app && adduser -S -G app app
WORKDIR /app
COPY --chown=app:app . .
USER app
CMD ["node", "server.js"]
```

---

## 19. Debugging Containers

### Diagnóstico de Containers

```bash
# Ver logs de container parado
docker logs myapp

# Executar shell no container
docker exec -it myapp sh

# Ver processos
docker top myapp

# Ver uso de recursos
docker stats myapp

# Ver mudanças no filesystem
docker diff myapp

# Inspect detalhado
docker inspect myapp

# Ver portas
docker port myapp

# Copiar arquivos para fora
docker cp myapp:/app/logs ./logs

# Copiar arquivos para dentro
docker cp ./debug.sh myapp:/tmp/debug.sh
```

### Debugging com Docker Compose

```bash
# Ver logs de todos serviços
docker compose logs

# Logs de serviço específico
docker compose logs -f api

# Executar em container específico
docker compose exec api sh

# Verificar status
docker compose ps

# Verificar variáveis de ambiente
docker compose exec api env

# Verificar conectividade
docker compose exec api ping db
```

### MELHORIA

```
❌ ERRADO: Remover container para debug
docker rm myapp
docker run ... # Novo container sem dados do problema

✅ CORRETO: Debug in-loco
docker exec -it myapp sh
# Inspecionar logs, configurações, estado atual
# Depois decidir se precisa recriar
```

---

## 20. Docker Compose Profiles

### Profiles para Diferentes Ambientes

```yaml
services:
  web:
    image: nginx
    ports:
      - "80:80"

  api:
    build: ./api
    profiles:
      - development
      - production

  debug:
    image: busybox
    profiles:
      - debug

  test:
    build: ./test
    profiles:
      - test
```

### Uso de Profiles

```bash
# Iniciar apenas web (padrão)
docker compose up

# Iniciar com development profile
docker compose --profile development up

# Iniciar com múltiplos profiles
docker compose --profile development --profile debug up

# Iniciar todos
docker compose --profile '*' up
```

### MELHORIA

```
❌ ERRADO: Ter múltiplos docker-compose files
docker-compose.yml
docker-compose.dev.yml
docker-compose.prod.yml
# Duplicação, difícil manutenção

✅ CORRETO: Usar profiles
docker compose --profile development up -d
# Um único arquivo, profiles para necessidades
```

---

## 📚 Referências

- [Docker Documentation](https://docs.docker.com/)
- [Dockerfile Reference](https://docs.docker.com/engine/reference/builder/)
- [Docker Compose](https://docs.docker.com/compose/)
- [Docker BuildKit](https://docs.docker.com/build/buildkit/)
- [Docker Scout](https://docs.docker.com/scout/)
- [Docker CLI Reference](https://docs.docker.com/reference/cli/docker/)
- [Docker Best Practices](https://docs.docker.com/develop/develop-images/dockerfile_best-practices/)

---

> **Total de Skills:** 20 categorias avançadas
> **Nível:** Intermediário a Avançado
> **Última atualização:** 2026
