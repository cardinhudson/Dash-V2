@echo off
title Instalador Completo - Dashboard KE5Z
echo ===============================================
echo    INSTALADOR COMPLETO - DASHBOARD KE5Z
echo ===============================================
echo.
echo Este instalador criara um executavel que pode ser
echo executado em QUALQUER PC com Windows, mesmo SEM
echo Python instalado!
echo.
echo O processo inclui:
echo 1. Instalacao do ambiente Python
echo 2. Instalacao das dependencias
echo 3. Criacao do executavel standalone
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

REM Verificar se Python esta instalado
python --version >nul 2>&1
if errorlevel 1 (
    echo ❌ Python nao encontrado!
    echo.
    echo Para continuar, voce precisa instalar o Python 3.7 ou superior.
    echo.
    echo Opcoes:
    echo 1. Instalar Python manualmente: https://www.python.org/downloads/
    echo 2. Usar o instalador automatico (recomendado)
    echo.
    echo Deseja abrir o site de download do Python? (S/N)
    set /p choice="Digite sua escolha: "
    if /i "%choice%"=="S" (
        start "" "https://www.python.org/downloads/"
        echo.
        echo Apos instalar o Python, execute este script novamente.
        echo.
        pause
        exit /b 1
    ) else (
        echo.
        echo Instalacao cancelada.
        pause
        exit /b 1
    )
) else (
    echo ✅ Python encontrado!
    python --version
)

echo.
echo ===============================================
echo    PASSO 2: CRIANDO AMBIENTE VIRTUAL
echo ===============================================
echo.

echo Criando ambiente virtual Python...
python -m venv venv
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
echo    PASSO 4: INSTALANDO PYINSTALLER
echo ===============================================
echo.

echo Instalando PyInstaller para criar executavel...
pip install pyinstaller

if errorlevel 1 (
    echo ❌ Erro ao instalar PyInstaller!
    echo.
    pause
    exit /b 1
)

echo ✅ PyInstaller instalado com sucesso!
echo.

echo ===============================================
echo    PASSO 5: CRIANDO EXECUTAVEL STANDALONE
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
pyinstaller --noconfirm --onefile --windowed ^
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
echo    PASSO 6: CRIANDO SCRIPTS DE EXECUCAO
echo ===============================================
echo.

REM Criar script para executar o executavel
echo @echo off > "EXECUTAR_DASHBOARD_FINAL.bat"
echo title Dashboard KE5Z - Executavel Standalone >> "EXECUTAR_DASHBOARD_FINAL.bat"
echo echo =============================================== >> "EXECUTAR_DASHBOARD_FINAL.bat"
echo echo    DASHBOARD KE5Z - EXECUTAVEL STANDALONE >> "EXECUTAR_DASHBOARD_FINAL.bat"
echo echo =============================================== >> "EXECUTAR_DASHBOARD_FINAL.bat"
echo echo. >> "EXECUTAR_DASHBOARD_FINAL.bat"
echo echo Iniciando Dashboard KE5Z... >> "EXECUTAR_DASHBOARD_FINAL.bat"
echo echo IMPORTANTE: Mantenha esta janela aberta! >> "EXECUTAR_DASHBOARD_FINAL.bat"
echo echo. >> "EXECUTAR_DASHBOARD_FINAL.bat"
echo cd /d "%%~dp0" >> "EXECUTAR_DASHBOARD_FINAL.bat"
echo "dist\Dashboard_KE5Z.exe" >> "EXECUTAR_DASHBOARD_FINAL.bat"
echo echo. >> "EXECUTAR_DASHBOARD_FINAL.bat"
echo echo Dashboard finalizado! >> "EXECUTAR_DASHBOARD_FINAL.bat"
echo pause >> "EXECUTAR_DASHBOARD_FINAL.bat"

echo ✅ Script de execucao criado!
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
    shortcut_path = os.path.join(desktop, 'Dashboard KE5Z - Standalone.lnk')
    
    target = os.path.join(os.getcwd(), 'EXECUTAR_DASHBOARD_FINAL.bat')
    wDir = os.getcwd()
    
    shell = Dispatch('WScript.Shell')
    shortcut = shell.CreateShortCut(shortcut_path)
    shortcut.Targetpath = target
    shortcut.WorkingDirectory = wDir
    shortcut.IconLocation = target
    shortcut.Description = 'Executar Dashboard KE5Z - Executavel Standalone'
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
echo    INSTALACAO CONCLUIDA COM SUCESSO!
echo ===============================================
echo.

echo ✅ Dashboard KE5Z instalado e executavel criado!
echo.
echo 📁 Arquivos criados:
echo    - dist\Dashboard_KE5Z.exe (Executavel standalone)
echo    - EXECUTAR_DASHBOARD_FINAL.bat (Script de execucao)
echo    - Atalho na area de trabalho (se disponivel)
echo.
echo 🚀 Como usar:
echo    1. Clique duplo em EXECUTAR_DASHBOARD_FINAL.bat
echo    2. Ou use o atalho na area de trabalho
echo    3. Ou execute diretamente dist\Dashboard_KE5Z.exe
echo.
echo 📦 Para distribuir em outros PCs:
echo    1. Copie a pasta completa do projeto
echo    2. Cole no PC de destino
echo    3. Execute EXECUTAR_DASHBOARD_FINAL.bat
echo    4. Funciona em QUALQUER PC Windows (sem Python!)
echo.
echo 🎉 Instalacao concluida! O Dashboard esta pronto para uso!
echo.
pause
