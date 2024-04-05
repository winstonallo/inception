FROM debian:bullseye

RUN apt-get update -y
RUN apt-get upgrade -y
RUN apt-get install mariadb-server -y
RUN apt-get install mariadb-client -y

RUN mkdir -p /var/run/mysqld
RUN chown -R mysql:mysql /run/mysqld
RUN chmod +x /run/mysqld
RUN chown -R mysql:mysql /var/lib/mysql
RUN chmod -R 755 /var/lib/mysql
EXPOSE 3306

COPY ./tools/start.sh /usr/local/bin/
COPY ./conf/wordpress.sql /usr/local/bin/
RUN chmod +x /usr/local/bin/start.sh
RUN chmod +x /usr/local/bin/wordpress.sql

ENTRYPOINT [ "/usr/local/bin/start.sh" ]

CMD ["mysqld", "--bind-address=0.0.0.0"]