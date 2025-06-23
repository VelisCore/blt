# OneDrive
Write-Output "`n[INFO] Starting OneDrive removal..."

Write-Output "[INFO] Stopping running OneDrive processes..."
Get-Process OneDrive -ErrorAction SilentlyContinue | Stop-Process -Force

Start-Sleep -Seconds 2

$oneDrivePaths = @(
    "$env:SYSTEMROOT\SysWOW64\OneDriveSetup.exe",
    "$env:SYSTEMROOT\System32\OneDriveSetup.exe"
)

foreach ($path in $oneDrivePaths) {
    if (Test-Path $path) {
        Write-Output "[INFO] Uninstalling OneDrive via: $path"
        & $path /uninstall | Out-Null
        Start-Sleep -Seconds 2
    }
}

Write-Output "[INFO] Removing OneDrive directories for all users..."

$usersPath = "$env:SystemDrive\Users"
Get-ChildItem -Path $usersPath -Directory | ForEach-Object {
    $oneDriveUserPath = Join-Path $_.FullName "OneDrive"
    if (Test-Path $oneDriveUserPath) {
        Write-Output "[INFO] Removing: $oneDriveUserPath"
        Remove-Item -Path $oneDriveUserPath -Recurse -Force -ErrorAction SilentlyContinue
    }
}

Write-Output "[INFO] Removing any remaining OneDrive registry entries..."
Remove-Item -Path "HKCU:\Software\Microsoft\OneDrive" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item -Path "HKLM:\Software\Policies\Microsoft\Windows\OneDrive" -Recurse -Force -ErrorAction SilentlyContinue

Write-Output "`n[SUCCESS] OneDrive was successfully removed."
