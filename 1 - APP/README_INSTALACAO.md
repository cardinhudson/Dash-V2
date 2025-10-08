# 🖥️ Dashboard KE5Z Desktop - Guia de Instalação

## 📋 Scripts Disponíveis

### 🚀 **INSTALAR.bat** (PRINCIPAL)
**Script unificado que faz tudo automaticamente:**
- ✅ Verifica e instala dependências
- ✅ Compila o executável
- ✅ Instala o aplicativo
- ✅ Cria atalho na área de trabalho

**Como usar:**
```bash
.\INSTALAR.bat
```

### 🖥️ **ABRIR.bat**
**Para abrir o aplicativo instalado:**
- ✅ Abre o Dashboard rapidamente
- ✅ Verifica se está instalado
- ✅ Inicia o aplicativo

**Como usar:**
```bash
.\ABRIR.bat
```

### 🧹 **LIMPAR.bat**
**Para limpar tudo e começar do zero:**
- ✅ Remove instalação anterior
- ✅ Remove arquivos de build
- ✅ Remove atalhos
- ✅ Fecha processos em execução
- ✅ Limpa arquivos temporários

**Como usar:**
```bash
.\LIMPAR.bat
```

## 🎯 Processo Recomendado

### 1️⃣ **Primeira Instalação:**
```bash
.\INSTALAR.bat
```

### 2️⃣ **Abrir o Aplicativo:**
```bash
.\ABRIR.bat
```

### 3️⃣ **Se houver problemas:**
```bash
.\LIMPAR.bat
.\INSTALAR.bat
```

## 📁 Estrutura Final

Após a instalação, você terá:

```
Dashboard_KE5Z_FINAL_DESKTOP/
├── Dashboard_KE5Z_Desktop.exe    # Executável principal
└── _internal/                    # Dados e dependências
    ├── Extracao.py
    ├── usuarios.json
    ├── usuarios_padrao.json
    ├── Dados SAPIENS.xlsx
    ├── Fornecedores.xlsx
    ├── Extracoes/
    └── arquivos/
```

## 🖥️ Como Executar

### Opção 1: Atalho na Área de Trabalho
- Clique no atalho **"Dashboard KE5Z Desktop"**

### Opção 2: Executável Direto
```bash
.\Dashboard_KE5Z_FINAL_DESKTOP\Dashboard_KE5Z_Desktop.exe
```

## ✨ Características

- 🖥️ **Aplicativo Desktop Nativo** - Interface nativa do Windows
- 🚀 **Independente** - Funciona sem Python instalado
- 🔒 **Seguro** - Execução local, sem dependências externas
- ⚡ **Rápido** - Inicialização otimizada
- 🎨 **Moderno** - Interface Streamlit integrada

## 🛠️ Requisitos do Sistema

- **Windows 10/11** (64-bit)
- **4GB RAM** (mínimo)
- **100MB** espaço em disco
- **Visual C++ Redistributable** (geralmente já instalado)

## ❓ Solução de Problemas

### Erro: "Executável não encontrado"
```bash
.\INSTALAR.bat
```

### Erro: "Arquivo em uso"
```bash
.\LIMPAR.bat
.\INSTALAR.bat
```

### Erro: "Dependências não encontradas"
```bash
pip install streamlit-desktop-app
.\INSTALAR.bat
```

### Erro: "Dashboard não encontrado"
```bash
.\INSTALAR.bat
.\ABRIR.bat
```

## 📞 Suporte

Se encontrar problemas:
1. Execute `LIMPAR.bat`
2. Execute `INSTALAR.bat`
3. Verifique se o Windows está atualizado
4. Reinicie o computador se necessário

---

**🎉 Dashboard KE5Z Desktop - Aplicativo nativo para Windows!**
