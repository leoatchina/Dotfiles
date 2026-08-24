@echo off
setlocal

REM Get the directory of the script
set "SCRIPT_DIR=%~dp0"
set "SCRIPT_DIR=%SCRIPT_DIR:~0,-1%"

REM Create Zap config directory in LocalAppData if it doesn't exist
if not exist "%LOCALAPPDATA%\zap\Zap\config" mkdir "%LOCALAPPDATA%\zap\Zap\config"

REM Remove existing keybindings.yaml in LocalAppData\zap\Zap\config if it exists
if exist "%LOCALAPPDATA%\zap\Zap\config\keybindings.yaml" del /F /Q "%LOCALAPPDATA%\zap\Zap\config\keybindings.yaml"

REM Create symbolic link from LocalAppData\zap\Zap\config\keybindings.yaml to Dotfiles\zap\keybindings.yaml
mklink "%LOCALAPPDATA%\zap\Zap\config\keybindings.yaml" "%SCRIPT_DIR%\keybindings.yaml"
if errorlevel 1 (
    echo [HINT] Run this cmd as Administrator or enable Developer Mode on Windows.
    exit /b 1
)

echo === zap keybindings linked ===
