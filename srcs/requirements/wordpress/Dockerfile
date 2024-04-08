FROM debian:bullseye

RUN apt-get update -y
RUN apt-get upgrade -y
RUN apt-get install php -y
RUN apt-get install php-cli -y
RUN apt-get install php-fpm -y
RUN apt-get install php-mysql -y
RUN apt-get install php-json -y
RUN apt-get install php-opcache -y
RUN apt-get install php-mbstring -y
RUN apt-get install php-xml -y
RUN apt-get install php-gd -y
RUN apt-get install php-curl -y
RUN apt-get install wget unzip -y

COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/

WORKDIR /var/www/html

RUN wget https://wordpress.org/latest.tar.gz
RUN tar -xvzf latest.tar.gz
RUN mv wordpress/* ./
RUN rmdir wordpress
RUN rm latest.tar.gz

RUN mkdir -p /run/php
RUN chown -R www-data:www-data /var/www/html
RUN find /var/www/html -type d -exec chmod 755 {} \;
RUN find /var/www/html -type f -exec chmod 644 {} \;

EXPOSE 9000

CMD [ "php-fpm7.4", "-F" ]