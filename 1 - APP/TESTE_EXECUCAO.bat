@echo off
chcp 65001 >nul 2>&1
title Teste Execucao Streamlit
echo ===============================================
echo    TESTE EXECUCAO STREAMLIT
echo ===============================================
echo.
cd /d "%~dp0"

echo Testando execucao do Streamlit...
echo.

REM Teste 1: streamlit.exe direto
echo === TESTE 1: streamlit.exe direto ===
if exist "venv\Scripts\streamlit.exe" (
    echo ✅ streamlit.exe encontrado!
    echo Executando: venv\Scripts\streamlit.exe run dashboard_main.py --server.port 8501
    echo.
    echo Pressione Ctrl+C para parar o teste...
    "venv\Scripts\streamlit.exe" run dashboard_main.py --server.port 8501
) else (
    echo ❌ streamlit.exe nao encontrado!
)

echo.
echo Teste concluido!
pause
