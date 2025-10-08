@echo off
title Criar Pasta 1 - APP Autofuncional V2
echo ===============================================
echo    CRIAR PASTA 1 - APP AUTOFUNCIONAL V2
echo ===============================================
echo.
echo Este script vai criar uma pasta 1 - APP que funciona
echo em QUALQUER PC Windows, mesmo SEM Python instalado!
echo.
echo O processo inclui:
echo 1. Download do Python portavel completo
echo 2. Instalacao das dependencias
echo 3. Criacao do executavel standalone
echo 4. Organizacao da pasta para distribuicao
echo.
echo IMPORTANTE: Este processo pode levar 15-20 minutos
echo dependendo da velocidade da internet e do PC.
echo.
echo Pressione qualquer tecla para continuar...
pause >nul

cd /d "%~dp0"

echo.
echo ===============================================
echo    PASSO 1: VERIFICANDO PYTHON PORTATEL
echo ===============================================
echo.

REM Verificar se Python portavel ja existe
if exist "python_portavel\python.exe" (
    echo ✅ Python portavel ja encontrado!
    goto :instalar_dependencias
)

echo Baixando Python portavel completo...
echo (Este processo pode levar alguns minutos...)
echo.

REM Criar pasta para Python portavel
if not exist "python_portavel" mkdir "python_portavel"

REM Baixar Python portavel completo (com pip)
echo Baixando Python 3.11.7 portavel completo...
powershell -Command "& {[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-WebRequest -Uri 'https://www.python.org/ftp/python/3.11.7/python-3.11.7-amd64.exe' -OutFile 'python_portavel\python-3.11.7-amd64.exe'}"

if not exist "python_portavel\python-3.11.7-amd64.exe" (
    echo ❌ Erro ao baixar Python portavel!
    echo.
    echo Tentando metodo alternativo...
    echo.
    echo Por favor, baixe manualmente o Python portavel:
    echo https://www.python.org/ftp/python/3.11.7/python-3.11.7-amd64.exe
    echo.
    echo E coloque o arquivo na pasta python_portavel\
    echo.
    pause
    exit /b 1
)

echo ✅ Python portavel baixado com sucesso!
echo.

echo Instalando Python portavel...
"python_portavel\python-3.11.7-amd64.exe" /quiet InstallAllUsers=0 PrependPath=0 Include_test=0

if not exist "python_portavel\python.exe" (
    echo ❌ Erro ao instalar Python portavel!
    echo.
    pause
    exit /b 1
)

echo ✅ Python portavel instalado com sucesso!
echo.

echo ===============================================
echo    PASSO 2: INSTALANDO DEPENDENCIAS
echo ===============================================
echo.

:instalar_dependencias
echo Instalando dependencias do Dashboard...
echo (Este processo pode levar alguns minutos...)
echo.

REM Instalar dependencias
"python_portavel\python.exe" -m pip install --upgrade pip
"python_portavel\python.exe" -m pip install -r requirements.txt

if errorlevel 1 (
    echo ❌ Erro ao instalar dependencias!
    echo.
    pause
    exit /b 1
)

echo ✅ Dependencias instaladas com sucesso!
echo.

echo ===============================================
echo    PASSO 3: INSTALANDO PYINSTALLER
echo ===============================================
echo.

echo Instalando PyInstaller para criar executavel...
"python_portavel\python.exe" -m pip install pyinstaller

if errorlevel 1 (
    echo ❌ Erro ao instalar PyInstaller!
    echo.
    pause
    exit /b 1
)

echo ✅ PyInstaller instalado com sucesso!
echo.

echo ===============================================
echo    PASSO 4: CRIANDO EXECUTAVEL STANDALONE
echo ===============================================
echo.

echo Criando executavel standalone...
echo (Este processo pode levar 5-10 minutos...)
echo.

REM Limpar pasta dist se existir
if exist "dist" (
    echo Limpando pasta dist anterior...
    rmdir /s /q "dist"
)

REM Criar executavel
"python_portavel\python.exe" -m PyInstaller --noconfirm --onefile --windowed ^
    --name "Dashboard_KE5Z" ^
    --add-data "pages;pages" ^
    --add-data "arquivos;arquivos" ^
    --add-data "dados_equipe.json;." ^
    --add-data "usuarios_padrao.json;." ^
    --add-data ".streamlit;.streamlit" ^
    --hidden-import streamlit ^
    --hidden-import pandas ^
    --hidden-import plotly ^
    --hidden-import openpyxl ^
    --hidden-import streamlit.web.cli ^
    --hidden-import streamlit.runtime.scriptrunner ^
    dashboard_main.py

if errorlevel 1 (
    echo ❌ Erro ao criar executavel!
    echo.
    pause
    exit /b 1
)

echo ✅ Executavel criado com sucesso!
echo.

echo ===============================================
echo    PASSO 5: ORGANIZANDO PASTA AUTOFUNCIONAL
echo ===============================================
echo.

echo Organizando pasta para ser autofuncional...

REM Mover executavel para a pasta principal
if exist "dist\Dashboard_KE5Z.exe" (
    move "dist\Dashboard_KE5Z.exe" "Dashboard_KE5Z.exe"
)

REM Limpar pasta dist
if exist "dist" (
    rmdir /s /q "dist"
)

REM Atualizar scripts de execucao para usar o executavel
echo @echo off > "EXECUTAR_DASHBOARD.bat"
echo title Dashboard KE5Z - Executavel Standalone >> "EXECUTAR_DASHBOARD.bat"
echo echo =============================================== >> "EXECUTAR_DASHBOARD.bat"
echo echo    DASHBOARD KE5Z - EXECUTAVEL STANDALONE >> "EXECUTAR_DASHBOARD.bat"
echo echo =============================================== >> "EXECUTAR_DASHBOARD.bat"
echo echo. >> "EXECUTAR_DASHBOARD.bat"
echo echo Iniciando Dashboard KE5Z... >> "EXECUTAR_DASHBOARD.bat"
echo echo IMPORTANTE: Mantenha esta janela aberta! >> "EXECUTAR_DASHBOARD.bat"
echo echo. >> "EXECUTAR_DASHBOARD.bat"
echo cd /d "%%~dp0" >> "EXECUTAR_DASHBOARD.bat"
echo "Dashboard_KE5Z.exe" >> "EXECUTAR_DASHBOARD.bat"
echo echo. >> "EXECUTAR_DASHBOARD.bat"
echo echo Dashboard finalizado! >> "EXECUTAR_DASHBOARD.bat"
echo pause >> "EXECUTAR_DASHBOARD.bat"

echo @echo off > "EXECUTAR_STREAMLIT.bat"
echo title Dashboard KE5Z - Streamlit Desktop >> "EXECUTAR_STREAMLIT.bat"
echo echo =============================================== >> "EXECUTAR_STREAMLIT.bat"
echo echo    DASHBOARD KE5Z - STREAMLIT DESKTOP >> "EXECUTAR_STREAMLIT.bat"
echo echo =============================================== >> "EXECUTAR_STREAMLIT.bat"
echo echo. >> "EXECUTAR_STREAMLIT.bat"
echo echo Iniciando Dashboard via Streamlit Desktop... >> "EXECUTAR_STREAMLIT.bat"
echo echo IMPORTANTE: Mantenha esta janela aberta! >> "EXECUTAR_STREAMLIT.bat"
echo echo. >> "EXECUTAR_STREAMLIT.bat"
echo cd /d "%%~dp0" >> "EXECUTAR_STREAMLIT.bat"
echo "Dashboard_KE5Z.exe" >> "EXECUTAR_STREAMLIT.bat"
echo echo. >> "EXECUTAR_STREAMLIT.bat"
echo echo Dashboard finalizado! >> "EXECUTAR_STREAMLIT.bat"
echo pause >> "EXECUTAR_STREAMLIT.bat"

echo ✅ Pasta organizada para ser autofuncional!
echo.

echo ===============================================
echo    PASSO 6: CRIANDO ATALHO NA AREA DE TRABALHO
echo ===============================================
echo.

echo Criando atalho na area de trabalho...
"python_portavel\python.exe" -c "
import os
import sys
try:
    import winshell
    from win32com.client import Dispatch
    
    desktop = winshell.desktop()
    shortcut_path = os.path.join(desktop, 'Dashboard KE5Z - Autofuncional.lnk')
    
    target = os.path.join(os.getcwd(), 'EXECUTAR_DASHBOARD.bat')
    wDir = os.getcwd()
    
    shell = Dispatch('WScript.Shell')
    shortcut = shell.CreateShortCut(shortcut_path)
    shortcut.Targetpath = target
    shortcut.WorkingDirectory = wDir
    shortcut.IconLocation = target
    shortcut.Description = 'Executar Dashboard KE5Z - Pasta Autofuncional'
    shortcut.save()
    
    print('✅ Atalho criado na area de trabalho!')
except ImportError:
    print('⚠️ Aviso: Dependencias para criar atalho nao disponiveis')
    print('   O Dashboard funcionara normalmente, apenas sem atalho')
except Exception as e:
    print(f'⚠️ Aviso: Nao foi possivel criar atalho: {e}')
    print('   O Dashboard funcionara normalmente, apenas sem atalho')
"

echo.
echo ===============================================
echo    PASTA AUTOFUNCIONAL CRIADA COM SUCESSO!
echo ===============================================
echo.

echo ✅ Pasta 1 - APP agora e autofuncional!
echo.
echo 📁 Arquivos criados:
echo    - Dashboard_KE5Z.exe (Executavel standalone)
echo    - EXECUTAR_DASHBOARD.bat (Script principal)
echo    - EXECUTAR_STREAMLIT.bat (Script alternativo)
echo    - python_portavel\ (Python portavel incluido)
echo    - Atalho na area de trabalho (se disponivel)
echo.
echo 🚀 Como usar:
echo    1. Clique duplo em EXECUTAR_DASHBOARD.bat
echo    2. Ou use o atalho na area de trabalho
echo    3. Ou execute diretamente Dashboard_KE5Z.exe
echo.
echo 📦 Para distribuir:
echo    1. Copie a pasta 1 - APP completa
echo    2. Cole no PC de destino
echo    3. Execute qualquer script .bat
echo    4. Funciona em QUALQUER PC Windows (sem Python!)
echo.
echo 🎉 Pasta autofuncional criada! Pronta para distribuicao!
echo.
pause
