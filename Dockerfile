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
    # intl
    && apt-get install -y libicu-dev \
    && docker-php-ext-install intl \
    # Git
    && apt-get -y install git

# Ajout Mysql
RUN docker-php-source extract \
	&& docker-php-ext-install pdo_mysql \
	&& docker-php-source delete

# Composer
COPY --from=composer:2 /usr/bin/composer /usr/local/bin/composer

# clean
RUN rm -rf /var/lib/apt/lists/* \
    && apt-get clean

ENV PATH "$PATH:/var/www/html/"

USER ${USER_ID}
