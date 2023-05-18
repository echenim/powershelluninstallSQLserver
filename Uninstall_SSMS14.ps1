# Function to find SSMS 2014 product GUID
function Find-SSMS2014GUID {
    $ssms2014Product = Get-WmiObject -Class Win32_Product | Where-Object { $_.Name -eq "Microsoft SQL Server 2014 Management Studio" }
    if ($ssms2014Product) {
        return $ssms2014Product.IdentifyingNumber
    }
    else {
        return $null
    }
}

# Main script
$ssms2014GUID = Find-SSMS2014GUID

if ($ssms2014GUID) {
    Write-Host "Uninstalling SQL Server Management Studio 2014..."
    $uninstallCommand = "msiexec.exe /x " + $ssms2014GUID + " /qn /norestart"
    Start-Process -FilePath "cmd.exe" -ArgumentList "/c $uninstallCommand" -Wait -NoNewWindow
    Write-Host "SQL Server Management Studio 2014 uninstalled successfully."
} else {
    Write-Host "SQL Server Management Studio 2014 not found."
}

# Execute the script Uninstall_SSMS14.ps1 directly from powershell