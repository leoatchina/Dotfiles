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
    $hostObjects = [System.Collections.ArrayList]::new()
    $currentHost = ""
    $hostInfo = @{}

    $ProcessHost = {
        param($CH, $HI)
        if ($CH -and $HI.ContainsKey("User")) {
            $hostName = if ($HI.ContainsKey("HostName")) { $HI["HostName"] } else { $CH }
            $port = if ($HI.ContainsKey("Port")) { $HI["Port"] } else { "22" }
            
            $null = $hostObjects.Add([PSCustomObject]@{
                Display = "$CH (User: $($HI['User']), Port: $port)"
                SortKey = $hostName
                Host    = $CH
            })
        }
    }

    Get-Content $sshConfigPath | ForEach-Object {
        $line = $_.Trim()
        if ($line -match "^Host\s+(.+)$") {
            & $ProcessHost $currentHost $hostInfo
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

    # Process the last host in the file
    & $ProcessHost $currentHost $hostInfo

    if ($hostObjects.Count -eq 0) {
        Write-Warning "No SSH hosts found with User configuration"
        return
    }

    # Sort hosts by IP address, then by name
    $sortedHosts = $hostObjects | Sort-Object -Property @{Expression = {
        if ($_.SortKey -match '^(\d{1,3})\.(\d{1,3})\.(\d{1,3})\.(\d{1,3})$') {
            # Pad each octet to 3 digits for correct numeric sorting as a string
            return ('1{0:D3}{1:D3}{2:D3}{3:D3}' -f [int]$matches[1], [int]$matches[2], [int]$matches[3], [int]$matches[4])
        } else {
            # Prefix with '2' to group non-IPs after IPs
            return "2$($_.SortKey)"
        }
    }}

    # Use fzf to select a host, with reversed layout and no sorting (preserve IP order)
    $oldFzfOpts = $env:FZF_DEFAULT_OPTS
    $env:FZF_DEFAULT_OPTS = "--layout=reverse"
    $selected = $sortedHosts.Display | Invoke-Fzf -Prompt "Select SSH host > " -NoSort
    $env:FZF_DEFAULT_OPTS = $oldFzfOpts
    
    if ($selected) {
        # Extract host name from selection
        $hostName = $selected -replace "\s*\(.*$", ""
        # Connect via SSH
        ssh $hostName
    }
}