#!/bin/sh

echo "Setting Mac..."

if test ! $(which brew); then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

  eval "$(/usr/local/Homebrew/bin/brew shellenv)"
fi

# Taps
brew tap buo/cask-upgrade
brew tap nektos/tap
brew tap stripe/stripe-cli
brew tap symfony-cli/tap

# Update
brew update

# Binaries
brew install \
     act \
     dnsmasq \
     fastfetch \
     git \
     mas \
     pkg-config \
     stripe \
     symfony-cli

# Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# Development
brew install \
     php \
     composer \
     httpd \
     imagemagick \
     mariadb \
     node \
     nginx

# NPM dependencies
npm install -g npm-check-updates

# MySQL configuration
brew services start mariadb
sudo mysql -u root -e "SET PASSWORD = PASSWORD('');"

# PHP modules
$HOMEBREW_PREFIX/opt/php/bin/pecl install apcu imagick redis xdebug

for Php in '8.3'; do
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
     docker \
     firefox \
     google-drive \
     httpie \
     iterm2 \
     keepassx \
     meld \
     microsoft-office \
     spotify \
     tableplus \
     transmission \
     vagrant \
     virtualbox \
     visual-studio-code \
     vlc

# Dotfiles
ln -s $HOME/.dotfiles/config/git/.gitconfig $HOME/.gitconfig
ln -s $HOME/.dotfiles/config/git/.gitignore_global $HOME/.gitignore_global
ln -s $HOME/.dotfiles/config/zsh/aliases.zsh $HOME/.oh-my-zsh/custom/aliases.zsh
ln -s $HOME/.dotfiles/config/zsh/path.zsh $HOME/.oh-my-zsh/custom/path.zsh
ln -s $HOME/.dotfiles/config/.wezterm.lua $HOME/.wezterm.lua
ln -s $HOME/.dotfiles/config/nvim $HOME/.config/nvim
