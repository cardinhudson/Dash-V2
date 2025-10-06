@echo off
chcp 65001 >nul 2>&1
cd /d "%~dp0"

echo ===============================================
echo    INSTALANDO ARQUIVOS NECESSARIOS
echo ===============================================
echo.

echo Copiando arquivos de dados para pasta _internal...
copy "auth_simple.py" "dist\Dashboard_KE5Z\_internal\" >nul
copy "dados_equipe.json" "dist\Dashboard_KE5Z\_internal\" >nul
copy "usuarios_padrao.json" "dist\Dashboard_KE5Z\_internal\" >nul
copy "Extracao.py" "dist\Dashboard_KE5Z\_internal\" >nul
copy "..\Dados SAPIENS.xlsx" "dist\Dashboard_KE5Z\_internal\" >nul
copy "..\Fornecedores.xlsx" "dist\Dashboard_KE5Z\_internal\" >nul

echo Copiando pastas de dados para pasta _internal...
xcopy "pages" "dist\Dashboard_KE5Z\_internal\pages\" /E /I /H /Y >nul
xcopy "KE5Z" "dist\Dashboard_KE5Z\_internal\KE5Z\" /E /I /H /Y >nul
xcopy "Extracoes" "dist\Dashboard_KE5Z\_internal\Extracoes\" /E /I /H /Y >nul
xcopy "arquivos" "dist\Dashboard_KE5Z\_internal\arquivos\" /E /I /H /Y >nul

echo.
echo ✅ Arquivos instalados com sucesso!
echo 🚀 Agora você pode executar o Dashboard
echo.
pause
