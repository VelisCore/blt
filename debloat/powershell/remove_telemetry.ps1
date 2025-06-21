# Deactivate Telemetry
Write-Output "Deaktiviere Telemetrie..."
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "AllowTelemetry" -Type DWord -Value 0 -Force
Stop-Service 'DiagTrack' -Force
Set-Service 'DiagTrack' -StartupType Disabled
Write-Output "Telemetrie deaktiviert."