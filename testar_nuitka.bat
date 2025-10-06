@echo off
chcp 65001 >nul
echo ===============================================
echo    TESTANDO NUITKA ANTES DA COMPILAÇÃO
echo ===============================================
echo.

cd /d "%~dp0"

REM Ativar ambiente virtual
call venv\Scripts\activate.bat

echo 🔧 Testando instalação do Nuitka...
python -c "import nuitka; print('✅ Nuitka instalado:', nuitka.__version__)"

echo.
echo 🔧 Testando compilação de um arquivo simples...
echo print("Hello World!") > test_simple.py

python -m nuitka --onefile --output-filename=test_simple.exe test_simple.py

if %errorlevel% neq 0 (
    echo ❌ Nuitka não está funcionando corretamente!
    echo.
    echo 🔧 Tentando instalar versão específica...
    pip uninstall nuitka -y
    pip install nuitka==1.8.6
    echo.
    echo 🔄 Testando novamente...
    python -m nuitka --onefile --output-filename=test_simple.exe test_simple.py
)

if exist test_simple.exe (
    echo ✅ Teste básico do Nuitka funcionou!
    del test_simple.exe
    del test_simple.py
    echo.
    echo 🚀 Pronto para compilar o dashboard!
    echo Execute: compilar_nuitka.bat
) else (
    echo ❌ Nuitka não está funcionando. Vamos tentar PyInstaller como alternativa.
    echo Execute: compilar_pyinstaller.bat
)

echo.
pause
