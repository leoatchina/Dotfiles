@echo off
setlocal

rem Source in current script directory
set "SCRIPT_DIR=%~dp0"
set "SCRIPT_DIR=%SCRIPT_DIR:~0,-1%"

set "source=%SCRIPT_DIR%\Microsoft.PowerShell_profile.ps1"

rem Destination under user Documents\PowerShell
set "targetDir=%USERPROFILE%\Documents\WindowsPowerShell"
set "dest=%targetDir%\Microsoft.PowerShell_profile.ps1"

rem Ensure destination directory exists
if not exist "%targetDir%" mkdir "%targetDir%"

rem Remove existing file or directory at destination
if exist "%dest%\NUL" (
  rmdir /S /Q "%dest%"
) else if exist "%dest%" (
  del /F /Q "%dest%"
)

rem Create symbolic link (file)
mklink "%dest%" "%source%"
if errorlevel 1 (
  echo Failed to create symbolic link. Try running as Administrator or enabling Developer Mode.
  exit /b 1
) else (
  echo PowerShell profile linked successfully!
)
