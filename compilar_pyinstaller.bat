@echo off
chcp 65001 >nul
echo ===============================================
echo    COMPILANDO DASHBOARD KE5Z COM PYINSTALLER
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

REM Instalar PyInstaller
echo 🔧 Instalando PyInstaller...
pip install pyinstaller --quiet

REM Criar pasta de saída
if not exist "dist" mkdir dist

echo.
echo 🚀 Iniciando compilação com PyInstaller...
echo ⏱️  Este processo pode levar 10-20 minutos...
echo.

REM Criar arquivo .spec personalizado
echo 📝 Criando arquivo de configuração PyInstaller...
(
echo # -*- mode: python ; coding: utf-8 -*-
echo.
echo block_cipher = None
echo.
echo a = Analysis^(
echo     ['dashboard_main.py'],
echo     pathex=[],
echo     binaries=[],
echo     datas=[
echo         ^('KE5Z', 'KE5Z'^),
echo         ^('pages', 'pages'^),
echo         ^('auth_simple.py', '.'^),
echo         ^('Extração.py', '.'^),
echo         ^('dados_equipe.json', '.'^),
echo         ^('usuarios_padrao.json', '.'^),
echo     ],
echo     hiddenimports=[
echo         'streamlit',
echo         'pandas',
echo         'altair',
echo         'plotly',
echo         'openpyxl',
echo         'numpy',
echo         'pandas.io.formats.style',
echo     ],
echo     hookspath=[],
echo     hooksconfig={},
echo     runtime_hooks=[],
echo     excludes=[],
echo     win_no_prefer_redirects=False,
echo     win_private_assemblies=False,
echo     cipher=block_cipher,
echo     noarchive=False,
echo ^)
echo.
echo pyz = PYZ^(a.pure, a.zipped_data, cipher=block_cipher^)
echo.
echo exe = EXE^(
echo     pyz,
echo     a.scripts,
echo     a.binaries,
echo     a.zipfiles,
echo     a.datas,
echo     [],
echo     name='Dashboard_KE5Z',
echo     debug=False,
echo     bootloader_ignore_signals=False,
echo     strip=False,
echo     upx=True,
echo     upx_exclude=[],
echo     runtime_tmpdir=None,
echo     console=False,
echo     disable_windowed_traceback=False,
echo     argv_emulation=False,
echo     target_arch=None,
echo     codesign_identity=None,
echo     entitlements_file=None,
echo ^)
) > dashboard.spec

REM Compilar com PyInstaller
pyinstaller dashboard.spec

if %errorlevel% neq 0 (
    echo ❌ Erro na compilação!
    echo.
    echo 🔧 Tentando compilação simples...
    pyinstaller --onefile --windowed --name=Dashboard_KE5Z_Simple ^
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
echo    3. O dashboard abrirá no navegador em http://localhost:8501
echo.

REM Limpar arquivos temporários
if exist dashboard.spec del dashboard.spec
if exist build rmdir /s /q build

echo.
pause





