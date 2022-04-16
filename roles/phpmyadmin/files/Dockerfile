FROM debian:buster

RUN apt update\
    && apt install wget php-mysql php7.3-mysql php7.3-fpm mariadb-client -y\
    && rm -rf /var/lib/apt/lists/*

#Downloading and preparing phpmyadmin
RUN mkdir -p /var/www/phpmyadmin
WORKDIR /var/www/phpmyadmin
RUN wget https://www.phpmyadmin.net/downloads/phpMyAdmin-latest-all-languages.tar.gz
RUN tar xvf phpMyAdmin-latest-all-languages.tar.gz --strip-components=1
COPY ./config.inc.php .
RUN chmod 660 config.inc.php

#Config php-fpm
RUN sed '/^listen =/s/\/run\/php\/php7.3-fpm.sock/9001/' -i /etc/php/7.3/fpm/pool.d/www.conf

#Creating dirs/files and setting perms
RUN mkdir /run/php
RUN touch /var/log/php7.3-fpm.log
RUN chown -R www-data:www-data /var/www/phpmyadmin /run/php /var/log/php7.3-fpm.log

USER www-data

ENTRYPOINT ["/usr/sbin/php-fpm7.3", "--nodaemonize"]
