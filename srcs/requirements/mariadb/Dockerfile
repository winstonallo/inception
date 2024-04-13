FROM debian:bullseye

# Update package lists
# Upgrade existing packages
# Install MariaDB
RUN apt update
RUN apt upgrade
RUN apt install mariadb-server -y

# Copy database server configuration file and initialization
# script into the container
COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/
COPY ./tools/init.sh .

# Create MariaDB directory and set permissions
# Ensures MariaDB has the required directories with the correct permissions.
RUN mkdir -p /run/mysqld
RUN chmod +x init.sh
RUN chown -R mysql:mysql /var/lib/mysql

# Initialize using script
ENTRYPOINT [ "./init.sh" ]