@echo off
chcp 65001 >nul
echo ===============================================
echo    DASHBOARD KE5Z - STREAMLIT DESKTOP
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

REM Instalar dependências se necessário
echo 📦 Verificando dependências...
pip install -r requirements.txt --quiet
pip install streamlit-desktop-app --quiet

REM Verificar se a porta 8501 está em uso e liberar se necessário
echo 🔍 Verificando porta 8501...
for /f "tokens=5" %%a in ('netstat -ano ^| findstr :8501') do (
    echo ⚠️  Porta 8501 em uso! Liberando...
    taskkill /PID %%a /F >nul 2>&1
    timeout /t 2 >nul
)

REM Executar dashboard com Streamlit Desktop
echo 🚀 Iniciando dashboard com Streamlit Desktop...
echo.
echo 📱 O dashboard abrirá em uma janela de desktop
echo    (não no navegador, mas como aplicativo nativo)
echo.
echo ⚠️  IMPORTANTE: Mantenha esta janela aberta enquanto usar o dashboard!
echo.

streamlit-desktop run dashboard_main.py

echo.
echo Dashboard finalizado!
pause


