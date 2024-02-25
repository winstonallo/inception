#!bin/bash

service mysql start;

mysql -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DB}\`;"
mysql -e "CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'localhost' IDENTIFIED BY '${SQL_PWD}';"
mysql -e "GRANT ALL PRIVILEGES ON \`${SQL_DB}\`.* TO \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PWD}';"
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PWD}';"
mysql -e "FLUSH PRIVILEGES;"
mysqladmin -u root -p$SQL_ROOT_PWD shutdown
exec mysqld_safe