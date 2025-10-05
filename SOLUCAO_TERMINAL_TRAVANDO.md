# 🔧 SOLUÇÃO PARA TERMINAL TRAVANDO

## 🚨 **PROBLEMA IDENTIFICADO**
O terminal integrado do Cursor/VS Code está travando quando executo comandos, causando:
- Comandos interrompidos
- Processos não finalizados
- Dificuldade para executar scripts

## ✅ **SOLUÇÕES ALTERNATIVAS**

### **1. USAR PROMPT DE COMANDO EXTERNO**
```batch
# Abrir CMD/PowerShell separadamente
# Navegar para a pasta do projeto
cd C:\user\U235107\GitHub\Dash

# Executar comandos diretamente
python --version
pip install plotly
```

### **2. USAR ARQUIVOS .BAT PARA EXECUÇÃO**
```batch
# Criar arquivo.bat com comandos
@echo off
python --version
pip install plotly
pause
```

### **3. USAR PYTHON DIRETAMENTE**
```python
# Executar Python sem terminal
import subprocess
import sys

# Instalar Plotly
subprocess.run([sys.executable, "-m", "pip", "install", "plotly==5.17.0"])
```

## 🛠️ **CONFIGURAÇÕES RECOMENDADAS**

### **VS Code/Cursor Settings:**
```json
{
    "terminal.integrated.shell.windows": "cmd.exe",
    "terminal.integrated.shellArgs.windows": ["/k", "chcp 65001"],
    "terminal.integrated.cwd": "${workspaceFolder}",
    "terminal.integrated.env.windows": {
        "PYTHONPATH": ""
    }
}
```

### **PowerShell como Alternativa:**
```json
{
    "terminal.integrated.defaultProfile.windows": "PowerShell",
    "terminal.integrated.profiles.windows": {
        "PowerShell": {
            "source": "PowerShell",
            "args": ["-NoExit", "-Command", "chcp 65001"]
        }
    }
}
```

## 🚀 **SCRIPTS PRONTOS PARA USO**

### **1. Verificar Python:**
```batch
@echo off
echo Verificando Python...
python --version
python -c "import sys; print('Python Path:', sys.executable)"
pause
```

### **2. Instalar Dependências:**
```batch
@echo off
echo Instalando dependências...
pip install streamlit pandas altair plotly==5.17.0 openpyxl pyarrow
echo Instalação concluída!
pause
```

### **3. Executar Dashboard:**
```batch
@echo off
echo Iniciando Dashboard...
streamlit run Dash.py --server.port 8501
pause
```

## 🔍 **DIAGNÓSTICO DO PROBLEMA**

### **Possíveis Causas:**
1. **Proxy Corporativo** - Bloqueia conexões
2. **Antivírus** - Intercepta comandos
3. **Permissões** - Usuário sem privilégios
4. **Encoding** - Problemas de caracteres
5. **Python Path** - Configuração incorreta

### **Testes de Diagnóstico:**
```batch
# Teste 1: Python básico
python -c "print('Python funcionando')"

# Teste 2: Pip básico
pip --version

# Teste 3: Conexão internet
ping google.com

# Teste 4: Permissões
echo test > test.txt
del test.txt
```

## 🎯 **RECOMENDAÇÃO FINAL**

**Use arquivos .bat para todas as operações:**
1. ✅ Mais confiável que terminal integrado
2. ✅ Não trava com comandos longos
3. ✅ Fácil de debugar
4. ✅ Funciona em qualquer ambiente
5. ✅ Pode ser executado independentemente

**Exemplo de uso:**
```batch
# Executar limpeza
limpar_arquivos_desnecessarios.bat

# Instalar Plotly
instalar_plotly.bat

# Abrir Dashboard
abrir_dashboard.bat
```

## 📝 **NOTA IMPORTANTE**
O problema do terminal travando é comum em ambientes corporativos. A solução com arquivos .bat é mais robusta e confiável para este projeto.
