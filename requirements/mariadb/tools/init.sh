#!/bin/bash

# Install the database
mysql_install_db

# Start the MariaDB server in the background
mysqld_safe &

# Wait a bit for the server to start up
sleep 10

# Run the initial SQL commands
mysql -u root < /etc/mysql/init.sql

# Bring the background MariaDB server process to the foreground
# This keeps the container running
wait
