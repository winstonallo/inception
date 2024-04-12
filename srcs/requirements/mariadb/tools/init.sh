#!/bin/bash

mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
mysqld_safe --general-log=1 --general-log-file=/var/log/mysql/general.log &

TIMEOUT=1000
INTERVAL=1
ELAPSED=0

while ! mysqladmin ping -u root --silent; do
    sleep $INTERVAL
    ELAPSED=$(($ELAPSED + $INTERVAL))
    if [ $ELAPSED -ge $TIMEOUT ]; then
        echo "MariaDB startup timed out after ${ELAPSED} seconds."
        exit 1
    fi
    echo "Waiting for MariaDB to start... ${ELAPSED} seconds elapsed."
done

echo "MariaDB is up and running!"

DB_EXISTS=$(mysql -u root -sse "SELECT 1 FROM information_schema.schemata WHERE schema_name='$DB_NAME'")

if [ ! "$DB_EXISTS" ]; then
    cat << EOF > /etc/mysql/init.sql
    CREATE DATABASE $DB_NAME;
    CREATE USER '$DB_ADMIN_USER'@'%' IDENTIFIED BY '$DB_ADMIN_PWD';
    GRANT ALL PRIVILEGES ON *.* TO '$DB_ADMIN_USER'@'%' WITH GRANT OPTION;
    FLUSH PRIVILEGES;
    CREATE USER '$DB_USER'@'%' IDENTIFIED BY '$DB_PWD';
    GRANT SELECT, INSERT, UPDATE, DELETE ON database_name.* TO '$DB_USER'@'%';
    FLUSH PRIVILEGES;
EOF

    mysql -u root < /etc/mysql/init.sql
else
    echo "INFO: Database already installed - skipping initialization."
fi

wait
