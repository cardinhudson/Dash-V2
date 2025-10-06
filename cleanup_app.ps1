$ErrorActionPreference = 'Continue'

$root = Split-Path -Parent $PSCommandPath
$app  = Join-Path $root '1 - APP'

function Try-Remove($path){
  if(Test-Path $path){
    try { Remove-Item -Recurse -Force $path -ErrorAction Stop }
    catch {
      # Se não conseguir remover, tenta renomear para marcar como obsoleto
      try { Rename-Item -Path $path -NewName ("__obsolete_" + [IO.Path]::GetFileName($path)) -ErrorAction Stop }
      catch { }
    }
  }
}

# Remover artefatos não usados
Try-Remove (Join-Path $app 'build')
Try-Remove (Join-Path $app 'dist')
Try-Remove (Join-Path $app 'venv')
Try-Remove (Join-Path $app 'download.vbs')
Try-Remove (Join-Path $app 'Dashboard_KE5Z.spec')

# Pasta de saída Excel
$outDir = Join-Path $app 'arquivos'
New-Item -ItemType Directory -Force -Path $outDir | Out-Null

# Copiar Excel atuais, se existirem na raiz
$srcDir = Join-Path $root 'arquivos'
if(Test-Path $srcDir){
  Get-ChildItem -Path $srcDir -Filter *.xlsx -File -ErrorAction SilentlyContinue | ForEach-Object {
    Copy-Item $_.FullName -Destination (Join-Path $outDir $_.Name) -Force -ErrorAction SilentlyContinue
  }
}

Write-Host 'Cleanup concluido'





