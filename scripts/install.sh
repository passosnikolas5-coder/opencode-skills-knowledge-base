#!/bin/bash

# Script de Instalação - OpenCode Skills Knowledge Base
# Versão: 2.0

set -e

echo "🚀 Iniciando instalação do OpenCode Skills Knowledge Base..."
echo ""

# Cores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Função para imprimir mensagens
print_message() {
    echo -e "${GREEN}[✓]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[!]${NC} $1"
}

print_error() {
    echo -e "${RED}[✗]${NC} $1"
}

print_info() {
    echo -e "${BLUE}[i]${NC} $1"
}

# Verificar se é root (Linux/macOS)
if [[ $EUID -eq 0 ]]; then
    print_warning "Este script não deve ser executado como root!"
    print_warning "Execute sem sudo."
    exit 1
fi

# Verificar sistema operacional
detect_os() {
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        echo "linux"
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        echo "macos"
    elif [[ "$OSTYPE" == "msys" ]] || [[ "$OSTYPE" == "cygwin" ]]; then
        echo "windows"
    else
        echo "unknown"
    fi
}

OS=$(detect_os)
print_info "Sistema operacional detectado: $OS"

# Verificar dependências
check_dependency() {
    if command -v "$1" &> /dev/null; then
        print_message "$1 está instalado"
        return 0
    else
        print_error "$1 não está instalado"
        return 1
    fi
}

echo ""
echo "📋 Verificando dependências..."
echo ""

# Git
if ! check_dependency git; then
    print_error "Git é necessário. Instale: https://git-scm.com/"
    exit 1
fi

# Node.js
if ! check_dependency node; then
    print_error "Node.js é necessário. Instale: https://nodejs.org/"
    exit 1
fi

# npm
if ! check_dependency npm; then
    print_error "npm é necessário. Geralmente vem com Node.js."
    exit 1
fi

# Verificar versão do Node.js
NODE_VERSION=$(node -v | cut -d'v' -f2 | cut -d'.' -f1)
if [ "$NODE_VERSION" -lt 16 ]; then
    print_error "Node.js versão 16+ é necessária. Versão atual: $(node -v)"
    exit 1
fi

print_message "Todas as dependências estão instaladas!"
echo ""

# Clonar repositório
echo "📥 Clonando repositório..."
echo ""

REPO_URL="https://github.com/passosnikolas5-coder/opencode-skills-knowledge-base.git"
INSTALL_DIR="$HOME/opencode-skills-knowledge-base"

if [ -d "$INSTALL_DIR" ]; then
    print_warning "Diretório já existe: $INSTALL_DIR"
    read -p "Deseja atualizar? (y/n): " -n 1 -r
    echo ""
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        cd "$INSTALL_DIR"
        git pull origin main
        print_message "Repositório atualizado!"
    else
        print_info "Usando diretório existente."
    fi
else
    git clone "$REPO_URL" "$INSTALL_DIR"
    cd "$INSTALL_DIR"
    print_message "Repositório clonado!"
fi

echo ""

# Instalar dependências
echo "📦 Instalando dependências..."
echo ""

if [ -f "package.json" ]; then
    npm install
    print_message "Dependências npm instaladas!"
else
    print_warning "Arquivo package.json não encontrado. Pulando instalação npm."
fi

echo ""

# Configurar variáveis de ambiente
echo "⚙️ Configurando variáveis de ambiente..."
echo ""

ENV_FILE="$INSTALL_DIR/.env"
if [ ! -f "$ENV_FILE" ]; then
    cat > "$ENV_FILE" << EOF
# OpenCode Skills Knowledge Base
# Variáveis de Ambiente

# GitHub Token (opcional)
GITHUB_TOKEN=

# OpenAI API Key (opcional)
OPENAI_API_KEY=

# Configurações
NODE_ENV=development
PORT=3000
EOF
    print_message "Arquivo .env criado!"
else
    print_warning "Arquivo .env já existe."
fi

echo ""

# Criar scripts executáveis
echo "🔧 Configurando scripts..."
echo ""

chmod +x scripts/*.sh 2>/dev/null || true
print_message "Scripts configurados!"

echo ""

# Verificar instalação
echo "🔍 Verificando instalação..."
echo ""

if [ -d "$INSTALL_DIR" ] && [ -f "$INSTALL_DIR/README.md" ]; then
    print_message "Instalação verificada com sucesso!"
else
    print_error "Houve um problema na instalação."
    exit 1
fi

echo ""
echo "✅ Instalação concluída com sucesso!"
echo ""
echo "📚 Próximos passos:"
echo "   1. Entre no diretório: cd $INSTALL_DIR"
echo "   2. Leia o README.md: cat README.md"
echo "   3. Explore as skills: ls src/"
echo "   4. Consulte a documentação: ls docs/"
echo ""
echo "🚀 Para começar, abra o terminal no diretório do projeto e execute:"
echo "   cat README.md"
echo ""
echo "📖 Documentação completa: https://github.com/passosnikolas5-coder/opencode-skills-knowledge-base#readme"
echo ""
echo "🎉 Divirta-se aprendendo com o OpenCode Skills Knowledge Base!"
echo ""