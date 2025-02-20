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
     hyprpaper \
     git \
     gnome \
     gnome-shell-extension-appindicator \
     grim \
     lazygit \
     mandb \
     nano \
     neovim \
     noto-fonts \
     noto-fonts-cjk \
     ripgrep \
     rsync \
     slurp \
     starship \
     tree \
     ttf-noto-nerd \
     vi \
     vim \
     waybar \
     wezterm \
     wofi \
     zsh

# Development
sudo pacman -S \
      composer \
      go \
      nginx-mainline \
      nullmailer \
      php-apcu php-fpm php-gd php-imagick php-pgsql php-redis php-sqlite xdebug \
      rustup

# PHP Dependencies
composer global require laravel/installer

# Apps
sudo pacman -S \
     discord \
     firefox \
     gthumb \
     keepassxc \
     meld \
     qemu-desktop \
     remmina \
     spotify-launcher \
     transmission-gtk \
     vlc

# Docker
sudo usermod -aG docker $USER

# Aur
yay -S \
     gnome-shell-extension-dash-to-dock \
     nvm \
     postman-bin \
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
ln -s $HOME/.dotfiles/config/waybar $HOME/.config/waybar
ln -s $HOME/.dotfiles/config/zsh/aliases.zsh $HOME/.oh-my-zsh/custom/aliases.zsh
ln -s $HOME/.dotfiles/config/zsh/path.zsh $HOME/.oh-my-zsh/custom/path.zsh
