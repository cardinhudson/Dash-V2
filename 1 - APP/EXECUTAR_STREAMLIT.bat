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

echo Iniciando Dashboard em modo DESKTOP NATIVO...
echo IMPORTANTE: Mantenha esta janela aberta!
echo.
echo NOTA: Esta versao usa o Streamlit em modo desktop
echo (interface nativa, nao navegador)
echo.

REM Copiar configuracao para modo desktop
copy ".streamlit\config_headless.toml" ".streamlit\config.toml" >nul 2>&1

echo ✅ Iniciando interface desktop nativa...
echo.
echo O Dashboard abrira em uma janela desktop separada
echo (nao no navegador)
echo.

"venv\Scripts\streamlit.exe" run dashboard_main.py --server.port 8502 --server.headless true

echo.
echo Dashboard finalizado!
pause
