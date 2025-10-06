@echo off
chcp 65001 >nul
echo ===============================================
echo    COMPILADOR FINAL DASHBOARD KE5Z
echo ===============================================
echo.

cd /d "%~dp0"

echo 🎯 Testando opções de compilação...
echo.

REM Testar Nuitka primeiro
echo 🔧 Testando Nuitka...
call testar_nuitka.bat >nul 2>&1

if %errorlevel% equ 0 (
    echo ✅ Nuitka funcionando! Usando Nuitka...
    echo.
    call compilar_nuitka.bat
) else (
    echo ⚠️  Nuitka falhou. Usando Streamlit Desktop...
    echo.
    call COMPILAR_STREAMLIT_DESKTOP.bat
)

echo.
echo 🎉 Processo finalizado!
echo.
pause
