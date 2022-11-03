#no errors throughout
$ErrorActionPreference = 'silentlycontinue'

# Check for ExecutionPolicy
$policy = "RemoteSigned"
if ((Get-ExecutionPolicy -Scope CurrentUser) -ne $policy) {
    $choice = (Read-Host -Prompt "This script requires the ExecutionPolicy to be RemoteSigned in order to have things work properly.`r`nWould you like to change the ExecutionPolicy? (y/n)").toLower()
    if ($choice.Contains("y")) {
        Write-Output "Setting ExecutionPolicy..."
        Set-ExecutionPolicy -ExecutionPolicy $policy -Scope "CurrentUser"
	Write-Output "Finished setting ExecutionPolicy."
	Start-Sleep -Seconds 1
        Start-Process powershell.exe -ArgumentList ("-NoProfile -ExecutionPolicy Bypass -File $PSCommandPath")
        exit
    }
}

Clear-Host
$titleText = @"
██╗    ██╗███████╗██╗      ██████╗ ██████╗ ███╗   ███╗███████╗
██║    ██║██╔════╝██║     ██╔════╝██╔═══██╗████╗ ████║██╔════╝
██║ █╗ ██║█████╗  ██║     ██║     ██║   ██║██╔████╔██║█████╗  
██║███╗██║██╔══╝  ██║     ██║     ██║   ██║██║╚██╔╝██║██╔══╝  
╚███╔███╔╝███████╗███████╗╚██████╗╚██████╔╝██║ ╚═╝ ██║███████╗
 ╚══╝╚══╝ ╚══════╝╚══════╝ ╚═════╝ ╚═════╝ ╚═╝     ╚═╝╚══════╝
                                                              
"@
Write-Host $titleText

# Loading the main script which will run the installer and the debloater
$choice = (Read-Host "The main script is ready. Would you like to run it? (y/n)").toLower()
if ($choice.Contains("y")) {
    Clear-Host
    Write-Output "Initializing..."
    Start-Sleep -Seconds 2
    Start-Process powershell.exe -ArgumentList ("-NoProfile -ExecutionPolicy Bypass -File $PSScriptRoot/scripts/main.ps1")
    exit
}

exit