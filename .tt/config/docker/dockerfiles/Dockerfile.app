FROM php:7.4.8-apache

# Variables
ENV APACHE_LOG_DIR=/var/log/apache2

# Copy application and configuration files.
COPY . /var/www/html
COPY .tt/config/docker/drush/drushrc.php /root/.drush/drushrc.php
COPY .tt/config/docker/apache2/000-default.conf /etc/apache2/sites-available/000-default.conf
COPY .tt/config/docker/drush/drushrc.php /root/.drush/drushrc.php

RUN set -eux
RUN apt update -y
RUN apt install -y git nodejs libldb-dev libpq-dev libxml2-dev zlib1g-dev libpng-dev libonig-dev
RUN rm -fr /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN docker-php-ext-install -j5 gd mbstring mysqli pdo pdo_mysql shmop opcache
RUN a2enmod rewrite

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
RUN php -r "if (hash_file('sha384', 'composer-setup.php') === '756890a4488ce9024fc62c56153228907f1545c228516cbf63f885e036d37e9a59d27d63f46af1d4d07ee0f76181c7d3') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
RUN php composer-setup.php
RUN php -r "unlink('composer-setup.php');"
RUN mv composer.phar /usr/local/bin/composer

# RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -
# RUN npm install -g gulp-cli

RUN chmod +x /var/www/html/init.sh
RUN mkdir -p /var/www/html/web/sites/default/files/translations
RUN chown -R www-data:www-data /var/www/html/web/sites/default
RUN chmod -R 775 /var/www/html/web/sites/default/files

RUN service apache2 restart