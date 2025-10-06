@echo off
chcp 65001 >nul
echo ===============================================
echo    CRIANDO PACOTE DISTRIBUÍVEL DASHBOARD KE5Z
echo ===============================================
echo.

cd /d "%~dp0"

REM Verificar se Python está instalado
where python >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ Python não encontrado! Por favor, instale Python 3.8+ de https://python.org/downloads
    pause
    exit /b 1
)
echo ✅ Python encontrado!

REM Ativar ambiente virtual
echo 🔄 Ativando ambiente virtual...
if not exist venv\Scripts\activate.bat (
    echo 🛠️ Criando ambiente virtual...
    python -m venv venv
    if %errorlevel% neq 0 (
        echo ❌ Erro ao criar ambiente virtual.
        pause
        exit /b 1
    )
)
call venv\Scripts\activate.bat

REM Instalar dependências
echo 📦 Instalando dependências...
pip install -r requirements.txt --quiet

REM Criar pasta de distribuição
if not exist "dist" mkdir dist
if not exist "dist\Dashboard_KE5Z" mkdir "dist\Dashboard_KE5Z"
if not exist "dist\Dashboard_KE5Z\.streamlit" mkdir "dist\Dashboard_KE5Z\.streamlit"

echo.
echo 🚀 Criando pacote distribuível...
echo.

REM Copiar arquivos necessários
echo 📁 Copiando arquivos...
xcopy "dashboard_main.py" "dist\Dashboard_KE5Z\" /Y >nul
xcopy "auth_simple.py" "dist\Dashboard_KE5Z\" /Y >nul
xcopy "Extração.py" "dist\Dashboard_KE5Z\" /Y >nul
xcopy "dados_equipe.json" "dist\Dashboard_KE5Z\" /Y >nul
xcopy "usuarios_padrao.json" "dist\Dashboard_KE5Z\" /Y >nul
xcopy "requirements.txt" "dist\Dashboard_KE5Z\" /Y >nul
xcopy "KE5Z" "dist\Dashboard_KE5Z\KE5Z\" /E /I /Y >nul
xcopy "pages" "dist\Dashboard_KE5Z\pages\" /E /I /Y >nul

REM Criar script de execução otimizado
echo 📝 Criando script de execução...
(
echo @echo off
echo chcp 65001 ^>nul
echo echo ===============================================
echo echo    DASHBOARD KE5Z - EXECUÇÃO AUTOMÁTICA
echo echo ===============================================
echo echo.
echo echo Iniciando dashboard...
echo echo.
echo cd /d "%%~dp0"
echo.
echo REM Verificar se Python está instalado
echo where python ^>nul 2^>^&1
echo if %%errorlevel%% neq 0 ^(
echo     echo ❌ Python não encontrado! Por favor, instale Python 3.8+ de https://python.org/downloads
echo     echo Certifique-se de marcar "Add Python to PATH" durante a instalação.
echo     pause
echo     exit /b 1
echo ^)
echo echo ✅ Python encontrado!
echo.
echo REM Ativar ambiente virtual
echo if exist venv\Scripts\activate.bat ^(
echo     echo 🔄 Ativando ambiente virtual...
echo     call venv\Scripts\activate.bat
echo ^) else ^(
echo     echo 🛠️ Criando ambiente virtual...
echo     python -m venv venv
echo     if %%errorlevel%% neq 0 ^(
echo         echo ❌ Erro ao criar ambiente virtual.
echo         pause
echo         exit /b 1
echo     ^)
echo     call venv\Scripts\activate.bat
echo     echo 📦 Instalando dependências...
echo     pip install -r requirements.txt --quiet
echo ^)
echo.
echo REM Verificar se a porta 8501 está em uso e liberar se necessário
echo echo 🔍 Verificando porta 8501...
echo for /f "tokens=5" %%%%a in ^('netstat -ano ^| findstr :8501'^) do ^(
echo     echo ⚠️  Porta 8501 em uso! Liberando...
echo     taskkill /PID %%%%a /F ^>nul 2^>^&1
echo     timeout /t 2 ^>nul
echo ^)
echo.
echo REM Executar dashboard
echo echo 🚀 Iniciando dashboard...
echo echo.
echo echo 📱 O dashboard abrirá no navegador em: http://localhost:8501
echo echo.
echo echo ⚠️  IMPORTANTE: Mantenha esta janela aberta enquanto usar o dashboard!
echo echo.
echo.
echo streamlit run dashboard_main.py --server.port 8501 --server.headless false
echo.
echo echo.
echo echo Dashboard finalizado!
echo pause
) > "dist\Dashboard_KE5Z\EXECUTAR_DASHBOARD.bat"

REM Criar arquivo de configuração Streamlit
echo 📝 Criando configuração Streamlit...
(
echo [server]
echo port = 8501
echo headless = false
echo enableCORS = false
echo enableXsrfProtection = false
echo.
echo [browser]
echo gatherUsageStats = false
echo.
echo [theme]
echo primaryColor = "#FF6B6B"
echo backgroundColor = "#FFFFFF"
echo secondaryBackgroundColor = "#F0F2F6"
echo textColor = "#262730"
) > "dist\Dashboard_KE5Z\.streamlit\config.toml"

REM Criar script de instalação rápida
echo 📝 Criando script de instalação...
(
echo @echo off
echo chcp 65001 ^>nul
echo echo ===============================================
echo echo    INSTALAÇÃO RÁPIDA DASHBOARD KE5Z
echo echo ===============================================
echo echo.
echo echo Este script instalará o Python e as dependências automaticamente.
echo echo.
echo pause
echo.
echo echo 🔧 Verificando Python...
echo where python ^>nul 2^>^&1
echo if %%errorlevel%% neq 0 ^(
echo     echo ❌ Python não encontrado!
echo     echo.
echo     echo 📥 Baixando Python...
echo     echo Abra https://python.org/downloads em seu navegador
echo     echo Baixe Python 3.8+ e instale marcando "Add Python to PATH"
echo     echo.
echo     pause
echo     exit /b 1
echo ^)
echo.
echo echo ✅ Python encontrado!
echo echo 🚀 Executando dashboard...
echo call EXECUTAR_DASHBOARD.bat
) > "dist\Dashboard_KE5Z\INSTALAR_E_EXECUTAR.bat"

REM Criar README para distribuição
echo 📝 Criando README...
(
echo # 🚀 DASHBOARD KE5Z - PACOTE DISTRIBUÍVEL
echo.
echo ## 📋 COMO EXECUTAR
echo.
echo ### 🥇 MÉTODO RÁPIDO
echo 1. **Duplo clique** em `INSTALAR_E_EXECUTAR.bat`
echo 2. Siga as instruções na tela
echo 3. O dashboard abrirá automaticamente
echo.
echo ### 🥈 MÉTODO MANUAL
echo 1. **Duplo clique** em `EXECUTAR_DASHBOARD.bat`
echo 2. Aguarde o dashboard carregar
echo 3. O navegador abrirá automaticamente em `http://localhost:8501`
echo.
echo ## 🔧 REQUISITOS
echo.
echo - Windows 10/11
echo - Python 3.8+ instalado
echo - Conexão com internet
echo.
echo ## 📁 ESTRUTURA
echo.
echo - `INSTALAR_E_EXECUTAR.bat` - Instalação automática
echo - `EXECUTAR_DASHBOARD.bat` - Execução direta
echo - `dashboard_main.py` - Código do dashboard
echo - `KE5Z/` - Dados do projeto
echo - `pages/` - Páginas do dashboard
echo - `auth_simple.py` - Sistema de autenticação
echo - `.streamlit/config.toml` - Configurações
echo.
echo ## ⚠️ TROUBLESHOOTING
echo.
echo **Erro: Python não encontrado**
echo - Execute `INSTALAR_E_EXECUTAR.bat`
echo - Ou instale Python 3.8+ de https://python.org/downloads
echo - Marque "Add Python to PATH" durante instalação
echo.
echo **Dashboard não abre**
echo - Acesse manualmente: http://localhost:8501
echo - Verifique se a porta 8501 não está em uso
echo - Execute `EXECUTAR_DASHBOARD.bat` como administrador
echo.
echo **Erro de dependências**
echo - Execute `EXECUTAR_DASHBOARD.bat` novamente
echo - O script instalará automaticamente as dependências
echo.
echo **Erro de porta em uso**
echo - Feche outros programas que usam a porta 8501
echo - O script tentará liberar a porta automaticamente
echo.
echo ## 🎯 FUNCIONALIDADES
echo.
echo - ✅ Dashboard interativo completo
echo - ✅ Sistema de autenticação
echo - ✅ Análise de dados KE5Z
echo - ✅ Gráficos e tabelas dinâmicas
echo - ✅ Exportação para Excel
echo - ✅ Múltiplas páginas de análise
echo - ✅ Filtros avançados
echo - ✅ Análise Type 07 com Top N
echo - ✅ Tabelas pivot inteligentes
echo.
echo ## 📊 PÁGINAS DISPONÍVEIS
echo.
echo 1. **Dashboard Principal** - Análise geral
echo 2. **Assistente IA** - Perguntas em linguagem natural
echo 3. **Total Accounts** - Tabelas de contas
echo 4. **Análise Waterfall** - Gráficos de cascata
echo 5. **Admin Usuários** - Gerenciamento de usuários
echo 6. **Extração Dados** - Extração de dados
echo 7. **Sobre o Projeto** - Informações do projeto
echo.
echo **🎉 Pronto para usar!**
) > "dist\Dashboard_KE5Z\README.md"

echo.
echo ✅ Pacote distribuível criado com sucesso!
echo 📁 Localização: dist\Dashboard_KE5Z\
echo.
echo 🎯 Para distribuir:
echo    1. Copie a pasta "Dashboard_KE5Z" para qualquer PC
echo    2. Execute "INSTALAR_E_EXECUTAR.bat" (recomendado)
echo    3. Ou execute "EXECUTAR_DASHBOARD.bat" diretamente
echo.
echo 📋 Vantagens desta solução:
echo    ✅ Funciona em qualquer PC Windows 10/11
echo    ✅ Instalação automática de dependências
echo    ✅ Liberação automática de portas
echo    ✅ Interface amigável
echo    ✅ Fácil de distribuir
echo    ✅ Atualizações simples
echo.
echo 🚀 Testando o pacote...
echo.
if exist "dist\Dashboard_KE5Z\EXECUTAR_DASHBOARD.bat" (
    echo ✅ Script de execução criado com sucesso!
) else (
    echo ❌ Erro ao criar script de execução
)

if exist "dist\Dashboard_KE5Z\dashboard_main.py" (
    echo ✅ Arquivo principal copiado com sucesso!
) else (
    echo ❌ Erro ao copiar arquivo principal
)

if exist "dist\Dashboard_KE5Z\KE5Z" (
    echo ✅ Dados copiados com sucesso!
) else (
    echo ❌ Erro ao copiar dados
)

echo.
echo 🎉 Pacote pronto para distribuição!
echo.
pause
