#!/bin/bash

sleep 10

until mysql -h"mariadb" -u"$SQL_USER" -p"$SQL_PWD" -e "show databases;" > /dev/null 2 > & 1; do
    echo "waiting for database connection..."
    sleep 1
done

# configuring wp
wp config create    --allow-root \
                    --dbname=$SQL_DATABASE \
                    --dbuser=$SQL_USER \
                    --dbpass=$SQL_PASSWORD \
                    --dbhost=mariadb:3306 \
                    --path='/var/www/wordpress'

# installing wp
wp core install     --allow-root \
                    --url="localhost:9000" \
                    --title="$SITE_NAME" \
                    --admin_user="$ADMIN_NAME" \
                    --admin-password="$ADMIN_PWD" \
                    --admin-email="$ADMIN_EMAIL" \
                    --path='/var/www/wordpress'

wp user create      $USER2 \
                    $USER2_EMAIL \
                    --allow-root \
                    --user-pass="$USER2_PWD" \
                    --role=editor
                    --path='/var/www/wordpress'

if [ ! -d "/run/php" ]; then
    mkdir -p /run/php
fi

/usr/sbin/php-fpm7.3 -F


wp user create abied-ch