#!/bin/sh

set -e

# Initialize the MariaDB data directory
mysql_install_db > /dev/null

# Start the mariadb service in the background
mysqld_safe --bind-address=0.0.0.0 &

# Wait for the MySQL daemon to start and for the socket to become available
while ! test -S "/run/mysqld/mysqld.sock"; do
    sleep 1
done

# Secure the installation and set up the initial database
mysql -u root <<-EOF
-- Set the root password
ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';

-- Remove anonymous users
DELETE FROM mysql.user WHERE User='';

-- Disallow root login remotely
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');

-- Remove test database and access to it
DROP DATABASE IF EXISTS test;
DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';

-- Reload privilege tables
FLUSH PRIVILEGES;
EOF

# Create the WordPress database and user, and grant privileges
mysql -u root -p"$MYSQL_ROOT_PASSWORD" <<-EOF
CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;
CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_USER_PASSWORD';  # Assuming you introduce MYSQL_USER_PASSWORD for the WordPress user
GRANT ALL ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';
FLUSH PRIVILEGES;
EOF

# Import the WordPress SQL file
mysql -u root -p"$MYSQL_ROOT_PASSWORD" $MYSQL_DATABASE < /usr/local/bin/wordpress.sql

# The script will not reach this point if the database import fails
# If you want to run mysqld directly and keep it in the foreground (to prevent the container from exiting), use exec:
exec mysqld --bind-address=0.0.0.0
