#!/bin/bash

# sleep 10

until mysql -h"mariadb" -u"$SQL_USER" -p"$SQL_PWD" -e "show databases;" > /dev/null 2 > & 1; do
    echo "waiting for database connection..."
    sleep 1
done

# configuring wp
wp config create    --allow-root \
                    --dbname=$SQL_DB \
                    --dbuser=$SQL_ROOT \
                    --dbpass=$SQL_PWD \
                    --dbhost=mariadb:3306 \
                    --path='/var/www/wordpress'

# installing wp
wp core install     --allow-root \
                    --url="localhost:9000" \
                    --title="$DOMAIN" \
                    --admin_user="$SQL_ROOT" \
                    --admin-password="$SQL_ROOT_PWD" \
                    --admin-email="$SQL_ROOT_EMAIL" \
                    --path='/var/www/wordpress'

wp user create      $SQL_USER \
                    $SQL_USER_EMAIL \
                    --allow-root \
                    --user-pass="$SQL_USER_PWD" \
                    --role=editor
                    --path='/var/www/wordpress'

if [ ! -d "/run/php" ]; then
    mkdir -p /run/php
fi

/usr/sbin/php-fpm7.3 -F


wp user create abied-ch