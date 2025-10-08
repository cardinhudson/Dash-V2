@echo off
chcp 65001 >nul
setlocal

set "DST=%~dp0Dashboard_KE5Z_FINAL_DESKTOP"
if not exist "%DST%\Dashboard_KE5Z_Desktop.exe" (
  echo Pasta nao instalada. Rode INSTALAR_DASHBOARD.bat primeiro.
  pause
  exit /b 1
)

echo Iniciando Dashboard KE5Z Desktop...
start "Dashboard KE5Z" "%DST%\Dashboard_KE5Z_Desktop.exe"
echo Abra a URL exibida na janela do aplicativo.

pause
