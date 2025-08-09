#!/bin/bash

# mkdir -p /run/mysqld /var/log/mysql /var/lib/mysql
# chown mysql:mysql /run/mysqld /var/log/mysql /var/lib/mysql

# #optional, will make script exit if any command fails
# set -e


# # Replace placeholders in init.sql with environment variables
# envsubst < /docker-entrypoint-initdb.d/init.sql.template > /docker-entrypoint-initdb.d/init.sql

# # chat told me
# mysqld_safe & sleep 5 && mysql < /docker-entrypoint-initdb.d/init.sql && mysqladmin shutdown


# # Start MariaDB
# exec "$@"
set -e

mkdir -p /run/mysqld /var/log/mysql /var/lib/mysql
chown mysql:mysql /run/mysqld /var/log/mysql /var/lib/mysql

# Only init if DB doesn't exist yet
if [ ! -d /var/lib/mysql/mysql ]; then
    echo "Initializing MariaDB..."
    mysqld_safe --skip-networking &
    sleep 5
    envsubst < /docker-entrypoint-initdb.d/init.sql.template > /tmp/init.sql
    mysql -u root <<EOF
    CREATE DATABASE ${DB_NAME};
    CREATE USER '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASS}';
    GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%';
    FLUSH PRIVILEGES;
EOF
    mysqladmin shutdown
fi

echo "Starting MariaDB..."
exec "$@"