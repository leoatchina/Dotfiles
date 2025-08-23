
Set-Alias touch ni
# windows 默认支持 start 命令
Set-Alias open explorer.exe
Set-Alias ll ls
Set-Alias grep findstr

# modules
Import-Module posh-git
Import-Module Terminal-Icons
Import-Module scoop-completion

# Check PSReadLine version compatibility before initializing oh-my-posh
$psReadLineVersion = (Get-Module PSReadLine).Version
$requiredVersion = [Version]"2.2.0"

if ($psReadLineVersion -ge $requiredVersion) {
    # Initialize oh-my-posh with default theme
    $env:POSH_THEME = if ($env:POSH_THEME) { $env:POSH_THEME } else { "$env:POSH_THEMES_PATH\atomic.omp.json" }
    try {
        oh-my-posh init pwsh --config $env:POSH_THEME | Invoke-Expression
    } catch {
        Write-Warning "Failed to initialize oh-my-posh: $($_.Exception.Message)"
        Write-Host "Please update PSReadLine: Install-Module PSReadLine -Force -AllowPrerelease" -ForegroundColor Yellow
    }
} else {
    Write-Warning "PSReadLine version $psReadLineVersion is too old for oh-my-posh. Required: $requiredVersion or higher."
    Write-Host "Please update PSReadLine: Install-Module PSReadLine -Force -AllowPrerelease" -ForegroundColor Yellow
    Write-Host "Current session will use basic prompt." -ForegroundColor Cyan
}


# PSReadLine
Import-Module PSReadLine

Set-PSReadLineKeyHandler -Chord 'Ctrl+d' -Function DeleteChar

# Basic PSReadLine options (compatible with all versions)
Set-PSReadLineOption -EditMode Emacs `
                     -BellStyle None `
                     -ShowToolTips `
                     -HistoryNoDuplicates `
                     -Colors @{ # 设置不同元素的颜色，如命令、参数、运算符、变量、字符串、数字、成员、类型、函数和默认颜色
                        Command = 'Cyan'
                        Parameter = 'Yellow'
                        Operator = 'Red'
                        Variable = 'Green'
                        String = 'Magenta'
                        Number = 'White'
                        Member = 'DarkYellow'
                        Type = 'DarkCyan'
                        Function = 'Blue'
                        Default = 'Gray'
                     }

# Only set PredictionSource and PredictionViewStyle if PSReadLine version supports it (2.2.0+)
if ($PSVersionTable.PSVersion.Major -ge 7 -or 
    (Get-Module PSReadLine).Version -ge [Version]"2.2.0") {
    Set-PSReadLineOption -PredictionSource History -PredictionViewStyle ListView
}
# fzf
Import-Module PSFzf
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r' -FzfOptions '--reverse'
# Utilities
function which ($command) {
    Get-Command -Name $command -ErrorAction SilentlyContinue |
      Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
}

# Oh-My-Posh theme management functions
function Set-PoshTheme {
    param(
        [Parameter(Mandatory=$true)]
        [string]$ThemeName
    )
    
    $themePath = "$env:POSH_THEMES_PATH\$ThemeName.omp.json"
    
    if (Test-Path $themePath) {
        $env:POSH_THEME = $themePath
        oh-my-posh init pwsh --config $env:POSH_THEME | Invoke-Expression
        Write-Host "已切换到主题: $ThemeName" -ForegroundColor Green
    } else {
        Write-Host "主题文件不存在: $themePath" -ForegroundColor Red
        Write-Host "可用主题:" -ForegroundColor Yellow
        Get-ChildItem "$env:POSH_THEMES_PATH\*.omp.json" | ForEach-Object { 
            Write-Host "  $($_.BaseName)" -ForegroundColor Cyan
        }
    }
}

function Get-PoshThemes {
    Write-Host "可用的 Oh-My-Posh 主题:" -ForegroundColor Yellow
    Get-ChildItem "$env:POSH_THEMES_PATH\*.omp.json" | ForEach-Object { 
        $name = $_.BaseName
        if ($env:POSH_THEME -and $env:POSH_THEME.Contains($name)) {
            Write-Host "  $name (当前使用)" -ForegroundColor Green
        } else {
            Write-Host "  $name" -ForegroundColor Cyan
        }
    }
}

# 别名
Set-Alias themes Get-PoshThemes
Set-Alias theme Set-PoshTheme