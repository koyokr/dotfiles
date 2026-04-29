#!/bin/sh
set -eu

# Runs as the regular user (chezmoi context).
# chezmoi targets $HOME, so root execution would write to /root and miss the
# actual user. sudo is invoked only for the system-level bits.
if [ "$(id -u)" -eq 0 ]; then
    echo "Refusing to run as root. Run as your normal user; sudo is used where needed." >&2
    exit 1
fi

# Detect distro via /etc/os-release ID field.
distro=""
if [ -f /etc/os-release ]; then
    distro=$(. /etc/os-release && echo "$ID")
fi

# Distro-specific setup.
if [ "$distro" = "arch" ]; then
    # 1. Sync and install packages.
    sudo pacman --noconfirm --quiet -Syu
    sudo pacman --noconfirm --quiet -S --needed \
        bat chezmoi croc fd fish fzf git git-delta helix hexyl \
        less ripgrep sd starship zoxide

    # 2. Ensure login shell is fish.
    current_shell=$(getent passwd "$USER" | cut -d: -f7)
    if [ "$current_shell" != /usr/bin/fish ]; then
        sudo chsh -s /usr/bin/fish "$USER"
    fi
else
    echo "Unsupported distro: ${distro:-unknown}" >&2
    exit 1
fi

# WSL-specific configuration (distro-independent).
if uname -r | grep -q 'WSL'; then
    sudo tee /etc/wsl.conf >/dev/null <<EOF
[boot]
systemd=true

[interop]
appendWindowsPath=false

[user]
default=$USER
EOF
fi

echo "Setup complete for $USER."
