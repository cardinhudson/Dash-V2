@echo off
chcp 65001 >nul 2>&1
cd /d "%~dp0"

echo ===============================================
echo    DASHBOARD KE5Z - EXECUTANDO...
echo ===============================================
echo.

if exist "dist\Dashboard_KE5Z\Dashboard_KE5Z.exe" (
    echo Executavel encontrado!
    echo Iniciando Dashboard...
    echo.
    echo IMPORTANTE: Mantenha esta janela aberta!
    echo O dashboard abrira como aplicacao desktop
    echo.
    "dist\Dashboard_KE5Z\Dashboard_KE5Z.exe"
) else (
    echo Executavel nao encontrado!
    echo Verificando pasta dist...
    if exist "dist" (
        echo Arquivos na pasta dist:
        dir /b "dist"
    ) else (
        echo Pasta dist nao existe!
    )
)

echo.
pause
