# Self-elevate if not admin
if (-Not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]'Administrator')) {
    Start-Process PowerShell.exe -Verb RunAs -ArgumentList "-File `"$($MyInvocation.MyCommand.Path)`"", $MyInvocation.UnboundArguments -Wait
    Exit
}
Import-Module Microsoft.PowerShell.Security
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
Set-ExecutionPolicy Bypass -Scope Process -Force

# Install Scoop if not already installed
if (!(Get-Command scoop -ErrorAction SilentlyContinue)) {
    Write-Host 'Installing Scoop...'
    Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
}

# Install scoop packages from main bucket
Write-Host 'Installing scoop packages from main bucket...'
scoop install `
    base64 `
    bat `
    chezmoi `
    croc `
    delta `
    fd `
    ffmpeg `
    fzf `
    git `
    gpg `
    gsudo `
    hexyl `
    lsd `
    openssh `
    openssl `
    python `
    ripgrep `
    scoop-search `
    sd `
    starship `
    syncthing `
    uv `
    wget `
    yt-dlp `
    zoxide

# Install scoop packages from extras bucket
Write-Host 'Installing scoop packages from extras bucket...'
scoop bucket add extras
scoop bucket add java
scoop bucket add nerd-fonts
scoop install `
    Delugia-Mono-Nerd-Font-Complete `
    mpv-git `
    picocrypt `
    psfzf `
    sysinternals `
    temurin-lts-jre

# Set Syncthing to start automatically
Write-Host 'Setting syncthing to start automatically...'
Register-ScheduledTask `
    -TaskName "Syncthing" `
    -Action (New-ScheduledTaskAction -Execute "$HOME\scoop\apps\syncthing\current\syncthing.exe" -Argument "--no-console --no-browser" -WorkingDirectory $HOME) `
    -Trigger (New-ScheduledTaskTrigger -AtLogOn -User $env:USERNAME) `
    -Settings (New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -ExecutionTimeLimit 0) `
Start-ScheduledTask -TaskName "Syncthing"

gsudo {
    # Install winget packages
    Write-Host 'Installing winget applications...'
    winget install --accept-source-agreements --accept-package-agreements --no-upgrade --silent `
        Microsoft.VCRedist.2015+.x64 `
        Microsoft.VCRedist.2015+.x86 `
        CondaForge.Miniforge3 `
        Microsoft.PowerShell `
        Microsoft.PowerToys `
        Microsoft.VisualStudioCode `
        M2Team.NanaZip Obsidian.Obsidian

    # Run Winutil
    Invoke-RestMethod -Uri https://christitus.com/win | Invoke-Expression
}

Write-Host 'Installation complete!'
