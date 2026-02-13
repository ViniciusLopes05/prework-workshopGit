# Salesforce Dev Prework (Mac)

Script de instalação automática para o ambiente de desenvolvimento Salesforce.

## 🚀 O que será instalado

| Ferramenta | Descrição |
|------------|-----------|
| Homebrew | Gerenciador de pacotes para macOS |
| Git | Controle de versão |
| Node.js | Runtime JavaScript (necessário para SF CLI) |
| VS Code | Editor de código |
| Salesforce CLI | Ferramenta de linha de comando Salesforce |
| Salesforce Extension Pack | Extensão VS Code para Salesforce |
| GitLens | Extensão VS Code para Git |

## 📋 Como usar

### Opção 1: Comando direto (recomendado)

Abra o **Terminal** (`Cmd + Espaço` → digite "Terminal") e execute:

```bash
/bin/bash -c "$(curl -fsSL https://github.com/ViniciusLopes05/prework-workshopGit/v1.0/setup.sh)"
```

### Opção 2: Download manual

1. Baixe o arquivo `setup.sh`
2. Abra o Terminal
3. Navegue até a pasta: `cd ~/Downloads`
4. Dê permissão: `chmod +x setup.sh`
5. Execute: `./setup.sh`

## ✅ O script vai:

1. Instalar o que estiver faltando
2. Atualizar o que já estiver instalado
3. Pedir seu nome e email para configurar o Git
4. Mostrar um resumo das versões instaladas

## 📌 Após a instalação

### 1. Reinicie o Terminal

Feche e abra novamente para carregar as configurações.

### 2. Verifique as instalações

```bash
git --version
node --version
sf --version
code --version
```

### 3. Verifique as extensões no VS Code

1. Abra o VS Code
2. Pressione `Cmd+Shift+P`
3. Digite `SFDX`
4. Devem aparecer comandos como "SFDX: Create Project"
