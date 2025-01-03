# Install Scoop if not already installed
if (!(Get-Command scoop -ErrorAction SilentlyContinue)) {
    Write-Host 'Installing Scoop...'
    Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
}

# Disable aria2 warning message for faster downloads
Write-Host 'Configuring Scoop settings...'
scoop config aria2-warning-enabled false

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
    'chezmoi',
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
    'openssh',
    'psfzf',
    'python',
    'ripgrep',
    'scoop-search',
    'sd',
    'starship',
    'sysinternals',
    'wget',
    'zoxide'
)

Write-Host 'Installing applications using Scoop...'
scoop install $scoopPackages

# Configure Windows Explorer settings
Write-Host 'Configuring Windows Explorer settings...'
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'HideFileExt' -Value 0
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'Hidden' -Value 1
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'NavPaneShowAllFolders' -Value 0
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'ShowSyncProviderNotifications' -Value 0

# Configure Snap layouts and multitasking settings
Write-Host 'Configuring snap layouts and multitasking settings...'
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'EnableSnapAssistFlyout' -Value 0
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'EnableSnapBar' -Value 0
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'EnableTaskGroups' -Value 1
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'MultiTaskingAltTabFilter' -Value 3

New-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\UCPD' -Name 'Start' -Value 4 -PropertyType DWORD -Force
Disable-ScheduledTask -TaskName ‘\Microsoft\Windows\AppxDeploymentClient\UCPD velocity’

# Configure taskbar settings
Write-Host 'Configuring taskbar settings...'
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Search' -Name 'SearchboxTaskbarMode' -Value 1
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'TaskbarAl' -Value 0
# Disabled due to UCPD driver blocking registry modifications
# Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'TaskbarDa' -Value 0

# Configure system tray clock (24-hour format with seconds)
Write-Host 'Configuring system tray clock format...'
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'ShowSecondsInSystemClock' -Value 1
Set-ItemProperty -Path 'HKCU:\Control Panel\International' -Name 'sShortTime' -Value 'HH:mm'
Set-ItemProperty -Path 'HKCU:\Control Panel\International' -Name 'sTimeFormat' -Value 'HH:mm:ss'

# Enable clipboard history
Write-Host 'Enabling clipboard history...'
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Clipboard' -Name 'EnableClipboardHistory' -Value 1

gsudo {
    # Remove MAX_PATH limit
    Write-Host 'Removing MAX_PATH length limit...'
    New-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem' -Name 'LongPathsEnabled' -Value 1 -PropertyType DWORD -Force

    # Disable search box suggestions
    Write-Host 'Disabling search box suggestions...'
    New-Item -Path 'HKCU:\Software\Policies\Microsoft\Windows\Explorer' -Force | Out-Null
    Set-ItemProperty -Path 'HKCU:\Software\Policies\Microsoft\Windows\Explorer' -Name 'DisableSearchBoxSuggestions' -Value 1 -Type DWord

    # Remove Windows Features
    Write-Host 'Removing Windows Features...'
    Disable-WindowsOptionalFeature -Online -FeatureName 'SMB1Protocol' -NoRestart
    Disable-WindowsOptionalFeature -Online -FeatureName 'MicrosoftWindowsPowerShellV2' -NoRestart

    # Install packages using winget
    $wingetPackages = @(
        'Microsoft.VCRedist.2015+.x64',
        'Microsoft.VCRedist.2015+.x86',
        'Bandisoft.BandiView',
        'CondaForge.Miniforge3',
        'Microsoft.PowerShell',
        'Microsoft.PowerToys',
        'Microsoft.VisualStudioCode',
        'Obsidian.Obsidian'
    )

    Write-Host 'Installing applications using winget...'
    winget install $wingetPackages --accept-source-agreements --accept-package-agreements --no-upgrade --silent
}

# Restart Explorer to apply changes
Stop-Process -Name explorer -Force

Write-Host 'Installation complete!'
