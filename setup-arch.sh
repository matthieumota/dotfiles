#!/bin/bash

echo "Setting Arch..."

# Update
yay

# Binaries
sudo pacman -S \
     btop \
     curl \
     docker \
     git \
     gnome-bluetooth-3.0 \
     gnome-shell-extension-appindicator \
     screenfetch \
     ttf-dejavu \
     xorg-xdpyinfo \
     zsh

# Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Development
sudo pacman -S \
      composer \
      mariadb \
      nodejs \
      npm \
      nullmailer \
      php-apcu php-fpm \
      nginx-mainline

# NPM dependencies
sudo npm install -g npm-check-updates

# PHP Dependencies
composer global require laravel/installer

# Apps
sudo pacman -S \
     code \
     discord \
     keepassxc \
     meld \
     remmina \
     spotify-launcher

# Docker
sudo usermod -aG docker $USER

# Aur
yay -S \
     google-chrome \
     powerline-fonts-git \
     stripe-cli-bin \
     symfony-cli-bin \
     visual-studio-code-bin

yay -Yc

# Dotfiles
ln -s $HOME/.dotfiles/config/git/.gitconfig $HOME/.gitconfig
ln -s $HOME/.dotfiles/config/git/.gitignore_global $HOME/.gitignore_global
ln -s $HOME/.dotfiles/config/zsh/aliases.zsh $HOME/.oh-my-zsh/custom/aliases.zsh
ln -s $HOME/.dotfiles/config/zsh/path.zsh $HOME/.oh-my-zsh/custom/path.zsh
