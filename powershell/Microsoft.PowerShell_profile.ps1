Set-Alias -Name vim -Value nvim
Set-Alias touch ni
# windows 默认支持 start 命令
Set-Alias open explorer.exe
Set-Alias ll ls
Set-Alias grep findstr

# modules
Import-Module posh-git
Import-Module Terminal-Icons
Import-Module scoop-completion
Import-Module PSReadLine
oh-my-posh init pwsh | Invoke-Expression