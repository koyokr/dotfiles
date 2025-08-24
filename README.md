# dotfiles

## Apply

**Linux**

```sh
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply --depth 1 --purge-binary koyokr
```

**Windows**

```powershell
iex "&{$(irm 'https://get.chezmoi.io/ps1')} -- init --apply --depth 1 --purge-binary koyokr"
```
