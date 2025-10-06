$ErrorActionPreference = 'Stop'

# Raiz do projeto baseada na localização do script
$root = Split-Path -Parent $PSCommandPath
$app  = Join-Path $root '1 - APP'

# 1) Garantir destino 1 - APP\Extracoes
$destExtracoes = Join-Path $app 'Extracoes'
New-Item -ItemType Directory -Force -Path $destExtracoes | Out-Null

# 2) Localizar pasta base "Extra*" (aceita variações de acento/mojibake)
$candidateDirs = Get-ChildItem -Path $root -Directory -ErrorAction SilentlyContinue | Where-Object { $_.Name -like 'Extra*' }

foreach ($p in @('KE5Z','KSBB')) {
  $src = $null
  foreach ($c in $candidateDirs) {
    $try = Join-Path $c.FullName $p
    if (Test-Path $try) { $src = $try; break }
  }
  if ($src) {
    $dst = Join-Path $destExtracoes $p
    New-Item -ItemType Directory -Force -Path $dst | Out-Null
    robocopy $src $dst /E /NFL /NDL /NJH /NJS /NC /NS | Out-Null
  }
}

# 3) Renomear pasta corrompida dentro do dist para Extracoes
$distBase = Join-Path $app 'dist\Dashboard_KE5Z'
if (Test-Path $distBase) {
  $extraFolder = Get-ChildItem -Path $distBase -Directory -ErrorAction SilentlyContinue | Where-Object { $_.Name -like 'Extra*' } | Select-Object -First 1
  if ($extraFolder -and ($extraFolder.Name -ne 'Extracoes')) {
    $targetPath = Join-Path $distBase 'Extracoes'
    if (Test-Path $targetPath) { Remove-Item -Recurse -Force $targetPath }
    Rename-Item -Path $extraFolder.FullName -NewName 'Extracoes' -Force
  }
}

# 4) Criar cópia do script com ASCII: Extracao.py
$scriptCandidates = @(
  (Join-Path $app  'Extra*.py')
  (Join-Path $root 'Extra*.py')
) | ForEach-Object { Get-ChildItem -Path $_ -File -ErrorAction SilentlyContinue }

$scriptSrc = $scriptCandidates | Select-Object -First 1
if ($scriptSrc) {
  Copy-Item $scriptSrc.FullName (Join-Path $app 'Extracao.py') -Force
}

# 5) Ajustar python311._pth para o Python portátil
$pth = Join-Path $app 'python_portable\python311._pth'
if (Test-Path $pth) {
  Set-Content -Path $pth -Value @('python311.zip','.', 'import site') -Encoding ASCII
}

Write-Host 'Concluido'


