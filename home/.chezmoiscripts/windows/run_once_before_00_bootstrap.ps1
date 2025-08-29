
# Install Scoop if not already installed
if (!(Get-Command scoop -ErrorAction SilentlyContinue)) {
    Write-Host 'Installing Scoop...'
    Start-Process powershell -ArgumentList "-NoProfile", "-ExecutionPolicy", "Bypass", "-Command", "iwr -useb get.scoop.sh | iex" -Wait -NoNewWindow
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path","User") + ";" + [System.Environment]::GetEnvironmentVariable("Path","Machine")
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
    -Settings (New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -ExecutionTimeLimit 0)

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
