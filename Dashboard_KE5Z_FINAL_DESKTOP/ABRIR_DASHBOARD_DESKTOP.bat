@echo off
chcp 65001 > nul

echo ============================================================
echo 🎯 DASHBOARD KE5Z - DESKTOP APP
echo ============================================================
echo 🚀 Iniciando o Dashboard KE5Z Desktop...
echo.

REM Verificar se o executável existe
if not exist "Dashboard_KE5Z_Desktop.exe" (
    echo ❌ Erro: Executável não encontrado!
    echo Certifique-se de que o arquivo Dashboard_KE5Z_Desktop.exe está nesta pasta.
    pause
    exit /b 1
)

echo ✅ Executável encontrado!
echo 🚀 Iniciando o dashboard...
echo ⏳ Aguarde... O dashboard pode levar de 1 a 2 minutos para carregar.
echo 🌐 O navegador será aberto automaticamente quando estiver pronto.
echo.

REM Executar o dashboard em segundo plano
start "" Dashboard_KE5Z_Desktop.exe

echo ✅ Dashboard iniciado em segundo plano!
echo 🌐 Aguardando o dashboard carregar...

REM Aguardar 30 segundos para o dashboard inicializar
timeout /t 30 /nobreak >nul

REM Abrir o navegador automaticamente
echo 🚀 Abrindo o navegador...
start "" "http://localhost:8501"

echo.
echo ✅ Dashboard iniciado com sucesso!
echo 🌐 Acesse: http://localhost:8501
echo.
echo 💡 Dicas:
echo - O navegador foi aberto automaticamente
echo - Para parar o dashboard, feche esta janela ou pressione Ctrl+C
echo - O dashboard continuará rodando em segundo plano
echo - Se o navegador não abriu, acesse manualmente: http://localhost:8501
echo.
pause