ARG PHP_IMAGE=php:8.2-fpm

FROM ${PHP_IMAGE} as php

# Maj list paquet
RUN apt-get update \
    && apt-get install -y wget \
    # Xdebug
    && pecl install xdebug \
    && docker-php-ext-enable xdebug \
    # zip
    && apt-get install -y zlib1g-dev libzip-dev \
    && docker-php-ext-install zip \
    # Git
    && apt-get -y install git

ARG XdebugFile=/usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

RUN echo "xdebug.mode=develop" >> $XdebugFile \
    && echo "xdebug.start_with_request=on" >> $XdebugFile \
    && echo "xdebug.discover_client_host=on" >> $XdebugFile

# Composer
COPY --from=composer:2 /usr/bin/composer /usr/local/bin/composer

# clean
RUN rm -rf /var/lib/apt/lists/* \
    && apt-get clean

ENV PATH "$PATH:/var/www/html/"

USER ${USER_ID}
