FROM debian:bullseye

RUN apt-get update
RUN apt-get install wget -y
RUN apt-get install curl -y
RUN apt-get install bash -y
RUN apt-get install php -y
RUN apt-get install php-cgi -y
RUN apt-get install php-mysql -y
RUN apt-get install php-fpm -y

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp

COPY ./conf/www.conf /etc/php/7.3/fpm/pool.d/

RUN wget https://de-at.wordpress.org/latest-de_AT.tar.gz
RUN tar -xzf latest-de_AT.tar.gz
RUN mv wordpress/* .
RUN rm -rf latest_AT.tar.gz
RUN rm -rf wordpress

RUN mkdir /run/php

RUN sed -i "s/username_here/$MYSQL_USER/g" wp-config-sample.php
RUN sed -i "s/password_here/$MYSQL_ROOT_PASSWORD/g" wp-config-sample.php
RUN sed -i "s/locahost/$MYSQL_HOSTNAME/g" wp-config-sample.php
RUN sed -i "s/database_name_here/$MYSQL_DATABASE/g" wp-config-sample.php
RUN cp wp-config-sample.php wp-config.php

WORKDIR /var/www/html/

EXPOSE 9000

CMD ["/usr/sbin/php-fpm7.4", "-F"]



