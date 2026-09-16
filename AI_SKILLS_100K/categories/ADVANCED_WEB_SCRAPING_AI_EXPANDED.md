# 🗺️ Google Maps Scraper Kit - AI-Driven Scraping (Skills)

> **Fonte: https://github.com/Mahanaicoach/google-maps-scraper-kit**
> **Skills extraídas e aprimoradas para o knowledge base**

---

## 📋 Visão Geral

**Google Maps Scraper Kit** é um kit plug-and-play que roda um scraper local de Google Maps e permite que Claude o dirija automaticamente. Fornece dados limpos de negócios: nome, endereço, telefone, website, rating, reviews.

---

## 🔧 Skills de Web Scraping

### 1. Arquitetura de Scraper Local

```python
# SKILL: Web Scraping com Docker Local
# Nível: Intermediário → Expert
# Contexto: Scraping automatizado de Google Maps

# COMPONENTES:
# 1. Docker Container: isolamento do scraper
# 2. API Local: interface HTTP
# 3. Claude Skill: integração com IA
# 4. Scripts Standalone: bash e Python
# 5. Rate Limiting: proteção contra blocks

# VANTAGENS:
# - Execução local (sem nuvem)
# - Controle total sobre dados
# - Sem custos de API
# - Privacidade garantida
# - Personalização completa

# MELHORIA:
// ERRADO: Usar APIs pagas ou serviços externos
// CORRECT: Scraper local com controle total
```

### 2. Docker Setup

```yaml
# SKILL: Configuração Docker para Scraping
# Nível: Intermediário → Expert
# Contexto: Containerização de scraper

# docker-compose.yml
version: '3.8'
services:
  scraper:
    image: gosom/google-maps-scraper
    ports:
      - "127.0.0.1:8080:8080"
    volumes:
      - ./data:/data
    environment:
      - GOMAP_API_KEY=your_key
    restart: unless-stopped

# COMANDOS:
# Iniciar: docker compose up -d
# Parar: docker compose down
# Logs: docker compose logs -f
# Status: docker compose ps

# MELHORIA:
// ERRADO: Instalação manual de dependências
// CORRECT: Docker Compose para setup limpo
```

### 3. API Local para Scraping

```python
# SKILL: API HTTP para Controle de Scraping
# Nível: Intermediário → Expert
# Contexto: Interface REST para scraper

# ENDPOINTS:
# GET  /api/v1/jobs          → Listar jobs
# POST /api/v1/jobs          → Criar job
# GET  /api/v1/jobs/:id      → Status do job
# DELETE /api/v1/jobs/:id    → Deletar job
# GET  /api/v1/results/:id   → Resultados

# EXEMPLO DE JOB:
{
  "query": "coffee shops in Austin TX",
  "lat": 30.2672,
  "lng": -97.7431,
  "depth": 5,
  "zoom": 14
}

# MELHORIA:
// ERRADO: Scripts soltos sem API
// CORRECT: API REST para gerenciamento
```

### 4. Claude Integration

```python
# SKILL: Integração com Claude para Automação
# Nível: Expert
# Contexto: IA dirigindo scraping

# SLASH COMMANDS:
# /scrape <business> in <city, ST> [depth]
# /scrape-batch <keywords-file> [--city "City, ST"]
# /scrape-setup
# /scrape-jobs [list | delete <id>]

# AUTO-TRIGGER PHRASES:
# - "scrape coffee shops in Austin"
# - "find all gyms in Miami with phone numbers"
# - "build me a lead list of dentists in Denver"
# - "pull Google Maps listings for plumbers in Phoenix"

# WORKFLOW CLAUDE:
# 1. Usuário descreve necessidade
# 2. Claude cria job via API
# 3. Monitora progresso
# 4. Faz download dos resultados
# 5. Limpa e formata dados
# 6. Apresenta ao usuário

# MELHORIA:
// ERRADO: Scraping manual
// CORRECT: IA dirigindo todo o processo
```

### 5. Rate Limiting e Proteção

```python
# SKILL: Proteção contra Rate Limiting
# Nível: Expert
# Contexto: Evitar bloqueio pelo Google

# REGRAS:
# 1. Um job por vez
# 2. Depth inicial: 5
# 3. Pausas entre jobs
# 4. Proxies para jobs grandes
# 5. Monitorar sinais de block

# SINAIS DE BLOCK:
# - Jobs retornando "failed"
# - Resultados vazios
# - Menos resultados que o esperado

# PROTEÇÕES:
# - Rate limiting automático
# - Rotação de IPs via proxies
# - Delays entre requests
# - User-Agent rotation
# - Cookie management

# MELHORIA:
// ERRADO: Scraping agressivo
// CORRECT: Scraping responsável com proteções
```

---

## 📊 Dados Coletados

### Campos Padrão
```json
{
  "name": "Nome do Negócio",
  "phone": "+1-555-123-4567",
  "email": "contact@business.com",
  "website": "https://business.com",
  "category": "Coffee Shop",
  "address": "123 Main St, Austin, TX",
  "rating": 4.5,
  "review_count": 128
}
```

### Campos Completos (--full)
```json
{
  "name": "Nome",
  "phone": "Telefone",
  "email": "Email",
  "website": "Website",
  "category": "Categoria",
  "address": "Endereço",
  "rating": 4.5,
  "review_count": 128,
  "lat": 30.2672,
  "lng": -97.7431,
  "place_id": "ChIJ...",
  "google_url": "https://maps.google.com/...",
  "opening_hours": {...},
  "images": [...],
  "reviews": [...]
}
```

### Extração de Socials (--socials)
```python
# Social Media Detection:
# - Instagram: @username ou instagram.com/username
# - Facebook: facebook.com/username
# - LinkedIn: linkedin.com/company/username

# Limitações:
# - Apenas sites que linkam redes sociais
# - Sem acesso direto ao Instagram/TikTok
# - Cobertura parcial
```

---

## 🚀 Workflows Avançados

### 1. Lead Generation
```bash
# Workflow completo de geração de leads:

# 1. Definir nicho e localização
# 2. Executar scraping
./scripts/scrape.sh "dentists in Miami FL" 25.7617 -80.1918 10

# 3. Limpar dados
python3 scripts/scrape.py --clean results.json

# 4. Adicionar socials
python3 scripts/scrape.py --socials results.json

# 5. Exportar para CRM
python3 scripts/scrape.py --export csv results.json
```

### 2. Análise de Mercado
```python
# SKILL: Análise de Mercado via Google Maps
# Nível: Intermediário → Expert
# Contexto: Dados para tomada de decisão

# MÉTRICAS CALCULÁVEIS:
# 1. Densidade de negócios por região
# 2. Rating médio por categoria
# 3. Distribuição de reviews
# 4. Horários de funcionamento
# 5. Concentração geográfica

# APLICAÇÕES:
# - Expansão de negócios
# - Análise de concorrência
# - Identificação de oportunidades
# - Planejamento de marketing
# - Validação de ideias

# MELHORIA:
// ERRADO: Dados brutos sem análise
// CORRECT: Insights acionáveis dos dados
```

### 3. Outreach Automatizado
```python
# SKILL: Automação de Outreach
# Nível: Expert
# Contexto: Contato automatizado com leads

# WORKFLOW:
# 1. Scraping de negócios
# 2. Filtragem por critérios
# 3. Personalização de mensagens
# 4. Envio via email/WhatsApp
# 5. Follow-up automático
# 6. Tracking de respostas

# FERRAMENTAS INTEGRADAS:
# - Email: SMTP/IMAP
# - WhatsApp: API Business
# - CRM: integração via API
# - Analytics: tracking de aberturas

# MELHORIA:
// ERRADO: Outreach manual
// CORRECT: Automação completa com tracking
```

---

## 🔒 Segurança e Ética

### Responsabilidade
```
1. LEIS: Respeitar GDPR/CCPA
2. ToS: Google Terms of Service
3. Privacidade: dados pessoais
4. Consentimento: quando aplicável
5. Uso: finalidades legítimas

# AVISO LEGAL:
"Scraping Maps é contra os ToS do Google — use responsavelmente
e siga a lei de dados (GDPR/CCPA) para qualquer dado de contato."
```

### Proteção de Dados
```
# Dados pessoais coletados:
# - Telefones
# - Emails
# - Endereços

# Obrigações:
# - Não revender dados brutos
# - Obter consentimento quando necessário
# - Permitir opt-out
# - Segurar dados adequadamente
# - Respeitar direitos dos titulares
```

---

## 📈 Métricas de Performance

| Métrica | Valor |
|---------|-------|
| Velocidade | ~120 places/min |
| Profundidade padrão | 5 |
| Máximo por job | 1000+ |
| Formatos de saída | JSON, CSV |
| Campos padrão | 8 |
| Campos completos | 34 |
| Socials | Instagram, Facebook, LinkedIn |
| Precisão | 95%+ |

---

## 🛠️ Scripts Disponíveis

### scrape.sh (Bash)
```bash
# Uso básico:
./scripts/scrape.sh "coffee shops in Austin TX" 30.2672 -97.7431 5

# Parâmetros:
# 1. Query de busca
# 2. Latitude
# 3. Longitude
# 4. Depth (profundidade)
```

### scrape.py (Python)
```python
# Uso básico:
python3 scripts/scrape.py "gyms in Miami" 25.7617 -80.1918 10

# Opções:
# --full          Todos os campos
# --socials       Adicionar redes sociais
# --export csv    Exportar para CSV
# --clean         Limpar dados
# --proxy socks5://user:pass@host:port  Usar proxy
```

---

## 🎓 Aplicações por Setor

### Marketing Digital
```
- Lead generation
- Análise de concorrência
- Planejamento de campanhas
- Identificação de influencers
```

### Vendas
```
- Prospecção de clientes
- Qualificação de leads
- Territory mapping
- Pipeline building
```

### Consultoria
```
- Análise de mercado
- Due diligence
- Business intelligence
- Market research
```

### Startups
```
- Validação de ideias
- Identificação de parceiros
- Análise de TAM
- Competitor analysis
```

---

*Google Maps Scraper Kit Skills v1.0 — Setembro 2026*
*Fonte: https://github.com/Mahanaicoach/google-maps-scraper-kit*