FROM debian:buster

RUN apt-get update\
    && apt-get install wget mariadb-client php-cli php-mysql php-gd php-xml php7.3-fpm sendmail -y\
    && rm -rf /var/lib/apt/lists/*

#Install wp-cli
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp

#Config php-fpm
RUN mkdir /run/php
RUN sed '/^listen =/s/\/run\/php\/php7.3-fpm.sock/9000/' -i /etc/php/7.3/fpm/pool.d/www.conf


#Prepare for wp setup
RUN mkdir -p /var/www/wordpress
COPY ./conf/install.sh /var/www/wordpress/install.sh
RUN touch /var/log/php7.3-fpm.log
RUN chown -R www-data:www-data /var/www/wordpress /run/php /var/log/php7.3-fpm.log

#Wordpress config
USER www-data
WORKDIR /var/www/wordpress

ENTRYPOINT ["/bin/sh", "/var/www/wordpress/install.sh"]
