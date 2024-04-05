FROM debian:bullseye

RUN apt-get update -y
RUN apt-get install mariadb-server
RUN apt-get install mariadb-client

RUN mkdir -p /var/run/mysqld
RUN chown -R mysql:mysql /var/run/mysqld
RUN chmod +x /var/run/mysqld

EXPOSE 3306

COPY ./tools/start.sh /usr/local/bin/
COPY ./conf/wordpress.sql /usr/local/bin/
RUN chmod +x /usr/local/bin/mariadb.sh
RUN chmod +x /usr/local/bin/wordpress.sql

RUN mysql_secure_installation


ENTRYPOINT [ "/usr/local/bin/mariadb.sh" ]

CMD ["mysqld", "--bind-address=0.0.0.0"]