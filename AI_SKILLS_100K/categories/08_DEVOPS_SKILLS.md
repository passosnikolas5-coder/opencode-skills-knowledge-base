# 🔄 DevOps & SRE Skills - 5.000 Skills

> **Todas as habilidades de DevOps e SRE documentadas**

---

## 📊 Visão Geral

| Subcategoria | Skills | Nível |
|--------------|--------|-------|
| CI/CD Pipelines | 800 | Intermediário → Expert |
| Container Orchestration | 700 | Intermediário → Expert |
| Infrastructure as Code | 600 | Intermediário → Expert |
| Monitoring & Observability | 500 | Intermediário → Expert |
| Incident Management | 400 | Intermediário → Expert |
| Automation | 500 | Intermediário → Expert |
| Cloud Operations | 500 | Intermediário → Expert |
| Security Operations | 400 | Avançado → Expert |
| Reliability Engineering | 300 | Avançado → Expert |
| Cost Optimization | 300 | Intermediário → Expert |

---

## 🚀 CI/CD Pipelines (800)

### Pipeline Design (300)

#### DEVOPS001: Pipeline Architecture
```lua
-- SKILL: Pipeline Architecture
-- Nível: Intermediário → Expert
-- Contexto: Design de pipelines CI/CD

-- STAGES:
-- 1. Source: code checkout, lint
-- 2. Build: compile, bundle, docker
-- 3. Test: unit, integration, e2e
-- 4. Security: SAST, SCA, DAST
-- 5. Deploy: staging, production
-- 6. Monitor: health checks, rollback

-- PATTERNS:
-- - Trunk-based development
-- - GitFlow
-- - Feature flags
-- - Blue-green deployment
-- - Canary releases
-- - Rolling updates

-- MELHORIA:
-- ERRADO: Manual deployments
-- CERTO: Automated pipeline with gates
```

### GitHub Actions (200)

#### DEVOPS002: GitHub Actions Advanced
```lua
-- SKILL: GitHub Actions Advanced
-- Nível: Intermediário → Expert
-- Contexto: CI/CD no GitHub

-- CONCEITOS:
-- 1. Reusable Workflows: workflow_call
-- 2. Composite Actions: shared steps
-- 3. Environments: protection rules
-- 4. Matrix Builds: multiple OS/versions
-- 5. Caching: actions/cache
-- 6. Self-hosted Runners: custom hardware

-- MELHORIA:
-- ERRADO: Duplicated workflows
-- CERTO: Reusable workflows + composite actions
```

### GitLab CI (150)

#### DEVOPS003: GitLab CI Advanced
```lua
-- SKILL: GitLab CI Advanced
-- Nível: Intermediário → Expert
-- Contexto: CI/CD no GitLab

-- CONCEITOS:
-- 1. Child Pipelines: parallel execution
-- 2. Includes: template reuse
-- 3. Rules: conditional jobs
-- 4. DAG: directed acyclic graph
-- 5. Components: reusable CI components
```

### ArgoCD (150)

#### DEVOPS004: ArgoCD GitOps
```lua
-- SKILL: ArgoCD GitOps
-- Nível: Intermediário → Expert
-- Contexto: GitOps com ArgoCD

-- CONCEITOS:
-- 1. Applications: sync status
-- 2. App of Apps: hierarchical
-- 3. Sync Waves: ordering
-- 4. Health Checks: custom
-- 5. Multi-cluster: management
```

---

## 🐳 Container Orchestration (700)

### Docker Advanced (300)

#### DEVOPS005: Docker Advanced
```lua
-- SKILL: Docker Advanced Patterns
-- Nível: Intermediário → Expert
-- Contexto: Docker avançado

-- PADRÕES:
-- 1. Multi-stage Builds: smaller images
-- 2. BuildKit: caching, secrets
-- 3. Multi-platform: buildx
-- 4. Health Checks: container monitoring
-- 5. Resource Limits: memory, CPU
-- 6. Security Scanning: trivy, snyk

-- MELHORIA:
-- ERRADO: Running as root
-- CERTO: Non-root + read-only + resource limits
```

### Kubernetes Production (400)

#### DEVOPS006: Kubernetes Production
```lua
-- SKILL: Kubernetes Production
-- Nível: Avançado → Expert
-- Contexto: K8s em produção

-- CONCEITOS:
-- 1. Resource Management: requests, limits
-- 2. Pod Disruption Budgets: availability
-- 3. Horizontal Pod Autoscaler: scaling
-- 4. Network Policies: security
-- 5. Service Mesh: Istio, Linkerd
-- 6. Operators: custom resources
-- 7. GitOps: ArgoCD, Flux
-- 8. Multi-tenancy: namespaces, quotas

-- BEST PRACTICES:
-- - RBAC for access control
-- - Network policies
-- - Pod security standards
-- - Monitoring with Prometheus
-- - Logging with EFK stack
```

---

## 🏗️ Infrastructure as Code (600)

### Terraform Advanced (300)

#### DEVOPS007: Terraform Advanced
```lua
-- SKILL: Terraform Advanced Patterns
-- Nível: Avançado → Expert
-- Contexto: IaC avançado

-- PADRÕES:
-- 1. Workspaces: environment separation
-- 2. Modules: reusable components
-- 3. State Management: remote, locking
-- 4. Policy as Code: Sentinel, OPA
-- 5. Multi-cloud: provider aliases
-- 6. Testing: terratest

-- MELHORIA:
-- ERRADO: Manual infrastructure
-- CERTO: Terraform + GitOps + policy enforcement
```

### Pulumi (150)

#### DEVOPS008: Pulumi IaC
```lua
-- SKILL: Pulumi Infrastructure as Code
-- Nível: Intermediário → Expert
-- Contexto: IaC com linguagens reais

-- CONCEITOS:
-- 1. Languages: TypeScript, Python, Go, C#
-- 2. State: Pulumi Cloud, S3, local
-- 3. Components: reusable abstractions
-- 4. Policies: CrossGuard
-- 5. Automation API: programmatic

-- VANTAGENS:
-- - Real programming languages
-- - IDE support
-- - Testing frameworks
-- - Package managers
```

### Ansible (150)

#### DEVOPS009: Ansible Automation
```lua
-- SKILL: Ansible Automation
-- Nível: Intermediário → Expert
-- Contexto: Automação de configuração

-- CONCEITOS:
-- 1. Playbooks: YAML-based
-- 2. Roles: reusable components
-- 3. Inventory: static, dynamic
-- 4. Modules: thousands available
-- 5. Vault: secrets management
-- 6. AWX/Tower: web UI, API

-- MELHORIA:
-- ERRADO: Shell scripts manuais
-- CERTO: Ansible playbooks + roles
```

---

## 📊 Monitoring & Observability (500)

### Prometheus Stack (200)

#### DEVOPS010: Prometheus Stack
```lua
-- SKILL: Prometheus Monitoring Stack
-- Nível: Intermediário → Expert
-- Contexto: Monitoramento completo

-- COMPONENTES:
-- 1. Prometheus: metrics collection
-- 2. Alertmanager: alert routing
-- 3. Grafana: visualization
-- 4. Loki: log aggregation
-- 5. Tempo: distributed tracing

-- BEST PRACTICES:
-- - Use recording rules
-- - Proper alert routing
-- - Dashboard organization
-- - Retention policies
```

### ELK Stack (150)

#### DEVOPS011: ELK Stack
```lua
-- SKILL: ELK Stack
-- Nível: Intermediário → Expert
-- Contexto: Log management

-- COMPONENTES:
-- 1. Elasticsearch: search engine
-- 2. Logstash: log processing
-- 3. Kibana: visualization
-- 4. Beats: data shippers

-- ALTERNATIVAS:
-- - OpenSearch (AWS fork)
-- - Grafana Loki (lightweight)
-- - Datadog (SaaS)
```

### Distributed Tracing (150)

#### DEVOPS012: Distributed Tracing
```lua
-- SKILL: Distributed Tracing
-- Nível: Avançado → Expert
-- Contexto: Rastrear requisições

-- CONCEITOS:
-- 1. Traces: end-to-end requests
-- 2. Spans: individual operations
-- 3. Context Propagation: headers
-- 4. Sampling: head/tail-based

-- FERRAMENTAS:
-- - Jaeger
-- - Zipkin
-- - Tempo (Grafana)
-- - AWS X-Ray
-- - OpenTelemetry

-- MELHORIA:
-- ERRADO: Apenas logs
-- CERTO: Traces + Metrics + Logs (three pillars)
```

---

## 🚨 Incident Management (400)

### Detection (150)

#### DEVOPS013: Incident Detection
```lua
-- SKILL: Incident Detection
-- Nível: Intermediário → Expert
-- Contexto: Detectar incidentes

-- MÉTODAS:
-- 1. Alerting: threshold-based
-- 2. Anomaly Detection: ML-based
-- 3. SLO Burn Rate: error budgets
-- 4. Synthetic Monitoring: uptime
-- 5. Real User Monitoring: RUM

-- BEST PRACTICES:
-- - Define SLOs/SLIs
-- - Multi-channel alerts
-- - Alert grouping
-- - Escalation policies
```

### Response (150)

#### DEVOPS014: Incident Response
```lua
-- SKILL: Incident Response
-- Nível: Intermediário → Expert
-- Contexto: Responder a incidentes

-- PROCESSO:
-- 1. Detection: alert fires
-- 2. Triage: severity assessment
-- 3. Communication: status page
-- 4. Investigation: root cause
-- 5. Mitigation: immediate fix
-- 6. Resolution: permanent fix
-- 7. Post-mortem: learnings

-- FERRAMENTAS:
-- - PagerDuty
-- - Opsgenie
-- - VictorOps
-- - Statuspage
```

### Post-Mortem (100)

#### DEVOPS015: Post-Mortem Process
```lua
-- SKILL: Post-Mortem Process
-- Nível: Intermediário → Expert
-- Contexto: Análise pós-incidente

-- COMPONENTES:
-- 1. Timeline: what happened
-- 2. Impact: users affected
-- 3. Root Cause: why it happened
-- 4. Action Items: prevent recurrence
-- 5. Learnings: what we learned

-- BLAMELESS CULTURE:
-- - Focus on systems, not people
-- - Psychological safety
-- - Continuous improvement
```

---

## ⚙️ Automation (500)

### Scripting (200)

#### DEVOPS016: Automation Scripting
```lua
-- SKILL: Automation Scripting
-- Nível: Intermediário → Expert
-- Contexto: Automação com scripts

-- LINGUAGENS:
-- 1. Bash: Linux automation
-- 2. PowerShell: Windows automation
-- 3. Python: cross-platform
-- 4. Go: compiled, fast

-- PADRÕES:
-- - Error handling
-- - Logging
-- - Idempotency
-- - Testing
-- - Documentation
```

### ChatOps (150)

#### DEVOPS017: ChatOps
```lua
-- SKILL: ChatOps
-- Nível: Intermediário → Expert
-- Contexto: Automação via chat

-- FERRAMENTAS:
-- 1. Slack: integrations, workflows
-- 2. Microsoft Teams: bots
-- 3. Discord: webhooks
-- 4. GitHub ChatOps: commands

-- CASOS:
-- - Deploy triggers
-- - Status updates
-- - Alert acknowledgment
-- - Runbook execution
```

### Self-Service (150)

#### DEVOPS018: Developer Self-Service
```lua
-- SKILL: Developer Self-Service
-- Nível: Avançado → Expert
-- Contexto: Self-service para devs

-- PLATAFORMAS:
-- 1. Backstage: developer portal
-- 2. Port: internal developer platform
-- 3. Humanitec: platform orchestration
-- 4. Kratix: platform as a product

-- CAPACIDADES:
-- - Service catalog
-- - Template engine
-- - Scorecards
-- - TechDocs
```

---

## ☁️ Cloud Operations (500)

### Multi-Cloud (200)

#### DEVOPS019: Multi-Cloud Strategy
```lua
-- SKILL: Multi-Cloud Strategy
-- Nível: Avançado → Expert
-- Contexto: Operar em múltiplas clouds

-- CONCEITOS:
-- 1. Cloud Abstraction: Terraform, Pulumi
-- 2. Service Mesh: Istio, Consul
-- 3. Container Orchestration: Kubernetes
-- 4. Identity Federation: OIDC, SAML

-- MOTIVAÇÕES:
-- - Vendor lock-in avoidance
-- - Best of breed services
-- - Compliance requirements
-- - Disaster recovery
```

### FinOps (150)

#### DEVOPS020: FinOps
```lua
-- SKILL: FinOps
-- Nível: Intermediário → Expert
-- Contexto: Otimização de custos em cloud

-- PRINCÍPIOS:
-- 1. Inform: visibility, allocation
-- 2. Optimize: rightsizing, reserved
-- 3. Operate: automation, governance

-- FERRAMENTAS:
-- - AWS Cost Explorer
-- - Azure Cost Management
-- - GCP Cost Management
-- - Kubecost (Kubernetes)
-- - CloudHealth
```

### DR & Backup (150)

#### DEVOPS021: Disaster Recovery
```lua
-- SKILL: Disaster Recovery
-- Nível: Avançado → Expert
-- Contexto: Recuperação de desastres

-- ESTRATÉGIAS:
-- 1. Backup & Restore
-- 2. Pilot Light
-- 3. Warm Standby
-- 4. Multi-site Active-Active

-- RPO/RTO:
-- - RPO: Recovery Point Objective
-- - RTO: Recovery Time Objective
-- - Define based on business needs

-- MELHORIA:
-- ERRADO: Backup sem teste
-- CERTO: Regular DR drills + automated backup
```

---

## 🔐 Security Operations (400)

### DevSecOps (200)

#### DEVOPS022: DevSecOps
```lua
-- SKILL: DevSecOps
-- Nível: Avançado → Expert
-- Contexto: Segurança em DevOps

-- INTEGRAÇÃO:
-- 1. SAST: Static Analysis (SonarQube)
-- 2. SCA: Software Composition (Snyk)
-- 3. DAST: Dynamic Analysis (OWASP ZAP)
-- 4. Container Scanning (Trivy)
-- 5. IaC Scanning (Checkov, tfsec)
-- 6. Secret Scanning (GitLeaks)

-- MELHORIA:
-- ERRADO: Security como última etapa
-- CERTO: Security shift-left
```

### Secret Management (100)

#### DEVOPS023: Secret Management
```lua
-- SKILL: Secret Management
-- Nível: Intermediário → Expert
-- Contexto: Gerenciar segredos

-- FERRAMENTAS:
-- 1. HashiCorp Vault: enterprise
-- 2. AWS Secrets Manager: managed
-- 3. Azure Key Vault: managed
-- 4. Sealed Secrets: Kubernetes
-- 5. External Secrets: operator

-- BEST PRACTICES:
-- - Never in code/repos
-- - Rotation policies
-- - Audit logging
-- - Least privilege access
```

### Compliance Automation (100)

#### DEVOPS024: Compliance Automation
```lua
-- SKILL: Compliance Automation
-- Nível: Avançado → Expert
-- Contexto: Automação de compliance

-- FERRAMENTAS:
-- 1. Open Policy Agent (OPA)
-- 2. Sentinel (HashiCorp)
-- 3. Chef InSpec
-- 4. Prowler (AWS)
-- 5. ScoutSuite (multi-cloud)

-- PADRÕES:
-- - Policy as Code
-- - Automated remediation
-- - Continuous compliance
-- - Audit trails
```

---

## 📈 Reliability Engineering (300)

### SLO/SLI/SLA (150)

#### DEVOPS025: SLO Management
```lua
-- SKILL: SLO Management
-- Nível: Avançado → Expert
-- Contexto: Reliability engineering

-- CONCEITOS:
-- 1. SLI: Service Level Indicator
-- 2. SLO: Service Level Objective
-- 3. SLA: Service Level Agreement
-- 4. Error Budget: allowable failures

-- MÉTRICAS:
-- - Availability (uptime)
-- - Latency (p50, p95, p99)
-- - Throughput (requests/sec)
-- - Error rate

-- MELHORIA:
-- ERRADO: 100% uptime target
-- CERTO: Realistic SLOs + error budget
```

### Chaos Engineering (150)

#### DEVOPS026: Chaos Engineering
```lua
-- SKILL: Chaos Engineering
-- Nível: Avançado → Expert
-- Contexto: Testar resiliência

-- FERRAMENTAS:
-- 1. Chaos Monkey: Netflix
-- 2. Litmus: Kubernetes
-- 3. Gremlin: enterprise
-- 4. AWS Fault Injection Simulator

-- PROCESSO:
-- 1. Define steady state
-- 2. Hypothesize
-- 3. Inject failure
-- 4. Observe
-- 5. Learn
-- 6. Automate

-- MELHORIA:
-- ERRADO: Chaos sem preparação
-- CERTO: Game days + blast radius control
```

---

## 💰 Cost Optimization (300)

### Right-Sizing (100)

#### DEVOPS027: Resource Right-Sizing
```lua
-- SKILL: Resource Right-Sizing
-- Nível: Intermediário → Expert
-- Contexto: Otimizar recursos

-- TÉCNICAS:
-- 1. Monitor utilization
-- 2. Right-size instances
-- 3. Use spot/preemptible
-- 4. Auto-scaling
-- 5. Reserved/committed use

-- FERRAMENTAS:
-- - AWS Compute Optimizer
-- - Azure Advisor
-- - GCP Recommender
-- - Kubecost
```

### Cost Monitoring (100)

#### DEVOPS028: Cost Monitoring
```lua
-- SKILL: Cost Monitoring
-- Nível: Intermediário → Expert
-- Contexto: Monitorar custos

-- FERRAMENTAS:
-- 1. AWS Cost Explorer
-- 2. Azure Cost Management
-- 3. GCP Cost Management
-- 4. Kubecost (K8s)
-- 5. CloudHealth (multi-cloud)

-- BEST PRACTICES:
-- - Budget alerts
-- - Cost allocation tags
-- - Regular reviews
-- - Anomaly detection
```

### Optimization Strategies (100)

#### DEVOPS029: Cost Optimization Strategies
```lua
-- SKILL: Cost Optimization Strategies
-- Nível: Intermediário → Expert
-- Contexto: Estratégias de otimização

-- ESTRATÉGIAS:
-- 1. Compute: right-sizing, spot, savings plans
-- 2. Storage: lifecycle policies, tiering
-- 3. Network: data transfer optimization
-- 4. Database: reserved capacity, serverless
-- 5. Serverless: optimize cold starts

-- MÉTRICAS:
-- - Cost per transaction
-- - Cost per user
-- - Cost per revenue
-- - Trend analysis
```

---

*DevOps & SRE Skills v1.0 - Setembro 2026*