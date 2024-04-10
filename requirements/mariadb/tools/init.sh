#!/bin/bash

mysql_install_db
mysqld_safe &
sleep 10

cat << EOF > /etc/mysql/init.sql
CREATE DATABASE $DB_NAME;
CREATE USER '$DB_USER'@'%' IDENTIFIED BY '$DB_PWD';
GRANT ALL PRIVILEGES ON *.* TO '$DB_USER'@'%' WITH GRANT OPTION;
FLUSH PRIVILEGES;
EOF

mysql -u root < /etc/mysql/init.sql

wait