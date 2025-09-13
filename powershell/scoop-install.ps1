Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
$env:SCOOP='D:\Scoop' 
[Environment]::SetEnvironmentVariable('USERSCOOP', $env:SCOOP, 'User')
Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression