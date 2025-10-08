@echo off
title Dashboard KE5Z
echo ===============================================
echo    DASHBOARD KE5Z
echo ===============================================
echo.

cd /d "%~dp0"

echo Verificando se o Dashboard foi instalado...
if exist "Dashboard_KE5Z.exe" (
    echo ✅ Dashboard encontrado!
    echo.
    echo Iniciando Dashboard KE5Z...
    echo IMPORTANTE: Mantenha esta janela aberta!
    echo.
    "Dashboard_KE5Z.exe"
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

echo.
echo Dashboard finalizado!
pause
