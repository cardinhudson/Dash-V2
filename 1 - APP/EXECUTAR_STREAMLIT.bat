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
echo NOTA: Esta versao usa o Streamlit Desktop App
echo (interface nativa, nao navegador)
echo.

REM Verificar se streamlit-desktop-app.exe existe
if exist "venv\Scripts\streamlit-desktop-app.exe" (
    echo ✅ Streamlit Desktop App encontrado!
    echo Iniciando interface desktop nativa...
    echo.
    "venv\Scripts\streamlit-desktop-app.exe" run dashboard_main.py --server.port 8502
) else (
    echo ❌ Streamlit Desktop App nao encontrado!
    echo Tentando instalar Streamlit Desktop...
    echo.
    "venv\Scripts\pip.exe" install streamlit-desktop-app
    echo.
    echo Tentando executar novamente...
    if exist "venv\Scripts\streamlit-desktop-app.exe" (
        "venv\Scripts\streamlit-desktop-app.exe" run dashboard_main.py --server.port 8502
    ) else (
        echo ❌ Falha ao instalar Streamlit Desktop App
        echo Executando versao web como fallback...
        echo.
        "venv\Scripts\streamlit.exe" run dashboard_main.py --server.port 8502
    )
)

echo.
echo Dashboard finalizado!
pause
