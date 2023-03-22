#!/bin/bash

echo "Setting Linux..."

export DEBIAN_FRONTEND=noninteractive

# PPAs
sudo apt-add-repository ppa:chris-lea/redis-server -y
sudo apt-add-repository ppa:ondrej/apache2 -y
sudo apt-add-repository ppa:ondrej/php -y

curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -

curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

curl -sS https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
echo "deb [arch=amd64] https://dl.google.com/linux/chrome/deb/ stable main" | sudo tee /etc/apt/sources.list.d/google-chrome.list

curl -sS https://download.spotify.com/debian/pubkey_0D811D58.gpg | sudo apt-key add -
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list

curl -sS https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" | sudo tee /etc/apt/sources.list.d/vscode.list

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
echo "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list

echo "deb [trusted=yes arch=amd64] https://download.konghq.com/insomnia-ubuntu/ default all" | sudo tee /etc/apt/sources.list.d/insomnia.list

wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list

wget -O - https://dbeaver.io/debs/dbeaver.gpg.key | sudo apt-key add -
echo "deb https://dbeaver.io/debs/dbeaver-ce /" | sudo tee /etc/apt/sources.list.d/dbeaver.list

sudo apt-key adv --fetch-keys https://mariadb.org/mariadb_release_signing_key.asc
echo "deb [arch=amd64,arm64,ppc64el,s390x] https://mirrors.xtom.nl/mariadb/repo/10.4/ubuntu focal main" | sudo tee /etc/apt/sources.list.d/mariadb.list

echo "deb [trusted=yes] https://repo.symfony.com/apt/ /" | sudo tee /etc/apt/sources.list.d/symfony-cli.list

sudo mkdir -p --mode=0755 /usr/share/keyrings
curl -fsSL https://pkg.cloudflare.com/cloudflare-main.gpg | sudo tee /usr/share/keyrings/cloudflare-main.gpg >/dev/null
echo 'deb [signed-by=/usr/share/keyrings/cloudflare-main.gpg] https://pkg.cloudflare.com/cloudflared focal main' | sudo tee /etc/apt/sources.list.d/cloudflared.list

# Update
sudo apt-get update
sudo apt-get upgrade -y

# Binaries
sudo apt-get install -y \
     ansible \
     cloudflared \
     curl \
     figlet \
     fish \
     git \
     graphviz \
     screenfetch \
     symfony-cli \
     zsh

# Oh My Zsh & Fish
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
curl -L https://get.oh-my.fish | fish /dev/stdin --noninteractive

# Scaleway
wget https://github.com/scaleway/scaleway-cli/releases/download/v1.20/scw_1.20_amd64.deb -O scw.deb
sudo apt-get install -y ./scw.deb && rm scw.deb

# Development
sudo apt-get install -y \
     php8.2-amqp php8.2-apcu php8.2-bcmath php8.2-cli php8.2-curl php8.2-fpm php8.2-gd php8.2-imagick php8.2-intl \
     php8.2-mbstring php8.2-mysql php8.2-redis php8.2-soap php8.2-sqlite3 php8.2-xdebug php8.2-xml php8.2-zip \
     php8.1-amqp php8.1-apcu php8.1-bcmath php8.1-cli php8.1-curl php8.1-fpm php8.1-gd php8.1-imagick php8.1-intl \
     php8.1-mbstring php8.1-mysql php8.1-redis php8.1-soap php8.1-sqlite3 php8.1-xdebug php8.1-xml php8.1-zip \
     php8.0-amqp php8.0-apcu php8.0-bcmath php8.0-cli php8.0-curl php8.0-fpm php8.0-gd php8.0-imagick php8.0-intl \
     php8.0-mbstring php8.0-mysql php8.0-redis php8.0-soap php8.0-sqlite3 php8.0-xdebug php8.0-xml php8.0-zip \
     php7.4-amqp php7.4-apcu php7.4-bcmath php7.4-cli php7.4-curl php7.4-fpm php7.4-gd php7.4-imagick php7.4-intl \
     php7.4-mbstring php7.4-mysql php7.4-redis php7.4-soap php7.4-sqlite3 php7.4-xdebug php7.4-xml php7.4-zip \
     php7.3-amqp php7.3-apcu php7.3-bcmath php7.3-cli php7.3-curl php7.3-fpm php7.3-gd php7.3-imagick php7.3-intl \
     php7.3-mbstring php7.3-mysql php7.3-redis php7.3-soap php7.3-sqlite3 php7.3-xdebug php7.3-xml php7.3-zip \
     php7.2-amqp php7.2-apcu php7.2-bcmath php7.2-cli php7.2-curl php7.2-fpm php7.2-gd php7.2-imagick php7.2-intl \
     php7.2-mbstring php7.2-mysql php7.2-redis php7.2-soap php7.2-sqlite3 php7.2-xdebug php7.2-xml php7.2-zip \
     apache2 \
     mariadb-server \
     nginx \
     nodejs \
     redis-server \
     yarn

# Apache
sudo a2enmod brotli http2 proxy_fcgi rewrite ssl vhost_alias

# NPM dependencies
sudo npm install -g npm-check-updates

# MySQL configuration
sudo mysql -u root -e "SET PASSWORD = PASSWORD('');"

# Composer
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer

# PHP Dependencies
composer global require laravel/installer

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

# Act
curl https://raw.githubusercontent.com/nektos/act/master/install.sh | sudo bash

# PhpStorm
if test ! $(which pstorm); then
  wget https://download-cdn.jetbrains.com/webide/PhpStorm-2022.3.tar.gz
  sudo tar xvf PhpStorm-2022.3.tar.gz --directory /opt/ && rm PhpStorm-2022.3.tar.gz
fi

# Stripe
wget https://github.com/stripe/stripe-cli/releases/download/v1.7.0/stripe_1.7.0_linux_x86_64.tar.gz
sudo tar xvf stripe_1.7.0_linux_x86_64.tar.gz --directory /usr/local/bin/ && rm stripe_1.7.0_linux_x86_64.tar.gz

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
