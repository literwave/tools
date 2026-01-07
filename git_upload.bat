@echo off
chcp 936 >nul 2>&1
set "PYTHONIOENCODING=gbk"

set "scriptdir=%~dp0"
pushd "%scriptdir%" || exit /b 1

echo ========================================
echo Git Auto Upload Script
echo ========================================
echo.

rem Check if git is available
git --version >nul 2>&1
if errorlevel 1 (
    echo Error: Git is not installed or not in PATH
    pause
    exit /b 1
)

rem Show current git status
echo Current Git Status:
echo ----------------------------------------
git status
echo ----------------------------------------
echo.

rem Add all changes
echo Adding all changes to staging area...
git add .
if errorlevel 1 (
    echo Failed to add changes
    pause
    exit /b 1
)
echo All changes added successfully.
echo.

rem Prompt for commit message
set /p "commit_msg=Please enter commit message (press Enter for default message): "
if "%commit_msg%"=="" (
    rem Generate default commit message with timestamp
    for /f "tokens=1-6 delims=/: " %%a in ("%date% %time%") do (
        set "timestamp=%%a-%%b-%%c %%d:%%e:%%f"
    )
    set "commit_msg=Auto commit at %timestamp%"
)

echo.
echo Committing changes with message: "%commit_msg%"
git commit -m "%commit_msg%"
if errorlevel 1 (
    echo No changes to commit or commit failed
    echo.
    pause
    exit /b 1
)
echo Commit successful.
echo.

rem Ask if user wants to push
set /p "push_confirm=Do you want to push to remote? (Y/N): "
if /i "%push_confirm%"=="Y" (
    echo Pushing to remote repository...
    git push
    if errorlevel 1 (
        echo Push failed. Please check your network connection and permissions.
        pause
        exit /b 1
    )
    echo Push successful!
) else (
    echo Skipped push to remote repository.
)

echo.
echo ========================================
echo Git upload completed successfully!
echo ========================================
popd
pause
