Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadLineOption -BellStyle None -PredictionSource History

function Invoke-Starship-PreCommand { $Host.UI.RawUI.WindowTitle = $PWD.ToString().Replace($HOME, '~').Replace('\', '/') }
Invoke-Expression (&starship init powershell)

Set-Alias -Name l -Value lsd
function la { l -a @args }
function ll { l -l --blocks 'permission,size,date,name' --date '+%Y-%m-%d %H:%M' @args }
function lla { ll -a @args }
function lt { lsd --tree -depth @args }
