# Remove Office Apps (preinstalled)
Write-Output "Entferne vorinstallierte Office-Apps..."
Get-AppxPackage -AllUsers Microsoft.MicrosoftOfficeHub | Remove-AppxPackage -AllUsers
Get-AppxPackage -AllUsers Microsoft.Office.OneNote | Remove-AppxPackage -AllUsers
Write-Output "Office Apps entfernt."