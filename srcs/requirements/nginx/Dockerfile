FROM debian:bullseye

# Update package lists
# Upgrade existing packages
# Install Nginx
# Install OpenSSL
RUN apt update 
RUN apt upgrade
RUN apt install nginx -y
RUN apt install openssl -y

# Generate new self-signed SSL certificate & key
#
#   req: Certificate request
#
#   -new: New request -> starting from scratch
#
#   -newkey rsa:4096:   
#       a. RSA: Encryption algorithm
#       b. 4096: Key size
#
#   -x509: Self-Signed
#
#   -nodes: 'no DES' -> no password
#
#   -days 365: Validity Period
#
#   -keyout: Destination for key
#
#   -out: Destination for certificate
#
#   -subj (subject details):
#       a. /C=AU: Country: AUstria
#       b. /L=VI: Locality: VIenna
#       c. /O=42: Organization: 42
#       d. /OU=student: Organizational Unit
#       e. /CN=abied-ch.42.fr: Common Name -> domain name
RUN openssl req -new -newkey rsa:4096 -x509 -nodes -days 365 \
    -keyout /etc/ssl/private/nginx-selfsigned.key \
    -out /etc/ssl/certs/nginx-selfsigned.crt \
    -subj "/C=AU/L=VI/O=42/OU=student/CN=abied-ch.42.fr"

# Copy Nginx config into the container
COPY ./conf/default /etc/nginx/sites-available/

# Expose port 443 for HTTPS
EXPOSE 443

ENTRYPOINT [ "nginx", "-g", "daemon off;" ]