@echo off
setlocal

REM Get the directory of the script
set "SCRIPT_DIR=%~dp0"
set "SCRIPT_DIR=%SCRIPT_DIR:~0,-1%"

REM Create .pi\agent directory if it doesn't exist
if not exist "%USERPROFILE%\.pi\agent" mkdir "%USERPROFILE%\.pi\agent"

REM Remove existing keybindings.json if it exists
if exist "%USERPROFILE%\.pi\agent\keybindings.json" del /F /Q "%USERPROFILE%\.pi\agent\keybindings.json"

REM Create symbolic link from .pi\agent\keybindings.json to Dotfiles\pi\agent\keybindings.json
mklink "%USERPROFILE%\.pi\agent\keybindings.json" "%SCRIPT_DIR%\agent\keybindings.json"
if errorlevel 1 (
    echo [HINT] Run this cmd as Administrator or enable Developer Mode on Windows.
    exit /b 1
)

REM pi-plan-mode.json MUST be a real file: the extension opens it with
REM O_NOFOLLOW and rejects symlinks. Copy instead of linking.
if exist "%USERPROFILE%\.pi\agent\pi-plan-mode.json" del /F /Q "%USERPROFILE%\.pi\agent\pi-plan-mode.json"
copy /Y "%SCRIPT_DIR%\agent\pi-plan-mode.json" "%USERPROFILE%\.pi\agent\pi-plan-mode.json" >nul
if errorlevel 1 (
    echo [ERROR] Failed to copy pi-plan-mode.json
    exit /b 1
)

REM permission-mode.json (symlink ok - plain read/write)
if not exist "%USERPROFILE%\.pi\agent\permission-mode" mkdir "%USERPROFILE%\.pi\agent\permission-mode"
if exist "%USERPROFILE%\.pi\agent\permission-mode\permission-mode.json" del /F /Q "%USERPROFILE%\.pi\agent\permission-mode\permission-mode.json"
mklink "%USERPROFILE%\.pi\agent\permission-mode\permission-mode.json" "%SCRIPT_DIR%\agent\permission-mode.win.json"
if errorlevel 1 (
    echo [HINT] Run this cmd as Administrator or enable Developer Mode on Windows.
    exit /b 1
)

REM pi-lens config (symlink ok)
if not exist "%USERPROFILE%\.pi-lens" mkdir "%USERPROFILE%\.pi-lens"
if exist "%USERPROFILE%\.pi-lens\config.json" del /F /Q "%USERPROFILE%\.pi-lens\config.json"
mklink "%USERPROFILE%\.pi-lens\config.json" "%SCRIPT_DIR%\pi-lens\config.json"
if errorlevel 1 (
    echo [HINT] Run this cmd as Administrator or enable Developer Mode on Windows.
    exit /b 1
)

echo === pi keybindings linked ===
echo === pi plan-mode settings copied (O_NOFOLLOW: real file) ===
echo === pi permission-mode linked ===
echo === pi-lens config linked ===
