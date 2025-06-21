# Remove Windows Maps
Write-Output "Entferne Windows Karten-App..."
Get-AppxPackage -AllUsers Microsoft.WindowsMaps | Remove-AppxPackage -AllUsers
Write-Output "Windows Karten-App entfernt."