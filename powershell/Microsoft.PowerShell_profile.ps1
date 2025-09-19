
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
oh-my-posh init pwsh --config "amro" | Invoke-Expression



# PSReadLine
Import-Module PSReadLine

Set-PSReadLineKeyHandler -Chord 'Ctrl+d' -Function DeleteChar
Set-PSReadLineOption -EditMode Emacs -BellStyle None -HistoryNoDuplicates -ShowToolTips
Set-PSReadLineOption -Colors @{
                        Command = 'Cyan'
                        Parameter = 'Yellow'
                        Operator = 'Red'
                        Variable = 'Green'
                        String = 'Magenta'
                        Number = 'White'
                        Member = 'DarkYellow'
                        Type = 'DarkCyan'
                        Default = 'Gray'
                     }

# Only set PredictionSource if PSReadLine version supports it (2.2.0+)
if ($PSVersionTable.PSVersion.Major -ge 7 -or 
    (Get-Module PSReadLine).Version -ge [Version]"2.2.0") {
    Set-PSReadLineOption -PredictionSource History -PredictionViewStyle ListView
}
# fzf
Import-Module PSFzf
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'
# Utilities
function which ($command) {
    Get-Command -Name $command -ErrorAction SilentlyContinue |
      Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
  }