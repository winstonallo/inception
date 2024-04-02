FROM debian:buster

RUN apt-get update -y
RUN apt-get install nginx -y
RUN apt-get install openssl -y

CMD [ "nginx", "-g", "daemon off;" ]