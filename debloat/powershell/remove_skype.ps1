# Remove Skype
Write-Output "Entferne Skype..."
Get-AppxPackage -AllUsers Microsoft.SkypeApp | Remove-AppxPackage -AllUsers
Write-Output "Skype entfernt."