@echo off
title Dashboard KE5Z - Streamlit Desktop
echo ===============================================
echo    DASHBOARD KE5Z - STREAMLIT DESKTOP
echo ===============================================
echo.

cd /d "%~dp0"

echo Verificando arquivos...
if not exist "dashboard_main.py" (
    echo ERRO: dashboard_main.py nao encontrado!
    echo.
    pause
    exit /b 1
)

if not exist "venv\Scripts\streamlit.exe" (
    echo ERRO: streamlit.exe nao encontrado!
    echo Execute primeiro o INSTALAR_DASHBOARD.bat
    echo.
    pause
    exit /b 1
)

echo Iniciando Dashboard via Streamlit Desktop...
echo.
echo IMPORTANTE: Mantenha esta janela aberta!
echo O Dashboard abrira automaticamente
echo.

REM Restaurar configuracao normal para garantir que funcione
if exist ".streamlit\config_normal.toml" (
    copy ".streamlit\config_normal.toml" ".streamlit\config.toml" >nul 2>&1
)

REM Executar Streamlit normalmente
"venv\Scripts\streamlit.exe" run dashboard_main.py --server.port 8502

echo.
echo Dashboard finalizado!
pause
