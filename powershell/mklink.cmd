@echo off
setlocal EnableDelayedExpansion

rem Source in current script directory
set "SCRIPT_DIR=%~dp0"
set "SCRIPT_DIR=%SCRIPT_DIR:~0,-1%"

set "source=%SCRIPT_DIR%\Microsoft.PowerShell_profile.ps1"

for %%D in ("%USERPROFILE%\Documents\WindowsPowerShell" "%USERPROFILE%\Documents\PowerShell") do (
  set "targetDir=%%~D"
  set "dest=%%~D\Microsoft.PowerShell_profile.ps1"

  rem Ensure destination directory exists
  if not exist "!targetDir!" mkdir "!targetDir!"

  rem Remove existing file or directory at destination
  if exist "!dest!\NUL" (
    rmdir /S /Q "!dest!"
  ) else if exist "!dest!" (
    del /F /Q "!dest!"
  )

  rem Create symbolic link (file)
  mklink "!dest!" "%source%"
  echo Created symbolic link: "!dest!" -> "%source%"
)

