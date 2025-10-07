@echo off
echo ===============================================
echo    DEBUG STREAMLIT - DIAGNOSTICO COMPLETO
echo ===============================================
echo.

echo Pressione qualquer tecla para continuar...
pause >nul

echo.
echo === 1. VERIFICANDO DIRETORIO ===
echo Diretorio atual: %CD%
echo.

echo === 2. VERIFICANDO ARQUIVOS ===
if exist "dashboard_main.py" (
    echo ✅ dashboard_main.py - ENCONTRADO
) else (
    echo ❌ dashboard_main.py - NAO ENCONTRADO
)

if exist "venv" (
    echo ✅ venv - PASTA ENCONTRADA
) else (
    echo ❌ venv - PASTA NAO ENCONTRADA
)

if exist "venv\Scripts" (
    echo ✅ venv\Scripts - PASTA ENCONTRADA
) else (
    echo ❌ venv\Scripts - PASTA NAO ENCONTRADA
)

if exist "venv\Scripts\streamlit.exe" (
    echo ✅ streamlit.exe - ENCONTRADO
) else (
    echo ❌ streamlit.exe - NAO ENCONTRADO
)

if exist "venv\Scripts\python.exe" (
    echo ✅ python.exe - ENCONTRADO
) else (
    echo ❌ python.exe - NAO ENCONTRADO
)

echo.
echo === 3. TESTANDO COMANDOS ===

echo Testando streamlit --version...
if exist "venv\Scripts\streamlit.exe" (
    "venv\Scripts\streamlit.exe" --version
    echo.
) else (
    echo ❌ streamlit.exe nao encontrado para teste
    echo.
)

echo Testando python --version...
if exist "venv\Scripts\python.exe" (
    "venv\Scripts\python.exe" --version
    echo.
) else (
    echo ❌ python.exe nao encontrado para teste
    echo.
)

echo === 4. TESTANDO EXECUCAO STREAMLIT ===
echo.
echo Tentando executar streamlit run dashboard_main.py...
echo (Pressione Ctrl+C para parar se funcionar)
echo.

if exist "venv\Scripts\streamlit.exe" (
    "venv\Scripts\streamlit.exe" run dashboard_main.py --server.port 8501
) else (
    echo ❌ streamlit.exe nao encontrado - nao foi possivel testar
)

echo.
echo === DIAGNOSTICO CONCLUIDO ===
echo.
pause
