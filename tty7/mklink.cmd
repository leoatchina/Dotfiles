@echo off
setlocal

REM Get the directory of the script
set "SCRIPT_DIR=%~dp0"
set "SCRIPT_DIR=%SCRIPT_DIR:~0,-1%"

REM Create tty7 directory in AppData\Roaming if it doesn't exist
if not exist "%APPDATA%\tty7" mkdir "%APPDATA%\tty7"

REM Remove existing config.json in AppData\Roaming\tty7 if it exists
if exist "%APPDATA%\tty7\config.json" del /F /Q "%APPDATA%\tty7\config.json"

REM Create symbolic link from AppData\Roaming\tty7\config.json to Dotfiles\tty7\config.json
mklink "%APPDATA%\tty7\config.json" "%SCRIPT_DIR%\config.json"
if errorlevel 1 (
    echo [HINT] Run this cmd as Administrator or enable Developer Mode on Windows.
    exit /b 1
)

echo === tty7 config linked ===
