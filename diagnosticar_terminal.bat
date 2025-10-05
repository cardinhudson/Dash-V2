@echo off
chcp 65001 >nul
cls
echo ========================================
echo    DIAGNOSTICO DO TERMINAL
echo ========================================
echo.
echo Identificando problemas com o terminal...
echo.

echo 1. Testando Python...
python --version
if %errorlevel% neq 0 (
    echo ❌ ERRO: Python não encontrado
) else (
    echo ✅ Python funcionando
)
echo.

echo 2. Testando Pip...
pip --version
if %errorlevel% neq 0 (
    echo ❌ ERRO: Pip não encontrado
) else (
    echo ✅ Pip funcionando
)
echo.

echo 3. Testando Conexão...
ping -n 1 google.com >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ ERRO: Sem conexão com internet
) else (
    echo ✅ Conexão funcionando
)
echo.

echo 4. Testando Permissões...
echo test > test_permissao.txt
if %errorlevel% neq 0 (
    echo ❌ ERRO: Sem permissão de escrita
) else (
    echo ✅ Permissões OK
    del test_permissao.txt
)
echo.

echo 5. Testando Encoding...
echo Testando caracteres especiais: ção
echo.

echo 6. Testando Comando Longo...
echo Executando comando que pode travar...
timeout /t 2 >nul
echo ✅ Comando longo funcionou
echo.

echo ========================================
echo         DIAGNOSTICO CONCLUIDO
echo ========================================
echo.
echo Se algum teste falhou, use os arquivos .bat
echo em vez do terminal integrado.
echo.
pause







