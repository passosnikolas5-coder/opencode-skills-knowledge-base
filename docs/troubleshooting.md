# 🔧 Solução de Problemas

Este guia ajuda a resolver problemas comuns ao usar o **OpenCode Skills Knowledge Base**.

## 📋 Índice

- [Problemas Comuns](#problemas-comuns)
- [Erros de Instalação](#erros-de-instalação)
- [Problemas de Performance](#problemas-de-performance)
- [Erros de Integração](#erros-de-integração)
- [Problemas de Compatibilidade](#problemas-de-compatibilidade)
- [FAQ](#faq)
- [Contato](#contato)

---

## Problemas Comuns

### 1. Skill Não é Carregada

**Sintoma:**
```
Error: Skill 'nome-da-skill' not found
```

**Causas Possíveis:**
- Skill não existe
- Nome incorreto
- Skill não está habilitada

**Solução:**
```bash
# Verificar skills disponíveis
opencode skills list

# Buscar skill específica
opencode skills search react

# Habilitar skill
opencode skills enable react-patterns
```

### 2. Exemplo Não Funciona

**Sintoma:**
```
Error: Cannot find module 'modulo'
```

**Causas Possíveis:**
- Dependência não instalada
- Versão incompatível
- Caminho incorreto

**Solução:**
```bash
# Instalar dependência
npm install modulo

# Ou
pip install modulo

# Verificar versão
node -v
python -v
```

### 3. Documentação Desatualizada

**Sintoma:**
- Links quebrados
- Exemplos obsoletos
- Informações incorretas

**Solução:**
1. Verifique a versão mais recente
2. Consulte a documentação oficial
3. Abra um issue reportando o problema

---

## Erros de Instalação

### Erro 1: Git Não Encontrado

**Mensagem:**
```
git: command not found
```

**Solução:**
```bash
# Windows
# Baixe e instale: https://git-scm.com/download/win

# macOS
brew install git

# Linux
sudo apt-get install git
```

### Erro 2: Node.js Não Encontrado

**Mensagem:**
```
node: command not found
```

**Solução:**
```bash
# Baixe e instale: https://nodejs.org/

# Ou use nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
nvm install 18
nvm use 18
```

### Erro 3: Permissões Insuficientes

**Mensagem:**
```
EACCES: permission denied
```

**Solução:**
```bash
# Linux/macOS
sudo chown -R $USER ~/.npm
npm config set prefix ~/.npm-global

# Windows
# Execute o PowerShell como administrador
```

### Erro 4: Espaço Insuficiente

**Mensagem:**
```
ENOSPC: no space left on device
```

**Solução:**
```bash
# Verificar espaço
df -h

# Limpar cache
npm cache clean --force
docker system prune -a

# Remover arquivos desnecessários
rm -rf /tmp/*
```

---

## Problemas de Performance

### 1. Carregamento Lento

**Sintoma:**
- Skills demoram para carregar
- Interface lenta

**Solução:**
```yaml
# .opencode/config.yaml
performance:
  cache: true
  parallel_loading: true
  lazy_load: true
  max_concurrent: 5
```

### 2. Uso Excessivo de Memória

**Sintoma:**
- Aplicação trava
- Sistema fica lento

**Solução:**
```bash
# Monitorar uso de memória
opencode stats

# Limitar memória
export OPENCODE_MAX_MEMORY=1024

# Fechar processos desnecessários
pkill -f "opencode"
```

### 3. Lentidão no Build

**Sintoma:**
- Build demora muito
- Compilação lenta

**Solução:**
```yaml
# .opencode/config.yaml
build:
  cache: true
  parallel: true
  incremental: true
  workers: 4
```

---

## Erros de Integração

### 1. GitHub API Error

**Mensagem:**
```
Error: Bad credentials
```

**Solução:**
```bash
# Verificar autenticação
gh auth status

# Reautenticar
gh auth login

# Usar token
export GITHUB_TOKEN=ghp_xxxxxxxxxxxx
```

### 2. Docker Error

**Mensagem:**
```
Error: Cannot connect to Docker daemon
```

**Solução:**
```bash
# Iniciar Docker
# Windows: Abra o Docker Desktop
# Linux
sudo systemctl start docker
sudo systemctl enable docker
```

### 3. Kubernetes Error

**Mensagem:**
```
Error: The connection to the server was refused
```

**Solução:**
```bash
# Verificar cluster
kubectl cluster-info

# Reiniciar minikube
minikube stop
minikube start

# Verificar configuração
kubectl config view
```

---

## Problemas de Compatibilidade

### 1. Versão Incompatível

**Mensagem:**
```
Error: Unsupported engine
```

**Solução:**
```bash
# Verificar versão atual
node -v
npm -v

# Atualizar
nvm install 18
nvm use 18

# Ou
npm install -g npm@latest
```

### 2. Sistema Operacional

**Problema:**
- Compatibilidade com Windows/Linux/macOS

**Solução:**
```yaml
# .opencode/config.yaml
compatibility:
  os: [windows, linux, macos]
  min_version:
    node: 16.0.0
    npm: 8.0.0
```

### 3. Dependências Conflitantes

**Mensagem:**
```
Error: ERESOLVE unable to resolve dependency tree
```

**Solução:**
```bash
# Usar force
npm install --force

# Ou legacy-peer-deps
npm install --legacy-peer-deps

# Limpar e reinstalar
rm -rf node_modules
npm install
```

---

## FAQ

### P1: Como atualizar a base de conhecimento?

```bash
# Clonar novamente
git clone https://github.com/passosnikolas5-coder/opencode-skills-knowledge-base.git

# Ou atualizar
cd opencode-skills-knowledge-base
git pull origin main
```

### P2: Como contribuir?

1. Leia o [CONTRIBUTING.md](../CONTRIBUTING.md)
2. Abra uma issue ou pull request
3. Siga as diretrizes

### P3: Como reportar um bug?

1. Abra uma [issue](https://github.com/passosnikolas5-coder/opencode-skills-knowledge-base/issues)
2. Use o template de bug report
3. Inclua passos para reproduzir

### P4: Como sugerir uma nova feature?

1. Abra uma [issue](https://github.com/passosnikolas5-coder/opencode-skills-knowledge-base/issues)
2. Use o template de feature request
3. Descreva o caso de uso

### P5: Como entrar em contato?

- **GitHub**: [@passosnikolas5-coder](https://github.com/passosnikolas5-coder)
- **Email**: [Seu email aqui]

---

## 📊 Diagnóstico

### Comandos Úteis

```bash
# Verificar versão
opencode --version

# Verificar configuração
opencode config show

# Verificar logs
opencode logs

# Verificar status
opencode status

# Limpar cache
opencode cache clear

# Reiniciar
opencode restart
```

### Logs

```bash
# Ver logs em tempo real
tail -f ~/.opencode/logs/opencode.log

# Filtrar erros
grep -i error ~/.opencode/logs/opencode.log

# Enviar logs para suporte
opencode logs --export
```

---

## 🆘 Suporte

### Canais de Suporte

1. **GitHub Issues**: Para bugs e sugestões
2. **GitHub Discussions**: Para dúvidas
3. **Documentação**: Para referência
4. **Email**: Para contato direto

### Como Pedir Ajuda

1. **Seja específico**: Descreva claramente o problema
2. **Inclua contexto**: O que você estava tentando fazer
3. **Mostre código**: Se aplicável
4. **Inclua logs**: Se disponível
5. **Seja paciente**: Aguarde resposta

### Informações Úteis

```bash
# Coletar informações do sistema
opencode diagnostics

# Exportar configuração
opencode config export

# Gerar relatório
opencode report
```

---

## 📝 Soluções Rápidas

### Reset Completo

```bash
# Limpar tudo
rm -rf ~/.opencode
rm -rf node_modules
rm package-lock.json

# Reinstalar
npm install
opencode setup
```

### Reinstalação

```bash
# Desinstalar
npm uninstall -g opencode

# Reinstalar
npm install -g opencode

# Configurar
opencode setup
```

### Atualização

```bash
# Atualizar opencode
npm update -g opencode

# Atualizar dependências
npm update

# Limpar cache
npm cache clean --force
```

---

*Guia atualizado em: Setembro 2026*
*Versão: 2.0*