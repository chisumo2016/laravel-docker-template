# Official Docker Image  for PHP
FROM php:8.0-fpm

# Set Current WORKING Directory
WORKDIR /var/www/html/

#Install dependencies
RUN apt-get clean && apt-get update && apt-get upgrade -y &&  apt-get install -y \
    git \
    libcurl4-openssl-dev \
    libonig-dev\
    libpng-dev\
    libssl-dev \
    libicu-dev \
    libxml2-dev \
    libzip-dev \
    unzip \
    wget\
    zip \
    curl \
    tzdata

ARG INSTALL_PHPREDIS=false
RUN pecl install -o -f redis  \
    && rm -rf /tmp/pear \
    && docker-php-ext-enable redis

RUN docker-php-ext-configure intl

# Clear Cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

#PHP EXTENSIONS
RUN docker-php-ext-install \
    bcmath \
    ctype \
    exif \
    gd \
    mbstring \
    mysqli \
    opcache \
    pdo_mysql \
    pcntl \
    tokenizer \
    xml \
    zip \
    intl


# Install Composer from Official Docker Image \
# https://hub.docker.com/r/composer/
COPY --from=composer:2.1.3 /usr/bin/composer /usr/bin/composer
#RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer
