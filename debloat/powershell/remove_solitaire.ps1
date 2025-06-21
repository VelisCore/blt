# Remove Solitaire Collection
Write-Output "Entferne Solitaire Collection..."
Get-AppxPackage -AllUsers Microsoft.MicrosoftSolitaireCollection | Remove-AppxPackage -AllUsers
Write-Output "Solitaire Collection entfernt."