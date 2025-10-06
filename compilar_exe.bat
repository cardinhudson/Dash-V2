@echo off
chcp 65001 >nul
echo ===============================================
echo    COMPILANDO DASHBOARD KE5Z COM NUITKA
echo ===============================================
echo.

cd /d "%~dp0"

REM Verificar se Python está instalado
where python >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ Python não encontrado! Por favor, instale Python 3.8+ de https://python.org/downloads
    pause
    exit /b 1
)
echo ✅ Python encontrado!

REM Ativar ambiente virtual
echo 🔄 Ativando ambiente virtual...
if not exist venv\Scripts\activate.bat (
    echo 🛠️ Criando ambiente virtual...
    python -m venv venv
    if %errorlevel% neq 0 (
        echo ❌ Erro ao criar ambiente virtual.
        pause
        exit /b 1
    )
)
call venv\Scripts\activate.bat

REM Instalar dependências
echo 📦 Instalando dependências...
pip install -r requirements.txt --quiet

REM Instalar Nuitka
echo 🔧 Instalando Nuitka...
pip install nuitka --quiet

REM Criar pasta de saída
if not exist "dist" mkdir dist

echo.
echo 🚀 Iniciando compilação com Nuitka...
echo ⏱️  Este processo pode levar 15-30 minutos na primeira vez...
echo.

REM Compilar com Nuitka
python -m nuitka ^
    --standalone ^
    --onefile ^
    --enable-plugin=streamlit ^
    --enable-plugin=pandas ^
    --enable-plugin=altair ^
    --enable-plugin=plotly ^
    --enable-plugin=openpyxl ^
    --include-data-dir=KE5Z=KE5Z ^
    --include-data-dir=pages=pages ^
    --include-data-file=auth_simple.py=auth_simple.py ^
    --include-data-file=Extração.py=Extração.py ^
    --include-data-file=dados_equipe.json=dados_equipe.json ^
    --include-data-file=usuarios_padrao.json=usuarios_padrao.json ^
    --include-data-file=requirements.txt=requirements.txt ^
    --output-filename=Dashboard_KE5Z.exe ^
    --output-dir=dist ^
    --windows-console-mode=disable ^
    --windows-icon-from-ico=icon.ico ^
    --assume-yes-for-downloads ^
    --no-prefer-source-code ^
    --remove-output ^
    dashboard_main.py

if %errorlevel% neq 0 (
    echo ❌ Erro na compilação!
    pause
    exit /b 1
)

echo.
echo ✅ Compilação concluída com sucesso!
echo 📁 Executável criado em: dist\Dashboard_KE5Z.exe
echo.
echo 🎯 O executável pode ser executado em qualquer PC Windows 11
echo    sem necessidade de instalar Python ou dependências!
echo.
pause





