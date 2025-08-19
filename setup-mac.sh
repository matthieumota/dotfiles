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
     neovim \
     ripgrep \
     starship \
     stripe \
     symfony-cli

# Development
brew install \
     composer \
     go \
     imagemagick \
     php \
     python \
     rustup \
     nvm

# Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
grep -qF "$HOMEBREW_PREFIX/bin/brew shellenv" ~/.zshrc || printf "\neval \"\$($HOMEBREW_PREFIX/bin/brew shellenv)\"\n" >> ~/.zshrc
grep -qF 'starship init zsh' ~/.zshrc || printf "eval \"\$(starship init zsh)\"\n" >> ~/.zshrc
grep -qF "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" ~/.zshrc || printf ". \"$HOMEBREW_PREFIX/opt/nvm/nvm.sh\"\n" >> ~/.zshrc
grep -qF "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" ~/.zshrc || printf ". \"$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm\"\n" >> ~/.zshrc

# dnsmasq
echo "address=/bx/127.0.0.1" > $HOMEBREW_PREFIX/etc/dnsmasq.d/bx
mkdir -p /etc/resolver
echo "nameserver 127.0.0.1" > /etc/resolver/bx

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
     ghostty \
     google-chrome \
     google-drive \
     grandperspective \
     keepassxc \
     meld \
     orbstack \
     postman \
     spotify \
     tableplus \
     transmission \
     virtualbox \
     visual-studio-code \
     vlc

# Dotfiles
ln -s $HOME/.dotfiles/config/ghostty $HOME/.config/ghostty
ln -s $HOME/.dotfiles/config/git/.gitconfig $HOME/.gitconfig
ln -s $HOME/.dotfiles/config/git/.gitignore_global $HOME/.gitignore_global
ln -s $HOME/.dotfiles/config/nvim $HOME/.config/nvim
ln -s $HOME/.dotfiles/config/starship.toml $HOME/.config/starship.toml
ln -s $HOME/.dotfiles/config/zsh/aliases.zsh $HOME/.oh-my-zsh/custom/aliases.zsh
ln -s $HOME/.dotfiles/config/zsh/path.zsh $HOME/.oh-my-zsh/custom/path.zsh
