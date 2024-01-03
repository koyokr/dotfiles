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
function l { lsd -a @args }
function ll { l -l --blocks 'permission,size,date,name' --date '+%Y-%m-%d %H:%M' @args }
