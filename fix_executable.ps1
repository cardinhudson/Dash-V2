# Script para corrigir arquivos faltantes no executável
Write-Host "🔧 Corrigindo arquivos faltantes no executável..." -ForegroundColor Green

# Diretórios
$sourceDir = "c:\Dash-V2\1 - APP"
$targetDir = "c:\Dash-V2\Dashboard_KE5Z_FINAL_DESKTOP"

# Arquivos necessários
$files = @(
    "auth_simple.py",
    "usuarios_padrao.json",
    "usuarios.json"
)

# Copiar arquivos
foreach ($file in $files) {
    $sourcePath = Join-Path $sourceDir $file
    $targetPath = Join-Path $targetDir $file
    
    if (Test-Path $sourcePath) {
        Copy-Item $sourcePath $targetPath -Force
        Write-Host "✅ Copiado: $file" -ForegroundColor Green
    } else {
        Write-Host "⚠️ Arquivo não encontrado: $file" -ForegroundColor Yellow
    }
}

Write-Host "🎉 Correção concluída!" -ForegroundColor Green
Write-Host "📁 Arquivos no diretório do executável:" -ForegroundColor Cyan
Get-ChildItem $targetDir | Select-Object Name, Length, LastWriteTime | Format-Table -AutoSize
