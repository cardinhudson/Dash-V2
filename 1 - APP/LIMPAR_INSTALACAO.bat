@echo off
chcp 65001 >nul
setlocal

set "DST=%~dp0Dashboard_KE5Z_FINAL_DESKTOP"

echo ===============================================
echo   LIMPEZA COMPLETA - DASHBOARD KE5Z
echo ===============================================

rem ==== FECHAR PROCESSOS ====
echo Fechando processos do Dashboard...
taskkill /f /im "Dashboard_KE5Z_Desktop.exe" >nul 2>&1
taskkill /f /im "python.exe" >nul 2>&1
taskkill /f /im "streamlit.exe" >nul 2>&1

echo Aguardando 3 segundos...
timeout /t 3 /nobreak >nul

rem ==== REMOVER ATALHO ====
echo Removendo atalho da area de trabalho...
del "%USERPROFILE%\Desktop\Dashboard KE5Z Desktop.lnk" >nul 2>&1

rem ==== LIMPEZA FORCADA DA PASTA ====
if exist "%DST%" (
  echo Limpando pasta de instalacao...
  
  rem Remover atributos de todos os arquivos
  attrib -r -h -s "%DST%\*" /s /d >nul 2>&1
  
  rem Tentar remover arquivos individualmente
  for /f "delims=" %%i in ('dir "%DST%" /s /b /a-d 2^>nul') do (
    del /f /q "%%i" >nul 2>&1
  )
  
  rem Tentar remover diretorios
  for /f "delims=" %%i in ('dir "%DST%" /s /b /ad 2^>nul ^| sort /r') do (
    rmdir /s /q "%%i" >nul 2>&1
  )
  
  rem Remocao final
  rmdir /s /q "%DST%" >nul 2>&1
  
  if exist "%DST%" (
    echo AVISO: Alguns arquivos nao puderam ser removidos.
    echo Execute como Administrador ou reinicie o PC.
  ) else (
    echo Limpeza concluida com sucesso!
  )
) else (
  echo Nenhuma instalacao anterior encontrada.
)

echo.
echo Limpeza finalizada!
echo Agora voce pode executar o instalador normalmente.

pause
