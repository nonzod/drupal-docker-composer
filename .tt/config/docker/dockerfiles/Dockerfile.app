FROM php:7.4.8-apache

# Variables
ENV APACHE_LOG_DIR=/var/log/apache2

# Copy application and configuration files.
COPY . /var/www/html
COPY .tt/config/docker/drush/drushrc.php /root/.drush/drushrc.php
COPY .tt/config/docker/apache2/000-default.conf /etc/apache2/sites-available/000-default.conf
COPY .tt/config/docker/drush/drushrc.php /root/.drush/drushrc.php

RUN apt update -y
RUN apt install -y nodejs libldb-dev libpq-dev libxml2-dev zlib1g-dev libpng-dev libonig-dev
RUN rm -fr /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN set -eux; \
    curl -sL https://deb.nodesource.com/setup_12.x | bash -; \
    npm install -g gulp-cli; \
    mkdir -p /var/www/html/web/sites/default/files; \
    chown -R www-data:www-data /var/www/html; \
    chmod 775 /var/www/html/web/sites/default/files; \
    chown -R www-data:www-data /var/www/html
RUN docker-php-ext-install -j5 gd mbstring mysqli pdo pdo_mysql shmop opcache
RUN a2enmod rewrite
RUN service apache2 restart