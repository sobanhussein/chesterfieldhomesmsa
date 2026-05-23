$file = Join-Path $PSScriptRoot "index.html"
$uri  = "ftp://ftpupload.net/htdocs/kingpinproperties/index.html"
$user = "if0_41958943"
$pass = "masonops257"

Write-Host ""
Write-Host "============================================" -ForegroundColor Yellow
Write-Host "   KINGPIN PROPERTIES - FTP Deployer" -ForegroundColor Yellow
Write-Host "============================================" -ForegroundColor Yellow
Write-Host ""

if (-not (Test-Path $file)) {
    Write-Host "[ERROR] index.html not found in same folder!" -ForegroundColor Red
    Read-Host "Press Enter to exit"
    exit
}

Write-Host "[1/3] File found: $([math]::Round((Get-Item $file).Length/1KB,1)) KB" -ForegroundColor Cyan
Write-Host "[2/3] Connecting to ftpupload.net ..." -ForegroundColor Cyan

try {
    $ftp = [System.Net.FtpWebRequest]::Create($uri)
    $ftp.Method      = [System.Net.WebRequestMethods+Ftp]::UploadFile
    $ftp.Credentials = New-Object System.Net.NetworkCredential($user, $pass)
    $ftp.UseBinary   = $true
    $ftp.UsePassive  = $true
    $ftp.EnableSsl   = $false

    $bytes = [System.IO.File]::ReadAllBytes($file)
    $ftp.ContentLength = $bytes.Length

    Write-Host "       Uploading $([math]::Round($bytes.Length/1KB,1)) KB ..." -ForegroundColor Cyan

    $stream = $ftp.GetRequestStream()
    $stream.Write($bytes, 0, $bytes.Length)
    $stream.Close()

    $resp = $ftp.GetResponse()
    Write-Host "[3/3] $($resp.StatusDescription)" -ForegroundColor Green
    $resp.Close()

    Write-Host ""
    Write-Host "============================================" -ForegroundColor Yellow
    Write-Host "  SUCCESS! Visit: kingpinproperties.gt.tc" -ForegroundColor Green
    Write-Host "============================================" -ForegroundColor Yellow

} catch {
    Write-Host ""
    Write-Host "[ERROR] $($_.Exception.Message)" -ForegroundColor Red
    Write-Host ""
    Write-Host "Check: password correct? Internet connected?" -ForegroundColor Yellow
}

Write-Host ""
Read-Host "Press Enter to exit"
