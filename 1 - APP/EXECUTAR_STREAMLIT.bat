@echo off
chcp 65001 >nul 2>&1
title Dashboard KE5Z - Streamlit
echo ===============================================
echo    DASHBOARD KE5Z - EXECUTANDO VIA STREAMLIT
echo ===============================================
echo.
cd /d "%~dp0"

echo Verificando ambiente virtual...
if exist "venv\Scripts\streamlit.exe" (
    echo ✅ streamlit.exe encontrado!
    echo Iniciando Dashboard via Streamlit...
    echo.
    echo IMPORTANTE: Mantenha esta janela aberta!
    echo O dashboard abrira no seu navegador
    echo.
    "venv\Scripts\streamlit.exe" run dashboard_main.py --server.port 8501
) else (
    echo ❌ streamlit.exe nao encontrado!
    echo Verificando se existe python...
    if exist "venv\Scripts\python.exe" (
        echo ✅ python.exe encontrado!
        echo Iniciando Dashboard via Streamlit (Python module)...
        echo.
        echo IMPORTANTE: Mantenha esta janela aberta!
        echo O dashboard abrira no seu navegador
        echo.
        "venv\Scripts\python.exe" -m streamlit run dashboard_main.py --server.port 8501
    ) else (
        echo ❌ Python nao encontrado no ambiente virtual!
        echo Execute primeiro o INSTALAR_DASHBOARD.bat
    )
)

echo.
pause
