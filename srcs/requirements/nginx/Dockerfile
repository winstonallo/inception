FROM debian:buster

RUN apt update && \
    apt install nginx php-fpm -y && \
    mkdir -p /etc/nginx/ssl && \
    apt install openssl -y && \
    openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=AT/ST=IDF/L=Vienna/O=42/OU=abied-ch.42.fr/CN=localhost" && \
    cat /etc/nginx/ssl/inception.crt > ~/inception.crt &&\
    mkdir -p /var/run/nginx
COPY conf/nginx.conf /etc/nginx/nginx.conf
RUN echo "<?php phpinfo(); ?>" > /var/www/html/index.php && \
    chown -R www-data:www-data /var/www/html && \
    chmod 755 /var/www/html
CMD [ "nginx", "-g", "daemon off;"]