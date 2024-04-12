#!/bin/bash

mysqld_safe &

TIMEOUT=30
INTERVAL=1
ELAPSED=0

# Wait for mariadb to start before proceeding
while ! mysqladmin ping -u root --silent; do
    sleep $INTERVAL
    ELAPSED=$(($ELAPSED + $INTERVAL))
    if [ $ELAPSED -ge $TIMEOUT ]; then
        echo "MariaDB startup timed out."
        exit 1
    fi
done

# Run MySQL query on database to check existence
#
# if not exists:
#   initialize
#
# else:
#   skip
DB_EXISTS=$(mysql -u root -sse "SELECT 1 FROM information_schema.schemata WHERE schema_name='$DB_NAME'")

if [ ! "$DB_EXISTS" ]; then
    cat << EOF > /etc/mysql/init.sql
    CREATE DATABASE $DB_NAME;
    CREATE USER '$DB_USER'@'%' IDENTIFIED BY '$DB_PWD';
    GRANT ALL PRIVILEGES ON *.* TO '$DB_USER'@'%' WITH GRANT OPTION;
    FLUSH PRIVILEGES;
EOF

    mysql -u root < /etc/mysql/init.sql
else
    echo "INFO: Database already installed - skipping initialization."
fi

# Wait for background processes to finish
wait