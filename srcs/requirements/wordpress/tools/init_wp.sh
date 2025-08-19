#!/bin/bash


set -e

#+ make php dir in case it doesnt exist
mkdir -p /run/php
chown -R www-data:www-data /run/php

echo "[INIT] Waiting for database..."
until mysqladmin ping -h"$DB_HOST" --silent; do
    sleep 1
done

#until mariadb -h"$DB_HOST" -u"$DB_USER" -p"$DB_PASSWORD" -e "SELECT 1;" > /dev/null 2>&1; do
#        sleep 1
#done


#should i check config or index instead?
if ! wp core is-installed --allow-root; then
    wp core download --allow-root
    wp config create --dbname="$DB_NAME" --dbuser="$DB_USER" --dbpass="$DB_PASS" --dbhost="$DB_HOST" --allow-root
    wp core install --url="$WP_URL" --title="$WP_TITLE" --admin_user="$WP_ADMIN" --admin_password="$WP_PASS" --admin_email="$WP_EMAIL" --allow-root
	wp user create "$WP_USER" "$WP_USER_EMAIL" --role=author --user_pass="$WP_USER_PASS" --allow-root
fi


   # Create a non-admin user


#gem proposed install instead
#    wp core download --allow-root

#    # Create the wp-config.php file
#    wp config create \
#        --dbname="$DB_NAME" \
#        --dbuser="$DB_USER" \
#        --dbpass="$DB_PASSWORD" \
#        --dbhost="$DB_HOST" \
#        --allow-root

#    # Run the WordPress installation
#    wp core install \
#        --url="$DOMAIN_NAME" \
#        --title="My Inception Project" \
#        --admin_user="$WP_ADMIN_USER" \
#        --admin_password="$WP_ADMIN_PASS" \
#        --admin_email="$WP_ADMIN_EMAIL" \
#        --skip-email \
#        --allow-root



#    echo "WordPress installation complete."
#fi

echo "Starting PHP-FPM..."
exec php-fpm7.4 -F