#!/bin/bash

echo "Setting Arch..."

# Update
yay

# Binaries
sudo pacman -S \
     amd-ucode \
     base-devel \
     blueman \
     btop \
     cups \
     curl \
     docker \
     docker-buildx \
     docker-compose \
     dosfstools \
     efibootmgr \
     ex-vi-compat \
     eza \
     fastfetch \
     fuzzel \
     github-cli \
     git \
     gnome \
     gnome-shell-extension-appindicator \
     gnome-shell-extensions \
     gnome-tweaks \
     grim \
     grub \
     hyprland \
     hyprlock \
     hyprpolkitagent \
     lazygit \
     libva-nvidia-driver \
     mako \
     man-db \
     nano \
     neovim \
     networkmanager \
     niri \
     noto-fonts \
     noto-fonts-cjk \
     nss-mdns \
     nvidia-open \
     os-prober \
     otf-font-awesome \
     pavucontrol \
     ripgrep \
     rsync \
     sbctl \
     slurp \
     starship \
     swaybg \
     system-config-printer \
     tree \
     ttf-noto-nerd \
     waybar \
     wl-clipboard \
     xdg-desktop-portal-hyprland \
     xwayland-satellite \
     zsh

# Development
sudo pacman -S \
     composer \
     go \
     nullmailer \
     php-apcu php-gd php-pgsql php-redis php-sqlite xdebug \
     rustup

# PHP Dependencies
composer global require laravel/installer

# Apps
sudo pacman -S \
     bitwarden \
     discord \
     firefox \
     ghostty \
     gthumb \
     meld \
     qemu-desktop \
     remmina \
     spotify-launcher \
     transmission-gtk \
     virt-manager \
     vlc \
     zed

# Docker
sudo usermod -aG docker $USER

# Aur
yay -S \
     ttf-firacode-nerd \
     gnome-shell-extension-dash-to-dock \
     google-chrome \
     hey-bin \
     nvm \
     php-pcov \
     postman-bin \
     powerline-fonts-git \
     symfony-cli-bin \
     visual-studio-code-bin

# Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
grep -qF 'starship init zsh' ~/.zshrc || printf "\neval \"\$(starship init zsh)\"\n" >> ~/.zshrc
grep -qF "/usr/share/nvm/init-nvm.sh" ~/.zshrc || printf "source /usr/share/nvm/init-nvm.sh\n" >> ~/.zshrc

# NPM dependencies
nvm install node
npm install -g npm-check-updates
curl -fsSL https://gh.io/copilot-install | bash
curl -fsSL https://opencode.ai/install | bash
curl -fsSL https://chatgpt.com/codex/install.sh | CODEX_NON_INTERACTIVE=1 sh
curl -fsSL https://claude.ai/install.sh | bash

# Bun
curl -fsSL https://bun.sh/install | bash

# Clean
yay -Yc
yay -Scc

# Dotfiles
ln -sfn $HOME/.dotfiles/config/fuzzel $HOME/.config/fuzzel
ln -sfn $HOME/.dotfiles/config/ghostty $HOME/.config/ghostty
ln -sfn $HOME/.dotfiles/config/git/.gitconfig $HOME/.gitconfig
ln -sfn $HOME/.dotfiles/config/git/.gitignore_global $HOME/.gitignore_global
ln -sfn $HOME/.dotfiles/config/hypr $HOME/.config/hypr
ln -sfn $HOME/.dotfiles/config/niri $HOME/.config/niri
ln -sfn $HOME/.dotfiles/config/nvim $HOME/.config/nvim
ln -sfn $HOME/.dotfiles/config/spotify-launcher.conf $HOME/.config/spotify-launcher.conf
ln -sfn $HOME/.dotfiles/config/starship.toml $HOME/.config/starship.toml
ln -sfn $HOME/.dotfiles/config/waybar $HOME/.config/waybar
ln -sfn $HOME/.dotfiles/config/zsh/aliases.zsh $HOME/.oh-my-zsh/custom/aliases.zsh
ln -sfn $HOME/.dotfiles/config/zsh/path.zsh $HOME/.oh-my-zsh/custom/path.zsh
