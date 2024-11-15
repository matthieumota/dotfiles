#!/bin/bash

echo "Setting Ubuntu..."

export DEBIAN_FRONTEND=noninteractive

# PPAs
sudo apt-add-repository ppa:ondrej/php -y

curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_23.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list

curl -sS https://download.spotify.com/debian/pubkey_6224F9941A8AA6D1.gpg | sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/spotify.gpg
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list

curl -fsSL https://packages.microsoft.com/keys/microsoft.asc | sudo gpg --dearmor -o /etc/apt/keyrings/packages.microsoft.gpg
echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" | sudo tee /etc/apt/sources.list.d/vscode.list

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list

curl -SsL https://packages.httpie.io/deb/KEY.gpg | sudo gpg --dearmor -o /usr/share/keyrings/httpie.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/httpie.gpg] https://packages.httpie.io/deb ./" | sudo tee /etc/apt/sources.list.d/httpie.list > /dev/null

curl -1sLf 'https://dl.cloudsmith.io/public/symfony/stable/setup.deb.sh' | sudo -E bash

wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list

wget -O- https://www.virtualbox.org/download/oracle_vbox_2016.asc | sudo gpg --yes --output /usr/share/keyrings/oracle-virtualbox-2016.gpg --dearmor
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/oracle-virtualbox-2016.gpg] http://download.virtualbox.org/virtualbox/debian $(lsb_release -cs) contrib" | sudo tee /etc/apt/sources.list.d/virtualbox.list

# Update
sudo apt-get update
sudo apt-get upgrade -y

# Binaries
sudo apt-get install -y \
     curl \
     fastfetch \
     git \
     meld \
     nullmailer \
     symfony-cli \
     zsh

# Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# Development
sudo apt-get install -y \
     php8.3-apcu php8.3-bcmath php8.3-cli php8.3-curl php8.3-fpm php8.3-gd php8.3-imagick php8.3-intl \
     php8.3-mbstring php8.3-mysql php8.3-redis php8.3-soap php8.3-sqlite3 php8.3-xdebug php8.3-xml php8.3-zip \
     mariadb-server \
     nginx \
     nodejs

# NPM dependencies
sudo npm install -g npm-check-updates

# MySQL configuration
sudo mysql -u root -e "SET PASSWORD = PASSWORD('');"

# Composer
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer

# PHP Dependencies
composer global require laravel/installer

# Apps
sudo apt-get install -y \
     code \
     gthumb \
     httpie \
     keepassx \
     spotify-client \
     vagrant \
     virtualbox-7.0 \
     vlc

# Discord
wget "https://discordapp.com/api/download?platform=linux&format=deb" -O discord.deb
sudo apt-get install -y ./discord.deb && rm discord.deb

# Docker
sudo apt-get install -y docker-ce
sudo usermod -aG docker $USER

# Act
curl https://raw.githubusercontent.com/nektos/act/master/install.sh | sudo bash

# Stripe
wget https://github.com/stripe/stripe-cli/releases/download/v1.19.2/stripe_1.19.2_linux_x86_64.tar.gz
sudo tar xvf stripe_1.19.2_linux_x86_64.tar.gz --directory /usr/local/bin/ && rm stripe_1.19.2_linux_x86_64.tar.gz

sudo chown -R root:root /usr/local/bin/

# Dotfiles
ln -s $HOME/.dotfiles/config/git/.gitconfig $HOME/.gitconfig
ln -s $HOME/.dotfiles/config/git/.gitignore_global $HOME/.gitignore_global
ln -s $HOME/.dotfiles/config/zsh/aliases.zsh $HOME/.oh-my-zsh/custom/aliases.zsh
ln -s $HOME/.dotfiles/config/zsh/path.zsh $HOME/.oh-my-zsh/custom/path.zsh
ln -s $HOME/.dotfiles/config/.wezterm.lua $HOME/.wezterm.lua
ln -s $HOME/.dotfiles/config/nvim $HOME/.config/nvim
