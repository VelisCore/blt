# Disable Windows Defender (needs reboot, not recommended for all!)
Write-Output "Deactivating Windows Defender..."
Set-MpPreference -DisableRealtimeMonitoring $true
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender" -Name "DisableAntiSpyware" -Value 1 -Force
Write-Output "Windows Defender deactivated."