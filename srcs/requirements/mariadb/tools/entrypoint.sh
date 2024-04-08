#!/bin/bash

mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld

if [ ! -d "/var/lib/mysql/mysql" ]; then
    mysql_install_db
fi

mysqld_safe &

while ! mysqladmin ping --silent; do
    sleep 1
done

for script in /init/*.sql; do
    mysql --user=root --password="root-pwd" < "$script"
done

mysqladmin --user=root --password="root-pwd" shutdown

exec mysqld_safe