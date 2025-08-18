#!/bin/bash

#if anything fails, exit script for easier debuggin
set -e

# Create necessary directories if they don't exist
mkdir -p /run/mysqld /var/log/mysql /var/lib/mysql
chown -R mysql:mysql /run/mysqld /var/log/mysql /var/lib/mysql

# Use --bootstrap to initialize the database in a safe, fast way
echo "Initializing MariaDB with bootstrap..."
{
    echo "FLUSH PRIVILEGES;"
    echo "CREATE DATABASE IF NOT EXISTS \`${DB_NAME}\`;"
    echo "CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_PASS' REQUIRE NONE;"
    echo "GRANT ALL PRIVILEGES ON \`${DB_NAME}\`.* TO '$DB_USER'@'%';"
    echo "FLUSH PRIVILEGES;"
} | mysqld --datadir=/var/lib/mysql --bootstrap

# Run MariaDB in the foreground
echo "Starting the real MariaDB ..."
exec mysqld_safe --port=3306 --bind-address=0.0.0.0 --datadir='/var/lib/mysql'