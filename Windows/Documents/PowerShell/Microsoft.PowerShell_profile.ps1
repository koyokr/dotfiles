Invoke-Expression (&starship init powershell)
Set-Alias ls lsd
function l { lsd @args }
function la { lsd -a @args }
function ll { lsd -l --date +'%Y-%m-%d %H:%M' @args }
function lla { ll -a @args }
function lt { lsd --tree --depth @args }
