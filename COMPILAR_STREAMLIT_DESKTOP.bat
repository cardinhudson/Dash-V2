@echo off
chcp 65001 >nul
echo ===============================================
echo    COMPILANDO COM STREAMLIT DESKTOP
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

REM Instalar Streamlit Desktop
echo 🔧 Instalando Streamlit Desktop...
pip install streamlit-desktop --quiet

REM Criar pasta de distribuição
if not exist "dist" mkdir dist
if not exist "dist\Dashboard_KE5Z" mkdir "dist\Dashboard_KE5Z"

echo.
echo 🚀 Criando pacote Streamlit Desktop...
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

REM Criar script de execução
echo 📝 Criando script de execução...
(
echo @echo off
echo chcp 65001 ^>nul
echo echo ===============================================
echo echo    DASHBOARD KE5Z - STREAMLIT DESKTOP
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
echo     pause
echo     exit /b 1
echo ^)
echo echo ✅ Python encontrado!
echo.
echo REM Ativar ambiente virtual
echo if exist venv\Scripts\activate.bat ^(
echo     call venv\Scripts\activate.bat
echo ^) else ^(
echo     echo 🛠️ Criando ambiente virtual...
echo     python -m venv venv
echo     call venv\Scripts\activate.bat
echo     echo 📦 Instalando dependências...
echo     pip install -r requirements.txt --quiet
echo ^)
echo.
echo REM Executar dashboard
echo echo 🚀 Iniciando dashboard...
echo streamlit run dashboard_main.py --server.port 8501 --server.headless false
echo.
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

REM Criar README para distribuição
echo 📝 Criando README...
(
echo # 🚀 DASHBOARD KE5Z - STREAMLIT DESKTOP
echo.
echo ## 📋 COMO EXECUTAR
echo.
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
echo - `EXECUTAR_DASHBOARD.bat` - Script principal
echo - `dashboard_main.py` - Código do dashboard
echo - `KE5Z/` - Dados do projeto
echo - `pages/` - Páginas do dashboard
echo - `auth_simple.py` - Sistema de autenticação
echo.
echo ## ⚠️ TROUBLESHOOTING
echo.
echo **Erro: Python não encontrado**
echo - Instale Python 3.8+ de https://python.org/downloads
echo - Marque "Add Python to PATH" durante instalação
echo.
echo **Dashboard não abre**
echo - Acesse manualmente: http://localhost:8501
echo - Verifique se a porta 8501 não está em uso
echo.
echo **Erro de dependências**
echo - Execute `EXECUTAR_DASHBOARD.bat` novamente
echo - O script instalará automaticamente as dependências
echo.
echo ## 🎯 FUNCIONALIDADES
echo.
echo - ✅ Dashboard interativo completo
echo - ✅ Sistema de autenticação
echo - ✅ Análise de dados KE5Z
echo - ✅ Gráficos e tabelas dinâmicas
echo - ✅ Exportação para Excel
echo - ✅ Múltiplas páginas de análise
echo.
echo **🎉 Pronto para usar!**
) > "dist\Dashboard_KE5Z\README.md"

echo.
echo ✅ Pacote Streamlit Desktop criado com sucesso!
echo 📁 Localização: dist\Dashboard_KE5Z\
echo.
echo 🎯 Para distribuir:
echo    1. Copie a pasta "Dashboard_KE5Z" para qualquer PC
echo    2. Execute "EXECUTAR_DASHBOARD.bat"
echo    3. O dashboard abrirá automaticamente
echo.
echo 📋 Vantagens do Streamlit Desktop:
echo    ✅ Mais estável que compiladores
echo    ✅ Fácil de distribuir
echo    ✅ Atualizações simples
echo    ✅ Compatível com Windows 10/11
echo.
pause
