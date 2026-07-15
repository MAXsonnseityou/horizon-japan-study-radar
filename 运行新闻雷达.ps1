param(
    [int]$Hours = 48
)

$ErrorActionPreference = "Stop"
$ProjectRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $ProjectRoot

$HorizonExe = Join-Path $ProjectRoot ".venv\Scripts\horizon.exe"
$EnvFile = Join-Path $ProjectRoot ".env"

if (-not (Test-Path -LiteralPath $HorizonExe)) {
    Write-Host "Horizon 尚未安装，请先在项目目录安装依赖。" -ForegroundColor Red
    exit 1
}

if (-not (Test-Path -LiteralPath $EnvFile)) {
    Write-Host "缺少 .env 文件。" -ForegroundColor Red
    exit 1
}

$KeyLine = Get-Content -LiteralPath $EnvFile -Encoding UTF8 |
    Where-Object { $_ -match '^DEEPSEEK_API_KEY=' } |
    Select-Object -First 1

if (-not $KeyLine -or $KeyLine -eq 'DEEPSEEK_API_KEY=') {
    Write-Host "请先在 .env 文件中填写 DEEPSEEK_API_KEY。" -ForegroundColor Yellow
    exit 1
}

& $HorizonExe --hours $Hours
exit $LASTEXITCODE
