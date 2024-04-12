#!/bin/bash

if [ "$(ls -A $DB_DATADIR)" ]; then
    echo "INFO: Database system already initialized in $DB_DATADIR, skipping mysql_install_db."
else
    echo "INFO: Initializing the database system."
    mysql_install_db --user=$MYSQL_USER --basedir=$DB_BASEDIR --datadir=$DB_DATADIR
fi

mysqld_safe --general-log=1 --general-log-file=/var/log/mysql/general.log &

TIMEOUT=1000
INTERVAL=1
ELAPSED=0

echo "INFO: Waiting for the MySQL service to start.."
while ! mysqladmin ping -u root --silent; do
    sleep $INTERVAL
    ELAPSED=$(($ELAPSED + $INTERVAL))
    if [ $ELAPSED -ge $TIMEOUT ]; then
        echo "ERROR: MariaDB startup timed out after ${ELAPSED} seconds."
        exit 1
    fi
done

echo "INFO: MySQL running."

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
    echo "INFO: Database already initialized."
fi

wait