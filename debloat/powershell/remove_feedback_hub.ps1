# Remove Feedback Hub
Write-Output "Entferne Feedback Hub..."
Get-AppxPackage -AllUsers Microsoft.WindowsFeedbackHub | Remove-AppxPackage -AllUsers
Write-Output "Feedback Hub entfernt."