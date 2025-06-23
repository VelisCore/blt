# Remove Xbox Apps
Write-Output "Removing Xbox Apps..."
Get-AppxPackage -AllUsers *xbox* | Remove-AppxPackage -AllUsers
Write-Output "Xbox Apps removed."