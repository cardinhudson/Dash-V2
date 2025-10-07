@echo off
title Dashboard KE5Z - Streamlit
echo ===============================================
echo    DASHBOARD KE5Z - EXECUTANDO VIA STREAMLIT
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

echo Iniciando Dashboard...
echo IMPORTANTE: Mantenha esta janela aberta!
echo.

"venv\Scripts\streamlit.exe" run dashboard_main.py --server.port 8501

echo.
echo Dashboard finalizado!
pause
