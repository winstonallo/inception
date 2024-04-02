#!/bin/sh

mkdir -p /etc/nginx/conf.d/
mkdir -p /etc/ssl/private/

openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/ssl/private/nginx-selfsigned.key \
    -out /etc/ssl/certs/nginx-selfsigned.crt \
    -subj "/C=AU/L=VI/O=42/OU=student/CN=abied-ch.42.fr"
