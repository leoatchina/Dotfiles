# Create symbolic link for PowerShell profile
$source = "$PSScriptRoot\Microsoft.PowerShell_profile.ps1"
$destination = "$HOME\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1"

# Remove existing file or symlink if it exists
if (Test-Path $destination) {
    Remove-Item $destination -Force
}

# Create symbolic link
New-Item -ItemType SymbolicLink -Path $destination -Target $source

Write-Host "PowerShell profile linked successfully!" -ForegroundColor Green