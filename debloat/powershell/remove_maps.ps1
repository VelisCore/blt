# Remove Windows Maps
Write-Output "Removing Windows Maps app..."
Get-AppxPackage -AllUsers Microsoft.WindowsMaps | Remove-AppxPackage -AllUsers
Write-Output "Windows Maps app removed."
