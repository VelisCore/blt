# Remove People Bar (My People)
Write-Output "Deactivating People Bar..."
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "HidePeopleBar" /t REG_DWORD /d 1 /f
Write-Output "People Bar deactivated."
