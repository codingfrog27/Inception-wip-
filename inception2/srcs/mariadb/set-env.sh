#!/bin/bash

mkdir -p /run/mysqld /var/log/mysql /var/lib/mysql
chown mysql:mysql /run/mysqld /var/log/mysql /var/lib/mysql

#optional, will make script exit if any command fails
set -e


# Replace placeholders in init.sql with environment variables
envsubst < /docker-entrypoint-initdb.d/init.sql.template > /docker-entrypoint-initdb.d/init.sql

# Start MariaDB
exec "$@"