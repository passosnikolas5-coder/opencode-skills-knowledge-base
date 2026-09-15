# 🔒 Cybersecurity Skills - 5.000 Skills

> **Todas as habilidades de segurança cibernética documentadas**

---

## 📊 Visão Geral

| Subcategoria | Skills | Nível |
|--------------|--------|-------|
| Penetration Testing | 800 | Intermediário → Expert |
| Network Security | 700 | Intermediário → Expert |
| Application Security | 700 | Intermediário → Expert |
| Cryptography | 600 | Avançado → Expert |
| Identity & Access | 600 | Intermediário → Expert |
| Incident Response | 500 | Intermediário → Expert |
| Cloud Security | 500 | Intermediário → Expert |
| DevSecOps | 400 | Intermediário → Expert |
| Compliance | 400 | Intermediário → Expert |
| Threat Intelligence | 300 | Avançado → Expert |

---

## 🎯 Penetration Testing Skills (800)

### Reconnaissance (200)

#### PT001: OSINT Gathering
```lua
-- SKILL: OSINT Gathering Techniques
-- Nível: Intermediário → Expert
-- Contexto: Coleta de informações abertas

-- FERRAMENTAS:
-- 1. Recon-ng
--    - Framework de reconhecimento
--    - Módulos automatizados
--    - Database de resultados
--
-- 2. Maltego
--    - Visualização de dados
--    - Transformações
--    - Relacionamentos
--
-- 3. Shodan
--    - Busca de dispositivos
--    - Portas abertas
--    - Serviços expostos
--
-- 4. theHarvester
--    - Emails
--    - Subdomínios
--    - Hosts
--
-- 5. SpiderFoot
--    - Automação completa
--    - Múltiplas fontes
--    - Correlação

-- FONTES:
-- - WHOIS
-- - DNS
-- - Social media
-- - Job postings
-- - Code repositories
-- - Pastebins
-- - Dark web
```

#### PT002: Network Scanning
```lua
-- SKILL: Network Scanning Mastery
-- Nível: Intermediário → Expert
-- Contexto: Mapeamento de redes

-- FERRAMENTAS:
-- 1. Nmap
--    - Port scanning
--    - Service detection
--    - OS fingerprinting
--    - Scripting engine (NSE)
--
-- 2. Masscan
--    - Alta velocidade
--    - Scans completos
--    - Raspberry Pi
--
-- 3. Zmap
--    - Internet-wide
--    - Estatísticas
--    - academic
--
-- 4. Unicornscan
--    - Assíncrono
--    - UDP scanning
--    - Performance

-- TIPOS DE SCAN:
-- - TCP SYN (stealth)
-- - TCP Connect
-- - UDP
-- - ACK
-- - Window
-- - Xmas
-- - Null
-- - FIN

-- MELHORIA:
-- ERRADO: Scan agressivo que detecta IDS
-- CERTO: Scan stealth com timing adequado
```

#### PT003: Vulnerability Assessment
```lua
-- SKILL: Vulnerability Assessment
-- Nível: Intermediário → Expert
-- Contexto: Identificar vulnerabilidades

-- FERRAMENTAS:
-- 1. Nessus
--    - Scanner comercial
--    - Múltiplos plugins
--    - Relatórios detalhados
--
-- 2. OpenVAS
--    - Open source
--    - Completo
--    - Customizável
--
-- 3. Qualys
--    - Cloud-based
--    - Compliance
--    - Contínuo
--
-- 4. Rapid7
--    - InsightVM
--    - Real-time
--    - Analytics

-- PROCESSO:
-- 1. Planning
--    - Escopo
--    - Auth
--    - Janela
--
-- 2. Scanning
--    - Configuração
--    - Execução
--    - Coleta
--
-- 3. Analysis
--    - Priorização
--    - Falso positivos
--    - Contexto
--
-- 4. Reporting
--    - Executivo
--    - Técnico
--    - Remediação
```

### Exploitation (300)

#### PT004: Metasploit Framework
```lua
-- SKILL: Metasploit Mastery
-- Nível: Intermediário → Expert
-- Contexto: Framework de exploração

-- COMPONENTES:
-- 1. Exploits
--    - Código de exploração
--    - Targets
--    - Options
--
-- 2. Payloads
--    - Reverse shells
--    - Bind shells
--    - Meterpreter
--
-- 3. Auxiliary
--    - Scanners
--    - Fuzzers
--    - Spoofing
--
-- 4. Post
--    - Pós-exploração
--    - Privilege escalation
--    - Lateral movement

-- COMANDOS:
-- search [keyword]
-- use [exploit]
-- show options
-- set [option] [value]
-- exploit
-- sessions -l
-- sessions -i [id]

-- MELHORIA:
-- ERRADO: Usar exploits sem entender
-- CERTO: Estudar cada exploit antes de usar
```

#### PT005: SQL Injection
```lua
-- SKILL: SQL Injection Mastery
-- Nível: Intermediário → Expert
-- Contexto: Exploração de SQL injection

-- TIPOS:
-- 1. In-band (Classic)
--    - UNION-based
--    - Error-based
--
-- 2. Blind
--    - Boolean-based
--    - Time-based
--
-- 3. Out-of-band
--    - DNS
--    - HTTP requests
--
-- 4. Second-order
--    - Armazenado
--    - Executado depois

-- PAYLOADS:
-- ' OR '1'='1
-- ' UNION SELECT null,table_name FROM information_schema.tables--
-- ' AND SLEEP(5)--
-- ' AND 1=CONVERT(int,@@version)--

-- FERRAMENTAS:
-- - sqlmap
-- - Burp Suite
-- - Havij
-- - jSQL

-- MELHORIA:
-- ERRADO: Testar payloads cegamente
-- CERTO: Entender a estrutura do banco primeiro
```

#### PT006: Cross-Site Scripting (XSS)
```lua
-- SKILL: XSS Exploitation
-- Nível: Intermediário → Expert
-- Contexto: Exploração de XSS

-- TIPOS:
-- 1. Reflected XSS
--    - URL parameter
--    - Immediate execution
--
-- 2. Stored XSS
--    - Database
--    - Persistent
--    - Mais perigoso
--
-- 3. DOM-based XSS
--    - Client-side
--    - JavaScript

-- PAYLOADS:
-- <script>alert('XSS')</script>
-- <img src=x onerror=alert('XSS')>
-- <svg onload=alert('XSS')>
-- javascript:alert('XSS')

-- BYPASS:
-- <ScRiPt>alert('XSS')</ScRiPt>
-- <script>alert(String.fromCharCode(88,83,83))</script>
-- <img src=x onerror="&#97;&#108;&#101;&#114;&#116;(1)">

-- FERRAMENTAS:
-- - XSStrike
-- - Dalfox
-- - BeEF
-- - Burp Suite
```

#### PT007: Buffer Overflow
```lua
-- SKILL: Buffer Overflow Exploitation
-- Nível: Avançado → Expert
-- Contexto: Exploração de buffer overflow

-- CONCEITOS:
-- 1. Stack-based
--    - Return address
--    - EIP/RIP control
--    - Shellcode injection
--
-- 2. Heap-based
--    - Heap spray
--    - Use-after-free
--    - Double free
--
-- 3. Format String
--    - %x, %n
--    - Read/write memory

-- FERRAMENTAS:
-- - GDB
-- - Immunity Debugger
-- - OllyDbg
-- - pwntools (Python)
-- - ROPgadget

-- PROCESSO:
-- 1. Find vulnerability
-- 2. Determine offset
-- 3. Control EIP
-- 4. Find bad chars
-- 5. Generate shellcode
-- 6. Exploit
```

### Post-Exploitation (300)

#### PT008: Privilege Escalation
```lua
-- SKILL: Privilege Escalation
-- Nível: Avançado → Expert
-- Contexto: Escalar privilégios

-- LINUX:
-- 1. SUID binaries
--    - find / -perm -4000
--    - gtfoBins
--
-- 2. Kernel exploits
--    - Dirty Pipe
--    - Dirty COW
--    - PwnKit
--
-- 3. Sudo misconfig
--    - sudo -l
--    - NOPASSWD
--
-- 4. Capabilities
--    - getcap -r /
--
-- 5. Cron jobs
--    - Writable scripts
--    - PATH manipulation

-- WINDOWS:
-- 1. Token impersonation
--    - Potato attacks
--    - JuicyPotato
--
-- 2. Service exploits
--    - Unquoted paths
--    - Weak permissions
--
-- 3. Registry
--    - AlwaysInstallElevated
--    - Autorun
--
-- 4. UAC bypass
--    - Fodhelper
--    - ComputerDefaults

-- FERRAMENTAS:
-- - LinPEAS
-- - WinPEAS
-- - PowerUp
-- - BeRoot
-- - linux-exploit-suggester
```

#### PT009: Lateral Movement
```lua
-- SKILL: Lateral Movement Techniques
-- Nível: Avançado → Expert
-- Contexto: Mover-se na rede

-- TÉCNICAS:
-- 1. Pass the Hash
--    - NTLM hashes
--    - Mimikatz
--    - smbclient
--
-- 2. Pass the Ticket
--    - Kerberos tickets
--    - Rubeus
--
-- 3. PsExec
--    - Remote execution
--    - SMB
--
-- 4. WMI
--    - Windows Management
--    - Remote commands
--
-- 5. SSH
--    - Keys
--    - Agent forwarding
--
-- 6. RDP
--    - Session hijacking
--    - Credential stealing

-- FERRAMENTAS:
-- - Mimikatz
-- - Impacket
-- - CrackMapExec
-- - BloodHound
-- - SharpHound
```

#### PT010: Data Exfiltration
```lua
-- SKILL: Data Exfiltration Techniques
-- Nível: Avançado → Expert
-- Contexto: Sair dados da rede

-- TÉCNICAS:
-- 1. DNS Tunneling
--    - DNS queries
--    - Encoded data
--    -iodine, dnscat2
--
-- 2. HTTP/HTTPS
--    - Normal traffic
--    - Encrypted
--    - Steganography
--
-- 3. ICMP
--    - Ping tunnel
--    - Encoded in packets
--
-- 4. Social Media
--    - Twitter
--    - Telegram
--    - Legitimate services
--
-- 5. Physical
--    - USB
--    - Bluetooth
--    - WiFi

-- FERRAMENTAS:
-- - Covert_TCP
-- - DNScat2
-- - iodine
-- - Cloakify
```

---

## 🌐 Network Security Skills (700)

### Firewalls (200)

#### NS001: Firewall Configuration
```lua
-- SKILL: Firewall Configuration Mastery
-- Nível: Intermediário → Expert
-- Contexto: Configurar firewalls

-- TIPOS:
-- 1. Packet Filtering
--    - Stateless
--    - Rules-based
--    - IP, port, protocol
--
-- 2. Stateful Inspection
--    - Connection tracking
--    - Context-aware
--    - More secure
--
-- 3. Application Layer
--    - Deep packet inspection
--    - Protocol analysis
--    - WAF
--
-- 4. Next-Gen (NGFW)
--    - IPS integrated
--    - User identity
--    - Application awareness

-- FERRAMENTAS:
-- - iptables/nftables (Linux)
-- - Windows Firewall
-- - pfSense
-- - OPNsense
-- - Palo Alto
-- - Fortinet
-- - Cisco ASA

-- REGRAS:
-- - Default deny
-- - Least privilege
-- - Log everything
-- - Regular audit
```

### IDS/IPS (150)

#### NS002: Intrusion Detection Systems
```lua
-- SKILL: IDS/IPS Configuration
-- Nível: Intermediário → Expert
-- Contexto: Detectar/prevenir intrusões

-- TIPOS:
-- 1. Network-based (NIDS/NIPS)
--    - Monitor network traffic
--    - Signature-based
--    - Anomaly-based
--
-- 2. Host-based (HIDS/HIPS)
--    - Monitor host
--    - File integrity
--    - Log analysis

-- FERRAMENTAS:
-- - Snort (open source)
-- - Suricata (multi-threaded)
-- - Zeek (formerly Bro)
-- - OSSEC (HIDS)
-- - Wazuh (SIEM + HIDS)

-- ASSINATURAS:
-- - Regras Snort/Suricata
-- - Custom signatures
-- - Rule optimization
-- - False positive tuning

-- ANOMALY:
-- - Baseline establishment
-- - Statistical analysis
-- - Machine learning
-- - Behavioral analysis
```

### VPN (150)

#### NS003: VPN Configuration
```lua
-- SKILL: VPN Configuration Mastery
-- Nível: Intermediário → Expert
-- Contexto: Redes privadas virtuais

-- TIPOS:
-- 1. Site-to-Site
--    - IPsec
--    - Conecta redes
--    - Gateway to gateway
--
-- 2. Remote Access
--    - SSL VPN
--    - Client-to-site
--    - Work from home
--
-- 3. Mesh VPN
--    - WireGuard
--    - Tailscale
--    - Nebula

-- PROTOCOLOS:
-- - OpenVPN
-- - WireGuard
-- - IPsec/IKEv2
-- - L2TP/IPsec
-- - SSTP

-- FERRAMENTAS:
-- - OpenVPN
-- - WireGuard
-- - pfSense
-- - StrongSwan
-- - Tailscale

-- MELHORIA:
-- ERRADO: VPN sem kill switch
-- CERTO: VPN + kill switch + DNS leak protection
```

### Network Monitoring (200)

#### NS004: Network Traffic Analysis
```lua
-- SKILL: Network Traffic Analysis
-- Nível: Intermediário → Expert
-- Contexto: Analisar tráfego de rede

-- FERRAMENTAS:
-- 1. Wireshark
--    - Packet capture
--    - Protocol analysis
--    - Filtering
--    - Statistics
--
-- 2. tcpdump
--    - Command line
--    - Scripts
--    - Remote capture
--
-- 3. Zeek
--    - Network monitoring
--    - Logs estruturados
--    - Análise de segurança
--
-- 4. NetworkMiner
--    - Forenics
--    - Host identification
--    - File extraction

-- PROTOCOLOS:
-- - HTTP/HTTPS
-- - DNS
-- - DHCP
-- - ARP
-- - TCP/UDP
-- - ICMP
-- - SSH
-- - TLS

-- MÉTRICAS:
-- - Bandwidth usage
-- - Latency
-- - Packet loss
-- - Jitter
-- - Connections per second
```

---

## 💻 Application Security Skills (700)

### Web Application Security (300)

#### WAS001: OWASP Top 10 Mitigation
```lua
-- SKILL: OWASP Top 10 Mitigation
-- Nível: Intermediário → Expert
-- Contexto: Proteger aplicações web

-- TOP 10 (2021):
-- 1. Broken Access Control
--    - RBAC/ABAC
--    - Deny by default
--    - CORS config
--    - Token validation
--
-- 2. Cryptographic Failures
--    - TLS 1.3
--    - AES-256-GCM
--    - Key rotation
--    - No hardcoded keys
--
-- 3. Injection
--    - Parameterized queries
--    - Input validation
--    - ORM
--    - WAF
--
-- 4. Insecure Design
--    - Threat modeling
--    - Secure design patterns
--    - Reference architecture
--
-- 5. Security Misconfiguration
--    - Hardening
--    - Remove defaults
--    - Error handling
--
-- 6. Vulnerable Components
--    - SCA tools
--    - Dependency scanning
--    - Version pinning
--
-- 7. Auth Failures
--    - MFA
--    - Rate limiting
--    - Password policy
--    - Session management
--
-- 8. Data Integrity Failures
--    - CI/CD security
--    - Signed updates
--    - SBOM
--
-- 9. Logging Failures
--    - Audit logging
--    - SIEM integration
--    - Alerting
--
-- 10. SSRF
--     - Input validation
--     - Allowlists
--     - Network segmentation
```

### API Security (200)

#### AS001: API Security Best Practices
```lua
-- SKILL: API Security Best Practices
-- Nível: Intermediário → Expert
-- Contexto: Proteger APIs

-- AMEAÇAS:
-- 1. Broken Object Level Authorization (BOLA)
-- 2. Broken Authentication
-- 3. Excessive Data Exposure
-- 4. Lack of Resources & Rate Limiting
-- 5. Broken Function Level Authorization
-- 6. Mass Assignment
-- 7. Security Misconfiguration
-- 8. Injection
-- 9. Improper Assets Management
-- 10. Insufficient Logging

-- DEFESAS:
-- 1. Authentication
--    - OAuth 2.0
--    - JWT validation
--    - API keys
--
-- 2. Authorization
--    - RBAC
--    - Scope-based
--    - Resource-level
--
-- 3. Rate Limiting
--    - Per-client
--    - Per-endpoint
--    - Sliding window
--
-- 4. Input Validation
--    - Schema validation
--    - Type checking
--    - Sanitization
--
-- 5. Encryption
--    - TLS everywhere
--    - Payload encryption
--    - At-rest encryption

-- FERRAMENTAS:
-- - OWASP API Security Top 10
-- - Postman security
-- - 42Crunch
-- - Salt Security
```

### Mobile Application Security (200)

#### MAS001: Mobile Security Testing
```lua
-- SKILL: Mobile Security Testing
-- Nível: Intermediário → Expert
-- Contexto: Testar segurança mobile

-- PLATAFORMAS:
-- 1. iOS
--    - Keychain
--    - Code signing
--    - App Transport Security
--    - Jailbreak detection
--
-- 2. Android
--    - Manifest permissions
--    - ProGuard/R8
--    - Root detection
--    - SafetyNet/Play Integrity

-- FERRAMENTAS:
-- - MobSF (Mobile Security Framework)
-- - Frida (dynamic instrumentation)
-- - Objection (runtime exploration)
-- - drozer (Android security)
-- - Needle (iOS security)
-- - Burp Suite (proxy)

-- TESTES:
-- 1. Static Analysis (SAST)
--    - Code review
--    - Manifest analysis
--    - Library vulnerabilities
--
-- 2. Dynamic Analysis (DAST)
--    - Runtime behavior
--    - Network traffic
--    - Data storage
--
-- 3. Network Analysis
--    - SSL/TLS testing
--    - Certificate pinning bypass
--    - MITM attacks

-- AMEAÇAS:
-- - Insecure storage
-- - Weak cryptography
-- - Insecure communication
-- - Insecure authentication
-- - Code reverse engineering
```

---

## 🔐 Cryptography Skills (600)

### Symmetric Encryption (200)

#### SE001: AES Implementation
```lua
-- SKILL: AES Implementation Mastery
-- Nível: Avançado → Expert
-- Contexto: Criptografia simétrica

-- CONFIGURAÇÕES:
-- 1. Key Size
--    - AES-128 (menos seguro)
--    - AES-192 (balanceado)
--    - AES-256 (mais seguro)
--
-- 2. Mode of Operation
--    - ECB (nunca usar!)
--    - CBC (necessita padding)
--    - CTR (paralelizável)
--    - GCM (recomendado)
--    - CCM (para dispositivos)
--
-- 3. Padding
--    - PKCS#7
--    - OAEP (para RSA)
--    - No padding (CTR/GCM)

-- IMPLEMENTAÇÃO:
```python
# Python example
from cryptography.hazmat.primitives.ciphers import Cipher, algorithms, modes
from cryptography.hazmat.backends import default_backend
import os

key = os.urandom(32)  # AES-256
iv = os.urandom(12)   # GCM recommends 12 bytes

cipher = Cipher(algorithms.AES(key), modes.GCM(iv), backend=default_backend())
encryptor = cipher.encryptor()
ct = encryptor.update(b"secret data") + encryptor.finalize()
tag = encryptor.tag
```

-- ERROS COMUNS:
-- - Usar ECB mode
-- - Reutilizar IV/nonce
-- - Chaves fracas
-- - Não autenticar (GCM)
```

### Asymmetric Encryption (200)

#### AE001: RSA Best Practices
```lua
-- SKILL: RSA Best Practices
-- Nível: Avançado → Expert
-- Contexto: Criptografia assimétrica

-- CONFIGURAÇÕES:
-- 1. Key Size
--    - 2048 bits (mínimo)
--    - 3072 bits (recomendado)
--    - 4096 bits (alto segurança)
--
-- 2. Padding
--    - PKCS#1 v1.5 (legado)
--    - OAEP (recomendado)
--    - PSS (para assinaturas)
--
-- 3. Hash
--    - SHA-256
--    - SHA-384
--    - SHA-512

-- USOS:
-- - Key exchange
-- - Digital signatures
-- - Encrypted communication
-- - Certificate authorities

-- ALTERNATIVAS MODERNAS:
-- - ECC (menor tamanho)
-- - X25519 (mais rápido)
-- - Ed25519 (assínatura)

-- ERROS COMUNS:
-- - Chaves muito pequenas
-- - Padding inadequado
-- - Não rotacionar chaves
```

### Hashing (100)

#### H001: Password Hashing
```lua
-- SKILL: Password Hashing Mastery
-- Nível: Intermediário → Expert
-- Contexto: Armazenar senhas

-- ALGORITMOS:
-- 1. Argon2id (recomendado)
--    - Memory-hard
--    - GPU-resistant
--    - Winner do PHC
--
-- 2. bcrypt
--    - Time-hard
--    - Amplamente suportado
--    - Cost factor
--
-- 3. scrypt
--    - Memory-hard
--    - Parâmetros ajustáveis
--
-- 4. PBKDF2
--    - NIST approved
--    - Simples
--    - Menos seguro

-- PARÂMETROS:
-- - Argon2id: memory=64MB, iterations=3, parallelism=4
-- - bcrypt: cost=12
-- - scrypt: N=16384, r=8, p=1

-- IMPLEMENTAÇÃO:
```python
# Argon2id example
from argon2 import PasswordHasher

ph = PasswordHasher(
    time_cost=3,
    memory_cost=65536,
    parallelism=4
)
hash = ph.hash("password")
verified = ph.verify(hash, "password")
```

-- ERROS COMUNS:
-- - MD5/SHA para senhas
-- - Sem salt
-- - Salt reutilizado
-- - Custos muito baixos
```

### Key Management (100)

#### KM001: Key Management Best Practices
```lua
-- SKILL: Key Management Best Practices
-- Nível: Avançado → Expert
-- Contexto: Gerenciar chaves de criptografia

-- CICLO DE VIDA:
-- 1. Generation
--    - RNG criptográfico
--    - Entropy adequada
--    - Hardware RNG
--
-- 2. Storage
--    - HSM/KMS
--    - Key vault
--    - Never in code
--
-- 3. Distribution
--    - Secure channels
--    - Key encapsulation
--    - Certificate-based
--
-- 4. Rotation
--    - Automatic rotation
--    - Versioning
--    - Backward compatibility
--
-- 5. Revocation
--    - CRL
--    - OCSP
--    - Emergency revocation
--
-- 6. Destruction
--    - Secure erasure
--    - Audit trail
--    - Compliance

-- FERRAMENTAS:
-- - AWS KMS
-- - Azure Key Vault
-- - Google Cloud KMS
-- - HashiCorp Vault
-- - Thales Luna HSM

-- COMPLIANCE:
-- - NIST SP 800-57
-- - FIPS 140-2
-- - PCI DSS
-- - HIPAA
```

---

## 🆔 Identity & Access Skills (600)

### Authentication (200)

#### IAM001: Authentication Methods
```lua
-- SKILL: Authentication Methods
-- Nível: Intermediário → Expert
-- Contexto: Autenticação segura

-- MÉTODAS:
-- 1. Password-based
--    - Password policy
--    - MFA
--    - Account lockout
--
-- 2. Token-based
--    - JWT
--    - Session tokens
--    - API keys
--
-- 3. Certificate-based
--    - Client certificates
--    - Mutual TLS
--    - Smart cards
--
-- 4. Biometric
--    - Fingerprint
--    - Face recognition
--    - Iris scan
--
-- 5. Passwordless
--    - WebAuthn/FIDO2
--    - Magic links
--    - Passkeys

-- MFA:
-- - TOTP (Google Authenticator)
-- - SMS (menos seguro)
-- - Push notifications
-- - Hardware tokens (YubiKey)
-- - Backup codes

-- MELHORIA:
-- ERRADO: Apenas senha
-- CERTO: Senha + MFA
```

### Authorization (200)

#### IA001: Authorization Models
```lua
-- SKILL: Authorization Models
-- Nível: Intermediário → Expert
-- Contexto: Controle de acesso

-- MODELOS:
-- 1. RBAC (Role-Based)
--    - Roles
--    - Permissions
--    - Simples
--
-- 2. ABAC (Attribute-Based)
--    - Policies
--    - Attributes
--    - Flexível
--
-- 3. ACL (Access Control List)
--    - Resource-based
--    - Granular
--
-- 4. ReBAC (Relationship-Based)
--    - Relationships
--    - Graph-based
--    - Zanzibar

-- IMPLEMENTAÇÃO:
```python
# RBAC example
class RBAC:
    def __init__(self):
        self.roles = {
            "admin": ["read", "write", "delete"],
            "editor": ["read", "write"],
            "viewer": ["read"]
        }
    
    def check_permission(self, role, permission):
        return permission in self.roles.get(role, [])
```

-- MELHORIA:
-- ERRADO: Hardcoded permissions
-- CERTO: Policy-based, auditable
```

### Single Sign-On (200)

#### SSO001: SSO Implementation
```lua
-- SKILL: Single Sign-On Implementation
-- Nível: Intermediário → Expert
-- Contexto: Login único

-- PROTOCOLOS:
-- 1. SAML 2.0
--    - XML-based
--    - Enterprise
--    - Federation
--
-- 2. OAuth 2.0
--    - Authorization
--    - Delegated access
--    - Modern
--
-- 3. OpenID Connect
--    - Authentication layer
--    - ID tokens
--    - Built on OAuth
--
-- 4. WS-Federation
--    - Microsoft
--    - Legacy

-- FLUXO:
-- 1. User clicks login
-- 2. Redirect to IdP
-- 3. Authenticate
-- 4. Return token
-- 5. Validate token
-- 6. Create session

-- FERRAMENTAS:
-- - Auth0
-- - Okta
-- - Keycloak
-- - Azure AD
-- - OneLogin

-- MELHORIA:
-- ERRADO: Múltiplos logins
-- CERTO: SSO + MFA
```

---

## 🚨 Incident Response Skills (500)

### Detection (150)

#### IR001: Security Monitoring
```lua
-- SKILL: Security Monitoring
-- Nível: Intermediário → Expert
-- Contexto: Monitorar segurança

-- SOURCES:
-- 1. Logs
--    - System logs
--    - Application logs
--    - Security logs
--
-- 2. Network
--    - IDS/IPS alerts
--    - NetFlow
--    - DNS logs
--
-- 3. Endpoints
--    - EDR alerts
--    - File integrity
--    - Process monitoring
--
-- 4. Cloud
--    - CloudTrail
--    - Azure Monitor
--    - GCP Logging

-- SIEM:
-- - Splunk
-- - ELK Stack
-- - QRadar
-- - Sentinel
-- - Chronicle

-- USE CASES:
-- - Brute force
-- - Privilege escalation
-- - Lateral movement
-- - Data exfiltration
-- - Malware detection
```

### Response (200)

#### IR002: Incident Response Process
```lua
-- SKILL: Incident Response Process
-- Nível: Intermediário → Expert
-- Contexto: Responder a incidentes

-- FASES:
-- 1. Preparation
--    - Runbooks
--    - Team training
--    - Tools ready
--
-- 2. Identification
--    - Detect
--    - Triage
--    - Classify
--
-- 3. Containment
--    - Short-term
--    - Long-term
--    - Evidence preservation
--
-- 4. Eradication
--    - Remove threat
--    - Patch vulnerabilities
--    - Reset credentials
--
-- 5. Recovery
--    - Restore systems
--    - Monitor
--    - Validate
--
-- 6. Lessons Learned
--    - Post-mortem
--    - Improve process
--    - Update runbooks

-- FERRAMENTAS:
-- - TheHive
-- - Cortex
-- - MISP
-- - IRIS
```

### Forensics (150)

#### IR003: Digital Forensics
```lua
-- SKILL: Digital Forensics
-- Nível: Avançado → Expert
-- Contexto: Investigação forense

-- TYPES:
-- 1. Disk Forensics
--    - Disk images
--    - File recovery
--    - Timeline analysis
--
-- 2. Memory Forensics
--    - RAM dumps
--    - Volatility
--    - Process analysis
--
-- 3. Network Forensics
--    - Packet capture
--    - Log analysis
--    - Timeline
--
-- 4. Mobile Forensics
--    - Extraction
--    - Analysis
--    - Reporting

-- FERRAMENTAS:
-- - Autopsy
-- - FTK
-- - EnCase
-- - Volatility
-- - Wireshark
-- - Cellebrite

-- PROCESSO:
-- 1. Evidence collection
-- 2. Chain of custody
-- 3. Analysis
-- 4. Reporting
-- 5. Expert testimony
```

---

## ☁️ Cloud Security Skills (500)

### AWS Security (200)

#### AWS001: AWS Security Best Practices
```lua
-- SKILL: AWS Security Best Practices
-- Nível: Intermediário → Expert
-- Contexto: Segurança na AWS

-- SERVIÇOS:
-- 1. IAM
--    - Least privilege
--    - MFA
--    - Roles
--    - Policies
--
-- 2. KMS
--    - Encryption keys
--    - Envelope encryption
--    - Rotation
--
-- 3. CloudTrail
--    - API logging
--    - Auditing
--    - Compliance
--
-- 4. GuardDuty
--    - Threat detection
--    - ML-based
--    - Continuous
--
-- 5. Security Hub
--    - Centralized
--    - Standards
--    - Compliance

-- BEST PRACTICES:
-- - Encrypt everything
-- - VPC segmentation
-- - Security groups
-- - NACLs
-- - WAF
-- - Shield
-- - Config rules
```

### Azure Security (150)

#### AZ001: Azure Security Best Practices
```lua
-- SKILL: Azure Security Best Practices
-- Nível: Intermediário → Expert
-- Contexto: Segurança no Azure

-- SERVIÇOS:
-- 1. Azure AD
--    - Identity management
--    - Conditional access
--    - PIM
--
-- 2. Key Vault
--    - Secrets management
--    - Key management
--    - Certificates
--
-- 3. Security Center
--    - Secure score
--    - Recommendations
--    - Compliance
--
-- 4. Sentinel
--    - SIEM
--    - SOAR
--    - Threat hunting
--
-- 5. Defender
--    - Cloud workload protection
--    - Threat protection
--    - Vulnerability management

-- BEST PRACTICES:
-- - Zero Trust
-- - Least privilege
-- - Encryption
-- - Monitoring
-- - Compliance
```

### GCP Security (150)

#### GCP001: GCP Security Best Practices
```lua
-- SKILL: GCP Security Best Practices
-- Nível: Intermediário → Expert
-- Contexto: Segurança no GCP

-- SERVIÇOS:
-- 1. Cloud IAM
--    - Policies
--    - Roles
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
--
-- 5. VPC Service Controls
--    - Perimeter security
--    - Data exfiltration prevention

-- BEST PRACTICES:
-- - Organization policies
-- - Resource hierarchy
-- - Network segmentation
-- - Audit logging
-- - Encryption
```

---

## 🔄 DevSecOps Skills (400)

### CI/CD Security (200)

#### DS001: Secure CI/CD Pipeline
```lua
-- SKILL: Secure CI/CD Pipeline
-- Nível: Intermediário → Expert
-- Contexto: Segurança em pipelines

-- STAGES:
-- 1. Source Code
--    - Secret scanning
--    - SAST
--    - License scanning
--
-- 2. Build
--    - Dependency scanning
--    - SCA
--    - Container scanning
--
-- 3. Test
--    - DAST
--    - IAST
--    - Pen testing
--
-- 4. Deploy
--    - Configuration validation
--    - Infrastructure scanning
--    - Compliance checks
--
-- 5. Monitor
--    - Runtime protection
--    - Logging
--    - Alerting

-- FERRAMENTAS:
-- - SonarQube (SAST)
-- - Snyk (SCA)
-- - Trivy (containers)
-- - OWASP ZAP (DAST)
-- - Checkov (IaC)
-- - tfsec (Terraform)

-- MELHORIA:
-- ERRADO: Security como última etapa
-- CERTO: Security em cada etapa
```

### Container Security (200)

#### CS001: Container Security
```lua
-- SKILL: Container Security
-- Nível: Intermediário → Expert
-- Contexto: Segurança de containers

-- NÍVEIS:
-- 1. Image Security
--    - Base image scanning
--    - Multi-stage builds
--    - Minimal images
--    - Signed images
--
-- 2. Registry Security
--    - Access control
--    - Vulnerability scanning
--    - Content trust
--
-- 3. Runtime Security
--    - Least privilege
--    - Resource limits
--    - Read-only filesystem
--    - No privileged
--
-- 4. Orchestrator Security
--    - RBAC
--    - Network policies
--    - Secrets management
--    - Audit logging

-- FERRAMENTAS:
-- - Trivy
-- - Clair
-- - Anchore
-- - Falco
-- - OPA/Gatekeeper
-- - Aqua Security

-- MELHORIA:
-- ERRADO: Running as root
-- CERTO: Non-root user + read-only + resource limits
```

---

*Cybersecurity Skills v1.0 - Setembro 2026*