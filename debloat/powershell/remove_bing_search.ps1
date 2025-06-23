# Remove Bing from Windows Search
Write-Output "Removing Bing from Search..."
REG ADD "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "BingSearchEnabled" /t REG_DWORD /d 0 /f
REG ADD "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "CortanaConsent" /t REG_DWORD /d 0 /f
Write-Output "Bing-Search deativated."