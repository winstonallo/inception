FROM debian:bullseye

RUN apt update 
RUN apt upgrade
RUN apt install nginx -y
RUN apt install openssl -y

RUN openssl req -new -newkey rsa:4096 -x509 -nodes -days 365 \
    -keyout /etc/ssl/private/nginx-selfsigned.key \
    -out /etc/ssl/certs/nginx-selfsigned.crt \
    -subj "/C=AU/L=VI/O=42/OU=student/CN=abied-ch.42.fr"

COPY ./conf/default /etc/nginx/sites-available/

EXPOSE 443

CMD [ "nginx", "-g", "daemon off;" ]