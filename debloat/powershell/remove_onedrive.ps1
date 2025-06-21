# Remove OneDrive for all users
Write-Output "Entferne OneDrive..."
Stop-Process -Name "OneDrive" -Force -ErrorAction SilentlyContinue
Start-Sleep -s 1
If (Test-Path "$($env:SYSTEMROOT)\SysWOW64\OneDriveSetup.exe") {
    & "$($env:SYSTEMROOT)\SysWOW64\OneDriveSetup.exe" /uninstall
}
If (Test-Path "$($env:SYSTEMROOT)\System32\OneDriveSetup.exe") {
    & "$($env:SYSTEMROOT)\System32\OneDriveSetup.exe" /uninstall
}
Remove-Item "$env:USERPROFILE\OneDrive" -Recurse -Force -ErrorAction SilentlyContinue
Write-Output "OneDrive entfernt."