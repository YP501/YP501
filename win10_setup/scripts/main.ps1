Write-Output "There are two scripts in this installation bundle:`r`n1. A windows debloater`r`n2. An application installer`r`n"

$choice = (Read-Host -Prompt "Would you like to run the Windows Debloater? (needs administrator privileges) (y/n)").ToLower()
if ($choice.Contains("y")) {
    Write-Output "Running debloater..."
    Start-Process powershell.exe -ArgumentList("-NoProfile -ExecutionPolicy Bypass -File $PSScriptRoot/debloater.ps1") -Wait -Verb RunAs
    Write-Output "Finished debloating.`r`n"
}
else {
    Write-Output "Skipping debloater.`r`n"
}

$choice = (Read-Host -Prompt "Would you like to run the application installer? (y/n)").ToLower()
if ($choice.Contains("y")) {
    Write-Output "Running application installer..."
    Start-Process powershell.exe -ArgumentList("-NoProfile -ExecutionPolicy Bypass -File $PSScriptRoot/installer.ps1") -Wait
    Write-Output "Finished installing applications.`r`n"
}
else {
    Write-Output "Skipping application installer.`r`n"
}

Write-Output "The windows 10 setup tool has finished successfully!"
Pause
exit