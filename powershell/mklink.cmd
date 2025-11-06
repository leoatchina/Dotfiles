@echo off
setlocal EnableDelayedExpansion

rem Get absolute path of source file (PowerShell profile in Dotfiles)
set "SCRIPT_DIR=%~dp0"
set "SCRIPT_DIR=%SCRIPT_DIR:~0,-1%"
for %%I in ("%SCRIPT_DIR%") do set "SOURCE_DIR=%%~fI"
set "source=%SOURCE_DIR%\Microsoft.PowerShell_profile.ps1"

rem Check if source file exists
if not exist "%source%" (
    echo Error: Source file not found: %source%
    exit /b 1
)

rem Create symbolic links in PowerShell profile directories
for %%D in ("%USERPROFILE%\Documents\WindowsPowerShell" "%USERPROFILE%\Documents\PowerShell") do (
  set "targetDir=%%~D"
  set "dest=%%~D\Microsoft.PowerShell_profile.ps1"

  rem Ensure destination directory exists
  if not exist "!targetDir!" mkdir "!targetDir!"

  rem Remove existing file or directory at destination
  if exist "!dest!" (
    if exist "!dest!\NUL" (
      rmdir /S /Q "!dest!"
    ) else (
      del /F /Q "!dest!"
    )
  )

  rem Create symbolic link: link at dest points to source
  rem Syntax: mklink link_path target_path
  mklink "!dest!" "%source%"
  if !errorlevel! equ 0 (
    echo Created symbolic link: "!dest!" -^> "%source%"
  ) else (
    echo Failed to create symbolic link: "!dest!"
  )
)

