# dotfiles

## Setup a new Windows PC

1. Initial setup:
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
Invoke-RestMethod -Uri https://raw.githubusercontent.com/koyokr/dotfiles/main/bootstrap.ps1 | Invoke-Expression
```

2. Get my dotfiles:
```powershell
chezmoi init --apply https://github.com/koyokr/dotfiles.git
```
