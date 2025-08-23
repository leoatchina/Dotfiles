Set-ExecutionPolicy RemoteSigned -scope CurrentUser
# powershell 安装依赖的方式 Install-Module，也可使用 Scoop 安装
Install-Module posh-git -Scope CurrentUser -AllowClobber -Force
Install-Module -Name Terminal-Icons -Repository PSGallery -Scope CurrentUser -AllowClobber -Force
Install-Module -Name z -Scope CurrentUser -AllowClobber -Force
Install-Module -Name PSReadLine -Scope CurrentUser -AllowClobber -Force
Install-Module -Name PSFzf -Scope CurrentUser -AllowClobber -Force