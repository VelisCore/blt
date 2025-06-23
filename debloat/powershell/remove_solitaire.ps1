# Remove Solitaire Collection
Write-Output "Removing Solitaire Collection..."
Get-AppxPackage -AllUsers Microsoft.MicrosoftSolitaireCollection | Remove-AppxPackage -AllUsers
Write-Output "Solitaire Collection removed."
