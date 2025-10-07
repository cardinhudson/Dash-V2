@echo off
title INSTALADOR DASHBOARD KE5Z
color 0A

echo.
echo ============================================================
echo                INSTALADOR DASHBOARD KE5Z
echo ============================================================
echo.
echo Este instalador ira configurar automaticamente o Dashboard
echo para voce. Apenas clique em qualquer tecla para continuar.
echo.
echo IMPORTANTE: Certifique-se de que o Python esta instalado
echo em seu computador antes de continuar.
echo.
echo ============================================================
echo.

pause

echo.
echo Iniciando instalacao...
echo.

REM Verificar se Python está instalado
python --version >nul 2>&1
if errorlevel 1 (
    echo.
    echo ERRO: Python nao encontrado!
    echo.
    echo Por favor, instale o Python 3.8 ou superior de:
    echo https://www.python.org/downloads/
    echo.
    echo Certifique-se de marcar "Add Python to PATH" durante a instalacao.
    echo.
    pause
    exit /b 1
)

echo Python encontrado! Iniciando instalador...
echo.

REM Executar o instalador Python
python INSTALADOR_DASHBOARD.py

echo.
echo Instalacao finalizada!
echo.
pause
