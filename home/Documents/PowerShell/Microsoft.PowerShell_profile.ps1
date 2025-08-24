# starship
function Invoke-Starship-PreCommand { $Host.UI.RawUI.WindowTitle = $PWD.ToString().Replace($HOME, '~').Replace('\', '/') }
Invoke-Expression (&starship init powershell)

# zoxide
Invoke-Expression (&{zoxide init --hook 'pwd' powershell | Out-String})

# psfzf
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+f' -PSReadlineChordReverseHistory 'Ctrl+r'

# scoop
Invoke-Expression (&scoop-search --hook)
