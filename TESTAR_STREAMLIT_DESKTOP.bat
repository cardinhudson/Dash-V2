@echo off
chcp 65001 >nul
echo ===============================================
echo    TESTANDO STREAMLIT DESKTOP
echo ===============================================
echo.

echo 🔍 Verificando se a pasta "1 - APP" existe...
if not exist "1 - APP" (
    echo ❌ Pasta "1 - APP" não encontrada!
    echo Certifique-se de que a pasta foi criada corretamente.
    pause
    exit /b 1
)
echo ✅ Pasta "1 - APP" encontrada!

echo.
echo 🔍 Verificando arquivos necessários...
if not exist "1 - APP\EXECUTAR_DASHBOARD.bat" (
    echo ❌ Arquivo EXECUTAR_DASHBOARD.bat não encontrado!
    pause
    exit /b 1
)
echo ✅ Arquivo EXECUTAR_DASHBOARD.bat encontrado!

if not exist "1 - APP\dashboard_main.py" (
    echo ❌ Arquivo dashboard_main.py não encontrado!
    pause
    exit /b 1
)
echo ✅ Arquivo dashboard_main.py encontrado!

if not exist "1 - APP\KE5Z" (
    echo ❌ Pasta KE5Z não encontrada!
    pause
    exit /b 1
)
echo ✅ Pasta KE5Z encontrada!

echo.
echo 🚀 Navegando para a pasta "1 - APP"...
cd "1 - APP"

echo.
echo 📋 Arquivos na pasta atual:
dir /b

echo.
echo 🎯 EXECUTANDO DASHBOARD...
echo.
echo ⚠️  IMPORTANTE: 
echo    - O dashboard abrirá em uma janela de desktop
echo    - Mantenha esta janela aberta enquanto usar
echo    - Se der erro, verifique se Python está instalado
echo.

EXECUTAR_DASHBOARD.bat

echo.
echo Dashboard finalizado!
pause





