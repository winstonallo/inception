FROM debian:bullseye

RUN apt update
RUN apt upgrade
RUN apt install mariadb-server -y

COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/
COPY conf/init.sql /etc/mysql/

RUN mkdir -p /run/mysqld

CMD [ "mysqld_safe" ]