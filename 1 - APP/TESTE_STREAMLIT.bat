@echo off
chcp 65001 >nul 2>&1
title Teste Streamlit
echo ===============================================
echo    TESTE STREAMLIT
echo ===============================================
echo.
cd /d "%~dp0"

echo Verificando ambiente virtual...
if exist "venv\Scripts\streamlit.exe" (
    echo ✅ streamlit.exe encontrado!
    echo Executando teste...
    "venv\Scripts\streamlit.exe" --version
) else (
    echo ❌ streamlit.exe nao encontrado!
)

if exist "venv\Scripts\python.exe" (
    echo ✅ python.exe encontrado!
    echo Executando teste...
    "venv\Scripts\python.exe" --version
) else (
    echo ❌ python.exe nao encontrado!
)

echo.
echo Teste concluido!
pause
