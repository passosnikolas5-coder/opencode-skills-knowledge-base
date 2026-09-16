# 🏗️ TERRAFORM AVANÇADO — Infrastructure as Code

**Fonte:** https://github.com/hashicorp/terraform (45k+ stars)
**Descrição:** Terraform é uma ferramenta de Infrastructure as Code (IaC) para provisionar e gerenciar infraestrutura de nuvem de forma declarativa, suportando múltiplos provedores como AWS, Azure e GCP.

---

## 1. HCL Syntax — Recursos e Configuração Básica

```hcl
resource "aws_instance" "web" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t3.micro"

  tags = {
    Name = "web-server"
    Environment = var.environment
  }
}

variable "environment" {
  description = "Ambiente de deploy"
  type        = string
  default     = "dev"
}

output "instance_id" {
  value = aws_instance.web.id
}
```

**❌ ERRADO:** Usar valores hardcoded para AMI e instance_type.
**✅ CORRETO:** Usar variáveis para parametrização e reutilização.

---

## 2. State Management — Gerenciamento de Estado

```hcl
terraform {
  backend "s3" {
    bucket         = "meu-terraform-state"
    key            = "infra/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
```

**❌ ERRADO:** Armazenar estado localmente em produção.
**✅ CORRETO:** Usar backend remoto com bloqueio (DynamoDB) e criptografia.

---

## 3. Módulos — Reutilização de Código

```hcl
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.0.0"

  name = "meu-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["us-east-1a", "us-east-1b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]
}
```

**❌ ERRADO:** Criar VPCs manualmente sem módulos reutilizáveis.
**✅ CORRETO:** Usar módulos versionados do registry para consistência.

---

## 4. Providers — Múltiplos Provedores

```hcl
provider "aws" {
  region = "us-east-1"
  alias  = "us"
}

provider "aws" {
  region = "eu-west-1"
  alias  = "eu"
}

resource "aws_s3_bucket" "us_bucket" {
  provider = aws.us
  bucket   = "meu-bucket-us"
}

resource "aws_s3_bucket" "eu_bucket" {
  provider = aws.eu
  bucket   = "meu-bucket-eu"
}
```

**❌ ERRADO:** Usar um único provider sem aliases para multi-região.
**✅ CORRETO:** Definir aliases e configurar providers explicitamente.

---

## 5. Workspaces — Ambientes Isolados

```hcl
terraform workspace new dev
terraform workspace new staging
terraform workspace new production

terraform workspace select production

locals {
  env_config = {
    dev         = { instance_type = "t3.micro" }
    staging     = { instance_type = "t3.small" }
    production  = { instance_type = "t3.large" }
  }
}

resource "aws_instance" "app" {
  instance_type = local.env_config[terraform.workspace].instance_type
}
```

**❌ ERRADO:** Não separar ambientes por workspace ou state.
**✅ CORRETO:** Usar workspaces ou diretórios separados por ambiente.

---

## 6. For-Each e Dynamic Blocks

```hcl
variable "users" {
  default = {
    alice = "admin"
    bob   = "developer"
  }
}

resource "aws_iam_user" "users" {
  for_each = var.users
  name     = each.key
  tags = {
    Role = each.value
  }
}

resource "aws_security_group" "web" {
  name = "web-sg"

  dynamic "ingress" {
    for_each = var.ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}
```

**❌ ERRADO:** Criar recursos repetitivos um por um.
**✅ CORRETO:** Usar for_each e dynamic blocks para código conciso.

---

## 7. Data Sources — Consultando Recursos Existentes

```hcl
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

data "aws_caller_identity" "current" {}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}
```

**❌ ERRADO:** Hardcodar IDs de AMIs ou contas.
**✅ CORRETO:** Usar data sources para descobrir valores dinamicamente.

---

## 8. Lifecycle Rules — Controle de Ciclo de Vida

```hcl
resource "aws_instance" "critical" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t3.large"

  lifecycle {
    create_before_destroy = true
    prevent_destroy       = true
    ignore_changes        = [tags]
  }
}
```

**❌ ERRADO:** Não proteger recursos críticos contra destruição acidental.
**✅ CORRETO:** Usar prevent_destroy e create_before_destroy.

---

## 9. Version Constraints — Controle de Versões

```hcl
terraform {
  required_version = ">= 1.5.0, < 2.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
```

**❌ ERRADO:** Não fixar versões de providers e Terraform.
**✅ CORRETO:** Usar constraints para evitar breaking changes.

---

## 10. Import e Migração

```bash
terraform import aws_instance.web i-0123456789abcdef0
terraform import module.vpc.aws_vpc.main vpc-abc123
```

```hcl
import {
  to = aws_instance.web
  id = "i-0123456789abcdef0"
}
```

**❌ ERRADO:** Importar sem criar o bloco de recurso correspondente.
**✅ CORRETO:** Definir o recurso HCL antes de importar para evitar drift.

---

## 11. Sentinel — Policy as Code

```python
import "tfplan/v2" as tfplan

all_instances = filter tfplan.resource_changes as _, rc {
    rc.type is "aws_instance" and
    (rc.mode is "managed" and
     rc.change.after is not null)
}

main = rule {
    all all_instances as _, instance {
        instance.change.after.instance_type in ["t3.micro", "t3.small"]
    }
}
```

**❌ ERRADO:** Não aplicar políticas de conformidade.
**✅ CORRETO:** Usar Sentinel para validar infraestrutura antes do apply.

---

## 12. Terraform CLI — Comandos Essenciais

```bash
terraform init          # Inicializa backend e providers
terraform plan          # Previne mudanças
terraform apply         # Aplica mudanças
terraform destroy       # Destrói infraestrutura
terraform fmt           # Formata código HCL
terraform validate      # Valida configuração
terraform state list    # Lista recursos gerenciados
terraform state show    # Mostra detalhes do recurso
terraform output        # Mostra outputs
terraform graph         # Gera grafo de dependências
```

**❌ ERRADO:** Pular terraform plan e ir direto para apply.
**✅ CORRETO:** Sempre revisar plan antes de confirmar apply.

---

## 13. Testing — Testes de Infraestrutura

```hcl
# test/vpc_test.tftest.hcl

run "verify_vpc_cidr" {
  command = apply

  assert {
    condition     = module.vpc.vpc_cidr_block == "10.0.0.0/16"
    error_message = "VPC CIDR incorreto"
  }
}

run "verify_subnets" {
  command = plan

  assert {
    condition     = length(module.vpc.private_subnets) == 2
    error_message = "Deveria ter 2 subnets privadas"
  }
}
```

**❌ ERRADO:** Não testar configurações Terraform.
**✅ CORRETO:** Usar terraform test para validar infraestrutura automaticamente.

---

## 14. Output Values — Saídas Reutilizáveis

```hcl
output "vpc_id" {
  description = "ID da VPC"
  value       = module.vpc.vpc_id
}

output "private_subnet_ids" {
  description = "IDs das subnets privadas"
  value       = module.vpc.private_subnets
}

output "db_endpoint" {
  description = "Endpoint do banco de dados"
  value       = aws_db_instance.main.endpoint
  sensitive   = true
}
```

**❌ ERRADO:** Não expor informações necessárias para outros módulos.
**✅ CORRETO:** Usar outputs para compartilhar dados entre módulos.

---

## 15. Backend Configuration — Configuração Avançada

```hcl
terraform {
  backend "s3" {
    bucket         = "terraform-state-prod"
    key            = "network/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-locks"
    
    # Para múltiplos accounts
    role_arn = "arn:aws:iam::123456789012:role/terraform"
  }
}
```

**❌ ERRADO:** Usar backend local em equipe compartilhada.
**✅ CORRETO:** Configurar backend remoto com locking e criptografia.

---

## 16. Variáveis Complexas e Validações

```hcl
variable "environment_config" {
  type = object({
    instance_type = string
    min_count     = number
    max_count     = number
    enable_backup = bool
  })

  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment_config.instance_type)
    error_message = "Instance type deve ser dev, staging ou prod."
  }
}

variable "allowed_cidrs" {
  type    = list(string)
  default = ["10.0.0.0/8"]

  validation {
    condition     = alltrue([for cidr in var.allowed_cidrs : can(cidrhost(cidr, 0))])
    error_message = "Todos os CIDRs devem ser válidos."
  }
}
```

**❌ ERRADO:** Não validar entrada de variáveis.
**✅ CORRETO:** Usar validation blocks para garantir valores corretos.

---

## 17. Sensitive Data — Dados Sensíveis

```hcl
variable "db_password" {
  type      = string
  sensitive = true
}

resource "aws_db_instance" "main" {
  password = var.db_password
}

# Nunca no state em texto plano:
# Use encrypt=true no backend S3
# Ou use Vault com provider vault
```

**❌ ERRADO:** Armazenar senhas em texto plano ou commits.
**✅ CORRETO:** Usar sensitive=true, variáveis de ambiente ou HashiCorp Vault.

---

## 18. Provisioners — Execução Pós-Criação

```hcl
resource "aws_instance" "web" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t3.micro"

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y nginx"
    ]

    connection {
      type        = "ssh"
      host        = self.private_ip
      user        = "ubuntu"
      private_key = file("~/.ssh/id_rsa")
    }
  }
}
```

**❌ ERRADO:** Usar provisioners para configuração complexa.
**✅ CORRETO:** Preferir Packer para AMIs ou user_data para bootstrap.

---

## 19. Terraform Cloud — Trabalho em Equipe

```hcl
terraform {
  cloud {
    organization = "minha-org"

    workspaces {
      name = "infra-producao"
    }
  }
}
```

**❌ ERRADO:** Gerenciar state manualmente em equipe.
**✅ CORRETO:** Usar Terraform Cloud para state remoto, locks e run triggers.

---

## 20. Expressões e Funções Avançadas

```hcl
locals {
  # Interpolação
  name = "servico-${var.environment}-${var.region}"
  
  # Condicionais
  instance_type = var.environment == "prod" ? "t3.large" : "t3.micro"
  
  # Loops com comprehensions
  private_cidrs = [for i in range(3) : cidrsubnet("10.0.0.0/16", 8, i)]
  
  # Funções de mapa
  env_config = merge(local.base_config, local[var.environment])
  
  # Lookups
  size = lookup(local.sizes, var.environment, "small")
}
```

**❌ ERRADO:** Não usar funções nativas para lógica complexa.
**✅ CORRETO:** Dominar expressões HCL para código mais limpo e dinâmico.

---

**Referências:**
- Terraform Docs: https://developer.hashicorp.com/terraform/docs
- Registry: https://registry.terraform.io/
- Best Practices: https://developer.hashicorp.com/terraform/cloud-docs/recommended-practices
