@echo off
title DESINSTALADOR DASHBOARD KE5Z
color 0C

echo.
echo ============================================================
echo                DESINSTALADOR DASHBOARD KE5Z
echo ============================================================
echo.
echo Este desinstalador ira remover completamente o Dashboard
echo KE5Z do seu sistema.
echo.
echo ATENCAO: Esta acao nao pode ser desfeita!
echo.
echo ============================================================
echo.

pause

echo.
echo Iniciando desinstalacao...
echo.

REM Verificar se Python está instalado
python --version >nul 2>&1
if errorlevel 1 (
    echo.
    echo ERRO: Python nao encontrado!
    echo.
    echo Para desinstalar manualmente:
    echo 1. Delete a pasta 'venv'
    echo 2. Delete os arquivos .bat de execucao
    echo 3. Delete o atalho da area de trabalho
    echo.
    pause
    exit /b 1
)

echo Python encontrado! Iniciando desinstalador...
echo.

REM Executar o desinstalador Python
python DESINSTALAR_DASHBOARD.py

echo.
echo Desinstalacao finalizada!
echo.
pause
