# Remove 3D Viewer
Write-Output "Entferne 3D Viewer..."
Get-AppxPackage -AllUsers Microsoft.Microsoft3DViewer | Remove-AppxPackage -AllUsers
Write-Output "3D Viewer entfernt."