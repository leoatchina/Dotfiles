@echo off
setlocal EnableExtensions

for %%I in ("%~dp0.") do set "SRC_DIR=%%~fI"
set "SRC_FILE=%SRC_DIR%\config.kdl"
set "DST_DIR=%APPDATA%\Zellij\config"
set "DST_FILE=%DST_DIR%\config.kdl"

echo [INFO] Source file      : "%SRC_FILE%"
echo [INFO] Link destination : "%DST_FILE%"

if not exist "%SRC_FILE%" (
    echo [ERROR] Source file does not exist: "%SRC_FILE%"
    exit /b 1
)

if exist "%DST_DIR%\\" (
    fsutil reparsepoint query "%DST_DIR%" >nul 2>nul
    if not errorlevel 1 (
        echo [ERROR] Destination directory is a link, not a normal directory: "%DST_DIR%"
        echo [ERROR] Remove it manually first, then rerun.
        exit /b 1
    )
) else (
    if exist "%DST_DIR%" (
        echo [ERROR] Destination path exists but is not a directory: "%DST_DIR%"
        exit /b 1
    )
    mkdir "%DST_DIR%" >nul 2>nul
    if errorlevel 1 (
        echo [ERROR] Failed to create destination directory: "%DST_DIR%"
        exit /b 1
    )
)

echo [INFO] Removing existing destination file (if any): "%DST_FILE%"
del /f /q "%DST_FILE%" >nul 2>nul
if exist "%DST_FILE%" (
    echo [ERROR] Failed to remove destination file: "%DST_FILE%"
    exit /b 1
)

mklink "%DST_FILE%" "%SRC_FILE%" >nul
if errorlevel 1 (
    echo [ERROR] mklink failed.
    echo [HINT] Run this cmd as Administrator or enable Developer Mode on Windows.
    exit /b 1
)

echo [OK] Link created:
echo      "%DST_FILE%" ^> "%SRC_FILE%"
exit /b 0
