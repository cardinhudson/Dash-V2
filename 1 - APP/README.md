# 🚀 DASHBOARD KE5Z - STREAMLIT DESKTOP

## 📋 EXECUÇÃO SIMPLIFICADA

### 🥇 MÉTODO ÚNICO (RECOMENDADO)
1. **Duplo clique** em `DASHBOARD_KE5Z.bat`
2. Aguarde a instalação automática (primeira vez: 5-10 min)
3. O dashboard abrirá automaticamente em janela Desktop
4. **Funciona em QUALQUER PC Windows 11 sem Python instalado!**

---

## 🔧 REQUISITOS

- **Windows 10/11** (64-bit)
- **Conexão com internet** (apenas para primeira instalação)
- **Edge Webview2** (geralmente já instalado no Windows 10/11)
- **NÃO precisa Python instalado** (usa Python portátil)

---

## 📁 ESTRUTURA COMPLETA

```
1 - APP/
├── 🎯 DASHBOARD_KE5Z.bat        # ARQUIVO PRINCIPAL (execute este)
├── 📄 dashboard_main.py         # Código principal do dashboard
├── 🔐 auth_simple.py            # Sistema de autenticação
├── 📋 requirements.txt          # Dependências Python
├── 👥 dados_equipe.json         # Dados da equipe
├── 👤 usuarios_padrao.json      # Usuários padrão
│
├── 📊 KE5Z/                     # Dados principais do projeto
│   ├── KE5Z.parquet            # Dados completos
│   ├── KE5Z_main.parquet       # Dados principais
│   ├── KE5Z_others.parquet     # Dados secundários
│   └── KE5Z_waterfall.parquet  # Dados para análise waterfall
│
├── 📥 Extracoes/                # Dados para extração SAP
│   ├── KE5Z/                   # Arquivos .txt KE5Z
│   │   ├── ke5z agosto.txt
│   │   ├── ke5z julho.txt
│   │   └── ke5z setembro.txt
│   └── KSBB/                   # Arquivos .txt KSBB
│       ├── ksbb agosto.txt
│       ├── ksbb julho.txt
│       └── ksbb setembro.txt
│
├── 📤 arquivos/                 # Saída dos Excel gerados
│   ├── KE5Z_pwt.xlsx
│   └── KE5Z_veiculos.xlsx
│
├── 📑 pages/                    # Páginas do dashboard
│   ├── 1_Dash_Mes.py           # Dashboard Mensal
│   ├── 2_IUD_Assistant.py      # Assistente IA
│   ├── 3_Total_accounts.py     # Total de Contas
│   ├── 4_Waterfall_Analysis.py # Análise Waterfall
│   ├── 5_Admin_Usuarios.py     # Administração
│   ├── 6_Extracao_Dados.py     # Extração de Dados
│   └── 7_Sobre_Projeto.py      # Sobre o Projeto
│
└── 🐍 python_portable/          # Python portátil (criado automaticamente)
    ├── python.exe              # Interpretador Python
    ├── python311.zip           # Biblioteca padrão
    └── Lib/                    # Dependências instaladas
```

---

## 🎯 FUNCIONALIDADES COMPLETAS

### 📊 Dashboard Principal
- ✅ **Análise completa** de dados KE5Z
- ✅ **Gráficos interativos** por Período, Type 05, Type 06
- ✅ **Análise Type 07** com filtros específicos
- ✅ **Top N dinâmico** (10, 15, 20, 30, 50, 100)
- ✅ **Tabelas pivot inteligentes** (apenas valores ≠ 0)
- ✅ **Exportação para Excel** com formatação

### 📅 Dashboard Mensal
- ✅ **Análise focada** em período específico
- ✅ **Filtro de período** simplificado
- ✅ **Gráficos Type 05 e Type 06** filtrados

### 🤖 Assistente IA (IUD Assistant)
- ✅ **Perguntas em linguagem natural**
- ✅ **Análises automáticas** dos dados
- ✅ **Sugestões inteligentes** de insights

### 📈 Análise Waterfall
- ✅ **Gráficos de cascata** interativos
- ✅ **Visualização de variações** temporais
- ✅ **Comparações** entre períodos

### 📋 Total Accounts
- ✅ **Tabelas de contas completas**
- ✅ **Análise por Type 05 e Type 06**
- ✅ **Interface limpa** e otimizada

### 👑 Administração de Usuários
- ✅ **Gerenciamento de usuários**
- ✅ **Aprovação de cadastros**
- ✅ **Controle de acesso** por perfil

### 📥 Extração de Dados
- ✅ **Extração de dados SAP**
- ✅ **Processamento automático**
- ✅ **Geração de arquivos** Parquet e Excel
- ✅ **Filtros de mês** personalizáveis

---

## 🔒 SISTEMA DE AUTENTICAÇÃO

### 👤 Usuários Padrão

**👑 Administrador:**
- **Usuário:** `admin`
- **Senha:** `admin123`
- **Acesso:** Completo (todas as funcionalidades)

**👤 Usuário Normal:**
- **Usuário:** `user`
- **Senha:** `user123`
- **Acesso:** Análises e dashboards (sem administração)

### 🆕 Novo Cadastro
1. Clique em "Criar nova conta" na tela de login
2. Preencha os dados solicitados
3. Aguarde aprovação do administrador
4. Receba notificação de aprovação

---

## 🎨 CARACTERÍSTICAS DO STREAMLIT DESKTOP

### ✅ Vantagens da Janela Desktop
- **🖥️ Aplicativo Nativo:** Roda como aplicativo Windows
- **🎯 Interface Limpa:** Sem barras de endereço ou botões do navegador
- **⚡ Melhor Performance:** Otimizado para desktop
- **📱 Offline:** Funciona sem internet após instalação
- **💼 Profissional:** Aparência mais corporativa

### 📱 Interface Nativa
- Janela dedicada do aplicativo
- Barra de título personalizada
- Menu de contexto nativo do Windows
- Redimensionamento fluido
- Ícone na barra de tarefas

---

## ⚠️ RESOLUÇÃO DE PROBLEMAS

### ❌ Dashboard não abre em janela Desktop
**Causa:** Edge Webview2 não instalado ou desatualizado

**Solução:**
1. Baixe Edge Webview2: [Microsoft Download](https://developer.microsoft.com/microsoft-edge/webview2/)
2. Instale e reinicie o computador
3. Execute `DASHBOARD_KE5Z.bat` como administrador
4. Se persistir, o sistema fará fallback para o navegador

### ❌ Erro na primeira instalação
**Possíveis causas:** Conexão com internet, antivírus, permissões

**Solução:**
1. Verifique conexão com internet
2. Execute como administrador
3. Temporariamente desabilite antivírus
4. Aguarde completar (pode levar 10 minutos)

### ❌ "Python não encontrado" ou "Módulo não encontrado"
**Causa:** Instalação incompleta do Python portátil

**Solução:**
1. Delete a pasta `python_portable/`
2. Execute `DASHBOARD_KE5Z.bat` novamente
3. Aguarde nova instalação completa

### ❌ Dashboard não carrega dados
**Causa:** Arquivos de dados ausentes ou corrompidos

**Solução:**
- Verifique se `KE5Z/` contém arquivos `.parquet`
- Verifique se `Extracoes/` contém pastas `KE5Z/` e `KSBB/`
- Recopie os dados se necessário

### ❌ Erro de permissão ou "Acesso negado"
**Solução:**
1. Execute como administrador
2. Verifique se antivírus não está bloqueando
3. Mova para pasta sem caracteres especiais (ex: `C:\Dashboard\`)

---

## 🚀 DISTRIBUIÇÃO PARA OUTROS PCs

### 📦 Como Distribuir

1. **Copie toda a pasta "1 - APP"** para o PC destino
2. **Certifique-se** que o PC destino tem Windows 10/11
3. **Execute** `DASHBOARD_KE5Z.bat` no PC destino
4. **Aguarde** a instalação automática
5. **Pronto!** Dashboard funcionará normalmente

### ✅ O que é Instalado Automaticamente
- 🐍 **Python 3.11 portátil** (não interfere com Python do sistema)
- 📦 **Todas as dependências** necessárias
- 🖥️ **Streamlit e Streamlit Desktop**
- 📊 **Bibliotecas de análise** (pandas, altair, plotly)
- 📄 **Bibliotecas de exportação** (openpyxl, xlsxwriter)

### 💾 Requisitos do PC Destino
- ✅ Windows 10/11 (64-bit)
- ✅ Conexão com internet (apenas primeira vez)
- ✅ Pelo menos 2GB de espaço livre
- ❌ **NÃO precisa Python instalado**
- ❌ **NÃO precisa configuração adicional**

---

## 💡 DICAS AVANÇADAS DE USO

### 🎯 Filtros Inteligentes
- **Combinação de filtros:** Use múltiplos filtros simultaneamente
- **"Todos" vs específicos:** "Todos" seleciona todos os registros
- **Múltipla seleção:** Ctrl+clique para seleções múltiplas

### 📈 Gráficos Interativos
- **Hover:** Passe o mouse para valores detalhados
- **Zoom:** Clique e arraste para zoom em área específica
- **Reset:** Duplo clique para resetar zoom
- **Legenda:** Clique na legenda para ocultar/mostrar séries

### 📥 Exportação Avançada
- **Excel formatado:** Tabelas mantêm cores e formatação
- **Localização:** Arquivos salvos em `arquivos/`
- **Filtros aplicados:** Exportação respeita filtros ativos

### 🔍 Análise Type 07
- **Filtros específicos:** Escolha Type 05, Type 06 e Período
- **Top N dinâmico:** Selecione quantos registros mostrar
- **Tabela detalhada:** Valores organizados por período

### 🤖 Assistente IA
- **Perguntas naturais:** "Qual o maior valor em agosto?"
- **Análises automáticas:** IA sugere insights relevantes
- **Contexto:** Perguntas consideram filtros ativos

---

## 🎉 PRONTO PARA USAR!

1. **Execute** `DASHBOARD_KE5Z.bat`
2. **Aguarde** a instalação (primeira vez: 5-10 min)
3. **Faça login** com credenciais padrão
4. **Explore** todas as funcionalidades!

### 🔗 Links Úteis
- **Suporte:** Consulte a página "Sobre o Projeto" no dashboard
- **Atualizações:** Substitua a pasta "1 - APP" por versão mais recente

---

**💻 Dashboard KE5Z - Powered by Streamlit Desktop**
**🚀 Funciona em qualquer PC Windows 11 sem Python instalado!**


