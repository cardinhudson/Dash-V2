# Script PowerShell para executar o Dashboard KE5Z
Write-Host "===============================================" -ForegroundColor Cyan
Write-Host "    DASHBOARD KE5Z - STREAMLIT DESKTOP" -ForegroundColor Cyan
Write-Host "===============================================" -ForegroundColor Cyan
Write-Host ""

# Verificar se a pasta "1 - APP" existe
if (-not (Test-Path "1 - APP")) {
    Write-Host "❌ Pasta '1 - APP' não encontrada!" -ForegroundColor Red
    Write-Host "Certifique-se de que a pasta foi criada corretamente." -ForegroundColor Yellow
    Read-Host "Pressione Enter para sair"
    exit 1
}

Write-Host "✅ Pasta '1 - APP' encontrada!" -ForegroundColor Green

# Navegar para a pasta
Set-Location "1 - APP"

Write-Host ""
Write-Host "🔍 Verificando arquivos necessários..." -ForegroundColor Yellow

# Verificar arquivos necessários
$arquivos = @(
    "EXECUTAR_DASHBOARD.bat",
    "dashboard_main.py",
    "KE5Z",
    "pages",
    "auth_simple.py",
    "requirements.txt"
)

foreach ($arquivo in $arquivos) {
    if (-not (Test-Path $arquivo)) {
        Write-Host "❌ Arquivo/pasta '$arquivo' não encontrado!" -ForegroundColor Red
        Read-Host "Pressione Enter para sair"
        exit 1
    }
    Write-Host "✅ $arquivo encontrado!" -ForegroundColor Green
}

Write-Host ""
Write-Host "🚀 Executando Dashboard..." -ForegroundColor Green
Write-Host ""
Write-Host "⚠️  IMPORTANTE:" -ForegroundColor Yellow
Write-Host "   - O dashboard abrirá em uma janela de desktop" -ForegroundColor White
Write-Host "   - Mantenha esta janela aberta enquanto usar" -ForegroundColor White
Write-Host "   - Se der erro, verifique se Python está instalado" -ForegroundColor White
Write-Host ""

# Executar o arquivo .bat
try {
    & ".\EXECUTAR_DASHBOARD.bat"
} catch {
    Write-Host "❌ Erro ao executar o dashboard: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host ""
    Write-Host "🔧 Soluções possíveis:" -ForegroundColor Yellow
    Write-Host "   1. Instale Python 3.8+ de https://python.org/downloads" -ForegroundColor White
    Write-Host "   2. Marque 'Add Python to PATH' durante a instalação" -ForegroundColor White
    Write-Host "   3. Reinicie o computador após instalar Python" -ForegroundColor White
    Write-Host "   4. Execute como administrador" -ForegroundColor White
}

Write-Host ""
Write-Host "Dashboard finalizado!" -ForegroundColor Cyan
Read-Host "Pressione Enter para sair"


