#!/bin/sh

echo "Setting Mac..."

if test ! $(which brew); then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Taps
brew tap buo/cask-upgrade
brew tap stripe/stripe-cli

# Update
brew update

# Binaries
brew install \
     dnsmasq \
     fastfetch \
     git \
     mas \
     starship \
     stripe \
     symfony-cli

# Development
brew install \
     php \
     composer \
     imagemagick \
     nvm

# Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
grep -qF "$HOMEBREW_PREFIX/bin/brew shellenv" ~/.zshrc || printf "\neval \"\$($HOMEBREW_PREFIX/bin/brew shellenv)\"\n" >> ~/.zshrc
grep -qF 'starship init zsh' ~/.zshrc || printf "eval \"\$(starship init zsh)\"\n" >> ~/.zshrc
grep -qF "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" ~/.zshrc || printf ". \"$HOMEBREW_PREFIX/opt/nvm/nvm.sh\"\n" >> ~/.zshrc

# NPM dependencies
nvm install node
npm install -g npm-check-updates

# PHP modules
$HOMEBREW_PREFIX/opt/php/bin/pecl install apcu imagick redis xdebug

for Php in '8.4'; do
    for Module in 'apcu' 'imagick' 'redis'; do
cat > $HOMEBREW_PREFIX/etc/php/"$Php"/conf.d/ext-"$Module".ini << EOF
[$Module]
extension="$Module.so"
EOF
    done

cat > $HOMEBREW_PREFIX/etc/php/"$Php"/conf.d/ext-xdebug.ini << EOF
[xdebug]
;zend_extension="xdebug.so"
EOF
done

# PHP Dependencies
composer global require laravel/installer

# Apps
brew install --cask \
     cyberduck \
     discord \
     firefox \
     google-chrome \
     google-drive \
     keepassxc \
     meld \
     orbstack \
     postman \
     spotify \
     tableplus \
     transmission \
     virtualbox \
     visual-studio-code \
     vlc \
     wezterm

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
