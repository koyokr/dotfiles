#!/bin/sh

{{- if and (eq .chezmoi.osRelease.id "arch") (eq .chezmoi.user.name "root") -}}
read -p "Enter the username to create: " USERNAME
if [ -z "${USERNAME}" ]; then
    echo "Username cannot be empty."
    exit 1
fi

# 1. pacman
pacman --noconfirm --quiet -Syu
pacman --noconfirm --quiet -S --needed bat chezmoi croc fd fish fzf git git-delta helix hexyl less ripgrep sd starship sudo zoxide

# 2. sudoer
echo '%wheel ALL=(ALL:ALL) NOPASSWD: ALL' > /etc/sudoers.d/10-wheel-nopasswd
chmod 0440 /etc/sudoers.d/10-wheel-nopasswd

# 3. useradd
if ! id "${USERNAME}" >/dev/null 2>&1; then
    useradd -m -G wheel -s /usr/bin/fish ${USERNAME}
fi

# 4. wsl
{{- if contains "WSL" .chezmoi.kernel.osrelease }}
cat > /etc/wsl.conf <<EOF
[boot]
systemd=true

[interop]
appendWindowsPath=false

[user]
default=${USERNAME}
EOF
{{- end }}

{{- end -}}
