#!/bin/sh

echo "Setting Mac..."

if ! command -v brew >/dev/null 2>&1; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Taps
brew tap buo/cask-upgrade

# Update
brew update

# Binaries
brew install \
     bat \
     chafa \
     eza \
     fastfetch \
     fd \
     fzf \
     gh \
     git \
     jq \
     lazydocker \
     lazygit \
     lazysql \
     mas \
     mole \
     neovim \
     pkgconf \
     ripgrep \
     starship \
     symfony-cli \
     tmux \
     wireguard-tools \
     yazi

# Development
brew install \
     composer \
     go \
     mise \
     php \
     pie \
     python \
     rustup

# Install Rust
$(brew --prefix rustup)/bin/rustup default stable

# Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
grep -qsF "$HOMEBREW_PREFIX/bin/brew shellenv" $HOME/.zprofile || printf "\neval \"\$($HOMEBREW_PREFIX/bin/brew shellenv)\"\n" >> $HOME/.zprofile
grep -qF 'starship init zsh' $HOME/.zshrc || printf "eval \"\$(starship init zsh)\"\n" >> $HOME/.zshrc
grep -qF 'mise activate zsh' $HOME/.zshrc || printf "eval \"\$(mise activate zsh)\"\n" >> $HOME/.zshrc

# NPM dependencies
export SHELL=$(command -v zsh)
eval "$(mise activate bash)"
mise use -g node
npm install -g npm-check-updates

# Install AI agents
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

# PHP Dependencies
composer global require laravel/installer

# Apps
brew install --cask \
     bitwarden \
     cyberduck \
     discord \
     font-fira-code-nerd-font \
     ghostty \
     google-chrome \
     google-drive \
     handy \
     meld \
     orbstack \
     spotify \
     visual-studio-code \
     windows-app \
     zed

# Dotfiles
ln -sfn $HOME/.dotfiles/config/ghostty $HOME/.config/ghostty
ln -sfn $HOME/.dotfiles/config/git/.gitconfig $HOME/.gitconfig
ln -sfn $HOME/.dotfiles/config/git/.gitignore_global $HOME/.gitignore_global
ln -sfn $HOME/.dotfiles/config/nvim $HOME/.config/nvim
ln -sfn $HOME/.dotfiles/config/starship.toml $HOME/.config/starship.toml
ln -sfn $HOME/.dotfiles/config/zsh/aliases.zsh $HOME/.oh-my-zsh/custom/aliases.zsh
ln -sfn $HOME/.dotfiles/config/zsh/fzf.zsh $HOME/.oh-my-zsh/custom/fzf.zsh
curl -fsSL https://raw.githubusercontent.com/junegunn/fzf-git.sh/main/fzf-git.sh -o $HOME/.oh-my-zsh/custom/fzf-git.zsh
ln -sfn $HOME/.dotfiles/config/zsh/path.zsh $HOME/.oh-my-zsh/custom/path.zsh
mkdir -p $HOME/.claude $HOME/.codex $HOME/.config/opencode
ln -sfn $HOME/.dotfiles/config/agents/AGENTS.md $HOME/.claude/CLAUDE.md
ln -sfn $HOME/.dotfiles/config/agents/AGENTS.md $HOME/.codex/AGENTS.md
ln -sfn $HOME/.dotfiles/config/agents/AGENTS.md $HOME/.config/opencode/AGENTS.md
