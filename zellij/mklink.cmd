@echo off
setlocal EnableExtensions

for %%I in ("%~dp0.") do set "SRC=%%~fI"
set "DST=%APPDATA%\Zellij\config"
set "PARENT=%APPDATA%\Zellij"

echo [INFO] Source directory : "%SRC%"
echo [INFO] Link destination : "%DST%"

if not exist "%PARENT%" (
    mkdir "%PARENT%"
    if errorlevel 1 (
        echo [ERROR] Failed to create parent directory: "%PARENT%"
        exit /b 1
    )
)

if exist "%DST%" (
    echo [INFO] Removing existing destination: "%DST%"
    rmdir "%DST%" >nul 2>nul
    if exist "%DST%" (
        rmdir /s /q "%DST%" >nul 2>nul
    )
    if exist "%DST%" (
        echo [ERROR] Failed to remove destination: "%DST%"
        exit /b 1
    )
)

mklink /D "%DST%" "%SRC%" >nul
if errorlevel 1 (
    echo [ERROR] mklink failed.
    echo [HINT] Run this cmd as Administrator or enable Developer Mode on Windows.
    exit /b 1
)

echo [OK] Link created:
echo      "%DST%" ^> "%SRC%"
exit /b 0
