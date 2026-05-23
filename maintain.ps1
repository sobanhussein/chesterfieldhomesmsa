# maintain.ps1 - The Heartbeat
Write-Host "Self-Maintenance: Sanitizing and Deploying..." -ForegroundColor Yellow

# 1. Force lowercase for all files (prevents 404s)
Get-ChildItem -Recurse | Rename-Item -NewName { $_.Name.ToLower() } -ErrorAction SilentlyContinue

# 2. Push to cloud
git push origin main

Write-Host "Heartbeat Sync Complete: Your site is now updating." -ForegroundColor Green