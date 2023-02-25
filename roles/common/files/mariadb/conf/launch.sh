#!/bin/bash

if [ ! -f /var/lib/mysql/ibdata1 ]; then
    
    mysql_install_db --user=mysql --datadir="/var/lib/mysql"

    /usr/bin/mysqld_safe --defaults-file=/etc/mysql/my.cnf &
    sleep 2

    mysql -u root --password="" -e "CREATE DATABASE ${DB_NAME}"
    echo "USE ${DB_NAME};
            GRANT ALL ON *.* TO '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASS}';
            GRANT ALL ON *.* TO '${DB_USER}'@'localhost' IDENTIFIED BY '${DB_PASS}';
FLUSH PRIVILEGES;
            FLUSH PRIVILEGES;" | mysql -u root --password=""
    echo "ALTER USER 'root'@'localhost' IDENTIFIED BY 'no-root-allowed';
	    FLUSH PRIVILEGES;" | mysql -u root --password=""
    sleep 10
    pkill mariadbd

fi

/usr/bin/mysqld_safe --user=mysql --datadir=/var/lib/mysql
