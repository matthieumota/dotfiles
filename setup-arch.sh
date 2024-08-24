#!/bin/bash

echo "Setting Arch..."

# Update
yay

# Binaries
sudo pacman -S \
     btop \
     curl \
     docker \
     docker-compose \
     fastfetch \
     git \
     gnome-bluetooth-3.0 \
     gnome-keyring \
     gnome-shell-extension-appindicator \
     noto-fonts \
     noto-fonts-cjk \
     rsync \
     vi \
     xorg-xdpyinfo \
     zsh

# Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Development
sudo pacman -S \
      composer \
      mariadb \
      nginx-mainline \
      nodejs \
      npm \
      nullmailer \
      php-apcu php-fpm php-gd php-imagick php-redis php-sqlite xdebug

# NPM dependencies
sudo npm install -g npm-check-updates

# MariaDB configuration
sudo mariadb -u root -e "SET PASSWORD = PASSWORD('');"

# PHP Dependencies
composer global require laravel/installer

# Apps
sudo pacman -S \
     discord \
     gthumb \
     keepassxc \
     meld \
     qemu \
     remmina \
     spotify-launcher \
     transmission-gtk \
     vlc

# Docker
sudo usermod -aG docker $USER

# Aur
yay -S \
     gnome-shell-extension-dash-to-dock \
     gnome-terminal-transparency \
     google-chrome \
     httpie-desktop-bin \
     powerline-fonts-git \
     stripe-cli-bin \
     symfony-cli-bin \
     visual-studio-code-bin

# Clean
yay -Yc
yay -Sc

# Dotfiles
ln -s $HOME/.dotfiles/config/git/.gitconfig $HOME/.gitconfig
ln -s $HOME/.dotfiles/config/git/.gitignore_global $HOME/.gitignore_global
ln -s $HOME/.dotfiles/config/zsh/aliases.zsh $HOME/.oh-my-zsh/custom/aliases.zsh
ln -s $HOME/.dotfiles/config/zsh/path.zsh $HOME/.oh-my-zsh/custom/path.zsh
