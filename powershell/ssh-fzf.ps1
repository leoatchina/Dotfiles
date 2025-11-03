# SSH connection function with fzf selection
function Invoke-SshFzf {
    param()
    
    # Check if ssh config file exists
    $sshConfigPath = "$HOME\.ssh\config"
    if (-not (Test-Path $sshConfigPath)) {
        Write-Error "SSH config file not found at $sshConfigPath"
        return
    }
    
    # Parse ssh config to extract hosts with User and Port
    $hosts = @()
    $currentHost = ""
    $hostInfo = @{}
    
    Get-Content $sshConfigPath | ForEach-Object {
        $line = $_.Trim()
        if ($line -match "^Host\s+(.+)$") {
            # Save previous host if it has required info
            if ($currentHost -and $hostInfo.ContainsKey("User")) {
                $port = if ($hostInfo.ContainsKey("Port")) { $hostInfo["Port"] } else { "22" }
                $hosts += "$currentHost (User: $($hostInfo['User']), Port: $port)"
            }
            
            # Start new host
            $currentHost = $matches[1]
            $hostInfo = @{}
        } elseif ($line -match "^User\s+(.+)$") {
            $hostInfo["User"] = $matches[1]
        } elseif ($line -match "^Port\s+(.+)$") {
            $hostInfo["Port"] = $matches[1]
        } elseif ($line -match "^HostName\s+(.+)$") {
            $hostInfo["HostName"] = $matches[1]
        }
    }
    
    # Don't forget the last host
    if ($currentHost -and $hostInfo.ContainsKey("User")) {
        $port = if ($hostInfo.ContainsKey("Port")) { $hostInfo["Port"] } else { "22" }
        $hosts += "$currentHost (User: $($hostInfo['User']), Port: $port)"
    }
    
    if ($hosts.Count -eq 0) {
        Write-Warning "No SSH hosts found with User configuration"
        return
    }
    
    # Use fzf to select a host
    $selected = $hosts | Invoke-Fzf -Prompt "Select SSH host > "
    
    if ($selected) {
        # Extract host name from selection
        $hostName = $selected -replace "\s*\(.*$", ""
        # Connect via SSH
        ssh $hostName
    }
}

# Export the function
Export-ModuleMember -Function Invoke-SshFzf