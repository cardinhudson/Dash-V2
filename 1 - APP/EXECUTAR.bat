@echo off
title Dashboard KE5Z
echo ===============================================
echo    DASHBOARD KE5Z
echo ===============================================
echo.

cd /d "%~dp0"

echo Verificando se o Dashboard foi instalado...
if exist "Dashboard_KE5Z_Desktop.exe" (
    echo ✅ Dashboard executavel desktop encontrado!
    echo.
    echo Iniciando Dashboard KE5Z Desktop...
    echo IMPORTANTE: Mantenha esta janela aberta!
    echo.
    "Dashboard_KE5Z_Desktop.exe"
) else (
    echo ❌ Dashboard executavel nao encontrado!
    echo.
    echo Verificando se existe ambiente virtual...
    if exist "venv\Scripts\streamlit.exe" (
        echo ✅ Ambiente virtual encontrado!
        echo.
        echo Iniciando Dashboard via Streamlit...
        echo IMPORTANTE: Mantenha esta janela aberta!
        echo.
        "venv\Scripts\streamlit.exe" run dashboard_main.py
    ) else (
        echo ❌ Dashboard nao foi instalado ainda!
        echo.
        echo Para instalar o Dashboard, execute:
        echo INSTALAR.bat
        echo.
        echo Apos a instalacao, execute este script novamente.
        echo.
        pause
        exit /b 1
    )
)

echo.
echo Dashboard finalizado!
pause
