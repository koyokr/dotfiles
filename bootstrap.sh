#!/bin/sh

# Check if running as root on Arch Linux.
if [ -f /etc/os-release ] && grep -q 'ID=arch' /etc/os-release && [ "$(id -u)" -eq 0 ]; then

    # 1. Get username.
    read -p "Enter the username to create: " USERNAME
    if [ -z "${USERNAME}" ]; then
        echo "Username cannot be empty."
        exit 1
    fi

    # 2. Install packages.
    pacman --noconfirm --quiet -Syu
    pacman --noconfirm --quiet -S --needed bat chezmoi croc fd fish fzf git git-delta helix hexyl less ripgrep sd starship sudo zoxide

    # 3. Configure sudoers.
    echo '%wheel ALL=(ALL:ALL) NOPASSWD: ALL' > /etc/sudoers.d/10-wheel-nopasswd
    chmod 0440 /etc/sudoers.d/10-wheel-nopasswd

    # 4. Create user if it doesn't exist.
    if ! id "${USERNAME}" >/dev/null 2>&1; then
        useradd -m -G wheel -s /usr/bin/fish "${USERNAME}"
    fi

    # 5. Configure for WSL if applicable.
    # Check if the kernel release string contains "WSL".
    if uname -r | grep -q 'WSL'; then
        cat > /etc/wsl.conf <<EOF
[boot]
systemd=true

[interop]
appendWindowsPath=false

[user]
default=${USERNAME}
EOF
    fi

    echo "Setup complete for user ${USERNAME}."

else
    echo "This script must be run as root on Arch Linux."
    exit 1
fi
