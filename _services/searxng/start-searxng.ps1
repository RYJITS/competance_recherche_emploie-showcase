$ErrorActionPreference = "Stop"

$Root = Split-Path -Parent $MyInvocation.MyCommand.Path
$Source = Join-Path $Root "searxng-src"
$Python = Join-Path $Root ".venv\Scripts\python.exe"
$Settings = Join-Path $Root "settings.yml"
$OutLog = Join-Path $Root "searxng.out.log"
$ErrLog = Join-Path $Root "searxng.err.log"

if (-not (Test-Path $Python)) {
  throw "Python venv introuvable: $Python"
}
if (-not (Test-Path $Settings)) {
  throw "Configuration SearXNG introuvable: $Settings"
}

$existing = Get-NetTCPConnection -LocalPort 8080 -State Listen -ErrorAction SilentlyContinue | Select-Object -First 1
if ($existing) {
  Write-Output "SearXNG semble deja actif sur http://localhost:8080 (pid=$($existing.OwningProcess))"
  exit 0
}

$env:SEARXNG_SETTINGS_PATH = $Settings
$env:PYTHONPATH = $Source
$env:SEARXNG_PORT = "8080"
$env:SEARXNG_BIND_ADDRESS = "127.0.0.1"

Start-Process -FilePath $Python `
  -ArgumentList "-m", "searx.webapp" `
  -WorkingDirectory $Source `
  -WindowStyle Hidden `
  -RedirectStandardOutput $OutLog `
  -RedirectStandardError $ErrLog

for ($i = 0; $i -lt 20; $i++) {
  Start-Sleep -Seconds 1
  $listener = Get-NetTCPConnection -LocalPort 8080 -State Listen -ErrorAction SilentlyContinue | Select-Object -First 1
  if ($listener) { break }
}
if (-not $listener) {
  throw "SearXNG n'a pas demarre. Voir $ErrLog"
}

Write-Output "SearXNG actif: http://localhost:8080 (pid=$($listener.OwningProcess))"
