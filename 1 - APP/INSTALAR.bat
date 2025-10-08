@echo off
title Instalar Dashboard KE5Z
echo ===============================================
echo    INSTALAR DASHBOARD KE5Z
echo ===============================================
echo.
echo Este script vai instalar o Dashboard KE5Z
echo que funciona em QUALQUER PC Windows!
echo.
echo IMPORTANTE: Este processo pode levar 5-10 minutos
echo dependendo da velocidade da internet e do PC.
echo.
echo Pressione qualquer tecla para continuar...
pause >nul

cd /d "%~dp0"

echo.
echo ===============================================
echo    VERIFICANDO PYTHON
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
echo    CRIANDO AMBIENTE VIRTUAL
echo ===============================================
echo.

REM Criar ambiente virtual
echo Criando ambiente virtual Python...
%PYTHON_CMD% -m venv venv
if errorlevel 1 (
    echo ❌ Erro ao criar ambiente virtual!
    echo.
    pause
    exit /b 1
)
echo ✅ Ambiente virtual criado!
echo.

REM Ativar ambiente virtual
echo Ativando ambiente virtual...
call venv\Scripts\activate.bat
if errorlevel 1 (
    echo ❌ Erro ao ativar ambiente virtual!
    echo.
    pause
    exit /b 1
)
echo ✅ Ambiente virtual ativado!
echo.

echo ===============================================
echo    INSTALANDO DEPENDENCIAS
echo ===============================================
echo.

REM Instalar dependencias
echo Instalando dependencias do Dashboard...
%PYTHON_CMD% -m pip install -r requirements.txt
if errorlevel 1 (
    echo ❌ Erro ao instalar dependencias!
    echo.
    pause
    exit /b 1
)
echo ✅ Dependencias instaladas!
echo.

echo ===============================================
echo    CRIANDO EXECUTAVEL
echo ===============================================
echo.

REM Instalar PyInstaller
echo Instalando PyInstaller...
%PYTHON_CMD% -m pip install pyinstaller
if errorlevel 1 (
    echo ❌ Erro ao instalar PyInstaller!
    echo.
    pause
    exit /b 1
)
echo ✅ PyInstaller instalado!
echo.

REM Limpar pastas anteriores
echo Limpando pastas anteriores...
if exist "build" rmdir /s /q "build"
if exist "dist" rmdir /s /q "dist"
if exist "*.spec" del "*.spec"
echo ✅ Pastas limpas!
echo.

REM Instalar streamlit-desktop-app
echo Instalando streamlit-desktop-app...
%PYTHON_CMD% -m pip install streamlit-desktop-app
if errorlevel 1 (
    echo ❌ Erro ao instalar streamlit-desktop-app!
    echo.
    pause
    exit /b 1
)
echo ✅ streamlit-desktop-app instalado!
echo.

REM Criar executavel desktop
echo Criando executavel desktop standalone...
echo NOTA: Esta versao cria um executavel desktop que funciona como aplicativo nativo.
%PYTHON_CMD% -m streamlit-desktop-app build dashboard_main.py --name Dashboard_KE5Z_Desktop --pyinstaller-options --onefile --noconfirm
if errorlevel 1 (
    echo ❌ Erro ao criar executavel desktop!
    echo.
    echo SOLUCAO: Use o EXECUTAR.bat que executa via Python diretamente.
    echo.
    pause
    exit /b 1
)
echo ✅ Executavel desktop criado!
echo.

echo ===============================================
echo    ORGANIZANDO ARQUIVOS
echo ===============================================
echo.

REM Mover executavel para a pasta principal
echo Movendo executavel desktop...
if exist "dist\Dashboard_KE5Z_Desktop.exe" (
    move "dist\Dashboard_KE5Z_Desktop.exe" "Dashboard_KE5Z_Desktop.exe"
    rmdir /s /q dist
    rmdir /s /q build
    echo ✅ Executavel desktop movido!
) else (
    echo ❌ Executavel desktop nao encontrado!
    echo.
    pause
    exit /b 1
)
echo.

echo ===============================================
echo    INSTALACAO CONCLUIDA!
echo ===============================================
echo.
echo ✅ Dashboard KE5Z instalado com sucesso!
echo.
echo Para executar o Dashboard:
echo 1. Clique duplo em: EXECUTAR.bat
echo.
echo Pressione qualquer tecla para finalizar...
pause >nul
exit /b 0
