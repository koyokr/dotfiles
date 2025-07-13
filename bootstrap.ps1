# Install Scoop if not already installed
if (!(Get-Command scoop -ErrorAction SilentlyContinue)) {
    Write-Host 'Installing Scoop...'
    Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
}

# Add Scoop buckets
Write-Host 'Adding Scoop buckets...'
scoop install git
scoop bucket add extras
scoop bucket add java
scoop bucket add nerd-fonts

# Install packages using Scoop
Write-Host 'Installing applications using Scoop...'
$scoopPackages = @(
    'base64',
    'bat',
    'chezmoi',
    'croc',
    'delta',
    'Delugia-Mono-Nerd-Font-Complete',
    'fd',
    'ffmpeg',
    'fzf',
    'gpg',
    'gsudo',
    'hexyl',
    'lsd',
    'mpv',
    'openssh',
    'picocrypt',
    'psfzf',
    'python',
    'ripgrep',
    'scoop-search',
    'sd',
    'starship',
    'sysinternals',
    'wget',
    'yt-dlp',
    'zoxide'
)
scoop install $scoopPackages

gsudo {
    # Install packages using winget
    Write-Host 'Installing applications using winget...'
    $wingetPackages = @(
        'Microsoft.VCRedist.2015+.x64',
        'Microsoft.VCRedist.2015+.x86',
        'CondaForge.Miniforge3',
        'Microsoft.PowerShell',
        'Microsoft.PowerToys',
        'Microsoft.VisualStudioCode',
        'Obsidian.Obsidian'
    )
    winget install $wingetPackages --accept-source-agreements --accept-package-agreements --no-upgrade --silent

    # Run Winutil
    Invoke-RestMethod -Uri https://christitus.com/win | Invoke-Expression
}

Write-Host 'Installation complete!'
