@echo off
chcp 65001 >nul
echo ===============================================
echo    COMPILADOR COMPLETO DASHBOARD KE5Z
echo ===============================================
echo.

cd /d "%~dp0"

echo 🎯 Escolhendo a melhor opção de compilação...
echo.

echo 📋 OPÇÕES DISPONÍVEIS:
echo.
echo 1. 🥇 STREAMLIT DESKTOP (RECOMENDADO)
echo    ✅ Aplicativo nativo (não no navegador)
echo    ✅ Interface mais limpa
echo    ✅ Melhor performance
echo    ✅ Funciona offline
echo.
echo 2. 🥈 PACOTE DISTRIBUÍVEL
echo    ✅ Fácil de distribuir
echo    ✅ Instalação automática
echo    ✅ Compatível com qualquer PC
echo.
echo 3. 🥉 NUITKA (EXPERIMENTAL)
echo    ✅ Executável nativo
echo    ✅ Melhor performance
echo    ⚠️  Pode ter problemas de compatibilidade
echo.

set /p opcao="Escolha uma opção (1, 2 ou 3): "

if "%opcao%"=="1" (
    echo.
    echo 🚀 Executando Streamlit Desktop...
    call EXECUTAR_STREAMLIT_DESKTOP.bat
) else if "%opcao%"=="2" (
    echo.
    echo 🚀 Criando pacote distribuível...
    call COMPILAR_STREAMLIT_SIMPLES.bat
) else if "%opcao%"=="3" (
    echo.
    echo 🚀 Tentando compilação com Nuitka...
    call compilar_nuitka.bat
) else (
    echo.
    echo ❌ Opção inválida! Usando opção padrão (Streamlit Desktop)...
    call EXECUTAR_STREAMLIT_DESKTOP.bat
)

echo.
echo 🎉 Processo finalizado!
echo.
pause
