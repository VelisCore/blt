# Remove Cortana (Windows 10 2004+ only disables)
Write-Output "Deactivating Cortana..."
Get-AppxPackage -AllUsers Microsoft.549981C3F5F10 | Remove-AppxPackage -AllUsers
Write-Output "Cortana removed/deativated."