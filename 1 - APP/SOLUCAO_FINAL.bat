@echo off
chcp 65001 >nul 2>&1
cd /d "%~dp0"

echo ===============================================
echo    DASHBOARD KE5Z - SOLUCAO COMPLETA
echo ===============================================
echo.

echo 1. Instalando arquivos necessarios...
call "INSTALAR_ARQUIVOS.bat"

echo.
echo 2. Executando Dashboard...
if exist "dist\Dashboard_KE5Z\Dashboard_KE5Z.exe" (
    echo ✅ Executável encontrado!
    echo 🚀 Iniciando Dashboard Desktop...
    echo.
    "dist\Dashboard_KE5Z\Dashboard_KE5Z.exe"
) else (
    echo ❌ Executável não encontrado!
    echo 📁 Verificando pasta dist...
    if exist "dist" (
        echo 📄 Arquivos na pasta dist:
        dir /b "dist"
    ) else (
        echo ❌ Pasta dist não existe!
    )
)

echo.
pause

