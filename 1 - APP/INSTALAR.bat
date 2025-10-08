@echo off
setlocal

echo ===============================================
echo   BUILD E INSTALACAO UNIFICADA - DASHBOARD KE5Z
echo ===============================================
echo Este script compila e instala o Dashboard automaticamente
echo.

set "DST=%~dp0Dashboard_KE5Z_FINAL_DESKTOP"
set "EXE=%~dp0dist\Dashboard_KE5Z_Desktop.exe"

echo [1/4] Verificando dependencias...
python -c "import streamlit_desktop_app" 2>nul
if errorlevel 1 (
    echo Instalando streamlit-desktop-app...
    pip install streamlit-desktop-app
    if errorlevel 1 (
        echo ERRO: Falha ao instalar streamlit-desktop-app
        pause
        exit /b 1
    )
    echo Streamlit Desktop App instalado com sucesso!
) else (
    echo Streamlit Desktop App ja esta instalado!
)

echo.
echo [2/4] Compilando executavel...
echo Limpando build anterior...
if exist "build" rmdir /s /q "build"
if exist "dist" rmdir /s /q "dist"

echo Compilando com PyInstaller...
python -m PyInstaller dashboard_desktop.spec --clean --noconfirm

if not exist "%EXE%" (
    echo.
    echo ERRO: Compilacao falhou!
    echo Verifique os erros acima.
    pause
    exit /b 1
)

echo Compilacao concluida com sucesso!

echo.
echo [3/4] Instalando aplicativo...
echo Fechando processos em execucao...
taskkill /f /im "Dashboard_KE5Z_Desktop.exe" >nul 2>&1

echo Limpando instalacao anterior...
if exist "%DST%" rmdir /s /q "%DST%"

echo Criando nova instalacao...
mkdir "%DST%"

echo Copiando executavel...
copy /Y "%EXE%" "%DST%\"

echo Copiando arquivos necessarios...
if not exist "%DST%\_internal" mkdir "%DST%\_internal"

if exist "%~dp0Extracao.py" copy /Y "%~dp0Extracao.py" "%DST%\_internal\"
if exist "%~dp0usuarios.json" copy /Y "%~dp0usuarios.json" "%DST%\_internal\"
if exist "%~dp0usuarios_padrao.json" copy /Y "%~dp0usuarios_padrao.json" "%DST%\_internal\"
if exist "%~dp0Dados SAPIENS.xlsx" copy /Y "%~dp0Dados SAPIENS.xlsx" "%DST%\_internal\"
if exist "%~dp0Fornecedores.xlsx" copy /Y "%~dp0Fornecedores.xlsx" "%DST%\_internal\"

if exist "%~dp0Extracoes" xcopy "%~dp0Extracoes\*" "%DST%\_internal\Extracoes\" /E /I /Y /Q >nul
if exist "%~dp0arquivos" xcopy "%~dp0arquivos\*" "%DST%\_internal\arquivos\" /E /I /Y /Q >nul

echo.
echo [4/4] Finalizando instalacao...
echo Criando atalho na area de trabalho...
powershell -NoProfile -Command "$s=New-Object -ComObject WScript.Shell; $d=[Environment]::GetFolderPath('Desktop'); $lnk=$s.CreateShortcut($d + '\\Dashboard KE5Z Desktop.lnk'); $lnk.TargetPath='%DST%\\Dashboard_KE5Z_Desktop.exe'; $lnk.WorkingDirectory='%DST%'; $lnk.Description='Dashboard KE5Z Desktop'; $lnk.Save()" >nul

echo.
echo ===============================================
echo   BUILD E INSTALACAO CONCLUIDOS COM SUCESSO!
echo ===============================================
echo.
echo Executavel: %EXE%
echo Instalacao: %DST%
echo Atalho: Desktop\Dashboard KE5Z Desktop.lnk
echo.
echo Dashboard compilado e instalado como aplicativo desktop nativo
echo Funciona sem Python instalado
echo Interface nativa do Windows
echo.
echo Para abrir o Dashboard, use o atalho na area de trabalho
echo ou execute: %DST%\Dashboard_KE5Z_Desktop.exe
echo.

pause
