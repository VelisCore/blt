# Remove News & Interests (Taskbar widget)
Write-Output "Deactivating News & Interests..."
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Feeds" /v "ShellFeedsTaskbarViewMode" /t REG_DWORD /d 2 /f
Write-Output "News & Interests deactivated."
