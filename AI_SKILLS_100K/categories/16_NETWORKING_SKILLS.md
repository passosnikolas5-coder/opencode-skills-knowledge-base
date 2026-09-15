# 🌐 Networking Skills - 3.000 Skills

> **Todas as habilidades de redes documentadas**

---

## 📊 Visão Geral

| Subcategoria | Skills | Nível |
|--------------|--------|-------|
| Network Fundamentals | 500 | Básico → Expert |
| Routing & Switching | 500 | Intermediário → Expert |
| Network Security | 500 | Intermediário → Expert |
| Cloud Networking | 400 | Intermediário → Expert |
| Wireless Networks | 300 | Intermediário → Expert |
| Network Automation | 300 | Intermediário → Expert |
| Network Monitoring | 300 | Intermediário → Expert |
| Content Delivery | 200 | Intermediário → Expert |

---

## 📡 Network Fundamentals (500)

### OSI Model (100)

#### NET001: OSI Model Mastery
```lua
-- SKILL: OSI Model Mastery
-- Nível: Básico → Expert
-- Contexto: Modelo OSI

-- CAMADAS:
-- 1. Physical: cables, connectors
-- 2. Data Link: MAC, switches
-- 3. Network: IP, routers
-- 4. Transport: TCP, UDP
-- 5. Session: sessions, sockets
-- 6. Presentation: encryption, compression
-- 7. Application: HTTP, DNS, SMTP

-- MELHORIA:
-- ERRADO: Ignorar camadas inferiores
-- CERTO: Understanding all layers for troubleshooting
```

### TCP/IP (100)

#### NET002: TCP/IP Protocol Suite
```lua
-- SKILL: TCP/IP Protocol Suite
-- Nível: Básico → Expert
-- Contexto: Suite TCP/IP

-- PROTOCOLOS:
-- 1. IP: addressing, subnetting
-- 2. TCP: reliable, connection-oriented
-- 3. UDP: unreliable, connectionless
-- 4. ICMP: diagnostics (ping, traceroute)
-- 5. ARP: address resolution
-- 6. DHCP: dynamic addressing
-- 7. DNS: name resolution

-- MELHORIA:
-- ERRADO: TCP for everything
-- CERTO: Choose protocol based on needs
```

### Subnetting (100)

#### NET003: IP Subnetting
```lua
-- SKILL: IP Subnetting
-- Nível: Básico → Expert
-- Contexto: Sub-rede IP

-- CONCEITOS:
-- 1. CIDR: Classless Inter-Domain Routing
-- 2. Subnet Masks: /24, /16, etc.
-- 3. VLSM: Variable Length Subnet Masking
-- 4. Supernetting: route aggregation
-- 5. IPv6: expanded address space

-- MÉTODOS:
-- Binary calculation
-- Magic number method
-- Quick subnetting

-- MELHORIA:
-- ERRADO: Classful addressing
-- CERTO: CIDR + VLSM for efficiency
```

### Network Devices (100)

#### NET004: Network Devices
```lua
-- SKILL: Network Devices
-- Nível: Básico → Expert
-- Contexto: Dispositivos de rede

-- DISPOSITIVOS:
-- 1. Hub: layer 1, broadcast
-- 2. Switch: layer 2, MAC-based
-- 3. Router: layer 3, IP-based
-- 4. Firewall: security, filtering
-- 5. Load Balancer: traffic distribution
-- 6. Wireless AP: Wi-Fi access

-- MELHORIA:
-- ERRADO: Hub in modern networks
-- CERTO: Managed switches + routers + firewalls
```

### Network Topologies (100)

#### NET005: Network Topologies
```lua
-- SKILL: Network Topologies
-- Nível: Básico → Expert
-- Contexto: Topologias de rede

-- TIPOS:
-- 1. Star: central hub/switch
-- 2. Ring: circular connection
-- 3. Bus: shared medium
-- 4. Mesh: full/partial interconnection
-- 5. Tree: hierarchical

-- MELHORIA:
-- ERRADO: Bus topology (legacy)
-- CERTO: Star + mesh for redundancy
```

---

## 🔄 Routing & Switching (500)

### Routing Protocols (200)

#### NET006: Routing Protocols
```lua
-- SKILL: Routing Protocols
-- Nível: Intermediário → Expert
-- Contexto: Protocolos de roteamento

-- PROTOCOLOS:
-- 1. OSPF: link-state, interior
-- 2. BGP: path-vector, exterior
-- 3. EIGRP: Cisco proprietary
-- 4. RIP: distance-vector (legacy)
-- 5. IS-IS: link-state, ISP

-- CONCEITOS:
-- Metric: cost, bandwidth, hop count
-- Convergence: speed of updates
-- Redistribution: protocol translation

-- MELHORIA:
-- ERRADO: RIP for large networks
-- CERTO: OSPF/BGP for scalability
```

### Switching Technologies (150)

#### NET007: Switching Technologies
```lua
-- SKILL: Switching Technologies
-- Nível: Intermediário → Expert
-- Contexto: Tecnologias de switching

-- CONCEITOS:
-- 1. VLANs: virtual LANs
-- 2. Trunking: 802.1Q
-- 3. Spanning Tree: loop prevention
-- 4. EtherChannel: link aggregation
-- 5. Port Security: MAC limiting

-- MELHORIA:
-- ERRADO: Flat network
-- CERTO: VLANs + proper segmentation
```

### WAN Technologies (150)

#### NET008: WAN Technologies
```lua
-- SKILL: WAN Technologies
-- Nível: Intermediário → Expert
-- Contexto: Tecnologias WAN

-- TIPOS:
-- 1. MPLS: label switching
-- 2. VPN: IPsec, SSL
-- 3. SD-WAN: software-defined
-- 4. Metro Ethernet: L2 WAN
-- 5. Dark Fiber: dedicated

-- MELHORIA:
-- ERRADO: Traditional MPLS only
-- CERTO: SD-WAN + hybrid connectivity
```

---

## 🔒 Network Security (500)

### Firewalls (150)

#### NET009: Firewall Management
```lua
-- SKILL: Firewall Management
-- Nível: Intermediário → Expert
-- Contexto: Gestão de firewalls

-- TIPOS:
-- 1. Packet Filtering: stateless
-- 2. Stateful Inspection: connection tracking
-- 3. NGFW: deep packet inspection
-- 4. WAF: web application firewall
-- 5. Cloud Firewall: cloud-native

-- MELHORIA:
-- ERRADO: Allow all inbound
-- CERTO: Default deny + explicit allow
```

### IDS/IPS (100)

#### NET010: Intrusion Detection/Prevention
```lua
-- SKILL: IDS/IPS
-- Nível: Intermediário → Expert
-- Contexto: Detecção/Prevenção de intrusão

-- CONCEITOS:
-- 1. Signature-based: known patterns
-- 2. Anomaly-based: baseline deviation
-- 3. Host-based: HIDS/HIPS
-- 4. Network-based: NIDS/NIPS

-- FERRAMENTAS:
-- Snort, Suricata (open source)
-- Palo Alto, Fortinet (commercial)

-- MELHORIA:
-- ERRADO: No IDS/IPS
-- CERTO: NIDS + HIPS + SIEM integration
```

### VPN (100)

#### NET011: VPN Technologies
```lua
-- SKILL: VPN Technologies
-- Nível: Intermediário → Expert
-- Contexto: Tecnologias VPN

-- TIPOS:
-- 1. Site-to-Site: network-to-network
-- 2. Remote Access: client-to-network
-- 3. SSL/TLS VPN: browser-based
-- 4. WireGuard: modern, fast
-- 5. Zero Trust: identity-based

-- MELHORIA:
-- ERRADO: Traditional VPN only
-- CERTO: Zero Trust Network Access (ZTNA)
```

### Network Segmentation (150)

#### NET012: Network Segmentation
```lua
-- SKILL: Network Segmentation
-- Nível: Intermediário → Expert
-- Contexto: Segmentação de rede

-- MÉTODOS:
-- 1. VLANs: layer 2 segmentation
-- 2. Subnets: layer 3 segmentation
-- 3. Microsegmentation: zero trust
-- 4. DMZ: public-facing services
-- 5. VRF: virtual routing/forwarding

-- MELHORIA:
-- ERRADO: Flat network
-- CERTO: Defense-in-depth segmentation
```

---

## ☁️ Cloud Networking (400)

### AWS Networking (150)

#### NET013: AWS Networking
```lua
-- SKILL: AWS Networking
-- Nível: Intermediário → Expert
-- Contexto: Networking AWS

-- SERVIÇOS:
-- 1. VPC: virtual private cloud
-- 2. Subnets: public, private
-- 3. Security Groups: stateful firewall
-- 4. NACLs: stateless firewall
-- 5. Load Balancers: ALB, NLB
-- 6. Direct Connect: dedicated link

-- MELHORIA:
-- ERRADO: Public subnets for everything
-- CERTO: Private subnets + NAT + bastion
```

### Azure Networking (100)

#### NET014: Azure Networking
```lua
-- SKILL: Azure Networking
-- Nível: Intermediário → Expert
-- Contexto: Networking Azure

-- SERVIÇOS:
-- 1. VNet: virtual network
-- 2. NSGs: network security groups
-- 3. Azure Firewall: managed firewall
-- 4. ExpressRoute: dedicated connection
-- 5. Azure Front Door: global load balancer

-- MELHORIA:
-- ERRADO: No network segmentation
-- CERTO: Hub-spoke topology + NSGs
```

### GCP Networking (50)

#### NET015: GCP Networking
```lua
-- SKILL: GCP Networking
-- Nível: Intermediário → Expert
-- Contexto: Networking GCP

-- SERVIÇOS:
-- 1. VPC: global VPC
-- 2. Cloud Armor: DDoS protection
-- 3. Cloud CDN: content delivery
-- 4. Cloud Interconnect: dedicated
-- 5. Cloud NAT: managed NAT

-- MELHORIA:
-- ERRADO: Default networking
-- CERTO: Custom VPC + firewall rules
```

### Multi-Cloud Networking (100)

#### NET016: Multi-Cloud Networking
```lua
-- SKILL: Multi-Cloud Networking
-- Nível: Avançado → Expert
-- Contexto: Networking multi-cloud

-- DESAFIOS:
-- 1. Connectivity: VPN, interconnect
-- 2. Security: consistent policies
-- 3. DNS: global name resolution
-- 4. Load Balancing: global traffic
-- 5. Monitoring: unified visibility

-- SOLUÇÕES:
-- Terraform, Pulumi (IaC)
-- Consul, Istio (service mesh)
-- Aviatrix, Alkira (multi-cloud)

-- MELHORIA:
-- ERRADO: Siloed cloud networks
-- CERTO: Unified multi-cloud networking
```

---

## 📶 Wireless Networks (300)

### Wi-Fi Technologies (150)

#### NET017: Wi-Fi Technologies
```lua
-- SKILL: Wi-Fi Technologies
-- Nível: Intermediário → Expert
-- Contexto: Tecnologias Wi-Fi

-- PADRÕES:
-- 1. 802.11ax (Wi-Fi 6): high efficiency
-- 2. 802.11ac (Wi-Fi 5): wave 1 & 2
-- 3. 802.11n (Wi-Fi 4): legacy
-- 4. Wi-Fi 6E: 6 GHz band
-- 5. Wi-Fi 7: multi-link operation

-- CONCEITOS:
-- Channels, SSIDs, Security (WPA3)
-- QoS, Roaming, Mesh

-- MELHORIA:
-- ERRADO: WEP/WPA (insecure)
-- CERTO: WPA3 + proper channel planning
```

### Network Design (100)

#### NET018: Network Design
```lua
-- SKILL: Network Design
-- Nível: Intermediário → Expert
-- Contexto: Design de rede

-- PRINCÍPIOS:
-- 1. Redundancy: no single point of failure
-- 2. Scalability: growth planning
-- 3. Performance: bandwidth, latency
-- 4. Security: defense-in-depth
-- 5. Manageability: monitoring, automation

-- MELHORIA:
-- ERRADO: Ad-hoc network growth
-- CERTO: Planned design + documentation
```

### Network Automation (50)

#### NET019: Wireless Network Automation
```lua
-- SKILL: Wireless Network Automation
-- Nível: Intermediário → Expert
-- Contexto: Automação de rede wireless

-- FERRAMENTAS:
-- 1. Cisco DNA Center
-- 2. Aruba Central
-- 3. Mist AI
-- 4. Cloud-managed (Meraki)

-- CONCEITOS:
-- Zero-touch provisioning
-- AI-driven optimization
-- Self-healing networks

-- MELHORIA:
-- ERRADO: Manual wireless management
-- CERTO: AI-driven wireless automation
```

---

## 🤖 Network Automation (300)

### Infrastructure as Code (150)

#### NET020: Network Infrastructure as Code
```lua
-- SKILL: Network Infrastructure as Code
-- Nível: Intermediário → Expert
-- Contexto: IaC para redes

-- FERRAMENTAS:
-- 1. Ansible: playbooks, roles
-- 2. Terraform: multi-vendor
-- 3. Nornir: Python-based
-- 4. Netmiko: SSH automation
-- 5. NAPALM: multi-vendor API

-- MELHORIA:
-- ERRADO: CLI configuration
-- CERTO: Code-based configuration + version control
```

### Intent-Based Networking (100)

#### NET021: Intent-Based Networking
```lua
-- SKILL: Intent-Based Networking
-- Nível: Avançado → Expert
-- Contexto: Networking baseado em intenção

-- CONCEITOS:
-- 1. Intent: desired outcome
-- 2. Translation: intent → config
-- 3. Validation: verify compliance
-- 4. Assurance: continuous monitoring

-- PLATAFORMAS:
-- Cisco DNA Center
-- Apstra (Juniper)
-- Alkira

-- MELHORIA:
-- ERRADO: Manual configuration
-- CERTO: Intent-based + automated validation
```

### API-Driven Networking (50)

#### NET022: API-Driven Networking
```lua
-- SKILL: API-Driven Networking
-- Nível: Intermediário → Expert
-- Contexto: Networking via APIs

-- APIs:
-- 1. REST: HTTP-based
-- 2. gRPC: high-performance
-- 3. NETCONF/YANG: standard
-- 4. OpenConfig: vendor-neutral

-- FERRAMENTAS:
-- Postman, HTTPie
-- Python requests
-- Go client libraries

-- MELHORIA:
-- ERRADO: CLI-only management
-- CERTO: API-first + automation
```

---

## 📊 Network Monitoring (300)

### SNMP (100)

#### NET023: SNMP Monitoring
```lua
-- SKILL: SNMP Monitoring
-- Nível: Intermediário → Expert
-- Contexto: Monitoramento SNMP

-- CONCEITOS:
-- 1. MIBs: Management Information Base
-- 2. OIDs: Object Identifiers
-- 3. Traps: asynchronous alerts
-- 4. Polling: periodic queries
-- 5. Community Strings: authentication

-- FERRAMENTAS:
-- Zabbix, Nagios, LibreNMS
-- PRTG, SolarWinds

-- MELHORIA:
-- ERRADO: SNMP v1/v2c (insecure)
-- CERTO: SNMP v3 + encrypted community
```

### NetFlow (100)

#### NET024: NetFlow Analysis
```lua
-- SKILL: NetFlow Analysis
-- Nível: Intermediário → Expert
-- Contexto: Análise de NetFlow

-- CONCEITOS:
-- 1. Flow Records: source, destination, ports
-- 2. SFlow: sampled flow data
-- 3. IPFIX: standardized flow
-- 4. Application Visibility: deep packet
-- 5. Traffic Analysis: bandwidth, patterns

-- FERRAMENTAS:
-- PRTG, SolarWinds
-- ntopng, ManageEngine

-- MELHORIA:
-- ERRADO: No traffic visibility
-- CERTO: Full traffic analysis + alerting
```

### Network Diagnostics (100)

#### NET025: Network Diagnostics
```lua
-- SKILL: Network Diagnostics
-- Nível: Básico → Expert
-- Contexto: Diagnóstico de rede

-- FERRAMENTAS:
-- 1. Ping: connectivity test
-- 2. Traceroute: path discovery
-- 3. nslookup/dig: DNS queries
-- 4. tcpdump: packet capture
-- 5. Wireshark: packet analysis
-- 6. netstat/ss: connection info

-- MELHORIA:
-- ERRADO: Ping only
-- CERTO: Full diagnostic toolkit
```

---

## 🌐 Content Delivery (200)

### CDN (100)

#### NET026: CDN Architecture
```lua
-- SKILL: CDN Architecture
-- Nível: Intermediário → Expert
-- Contexto: Arquitetura CDN

-- CONCEITOS:
-- 1. Edge Locations: global PoPs
-- 2. Origin Shield: origin protection
-- 3. Cache Rules: TTL, invalidation
-- 4. SSL/TLS: certificates
-- 5. DDoS Protection: edge security

-- PROVIDERS:
-- Cloudflare, Akamai
-- AWS CloudFront, Azure CDN
-- Fastly, KeyCDN

-- MELHORIA:
-- ERRADO: No CDN
-- CERTO: CDN for static + dynamic content
```

### Edge Computing (100)

#### NET027: Edge Computing
```lua
-- SKILL: Edge Computing
-- Nível: Intermediário → Expert
-- Contexto: Computação de borda

-- CONCEITOS:
-- 1. Edge Functions: serverless at edge
-- 2. Edge Databases: local data
-- 3. Edge AI: inference at edge
-- 4. Edge Caching: reduced latency
-- 5. Edge Security: WAF at edge

-- PLATAFORMAS:
-- Cloudflare Workers
-- AWS Lambda@Edge
-- Vercel Edge Functions

-- MELHORIA:
-- ERRADO: All compute in central cloud
-- CERTO: Edge for low-latency workloads
```

---

*Networking Skills v1.0 - Setembro 2026*