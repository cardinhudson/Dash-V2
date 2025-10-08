@echo off
chcp 65001 >nul
setlocal

set "DST=%~dp0Dashboard_KE5Z_FINAL_DESKTOP"
set "INT=%DST%\_internal"

echo ===============================================
echo   INSTALADOR FORCADO - DASHBOARD KE5Z
echo ===============================================
echo Destino: "%DST%"

rem Procurar executavel em diferentes locais
set "EXE="
if exist "%~dp0dist\Dashboard_KE5Z_Desktop\Dashboard_KE5Z_Desktop.exe" (
  set "EXE=%~dp0dist\Dashboard_KE5Z_Desktop\Dashboard_KE5Z_Desktop.exe"
  set "SRC=%~dp0dist\Dashboard_KE5Z_Desktop"
) else if exist "%~dp0Dashboard_KE5Z_Desktop.exe" (
  set "EXE=%~dp0Dashboard_KE5Z_Desktop.exe"
  set "SRC=%~dp0"
) else if exist "%~dp0..\Dashboard_KE5Z_Desktop.exe" (
  set "EXE=%~dp0..\Dashboard_KE5Z_Desktop.exe"
  set "SRC=%~dp0.."
) else (
  echo.
  echo ERRO: Executavel nao encontrado!
  echo Procurando em:
  echo   - %~dp0dist\Dashboard_KE5Z_Desktop\
  echo   - %~dp0
  echo   - %~dp0..
  echo.
  echo Execute primeiro o build para compilar.
  pause
  exit /b 1
)

echo Executavel encontrado: "%EXE%"

rem ==== FORCAR FECHAMENTO DE PROCESSOS ====
echo.
echo Fechando processos do Dashboard em execucao...
taskkill /f /im "Dashboard_KE5Z_Desktop.exe" >nul 2>&1
taskkill /f /im "python.exe" >nul 2>&1
timeout /t 2 /nobreak >nul

rem ==== LIMPEZA FORCADA ====
if exist "%DST%" (
  echo Limpando instalacao anterior (forcado)...
  
  rem Tentar remover arquivos individualmente primeiro
  for /f "delims=" %%i in ('dir "%DST%" /s /b /a-d 2^>nul') do (
    attrib -r -h -s "%%i" >nul 2>&1
    del /f /q "%%i" >nul 2>&1
  )
  
  rem Tentar remover diretorios
  for /f "delims=" %%i in ('dir "%DST%" /s /b /ad 2^>nul ^| sort /r') do (
    rmdir /s /q "%%i" >nul 2>&1
  )
  
  rem Remocao final forçada
  rmdir /s /q "%DST%" >nul 2>&1
)

rem ==== CRIAR NOVA INSTALACAO ====
mkdir "%DST%" 2>nul
if not exist "%DST%" (
  echo ERRO: Nao foi possivel criar diretorio de destino.
  echo Verifique permissoes de escrita.
  pause
  exit /b 1
)

echo Copiando executavel e dependencias...
if exist "%SRC%\_internal" (
  xcopy "%SRC%\*" "%DST%\" /E /I /Y /Q >nul
) else (
  copy /Y "%EXE%" "%DST%\" >nul
)

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
if exist "%~dp0Extracoes" xcopy "%~dp0Extracoes\*" "%INT%\Extracoes\" /E /I /Y /Q >nul
rem Se houver a pasta com acento no nivel acima, copiar tambem (opcional)
if exist "%~dp0..\Extrações" xcopy "%~dp0..\Extrações\*" "%INT%\Extrações\" /E /I /Y /Q >nul

rem Copiar pasta 'arquivos' (planilhas auxiliares) se existir na 1 - APP
if exist "%~dp0arquivos" xcopy "%~dp0arquivos\*" "%INT%\arquivos\" /E /I /Y /Q >nul

rem ==== VERIFICAR INSTALACAO ====
if not exist "%DST%\Dashboard_KE5Z_Desktop.exe" (
  echo.
  echo ERRO: Instalacao falhou - executavel nao encontrado!
  pause
  exit /b 1
)

echo Criando atalho na area de trabalho...
powershell -NoProfile -Command "$s=New-Object -ComObject WScript.Shell; $d=[Environment]::GetFolderPath('Desktop'); $lnk=$s.CreateShortcut($d + '\\Dashboard KE5Z Desktop.lnk'); $lnk.TargetPath='%DST%\\Dashboard_KE5Z_Desktop.exe'; $lnk.WorkingDirectory='%DST%'; $lnk.Description='Dashboard KE5Z Desktop'; $lnk.Save()" >nul

echo.
echo ===============================================
echo   INSTALACAO CONCLUIDA COM SUCESSO!
echo ===============================================
echo Pasta: "%DST%"
echo Atalho: Desktop\Dashboard KE5Z Desktop.lnk
echo.
echo Para abrir o Dashboard, use o atalho na area de trabalho
echo ou execute: ABRIR_DASHBOARD.bat
echo.
echo IMPORTANTE: Se ainda houver problemas, reinicie o PC
echo e execute este instalador novamente.

pause
