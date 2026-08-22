@echo off
setlocal

REM Get the directory of the script
set "SCRIPT_DIR=%~dp0"
set "SCRIPT_DIR=%SCRIPT_DIR:~0,-1%"

REM Create zap directory in AppData\Roaming if it doesn't exist
if not exist "%APPDATA%\zap" mkdir "%APPDATA%\zap"

REM Remove existing config.toml in AppData\Roaming\zap if it exists
if exist "%APPDATA%\zap\config.toml" del /F /Q "%APPDATA%\zap\config.toml"

REM Create symbolic link from AppData\Roaming\zap\config.toml to Dotfiles\zap\config.toml
mklink "%APPDATA%\zap\config.toml" "%SCRIPT_DIR%\config.toml"
if errorlevel 1 (
    echo [HINT] Run this cmd as Administrator or enable Developer Mode on Windows.
    exit /b 1
)

echo === zap config linked ===
