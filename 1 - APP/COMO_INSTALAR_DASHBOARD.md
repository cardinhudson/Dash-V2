# 🚀 GUIA DE INSTALAÇÃO - DASHBOARD KE5Z

## 📋 Pré-requisitos

Antes de instalar o Dashboard, certifique-se de que seu computador possui:

- **Windows 10/11** (recomendado)
- **Python 3.8 ou superior** instalado
- **Conexão com a internet** (para baixar dependências)
- **Pelo menos 2GB de espaço livre** no disco

## 🔧 Instalação do Python (se necessário)

Se você não tem Python instalado:

1. Acesse: https://www.python.org/downloads/
2. Baixe a versão mais recente do Python
3. **IMPORTANTE**: Durante a instalação, marque a opção **"Add Python to PATH"**
4. Complete a instalação

## 🎯 Instalação do Dashboard

### Método 1: Instalação Automática (Recomendado)

1. **Baixe o projeto** do GitHub ou copie a pasta `1 - APP`
2. **Navegue até a pasta** `1 - APP`
3. **Clique duas vezes** no arquivo `INSTALAR_DASHBOARD.bat`
4. **Aguarde** a instalação automática (pode levar alguns minutos)
5. **Pronto!** O Dashboard estará instalado

### Método 2: Instalação Manual

Se preferir instalar manualmente:

1. Abra o **Prompt de Comando** na pasta `1 - APP`
2. Execute os comandos:

```bash
# Criar ambiente virtual
python -m venv venv

# Ativar ambiente virtual (Windows)
venv\Scripts\activate

# Instalar dependências
pip install -r requirements.txt
```

## 🚀 Como Executar o Dashboard

Após a instalação, você pode executar o Dashboard de várias formas:

### Opção 1: Dashboard no Navegador (Recomendado)
- Clique duas vezes em `EXECUTAR_DASHBOARD.bat`
- Abre automaticamente no seu navegador web

### Opção 2: Dashboard Interface Desktop Nativa
- Clique duas vezes em `EXECUTAR_STREAMLIT.bat`
- Usa o Streamlit em modo desktop (interface nativa, não navegador)

### Opção 3: Atalho na Área de Trabalho
- Use o atalho **"Dashboard KE5Z"** criado automaticamente na área de trabalho
- Clique duas vezes no atalho para iniciar o Dashboard no navegador

### Opção 4: Linha de Comando
```bash
# Navegue até a pasta do projeto
cd "1 - APP"

# Ative o ambiente virtual
venv\Scripts\activate

# Execute o Dashboard
python dashboard_main.py
```

## 🌐 Acessando o Dashboard

Após executar, o Dashboard abrirá automaticamente no seu navegador em:
- **URL**: http://localhost:8501
- **Porta**: 8501 (padrão)

## 📁 Estrutura do Projeto

```
1 - APP/
├── INSTALAR_DASHBOARD.bat          # Instalador principal
├── INSTALADOR_DASHBOARD.py         # Script de instalação
├── EXECUTAR_DASHBOARD.bat          # Executável do Dashboard
├── dashboard_main.py               # Aplicação principal
├── requirements.txt                # Dependências
├── venv/                          # Ambiente virtual (criado automaticamente)
├── pages/                         # Páginas do Dashboard
├── KE5Z/                          # Dados do projeto
├── arquivos/                      # Arquivos de dados
└── usuarios_padrao.json           # Configurações de usuário
```

## 🔧 Solução de Problemas

### Erro: "Python não encontrado"
- **Solução**: Instale o Python e certifique-se de marcar "Add Python to PATH"

### Erro: "Módulo não encontrado"
- **Solução**: Execute novamente o instalador ou instale manualmente:
  ```bash
  pip install -r requirements.txt
  ```

### Erro: "Porta já em uso"
- **Solução**: Feche outras instâncias do Dashboard ou reinicie o computador

### Dashboard não abre no navegador
- **Solução**: Acesse manualmente http://localhost:8501

## 📞 Suporte

Se encontrar problemas:

1. **Verifique** se seguiu todos os passos
2. **Consulte** os arquivos de log gerados
3. **Reinstale** o Dashboard se necessário
4. **Verifique** se o Python está funcionando: `python --version`

## 🔄 Atualizações

Para atualizar o Dashboard:

1. Baixe a nova versão
2. Execute novamente o instalador
3. O instalador atualizará automaticamente as dependências

## ⚡ Dicas de Performance

- **Feche** outros programas desnecessários
- **Use** um navegador moderno (Chrome, Firefox, Edge)
- **Mantenha** o Dashboard atualizado
- **Verifique** se há espaço suficiente no disco

---

**🎉 Pronto! Seu Dashboard KE5Z está instalado e funcionando!**

Para mais informações, consulte os outros arquivos README no projeto.
