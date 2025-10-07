@echo off
title Dashboard KE5Z - Streamlit (Interface Nativa)
echo ===============================================
echo    DASHBOARD KE5Z - INTERFACE NATIVA STREAMLIT
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

echo Iniciando Dashboard em modo NATIVO...
echo IMPORTANTE: Mantenha esta janela aberta!
echo.
echo NOTA: Esta versao usa a interface nativa do Streamlit
echo (nao abre automaticamente no navegador)
echo.

"venv\Scripts\streamlit.exe" run dashboard_main.py --server.port 8501 --server.headless true

echo.
echo Dashboard finalizado!
pause
