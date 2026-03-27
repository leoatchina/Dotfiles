@echo off
setlocal EnableExtensions

for %%I in ("%~dp0.") do set "SRC_DIR=%%~fI"
set "DST_ROOT=C:\Users\leo\AppData\Roaming\Zellij"

call :link_dir "config"
if errorlevel 1 exit /b 1

call :link_dir "layouts"
if errorlevel 1 exit /b 1

echo [OK] All directory links created.
exit /b 0

:link_dir
set "NAME=%~1"
set "SRC_DIR_PATH=%SRC_DIR%\%NAME%"
set "DST_DIR_PATH=%DST_ROOT%\%NAME%"

echo [INFO] Source directory : "%SRC_DIR_PATH%"
echo [INFO] Link destination : "%DST_DIR_PATH%"

if not exist "%SRC_DIR_PATH%\\" (
    echo [ERROR] Source directory does not exist: "%SRC_DIR_PATH%"
    exit /b 1
)

if not exist "%DST_ROOT%\\" (
    mkdir "%DST_ROOT%" >nul 2>nul
    if errorlevel 1 (
        echo [ERROR] Failed to create destination root: "%DST_ROOT%"
        exit /b 1
    )
)

if exist "%DST_DIR_PATH%\\" (
    fsutil reparsepoint query "%DST_DIR_PATH%" >nul 2>nul
    if not errorlevel 1 (
        echo [INFO] Removing existing link: "%DST_DIR_PATH%"
        rmdir "%DST_DIR_PATH%" >nul 2>nul
        if exist "%DST_DIR_PATH%\\" (
            echo [ERROR] Failed to remove existing link: "%DST_DIR_PATH%"
            exit /b 1
        )
    ) else (
        echo [ERROR] Destination directory exists and is not a link: "%DST_DIR_PATH%"
        echo [ERROR] Move or remove it manually, then rerun.
        exit /b 1
    )
) else (
    if exist "%DST_DIR_PATH%" (
        echo [ERROR] Destination path exists but is not a directory: "%DST_DIR_PATH%"
        exit /b 1
    )
)

mklink /d "%DST_DIR_PATH%" "%SRC_DIR_PATH%" >nul
if errorlevel 1 (
    echo [ERROR] mklink /d failed for "%NAME%".
    echo [HINT] Run this cmd as Administrator or enable Developer Mode on Windows.
    exit /b 1
)

echo [OK] Link created: "%DST_DIR_PATH%" ^> "%SRC_DIR_PATH%"
exit /b 0
