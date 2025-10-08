@echo off
setlocal

echo ===============================================
echo   ABRINDO DASHBOARD KE5Z DESKTOP
echo ===============================================

set "EXE=%~dp0Dashboard_KE5Z_FINAL_DESKTOP\Dashboard_KE5Z_Desktop.exe"

if not exist "%EXE%" (
    echo.
    echo ERRO: Dashboard nao encontrado!
    echo.
    echo Execute primeiro: INSTALAR_DASHBOARD.bat
    echo.
    pause
    exit /b 1
)

echo Abrindo Dashboard KE5Z Desktop...
echo.

echo Iniciando Dashboard como aplicativo desktop nativo...
echo.

start "" "%EXE%"

echo Dashboard iniciado com sucesso!
echo.
echo O aplicativo deve abrir como uma janela desktop nativa.
echo Se nao abrir, verifique se nao ha outros processos em execucao.
echo.
echo Para acessar via navegador (se necessario): http://localhost:8501
echo.