@echo off
title Embalar Pasta Completa - Dashboard KE5Z
echo ===============================================
echo    EMBALAR PASTA COMPLETA - DASHBOARD KE5Z
echo ===============================================
echo.
echo Este script vai empacotar TUDO na pasta 1 - APP
echo para que ela seja completamente portavel e funcione
echo em QUALQUER PC Windows, mesmo SEM Python instalado!
echo.
echo O processo inclui:
echo 1. Instalacao do ambiente Python
echo 2. Instalacao das dependencias
echo 3. Criacao do executavel standalone
echo 4. Organizacao da pasta para distribuicao
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
echo    PASSO 6: ORGANIZANDO PASTA PARA DISTRIBUICAO
echo ===============================================
echo.

echo Organizando pasta para distribuicao...

REM Criar pasta de distribuicao
if exist "DISTRIBUICAO" (
    echo Limpando pasta de distribuicao anterior...
    rmdir /s /q "DISTRIBUICAO"
)

mkdir "DISTRIBUICAO"

REM Copiar executavel para pasta de distribuicao
copy "dist\Dashboard_KE5Z.exe" "DISTRIBUICAO\Dashboard_KE5Z.exe"

REM Criar script de execucao principal
echo @echo off > "DISTRIBUICAO\EXECUTAR_DASHBOARD.bat"
echo title Dashboard KE5Z - Executavel Standalone >> "DISTRIBUICAO\EXECUTAR_DASHBOARD.bat"
echo echo =============================================== >> "DISTRIBUICAO\EXECUTAR_DASHBOARD.bat"
echo echo    DASHBOARD KE5Z - EXECUTAVEL STANDALONE >> "DISTRIBUICAO\EXECUTAR_DASHBOARD.bat"
echo echo =============================================== >> "DISTRIBUICAO\EXECUTAR_DASHBOARD.bat"
echo echo. >> "DISTRIBUICAO\EXECUTAR_DASHBOARD.bat"
echo echo Iniciando Dashboard KE5Z... >> "DISTRIBUICAO\EXECUTAR_DASHBOARD.bat"
echo echo IMPORTANTE: Mantenha esta janela aberta! >> "DISTRIBUICAO\EXECUTAR_DASHBOARD.bat"
echo echo. >> "DISTRIBUICAO\EXECUTAR_DASHBOARD.bat"
echo cd /d "%%~dp0" >> "DISTRIBUICAO\EXECUTAR_DASHBOARD.bat"
echo "Dashboard_KE5Z.exe" >> "DISTRIBUICAO\EXECUTAR_DASHBOARD.bat"
echo echo. >> "DISTRIBUICAO\EXECUTAR_DASHBOARD.bat"
echo echo Dashboard finalizado! >> "DISTRIBUICAO\EXECUTAR_DASHBOARD.bat"
echo pause >> "DISTRIBUICAO\EXECUTAR_DASHBOARD.bat"

REM Criar script de execucao alternativo
echo @echo off > "DISTRIBUICAO\EXECUTAR_STREAMLIT.bat"
echo title Dashboard KE5Z - Streamlit Desktop >> "DISTRIBUICAO\EXECUTAR_STREAMLIT.bat"
echo echo =============================================== >> "DISTRIBUICAO\EXECUTAR_STREAMLIT.bat"
echo echo    DASHBOARD KE5Z - STREAMLIT DESKTOP >> "DISTRIBUICAO\EXECUTAR_STREAMLIT.bat"
echo echo =============================================== >> "DISTRIBUICAO\EXECUTAR_STREAMLIT.bat"
echo echo. >> "DISTRIBUICAO\EXECUTAR_STREAMLIT.bat"
echo echo Iniciando Dashboard via Streamlit Desktop... >> "DISTRIBUICAO\EXECUTAR_STREAMLIT.bat"
echo echo IMPORTANTE: Mantenha esta janela aberta! >> "DISTRIBUICAO\EXECUTAR_STREAMLIT.bat"
echo echo. >> "DISTRIBUICAO\EXECUTAR_STREAMLIT.bat"
echo cd /d "%%~dp0" >> "DISTRIBUICAO\EXECUTAR_STREAMLIT.bat"
echo "Dashboard_KE5Z.exe" >> "DISTRIBUICAO\EXECUTAR_STREAMLIT.bat"
echo echo. >> "DISTRIBUICAO\EXECUTAR_STREAMLIT.bat"
echo echo Dashboard finalizado! >> "DISTRIBUICAO\EXECUTAR_STREAMLIT.bat"
echo pause >> "DISTRIBUICAO\EXECUTAR_STREAMLIT.bat"

REM Copiar arquivos de dados necessarios
if exist "arquivos" (
    xcopy "arquivos" "DISTRIBUICAO\arquivos" /E /I /Q
)

if exist "dados_equipe.json" (
    copy "dados_equipe.json" "DISTRIBUICAO\"
)

if exist "usuarios_padrao.json" (
    copy "usuarios_padrao.json" "DISTRIBUICAO\"
)

REM Criar arquivo README para distribuicao
echo # Dashboard KE5Z - Executavel Standalone > "DISTRIBUICAO\README.md"
echo. >> "DISTRIBUICAO\README.md"
echo ## Como Usar >> "DISTRIBUICAO\README.md"
echo. >> "DISTRIBUICAO\README.md"
echo ### Opcao 1: Executavel Principal >> "DISTRIBUICAO\README.md"
echo - Clique duplo em `EXECUTAR_DASHBOARD.bat` >> "DISTRIBUICAO\README.md"
echo - Abre automaticamente no navegador >> "DISTRIBUICAO\README.md"
echo. >> "DISTRIBUICAO\README.md"
echo ### Opcao 2: Executavel Alternativo >> "DISTRIBUICAO\README.md"
echo - Clique duplo em `EXECUTAR_STREAMLIT.bat` >> "DISTRIBUICAO\README.md"
echo - Interface Streamlit Desktop >> "DISTRIBUICAO\README.md"
echo. >> "DISTRIBUICAO\README.md"
echo ### Opcao 3: Executavel Direto >> "DISTRIBUICAO\README.md"
echo - Clique duplo em `Dashboard_KE5Z.exe` >> "DISTRIBUICAO\README.md"
echo - Executavel standalone >> "DISTRIBUICAO\README.md"
echo. >> "DISTRIBUICAO\README.md"
echo ## Requisitos >> "DISTRIBUICAO\README.md"
echo - Windows 10/11 >> "DISTRIBUICAO\README.md"
echo - **NAO precisa Python instalado** >> "DISTRIBUICAO\README.md"
echo - **NAO precisa instalar dependencias** >> "DISTRIBUICAO\README.md"
echo. >> "DISTRIBUICAO\README.md"
echo ## Distribuicao >> "DISTRIBUICAO\README.md"
echo - Copie a pasta completa para qualquer PC Windows >> "DISTRIBUICAO\README.md"
echo - Execute qualquer um dos scripts acima >> "DISTRIBUICAO\README.md"
echo - Funciona imediatamente! >> "DISTRIBUICAO\README.md"

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
    shortcut_path = os.path.join(desktop, 'Dashboard KE5Z - Standalone.lnk')
    
    target = os.path.join(os.getcwd(), 'DISTRIBUICAO', 'EXECUTAR_DASHBOARD.bat')
    wDir = os.path.join(os.getcwd(), 'DISTRIBUICAO')
    
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
echo    EMBALAGEM CONCLUIDA COM SUCESSO!
echo ===============================================
echo.

echo ✅ Dashboard KE5Z empacotado com sucesso!
echo.
echo 📁 Pasta de distribuicao criada: DISTRIBUICAO\
echo.
echo 📦 Conteudo da pasta DISTRIBUICAO:
echo    - Dashboard_KE5Z.exe (Executavel standalone)
echo    - EXECUTAR_DASHBOARD.bat (Script principal)
echo    - EXECUTAR_STREAMLIT.bat (Script alternativo)
echo    - README.md (Instrucoes de uso)
echo    - arquivos\ (Dados do dashboard)
echo    - dados_equipe.json
echo    - usuarios_padrao.json
echo.
echo 🚀 Como usar:
echo    1. Copie a pasta DISTRIBUICAO\ para qualquer PC Windows
echo    2. Execute EXECUTAR_DASHBOARD.bat
echo    3. Funciona imediatamente (sem Python instalado!)
echo.
echo 📦 Para distribuir:
echo    1. Copie a pasta DISTRIBUICAO\ completa
echo    2. Cole no PC de destino
echo    3. Execute qualquer script .bat
echo    4. Funciona em QUALQUER PC Windows!
echo.
echo 🎉 Embalagem concluida! A pasta esta pronta para distribuicao!
echo.
pause
