#!/bin/bash

echo "Setting Linux..."

export DEBIAN_FRONTEND=noninteractive

## PPAs
sudo apt-add-repository ppa:chris-lea/redis-server -y
sudo apt-add-repository ppa:ondrej/apache2 -y
sudo apt-add-repository ppa:ondrej/php -y

curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -

curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

curl -sS https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
echo "deb [arch=amd64] https://dl.google.com/linux/chrome/deb/ stable main" | sudo tee /etc/apt/sources.list.d/google-chrome.list

curl -sS https://download.spotify.com/debian/pubkey.gpg | sudo apt-key add - 
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list

curl -sS https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" | sudo tee /etc/apt/sources.list.d/vscode.list

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
echo "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list

wget --quiet -O - https://insomnia.rest/keys/debian-public.key.asc | sudo apt-key add -
echo "deb https://dl.bintray.com/getinsomnia/Insomnia /" | sudo tee /etc/apt/sources.list.d/insomnia.list

wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list

wget -O - https://dbeaver.io/debs/dbeaver.gpg.key | sudo apt-key add -
echo "deb https://dbeaver.io/debs/dbeaver-ce /" | sudo tee /etc/apt/sources.list.d/dbeaver.list

sudo apt-key adv --fetch-keys https://mariadb.org/mariadb_release_signing_key.asc
echo "deb [arch=amd64,arm64,ppc64el] http://mirrors.supportex.net/mariadb/repo/10.4/ubuntu focal main" | sudo tee /etc/apt/sources.list.d/mariadb.list

# Update
sudo apt-get update
sudo apt-get upgrade -y

# Binaries
sudo apt-get install -y \
     ansible \
     curl \
     figlet \
     fish \
     git \
     graphviz \
     screenfetch \
     zsh

# Oh My Zsh & Fish
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
curl -L https://get.oh-my.fish | fish

# Scaleway
wget https://github.com/scaleway/scaleway-cli/releases/download/v1.20/scw_1.20_amd64.deb -O scw.deb
sudo apt-get install -y ./scw.deb && rm scw.deb

# Development
sudo apt-get install -y \
     php7.4-cli php7.4-curl php7.4-fpm php7.4-gd php7.4-intl \
     php7.4-mbstring php7.4-mysql php7.4-sqlite3 php7.4-xml php7.4-zip \
     php7.3-cli php7.3-curl php7.3-fpm php7.3-gd php7.3-intl \
     php7.3-mbstring php7.3-mysql php7.3-sqlite3 php7.3-xml php7.3-zip \
     php7.2-cli php7.2-curl php7.2-fpm php7.2-gd php7.2-intl \
     php7.2-mbstring php7.2-mysql php7.2-sqlite3 php7.2-xml php7.2-zip \
     php-amqp php-apcu php-imagick php-redis php-xdebug \
     apache2 \
     mariadb-server \
     nginx \
     nodejs \
     redis-server \
     yarn

# Apache
sudo a2enmod http2 proxy_fcgi ssl vhost_alias

# NPM dependencies
sudo npm install -g npm-check-updates

# MySQL configuration
sudo mysql -u root -e "ALTER USER root@localhost IDENTIFIED BY ''; FLUSH PRIVILEGES;"

# Composer
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer

# PHP Dependencies
composer global require laravel/installer

# Symfony
wget https://get.symfony.com/cli/installer -O - | bash
sudo mv $HOME/.symfony/bin/symfony /usr/local/bin/symfony

# WP-CLI
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
sudo mv wp-cli.phar /usr/local/bin/wp-cli

# Apps
sudo apt-get install -y \
     bleachbit \
     code \
     dbeaver-ce \
     filezilla \
     google-chrome-stable \
     insomnia \
     keepassx \
     openjdk-11-jdk \
     spotify-client \
     sublime-text \
     vagrant \
     virtualbox \
     vlc

# Discord
wget "https://discordapp.com/api/download?platform=linux&format=deb" -O discord.deb
sudo apt-get install -y ./discord.deb && rm discord.deb

# Docker
sudo apt-get install -y docker-ce
sudo curl -L "https://github.com/docker/compose/releases/download/1.26.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo usermod -aG docker $USER

# Drone CLI
curl -L https://github.com/drone/drone-cli/releases/latest/download/drone_linux_amd64.tar.gz | tar zx
sudo install -t /usr/local/bin drone && rm drone

# Ngrok
wget https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip
sudo unzip ngrok-stable-linux-amd64.zip -d /usr/local/bin/ && rm ngrok-stable-linux-amd64.zip

# Slack
wget https://downloads.slack-edge.com/linux_releases/slack-desktop-4.4.3-amd64.deb -O slack.deb
sudo apt-get install -y ./slack.deb && rm slack.deb

# PhpStorm
if test ! $(which pstorm); then
  wget https://download-cf.jetbrains.com/webide/PhpStorm-2020.1.2.tar.gz
  sudo tar xvf PhpStorm-2020.1.2.tar.gz --directory /opt/ && rm PhpStorm-2020.1.2.tar.gz
fi

# Postfix
sudo debconf-set-selections <<< "postfix postfix/mailname string localhost"
sudo debconf-set-selections <<< "postfix postfix/main_mailer_type string 'Internet Site'"
sudo apt-get install -y mailutils

sudo chown -R root:root /usr/local/bin/

# Dotfiles
ln -s $HOME/.dotfiles/config/fish/aliases.fish $HOME/.config/fish/conf.d/aliases.fish
ln -s $HOME/.dotfiles/config/fish/path.fish $HOME/.config/fish/conf.d/path.fish
ln -s $HOME/.dotfiles/config/git/.gitconfig $HOME/.gitconfig
ln -s $HOME/.dotfiles/config/git/.gitignore_global $HOME/.gitignore_global
ln -s $HOME/.dotfiles/config/zsh/aliases.zsh $HOME/.oh-my-zsh/custom/aliases.zsh
ln -s $HOME/.dotfiles/config/zsh/path.zsh $HOME/.oh-my-zsh/custom/path.zsh
