# Set execution policy to allow script execution
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser -Force

# Configure Windows Explorer settings
Write-Host 'Configuring Windows Explorer settings...'
# Show file extensions
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'HideFileExt' -Value 0
# Show hidden files
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'Hidden' -Value 1

# Disable search box suggestions
Write-Host 'Disabling search box suggestions...'
New-Item -Path 'HKCU:\Software\Policies\Microsoft\Windows\Explorer' -Force | Out-Null
Set-ItemProperty -Path 'HKCU:\Software\Policies\Microsoft\Windows\Explorer' -Name 'DisableSearchBoxSuggestions' -Value 1 -Type DWord

# Remove MAX_PATH limit
Write-Host 'Removing MAX_PATH length limit...'
New-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem' -Name 'LongPathsEnabled' -Value 1 -PropertyType DWORD -Force

# Install packages using winget
$wingetPackages = @(
    'Bandisoft.BandiView',
    'Bandisoft.Bandizip',
    'CondaForge.Miniforge3',
    'DigitalScholar.Zotero',
    'Microsoft.PowerShell',
    'Microsoft.PowerToys',
    'Microsoft.VisualStudioCode',
    'Obsidian.Obsidian'
)

Write-Host 'Installing applications using winget...'
winget install $wingetPackages --accept-source-agreements --accept-package-agreements --no-upgrade --silent

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
$scoopPackages = @(
    'aria2',
    'base64',
    'bat',
    'croc',
    'curl',
    'delta',
    'Delugia-Mono-Nerd-Font-Complete',
    'fd',
    'ffmpeg',
    'fzf',
    'git',
    'gsudo',
    'hexyl',
    'lsd',
    'mpv',
    'neovim',
    'nodejs-lts',
    'openssh',
    'psfzf',
    'python',
    'ripgrep',
    'scoop-search',
    'sd',
    'starship',
    'sysinternals',
    'temurin-lts-jdk',
    'wget',
    'zoxide'
)

Write-Host 'Installing applications using Scoop...'
scoop install $scoopPackages

# Restart Explorer to apply changes
Stop-Process -Name explorer -Force

Write-Host 'Installation complete!'
