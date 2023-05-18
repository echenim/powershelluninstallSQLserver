# Define the application name
$appName = "SQL Server Management Studio 2014"

# Get the product code of the application
$installer = New-Object -ComObject WindowsInstaller.Installer
$productCode = $null
for ($i = 0; $i -lt $installer.Products.Count; $i++) {
    $product = $installer.Products.Item($i)
    if ($installer.ProductInfo($product, "ProductName") -eq $appName) {
        $productCode = $product
        break
    }
}

# Uninstall the application if the product code is found
if ($productCode) {
    Write-Host "Uninstalling $appName..."
    $arguments = "/x $productCode /qn /norestart /L*v log.txt"
    $process = Start-Process "msiexec.exe" -ArgumentList $arguments -Wait -NoNewWindow -PassThru
    if ($process.ExitCode -eq 0) {
        Write-Host "$appName successfully uninstalled."
    } else {
        Write-Host "An error occurred while uninstalling $appName. Exit code: $($process.ExitCode)"
    }
} else {
    Write-Host "$appName not found. Please ensure it is installed."
}
