#!/bin/bash

# Script de Atualização - OpenCode Skills Knowledge Base
# Versão: 2.0

set -e

echo "🔄 Iniciando atualização do OpenCode Skills Knowledge Base..."
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

# Verificar se está no diretório correto
if [ ! -f "README.md" ] || [ ! -d "src" ]; then
    print_error "Este script deve ser executado no diretório raiz do projeto."
    print_error "Diretório atual: $(pwd)"
    exit 1
fi

# Verificar se é um repositório Git
if [ ! -d ".git" ]; then
    print_error "Este não é um repositório Git."
    exit 1
fi

# Verificar conexão com internet
if ! ping -c 1 github.com &> /dev/null; then
    print_error "Sem conexão com a internet."
    exit 1
fi

print_message "Verificações iniciais concluídas!"
echo ""

# Fazer backup
echo "💾 Fazendo backup..."
echo ""

BACKUP_DIR="$HOME/opencode-skills-knowledge-base-backup-$(date +%Y%m%d-%H%M%S)"
if [ -d "$BACKUP_DIR" ]; then
    print_warning "Diretório de backup já existe: $BACKUP_DIR"
else
    mkdir -p "$BACKUP_DIR"
    cp -r . "$BACKUP_DIR" 2>/dev/null || true
    print_message "Backup criado em: $BACKUP_DIR"
fi

echo ""

# Verificar mudanças locais
echo "🔍 Verificando mudanças locais..."
echo ""

if [ -n "$(git status --porcelain)" ]; then
    print_warning "Existem mudanças locais não commitadas."
    read -p "Deseja salvar as mudanças? (y/n): " -n 1 -r
    echo ""
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        git add .
        git commit -m "backup: mudanças antes da atualização"
        print_message "Mudanças salvas!"
    else
        print_warning "Mudanças locais podem ser perdidas."
        read -p "Continuar mesmo assim? (y/n): " -n 1 -r
        echo ""
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            print_error "Atualização cancelada."
            exit 1
        fi
    fi
fi

echo ""

# Atualizar repositório
echo "📥 Atualizando repositório..."
echo ""

# Salvar branch atual
CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)

# Fetch de todas as branches
git fetch --all --prune

# Verificar se há atualizações
LOCAL=$(git rev-parse HEAD)
REMOTE=$(git rev-parse @{u})

if [ "$LOCAL" = "$REMOTE" ]; then
    print_message "Repositório já está atualizado!"
else
    print_info "Há atualizações disponíveis."
    
    # Puxar mudanças
    git pull origin "$CURRENT_BRANCH"
    print_message "Repositório atualizado!"
fi

echo ""

# Atualizar submódulos (se existirem)
echo "📦 Atualizando submódulos..."
echo ""

if [ -f ".gitmodules" ]; then
    git submodule update --init --recursive
    print_message "Submódulos atualizados!"
else
    print_info "Nenhum submódulo encontrado."
fi

echo ""

# Atualizar dependências
echo "📦 Atualizando dependências..."
echo ""

if [ -f "package.json" ]; then
    # Limpar cache
    npm cache clean --force 2>/dev/null || true
    
    # Atualizar dependências
    npm update
    print_message "Dependências npm atualizadas!"
else
    print_warning "Arquivo package.json não encontrado. Pulando atualização npm."
fi

echo ""

# Executar scripts de atualização
echo "🔧 Executando scripts de atualização..."
echo ""

if [ -f "scripts/post-update.sh" ]; then
    bash scripts/post-update.sh
    print_message "Scripts de atualização executados!"
else
    print_info "Nenhum script de atualização encontrado."
fi

echo ""

# Verificar atualização
echo "🔍 Verificando atualização..."
echo ""

# Verificar se os arquivos principais existem
if [ -f "README.md" ] && [ -d "src" ] && [ -d "docs" ]; then
    print_message "Atualização verificada com sucesso!"
else
    print_error "Houve um problema na atualização."
    print_error "Considere restaurar o backup: cp -r $BACKUP_DIR/* ."
    exit 1
fi

echo ""

# Limpar cache antigo
echo "🧹 Limpando cache antigo..."
echo ""

# Remover caches desnecessários
rm -rf node_modules/.cache 2>/dev/null || true
rm -rf .next/cache 2>/dev/null || true
print_message "Cache limpo!"

echo ""

# Mostrar estatísticas
echo "📊 Estatísticas da atualização:"
echo ""

echo "   - Último commit: $(git log -1 --pretty=format:'%h %s')"
echo "   - Branch: $(git rev-parse --abbrev-ref HEAD)"
echo "   - Status: $(git status --porcelain | wc -l) arquivo(s) modificado(s)"
echo ""

# Verificar versão
if [ -f "package.json" ]; then
    VERSION=$(node -p "require('./package.json').version" 2>/dev/null || echo "N/A")
    echo "   - Versão: $VERSION"
fi

echo ""

# Próximos passos
echo "✅ Atualização concluída com sucesso!"
echo ""
echo "📚 Próximos passos:"
echo "   1. Leia as novidades: git log --oneline -10"
echo "   2. Verifique o changelog: cat CHANGELOG.md"
echo "   3. Consulte a documentação: ls docs/"
echo ""
echo "🔗 Para ver as últimas mudanças:"
echo "   git log --oneline -20"
echo ""
echo "📖 Documentação completa: https://github.com/passosnikolas5-coder/opencode-skills-knowledge-base#readme"
echo ""
echo "🎉 Atualização concluída!"
echo ""