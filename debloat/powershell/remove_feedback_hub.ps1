# Remove Feedback Hub
Write-Output "Removing Feedback Hub..."
Get-AppxPackage -AllUsers Microsoft.WindowsFeedbackHub | Remove-AppxPackage -AllUsers
Write-Output "Feedback Hub removed."
