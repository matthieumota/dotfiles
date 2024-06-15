#!/bin/bash

echo "Setting Arch..."

# Update
sudo pacman -Syu

# Binaries
sudo pacman -S \
     curl \
     docker \
     git \
     gnome-shell-extension-appindicator \
     nodejs \
     screenfetch \
     xorg-xdpyinfo \
     zsh

# Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Docker
sudo usermod -aG docker $USER

# Apps
sudo pacman -S \
     code \
     discord \
     remmina \
     spotify-launcher

# Aur
yay -S \
     powerline-fonts-git \
     visual-studio-code-bin \
     google-chrome

yay -Yc

# Dotfiles
ln -s $HOME/.dotfiles/config/git/.gitconfig $HOME/.gitconfig
ln -s $HOME/.dotfiles/config/git/.gitignore_global $HOME/.gitignore_global
