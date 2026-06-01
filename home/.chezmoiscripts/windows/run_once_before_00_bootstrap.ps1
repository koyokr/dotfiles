
# Install Scoop if not already installed
if (!(Get-Command scoop -ErrorAction SilentlyContinue)) {
    Write-Host 'Installing Scoop...'
    Start-Process powershell -ArgumentList "-NoProfile", "-ExecutionPolicy", "Bypass", "-Command", "iwr -useb get.scoop.sh | iex" -Wait -NoNewWindow
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path","User") + ";" + [System.Environment]::GetEnvironmentVariable("Path","Machine")
}

# Install scoop packages
Write-Host 'Installing scoop packages'
scoop install git
scoop bucket add extras
scoop bucket add java
scoop bucket add nerd-fonts
scoop install `
    adb `
    base64 `
    bat `
    chezmoi `
    croc `
    cyberchef `
    Delugia-Mono-Nerd-Font-Complete `
    fd `
    ffmpeg `
    fzf `
    gpg `
    gsudo `
    hexyl `
    lsd `
    mpv-git `
    openssl `
    psfzf `
    python `
    qpdf `
    ripgrep `
    scoop-search `
    sd `
    starship `
    syncthing `
    temurin-lts-jdk `
    uv `
    wget `
    yt-dlp `
    zoxide

# Set Syncthing to start automatically
Write-Host 'Setting syncthing to start automatically...'
Register-ScheduledTask `
    -TaskName "Syncthing" `
    -Action (New-ScheduledTaskAction -Execute "$HOME\scoop\apps\syncthing\current\syncthing.exe" -Argument "--no-console --no-browser" -WorkingDirectory $HOME) `
    -Trigger (New-ScheduledTaskTrigger -AtLogOn -User $env:USERNAME) `
    -Settings (New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -ExecutionTimeLimit 0)

gsudo {
    # Install winget packages
    Write-Host 'Installing winget applications...'
    winget install --accept-source-agreements --accept-package-agreements --no-upgrade --silent `
        Microsoft.VCRedist.2015+.x64 `
        Microsoft.VCRedist.2015+.x86 `
        Microsoft.PowerShell `
        Microsoft.PowerToys `
        Microsoft.VisualStudioCode `
        Obsidian.Obsidian

    # Run Winutil
    Invoke-RestMethod -Uri https://christitus.com/win | Invoke-Expression
}

Write-Host 'Installation complete!'
