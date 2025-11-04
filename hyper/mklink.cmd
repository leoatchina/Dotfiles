@echo off
setlocal

REM Get the directory of the script
set "SCRIPT_DIR=%~dp0"
set "SCRIPT_DIR=%SCRIPT_DIR:~0,-1%"

REM Create Hyper directory in AppData\Roaming if it doesn't exist
if not exist "%APPDATA%\Hyper" mkdir "%APPDATA%\Hyper"

REM Remove existing .hyper.js file in AppData\Roaming\Hyper if it exists
if exist "%APPDATA%\Hyper\.hyper.js" del "%APPDATA%\Hyper\.hyper.js"

REM Create symbolic link from AppData\Roaming\Hyper\.hyper.js to Dotfiles\hyper\.hyper.js
mklink /H "%APPDATA%\Hyper\.hyper.js" "%SCRIPT_DIR%\hyper.js"

pause