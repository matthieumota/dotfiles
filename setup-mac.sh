#!/bin/sh

echo "Setting Mac..."

if test ! $(which brew); then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Taps
brew tap buo/cask-upgrade

# Update
brew update

# Binaries
brew install \
     fastfetch \
     gh \
     git \
     lazygit \
     mas \
     mole \
     neovim \
     ripgrep \
     starship \
     symfony-cli

# Development
brew install \
     composer \
     go \
     nvm \
     php \
     pie \
     python \
     rustup

# Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
grep -qF "$HOMEBREW_PREFIX/bin/brew shellenv" ~/.zshrc || printf "\neval \"\$($HOMEBREW_PREFIX/bin/brew shellenv)\"\n" >> ~/.zshrc
grep -qF 'starship init zsh' ~/.zshrc || printf "eval \"\$(starship init zsh)\"\n" >> ~/.zshrc
grep -qF "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" ~/.zshrc || printf ". \"$HOMEBREW_PREFIX/opt/nvm/nvm.sh\"\n" >> ~/.zshrc
grep -qF "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" ~/.zshrc || printf ". \"$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm\"\n" >> ~/.zshrc

# NPM dependencies
nvm install node
npm install -g npm-check-updates
curl -fsSL https://gh.io/copilot-install | bash
curl -fsSL https://opencode.ai/install | bash
curl -fsSL https://chatgpt.com/codex/install.sh | CODEX_NON_INTERACTIVE=1 sh
curl -fsSL https://claude.ai/install.sh | bash

# Bun
curl -fsSL https://bun.sh/install | bash

# PHP modules
pie install apcu/apcu
pie install pecl/pcov
pie install phpredis/phpredis
pie install xdebug/xdebug

# PHP Dependencies
composer global require laravel/installer

# Apps
brew install --cask \
     arc \
     bitwarden \
     cyberduck \
     discord \
     firefox \
     font-fira-code-nerd-font \
     ghostty \
     google-chrome \
     google-drive \
     grandperspective \
     handy \
     meld \
     orbstack \
     postman \
     spotify \
     transmission \
     virtualbox \
     visual-studio-code \
     vlc \
     windows-app \
     zed

# Dotfiles
ln -s $HOME/.dotfiles/config/ghostty $HOME/.config/ghostty
ln -s $HOME/.dotfiles/config/git/.gitconfig $HOME/.gitconfig
ln -s $HOME/.dotfiles/config/git/.gitignore_global $HOME/.gitignore_global
ln -s $HOME/.dotfiles/config/nvim $HOME/.config/nvim
ln -s $HOME/.dotfiles/config/starship.toml $HOME/.config/starship.toml
ln -s $HOME/.dotfiles/config/zsh/aliases.zsh $HOME/.oh-my-zsh/custom/aliases.zsh
ln -s $HOME/.dotfiles/config/zsh/path.zsh $HOME/.oh-my-zsh/custom/path.zsh
