# 📁 Links para Pastas Implementados na Página de Extração

## ✅ **Funcionalidades Adicionadas**

### 🎯 **Seção "Acesso Rápido às Pastas"**

#### **📂 Dados de Entrada (KE5Z)**
- **Caminho completo**: Exibido com `os.path.abspath()`
- **Contagem de arquivos**: Número de arquivos .txt encontrados
- **Lista de arquivos**: Primeiros 3 arquivos com tamanho em MB
- **Status**: ✅ Verde se existe, ❌ Vermelho se não existe

#### **📊 Dados Processados (Parquet)**
- **Caminho completo**: Exibido com `os.path.abspath()`
- **Contagem de arquivos**: Número de arquivos .parquet
- **Lista detalhada**: Todos os arquivos com:
  - Nome do arquivo
  - Tamanho em MB
  - Data e hora de modificação
- **Status**: ✅ Verde se existe, ⚠️ Amarelo se não existe

#### **📋 Relatórios Excel**
- **Caminho completo**: Exibido com `os.path.abspath()`
- **Contagem de arquivos**: Número de arquivos .xlsx
- **Lista detalhada**: Todos os arquivos com:
  - Nome do arquivo
  - Tamanho em MB
  - Data e hora de modificação
- **Status**: ✅ Verde se existe, ⚠️ Amarelo se não existe

### 🚀 **Botões de Ação Rápida**

#### **Funcionalidade**
- **Abrir Pasta KE5Z**: Abre `Extrações/KE5Z` no Windows Explorer
- **Abrir Pasta Parquet**: Abre `KE5Z` no Windows Explorer
- **Abrir Pasta Excel**: Abre `arquivos` no Windows Explorer

#### **Comportamento Inteligente**
- **Habilitado**: Se a pasta existe
- **Desabilitado**: Se a pasta não existe
- **Layout**: 3 colunas com botões de largura total

## 📊 **Informações Exibidas**

### **Para cada pasta:**
1. **Caminho absoluto** completo
2. **Status** (existe/não existe)
3. **Contagem** de arquivos por tipo
4. **Lista de arquivos** com detalhes:
   - Nome do arquivo
   - Tamanho em MB
   - Data/hora de modificação

### **Formato de exibição:**
```
✅ C:\user\U235107\GitHub\Dash-V2\KE5Z
📊 4 arquivos .parquet
  • KE5Z.parquet (33.8 MB) - 04/10/2025 07:00
  • KE5Z_main.parquet (1.2 MB) - 04/10/2025 07:00
  • KE5Z_others.parquet (18.8 MB) - 04/10/2025 07:00
  • KE5Z_waterfall.parquet (9.0 MB) - 03/10/2025 19:57
```

## 🎨 **Interface Melhorada**

### **Layout Responsivo**
- **3 colunas** para as pastas principais
- **Botões de ação** organizados em 3 colunas
- **Status visual** com cores e ícones
- **Informações detalhadas** sem poluir a interface

### **Experiência do Usuário**
- **Acesso direto** às pastas com um clique
- **Informações em tempo real** sobre arquivos
- **Navegação intuitiva** com ícones e cores
- **Feedback visual** claro sobre status das pastas

## 🔧 **Implementação Técnica**

### **Funções Utilizadas**
- `os.path.exists()`: Verificar existência das pastas
- `os.path.abspath()`: Obter caminho absoluto
- `os.listdir()`: Listar arquivos nas pastas
- `os.path.getsize()`: Obter tamanho dos arquivos
- `os.path.getmtime()`: Obter timestamp de modificação
- `os.startfile()`: Abrir pastas no Windows Explorer

### **Tratamento de Erros**
- **Verificação de existência** antes de exibir informações
- **Botões desabilitados** quando pastas não existem
- **Mensagens de erro** claras e informativas
- **Fallback gracioso** para pastas ausentes

## 🎯 **Benefícios**

1. **Acesso rápido** às pastas de dados
2. **Visibilidade completa** do status dos arquivos
3. **Navegação intuitiva** com botões de ação
4. **Informações detalhadas** sobre cada arquivo
5. **Interface limpa** e organizada
6. **Feedback visual** imediato

## 📍 **Localização na Interface**

- **Aba**: "📁 Arquivos"
- **Seção**: "📁 Acesso Rápido às Pastas"
- **Posição**: No topo da aba, antes da verificação de arquivos necessários
- **Layout**: 3 colunas principais + 3 botões de ação
