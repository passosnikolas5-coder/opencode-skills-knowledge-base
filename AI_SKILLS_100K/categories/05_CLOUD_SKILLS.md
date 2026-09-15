# ☁️ Cloud & Infrastructure Skills - 7.000 Skills

> **Todas as habilidades de cloud e infraestrutura documentadas**

---

## 📊 Visão Geral

| Subcategoria | Skills | Nível |
|--------------|--------|-------|
| AWS | 1.500 | Básico → Expert |
| Azure | 1.200 | Básico → Expert |
| GCP | 1.000 | Básico → Expert |
| Kubernetes | 800 | Intermediário → Expert |
| Docker | 700 | Básico → Expert |
| Terraform | 600 | Intermediário → Expert |
| CI/CD | 600 | Intermediário → Expert |
| Monitoring | 400 | Intermediário → Expert |
| Logging | 300 | Intermediário → Expert |
| Security | 300 | Avançado → Expert |

---

## 🟠 AWS Skills (1.500)

### Compute (300)

#### AWS001: EC2 Mastery
```lua
-- SKILL: EC2 Mastery
-- Nível: Básico → Expert
-- Contexto: Servidores virtuais na AWS

-- CONCEITOS:
-- 1. Instance Types
--    - General Purpose (t3, m5)
--    - Compute Optimized (c5, c6g)
--    - Memory Optimized (r5, x1)
--    - Storage Optimized (i3, d2)
--    - Accelerated (p4, g4)
--
-- 2. Pricing
--    - On-Demand
--    - Reserved (1yr, 3yr)
--    - Spot (até 90% off)
--    - Savings Plans
--
-- 3. Networking
--    - VPC
--    - Security Groups
--    - Elastic IP
--    - ENI
--
-- 4. Storage
--    - EBS (persistent)
--    - Instance Store (ephemeral)
--    - EFS (shared)

-- BEST PRACTICES:
-- - Right-sizing
-- - Auto Scaling
-- - Mixed instances
-- - Monitoring with CloudWatch
```

#### AWS002: Lambda Serverless
```lua
-- SKILL: Lambda Serverless
-- Nível: Intermediário → Expert
-- Contexto: Computação serverless

-- CONCEITOS:
-- 1. Function Configuration
--    - Runtime
--    - Memory (128MB - 10GB)
--    - Timeout (max 15min)
--    - Environment variables
--
-- 2. Triggers
--    - API Gateway
--    - S3
--    - DynamoDB Streams
--    - SQS/SNS
--    - EventBridge
--
-- 3. Deployment
--    - ZIP package
--    - Container image
--    - Lambda Layers
--
-- 4. Advanced
--    - Concurrency
--    - Provisioned
--    - Destinations
--    - Dead letter queues

-- LIMITS:
-- - 1000 concurrent (default)
-- - 15 min timeout
-- - 250MB /tmp
-- - 6MB payload (synchronous)

-- MELHORIA:
-- ERRADO: Lambda para tudo
-- CERTO: Lambda para event-driven, bursty workloads
```

### Storage (250)

#### AWS003: S3 Mastery
```lua
-- SKILL: S3 Mastery
-- Nível: Básico → Expert
-- Contexto: Armazenamento de objetos

-- CONCEITOS:
-- 1. Storage Classes
--    - Standard
--    - Intelligent-Tiering
--    - Standard-IA
--    - One Zone-IA
--    - Glacier
--    - Glacier Deep Archive
--
-- 2. Features
--    - Versioning
--    - Lifecycle policies
--    - Cross-region replication
--    - Event notifications
--    - Access points
--
-- 3. Security
--    - Bucket policies
--    - ACLs
--    - VPC endpoints
--    - Encryption (SSE-S3, SSE-KMS, SSE-C)
--    - Access logging
--
-- 4. Performance
--    - Multipart upload
--    - Transfer acceleration
--    - S3 Select

-- BEST PRACTICES:
-- - Use prefixes for partitioning
-- - Enable versioning
-- - Lifecycle policies
-- - CloudFront for CDN
```

### Database (250)

#### AWS004: DynamoDB Mastery
```lua
-- SKILL: DynamoDB Mastery
-- Nível: Intermediário → Expert
-- Contexto: NoSQL na AWS

-- CONCEITOS:
-- 1. Data Model
--    - Tables, items, attributes
--    - Primary key (partition key)
--    - Sort key (composite key)
--    - Global Secondary Index (GSI)
--    - Local Secondary Index (LSI)
--
-- 2. Capacity
--    - On-demand
--    - Provisioned
--    - Auto-scaling
--    - Reserved capacity
--
-- 3. Features
--    - DynamoDB Streams
--    - Global Tables
--    - DAX (caching)
--    - Time to Live (TTL)
--    - Point-in-time recovery
--
-- 4. Patterns
--    - Single table design
--    - Adjacency lists
--    - Materialized views
--    - Time series

-- QUERY vs SCAN:
-- - Query: Uses primary key, efficient
-- - Scan: Reads everything, expensive
```

### Networking (250)

#### AWS005: VPC Mastery
```lua
-- SKILL: VPC Mastery
-- Nível: Intermediário → Expert
-- Contexto: Rede virtual na AWS

-- CONCEITOS:
-- 1. Subnets
--    - Public (internet-facing)
--    - Private (internal)
--    - Availability Zones
--
-- 2. Routing
--    - Route tables
--    - Internet Gateway
--    - NAT Gateway
--    - VPC Peering
--    - Transit Gateway
--
-- 3. Security
--    - Security Groups (stateful)
--    - NACLs (stateless)
--    - VPC Endpoints
--    - Flow Logs
--
-- 4. Advanced
--    - IPv4/IPv6 dual stack
--    - VPC Sharing
--    - Network Firewall
--    - Reachability Analyzer

-- BEST PRACTICES:
-- - Multiple AZs
-- - Public/Private separation
-- - Least privilege
-- - Flow logs enabled
```

### Security (250)

#### AWS006: IAM Mastery
```lua
-- SKILL: IAM Mastery
-- Nível: Intermediário → Expert
-- Contexto: Gerenciamento de identidade

-- CONCEITOS:
-- 1. Users & Groups
--    - Humans
--    - Service accounts
--    - Group membership
--
-- 2. Roles
--    - Service roles
--    - Cross-account
--    - Federation
--    - Assume role
--
-- 3. Policies
--    - JSON policy documents
--    - Managed vs inline
--    - Evaluation logic
--    - Conditions
--
-- 4. Best Practices
--    - Least privilege
--    - MFA
--    - Rotation
--    - Monitoring

-- FERRAMENTAS:
-- - IAM Access Analyzer
-- - IAM Credential Report
-- - AWS Config
-- - CloudTrail
```

### Monitoring (200)

#### AWS007: CloudWatch Mastery
```lua
-- SKILL: CloudWatch Mastery
-- Nível: Intermediário → Expert
-- Contexto: Monitoramento na AWS

-- CONCEITOS:
-- 1. Metrics
--    - Standard resolution
--    - High resolution
--    - Custom metrics
--    - Math expressions
--
-- 2. Alarms
--    - Static thresholds
--    - Anomaly detection
--    - Composite alarms
--    - Actions
--
-- 3. Logs
--    - Log groups
--    - Log streams
--    - Insights queries
--    - Subscriptions
--
-- 4. Events
--    - EventBridge
--    - Schedules
--    - Rules
--    - Targets

-- BEST PRACTICES:
-- - Custom dashboards
-- - Alarms for critical metrics
-- - Log retention policies
-- - Cost optimization
```

---

## 🔵 Azure Skills (1.200)

### Compute (250)

#### AZ001: Azure VMs
```lua
-- SKILL: Azure Virtual Machines
-- Nível: Básico → Expert
-- Contexto: Servidores virtuais no Azure

-- CONCEITOS:
-- 1. VM Sizes
--    - General Purpose (B, D, Dav4)
--    - Compute Optimized (F, Fs)
--    - Memory Optimized (E, M)
--    - Storage Optimized (Ls)
--    - GPU (NC, ND, NV)
--
-- 2. Pricing
--    - Pay-as-you-go
--    - Reserved VM Instances
--    - Spot VMs
--    - Azure Hybrid Benefit
--
-- 3. Features
--    - Availability Sets
--    - Availability Zones
--    - Scale Sets
--    - Confidential VMs
--
-- 4. Networking
--    - VNet
--    - NSG
--    - Load Balancer
--    - Application Gateway

-- BEST PRACTICES:
-- - Use managed disks
-- - Enable backups
-- - Use availability zones
-- - Monitor with Azure Monitor
```

#### AZ002: Azure Functions
```lua
-- SKILL: Azure Functions
-- Nível: Intermediário → Expert
-- Contexto: Serverless no Azure

-- CONCEITOS:
-- 1. Plans
--    - Consumption (serverless)
--    - Premium (warm instances)
--    - Dedicated (App Service)
--
-- 2. Triggers
--    - HTTP
--    - Timer
--    - Queue
--    - Blob
--    - Event Hub
--    - Service Bus
--
-- 3. Bindings
--    - Input bindings
--    - Output bindings
--    - Declarative
--
-- 4. Durable Functions
--    - Orchestration
--    - Chaining
--    - Fan-out/fan-in

-- LIMITS:
-- - Consumption: 10 min default, 60 max
-- - Premium: no timeout
-- - 1.5GB memory
```

### Database (200)

#### AZ003: Azure SQL
```lua
-- SKILL: Azure SQL Database
-- Nível: Intermediário → Expert
-- Contexto: Banco de dados relacional no Azure

-- OPÇÕES:
-- 1. Azure SQL Database
--    - Managed PaaS
--    - Serverless
--    - Hyperscale
--
-- 2. Azure SQL Managed Instance
--    - Near 100% compatibilidade
--    - Migration fácil
--    - Instance-scoped features
--
-- 3. SQL Server on VMs
--    - IaaS
--    - Full control
--    - Lift and shift

-- FEATURES:
-- - Geo-replication
-- - Auto-tuning
-- - Threat detection
-- - Data masking
-- - Dynamic data masking
-- - Transparent data encryption

-- BEST PRACTICES:
-- - Use elastic pools
-- - Enable auto-tuning
-- - Use read replicas
-- - Monitor performance
```

### Networking (200)

#### AZ004: Azure Networking
```lua
-- SKILL: Azure Networking
-- Nível: Intermediário → Expert
-- Contexto: Rede no Azure

-- SERVIÇOS:
-- 1. Virtual Network
--    - Subnets
--    - Peering
--    - Service endpoints
--    - Private Link
--
-- 2. Load Balancer
--    - Standard
--    - Basic
--    - Internal/Public
--
-- 3. Application Gateway
--    - L7 load balancing
--    - WAF
--    - SSL termination
--
-- 4. CDN
--    - Azure Front Door
--    - Azure CDN
--    - Edge locations

-- BEST PRACTICES:
-- - Use network security groups
-- - Implement private endpoints
-- - Use Azure Firewall
-- - Enable DDoS protection
```

### Identity (200)

#### AZ005: Azure Active Directory
```lua
-- SKILL: Azure Active Directory
-- Nível: Intermediário → Expert
-- Contexto: Identidade no Azure

-- CONCEITOS:
-- 1. Authentication
--    - MFA
--    - Conditional Access
--    - Passwordless
--
-- 2. Authorization
--    - RBAC
--    - PIM (Privileged Identity Management)
--    - Access reviews
--
-- 3. Federation
--    - SAML
--    - OAuth/OIDC
--    - B2B collaboration
--
-- 4. Protection
--    - Identity Protection
--    - Risk detection
--    - Access reviews

-- BEST PRACTICES:
-- - Enable MFA
-- - Use conditional access
-- - Implement PIM
-- - Monitor sign-ins
```

---

## 🟢 GCP Skills (1.000)

### Compute (250)

#### GCP001: Google Compute Engine
```lua
-- SKILL: Google Compute Engine
-- Nível: Básico → Expert
-- Contexto: Servidores virtuais no GCP

-- CONCEITOS:
-- 1. Machine Types
--    - General Purpose (E2, N2)
--    - Compute Optimized (C2, C2D)
--    - Memory Optimized (M1, M2)
--    - Accelerated (A2, G2)
--
-- 2. Pricing
--    - On-demand
--    - Committed Use (1yr, 3yr)
--    - Preemptible/Spot
--    - Sustained Use
--
-- 3. Features
--    - Managed Instance Groups
--    - Predefined/Autoscaler
--    - Confidential VMs
--    - Sole-tenant nodes
--
-- 4. Networking
--    - VPC
--    - Firewall rules
--    - Cloud Load Balancing
--    - Cloud CDN

-- BEST PRACTICES:
-- - Use preemptible for batch
-- - Enable OS Login
-- - Use Shielded VMs
-- - Monitor with Cloud Monitoring
```

#### GCP002: Cloud Run
```lua
-- SKILL: Cloud Run
-- Nível: Intermediário → Expert
-- Contexto: Serverless containers no GCP

-- CONCEITOS:
-- 1. Container Runtime
--    - Any language
--    - Dockerfile
--    - Buildpacks
--
-- 2. Configuration
--    - CPU allocation
--    - Memory
--    - Concurrency
--    - Min/max instances
--
-- 3. Features
--    - HTTP/2
--    - WebSockets
--    - Streaming
--    - End-to-end HTTPS
--
-- 4. Integration
--    - Cloud SQL
--    - Memorystore
--    - Secret Manager
--    - VPC Connector

-- LIMITS:
-- - 1000 instances (default)
-- - 30 min timeout
-- - 32GB memory
-- - 8 vCPU
```

### Database (200)

#### GCP003: Cloud Spanner
```lua
-- SKILL: Cloud Spanner
-- Nível: Avançado → Expert
-- Contexto: Banco relacional global

-- CONCEITOS:
-- 1. Global Distribution
--    - Multi-region
--    - Strong consistency
--    - 99.999% SLA
--
-- 2. Features
--    - Horizontal scaling
--    - Automatic sharding
--    - ACID transactions
--    - SQL interface
--
-- 3. Configuration
--    - Instances
--    - Databases
--    - Tables
--    - Indexes
--
-- 4. Best Practices
--    - Schema design
--    - Interleaving
--    - Primary keys
--    - Indexing

-- QUANDO USAR:
-- - Global applications
-- - Strong consistency needed
-- - High availability
-- - Relational + horizontal scaling
```

### Networking (200)

#### GCP004: VPC & Networking
```lua
-- SKILL: GCP Networking
-- Nível: Intermediário → Expert
-- Contexto: Rede no GCP

-- CONCEITOS:
-- 1. VPC
--    - Auto/custom mode
--    - Subnets
--    - Firewall rules
--    - Routes
--
-- 2. Load Balancing
--    - HTTP(S) LB
--    - TCP/UDP LB
--    - Internal LB
--    - Network LB
--
-- 3. CDN
--    - Cloud CDN
--    - Edge caching
--    - Origin groups
--
-- 4. Interconnect
--    - Cloud Interconnect
--    - VPN
--    - Peering

-- BEST PRACTICES:
-- - Use private IPs
-- - Implement firewall rules
-- - Use Cloud NAT
-- - Enable VPC Flow Logs
```

### Security (200)

#### GCP005: Security Best Practices
```lua
-- SKILL: GCP Security
-- Nível: Intermediário → Expert
-- Contexto: Segurança no GCP

-- SERVIÇOS:
-- 1. Cloud IAM
--    - Roles
--    - Policies
--    - Conditions
--
-- 2. KMS
--    - Key management
--    - Encryption
--    - HSM
--
-- 3. Security Command Center
--    - Threat detection
--    - Vulnerability scanning
--    - Compliance
--
-- 4. Cloud Armor
--    - DDoS protection
--    - WAF
--    - Bot protection

-- BEST PRACTICES:
-- - Use service accounts
-- - Implement least privilege
-- - Enable audit logging
-- - Use VPC Service Controls
```

---

## 🟣 Kubernetes Skills (800)

### Core Concepts (300)

#### K8S001: Kubernetes Architecture
```lua
-- SKILL: Kubernetes Architecture
-- Nível: Intermediário → Expert
-- Contexto: Orquestração de containers

-- COMPONENTES:
-- 1. Control Plane
--    - API Server
--    - etcd
--    - Scheduler
--    - Controller Manager
--
-- 2. Node Components
--    - kubelet
--    - kube-proxy
--    - Container Runtime
--
-- 3. Objects
--    - Pods
--    - Deployments
--    - Services
--    - ConfigMaps
--    - Secrets
--    - Namespaces

-- KUBECTL:
-- kubectl get [resource]
-- kubectl describe [resource] [name]
-- kubectl create -f [file]
-- kubectl apply -f [file]
-- kubectl delete -f [file]
-- kubectl logs [pod]
-- kubectl exec -it [pod] -- /bin/sh
```

#### K8S002: Pod Management
```lua
-- SKILL: Pod Management
-- Nível: Intermediário → Expert
-- Contexto: Gerenciar pods

-- CONCEITOS:
-- 1. Pod Lifecycle
--    - Pending
--    - Running
--    - Succeeded/Failed
--    - Unknown
--
-- 2. Probes
--    - Liveness
--    - Readiness
--    - Startup
--
-- 3. Resources
--    - Requests
--    - Limits
--    - QoS classes
--
-- 4. Patterns
--    - Sidecar
--    - Ambassador
--    - Adapter
--    - Init containers

-- BEST PRACTICES:
-- - Use deployments for stateless
-- - Set resource limits
-- - Use liveness/readiness probes
-- - Avoid privileged pods
```

### Networking (200)

#### K8S003: Kubernetes Networking
```lua
-- SKILL: Kubernetes Networking
-- Nível: Intermediário → Expert
-- Contexto: Rede em Kubernetes

-- CONCEITOS:
-- 1. Pod Networking
--    - CNI plugins
--    - Flannel, Calico, Cilium
--    - Network policies
--
-- 2. Services
--    - ClusterIP
--    - NodePort
--    - LoadBalancer
--    - ExternalName
--
-- 3. Ingress
--    - Ingress controllers
--    - NGINX, Traefik
--    - TLS termination
--
-- 4. DNS
--    - CoreDNS
--    - Service discovery
--    - Headless services

-- NETWORK POLICIES:
-- - Ingress rules
-- - Egress rules
-- - Pod selectors
-- - Namespace selectors
```

### Storage (150)

#### K8S004: Kubernetes Storage
```lua
-- SKILL: Kubernetes Storage
-- Nível: Intermediário → Expert
-- Contexto: Armazenamento em Kubernetes

-- CONCEITOS:
-- 1. Volumes
--    - emptyDir
--    - hostPath
--    - persistentVolumeClaim
--
-- 2. Persistent Volumes
--    - PV/PVC
--    - StorageClasses
--    - Dynamic provisioning
--
-- 3. CSI Drivers
--    - EBS, EFS (AWS)
--    - Disk, File (Azure)
--    - Persistent Disk (GCP)
--
-- 4. StatefulSets
--    - Stable network identity
--    - Stable storage
--    - Ordered deployment

-- BEST PRACTICES:
-- - Use PersistentVolumes for state
-- - Define StorageClasses
-- - Use StatefulSets for stateful apps
-- - Backup PVs
```

### Security (150)

#### K8S005: Kubernetes Security
```lua
-- SKILL: Kubernetes Security
-- Nível: Avançado → Expert
-- Contexto: Segurança em Kubernetes

-- CAMADAS:
-- 1. Cluster
--    - RBAC
--    - Admission controllers
--    - Pod security standards
--
-- 2. Container
--    - Image scanning
--    - Read-only rootfs
--    - Non-root user
--
-- 3. Network
--    - Network policies
--    - Service mesh
--    - mTLS
--
-- 4. Secrets
--    - Sealed Secrets
--    - External Secrets
--    - Vault

-- BEST PRACTICES:
-- - Use RBAC
-- - Scan images
-- - Enable audit logging
-- - Use network policies
-- - Encrypt etcd
```

---

## 🐳 Docker Skills (700)

### Core Concepts (200)

#### DK001: Docker Fundamentals
```lua
-- SKILL: Docker Fundamentals
-- Nível: Básico → Expert
-- Contexto: Containerização

-- CONCEITOS:
-- 1. Images
--    - Layers
--    - Dockerfile
--    - Multi-stage builds
--
-- 2. Containers
--    - Lifecycle
--    - Networking
--    - Storage
--
-- 3. Registries
--    - Docker Hub
--    - ECR, ACR, GCR
--    - Private registries
--
-- 4. Compose
--    - Multi-container
--    - Services
--    - Volumes
--    - Networks

-- COMANDOS:
-- docker build -t [name] .
-- docker run -d -p 8080:80 [image]
-- docker ps
-- docker logs [container]
-- docker exec -it [container] /bin/sh
-- docker-compose up -d
-- docker-compose down
```

#### DK002: Dockerfile Best Practices
```lua
-- SKILL: Dockerfile Best Practices
-- Nível: Intermediário → Expert
-- Contexto: Criar imagens eficientes

-- PRINCÍPIOS:
-- 1. Multi-stage builds
--    - Build stage
--    - Runtime stage
--    - Menor tamanho
--
-- 2. Layer optimization
--    - Combine RUNs
--    - Order by frequency
--    - Use .dockerignore
--
-- 3. Security
--    - Non-root user
--    - Minimal base
--    - Scan images
--
-- 4. Caching
--    - Leverage layer cache
--    - COPY requirements first
--    - Use BuildKit

-- EXEMPLO:
```dockerfile
# Build stage
FROM node:18-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production
COPY . .
RUN npm run build

# Runtime stage
FROM node:18-alpine
RUN addgroup -g 1001 -S nodejs
RUN adduser -S nextjs -u 1001
COPY --from=builder --chown=nextjs:nodejs /app/dist ./dist
USER nextjs
CMD ["node", "dist/index.js"]
```
```

### Advanced (300)

#### DK003: Docker Networking
```lua
-- SKILL: Docker Networking
-- Nível: Intermediário → Expert
-- Contexto: Rede em Docker

-- TIPOS:
-- 1. Bridge (default)
--    - Internal communication
--    - Port mapping
--
-- 2. Host
--    - Remove isolation
--    - Better performance
--
-- 3. None
--    - No networking
--    - Isolated
--
-- 4. Overlay
--    - Multi-host
--    - Swarm
--
-- 5. Macvlan
--    - Assign MAC address
--    - Direct network access

-- COMANDOS:
-- docker network create [name]
-- docker network ls
-- docker network inspect [name]
-- docker run --network [name] [image]
```

#### DK004: Docker Compose
```lua
-- SKILL: Docker Compose Mastery
-- Nível: Intermediário → Expert
-- Contexto: Multi-container apps

-- CONCEITOS:
-- 1. Services
--    - Multiple containers
--    - Dependencies
--    - Health checks
--
-- 2. Networks
--    - Custom networks
--    - Service discovery
--
-- 3. Volumes
--    - Named volumes
--    - Bind mounts
--    - tmpfs
--
-- 4. Configs
--    - Environment variables
--    - Secrets
--    - Config files

-- EXEMPLO:
```yaml
version: '3.8'
services:
  web:
    build: .
    ports:
      - "3000:3000"
    environment:
      - DB_HOST=database
    depends_on:
      database:
        condition: service_healthy
  
  database:
    image: postgres:15
    volumes:
      - db_data:/var/lib/postgresql/data
    environment:
      - POSTGRES_PASSWORD=secret
    healthcheck:
      test: ["CMD", "pg_isready"]
      interval: 10s

volumes:
  db_data:
```
```

---

## 🏗️ Terraform Skills (600)

### Core Concepts (200)

#### TF001: Terraform Fundamentals
```lua
-- SKILL: Terraform Fundamentals
-- Nível: Básico → Expert
-- Contexto: Infrastructure as Code

-- CONCEITOS:
-- 1. Providers
--    - AWS, Azure, GCP
--    - Version constraints
--    - Authentication
--
-- 2. Resources
--    - Resource types
--    - Arguments
--    - Attributes
--
-- 3. State
--    - Remote state
--    - State locking
--    - Import
--
-- 4. Modules
--    - Reusable components
--    - Input/output
--    - Versioning

-- COMANDOS:
-- terraform init
-- terraform plan
-- terraform apply
-- terraform destroy
-- terraform state list
-- terraform import
```

#### TF002: Terraform Best Practices
```lua
-- SKILL: Terraform Best Practices
-- Nível: Intermediário → Expert
-- Contexto: IaC em produção

-- PRINCÍPIOS:
-- 1. Project Structure
--    - Modules
--    - Environments
--    - Workspaces
--
-- 2. State Management
--    - Remote backend
--    - State locking
--    - Encryption
--
-- 3. Code Quality
--    - terraform fmt
--    - terraform validate
--    - tflint
--    - checkov
--
-- 4. Testing
--    - terratest
--    - Plan validation
--    - Import testing

-- BEST PRACTICES:
-- - Use modules
-- - Remote state
-- - Version pinning
-- - Plan before apply
-- - Use variables
```

### Advanced (200)

#### TF003: Terraform Advanced Patterns
```lua
-- SKILL: Terraform Advanced Patterns
-- Nível: Avançado → Expert
-- Contexto: Padrões avançados

-- PADRÕES:
-- 1. Workspaces
--    - Environment separation
--    - State isolation
--
-- 2. Modules
--    - Registry modules
--    - Custom modules
--    - Module composition
--
-- 3. Provisioners
--    - Remote-exec
--    - Local-exec
--    - File
--
-- 4. Dynamic Blocks
--    - Dynamic "ingress" {}
--    - For expressions
--    - Splat expressions

-- MULTI-CLOUD:
-- - Provider aliases
-- - Cross-provider resources
-- - Federated identity
```

### Security (200)

#### TF004: Terraform Security
```lua
-- SKILL: Terraform Security
-- Nível: Avançado → Expert
-- Contexto: Segurança em IaC

-- CONCEITOS:
-- 1. Secrets Management
--    - Sensitive variables
--    - Vault integration
--    - Environment variables
--
-- 2. Policy as Code
--    - Sentinel
--    - OPA/Conftest
--    - Checkov
--
-- 3. State Security
--    - Encryption at rest
--    - Access control
--    - Audit logging
--
-- 4. Compliance
--    - CIS benchmarks
--    - Custom policies
--    - drift detection

-- FERRAMENTAS:
-- - tfsec
-- - checkov
-- - terrascan
-- - Sentinel
```

---

## 🔄 CI/CD Skills (600)

### GitHub Actions (200)

#### GA001: GitHub Actions Mastery
```lua
-- SKILL: GitHub Actions Mastery
-- Nível: Intermediário → Expert
-- Contexto: CI/CD no GitHub

-- CONCEITOS:
-- 1. Workflows
--    - YAML syntax
--    - Triggers
--    - Jobs
--    - Steps
--
-- 2. Actions
--    - Marketplace
--    - Custom actions
--    - Composite actions
--
-- 3. Secrets
--    - Environment secrets
--    - Repository secrets
--
-- 4. Caching
--    - Dependency caching
--    - Build caching

-- EXEMPLO:
```yaml
name: CI
on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: 18
      - run: npm ci
      - run: npm test
  
  deploy:
    needs: test
    if: github.ref == 'refs/heads/main'
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - run: npm run build
      - uses: aws-actions/configure-aws-credentials@v4
        with:
          role-to-assume: arn:aws:iam::123456789:role/deploy
          aws-region: us-east-1
      - run: aws s3 sync dist/ s3://my-bucket
```
```

### GitLab CI (200)

#### GL001: GitLab CI/CD
```lua
-- SKILL: GitLab CI/CD Mastery
-- Nível: Intermediário → Expert
-- Contexto: CI/CD no GitLab

-- CONCEITOS:
-- 1. .gitlab-ci.yml
--    - Stages
--    - Jobs
--    - Variables
--
-- 2. Runners
--    - Shared runners
--    - Specific runners
--    - Docker runners
--
-- 3. Artifacts
--    - Build artifacts
--    - Cache
--
-- 4. Environments
--    - Deployment targets
--    - Review apps

-- EXEMPLO:
```yaml
stages:
  - build
  - test
  - deploy

variables:
  DOCKER_IMAGE: $CI_REGISTRY_IMAGE:$CI_COMMIT_SHA

build:
  stage: build
  script:
    - docker build -t $DOCKER_IMAGE .
    - docker push $DOCKER_IMAGE

test:
  stage: test
  script:
    - docker run $DOCKER_IMAGE npm test

deploy:
  stage: deploy
  only:
    - main
  script:
    - kubectl set image deployment/app app=$DOCKER_IMAGE
  environment:
    name: production
```
```

### Jenkins (200)

#### JK001: Jenkins Pipeline
```lua
-- SKILL: Jenkins Pipeline
-- Nível: Intermediário → Expert
-- Contexto: CI/CD com Jenkins

-- CONCEITOS:
-- 1. Declarative Pipeline
--    - agent
--    - stages
--    - steps
--    - post
--
-- 2. Scripted Pipeline
--    - node
--    - stage
--    - sh
--
-- 3. Shared Libraries
--    - Reusable code
--    - Team standards
--
-- 4. Credentials
--    - Credentials store
--    - SSH keys
--    - Tokens

-- EXEMPLO:
```groovy
pipeline {
    agent any
    
    environment {
        DOCKER_IMAGE = "myapp:${BUILD_NUMBER}"
    }
    
    stages {
        stage('Build') {
            steps {
                sh 'docker build -t $DOCKER_IMAGE .'
            }
        }
        stage('Test') {
            steps {
                sh 'docker run $DOCKER_IMAGE npm test'
            }
        }
        stage('Deploy') {
            when {
                branch 'main'
            }
            steps {
                sh 'kubectl set image deployment/app app=$DOCKER_IMAGE'
            }
        }
    }
    
    post {
        always {
            sh 'docker rmi $DOCKER_IMAGE || true'
        }
    }
}
```
```

---

## 📊 Monitoring Skills (400)

### Prometheus (150)

#### PR001: Prometheus Mastery
```lua
-- SKILL: Prometheus Mastery
-- Nível: Intermediário → Expert
-- Contexto: Monitoramento e métricas

-- CONCEITOS:
-- 1. Data Model
--    - Metrics
--    - Labels
--    - Time series
--
-- 2. Query Language (PromQL)
--    - Selectors
--    - Operators
--    - Functions
--
-- 3. Alerting
--    - Alert rules
--    - Alertmanager
--    - Routing
--
-- 4. Exporters
--    - Node exporter
--    - Application metrics
--    - Custom exporters

-- COMANDOS:
-- prometheus --config.file=prometheus.yml
-- promtool check config prometheus.yml
-- promtool test rules tests.yml
```

### Grafana (150)

#### GF001: Grafana Dashboards
```lua
-- SKILL: Grafana Dashboard Creation
-- Nível: Intermediário → Expert
-- Contexto: Visualização de dados

-- CONCEITOS:
-- 1. Data Sources
--    - Prometheus
--    - InfluxDB
--    - Elasticsearch
--
-- 2. Panels
--    - Time series
--    - Gauge
--    - Stat
--    - Table
--
-- 3. Variables
--    - Dynamic queries
--    - Dropdowns
--
-- 4. Alerting
--    - Panel alerts
--    - Notification channels

-- BEST PRACTICES:
-- - Use templates
-- - Organize by service
-- - Add context to panels
-- - Use consistent colors
```

### ELK Stack (100)

#### ELK001: Elasticsearch Mastery
```lua
-- SKILL: Elasticsearch Mastery
-- Nível: Intermediário → Expert
-- Contexto: Busca e análise

-- CONCEITOS:
-- 1. Indexing
--    - Documents
--    - Mappings
--    - Templates
--
-- 2. Searching
--    - Query DSL
--    - Full-text search
--    - Aggregations
--
-- 3. Cluster
--    - Shards
--    - Replicas
--    - Nodes
--
-- 4. Performance
--    - Caching
--    - Refresh interval
--    - Merge policy

-- QUERY DSL:
```json
{
  "query": {
    "bool": {
      "must": [
        { "match": { "title": "elastic" } }
      ],
      "filter": [
        { "range": { "date": { "gte": "2024-01-01" } } }
      ]
    }
  }
}
```
```

---

*Cloud & Infrastructure Skills v1.0 - Setembro 2026*