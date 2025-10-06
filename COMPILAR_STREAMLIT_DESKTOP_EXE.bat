@echo off
chcp 65001 >nul
echo ===============================================
echo    COMPILANDO COM STREAMLIT DESKTOP APP
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
pip install streamlit-desktop-app --quiet

REM Criar pasta de saída
if not exist "dist" mkdir dist

echo.
echo 🚀 Iniciando compilação com Streamlit Desktop App...
echo ⏱️  Este processo pode levar 10-20 minutos...
echo.

REM Compilar com Streamlit Desktop App
streamlit-desktop build dashboard_main.py --output-dir dist --name Dashboard_KE5Z

if %errorlevel% neq 0 (
    echo ❌ Erro na compilação!
    echo.
    echo 🔧 Tentando compilação alternativa com PyInstaller...
    pyinstaller --onefile --windowed --name=Dashboard_KE5Z ^
        --add-data="KE5Z;KE5Z" ^
        --add-data="pages;pages" ^
        --add-data="auth_simple.py;." ^
        --add-data="Extração.py;." ^
        --add-data="dados_equipe.json;." ^
        --add-data="usuarios_padrao.json;." ^
        --hidden-import=streamlit ^
        --hidden-import=pandas ^
        --hidden-import=altair ^
        --hidden-import=plotly ^
        --hidden-import=openpyxl ^
        --hidden-import=pywebview ^
        dashboard_main.py
    
    if %errorlevel% neq 0 (
        echo ❌ Compilação falhou completamente!
        pause
        exit /b 1
    )
)

echo.
echo ✅ Compilação concluída com sucesso!
echo 📁 Executável criado em: dist\Dashboard_KE5Z.exe
echo.
echo 🎯 O executável pode ser executado em qualquer PC Windows 11
echo    sem necessidade de instalar Python ou dependências!
echo.
echo 📋 Para testar:
echo    1. Vá para a pasta dist\
echo    2. Execute Dashboard_KE5Z.exe
echo    3. O dashboard abrirá em uma janela de desktop
echo.
echo 🎉 Vantagens do Streamlit Desktop:
echo    ✅ Aplicativo nativo (não no navegador)
echo    ✅ Interface mais limpa
echo    ✅ Melhor performance
echo    ✅ Funciona offline
echo.
pause





