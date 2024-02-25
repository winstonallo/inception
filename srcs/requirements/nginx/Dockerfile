# specify base image (distro: debian, version: buster)
FROM debian:buster

# RUN executes the given cmd line on container startup
RUN \ 
    # update package list & installs nginx
    # -y option answers yes if prompted for confirmations
    apt update && \
    apt install nginx php-fpm -y && \
    # mkdir for ssl certificates & install ssl
    mkdir -p /etc/nginx/ssl && \
    apt install openssl -y && \
    # use openssl to generate a self-signed SSL certificate and key
    # -subj option specifies the name for the certif
    openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=AT/ST=IDF/L=Vienna/O=42/OU=abied-ch.42.fr/UID=abied-ch/CN=localhost" && \
    # mkdir for nginx run files    
    mkdir -p /var/run/nginx

# COPY: copies files from local machine to your image
COPY \
    # copy the locally stored config to the nginx image
    conf/nginx.conf /etc/nginx/nginx.conf

RUN \
    # create php file to display php info
    echo "<?php phpinfo(); ?>" > /var/www/html/index.php && \
    # change owner of dir & give full perms
    chown -R www-data:www-data /var/www/html && \
    chmod 755 /var/www/html

# execute cmd line once image is started
CMD \ 
    # start nginx in foreground
    [ "nginx", "-g", "daemon off;"]