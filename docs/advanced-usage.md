# 📚 Guia de Uso Avançado

Este guia cobre tópicos avançados de uso do **OpenCode Skills Knowledge Base** para desenvolvedores experientes e usuários avançados.

## 📋 Índice

- [Visão Geral](#visão-geral)
- [Combinação de Skills](#combinação-de-skills)
- [Criação de Workflows](#criação-de-workflows)
- [Integração com Projetos](#integração-com-projetos)
- [Automação](#automação)
- [Personalização](#personalização)
- [Otimização](#otimização)
- [Escalabilidade](#escalabilidade)

---

## Visão Geral

O uso avançado do **OpenCode Skills Knowledge Base** envolve:

1. **Combinar múltiplas skills** para resolver problemas complexos
2. **Criar workflows** personalizados
3. **Integrar com projetos** existentes
4. **Automatizar tarefas** repetitivas
5. **Personalizar** a base para suas necessidades
6. **Otimizar** performance e produtividade
7. **Escalar** para equipes e organizações

---

## Combinação de Skills

### Padrões de Combinação

#### 1. Stack Completa

```bash
# Frontend
skill react-patterns
skill nextjs-best-practices
skill tailwind-patterns

# Backend
skill fastapi-router-py
skill api-designer
skill api-security-best-practices

# Database
skill postgresql
skill redis-caching

# DevOps
skill docker-expert
skill kubernetes-architect
skill github-actions-advanced
```

#### 2. AI/ML Stack

```bash
# Frameworks
skill langchain
skill hugging-face
skill pytorch

# Agentes
skill ai-agents
skill agent-orchestration

# Dados
skill data-pipeline
skill feature-store

# Deploy
skill mlops-pipeline
skill model-serving
```

#### 3. Segurança Completa

```bash
# Desenvolvimento Seguro
skill secure-coding
skill backend-security-coder
skill api-security-best-practices

# Testes
skill penetration-testing
skill security-audit

# Compliance
skill owasp-top-10
skill pci-dss
skill gdpr-compliance

# Resposta a Incidentes
skill incident-response
skill forensic-analysis
```

### Mapeamento de Dependências

```yaml
# Exemplo: Dependências entre skills
react-patterns:
  depends_on:
    - javascript-fundamentals
    - typescript-basics
  related:
    - nextjs-best-practices
    - tailwind-patterns
    - zustand-store-ts

docker-expert:
  depends_on:
    - linux-basics
    - networking-fundamentals
  related:
    - kubernetes-architect
    - github-actions-advanced
    - terraform-specialist
```

---

## Criação de Workflows

### Workflow: Desenvolvimento Fullstack

```yaml
# .opencode/workflows/fullstack.yaml
name: Fullstack Development
description: Workflow completo para desenvolvimento fullstack

stages:
  - name: Setup
    skills:
      - project-scaffolding
      - git-configuration
      - eslint-prettier-setup
    commands:
      - npm init -y
      - git init
      - npm install --save-dev eslint prettier

  - name: Frontend
    skills:
      - react-patterns
      - nextjs-best-practices
      - tailwind-patterns
    commands:
      - npx create-next-app frontend
      - cd frontend && npm install tailwindcss

  - name: Backend
    skills:
      - fastapi-router-py
      - api-designer
      - api-security-best-practices
    commands:
      - mkdir backend && cd backend
      - python -m venv venv
      - pip install fastapi uvicorn

  - name: Database
    skills:
      - postgresql
      - redis-caching
    commands:
      - docker run -d -p 5432:5432 postgres
      - docker run -d -p 6379:6379 redis

  - name: DevOps
    skills:
      - docker-expert
      - github-actions-advanced
    commands:
      - docker compose up -d
      - git add . && git commit -m "Initial setup"

  - name: Testing
    skills:
      - pytest-skill
      - cypress-skill
      - tdd-orchestrator
    commands:
      - pytest
      - cypress run

  - name: Deployment
    skills:
      - kubernetes-architect
      - terraform-specialist
    commands:
      - kubectl apply -f k8s/
      - terraform apply
```

### Workflow: AI/ML Pipeline

```yaml
# .opencode/workflows/ai-ml.yaml
name: AI/ML Pipeline
description: Pipeline completo para projetos de AI/ML

stages:
  - name: Data Collection
    skills:
      - web-scraping
      - api-integration
      - data-pipeline
    commands:
      - python collect_data.py
      - python process_data.py

  - name: Feature Engineering
    skills:
      - feature-store
      - data-transformation
    commands:
      - python feature_engineering.py
      - python validate_features.py

  - name: Model Training
    skills:
      - pytorch
      - hugging-face
      - hyperparameter-tuning
    commands:
      - python train.py
      - python evaluate.py

  - name: Model Serving
    skills:
      - model-serving
      - api-designer
    commands:
      - python serve.py
      - curl http://localhost:8000/predict

  - name: Monitoring
    skills:
      - model-monitoring
      - observability
    commands:
      - python monitor.py
      - grafana-server
```

---

## Integração com Projetos

### Estrutura de Projeto Recomendada

```
meu-projeto/
├── .opencode/
│   ├── config.yaml
│   ├── workflows/
│   └── skills/
├── src/
│   ├── frontend/
│   ├── backend/
│   └── shared/
├── docs/
├── tests/
├── scripts/
└── README.md
```

### Configuração do Projeto

```yaml
# .opencode/config.yaml
project:
  name: meu-projeto
  version: 1.0.0
  description: Descrição do projeto

skills:
  enabled:
    - react-patterns
    - nextjs-best-practices
    - fastapi-router-py
    - docker-expert
    - github-actions-advanced

  disabled:
    - legacy-skills

  custom:
    - path: ./skills/custom-skill
      name: my-custom-skill

workflows:
  - name: development
    file: .opencode/workflows/dev.yaml
  - name: deployment
    file: .opencode/workflows/deploy.yaml

integrations:
  - name: github
    token: ${GITHUB_TOKEN}
  - name: slack
    webhook: ${SLACK_WEBHOOK}
```

### Uso em Scripts

```bash
#!/bin/bash
# scripts/deploy.sh

# Carregar skills
skill docker-expert
skill kubernetes-architect

# Build
docker build -t myapp:latest .

# Deploy
kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/service.yaml

# Verificar
kubectl get pods
kubectl get services
```

---

## Automação

### Scripts de Automação

#### Setup Inicial

```bash
#!/bin/bash
# scripts/setup.sh

echo "🚀 Configurando projeto..."

# Git
git init
git remote add origin https://github.com/user/repo.git

# Frontend
cd frontend
npx create-next-app .
npm install tailwindcss @tailwindcss/postcss postcss
npm install zustand

# Backend
cd ../backend
python -m venv venv
source venv/bin/activate
pip install fastapi uvicorn sqlalchemy

# Docker
docker compose up -d

echo "✅ Projeto configurado!"
```

#### Deploy Automatizado

```bash
#!/bin/bash
# scripts/deploy.sh

set -e

echo "🚀 Iniciando deploy..."

# Testes
echo "🧪 Executando testes..."
pytest
npm test

# Build
echo "🔨 Fazendo build..."
docker build -t myapp:latest .
docker push myapp:latest

# Deploy
echo "📦 Fazendo deploy..."
kubectl apply -f k8s/

# Verificação
echo "🔍 Verificando deploy..."
kubectl rollout status deployment/myapp

echo "✅ Deploy concluído!"
```

### GitHub Actions

```yaml
# .github/workflows/ci.yaml
name: CI/CD

on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Setup Node.js
        uses: actions/setup-node@v3
        with:
          node-version: '18'
      - name: Install dependencies
        run: npm ci
      - name: Run tests
        run: npm test

  deploy:
    needs: test
    runs-on: ubuntu-latest
    if: github.ref == 'refs/heads/main'
    steps:
      - uses: actions/checkout@v3
      - name: Deploy to production
        run: |
          kubectl apply -f k8s/
          kubectl rollout status deployment/myapp
```

---

## Personalização

### Criando Skills Personalizadas

```markdown
# minha-skill-personalizada

**Descrição:** Skill personalizada para meu projeto

**Quando usar:**
- Quando preciso de...
- Para projetos que...

**Exemplos práticos:**
```código
# Meu código personalizado
```

**Casos de uso avançados:**
- Projeto específico 1
- Projeto específico 2

**Integração com outras skills:**
- skill1: para complementar
- skill2: para integrar

**Padrões e anti-padrões:**
✅ Fazer: Minha prática recomendada
❌ Evitar: Meu anti-pattern

**Dicas de performance:**
- Minha dica 1
- Minha dica 2

**Comandos úteis:**
```bash
# Meus comandos
```

**Referências:**
- [Minha Referência](url)
```

### Configurações Personalizadas

```yaml
# .opencode/personal.yaml
preferences:
  language: pt-BR
  theme: dark
  editor: vscode

skills:
  auto_load: true
  cache: true
  parallel: true

workflows:
  auto_detect: true
  custom_path: .opencode/workflows

integrations:
  auto_sync: true
  notifications: true
```

---

## Otimização

### Performance

#### 1. Cache de Skills

```bash
# Habilitar cache
export OPENCODE_CACHE=true
export OPENCODE_CACHE_TTL=3600

# Limpar cache
opencode cache clear
```

#### 2. Carregamento Paralelo

```yaml
# .opencode/config.yaml
performance:
  parallel_loading: true
  max_concurrent: 5
  lazy_load: true
```

#### 3. Otimização de Memória

```bash
# Monitorar uso de memória
opencode stats

# Limitar memória
export OPENCODE_MAX_MEMORY=1024
```

### Produtividade

#### 1. Atalhos de Teclado

```json
// .opencode/keybindings.json
{
  "skill.load": "Ctrl+Shift+S",
  "skill.search": "Ctrl+Shift+F",
  "workflow.run": "Ctrl+Shift+W",
  "help.open": "F1"
}
```

#### 2. Autocompletar

```yaml
# .opencode/autocomplete.yaml
autocomplete:
  enabled: true
  trigger: "."
  skills:
    - react-patterns
    - nextjs-best-practices
```

#### 3. Snippets

```yaml
# .opencode/snippets.yaml
snippets:
  - name: react-component
    prefix: rfc
    body: |
      import React from 'react';
      
      interface Props {}
      
      export const Component: React.FC<Props> = () => {
        return <div></div>;
      };
```

---

## Escalabilidade

### Para Equipes

#### 1. Compartilhamento de Configurações

```yaml
# .opencode/team.yaml
team:
  name: minha-equipe
  size: 5

shared:
  skills:
    - react-patterns
    - fastapi-router-py
    - docker-expert
  
  workflows:
    - development
    - deployment
  
  configurations:
    - eslint
    - prettier
    - typescript
```

#### 2. Roles e Permissões

```yaml
# .opencode/permissions.yaml
roles:
  admin:
    - manage_skills
    - manage_workflows
    - manage_integrations
  
  developer:
    - use_skills
    - run_workflows
    - view_integrations
  
  viewer:
    - view_skills
    - view_workflows
```

#### 3. Auditoria

```yaml
# .opencode/audit.yaml
audit:
  enabled: true
  log_file: .opencode/audit.log
  retention: 90d
  
events:
  - skill_loaded
  - workflow_executed
  - configuration_changed
```

### Para Organizações

#### 1. Multi-tenant

```yaml
# .opencode/multi-tenant.yaml
tenants:
  - name: empresa-a
    skills: [react-patterns, nextjs-best-practices]
    workflows: [development, deployment]
  
  - name: empresa-b
    skills: [vue-patterns, nuxt-best-practices]
    workflows: [development, deployment]
```

#### 2. Governança

```yaml
# .opencode/governance.yaml
governance:
  policies:
    - name: security
      rules:
        - require_api_security
        - require_input_validation
        - require_logging
  
  compliance:
    - owasp-top-10
    - pci-dss
    - gdpr
```

#### 3. Métricas

```yaml
# .opencode/metrics.yaml
metrics:
  enabled: true
  export: prometheus
  
  tracks:
    - skill_usage
    - workflow_performance
    - team_productivity
```

---

## 🔍 Solução de Problemas Avançados

### Problema: Conflitos entre Skills

**Solução:**
1. Verifique dependências
2. Use versões específicas
3. Configure isolamento
4. Use containers

### Problema: Performance Lenta

**Solução:**
1. Habilite cache
2. Use carregamento paralelo
3. Otimize configurações
4. Monitore recursos

### Problema: Integração Complexa

**Solução:**
1. Use APIs padronizadas
2. Implemente retry logic
3. Configure timeouts
4. Use circuit breakers

---

## 📞 Suporte Avançado

### Documentação

- [README.md](../README.md) - Documentação principal
- [CONTRIBUTING.md](../CONTRIBUTING.md) - Guia de contribuição
- [CHANGELOG.md](../CHANGELOG.md) - Histórico de versões

### Comunidade

- **GitHub Issues**: Para bugs e sugestões
- **GitHub Discussions**: Para dúvidas avançadas
- **Stack Overflow**: Tag `opencode-skills`

### Contato

- **Autor**: Passos Nikolas
- **GitHub**: [@passosnikolas5-coder](https://github.com/passosnikolas5-coder)

---

*Guia atualizado em: Setembro 2026*
*Versão: 2.0*