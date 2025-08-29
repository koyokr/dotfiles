# dotfiles

## Apply

**Linux**

```sh
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply --depth 1 koyokr
```

**Windows**

```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
iex "&{$(irm 'https://get.chezmoi.io/ps1')} -- init --apply --depth 1 koyokr"
```
