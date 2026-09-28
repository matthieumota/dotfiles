ARG PHP_VERSION=8.4
FROM php:${PHP_VERSION}-fpm

ADD --chmod=0755 https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/
RUN install-php-extensions apcu bcmath exif gd intl opcache pcntl pdo_mysql pdo_pgsql redis soap zip @composer \
    && mv "$PHP_INI_DIR/php.ini-development" "$PHP_INI_DIR/php.ini" \
    && echo "memory_limit = -1" >> /usr/local/etc/php/conf.d/custom.ini

RUN apt-get update \
    && apt-get install -y git unzip \
    && apt-get clean && rm -rf /var/lib/apt/lists/* \
    && useradd -m -u 1000 matthieu

USER matthieu
WORKDIR /app
