@echo off
chcp 65001 >nul 2>&1
title Dashboard KE5Z
echo ===============================================
echo    DASHBOARD KE5Z - EXECUTANDO VIA STREAMLIT
echo ===============================================
echo.
cd /d "%~dp0"

REM Verificar se o ambiente virtual existe
if exist "venv\Scripts\streamlit.exe" (
    echo Ambiente virtual encontrado!
    echo Iniciando Dashboard via Streamlit...
    echo.
    echo IMPORTANTE: Mantenha esta janela aberta!
    echo O dashboard abrira no seu navegador
    echo.
    "venv\Scripts\streamlit.exe" run dashboard_main.py --server.port 8502 --server.headless true
) else (
    echo Ambiente virtual nao encontrado!
    echo Verificando se existe venv...
    if exist "venv" (
        echo Pasta venv existe mas streamlit.exe nao encontrado
        echo Tentando executar com python...
        if exist "venv\Scripts\python.exe" (
            "venv\Scripts\python.exe" -m streamlit run dashboard_main.py --server.port 8502 --server.headless true
        ) else (
            echo Python nao encontrado no ambiente virtual!
        )
    ) else (
        echo Pasta venv nao existe!
        echo Execute primeiro o INSTALAR_DASHBOARD.bat
    )
)

echo.
pause
