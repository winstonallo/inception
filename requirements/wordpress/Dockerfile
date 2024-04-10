FROM debian:bullseye

RUN apt update
RUN apt upgrade
RUN apt install php-fpm -y

RUN mkdir -p /run/php

COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/

CMD [ "php-fpm7.4", "-F" ]
# -F:   Force to run in background and ignore daemon
