#!/bin/bash

cd /var/www/html

# Download WP-CLI
if [ ! -f wp-cli.phar ]; then
    echo "Downloading WP-CLI..."
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    chmod +x wp-cli.phar
else
    echo "WP-CLI already downloaded."
fi

# Download WordPress core
if [ ! -f wp-config.php ]; then
    echo "Downloading WordPress..."
    ./wp-cli.phar core download --allow-root

    echo "Creating wp-config.php..."
    ./wp-cli.phar config create --dbname=wordpress --dbuser=abied-ch --dbpass=password --dbhost=mariadb --allow-root
else
    echo "WordPress is already setup."
fi

# Install WordPress if not already installed
if ! $(./wp-cli.phar core is-installed --allow-root); then
    echo "Installing WordPress..."
    ./wp-cli.phar core install --url=localhost --title=inception --admin_user=admin --admin_password=admin --admin_email=admin@admin.com --allow-root
else
    echo "WordPress is already installed."
fi

# Start PHP-FPM
echo "Starting PHP-FPM..."
php-fpm7.4 -F
