Invoke-Expression (&starship init powershell)
Invoke-Expression (&{(zoxide init --hook pwd powershell) -join "`n"})

Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadLineOption -BellStyle None -PredictionSource History

function l { lsd @args }
function la { lsd -a @args }
function ll { lsd -l --blocks 'permission,size,date,name' --date '+%Y-%m-%d %H:%M' @args }
function lla { ll -a @args }
