CREATE DATABASE IF NOT EXISTS mariadb;
CREATE USER IF NOT EXISTS 'abied-ch'@'localhost' IDENTIFIED BY 'Arthur54600wow';
GRANT ALL PRIVILEGES ON mariadb.* TO 'abied-ch'@'localhost';
FLUSH PRIVILEGES;