Invoke-Expression (&starship init powershell)

Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadLineOption -BellStyle None -PredictionSource History

function l { lsd @args }
function la { lsd -a @args }
function ll { lsd -l --blocks 'permission,size,date,name' --date '+%Y-%m-%d %H:%M' @args }
function lla { ll -a @args }
