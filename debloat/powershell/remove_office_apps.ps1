# Remove Office Apps (preinstalled)
Write-Output "Removing pre-installed Office apps..."
Get-AppxPackage -AllUsers Microsoft.MicrosoftOfficeHub | Remove-AppxPackage -AllUsers
Get-AppxPackage -AllUsers Microsoft.Office.OneNote | Remove-AppxPackage -AllUsers
Write-Output "Office apps removed."
