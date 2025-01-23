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
     hyprland \
     git \
     gnome-bluetooth-3.0 \
     gnome-keyring \
     gnome-shell-extension-appindicator \
     kitty \
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
     wofi \
     xorg-xdpyinfo \
     zsh

# Development
sudo pacman -S \
      composer \
      nginx-mainline \
      nullmailer \
      php-apcu php-fpm php-gd php-imagick php-pgsql php-redis php-sqlite xdebug

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
     nvm \
     powerline-fonts-git \
     stripe-cli-bin \
     symfony-cli-bin \
     visual-studio-code-bin

# Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
grep -qF 'starship init zsh' ~/.zshrc || printf "\neval \"\$(starship init zsh)\"\n" >> ~/.zshrc
grep -qF "/usr/share/nvm/init-nvm.sh" ~/.zshrc || printf "source /usr/share/nvm/init-nvm.sh\n" >> ~/.zshrc

# NPM dependencies
npm install -g npm-check-updates

# Clean
yay -Yc
yay -Scc

# Dotfiles
ln -s $HOME/.dotfiles/config/.wezterm.lua $HOME/.wezterm.lua
ln -s $HOME/.dotfiles/config/git/.gitconfig $HOME/.gitconfig
ln -s $HOME/.dotfiles/config/git/.gitignore_global $HOME/.gitignore_global
ln -s $HOME/.dotfiles/config/hypr $HOME/.config/hypr
ln -s $HOME/.dotfiles/config/nvim $HOME/.config/nvim
ln -s $HOME/.dotfiles/config/starship.toml $HOME/.config/starship.toml
ln -s $HOME/.dotfiles/config/zsh/aliases.zsh $HOME/.oh-my-zsh/custom/aliases.zsh
ln -s $HOME/.dotfiles/config/zsh/path.zsh $HOME/.oh-my-zsh/custom/path.zsh
