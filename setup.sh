#!/bin/bash
set -e
set -o pipefail

ARCH=$(uname -m)

BREW_BIN="/opt/homebrew/bin/brew"

################################################
# 1. Homebrew
################################################

echo "────────────────────────────────────────────"
echo "1/6 - Homebrew (gerenciador de pacotes)"
echo "────────────────────────────────────────────"

if command -v brew &> /dev/null; then
    echo "   Atualizando..."
    brew update > /dev/null 2>&1 || true
else
    echo "📦 Instalando Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    echo "eval \"\$($BREW_BIN shellenv)\"" >> ~/.zprofile
    eval "$($BREW_BIN shellenv)"
fi

echo ""

################################################
# 2. Git
################################################

echo "────────────────────────────────────────────"
echo "2/6 - Git (controle de versão)"
echo "────────────────────────────────────────────"

if command -v git &> /dev/null; then
    echo "   Verificando atualizações..."
    brew upgrade git 2>/dev/null || true
else
    echo "📦 Instalando Git..."
    brew install git
fi

echo ""

################################################
# 3. Node.js
################################################

echo "────────────────────────────────────────────"
echo "3/6 - Node.js (necessário para SF CLI)"
echo "────────────────────────────────────────────"

if command -v node &> /dev/null; then
    echo "   Verificando atualizações..."
    brew upgrade node 2>/dev/null || true
else
    echo "📦 Instalando Node.js..."
    brew install node
fi

echo ""

################################################
# 4. VS Code
################################################

echo "────────────────────────────────────────────"
echo "4/6 - Visual Studio Code"
echo "────────────────────────────────────────────"

if command -v code &> /dev/null; then
    echo "   Verificando atualizações..."
    brew upgrade --cask visual-studio-code 2>/dev/null || true
elif [[ -d "/Applications/Visual Studio Code.app" ]]; then
    echo "   ⚠️  Comando 'code' não está no PATH"
    echo "   Após o script, abra o VS Code e pressione:"
    echo "   Cmd+Shift+P → 'Shell Command: Install code command in PATH'"
else
    echo "📦 Instalando VS Code..."
    brew install --cask visual-studio-code
fi

echo ""

################################################
# 5. Salesforce CLI
################################################

echo "────────────────────────────────────────────"
echo "5/6 - Salesforce CLI"
echo "────────────────────────────────────────────"

if command -v sf &> /dev/null; then
    echo "   Verificando atualizações..."
    npm update --global @salesforce/cli 2>/dev/null || true
else
    echo "📦 Instalando Salesforce CLI..."
    npm install --global @salesforce/cli
fi

echo ""

################################################
# 6. VS Code Extensions
################################################

echo "────────────────────────────────────────────"
echo "6/6 - Extensões VS Code"
echo "────────────────────────────────────────────"

if command -v code &> /dev/null; then
    echo "📦 Instalando extensões..."
    
    echo "   → Salesforce Extension Pack..."
    code --install-extension salesforce.salesforcedx-vscode --force 2>/dev/null || true
    
    echo "   → GitLens..."
    code --install-extension eamodio.gitlens --force 2>/dev/null || true
else
    echo "⚠️  VS Code CLI não disponível ainda"
    echo "   Após reiniciar o Terminal, execute manualmente:"
    echo ""
    echo "   code --install-extension salesforce.salesforcedx-vscode"
    echo "   code --install-extension eamodio.gitlens"
fi

echo ""

################################################
# 7. Configuração do Git
################################################

echo "────────────────────────────────────────────"
echo "Configuração do Git"
echo "────────────────────────────────────────────"

CURRENT_NAME=$(git config --global user.name 2>/dev/null || echo "")
CURRENT_EMAIL=$(git config --global user.email 2>/dev/null || echo "")

if [[ -z "$CURRENT_NAME" ]]; then
    echo ""
    read -p "Digite seu nome completo: " git_name
    git config --global user.name "$git_name"
    echo "✅ Nome configurado: $git_name"
else
    echo "✅ Nome já configurado: $CURRENT_NAME"
fi

if [[ -z "$CURRENT_EMAIL" ]]; then
    echo ""
    read -p "Digite seu email corporativo: " git_email
    git config --global user.email "$git_email"
    echo "✅ Email configurado: $git_email"
else
    echo "✅ Email já configurado: $CURRENT_EMAIL"
fi

# Configurar VS Code como editor padrão do Git
git config --global core.editor "code --wait" 2>/dev/null || true

echo ""

echo ""
echo "╔════════════════════════════════════════════════════════════════╗"
echo "║                    📋 VERIFICAÇÃO FINAL                        ║"
echo "╚════════════════════════════════════════════════════════════════╝"
echo ""

echo "Versões instaladas:"
echo "────────────────────────────────────────────"

echo -n "  Git:            "
git --version 2>/dev/null | cut -d' ' -f3 || echo "❌ Não encontrado"

echo -n "  Node.js:        "
node --version 2>/dev/null || echo "❌ Não encontrado"

echo -n "  NPM:            "
npm --version 2>/dev/null || echo "❌ Não encontrado"

echo -n "  Salesforce CLI: "
sf --version 2>/dev/null | head -n 1 | cut -d' ' -f1-2 || echo "❌ Não encontrado"

if command -v code &> /dev/null; then
    echo -n "  VS Code:        "
    code --version 2>/dev/null | head -n 1 || echo "❌ Não encontrado"
else
    echo "  VS Code:        ⚠️  CLI não no PATH (ver instruções acima)"
fi

echo ""
echo "Configuração Git:"
echo "────────────────────────────────────────────"
echo "  Nome:  $(git config --global user.name 2>/dev/null || echo 'Não configurado')"
echo "  Email: $(git config --global user.email 2>/dev/null || echo 'Não configurado')"

echo ""
echo "╔════════════════════════════════════════════════════════════════╗"
echo "║              ✅ INSTALAÇÃO CONCLUÍDA COM SUCESSO!              ║"
echo "╚════════════════════════════════════════════════════════════════╝"
echo ""
