@echo off
chcp 65001 >nul 2>&1
title Dashboard KE5Z - Streamlit
echo ===============================================
echo    DASHBOARD KE5Z - EXECUTANDO VIA STREAMLIT
echo ===============================================
echo.

REM Mudar para o diretorio do script
cd /d "%~dp0"
echo Diretorio atual: %CD%
echo.

REM Verificar se dashboard_main.py existe
if not exist "dashboard_main.py" (
    echo ❌ ERRO: dashboard_main.py nao encontrado!
    echo Certifique-se de que este script esta na pasta correta.
    echo.
    pause
    exit /b 1
)

echo ✅ dashboard_main.py encontrado!
echo.

REM Verificar se o ambiente virtual existe
if exist "venv\Scripts\streamlit.exe" (
    echo ✅ streamlit.exe encontrado!
    echo Iniciando Dashboard via Streamlit...
    echo.
    echo IMPORTANTE: Mantenha esta janela aberta!
    echo O dashboard abrira no seu navegador
    echo.
    "venv\Scripts\streamlit.exe" run dashboard_main.py --server.port 8501
    if errorlevel 1 (
        echo.
        echo ❌ ERRO: Falha ao executar Streamlit!
        echo Verifique se todas as dependencias estao instaladas.
        echo.
        pause
        exit /b 1
    )
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
        if errorlevel 1 (
            echo.
            echo ❌ ERRO: Falha ao executar Streamlit via Python!
            echo Verifique se todas as dependencias estao instaladas.
            echo.
            pause
            exit /b 1
        )
    ) else (
        echo ❌ Python nao encontrado no ambiente virtual!
        echo Execute primeiro o INSTALAR_DASHBOARD.bat
        echo.
        pause
        exit /b 1
    )
)

echo.
echo ✅ Dashboard finalizado!
pause
