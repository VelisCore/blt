# Remove Skype
Write-Output "Removing Skype..."
Get-AppxPackage -AllUsers Microsoft.SkypeApp | Remove-AppxPackage -AllUsers
Write-Output "Skype removed."
