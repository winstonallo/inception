#!/bin/sh

mysql_install_db

/etc/init.d/mysql start

mysql_secure_installation << _EOF_

Y
root4life
root4life
Y
n
Y
Y
_EOF_

echo "GRANT ALL ON *.* TO 'root'@'%' IDENTIFIED BY '$SQL_PWD'; FLUSH PRIVILEGES;" | mysql -uroot

echo "CREATE DATABASE IF NOT EXISTS $SQL_DB; GRANT ALL ON $SQL_DB.* TO '$SQL_USER'@'%' IDENTIFIED BY '$SQL_PWD'; FLUSH PRIVILEGES;" | mysql -u root

mysql -uroot -p$SQL_PWD $SQL_DB < /usr/local/bin/wordpress.sql

fi

/etc/init.d/mysql stop

exec "$@"