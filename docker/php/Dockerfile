ARG PHP_VERSION=8.4
FROM php:${PHP_VERSION}-fpm

ENV PATH "$PATH:/home/matthieu/.composer/vendor/bin"

ADD --chmod=0755 https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/
RUN install-php-extensions apcu bcmath exif gd intl opcache pcntl pdo_mysql pdo_pgsql redis soap zip @composer \
    && mv "$PHP_INI_DIR/php.ini-development" "$PHP_INI_DIR/php.ini" \
    && echo "memory_limit = -1" >> /usr/local/etc/php/conf.d/custom.ini

RUN apt-get update \
    && apt-get install -y git zip \
    && curl -sS https://get.symfony.com/cli/installer | bash \
    && mv ~/.symfony5/bin/symfony /usr/local/bin/symfony \
    && apt-get -y autoremove && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && useradd -m -u 1000 matthieu

USER matthieu

RUN git config --global user.email "matthieumota@gmail.com" \
    && git config --global user.name "Matthieu Mota" \
    && composer global require laravel/installer

WORKDIR /app
