# dotfiles

## Installation

### 1. Bootstrap

**Linux**

```sh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/koyokr/dotfiles/main/bootstrap.sh)"
```

**Windows**

```powershell
irm https://raw.githubusercontent.com/koyokr/dotfiles/main/bootstrap.ps1 | iex
```

### 2. Apply
```sh
chezmoi init --apply https://github.com/koyokr/dotfiles.git
```
