@echo off
chcp 65001 >nul 2>&1
cd /d "%~dp0"

echo ===============================================
echo    VERIFICANDO INSTALACAO DO DASHBOARD
echo ===============================================
echo.

echo Verificando executavel...
if exist "dist\Dashboard_KE5Z\Dashboard_KE5Z.exe" (
    echo ✅ Executável encontrado
) else (
    echo ❌ Executável não encontrado
    goto :end
)

echo.
echo Verificando arquivos essenciais na pasta _internal...
if exist "dist\Dashboard_KE5Z\_internal\auth_simple.py" (
    echo ✅ auth_simple.py
) else (
    echo ❌ auth_simple.py - FALTANDO
)

if exist "dist\Dashboard_KE5Z\_internal\dados_equipe.json" (
    echo ✅ dados_equipe.json
) else (
    echo ❌ dados_equipe.json - FALTANDO
)

if exist "dist\Dashboard_KE5Z\_internal\usuarios_padrao.json" (
    echo ✅ usuarios_padrao.json
) else (
    echo ❌ usuarios_padrao.json - FALTANDO
)

if exist "dist\Dashboard_KE5Z\_internal\pages" (
    echo ✅ pasta pages
) else (
    echo ❌ pasta pages - FALTANDO
)

if exist "dist\Dashboard_KE5Z\_internal\KE5Z" (
    echo ✅ pasta KE5Z
) else (
    echo ❌ pasta KE5Z - FALTANDO
)

if exist "dist\Dashboard_KE5Z\_internal\Extracoes" (
    echo ✅ pasta Extracoes
) else (
    echo ❌ pasta Extracoes - FALTANDO
)

if exist "dist\Dashboard_KE5Z\_internal\arquivos" (
    echo ✅ pasta arquivos
) else (
    echo ❌ pasta arquivos - FALTANDO
)

echo.
echo ===============================================
echo    RESULTADO DA VERIFICACAO
echo ===============================================

:end
pause

