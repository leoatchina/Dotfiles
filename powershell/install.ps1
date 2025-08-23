Set-ExecutionPolicy RemoteSigned -scope CurrentUser
winget install -e --id Git.Git
# powershell 安装依赖的方式 Install-Module，也可使用 Scoop 安装
Install-Module oh-my-posh -Scope CurrentUser -Force
Install-Module posh-git -Scope CurrentUser -Force
Install-Module -Name Terminal-Icons -Repository PSGallery -Scope CurrentUser -Force
Install-Module -Name z -Force -Scope CurrentUser
Install-Module -Name PSReadLine -AllowPrerelease -Scope CurrentUser -Force -SkipPublishercheck
Install-Module -Name PSFzf -Scope CurrentUser -Force 