@echo off
setlocal

REM Get the directory of the script
set "SCRIPT_DIR=%~dp0"
set "SCRIPT_DIR=%SCRIPT_DIR:~0,-1%"

REM Create .config directory if it doesn't exist
if not exist "%USERPROFILE%\.config" mkdir "%USERPROFILE%\.config"

REM Remove existing wezterm directory in .config if it exists
if exist "%USERPROFILE%\.config\wezterm" rmdir "%USERPROFILE%\.config\wezterm"

REM Create junction link from .config\wezterm to Dotfiles\wezterm
mklink /j "%USERPROFILE%\.config\wezterm" "%SCRIPT_DIR%"

pause