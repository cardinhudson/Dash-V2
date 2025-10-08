@echo off
title Criar Executavel Dashboard KE5Z
echo ===============================================
echo    CRIAR EXECUTAVEL DASHBOARD KE5Z
echo ===============================================
echo.

echo Este script criara um executavel que pode ser executado
echo em qualquer PC com Windows, mesmo SEM Python instalado!
echo.
echo Pressione qualquer tecla para continuar...
pause >nul

echo.
echo === 1. Verificando ambiente virtual ===
if not exist "venv\Scripts\python.exe" (
    echo ERRO: Ambiente virtual nao encontrado!
    echo Execute primeiro o INSTALAR_DASHBOARD.bat
    echo.
    pause
    exit /b 1
)

echo ✅ Ambiente virtual encontrado!
echo.

echo === 2. Instalando PyInstaller ===
"venv\Scripts\pip.exe" install pyinstaller
echo.

echo === 3. Criando executavel ===
echo Aguarde... este processo pode levar varios minutos...
echo.

"venv\Scripts\pyinstaller.exe" --noconfirm --onefile --windowed ^
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
    dashboard_main.py

echo.
echo === 4. Verificando resultado ===
if exist "dist\Dashboard_KE5Z.exe" (
    echo ✅ Executavel criado com sucesso!
    echo.
    echo Localizacao: dist\Dashboard_KE5Z.exe
    echo.
    echo Este executavel pode ser copiado para qualquer PC com Windows
    echo e funcionara mesmo SEM Python instalado!
) else (
    echo ❌ Erro ao criar executavel!
    echo Verifique os logs acima para mais detalhes.
)

echo.
pause
