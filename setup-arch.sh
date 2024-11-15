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
     lazygit \
     neovim \
     noto-fonts \
     noto-fonts-cjk \
     ripgrep \
     rsync \
     starship \
     ttf-noto-nerd \
     vim \
     wezterm \
     xorg-xdpyinfo \
     zsh

# Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
grep -qF 'starship init zsh' ~/.zshrc || printf "\neval \"\$(starship init zsh)\"" >> ~/.zshrc

# Development
sudo pacman -S \
      composer \
      mariadb \
      nginx-mainline \
      nodejs \
      npm \
      nullmailer \
      php-apcu php-fpm php-gd php-imagick php-pgsql php-redis php-sqlite xdebug

# NPM dependencies
sudo npm install -g npm-check-updates

# MariaDB configuration
sudo mariadb -u root -e "SET PASSWORD = PASSWORD('');"

# PHP Dependencies
composer global require laravel/installer

# Apps
sudo pacman -S \
     discord \
     firefox \
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
     httpie-desktop-bin \
     powerline-fonts-git \
     stripe-cli-bin \
     symfony-cli-bin \
     visual-studio-code-bin

# Clean
yay -Yc
yay -Scc

# Dotfiles
ln -s $HOME/.dotfiles/config/git/.gitconfig $HOME/.gitconfig
ln -s $HOME/.dotfiles/config/git/.gitignore_global $HOME/.gitignore_global
ln -s $HOME/.dotfiles/config/zsh/aliases.zsh $HOME/.oh-my-zsh/custom/aliases.zsh
ln -s $HOME/.dotfiles/config/zsh/path.zsh $HOME/.oh-my-zsh/custom/path.zsh
ln -s $HOME/.dotfiles/config/.wezterm.lua $HOME/.wezterm.lua
ln -s $HOME/.dotfiles/config/nvim $HOME/.config/nvim
