FROM debian:bullseye

RUN apt update 
RUN apt upgrade
RUN apt install nginx -y

COPY ./conf/default /etc/nginx/sites-available/.

CMD [ "nginx", "-g", "daemon off;" ]