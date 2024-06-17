# Matthieu's Dotfiles

This project serves me to install, configure and maintain my development workflow on macOS / Ubuntu / Arch. Like that, I can easily reset a Mac or Linux machine and start fresh without installing manually !

I'm back to Arch Linux !

## A fresh macOS / Ubuntu / Arch

Before begin to re-install your machine, please check this steps :

- Did you commit and push on all your repositories ?
- Did you save all your documents not present in Cloud.

You can now install a clean macOS or Ubuntu.

## Usage

You can now clone this repository :

```bash
git clone git@github.com:matthieumota/dotfiles.git .dotfiles
cd .dotfiles
# On your Mac
./setup-mac.sh
# On your Ubuntu
./setup-ubuntu.sh
# On your Arch
./setup-arch.sh
```

## Tunnel SSH

Sometime, I need to create SSH tunnel. For instance, to create a tunnel on `3002` port on `1.2.3.4` server for `domain:80` :

```bash
ssh -R 3002:domain:80 -N cloud@1.2.3.4
```

After, we can use a nginx reverse proxy with :

```
location / {
    proxy_pass http://localhost:3002;
    proxy_set_header Host domain;
}
```

## Docker

To manage old PHP versions, I have 2 choices :

- Simply install old versions on machine with AUR or PPA.
- Use docker to manage old PHP versions containers, you can find configuration in `docker` folder.

You can use PHP FPM on Nginx (or Apache but no documented) :

```
location ~ \.php$ {
    # 9082 is exposed for PHP 8.2
    # 9081 is exposed for PHP 8.1
    fastcgi_pass 127.0.0.1:9081;
}
```

You can run PHP commands via container :

```bash
docker compose exec php81 php --version
docker compose exec php81 composer
```

Be careful to adapt `Dockerfile` and `compose.yaml` with your information (Project path, name, user id and group id from system) and you can build images

```bash
docker compose up -d --build
```

You can easily add other PHP versions.
