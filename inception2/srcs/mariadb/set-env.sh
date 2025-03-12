#!/bin/bash
set -e

# Replace placeholders in init.sql with environment variables
envsubst < /docker-entrypoint-initdb.d/init.sql.template > /docker-entrypoint-initdb.d/init.sql

# Start MariaDB
exec "$@"