# PowerShell Script to Uninstall SQL Server Management Studio 2014

# Function to find the uninstall string in the registry
function Find-UninstallString {
    param (
        [string]$DisplayName
    )
    $uninstallKeys = Get-ChildItem -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall', 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall'
    
    foreach ($key in $uninstallKeys) {
        $keyInfo = Get-ItemProperty -Path $key.PSPath
        if ($keyInfo.DisplayName -eq $DisplayName) {
            return $keyInfo.UninstallString
        }
    }
}

# Main function
function Uninstall-SSMS2014 {
    $ssmsDisplayName = "Microsoft SQL Server Management Studio 12"
    $uninstallString = Find-UninstallString -DisplayName $ssmsDisplayName

    if ($uninstallString) {
        Write-Host "Uninstalling SQL Server Management Studio 2014..."
        $uninstallCommand = $uninstallString -Replace "msiexec.exe", "msiexec.exe /passive /norestart"
        Start-Process -FilePath "cmd.exe" -ArgumentList "/c $uninstallCommand" -Wait
        Write-Host "SQL Server Management Studio 2014 has been uninstalled."
    } else {
        Write-Host "SQL Server Management Studio 2014 not found. Please make sure it is installed."
    }
}

# Execute the script Uninstall-SSMS2014.ps1 directly from powershell