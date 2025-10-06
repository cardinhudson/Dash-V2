# 📋 DASHBOARD KE5Z - GUIA DE INSTALAÇÃO

## 🚀 INSTALAÇÃO AUTOMÁTICA (RECOMENDADO)

### ✅ Método Único - Funciona em Qualquer PC

1. **Copie a pasta "1 - APP"** para o PC destino
2. **Duplo clique** em `DASHBOARD_KE5Z.bat`
3. **Aguarde** a instalação automática (5-10 minutos na primeira vez)
4. **Pronto!** O dashboard abrirá em janela Desktop

### 🎯 Características

- ✅ **Não precisa Python instalado** no PC destino
- ✅ **Janela Desktop nativa** (não abre no navegador)
- ✅ **Funciona offline** após instalação
- ✅ **Python portátil** incluído automaticamente
- ✅ **Todas as dependências** instaladas automaticamente

---

## 📁 ESTRUTURA DA PASTA

```
1 - APP/
├── DASHBOARD_KE5Z.bat           # ← EXECUTE ESTE ARQUIVO
├── dashboard_main.py            # Código principal
├── auth_simple.py               # Sistema de autenticação
├── requirements.txt             # Dependências Python
├── KE5Z/                        # Dados do projeto
│   ├── KE5Z.parquet            # Dados completos
│   ├── KE5Z_main.parquet       # Dados principais
│   └── KE5Z_others.parquet     # Dados secundários
├── Extracoes/                   # Dados para extração
│   ├── KE5Z/                   # Arquivos .txt KE5Z
│   └── KSBB/                   # Arquivos .txt KSBB
├── arquivos/                    # Saída dos Excel gerados
├── pages/                       # Páginas do dashboard
│   ├── 1_Dash_Mes.py           # Dashboard Mensal
│   ├── 2_IUD_Assistant.py      # Assistente IA
│   ├── 3_Total_accounts.py     # Total de Contas
│   ├── 4_Waterfall_Analysis.py # Análise Waterfall
│   ├── 5_Admin_Usuarios.py     # Administração
│   ├── 6_Extracao_Dados.py     # Extração de Dados
│   └── 7_Sobre_Projeto.py      # Sobre o Projeto
└── python_portable/             # Python portátil (criado automaticamente)
```

---

## 🎯 FUNCIONALIDADES

### 📊 Dashboard Principal
- ✅ Análise completa de dados KE5Z
- ✅ Gráficos interativos por Período, Type 05, Type 06
- ✅ Análise Type 07 com filtros específicos
- ✅ Top N dinâmico (10, 15, 20, 30, 50, 100)
- ✅ Tabelas pivot inteligentes
- ✅ Exportação para Excel

### 📅 Dashboard Mensal
- ✅ Análise focada em período específico
- ✅ Filtro de período simplificado
- ✅ Gráficos filtrados

### 🤖 Assistente IA
- ✅ Perguntas em linguagem natural
- ✅ Análises automáticas
- ✅ Sugestões inteligentes

### 📈 Análise Waterfall
- ✅ Gráficos de cascata
- ✅ Visualização de variações
- ✅ Comparações temporais

### 👑 Administração
- ✅ Gerenciamento de usuários
- ✅ Aprovação de cadastros
- ✅ Controle de acesso

### 📥 Extração de Dados
- ✅ Extração de dados SAP
- ✅ Processamento automático
- ✅ Geração de arquivos Parquet e Excel

---

## 🔒 SISTEMA DE AUTENTICAÇÃO

### 👤 Usuários Padrão

**Administrador:**
- Usuário: `admin`
- Senha: `admin123`
- Acesso completo ao sistema

**Usuário Normal:**
- Usuário: `user`
- Senha: `user123`
- Acesso às análises

---

## ⚠️ RESOLUÇÃO DE PROBLEMAS

### ❌ Dashboard não abre em janela Desktop
**Solução:**
1. Instale o Edge Webview2: [Download Microsoft](https://developer.microsoft.com/microsoft-edge/webview2/)
2. Execute `DASHBOARD_KE5Z.bat` como administrador
3. Se persistir, o sistema fará fallback para o navegador automaticamente

### ❌ Erro na primeira instalação
**Solução:**
1. Verifique se há conexão com internet
2. Execute como administrador
3. Aguarde completar (pode levar 10 minutos)

### ❌ "Arquivo não encontrado" ou erro de permissão
**Solução:**
1. Execute como administrador
2. Verifique se antivírus não está bloqueando
3. Descompacte em pasta sem caracteres especiais

### ❌ Dashboard não carrega dados
**Solução:**
- Certifique-se que as pastas `KE5Z/`, `Extracoes/` existem
- Verifique se os arquivos `.parquet` e `.txt` estão presentes

---

## 🚀 DISTRIBUIÇÃO PARA OUTROS PCs

### Para usar em outro PC:

1. **Copie toda a pasta "1 - APP"** para o PC destino
2. **Execute** `DASHBOARD_KE5Z.bat` no PC destino
3. **Aguarde** a instalação automática
4. **Pronto!** Dashboard funcionará normalmente

### O que é instalado automaticamente:
- ✅ Python 3.11 portátil (não interfere com Python do sistema)
- ✅ Todas as dependências necessárias
- ✅ Streamlit e Streamlit Desktop
- ✅ Bibliotecas de análise de dados

---

## 💡 DICAS DE USO

### 🎯 Filtros
- Use filtros combinados para análises específicas
- "Todos" seleciona todos os registros
- Múltipla seleção disponível

### 📈 Gráficos
- Passe o mouse para ver valores detalhados
- Clique e arraste para zoom
- Duplo clique para resetar zoom

### 📥 Exportação
- Clique em "Baixar Excel" para exportar
- Arquivos salvos na pasta `arquivos/`

---

## 🎉 PRONTO PARA USAR!

1. Execute `DASHBOARD_KE5Z.bat`
2. Aguarde a instalação (primeira vez)
3. Faça login com suas credenciais
4. Explore todas as funcionalidades!

**💻 Dashboard KE5Z - Desenvolvido com Streamlit Desktop**


