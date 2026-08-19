@echo off
setlocal

REM Get the directory of the script
set "SCRIPT_DIR=%~dp0"
set "SCRIPT_DIR=%SCRIPT_DIR:~0,-1%"

REM Determine target directory (%USERPROFILE%\.omp\agent or %HOME%\.omp\agent)
if defined USERPROFILE (
    set "TARGET_DIR=%USERPROFILE%\.omp\agent"
) else (
    set "TARGET_DIR=%HOME%\.omp\agent"
)

REM Create target directory if it doesn't exist
if not exist "%TARGET_DIR%" mkdir "%TARGET_DIR%"

REM Remove existing keybindings.yml in target directory if it exists
if exist "%TARGET_DIR%\keybindings.yml" del /F /Q "%TARGET_DIR%\keybindings.yml"

REM Create symbolic link for keybindings.yml
mklink "%TARGET_DIR%\keybindings.yml" "%SCRIPT_DIR%\agent\keybindings.yml"
if errorlevel 1 (
    echo [HINT] Run this cmd as Administrator or enable Developer Mode on Windows.
    exit /b 1
)
echo === omp keybindings linked ===

REM Copy config.yml if it doesn't exist in target directory
if not exist "%TARGET_DIR%\config.yml" (
    copy "%SCRIPT_DIR%\agent\config.yml" "%TARGET_DIR%\config.yml" >nul
    echo === omp config copied ===
)
