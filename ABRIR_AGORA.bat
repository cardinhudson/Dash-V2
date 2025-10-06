@echo off
chcp 65001 >nul
title Dashboard KE5Z
echo.
echo ===============================================
echo    🚀 DASHBOARD KE5Z - ABERTURA IMEDIATA
echo ===============================================
echo.

cd /d "%~dp0"

REM Parar qualquer processo na porta 8501
echo 🔍 Verificando porta 8501...
for /f "tokens=5" %%a in ('netstat -ano ^| findstr :8501') do (
    echo ⚠️  Liberando porta 8501...
    taskkill /PID %%a /F >nul 2>&1
)

REM Aguardar um momento
timeout /t 2 >nul

REM Ativar ambiente virtual e executar
echo 🚀 Iniciando dashboard...
call venv\Scripts\activate.bat
streamlit run app.py --server.port 8501 --server.headless false

echo.
echo Dashboard finalizado!
pause
