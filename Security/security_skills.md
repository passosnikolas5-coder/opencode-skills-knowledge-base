# Documentação Completa de Skills de Segurança

**Data de Geração:** 14/09/2026  
**Total de Skills Documentadas:** 88  
**Categorias:** 3

---

## Índice

1. [Security Category (80 skills)](#security-category)
2. [Pentest Tools Category (1 skill)](#pentest-tools-category)
3. [Document Verification Category (7 skills)](#document-verification-category)

---

## Security Category

### 1. 007
**Descrição:** Auditoria de segurança, hardening, modelagem de ameaças (STRIDE/PASTA), Red/Blue Team, verificações OWASP, revisão de código, resposta a incidentes e segurança de infraestrutura.

**Quando usar:** Para projetos que precisam de uma auditoria de segurança completa ou modelagem de ameaças.

**Exemplo prático:** Auditar um aplicativo web antes do lançamento em produção, identificando vulnerabilidades OWASP Top 10 e implementando correções.

---

### 2. anti-reversing-techniques
**Descrição:** Técnicas de segurança de uso duplo para ofuscação de código e prevenção de engenharia reversa. **APENAS PARA USO AUTORIZADO.**

**Quando usar:** Proteger propriedade intelectual e código proprietário contra engenharia reversa não autorizada.

**Exemplo prático:** Ofuscar um aplicativo móvel para dificultar a extração de chaves de API ou algoritmos proprietários.

---

### 3. attack-tree-construction
**Descrição:** Construir árvores de ataque abrangentes para visualizar caminhos de ameaças.

**Quando usar:** Mapear cenários de ataque, identificar lacunas de defesa ou comunicar riscos de segurança a stakeholders.

**Exemplo prático:** Criar uma árvore de ataque para um sistema bancário online, mapeando vetores como phishing, brute force e exploração de APIs.

---

### 4. audit-skills
**Descrição:** Auditor de segurança especialista para Skills e Bundles de IA. Realiza análise estática não intrusiva para identificar padrões maliciosos, vazamentos de dados e payloads ofuscados.

**Quando usar:** Antes de instalar qualquer skill ou extensão de IA para verificar se é segura.

**Exemplo prático:** Auditar uma skill de terceiros antes de autorizar sua instalação em um ambiente corporativo.

---

### 5. auth-implementation-patterns
**Descrição:** Implementar ou revisar autenticação e autorização com limites explícitos de token, sessão e acesso a recursos.

**Quando usar:** Projetos que precisam de sistemas de autenticação robustos ou revisão de implementações existentes.

**Exemplo prático:** Implementar autenticação OAuth 2.0 com refresh tokens e revogação de sessões em um API REST.

---

### 6. aws-compliance-checker
**Descrição:** Verificação automatizada de conformidade com benchmarks CIS, PCI-DSS, HIPAA e SOC 2.

**Quando usar:** Ambientes AWS que precisam atender a requisitos regulatórios específicos.

**Exemplo prático:** Verificar conformidade de uma conta AWS com PCI-DSS antes de processar pagamentos.

---

### 7. aws-iam-best-practices
**Descrição:** Revisão, hardening e implementação do menor privilégio em políticas IAM.

**Quando usar:** Para garantir que credenciais AWS tenham apenas os mínimos necessários.

**Exemplo prático:** Revisar e otimizar políticas IAM de uma conta AWS para remover permissões excessivas.

---

### 8. aws-secrets-rotation
**Descrição:** Automatizar a rotação de segredos AWS para RDS, chaves de API e credenciais.

**Quando usar:** Manter credenciais seguras com rotação automática em ambientes AWS.

**Exemplo prático:** Configurar rotação automática de senhas de banco de dados RDS a cada 30 dias.

---

### 9. aws-security-audit
**Descrição:** Avaliação abrangente da postura de segurança AWS usando AWS CLI e melhores práticas.

**Quando usar:** Auditorias periódicas de segurança em contas AWS ou preparação para compliance.

**Exemplo prático:** Realizar auditoria completa de uma conta AWS, identificando recursos expostos publicamente.

---

### 10. binary-analysis-patterns
**Descrição:** Padrões e técnicas abrangentes para analisar binários compilados, entender código assembly e reconstruir lógica de programa.

**Quando usar:** Análise de malware, engenharia reversa ou auditoria de segurança de binários.

**Exemplo prático:** Analisar um binário suspeito para determinar seu comportamento e identificar vulnerabilidades.

---

### 11. broken-authentication
**Descrição:** Identificar e explorar vulnerabilidades de autenticação e gerenciamento de sessão em aplicações web.

**Quando usar:** Testes de penetração em sistemas de login e gerenciamento de sessões.

**Exemplo prático:** Testar se um aplicativo web é vulnerável a session fixation ou credential stuffing.

---

### 12. bumblebee
**Descrição:** Executar varreduras de inventário e exposição de cadeia de suprimentos Bumblebee em macOS/Linux.

**Quando usar:** Detectar pacotes comprometidos, extensões e configurações de host MCP.

**Exemplo prático:** Verificar se alguma dependência do projeto foi comprometida em um ataque de supply chain.

---

### 13. burp-suite-testing
**Descrição:** Executar testes de segurança abrangentes em aplicações web usando o conjunto integrado de ferramentas Burp Suite.

**Quando usar:** Testes de penetração em aplicações web com interceptação de tráfego HTTP e varredura automatizada.

**Exemplo prático:** Usar Burp Suite para identificar vulnerabilidades SQL injection em um formulário de login.

---

### 14. burpsuite-project-parser
**Descrição:** Pesquisar e explorar arquivos de projeto Burp Suite (.burp) via linha de comando.

**Quando usar:** Análise forense de tráfego HTTP capturado em projetos Burp.

**Exemplo prático:** Extrair dados de proxy history de um projeto Burp para relatório de auditoria.

---

### 15. constant-time-analysis
**Descrição:** Analisar código criptográfico para detectar operaziones que vazam dados secretos através de variações de tempo de execução.

**Quando usar:** Auditoria de implementações criptográficas contra ataques de canal lateral.

**Exemplo prático:** Verificar se uma implementação de RSA é vulnerável a ataques de timing.

---

### 16. container-security-hardening
**Descrição:** Hardening de imagens Docker/containers e deployments com imagens base seguras, usuários non-root, varredura CVE, SBOM, seccomp/AppArmor e controles de segurança Kubernetes.

**Quando usar:** Revisão de segurança de Dockerfiles, varredura de CVEs em containers, ou hardening em produção.

**Exemplo prático:** Transformar um Dockerfile inseguro em uma imagem distroless com escopo mínimo de privilégios.

---

### 17. cred-omega
**Descrição:** CISO operacional enterprise para gestão total de credenciais e segredos.

**Quando usar:** Gestão centralizada de credenciais em ambientes empresariais.

**Exemplo prático:** Implementar vault de segredos com rotação automática para toda a infraestrutura.

---

### 18. cyber-audit
**Descrição:** Executar verificações de exposição somente leitura para avisos de segurança e escrever relatório de auditoria local estruturado.

**Quando usar:** Auditorias rápidas de exposição em repositórios ou ambientes.

**Exemplo prático:** Verificar se um repositório Git contém segredos expostos ou configurações inseguras.

---

### 19. dependency-management-deps-audit
**Descrição:** Especialista em segurança de dependências, especializado em varredura de vulnerabilidades, conformidade de licenças e segurança de cadeia de suprimentos.

**Quando usar:** Análise de dependências do projeto para vulnerabilidades conhecidas e problemas de licenciamento.

**Exemplo prático:** Escanear projeto Node.js para dependências com CVEs conhecidos e sugerir atualizações.

---

### 20. differential-review
**Descrição:** Revisão de código focada em segurança para PRs, commits e diffs.

**Quando usar:** Code review de alterações que impactam segurança antes de merge.

**Exemplo prático:** Revisar um pull request que adiciona autenticação para garantir que não há vulnerabilities.

---

### 21. email-security
**Descrição:** Revisão autorizada de segurança de e-mail: análise de phishing, autenticação SPF/DKIM/DMARC, investigação de padrões BEC e pesquisa de abuso de tokens de caixa de correio.

**Quando usar:** Investigar tentativas de phishing ou verificar configuração de segurança de e-mail.

**Exemplo prático:** Analisar um e-mail suspeito para determinar se é phishing e verificar autenticação SPF/DKIM.

---

### 22. ethical-hacking-methodology
**Descrição:** Domine o ciclo de vida completo de testes de penetração, desde reconhecimento até relatório.

**Quando usar:** Planejamento e execução de assessments de segurança autorizados.

**Exemplo prático:** Conduzir assessment completo de segurança em uma rede corporativa seguindo metodologia de 5 fases.

---

### 23. ffuf-claude-skill
**Descrição:** Web fuzzing com ffuf.

**Quando usar:** Fuzzing de endpoints web para descobrir diretórios, parâmetros ou vulnerabilities.

**Exemplo prático:** Usar ffuf para descobrir endpoints ocultos em uma API REST.

---

### 24. ffuf-web-fuzzing
**Descrição:** Orientação especializada para fuzzing web com ffuf durante testes de penetração, incluindo fuzzing autenticado.

**Quando usar:** Testes de penetração que requerem fuzzing autenticado com calibração automática.

**Exemplo prático:** Fuzzing de parâmetros de URL em uma aplicação autenticada para encontrar vulnerabilities.

---

### 25. file-path-traversal
**Descrição:** Identificar e explorar vulnerabilidades de traversão de caminho de arquivo (directory traversal).

**Quando usar:** Testes de penetração para verificar se é possível ler arquivos arbitrários no servidor.

**Exemplo prático:** Explorar vulnerabilidade path traversal para acessar /etc/passwd em servidor web.

---

### 26. file-uploads
**Descrição:** Especialista em uploads de arquivos e armazenamento em nuvem. Cobertura de S3, Cloudflare R2, URLs pré-assinadas e uploads multipart.

**Quando usar:** Implementação segura de funcionalidades de upload de arquivos.

**Exemplo prático:** Implementar upload seguro com validação de tipo de arquivo e armazenamento em S3.

---

### 27. firmware-analyst
**Descrição:** Analista de firmware especialista em sistemas embarcados, segurança IoT e engenharia reversa de hardware.

**Quando usar:** Análise de firmware de dispositivos IoT ou sistemas embarcados para vulnerabilidades.

**Exemplo prático:** Extrair e analisar firmware de um roteador para encontrar backdoors ou credenciais hardcoded.

---

### 28. frontend-security-coder
**Descrição:** Especialista em práticas seguras de codificação frontend, especializado em prevenção XSS, sanitização de output e padrões de segurança client-side.

**Quando usar:** Desenvolvimento de aplicações web que precisam de proteção contra XSS e outras vulnerabilidades client-side.

**Exemplo prático:** Implementar sanitização de entrada e output em um formulário de comentário para prevenir XSS.

---

### 29. fsi-compliance-checker
**Descrição:** Mapeia alterações de código, arquitetura e infraestrutura para IDs de controle específicos em PCI-DSS v4.0 e MAS TRM.

**Quando usar:** Organizações financeiras que precisam demonstrar conformidade com regulamentações.

**Exemplo prático:** Gerar relatório de conformidade PCI-DSS para uma aplicação de processamento de pagamentos.

---

### 30. gdpr-data-handling
**Descrição:** Guia prático de implementação para processamento de dados compatível com GDPR, gerenciamento de consentimento e controles de privacidade.

**Quando usar:** Implementação de requisitos GDPR em aplicações que coletam dados pessoais da UE.

**Exemplo prático:** Implementar mecanismo de consentimento e direito ao esquecimento em um aplicativo.

---

### 31. gha-security-review
**Descrição:** Encontrar vulnerabilidades exploráveis em workflows GitHub Actions. Cada achado DEVE incluir cenário concreto de exploração.

**Quando usar:** Auditoria de pipelines CI/CD GitHub Actions para vulnerabilidades de segurança.

**Exemplo prático:** Identificar se um workflow GitHub Actions permite injeção de código através de inputs não sanitizados.

---

### 32. html-injection-testing
**Descrição:** Identificar e explorar vulnerabilidades de injeção HTML que permitem injetar conteúdo HTML malicioso em aplicações web.

**Quando usar:** Testes de penetração para verificar se é possível injetar HTML em páginas web.

**Exemplo prático:** Testar se um campo de busca permite injeção HTML para criar páginas de phishing.

---

### 33. idor-testing
**Descrição:** Metodologias sistemáticas para identificar e explorar vulnerabilidades IDOR (Insecure Direct Object Reference).

**Quando usar:** Testes de penetração em APIs para verificar acesso não autorizado a recursos de outros usuários.

**Exemplo prático:** Testar se alterando o ID de usuário na URL é possível acessar dados de outro usuário.

---

### 34. laravel-security-audit
**Descrição:** Auditor de segurança para aplicações Laravel. Analisa código vulnerabilidades, configurações incorretas e práticas inseguras.

**Quando usar:** Auditoria de segurança específica para aplicações construídas com Laravel.

**Exemplo prático:** Auditar uma aplicação Laravel para verificar se está protegida contra mass assignment e SQL injection.

---

### 35. linux-privilege-escalation
**Descrição:** Executar avaliações sistemáticas de escalação de privilégios em sistemas Linux.

**Quando usar:** Testes de penetração em ambientes Linux para identificar caminhos de escalação para root.

**Exemplo prático:** Identificar binários SUID configurados incorretamente que permitem escalação de privilégios.

---

### 36. malware-analyst
**Descrição:** Analista de malware especialista em pesquisa defensiva de malware, inteligência de ameaças e resposta a incidentes.

**Quando usar:** Análise de amostras de malware para entender comportamento e desenvolver contra-medidas.

**Exemplo prático:** Analisar em sandbox uma amostra de ransomware para identificar IOC e comportamento.

---

### 37. memory-forensics
**Descrição:** Técnicas abrangentes para aquisição, análise e extração de artefatos de dumps de memória.

**Quando usar:** Resposta a incidentes e análise de malware via forense de memória.

**Exemplo prático:** Analisar dump de memória de máquina comprometida para extrair processos maliciosos e artefatos.

---

### 38. metasploit-framework
**Descrição:** Framework de exploração para assessments de segurança autorizados. **APENAS PARA USO AUTORIZADO.**

**Quando usar:** Testes de penetração autorizados usando o framework Metasploit.

**Exemplo prático:** Usar Metasploit para demonstrar exploração de vulnerability CVE em ambiente de teste controlado.

---

### 39. mtls-configuration
**Descrição:** Configurar TLS mútuo (mTLS) para comunicação zero-trust entre serviços.

**Quando usar:** Implementar networking zero-trust e gerenciamento de certificados para comunicação interna.

**Exemplo prático:** Configurar mTLS entre microsserviços em cluster Kubernetes para comunicação segura.

---

### 40. pci-compliance
**Descrição:** Revisar fluxos de dados de pagamento e evidências de controle de engenharia para avaliação PCI.

**Quando usar:** Preparação para auditoria PCI-DSS em sistemas que processam cartões de crédito.

**Exemplo prático:** Revisar fluxo de dados de pagamento para garantir que dados sensíveis não são armazenados indevidamente.

---

### 41. pentest-checklist
**Descrição:** Checklist abrangente para planejar, executar e acompanhar testes de penetração.

**Quando usar:** Preparação e execução organizada de assessments de segurança.

**Exemplo prático:** Usar o checklist para garantir que todas as fases de um pentest sejam executadas adequadamente.

---

### 42. pentest-commands
**Descrição:** Referência abrangente de comandos para ferramentas de testes de penetração.

**Quando usar:** Consulta rápida de comandos durante assessments de segurança.

**Exemplo prático:** Consultar comandos Nmap para varredura de rede específica durante um pentest.

---

### 43. privacy-by-design
**Descrição:** Construir aplicativos que coletam dados do usuário com proteções de privacidade desde o início.

**Quando usar:** Desenvolvimento de aplicações que coletam dados pessoais e precisam de conformidade com privacidade.

**Exemplo prático:** Implementar minimização de dados e criptografia desde o início do desenvolvimento de um app de saúde.

---

### 44. production-audit
**Descrição:** Auditar repositório publicado para lacunas de prontidão em produção incluindo RLS, webhooks, segredos, grants, idempotência Stripe, UX mobile e saúde de deploy.

**Quando usar:** Auditoria pré-lançamento ou revisão de segurança em produção.

**Exemplo prático:** Auditar aplicação SaaS antes do launch para garantir que todas as.configurações de segurança estão corretas.

---

### 45. protocol-reverse-engineering
**Descrição:** Técnicas abrangentes para capturar, analisar e documentar protocolos de rede.

**Quando usar:** Pesquisa de segurança, interoperabilidade e depuração de protocolos proprietários.

**Exemplo prático:** Reverse engineer de protocolo proprietário de um dispositivo IoT para entender sua comunicação.

---

### 46. red-team-tactics
**Descrição:** Princípios de táticas de red team baseados no MITRE ATT&CK.

**Quando usar:** Simulações de ataques avançados e exercícios de defesa.

**Exemplo prático:** Executar campanha de red team simulando APT contra infraestrutura corporativa.

---

### 47. red-team-tools
**Descrição:** Metodologias e fluxos de trabalho comprovados de pesquisadores de segurança para reconhecimento, descoberta de vulnerabilidades e bug bounty.

**Quando usar:** Automação de tarefas comuns de segurança e cobertura abrangente de superfícies de ataque.

**Exemplo prático:** Automatizar reconhecimento de superfície de ataque usando ferramentas de red team.

---

### 48. reverse-engineer
**Descrição:** Engenheiro reverso especialista em análise de binários, desmontagem, descompilação e análise de software.

**Quando usar:** Análise de software proprietário, engenharia reversa de malware ou auditoria de segurança.

**Exemplo prático:** Usar Ghidra para descompilar binário e entender algoritmo de ofuscação.

---

### 49. sast-configuration
**Descrição:** Configuração de ferramentas SAST (Static Application Security Testing), criação de regras personalizadas para varredura de segurança.

**Quando usar:** Implementação de varredura estática de segurança em pipelines CI/CD.

**Exemplo prático:** Configurar Semgrep com regras personalizadas para detectar SQL injection em código Python.

---

### 50. scanning-tools
**Descrição:** Domine ferramentas essenciais de varredura de segurança para descoberta de rede, avaliação de vulnerabilidades, testes de aplicações web e validação de conformidade.

**Quando usar:** Seleção e configuração de ferramentas de varredura para diferentes categorias de segurança.

**Exemplo prático:** Configurar Nmap, Nikto e OWASP ZAP para avaliação completa de segurança de uma rede.

---

### 51. secrets-management
**Descrição:** Práticas seguras de gestão de segredos para pipelines CI/CD usando Vault, AWS Secrets Manager e outras ferramentas.

**Quando usar:** Implementação de gestão segura de credenciais em pipelines de deploy.

**Exemplo prático:** Configurar HashiCorp Vault para gerenciar segredos de aplicação com rotação automática.

---

### 52. security-and-hardening
**Descrição:** Hardening de código contra vulnerabilidades. Use ao lidar com entrada do usuário, autenticação, armazenamento de dados ou integrações externas.

**Quando usar:** Construção de qualquer funcionalidade que aceita dados não confiáveis ou gerencia sessões de usuário.

**Exemplo prático:** Hardening de endpoint de API que aceita entrada do usuário contra injection attacks.

---

### 53. security-auditor
**Descrição:** Auditor de segurança especialista em DevSecOps, cibersegurança abrangente e frameworks de conformidade.

**Quando usar:** Auditorias abrangentes de segurança em ambientes DevSecOps.

**Exemplo prático:** Realizar auditoria completa de segurança em pipeline DevSecOps, desde código até produção.

---

### 54. security-bluebook-builder
**Descrição:** Construir política de segurança mínima mas real para aplicativos sensíveis. Documento único usando linguagem MUST/SHOULD/CAN.

**Quando usar:** Criação de políticas de segurança para aplicações sensíveis.

**Exemplo prático:** Criar livro azul de segurança para aplicativo bancário definindo gates de segurança obrigatórios.

---

### 55. security-compliance-compliance-check
**Descrição:** Especialista em conformidade regulatória para sistemas de software incluindo GDPR, HIPAA, SOC2, PCI-DSS.

**Quando usar:** Auditorias abrangentes de conformidade e orientação de implementação.

**Exemplo prático:** Auditar conformidade HIPAA de sistema de saúde eletrônico e gerar plano de remediação.

---

### 56. security-requirement-extraction
**Descrição:** Derivar requisitos de segurança de modelos de ameaças e contexto de negócio.

**Quando usar:** Tradução de ameaças em requisitos acionáveis, criação de histórias de segurança ou construção de casos de teste.

**Exemplo prático:** Extrair requisitos de segurança de um modelo de ameaças STRIDE para um sistema de pagamento.

---

### 57. security-scanning-security-dependencies
**Descrição:** Especialista em análise de vulnerabilidades de dependências, geração SBOM e segurança de cadeia de suprimentos.

**Quando usar:** Varredura de dependências do projeto em múltiplos ecossistemas para vulnerabilidades.

**Exemplo prático:** Gerar SBOM completo e identificar vulnerabilidades em dependências de projeto Java.

---

### 58. security-scanning-security-hardening
**Descrição:** Coordenar varredura e hardening de segurança multicamada em aplicação, infraestrutura e controles de conformidade.

**Quando usar:** Hardening abrangente de segurança em múltiplas camadas de uma aplicação.

**Exemplo prático:** Implementar hardening multicamada em aplicação web incluindo WAF, hardened OS e auditoria de código.

---

### 59. security-scanning-security-sast
**Descrição:** SAST (Static Application Security Testing) para análise de vulnerabilidades de código em múltiplas linguagens e frameworks.

**Quando usar:** Varredura estática de código para detectar vulnerabilidades antes do deploy.

**Exemplo prático:** Executar varredura SAST em repositório Python para identificar vulnerabilities de segurança.

---

### 60. semgrep-rule-creator
**Descrição:** Criar regras Semgrep personalizadas para detectar vulnerabilidades de segurança, padrões de bugs e padrões de código.

**Quando usar:** Construção de detecções de análise estática personalizadas para necessidades específicas.

**Exemplo prático:** Criar regra Semgrep para detectar uso inseguro de funções de random em tokens de sessão.

---

### 61. semgrep-rule-variant-creator
**Descrição:** Criar variantes linguísticas de regras Semgrep existentes.

**Quando usar:** Portar regras Semgrep para linguagens-alvo específicas.

**Exemplo prático:** Portar regra Semgrep de JavaScript para TypeScript mantendo a mesma detecção.

---

### 62. shodan-reconnaissance
**Descrição:** Metodologias sistemáticas para alavancar Shodan como ferramenta de reconhecimento em pentests.

**Quando usar:** Fase de reconhecimento em testes de penetração para descobrir serviços expostos.

**Exemplo prático:** Usar Shodan para encontrar servidores CVE vulneráveis expostos na internet.

---

### 63. skill-audit
**Descrição:** Scanner de segurança pré-instalação para skills de agentes de IA. 7,5% de 14.706 skills são maliciosas.

**Quando usar:** Antes de instalar qualquer skill de agente de IA para verificar se é segura.

**Exemplo prático:** Auditar skill de terceiros antes de autorizar instalação em ambiente corporativo.

---

### 64. skill-security-audit
**Descrição:** Auditar Skill de Agente, servidor MCP, conector ou extensão desktop antes da instalação.

**Quando usar:** Verificação completa de segurança antes de instalar componentes de IA.

**Exemplo prático:** Auditar MCP server antes de integrar ao fluxo de trabalho corporativo.

---

### 65. smtp-penetration-testing
**Descrição:** Conduzir assessments de segurança abrangentes de servidores SMTP.

**Quando usar:** Testes de penetração em servidores de e-mail para identificar vulnerabilidades.

**Exemplo prático:** Testar servidor SMTP para open relays, enumeração de usuários e autenticação fraca.

---

### 66. solidity-security
**Descrição:** Domine melhores práticas de segurança de smart contracts, prevenção de vulnerabilidades e padrões de desenvolvimento Solidity seguro.

**Quando usar:** Desenvolvimento e auditoria de smart contracts em Ethereum/EVM.

**Exemplo prático:** Auditar smart contract DeFi para vulnerabilidades como reentrancy e integer overflow.

---

### 67. sql-injection-testing
**Descrição:** Executar assessments abrangentes de vulnerabilidade SQL injection em aplicações web.

**Quando usar:** Testes de penetração para identificar vulnerabilidades de injection em bancos de dados.

**Exemplo prático:** Testar formulário de login para SQL injection usando técnicas de bypass de autenticação.

---

### 68. ssh-penetration-testing
**Descrição:** Conduzir assessments de segurança abrangentes de SSH incluindo enumeração, ataques de credencial, exploração de vulnerabilidades e tunelamento.

**Quando usar:** Testes de penetração em serviços SSH para identificar vulnerabilidades.

**Exemplo prático:** Testar servidor SSH para credenciais fracas, vulnerabilidades e configurações inseguras.

---

### 69. stride-analysis-patterns
**Descrição:** Aplicar metodologia STRIDE para identificar ameaças sistematicamente.

**Quando usar:** Análise de segurança de sistema, sessões de modelagem de ameaças ou criação de documentação de segurança.

**Exemplo prático:** Aplicar STRIDE em arquitetura de microsserviços para identificar todas as categorias de ameaças.

---

### 70. supply-chain-security
**Descrição:** Assessment de segurança de cadeia de suprimentos de software: geração SBOM, varredura SCA, revisão pipeline CI/CD e verificação de vulnerabilidades.

**Quando usar:** Auditoria abrangente de segurança de cadeia de suprimentos de software.

**Exemplo prático:** Realizar assessment completo de supply chain security em projeto open-source.

---

### 71. threat-mitigation-mapping
**Descrição:** Mapear ameaças identificadas para controles e mitigações de segurança apropriados.

**Quando usar:** Priorização de investimentos em segurança, criação de planos de remediação ou validação de eficácia de controles.

**Exemplo prático:** Mapear ameaças STRIDE identificadas para controles de segurança específicos no framework NIST.

---

### 72. threat-modeling-expert
**Descrição:** Especialista em metodologias de modelagem de ameaças, revisão de arquitetura de segurança e avaliação de riscos.

**Quando usar:** Revisões proativas de arquitetura de segurança, identificação de ameaças ou construção de sistemas seguros por design.

**Exemplo prático:** Conduzir sessão de threat modeling para novo sistema de microsserviços usando PASTA.

---

### 73. top-web-vulnerabilities
**Descrição:** Referência abrangente e estruturada das 100 vulnerabilidades mais críticas de aplicações web.

**Quando usar:** Identificação sistemática de vulnerabilidades, avaliação de impacto e orientação de remediação.

**Exemplo prático:** Usar como referência durante assessment de segurança para garantir cobertura completa.

---

### 74. varlock
**Descrição:** Gerenciamento de variáveis de ambiente seguro por padrão para sessões Claude Code.

**Quando usar:** Sessões de Claude Code que precisam de variáveis de ambiente seguras.

**Exemplo prático:** Configurar variáveis de ambiente para sessão de Claude Code sem expor segredos.

---

### 75. varlock-claude-skill
**Descrição:** Gerenciamento seguro de variáveis de ambiente garantindo que segredos não sejam expostos em sessões Claude, terminais, logs ou commits git.

**Quando usar:** Proteger segredos durante uso de Claude Code em qualquer ambiente.

**Exemplo prático:** Garantir que token de API não seja exposto em logs ou commits durante sessão Claude.

---

### 76. vulnerability-scanner
**Descrição:** Princípios avançados de análise de vulnerabilidades. OWASP 2025, Supply Chain Security, mapeamento de superfície de ataque e priorização de riscos.

**Quando usar:** Análise avançada de vulnerabilidades com foco em ameaças atuais.

**Exemplo prático:** Usar como referência para análise de vulnerabilidades em projeto com foco em OWASP Top 10 2025.

---

### 77. windows-privilege-escalation
**Descrição:** Metodologias sistemáticas para descobrir e explorar vulnerabilidades de escalação de privilégios em sistemas Windows.

**Quando usar:** Testes de penetração em ambientes Windows para identificar caminhos de escalação.

**Exemplo prático:** Identificar configurações incorretas de serviços Windows que permitem escalação para SYSTEM.

---

### 78. wireshark-analysis
**Descrição:** Executar análise abrangente de tráfego de rede usando Wireshark para captura, filtragem e exame de pacotes.

**Quando usar:** Investigações de segurança, otimização de performance e troubleshooting de rede.

**Exemplo prático:** Capturar e analisar tráfego de rede para identificar comunicação maliciosa ou vazamento de dados.

---

### 79. wordpress-penetration-testing
**Descrição:** Avaliar instalações WordPress para vulnerabilidades comuns e superfícies de ataque WordPress 7.0.

**Quando usar:** Testes de penetração em sites e aplicações WordPress.

**Exemplo prático:** Testar site WordPress para vulnerabilidades de plugins, temas e configurações inseguras.

---

### 80. xss-html-injection
**Descrição:** Executar assessments abrangentes de vulnerabilidades de injeção client-side em aplicações web.

**Quando usar:** Testes de penetração para identificar XSS e injeção HTML.

**Exemplo prático:** Testar formulários de busca para XSS refletido e armazenado.

---

## Pentest Tools Category

### 81. src-hunter
**Descrição:** Workflow de caça a vulnerabilidades bug-bounty/SRC: metodologia de cinco fases (intake, recon, enumeração, hunt, report) com playbooks de ataque para SQLi, XSS, RCE, SSRF, IDOR, CSRF, path traversal e file upload.

**Quando usar:** Caça sistemática a vulnerabilidades em programas de bug bounty ou assessments de segurança.

**Exemplo prático:** Usar metodologia de 5 fases para encontrar vulnerabilidades em programa de bug bounty de grande empresa de tecnologia.

---

## Document Verification Category

### 82. check-identity-pack
**Descrição:** Executar verificação de identidade AFP 100-point ou AUSTRAC safe-harbour sobre conjunto de documentos e reportar exatamente o que está faltando.

**Quando usar:** Verificação de documentos de identidade para onboarding, ou avaliação se pacote de documentos atende requisitos australianos de identidade.

**Exemplo prático:** Verificar se conjunto de documentos de identificação de funcionário atende aos 100 pontos do padrão AFP.

---

### 83. detect-ai-text
**Descrição:** Estimar se a prosa de um documento foi escrita por IA, com sinais linguísticos e abstenção honesta em não-prosa.

**Quando usar:** Triagem para determinar se ensaio, relatório, CV ou artigo foi gerado por IA.

**Exemplo prático:** Analisar submissão acadêmica para determinar probabilidade de ter sido escrita por IA.

---

### 84. extract-document-data
**Descrição:** Extrair campos estruturados e fundamentados de documentos — valores citam sua página, valores ausentes se abstêm em vez de alucinar.

**Quando usar:** Parsing de faturas, holerites, extratos, contratos e outros documentos estruturados.

**Exemplo prático:** Extrair dados de fatura de fornecedor para integração com sistema de contas a pagar.

---

### 85. find-matching-tenders
**Descrição:** Encontrar licitações governamentais AU/NZ abertas que correspondem ao que uma empresa faz, classificadas por adequação com análise de lacunas.

**Quando usar:** Busca de oportunidades de licitações, contratos governamentais ou RFPs para negócio ou cliente.

**Exemplo prático:** Encontrar licitações governamentais australianas de TI que correspondem às capacidades de uma empresa de software.

---

### 86. screen-adverse-media
**Descrição:** Rastrear pessoa ou organização para cobertura de mídia adversa, status PEP e exposição a sanções — com correção de corroboração.

**Quando usar:** Due diligence antes de onboarding, parceria ou investimento; fluxos AML/CTF; monitoramento contínuo de contraparte.

**Exemplo prático:** Rastrear potencial investidor para verificar se há exposição a sanções ou mídia negativa antes de investimento.

---

### 87. verify-citations
**Descrição:** Verificar citações e referências em documento, relatório ou artigo contra fontes reais.

**Quando usar:** Fact-check, verificação de referências, validação de evidências em relatórios de pesquisa, propostas de licitação, whitepapers ou escrita acadêmica.

**Exemplo prático:** Verificar se todas as citações em whitepaper de segurança são autênticas e de fontes confiáveis.

---

### 88. verify-document
**Descrição:** Verificar se documento (PDF ou imagem) apresenta sinais de adulteração ou falsificação antes de confiar nele.

**Quando usar:** Verificação de holerites, faturas, extratos bancários, documentos de identidade, contratos ou qualquer documento onde autenticidade importa.

**Exemplo prático:** Verificar se holerite submetido por candidato apresenta sinais de adulteração antes de contratação.

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

---

*Documento gerado automaticamente a partir dos pointers de skills do sistema OpenCode.*
