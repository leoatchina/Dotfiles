
Set-Alias touch ni
# windows 默认支持 start 命令
Set-Alias open explorer.exe
Set-Alias ll ls
Set-Alias grep findstr

# modules
Import-Module posh-git
Import-Module Terminal-Icons
Import-Module scoop-completion
oh-my-posh init pwsh | Invoke-Expression


# PSReadLine
Import-Module PSReadLine
Set-PSReadLineOption -EditMode Emacs
Set-PSReadLineOption -BellStyle None
Set-PSReadLineKeyHandler -Chord 'Ctrl+d' -Function DeleteChar

# Only set PredictionSource if PSReadLine version supports it (2.2.0+)
if ($PSVersionTable.PSVersion.Major -ge 7 -or 
    (Get-Module PSReadLine).Version -ge [Version]"2.2.0") {
    Set-PSReadLineOption -PredictionSource History
}
# fzf
Import-Module PSFzf
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'
# Utilities
function which ($command) {
    Get-Command -Name $command -ErrorAction SilentlyContinue |
      Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
  }