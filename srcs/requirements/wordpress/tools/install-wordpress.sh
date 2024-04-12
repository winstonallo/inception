#!/bin/bash

cd /var/www/html
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar

if [ ! -f wp-login.php ]; then
    ./wp-cli.phar core download --allow-root
else
    echo "INFO: WordPress core files already exist, skipping download."
fi

if [ ! -f wp-config.php ]; then
    ./wp-cli.phar config create --dbname=$DB_NAME --dbuser=$DB_ADMIN_USER --dbpass=$DB_ADMIN_PWD --dbhost=mariadb --allow-root
else
    echo "INFO: wp-config.php already exists, skipping configuration creation."
fi

if ! ./wp-cli.phar core is-installed --allow-root; then
    ./wp-cli.phar core install --url=localhost --title=inception --admin_user=$DB_ADMIN_USER --admin_password=$DB_ADMIN_PWD --admin_email=admin@admin.com --allow-root
else
    echo "INFO: WordPress is already installed, skipping installation."
fi

cat << EOF


----https://localhost:443----
--------abied-ch.42.fr-------
EOF

php-fpm7.4 -F
