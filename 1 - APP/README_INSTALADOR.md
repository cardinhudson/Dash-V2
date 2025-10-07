# 🚀 INSTALADOR AUTOMÁTICO - DASHBOARD KE5Z

## 📋 Visão Geral

Este instalador automático facilita a instalação e configuração do Dashboard KE5Z em qualquer computador Windows, automatizando todo o processo de configuração.

## 🎯 Características

- ✅ **Instalação Automática**: Configura tudo automaticamente
- ✅ **Verificação de Dependências**: Verifica se o Python está instalado
- ✅ **Ambiente Virtual**: Cria ambiente isolado para o projeto
- ✅ **Scripts de Execução**: Cria arquivos .bat para execução fácil
- ✅ **Atalhos**: Cria atalho na área de trabalho
- ✅ **Verificação**: Confirma se a instalação foi bem-sucedida
- ✅ **Desinstalador**: Remove completamente o Dashboard

## 📁 Arquivos do Instalador

```
1 - APP/
├── INSTALAR_DASHBOARD.bat          # Instalador principal (clique duplo)
├── INSTALADOR_DASHBOARD.py         # Script Python do instalador
├── DESINSTALAR_DASHBOARD.bat       # Desinstalador
├── DESINSTALAR_DASHBOARD.py        # Script Python do desinstalador
├── installer_config.json           # Configurações do instalador
├── COMO_INSTALAR_DASHBOARD.md      # Guia detalhado de instalação
└── README_INSTALADOR.md            # Este arquivo
```

## 🚀 Como Usar

### Para Instalar:
1. **Clique duas vezes** em `INSTALAR_DASHBOARD.bat`
2. **Aguarde** a instalação automática
3. **Pronto!** Use o atalho na área de trabalho

### Para Desinstalar:
1. **Clique duas vezes** em `DESINSTALAR_DASHBOARD.bat`
2. **Confirme** a desinstalação
3. **Pronto!** O Dashboard foi removido

## 🔧 Requisitos do Sistema

- **Windows 10/11**
- **Python 3.8+** instalado
- **Conexão com internet** (para baixar dependências)
- **2GB de espaço livre** no disco

## 📋 Processo de Instalação

O instalador executa as seguintes etapas automaticamente:

1. **Verificação do Python**: Confirma se Python 3.8+ está instalado
2. **Criação do Ambiente Virtual**: Cria ambiente isolado
3. **Atualização do pip**: Atualiza para a versão mais recente
4. **Instalação de Dependências**: Instala todas as bibliotecas necessárias
5. **Criação de Scripts**: Cria arquivos .bat para execução
6. **Criação de Atalhos**: Cria atalho na área de trabalho
7. **Verificação Final**: Confirma se tudo está funcionando

## 🛠️ Personalização

Você pode personalizar o instalador editando o arquivo `installer_config.json`:

```json
{
    "installer": {
        "name": "Dashboard KE5Z",
        "version": "1.0.0",
        "python_min_version": "3.8",
        "create_shortcut": true,
        "default_port": 8501
    }
}
```

## 🔍 Solução de Problemas

### Erro: "Python não encontrado"
- **Solução**: Instale Python 3.8+ de https://python.org
- **Importante**: Marque "Add Python to PATH" durante a instalação

### Erro: "Falha ao criar ambiente virtual"
- **Solução**: Execute como administrador ou verifique permissões

### Erro: "Falha ao instalar dependências"
- **Solução**: Verifique conexão com internet e execute novamente

### Erro: "Porta já em uso"
- **Solução**: Feche outras instâncias do Dashboard

## 📊 Logs e Debugging

O instalador gera logs automáticos. Para debug:

1. Execute o instalador via linha de comando:
   ```cmd
   python INSTALADOR_DASHBOARD.py
   ```

2. Verifique os logs de erro
3. Consulte a documentação de cada biblioteca

## 🔄 Atualizações

Para atualizar o instalador:

1. Baixe a nova versão
2. Substitua os arquivos do instalador
3. Execute novamente o instalador

## 📞 Suporte

Se encontrar problemas:

1. **Verifique** os requisitos do sistema
2. **Consulte** o arquivo `COMO_INSTALAR_DASHBOARD.md`
3. **Execute** o instalador via linha de comando para ver erros
4. **Verifique** se o Python está funcionando: `python --version`

## 🎯 Próximos Passos

Após a instalação:

1. **Execute** o Dashboard usando o atalho
2. **Acesse** http://localhost:8501 no navegador
3. **Configure** os usuários se necessário
4. **Importe** seus dados

---

**🎉 Instalador criado com sucesso!**

O Dashboard KE5Z agora pode ser instalado facilmente em qualquer computador Windows com apenas alguns cliques!
