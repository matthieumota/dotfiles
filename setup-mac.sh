#!/bin/sh

echo "Setting Mac..."

if test ! $(which brew); then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

# Taps
brew tap buo/cask-upgrade
brew tap homebrew/cask-drivers
brew tap nektos/tap
brew tap stripe/stripe-cli

# Update
brew update

# Binaries
brew install \
     act \
     ansible \
     dnsmasq \
     figlet \
     fish \
     git \
     graphviz \
     mas \
     pkg-config \
     screenfetch \
     scw \
     stripe

# Oh My Zsh & Fish
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
curl -L https://get.oh-my.fish | fish /dev/stdin --noninteractive

# Development
brew install \
     php \
     php@7.4 \
     php@7.3 \
     php@7.2 \
     composer \
     httpd \
     imagemagick \
     mariadb \
     node \
     nginx \
     rabbitmq-c \
     redis \
     wp-cli \
     yarn

# NPM dependencies
npm install -g npm-check-updates

# MySQL configuration
brew services start mariadb
sudo mysql -u root -e "SET PASSWORD = PASSWORD('');"

# PHP modules
/usr/local/opt/php/bin/pecl install amqp apcu imagick redis xdebug
/usr/local/opt/php@7.4/bin/pecl install amqp apcu imagick redis xdebug
/usr/local/opt/php@7.3/bin/pecl install amqp apcu imagick redis xdebug
/usr/local/opt/php@7.2/bin/pecl install amqp apcu imagick redis xdebug

for Php in '7.2' '7.3' '7.4' '8.0'; do
    for Module in 'amqp' 'apcu' 'imagick' 'redis'; do
cat > /usr/local/etc/php/"$Php"/conf.d/ext-"$Module".ini << EOF
[$Module]
extension="$Module.so"
EOF
    done

cat > /usr/local/etc/php/"$Php"/conf.d/ext-xdebug.ini << EOF
[xdebug]
;zend_extension="xdebug.so"
EOF
done

# PHP Dependencies
composer global require laravel/installer

# Symfony
curl -sS https://get.symfony.com/cli/installer | bash
mv $HOME/.symfony/bin/symfony /usr/local/bin/symfony

# Apps
brew cask install \
     cyberduck \
     discord \
     docker \
     firefox \
     google-backup-and-sync \
     google-chrome \
     hp-easy-start \
     insomnia \
     iterm2 \
     keepassx \
     microsoft-office \
     ngrok \
     phpstorm \
     slack \
     sourcetree \
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
