@echo off
title Instalar Dashboard KE5Z
echo ===============================================
echo    INSTALAR DASHBOARD KE5Z
echo ===============================================
echo.
echo Este script vai criar um aplicativo Streamlit Desktop
echo que funciona em QUALQUER PC Windows, mesmo SEM Python instalado!
echo.
echo Baseado na documentacao oficial do Streamlit Desktop App:
echo https://github.com/ohtaman/streamlit-desktop-app
echo.
echo O processo inclui:
echo 1. Instalacao do streamlit-desktop-app
echo 2. Construcao do executavel desktop
echo 3. Organizacao da pasta para distribuicao
echo.
echo IMPORTANTE: Este processo pode levar 10-15 minutos
echo dependendo da velocidade da internet e do PC.
echo.
echo Pressione qualquer tecla para continuar...
pause >nul

cd /d "%~dp0"

echo.
echo ===============================================
echo    PASSO 1: VERIFICANDO PYTHON
echo ===============================================
echo.

REM Verificar se Python esta instalado ou se existe Python portavel
python --version >nul 2>&1
if errorlevel 1 (
    echo ❌ Python nao encontrado no sistema!
    echo.
    echo Verificando se existe Python portavel...
    if exist "python_portavel\python.exe" (
        echo ✅ Python portavel encontrado!
        echo Usando Python portavel existente...
        set PYTHON_CMD=python_portavel\python.exe
    ) else (
        echo ❌ Python portavel tambem nao encontrado!
        echo.
        echo Baixando e instalando Python automaticamente...
        echo.
        
        REM Criar pasta para Python portavel
        if not exist "python_portavel" mkdir "python_portavel"
        
        REM Baixar Python portavel automaticamente
        echo Baixando Python 3.11.7 portavel...
        powershell -Command "& {[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-WebRequest -Uri 'https://www.python.org/ftp/python/3.11.7/python-3.11.7-amd64.exe' -OutFile 'python_portavel\python-3.11.7-amd64.exe'}"
        
        if exist "python_portavel\python-3.11.7-amd64.exe" (
            echo ✅ Python baixado com sucesso!
            echo.
            echo Instalando Python automaticamente...
            "python_portavel\python-3.11.7-amd64.exe" /quiet InstallAllUsers=0 PrependPath=0 Include_test=0
            
            if exist "python_portavel\python.exe" (
                echo ✅ Python instalado com sucesso!
                set PYTHON_CMD=python_portavel\python.exe
            ) else (
                echo ❌ Erro ao instalar Python!
                echo.
                pause
                exit /b 1
            )
        ) else (
            echo ❌ Erro ao baixar Python!
            echo.
            pause
            exit /b 1
        )
    )
) else (
    echo ✅ Python encontrado no sistema!
    python --version
    set PYTHON_CMD=python
)

echo.
echo ===============================================
echo    PASSO 2: CRIANDO AMBIENTE VIRTUAL
echo ===============================================
echo.

echo Criando ambiente virtual Python...
%PYTHON_CMD% -m venv venv
if errorlevel 1 (
    echo ❌ Erro ao criar ambiente virtual!
    echo.
    pause
    exit /b 1
)

echo ✅ Ambiente virtual criado com sucesso!
echo.

echo ===============================================
echo    PASSO 3: INSTALANDO DEPENDENCIAS
echo ===============================================
echo.

echo Ativando ambiente virtual...
call venv\Scripts\activate.bat

echo.
echo Instalando dependencias do Dashboard...
echo (Este processo pode levar alguns minutos...)
echo.

pip install --upgrade pip
pip install -r requirements.txt

if errorlevel 1 (
    echo ❌ Erro ao instalar dependencias!
    echo.
    pause
    exit /b 1
)

echo ✅ Dependencias instaladas com sucesso!
echo.

echo ===============================================
echo    PASSO 4: INSTALANDO STREAMLIT DESKTOP APP
echo ===============================================
echo.

echo Instalando streamlit-desktop-app...
echo (Baseado na documentacao oficial)
echo.

pip install streamlit-desktop-app

if errorlevel 1 (
    echo ❌ Erro ao instalar streamlit-desktop-app!
    echo.
    pause
    exit /b 1
)

echo ✅ streamlit-desktop-app instalado com sucesso!
echo.

echo ===============================================
echo    PASSO 5: CRIANDO EXECUTAVEL DESKTOP
echo ===============================================
echo.

echo Criando executavel desktop...
echo (Este processo pode levar 5-10 minutos...)
echo.

REM Limpar pasta dist se existir
if exist "dist" (
    echo Limpando pasta dist anterior...
    rmdir /s /q "dist"
)

REM Criar executavel desktop usando streamlit-desktop-app
streamlit-desktop-app build dashboard_main.py --name Dashboard_KE5Z

if errorlevel 1 (
    echo ❌ Erro ao criar executavel desktop!
    echo.
    pause
    exit /b 1
)

echo ✅ Executavel desktop criado com sucesso!
echo.

echo ===============================================
echo    PASSO 6: ORGANIZANDO PASTA PARA DISTRIBUICAO
echo ===============================================
echo.

echo Organizando pasta para distribuicao...

REM Verificar se o executavel foi criado
if exist "dist\Dashboard_KE5Z\Dashboard_KE5Z.exe" (
    echo ✅ Executavel desktop encontrado!
    
    REM Mover executavel para a pasta principal
    move "dist\Dashboard_KE5Z\Dashboard_KE5Z.exe" "Dashboard_KE5Z_Desktop.exe"
    
    REM Criar script de execucao principal
    echo @echo off > "EXECUTAR_DASHBOARD_DESKTOP.bat"
    echo title Dashboard KE5Z - Desktop App >> "EXECUTAR_DASHBOARD_DESKTOP.bat"
    echo echo =============================================== >> "EXECUTAR_DASHBOARD_DESKTOP.bat"
    echo echo    DASHBOARD KE5Z - DESKTOP APP >> "EXECUTAR_DASHBOARD_DESKTOP.bat"
    echo echo =============================================== >> "EXECUTAR_DASHBOARD_DESKTOP.bat"
    echo echo. >> "EXECUTAR_DASHBOARD_DESKTOP.bat"
    echo echo Iniciando Dashboard KE5Z Desktop App... >> "EXECUTAR_DASHBOARD_DESKTOP.bat"
    echo echo IMPORTANTE: Mantenha esta janela aberta! >> "EXECUTAR_DASHBOARD_DESKTOP.bat"
    echo echo. >> "EXECUTAR_DASHBOARD_DESKTOP.bat"
    echo cd /d "%%~dp0" >> "EXECUTAR_DASHBOARD_DESKTOP.bat"
    echo "Dashboard_KE5Z_Desktop.exe" >> "EXECUTAR_DASHBOARD_DESKTOP.bat"
    echo echo. >> "EXECUTAR_DASHBOARD_DESKTOP.bat"
    echo echo Dashboard finalizado! >> "EXECUTAR_DASHBOARD_DESKTOP.bat"
    echo pause >> "EXECUTAR_DASHBOARD_DESKTOP.bat"
    
    echo ✅ Scripts de execucao criados!
) else (
    echo ❌ Executavel desktop nao encontrado!
    echo Verificando pasta dist...
    if exist "dist" (
        echo Conteudo da pasta dist:
        dir "dist"
    ) else (
        echo Pasta dist nao existe!
    )
    echo.
    pause
    exit /b 1
)

REM Limpar pasta dist
if exist "dist" (
    rmdir /s /q "dist"
)

echo ✅ Pasta organizada para distribuicao!
echo.

echo ===============================================
echo    PASSO 7: CRIANDO ATALHO NA AREA DE TRABALHO
echo ===============================================
echo.

echo Criando atalho na area de trabalho...
python -c "
import os
import sys
try:
    import winshell
    from win32com.client import Dispatch
    
    desktop = winshell.desktop()
    shortcut_path = os.path.join(desktop, 'Dashboard KE5Z - Desktop App.lnk')
    
    target = os.path.join(os.getcwd(), 'EXECUTAR_DASHBOARD_DESKTOP.bat')
    wDir = os.getcwd()
    
    shell = Dispatch('WScript.Shell')
    shortcut = shell.CreateShortCut(shortcut_path)
    shortcut.Targetpath = target
    shortcut.WorkingDirectory = wDir
    shortcut.IconLocation = target
    shortcut.Description = 'Executar Dashboard KE5Z - Desktop App'
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
echo    STREAMLIT DESKTOP APP CRIADO COM SUCESSO!
echo ===============================================
echo.

echo ✅ Dashboard KE5Z Desktop App criado com sucesso!
echo.
echo 📁 Arquivos criados:
echo    - Dashboard_KE5Z_Desktop.exe (Executavel desktop)
echo    - EXECUTAR_DASHBOARD_DESKTOP.bat (Script de execucao)
echo    - Atalho na area de trabalho (se disponivel)
echo.
echo 🚀 Como usar:
echo    1. Clique duplo em EXECUTAR_DASHBOARD_DESKTOP.bat
echo    2. Ou use o atalho na area de trabalho
echo    3. Ou execute diretamente Dashboard_KE5Z_Desktop.exe
echo.
echo 📦 Para distribuir:
echo    1. Copie a pasta 1 - APP completa
echo    2. Cole no PC de destino
echo    3. Execute qualquer script .bat
echo    4. Funciona em QUALQUER PC Windows (sem Python!)
echo.
echo 🎉 Streamlit Desktop App criado! Pronto para distribuicao!
echo.
echo 📋 Requisitos para o PC de destino:
echo    - Windows 10/11
echo    - .NET Framework (geralmente ja instalado)
echo    - Edge Webview2 (geralmente ja instalado)
echo.
pause
