@echo off
setlocal

REM Get the directory of the script
set "SCRIPT_DIR=%~dp0"
set "SCRIPT_DIR=%SCRIPT_DIR:~0,-1%"

REM Create herdr directory in AppData\Roaming if it doesn't exist
if not exist "%APPDATA%\herdr" mkdir "%APPDATA%\herdr"

REM Remove existing config.toml in AppData\Roaming\herdr if it exists
if exist "%APPDATA%\herdr\config.toml" del /F /Q "%APPDATA%\herdr\config.toml"

REM Create symbolic link from AppData\Roaming\herdr\config.toml to Dotfiles\herdr\config.toml
mklink "%APPDATA%\herdr\config.toml" "%SCRIPT_DIR%\config.toml"
if errorlevel 1 (
    echo [HINT] Run this cmd as Administrator or enable Developer Mode on Windows.
    exit /b 1
)

echo === herdr config linked ===
