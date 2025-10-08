@echo off
setlocal

echo ===============================================
echo   LIMPEZA COMPLETA - DASHBOARD KE5Z
echo ===============================================
echo Este script remove todos os arquivos de build e instalacao
echo.

set "DST=%~dp0Dashboard_KE5Z_FINAL_DESKTOP"
set "DESKTOP_SHORTCUT=%USERPROFILE%\Desktop\Dashboard KE5Z Desktop.lnk"

echo [1/5] Fechando processos do Dashboard...
taskkill /IM Dashboard_KE5Z_Desktop.exe /F >nul 2>&1
taskkill /IM python.exe /F >nul 2>&1
timeout /t 3 /nobreak >nul

echo [2/5] Removendo atalho da area de trabalho...
if exist "%DESKTOP_SHORTCUT%" del "%DESKTOP_SHORTCUT%" >nul 2>&1

echo [3/5] Limpando pasta de instalacao...
if exist "%DST%" (
  rem Tenta remover atributos de somente leitura antes de deletar
  attrib -R /S /D "%DST%\*" >nul 2>&1
  rmdir /s /q "%DST%"
)

echo [4/5] Limpando arquivos de build...
if exist "build" rmdir /s /q "build"
if exist "dist" rmdir /s /q "dist"

echo [5/5] Limpando arquivos temporarios...
if exist "*.pyc" del /q "*.pyc"
if exist "__pycache__" rmdir /s /q "__pycache__"
if exist "*.log" del /q "*.log"
if exist "*.tmp" del /q "*.tmp"

echo.
echo ===============================================
echo   LIMPEZA CONCLUIDA COM SUCESSO!
echo ===============================================
echo.
echo Todos os arquivos de build e instalacao foram removidos:
echo - Pasta de instalacao: %DST%
echo - Arquivos de build: build/, dist/
echo - Atalho da area de trabalho
echo - Arquivos temporarios
echo.
echo Agora voce pode executar INSTALAR.bat novamente.
echo.

pause
