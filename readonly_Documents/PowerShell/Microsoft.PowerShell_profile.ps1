# starship
function Invoke-Starship-PreCommand { $Host.UI.RawUI.WindowTitle = $PWD.ToString().Replace($HOME, '~').Replace('\', '/') }
Invoke-Expression (&starship init powershell)

# scoop
Invoke-Expression (&scoop-search --hook)

# zoxide
Invoke-Expression (&{zoxide init --hook 'pwd' powershell | Out-String})

# psfzf
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+f' -PSReadlineChordReverseHistory 'Ctrl+r'

# lsd
function l  { lsd @args }
function la { lsd -a @args }
function ll { lsd -la --blocks 'permission,size,date,name' --date '+%Y-%m-%d %H:%M' @args }

# gh copilot
$GH_COPILOT_PROFILE = Join-Path -Path $(Split-Path -Path $PROFILE -Parent) -ChildPath "gh-copilot.ps1"
. $GH_COPILOT_PROFILE
