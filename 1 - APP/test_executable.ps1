# Script para testar o executável Dashboard KE5Z Desktop
Write-Host "=" * 60 -ForegroundColor Cyan
Write-Host "TESTE DO EXECUTÁVEL DASHBOARD KE5Z DESKTOP" -ForegroundColor Green
Write-Host "=" * 60 -ForegroundColor Cyan
Write-Host ""

# Verificar se o executável existe
$exePath = "c:\Dash-V2\1 - APP\Dashboard_KE5Z_Desktop.exe"
if (Test-Path $exePath) {
    $exeSize = (Get-Item $exePath).Length / 1MB
    Write-Host "✅ Executável encontrado: $exePath" -ForegroundColor Green
    Write-Host "   Tamanho: $($exeSize.ToString('F2')) MB" -ForegroundColor Cyan
    Write-Host ""
} else {
    Write-Host "❌ Executável NÃO encontrado!" -ForegroundColor Red
    exit 1
}

# Verificar metadados incluídos
Write-Host "🔍 Verificando metadados incluídos..." -ForegroundColor Yellow
Write-Host ""

$archiveViewer = "c:\Dash-V2\1 - APP\venv\Scripts\pyi-archive_viewer.exe"
$metadata = & $archiveViewer $exePath | Select-String "METADATA"

Write-Host "📦 Metadados encontrados:" -ForegroundColor Cyan
$metadata | Select-Object -First 10 | ForEach-Object { 
    Write-Host "   $_" -ForegroundColor Gray 
}

Write-Host ""
Write-Host "=" * 60 -ForegroundColor Cyan
Write-Host "TESTE CONCLUÍDO" -ForegroundColor Green
Write-Host "=" * 60 -ForegroundColor Cyan
Write-Host ""
Write-Host "⚠️  NOTA: Para testar a execução completa, execute:" -ForegroundColor Yellow
Write-Host "   .\Dashboard_KE5Z_Desktop.exe" -ForegroundColor White
Write-Host ""

