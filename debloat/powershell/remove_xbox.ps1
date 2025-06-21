# Remove Xbox Apps
Write-Output "Entferne Xbox Apps..."
Get-AppxPackage -AllUsers *xbox* | Remove-AppxPackage -AllUsers
Write-Output "Xbox Apps entfernt."