@echo off
title CHESTERFIELD HOMES - Vercel Deploy
color 0A
echo.
echo ============================================
echo   CHESTERFIELD HOMES - Vercel Deployer
echo ============================================
echo.

REM --- Check index.html exists ---
if not exist "%~dp0index.html" (
    color 0C
    echo [ERROR] index.html not found in same folder!
    pause
    exit /b
)

echo [1/3] Checking Vercel installation...
where vercel >nul 2>&1
if %errorlevel% neq 0 (
    echo Vercel not found. Installing now...
    npm install -g vercel
)

echo [2/3] Deploying to Vercel...
echo.
cd /d "%~dp0"
vercel --prod --yes

echo.
echo ============================================
echo  Done! Check your live URL above.
echo ============================================
echo.
pause
