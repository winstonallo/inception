FROM debian:buster

# wget necessary for installing wordpress using its link
RUN \
    apt-get update && \
    apt-get -y install wget

# install php & its dependencies
RUN \
    apt-get install -y php7.3 \
    php-fpm \
    php-mysql \
    mariadb-client

# download latest wordpress version, unzip & rm zip
RUN \
    wget https://wordpress.org/latest.tar.gz -P /var/www && \
    cd /var/www && \
    tar -xzf latest.tar.gz && \
    rm latest.tar.gz

RUN \
    chown -R root:root /var/www/wordpress

COPY \
    conf/php.ini /etc/php/7.3/fpm/php.ini

COPY \
    conf/auto_config.sh ./auto_config.sh

RUN \
    chmod +x /auto_config.sh

RUN \
    wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

ENTRYPOINT \
    [ "./auto_config.sh" ]