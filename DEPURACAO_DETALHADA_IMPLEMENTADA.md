# 🔍 Depuração Detalhada Implementada na Página de Extração

## ✅ **Funcionalidades de Depuração Adicionadas**

### 🎯 **Seção "Depuração Detalhada" (Expandível)**

A nova seção de depuração está localizada na aba "📁 Arquivos" e pode ser expandida/contraída conforme necessário.

---

## 🐍 **1. Informações do Ambiente Python**

### **Executável Python**
- **Caminho completo** do executável Python sendo usado
- **Versão Python** detalhada
- **Diretório de trabalho** atual

### **Plataforma e Sistema**
- **Plataforma** (Windows, Linux, etc.)
- **Encoding padrão** do sistema
- **Variáveis de ambiente** importantes:
  - `PATH` (truncado para 100 caracteres)
  - `PYTHONPATH`
  - `VIRTUAL_ENV`

---

## 📦 **2. Verificação de Dependências**

### **Módulos Verificados**
- **Pandas** - Processamento de dados
- **NumPy** - Computação numérica
- **OpenPyXL** - Manipulação de Excel
- **Streamlit** - Interface web
- **Plotly** - Gráficos interativos
- **Módulos built-in** (os, glob, subprocess, datetime)

### **Informações Exibidas**
- ✅ **Status de importação** (sucesso/erro)
- 📊 **Versão** de cada módulo
- ❌ **Mensagens de erro** detalhadas

---

## 📁 **3. Verificação de Arquivos e Pastas**

### **Arquivos e Pastas Verificados**
- **Extração.py** - Script principal
- **Extrações/KE5Z** - Pasta de dados de entrada
- **KE5Z** - Pasta de dados processados
- **arquivos** - Pasta de relatórios Excel
- **requirements.txt** - Dependências do projeto

### **Informações Detalhadas**
- ✅ **Status de existência**
- 📊 **Tamanho** (para arquivos)
- 📁 **Contagem de arquivos** (para pastas)
- 📍 **Caminho absoluto** completo

---

## 🧪 **4. Teste de Execução**

### **Botão "Executar Teste de Depuração"**
Executa testes práticos para verificar o funcionamento:

#### **Teste de Importação**
- Importa pandas e numpy
- Verifica se as bibliotecas estão funcionando

#### **Teste de Leitura de Arquivo**
- Localiza arquivos .txt na pasta KE5Z
- Tenta ler o primeiro arquivo encontrado
- Exibe informações sobre colunas e linhas
- Mostra erros de encoding ou formato

#### **Teste de Escrita**
- Cria um DataFrame de teste
- Salva como arquivo Parquet
- Verifica se a escrita funciona
- Remove o arquivo de teste automaticamente

---

## 💻 **5. Informações do Sistema**

### **Memória Disponível**
- **Total** de RAM disponível
- **Disponível** para uso
- **Percentual** de uso atual

### **Espaço em Disco**
- **Total** de espaço em disco
- **Livre** para uso
- **Percentual** de uso atual

### **Processos Python Ativos**
- **Contagem** de processos Python
- **PID** e uso de memória dos principais processos
- **Monitoramento** de recursos

### **Timestamp Atual**
- **Data e hora** atual do sistema
- **Formato** brasileiro (dd/mm/aaaa hh:mm:ss)

---

## 🎨 **Interface e Usabilidade**

### **Layout Responsivo**
- **2 colunas** para informações do Python
- **3 colunas** para dependências
- **Layout flexível** para arquivos e pastas
- **2 colunas** para informações do sistema

### **Feedback Visual**
- ✅ **Verde** para sucessos
- ❌ **Vermelho** para erros
- ⚠️ **Amarelo** para avisos
- ℹ️ **Azul** para informações

### **Código Formatado**
- **Blocos de código** para caminhos e versões
- **Formatação** clara e legível
- **Truncamento** inteligente para textos longos

---

## 🔧 **Funcionalidades Técnicas**

### **Tratamento de Erros**
- **Try/catch** para importações
- **Verificação de existência** antes de acessar arquivos
- **Fallback gracioso** quando módulos não estão disponíveis

### **Performance**
- **Importações sob demanda** (apenas quando necessário)
- **Testes opcionais** (executados apenas quando solicitado)
- **Limpeza automática** de arquivos de teste

### **Compatibilidade**
- **Funciona** mesmo sem psutil instalado
- **Detecção automática** de módulos disponíveis
- **Encoding** adequado para Windows

---

## 🎯 **Como Usar**

1. **Acesse** a página "Extração de Dados"
2. **Clique** na aba "📁 Arquivos"
3. **Expanda** a seção "🔍 Depuração Detalhada"
4. **Visualize** as informações do ambiente
5. **Clique** em "🔬 Executar Teste de Depuração" para testes práticos
6. **Monitore** o status de dependências e arquivos

---

## 📊 **Benefícios**

1. **Diagnóstico rápido** de problemas
2. **Verificação completa** do ambiente
3. **Testes práticos** de funcionalidade
4. **Informações detalhadas** do sistema
5. **Interface intuitiva** e organizada
6. **Depuração** sem sair da aplicação

---

## 🔍 **Exemplo de Saída**

```
🐍 Informações do Ambiente Python
Executável Python: C:\Users\u235107\AppData\Local\Programs\Python\Python313\python.exe
Versão Python: 3.13.0 (main, Oct 2 2024, 10:05:00) [MSC v.1939 64 bit (AMD64)]
Diretório de Trabalho: C:\user\U235107\GitHub\Dash-V2

📦 Verificação de Dependências
✅ pandas v2.1.4
✅ numpy v1.26.2
✅ openpyxl v3.1.2
✅ streamlit v1.28.1
❌ plotly: No module named 'plotly'

📁 Verificação de Arquivos e Pastas
Extração.py (Script principal) ✅ Arquivo (23,884 bytes)
Extrações/KE5Z (Pasta de dados KE5Z) ✅ Pasta (3 arquivos)
KE5Z (Pasta de dados processados) ✅ Pasta (4 arquivos)
arquivos (Pasta de relatórios Excel) ✅ Pasta (2 arquivos)
```

A depuração detalhada agora está disponível e funcionando! 🎉
