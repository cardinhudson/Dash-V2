@echo off
chcp 65001 >nul 2>&1
title Dashboard KE5Z - Streamlit
echo ===============================================
echo    DASHBOARD KE5Z - EXECUTANDO VIA STREAMLIT
echo ===============================================
echo.
cd /d "C:\Dash-V2\1 - APP"

REM Verificar se o ambiente virtual existe
if exist "venv\Scripts\python.exe" (
    echo Ambiente virtual encontrado!
    echo Iniciando Dashboard via Streamlit (Python module)...
    echo.
    echo IMPORTANTE: Mantenha esta janela aberta!
    echo O dashboard abrira no seu navegador
    echo.
    "venv\Scripts\python.exe" -m streamlit run dashboard_main.py --server.port 8501 --server.headless true
) else (
    echo Ambiente virtual nao encontrado!
    echo Execute primeiro o INSTALAR_DASHBOARD.bat
)

echo.
pause
