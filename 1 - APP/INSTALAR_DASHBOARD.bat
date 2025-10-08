@echo off
chcp 65001 >nul
setlocal

set "SRC=%~dp0dist\Dashboard_KE5Z_Desktop"
set "DST=%~dp0Dashboard_KE5Z_FINAL_DESKTOP"
set "INT=%DST%\_internal"

echo ===============================================
echo   INSTALADOR - DASHBOARD KE5Z DESKTOP
echo ===============================================
echo Fonte: "%SRC%"
echo Destino: "%DST%"

if not exist "%SRC%\Dashboard_KE5Z_Desktop.exe" (
  echo.
  echo ERRO: Build nao encontrado em "%SRC%".
  echo Execute o processo de build antes de instalar.
  pause
  exit /b 1
)

if exist "%DST%" (
  echo Limpando instalacao anterior...
  rmdir /s /q "%DST%"
)
mkdir "%DST%"

echo Copiando executavel e dependencias...
xcopy "%SRC%\*" "%DST%\" /E /I /Y >nul

rem ==== Copiar arquivos/diretorios requeridos para dentro de _internal ====
if not exist "%INT%" mkdir "%INT%"

echo Copiando arquivos requeridos para _internal...
rem Tenta copiar a partir da pasta 1 - APP
for %%F in ("%~dp0Extracao.py","%~dp0usuarios.json","%~dp0usuarios_padrao.json") do (
  if exist %%~F copy /Y %%~F "%INT%\" >nul
)

rem Copiar arquivos Excel obrigatorios de 1 - APP ou do diretorio pai, se necessario
for %%N in ("Dados SAPIENS.xlsx" "Fornecedores.xlsx") do (
  if exist "%~dp0%%~N" copy /Y "%~dp0%%~N" "%INT%\" >nul
  if not exist "%INT%\%%~N" if exist "%~dp0..\%%~N" copy /Y "%~dp0..\%%~N" "%INT%\" >nul
)

rem Pastas de dados (preferir 'Extracoes' local da pasta 1 - APP)
if exist "%~dp0Extracoes" xcopy "%~dp0Extracoes\*" "%INT%\Extracoes\" /E /I /Y >nul
rem Se houver a pasta com acento no nivel acima, copiar tambem (opcional)
if exist "%~dp0..\Extrações" xcopy "%~dp0..\Extrações\*" "%INT%\Extrações\" /E /I /Y >nul

rem Copiar pasta 'arquivos' (planilhas auxiliares) se existir na 1 - APP
if exist "%~dp0arquivos" xcopy "%~dp0arquivos\*" "%INT%\arquivos\" /E /I /Y >nul

echo Criando atalho na area de trabalho...
powershell -NoProfile -Command "$s=New-Object -ComObject WScript.Shell; $d=[Environment]::GetFolderPath('Desktop'); $lnk=$s.CreateShortcut($d + '\\Dashboard KE5Z Desktop.lnk'); $lnk.TargetPath='%DST%\\Dashboard_KE5Z_Desktop.exe'; $lnk.WorkingDirectory='%DST%'; $lnk.Description='Dashboard KE5Z Desktop'; $lnk.Save()" >nul

echo.
echo Instalacao concluida com sucesso!
echo Pasta: "%DST%"
echo Atalho: Desktop\Dashboard KE5Z Desktop.lnk

pause
