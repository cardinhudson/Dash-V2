# ========================================
# TESTE FINAL - DASHBOARD KE5Z DESKTOP
# ========================================

Write-Host "=" * 60 -ForegroundColor Cyan
Write-Host "🧪 TESTE FINAL - DASHBOARD KE5Z DESKTOP" -ForegroundColor Green
Write-Host "=" * 60 -ForegroundColor Cyan
Write-Host ""

# Verificar executável
$exePath = "c:\Dash-V2\1 - APP\Dashboard_KE5Z_Desktop.exe"
if (Test-Path $exePath) {
    $exeSize = (Get-Item $exePath).Length / 1MB
    Write-Host "✅ Executável encontrado: $($exeSize.ToString('F2')) MB" -ForegroundColor Green
} else {
    Write-Host "❌ Executável NÃO encontrado!" -ForegroundColor Red
    exit 1
}

# Verificar arquivos necessários
$requiredFiles = @(
    "auth_simple.py",
    "usuarios_padrao.json", 
    "usuarios.json",
    "KE5Z\KE5Z.parquet",
    ".streamlit\config.toml"
)

Write-Host ""
Write-Host "🔍 Verificando arquivos necessários..." -ForegroundColor Yellow

$allFilesExist = $true
foreach ($file in $requiredFiles) {
    $filePath = "c:\Dash-V2\1 - APP\$file"
    if (Test-Path $filePath) {
        Write-Host "   ✅ $file" -ForegroundColor Green
    } else {
        Write-Host "   ❌ $file" -ForegroundColor Red
        $allFilesExist = $false
    }
}

if (-not $allFilesExist) {
    Write-Host ""
    Write-Host "❌ Alguns arquivos necessários estão faltando!" -ForegroundColor Red
    Write-Host "   Execute primeiro o build completo" -ForegroundColor Yellow
    exit 1
}

# Teste do executável
Write-Host ""
Write-Host "🚀 Testando executável..." -ForegroundColor Yellow
Write-Host "   Iniciando Dashboard (aguarde 10 segundos)..." -ForegroundColor Gray

try {
    # Iniciar o executável em background
    $process = Start-Process -FilePath $exePath -PassThru -WindowStyle Hidden
    
    # Aguardar inicialização
    Start-Sleep -Seconds 10
    
    # Verificar se a porta 8501 está ativa
    $portCheck = netstat -an | Select-String ":8501.*LISTENING"
    if ($portCheck) {
        Write-Host "   ✅ Servidor Streamlit ativo na porta 8501" -ForegroundColor Green
        
        # Testar conexão HTTP
        try {
            $response = Invoke-WebRequest -Uri "http://localhost:8501" -TimeoutSec 5 -ErrorAction Stop
            if ($response.StatusCode -eq 200) {
                Write-Host "   ✅ Dashboard respondendo corretamente" -ForegroundColor Green
            }
        } catch {
            Write-Host "   ⚠️  Dashboard iniciou mas não respondeu ao teste HTTP" -ForegroundColor Yellow
        }
    } else {
        Write-Host "   ❌ Servidor não iniciou na porta 8501" -ForegroundColor Red
    }
    
    # Parar o processo de teste
    Stop-Process -Id $process.Id -Force -ErrorAction SilentlyContinue
    Start-Sleep -Seconds 2
    
} catch {
    Write-Host "   ❌ Erro ao testar executável: $($_.Exception.Message)" -ForegroundColor Red
}

# Verificar configurações
Write-Host ""
Write-Host "⚙️ Verificando configurações..." -ForegroundColor Yellow

$configPath = "c:\Dash-V2\1 - APP\.streamlit\config.toml"
if (Test-Path $configPath) {
    $configContent = Get-Content $configPath -Raw
    if ($configContent -match "headless = true") {
        Write-Host "   ✅ Configuração headless correta" -ForegroundColor Green
    } else {
        Write-Host "   ⚠️  Configuração headless pode estar incorreta" -ForegroundColor Yellow
    }
} else {
    Write-Host "   ❌ Arquivo de configuração não encontrado" -ForegroundColor Red
}

# Resumo do teste
Write-Host ""
Write-Host "=" * 60 -ForegroundColor Cyan
Write-Host "📊 RESULTADO DO TESTE" -ForegroundColor Green
Write-Host "=" * 60 -ForegroundColor Cyan

if ($allFilesExist -and $portCheck) {
    Write-Host "🎉 TESTE APROVADO!" -ForegroundColor Green
    Write-Host ""
    Write-Host "✅ O Dashboard está funcionando corretamente" -ForegroundColor Green
    Write-Host "✅ Todos os arquivos necessários estão presentes" -ForegroundColor Green
    Write-Host "✅ Servidor Streamlit está ativo" -ForegroundColor Green
    Write-Host ""
    Write-Host "🚀 PRONTO PARA USO!" -ForegroundColor Green
    Write-Host ""
    Write-Host "📱 Para usar:" -ForegroundColor Yellow
    Write-Host "   1. Execute: .\Dashboard_KE5Z_Desktop.exe" -ForegroundColor White
    Write-Host "   2. Acesse: http://localhost:8501" -ForegroundColor White
    Write-Host "   3. Mantenha a janela do executável aberta" -ForegroundColor White
} else {
    Write-Host "❌ TESTE FALHOU!" -ForegroundColor Red
    Write-Host ""
    Write-Host "🔧 Verifique:" -ForegroundColor Yellow
    Write-Host "   • Se todos os arquivos estão presentes" -ForegroundColor White
    Write-Host "   • Se o executável foi construído corretamente" -ForegroundColor White
    Write-Host "   • Se não há conflitos de porta" -ForegroundColor White
}

Write-Host ""
Write-Host "Pressione qualquer tecla para finalizar..." -ForegroundColor Gray
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")