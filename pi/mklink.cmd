@echo off
setlocal

REM Get the directory of the script
set "SCRIPT_DIR=%~dp0"
set "SCRIPT_DIR=%SCRIPT_DIR:~0,-1}"

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

REM Remove existing pi-plan-mode.json if it exists
if exist "%USERPROFILE%\.pi\agent\pi-plan-mode.json" del /F /Q "%USERPROFILE%\.pi\agent\pi-plan-mode.json"

REM Create symbolic link for pi-plan-mode.json
mklink "%USERPROFILE%\.pi\agent\pi-plan-mode.json" "%SCRIPT_DIR%\agent\pi-plan-mode.json"
if errorlevel 1 (
    echo [HINT] Run this cmd as Administrator or enable Developer Mode on Windows.
    exit /b 1
)


echo === pi keybindings linked ===
echo === pi plan-mode settings linked ===
