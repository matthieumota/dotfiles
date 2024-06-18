ARG PHP_VERSION=8.2
FROM php:${PHP_VERSION}-fpm

ARG UNAME=matthieu
ARG UID=1000
ARG GID=1000
ARG EMAIL=matthieumota@gmail.com
ARG NAME=Matthieu Mota
ARG CODE_PATH=/home/${UNAME}/Code

ENV PATH "$PATH:/home/${UNAME}/.composer/vendor/bin"

ADD --chmod=0755 https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/
RUN install-php-extensions apcu bcmath intl opcache pdo_mysql soap zip \
    && mv "$PHP_INI_DIR/php.ini-development" "$PHP_INI_DIR/php.ini"

RUN apt-get update \
    && apt-get install -y git zip \
    && groupadd -g ${GID} ${UNAME} \
    && useradd -u ${UID} -g ${GID} -m ${UNAME} \
    && chown ${UNAME}:${UNAME} /home/${UNAME} \
    && curl -sLS https://getcomposer.org/installer | php -- --install-dir=/usr/bin/ --filename=composer \
    && curl -sS https://get.symfony.com/cli/installer | bash \
    && mv ~/.symfony5/bin/symfony /usr/local/bin/symfony \
    && apt-get -y autoremove && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

USER ${UNAME}

RUN git config --global user.email "${EMAIL}" \
    && git config --global user.name "${NAME}" \
    && composer global require laravel/installer

WORKDIR ${CODE_PATH}
