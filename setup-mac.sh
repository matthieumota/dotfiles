#!/bin/sh

echo "Setting Mac..."

if test ! $(which brew); then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

  eval "$(/usr/local/Homebrew/bin/brew shellenv)"
fi

# Taps
brew tap buo/cask-upgrade
brew tap nektos/tap
brew tap shivammathur/php
brew tap stripe/stripe-cli
brew tap symfony-cli/tap

# Update
brew update

# Binaries
brew install \
     act \
     ansible \
     cloudflared \
     dnsmasq \
     figlet \
     fish \
     git \
     graphviz \
     mas \
     pkg-config \
     screenfetch \
     scw \
     stripe \
     symfony-cli

# Oh My Zsh & Fish
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
curl -L https://get.oh-my.fish | fish /dev/stdin --noninteractive

# Development
brew install \
     php \
     php@8.2 \
     php@8.1 \
     shivammathur/php/php@8.0 \
     shivammathur/php/php@7.4 \
     shivammathur/php/php@7.3 \
     shivammathur/php/php@7.2 \
     composer \
     httpd \
     imagemagick \
     mariadb \
     node \
     nginx \
     rabbitmq-c \
     redis \
     wp-cli

# NPM dependencies
npm install -g npm-check-updates

# MySQL configuration
brew services start mariadb
sudo mysql -u root -e "SET PASSWORD = PASSWORD('');"

# PHP modules
$HOMEBREW_PREFIX/opt/php/bin/pecl install amqp apcu imagick redis xdebug
$HOMEBREW_PREFIX/opt/php@8.2/bin/pecl install amqp apcu imagick redis xdebug
$HOMEBREW_PREFIX/opt/php@8.1/bin/pecl install amqp apcu imagick redis xdebug
$HOMEBREW_PREFIX/opt/php@8.0/bin/pecl install amqp apcu imagick redis xdebug
$HOMEBREW_PREFIX/opt/php@7.4/bin/pecl install amqp apcu imagick redis xdebug
$HOMEBREW_PREFIX/opt/php@7.3/bin/pecl install amqp apcu imagick redis xdebug
$HOMEBREW_PREFIX/opt/php@7.2/bin/pecl install amqp apcu imagick redis xdebug

for Php in '7.2' '7.3' '7.4' '8.0' '8.1' '8.2' '8.3'; do
    for Module in 'amqp' 'apcu' 'imagick' 'redis'; do
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
brew cask install \
     cyberduck \
     discord \
     docker \
     firefox \
     google-chrome \
     google-drive \
     insomnia \
     iterm2 \
     keepassx \
     meld \
     microsoft-office \
     phpstorm \
     spotify \
     sublime-text \
     tableplus \
     transmission \
     vagrant \
     virtualbox \
     visual-studio-code \
     vlc

# Dotfiles
ln -s $HOME/.dotfiles/config/fish/aliases.fish $HOME/.config/fish/conf.d/aliases.fish
ln -s $HOME/.dotfiles/config/fish/path.fish $HOME/.config/fish/conf.d/path.fish
ln -s $HOME/.dotfiles/config/git/.gitconfig $HOME/.gitconfig
ln -s $HOME/.dotfiles/config/git/.gitignore_global $HOME/.gitignore_global
ln -s $HOME/.dotfiles/config/zsh/aliases.zsh $HOME/.oh-my-zsh/custom/aliases.zsh
ln -s $HOME/.dotfiles/config/zsh/path.zsh $HOME/.oh-my-zsh/custom/path.zsh
