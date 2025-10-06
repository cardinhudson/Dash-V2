@echo off
chcp 65001 >nul
echo ===============================================
echo    COMPILADOR AUTOMÁTICO DASHBOARD KE5Z
echo ===============================================
echo.

cd /d "%~dp0"

echo 🎯 Escolhendo o melhor compilador para Windows 11...
echo.

REM Testar Nuitka primeiro
echo 🔧 Testando Nuitka...
call testar_nuitka.bat

if %errorlevel% equ 0 (
    echo.
    echo ✅ Nuitka funcionando! Usando Nuitka para compilação...
    echo.
    call compilar_nuitka.bat
) else (
    echo.
    echo ⚠️  Nuitka não funcionou. Usando PyInstaller como alternativa...
    echo.
    call compilar_pyinstaller.bat
)

echo.
echo 🎉 Processo de compilação finalizado!
echo.
pause
