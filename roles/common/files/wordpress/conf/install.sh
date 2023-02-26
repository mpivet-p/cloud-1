#!/bin/bash

export WP_CLI_CACHE_DIR=/var/www/wordpress/.wp-cli/cache

sleep 20
if [ ! -f "/var/www/wordpress/wp-config.php" ]; then

    #If wp-config is missing we remove all files before reinstalling
    ls | grep -v install.sh | xargs rm -rf
    wp core download --path="/var/www/wordpress"
    wp config create\
        --dbhost=${DB_HOST}\
        --dbname=${DB_NAME}\
        --dbuser=${DB_USER}\
        --dbpass=${DB_PASS}

    sed -i '21s/^/define("WP_SITEURL", "https:\/\/{{ DOMAIN }}");\n/' /var/www/wordpress/wp-config.php
    sed -i '21s/^/define("WP_HOME", "https:\/\/{{ DOMAIN }}");\n/' /var/www/wordpress/wp-config.php
    sed -i '21s/^/define("FORCE_SSL_ADMIN", true);\n/' /var/www/wordpress/wp-config.php

    wp core install\
        --url=${WP_URL}\
        --title=${WP_TITLE}\
        --admin_name=${WP_ADMIN}\
        --admin_password=${WP_PASS}\
        --admin_email=${WP_MAIL}
    wp user create bob bob@example.com --role=author

fi

/usr/sbin/php-fpm7.3 --nodaemonize
