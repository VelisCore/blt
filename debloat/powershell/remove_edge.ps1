#requires -RunAsAdministrator
# Remove Microsoft Edge (Stable), WebView2, Task-Scheduler Items, Startmenu, Registry Keys, etc.

param (
    [switch]$Silent
)

function Hide-Console {
    $consoleWindow = Get-Process -Id $PID | ForEach-Object { $_.MainWindowHandle }
    if ($consoleWindow -ne 0) {
        $null = ShowWindowAsync($consoleWindow, 0)
    }
}
Add-Type @"
using System;
using System.Runtime.InteropServices;
public class Win32 {
    [DllImport("user32.dll")]
    public static extern bool ShowWindowAsync(IntPtr hWnd, int nCmdShow);
}
"@

# Optional: hide console in silent mode
if ($Silent) {
    [Win32]::ShowWindowAsync((Get-Process -Id $PID).MainWindowHandle, 0)
}

# Define uninstall paths
$setupExe = "$PSScriptRoot\setup.exe"

function Run-EdgeUninstall {
    if (Test-Path "C:\Program Files (x86)\Microsoft\Edge\Application\pwahelper.exe") {
        Write-Host "Uninstalling Edge..."
        Start-Process -FilePath $setupExe -ArgumentList "--uninstall", "--system-level", "--force-uninstall" -NoNewWindow -Wait
    }

    if (Test-Path "C:\Program Files (x86)\Microsoft\EdgeWebView\Application") {
        Write-Host "Uninstalling Edge WebView..."
        Start-Process -FilePath $setupExe -ArgumentList "--uninstall", "--msedgewebview", "--system-level", "--force-uninstall" -NoNewWindow -Wait
    }
}

function Remove-AppxEdge {
    $packages = Get-AppxPackage -AllUsers | Where-Object { $_.Name -like "*microsoftedge*" -and $_.Name -notlike "*DevTools*" }
    foreach ($pkg in $packages) {
        Write-Host "Marking Edge package '$($pkg.Name)' as removed..."
        $paths = @(
            "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Appx\AppxAllUserStore\EndOfLife\$($pkg.PackageUserInformation[0].UserSecurityId)\$($pkg.PackageFullName)",
            "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Appx\AppxAllUserStore\EndOfLife\S-1-5-18\$($pkg.PackageFullName)",
            "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Appx\AppxAllUserStore\Deprovisioned\$($pkg.PackageFullName)"
        )
        foreach ($path in $paths) {
            if (-not (Test-Path $path)) {
                New-Item -Path $path -Force | Out-Null
            }
        }
    }
}

function Clean-BadRegistry {
    $base = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Appx\AppxAllUserStore"
    function Should-Delete($name) {
        return ($name -notmatch "[a-zA-Z]") -or ($name -match "\s")
    }

    function Recurse-Clean($path) {
        Get-ChildItem -Path $path -ErrorAction SilentlyContinue | ForEach-Object {
            if (Should-Delete $_.PSChildName) {
                Remove-Item -Path $_.PsPath -Recurse -Force -ErrorAction SilentlyContinue
            }
            else {
                Recurse-Clean $_.PsPath
            }
        }
    }

    Recurse-Clean $base
}

function Remove-Shortcuts {
    $users = Get-ChildItem 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList' |
        ForEach-Object {
            (Get-ItemProperty $_.PsPath).ProfileImagePath
        }

    foreach ($path in $users) {
        $desktop = Join-Path $path "Desktop"
        if (Test-Path $desktop) {
            Remove-Item "$desktop\Microsoft Edge.lnk" -ErrorAction SilentlyContinue
            Remove-Item "$desktop\edge.lnk" -ErrorAction SilentlyContinue
        }
    }

    Remove-Item "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Microsoft Edge.lnk" -ErrorAction SilentlyContinue
}

function Remove-ScheduledTasks {
    $tasks = schtasks /query /fo csv | ConvertFrom-Csv | Where-Object { $_.TaskName -like "*MicrosoftEdge*" }
    foreach ($task in $tasks) {
        schtasks /delete /tn "$($task.TaskName)" /f > $null 2>&1
    }

    Get-ChildItem -Path "C:\Windows\System32\Tasks" -Recurse -Force | Where-Object { $_.Name -like "MicrosoftEdge*" } | Remove-Item -Force
}

function Remove-EdgeServices {
    foreach ($svc in "edgeupdate", "edgeupdatem") {
        sc.exe delete $svc > $null 2>&1
        Remove-Item "HKLM:\SYSTEM\CurrentControlSet\Services\$svc" -Recurse -Force -ErrorAction SilentlyContinue
    }
}

function Remove-SystemApps {
    Get-ChildItem "C:\Windows\SystemApps" | Where-Object { $_.Name -like "Microsoft.MicrosoftEdge*" } | ForEach-Object {
        takeown /f $_.FullName /r /d y > $null
        icacls $_.FullName /grant Administrators:F /t > $null
        Remove-Item $_.FullName -Recurse -Force -ErrorAction SilentlyContinue
    }
}

function Remove-EdgeExecutables {
    $userName = $env:USERNAME
    Get-ChildItem "C:\Windows\System32" | Where-Object { $_.Name -like "MicrosoftEdge*.exe" } | ForEach-Object {
        takeown /f $_.FullName > $null 2>&1
        icacls $_.FullName /inheritance:e /grant "${userName}:(OI)(CI)F" > $null 2>&1
        Remove-Item $_.FullName -Force -ErrorAction SilentlyContinue
    }
}

function Final-Cleanup {
    Remove-Item "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Edge" -Recurse -Force -ErrorAction SilentlyContinue
    Stop-Process -Name MicrosoftEdgeUpdate -Force -ErrorAction SilentlyContinue
    Remove-Item "C:\Program Files (x86)\Microsoft\Edge" -Recurse -Force -ErrorAction SilentlyContinue
    Remove-Item "C:\Program Files (x86)\Microsoft\EdgeUpdate" -Recurse -Force -ErrorAction SilentlyContinue
}

# === Execution ===

if (-not $Silent) {
    Write-Host "`n===> Starte Microsoft Edge Entfernung..."
}

Run-EdgeUninstall
Remove-AppxEdge
Clean-BadRegistry
Remove-Shortcuts
Remove-ScheduledTasks
Remove-EdgeServices
Remove-SystemApps
Remove-EdgeExecutables
Final-Cleanup

if (-not $Silent) {
    Write-Host "`n✅ Microsoft Edge wurde (soweit möglich) entfernt."
    Start-Sleep -Seconds 3
}
