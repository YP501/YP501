function installScoopApps {
    $scoopApps = @(
        "7zip"
        "audacity"
        "blender"
        "filezilla"
        "github"
        "vscode"
        "mongodb-compass"
        "firefox"
        "nodejs"
        "obs-studio"
        "oh-my-posh"
        "terminal-icons"
        "python"
        "qbittorrent-enhanced"
        "spotify"
        "translucenttb"
        "vlc"
        "BitstreamVeraSansMono-NF"
        "yarn"
    )

    # Installing scoop cmdlet
    Write-Output "Checking if scoop is already installed..."
    Start-Sleep -Seconds 1
    if (Get-Command scoop -ErrorAction SilentlyContinue) {
        Write-Output "Scoop is already installed. Skipping installation..."
    }
    else {
        Write-Output "Scoop is not installed. Installing scoop..."
        Invoke-RestMethod get.scoop.sh | Invoke-Expression
    }

    $scoopAppsDir = "$home\scoop\apps"

    # Installing git for getting scoop buckets
    scoop install git

    # Installing scoop buckets
    scoop bucket add nerd-fonts
    scoop bucket add extras

    # Installing the apps with scoop
    ForEach ($scoopApp in $scoopApps) {
        scoop install $scoopApp
        
        # Adding configs
        switch ($scoopApp) {
            "7zip" {
                Write-Output "`r`n"
                Write-Output "Installing 7zip context menu registry entries..."
                reg import "$scoopAppsDir\7zip\current\install-context.reg"
            }
            "vscode" {
                Write-Output "`r`n"
                Write-Output "Installing vscode context menu registry entries..."
                reg import "$scoopAppsDir\vscode\current\install-associations.reg"
                reg import "$scoopAppsDir\vscode\current\install-context.reg"

                Write-Output "`r`n"
                Write-Output "Installing vscode extensions..."
                Write-Host "NOTE: It will say something about a buffer method, please ignore that and let it run as it will install with no problems!" -ForegroundColor Yellow
                Start-Sleep -Seconds 5
                $vscodeExtensions = @(
                    "christian-kohler.npm-intellisense"
                    "dbaeumer.vscode-eslint"
                    "dbankier.vscode-quick-select"
                    "eamodio.gitlens"
                    "esbenp.prettier-vscode"
                    "formulahendry.code-runner"
                    "Gruntfuggly.todo-tree"
                    "illixion.vscode-vibrancy-continued"
                    "jbockle.jbockle-format-files"
                    "LeonardSSH.vscord"
                    "miguelsolorio.fluent-icons"
                    "ms-python.isort"
                    "ms-python.python"
                    "ms-python.vscode-pylance"
                    "ms-vscode.powershell"
                    "ms-vsliveshare.vsliveshare"
                    "naumovs.color-highlight"
                    "PKief.material-icon-theme"
                    "ritwickdey.LiveServer"
                    "usernamehw.errorlens"
                    "wix.vscode-import-cost"
                    "xuanzhi33.simple-calculator"
                    "zhuangtongfa.material-theme"
                )

                ForEach ($extension in $vscodeExtensions) {
                    code --install-extension $extension
                }
            }
            "firefox" {
                firefox -P
            }
            "python" {
                Write-Output "`r`n"
                Write-Output "Installing python context menu registry entries..."
                reg import "$scoopAppsDir\python\current\install-pep-514.reg"
            }
        }

        Write-Output "`r`n"
    }

    Write-Output "Finished installing apps with scoop. Exiting..."
    Start-Sleep -Seconds 3

}

function getDownloadUrl {

    param(
        [parameter(Mandatory = $true)]
        $repo,
        [parameter(Mandatory = $true)]
        $filter
    )

    $uri = "https://api.github.com/repos/$repo/releases"

    $downloadUrls = ((Invoke-RestMethod -Method GET -Uri $uri)[0].assets).browser_download_url
    ($downloadUrls | Select-String -Pattern $filter).toString()
}

function downloadFile {

    param(
        [parameter(Mandatory = $true)]
        $url,
        [parameter(Mandatory = $true)]
        $destination
    )

    $fileName = Split-Path $url -leaf

    $wc = New-Object System.Net.WebClient
    $wc.DownloadFile($url, "$destination\$fileName")
}

function installGithubApps {
    $installationFolder = "C:\Temp\downloaded\githubApps"
    If (Test-Path $installationFolder) {
        Write-Output "$installationFolder exists. Skipping."
    }
    Else {
        Write-Output "The folder '$installationFolder' doesn't exist. Creating now."
        Start-Sleep 1
        New-Item -Path "$installationFolder" -ItemType Directory
        Write-Output "The folder $installationFolder was successfully created."
    }
    Write-Output "`r`n"

    # Write-Output "Downloading chaiNNer..."
    # (downloadFile -url (getDownloadUrl -repo "chaiNNer-org/chaiNNer" -filter "windows-x64") -destination $installationFolder)
    # Write-Output "Done.`r`n"

    # Write-Output 'Downloading Assist...'
    # (downloadFile -url (getDownloadUrl -repo "HeyM1ke/Assist" -filter "Assist.zip") -destination $installationFolder)
    # Write-Output "Done.`r`n"

    $githubApps = Get-ChildItem $installationFolder
    ForEach ($githubApp in $githubApps) {
        $fileName = $githubApp.Name
        $filePath = "$installationFolder\$fileName"

        $fileNameSwitch = $fileName.ToLower()
        if ($fileNameSwitch.Contains('assist')) {
            Write-Output "hello"
            7z x $filePath -o"C:\Temp\downloaded\Assist"
        }
        # TODO: finish this unholy creation
    }
    pause
}

# installScoopApps
installGithubApps