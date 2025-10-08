@echo off
chcp 65001 >nul
setlocal

set "DST=%~dp0Dashboard_KE5Z_FINAL_DESKTOP"
set "INT=%DST%\_internal"

echo ===============================================
echo   TESTE DE INSTALACAO - DASHBOARD KE5Z
echo ===============================================
echo Destino: "%DST%"

rem Procurar executavel
if exist "%~dp0dist\Dashboard_KE5Z_Desktop\Dashboard_KE5Z_Desktop.exe" (
  set "EXE=%~dp0dist\Dashboard_KE5Z_Desktop\Dashboard_KE5Z_Desktop.exe"
  set "SRC=%~dp0dist\Dashboard_KE5Z_Desktop"
  echo Executavel encontrado: "%EXE%"
) else (
  echo ERRO: Executavel nao encontrado!
  pause
  exit /b 1
)

rem Limpar instalacao anterior
if exist "%DST%" (
  echo Limpando instalacao anterior...
  rmdir /s /q "%DST%"
)

rem Criar nova instalacao
mkdir "%DST%"
echo Copiando executavel e dependencias...
xcopy "%SRC%\*" "%DST%\" /E /I /Y /Q >nul

rem Copiar arquivos necessarios para _internal
if not exist "%INT%" mkdir "%INT%"

echo Copiando arquivos necessarios...
copy /Y "%~dp0Dados SAPIENS.xlsx" "%INT%\" >nul
copy /Y "%~dp0Fornecedores.xlsx" "%INT%\" >nul
copy /Y "%~dp0Extracao.py" "%INT%\" >nul
copy /Y "%~dp0usuarios.json" "%INT%\" >nul
copy /Y "%~dp0usuarios_padrao.json" "%INT%\" >nul

rem Copiar pasta Extracoes
if exist "%~dp0Extracoes" (
  echo Copiando pasta Extracoes...
  xcopy "%~dp0Extracoes\*" "%INT%\Extracoes\" /E /I /Y /Q >nul
)

echo.
echo ===============================================
echo   INSTALACAO CONCLUIDA COM SUCESSO!
echo ===============================================
echo Pasta: "%DST%"
echo.
echo Para testar, execute: "%DST%\Dashboard_KE5Z_Desktop.exe"

pause


