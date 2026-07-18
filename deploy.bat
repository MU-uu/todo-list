@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

cd /d "%~dp0"

echo ========================================
echo   Todo List - One-click Deploy
echo ========================================
echo.

REM Check git
where git >nul 2>&1
if errorlevel 1 (
    echo [ERROR] git not found. Install from https://git-scm.com
    pause
    exit /b 1
)

REM Check gh
where gh >nul 2>&1
if errorlevel 1 (
    echo [ERROR] GitHub CLI (gh) not found. Install from https://cli.github.com
    pause
    exit /b 1
)

REM Check git status
git status >nul 2>&1
if errorlevel 1 (
    echo [ERROR] Not a git repo. Run: git init
    pause
    exit /b 1
)

REM Check for changes
git diff --quiet
set HAS_STAGED=%errorlevel%
git diff --cached --quiet
set HAS_UNSTAGED=%errorlevel%

if %HAS_STAGED% equ 0 if %HAS_UNSTAGED% equ 0 (
    echo [INFO] No changes to commit.
    pause
    exit /b 0
)

echo Changes detected. Committing...
echo.

REM Ask for commit message
set MSG=
set /p MSG="Commit message (press Enter for default): "
if "%MSG%"=="" set MSG=update: auto deploy at %date% %time%

REM Stage and commit
git add .
git commit -m "%MSG%"
if errorlevel 1 (
    echo [ERROR] git commit failed.
    pause
    exit /b 1
)

REM Get gh token and push
echo.
echo Pushing to GitHub...
for /f "delims=" %%i in ('gh auth token 2^>nul') do set TOKEN=%%i

if "%TOKEN%"=="" (
    echo [ERROR] gh not logged in. Run: gh auth login
    pause
    exit /b 1
)

git push https://MU-uu:%TOKEN%@github.com/MU-uu/todo-list.git main
if errorlevel 1 (
    echo [ERROR] git push failed.
    pause
    exit /b 1
)

echo.
echo ========================================
echo   Done! Netlify will deploy in 30s.
echo   URL: https://mu-todo-list.netlify.app
echo ========================================
echo.
pause
