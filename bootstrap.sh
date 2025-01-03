#!/bin/sh

# Install required packages
sudo pacman -S --noconfirm fish git-delta lsd starship

# Change default shell to fish
chsh -s /usr/bin/fish
