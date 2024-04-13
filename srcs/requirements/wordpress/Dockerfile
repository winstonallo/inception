FROM debian:bullseye

RUN apt update
RUN apt upgrade
RUN apt install php-fpm -y
RUN apt install php-mysqli -y
RUN apt install curl -y

RUN mkdir -p /run/php

COPY conf/www.conf /etc/php/7.4/fpm/pool.d/
COPY tools/install-wordpress.sh .

RUN chmod +x install-wordpress.sh

ENTRYPOINT [ "./install-wordpress.sh" ]
