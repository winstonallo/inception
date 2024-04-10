create database wordpress;
create user 'abied-ch'@'%' identified by 'password';
grant all privileges on *.* to 'abied-ch'@'%' with grant option;
flush privileges;