tmp_ai.sh

#!/bin/bash
set -e

echo "[INIT] Creating PHP socket dir..."
mkdir -p /run/php
chown -R www-data:www-data /run/php

echo "[INIT] Waiting for MariaDB..."
until mysqladmin ping -h"$MARIADB_HOST" --silent; do
    sleep 1
done

echo "[INIT] Checking WordPress installation..."
if ! wp core is-installed --allow-root --path=/var/www/html/wordpress; then
    echo "[INIT] Downloading WordPress..."
    wp core download --allow-root --path=/var/www/html/wordpress

    echo "[INIT] Creating wp-config.php..."
    wp config create \
      --dbname="$DB_NAME" \
      --dbuser="$DB_USER" \
      --dbpass="$DB_PASS" \
      --dbhost="$DB_HOST" \
      --allow-root \
      --path=/var/www/html/wordpress

    echo "[INIT] Installing WordPress..."
    wp core install \
      --url="$WP_URL" \
      --title="$WP_TITLE" \
      --admin_user="$WP_ADMIN" \
      --admin_password="$WP_PASS" \
      --admin_email="$WP_EMAIL" \
      --allow-root \
      --path=/var/www/html/wordpress
fi

echo "[INIT] Launching PHP-FPM..."
exec "$@"
