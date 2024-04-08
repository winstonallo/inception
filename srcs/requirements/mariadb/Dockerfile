FROM debian:bullseye

RUN apt-get update -y
RUN apt-get upgrade -y
RUN apt-get install mariadb-server -y
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/*
RUN mkdir /etc/init

COPY ./conf/init.sql /init/

COPY ./tools/entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT [ "entrypoint.sh" ]

CMD [ "mysqld" ]