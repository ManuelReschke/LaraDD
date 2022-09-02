FROM php:8.0-fpm

# Set env specific configs
ENV DEBIAN_FRONTEND noninteractive

########################################################################################################################
### Install base packages and basic php extensions
########################################################################################################################

# Update dependencies ready
RUN apt-get update && apt-get upgrade -y

# Default software
RUN apt-get install -y \
    git \
    libzip-dev \
    zip \
    unzip \
    npm

########################################################################################################################
### PHP Configuration
########################################################################################################################

# We have to copy the php configuration instead of using a volume because
# we can't use sed command to replace remote ip on docker volumes.
# Docker volumes are always in use, so that sed can't save changed xdebug configuration.
COPY ./docker/container/php-fpm/docker.ini /usr/local/etc/php/conf.d/99-docker.ini

# PHP core extension
RUN docker-php-ext-install zip pdo pdo_mysql sockets

RUN apt-get update \
    && apt-get install -y zlib1g-dev libicu-dev g++ \
    && docker-php-ext-configure intl \
    && docker-php-ext-install intl

# Xdebug extension
RUN pecl install xdebug \
    && docker-php-ext-enable xdebug

# MongoDB Extension
# https://github.com/mongodb/mongo-php-driver/issues/138
RUN apt-get install -y libssl-dev pkg-config \
    && pecl install mongodb \
    && docker-php-ext-enable mongodb

# Tideways PHP Profiling Ext
# Github: https://github.com/tideways/php-profiler-extension
RUN cd /usr/local/ \
    && git clone https://github.com/tideways/php-profiler-extension.git \
    && cd php-profiler-extension \
    && phpize \
    && ./configure --with-php-config=/usr/local/bin/php-config \
    && make && make install \
    && docker-php-ext-enable tideways_xhprof

# Install Redis extension
RUN pecl install redis-5.3.7 && docker-php-ext-enable redis

# Composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php composer-setup.php --install-dir=/usr/bin --filename=composer \
    && php -r "unlink('composer-setup.php');"
