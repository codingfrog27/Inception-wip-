#!/bin/bash

# Move the configuration file to the correct location
mv /db-config.cnf /etc/mysql/mariadb.conf.d/db-config.cnf

# Set proper permissions
chmod 644 /etc/mysql/mariadb.conf.d/db-config.cnf

# Create necessary directories and set permissions as root
mkdir -p /run/mysqld 
mkdir -p /var/log/mysql
mkdir -p /var/lib/mysql
chown -R mysql:mysql /run/mysqld 
chown -R mysql:mysql /var/log/mysql
chown -R mysql:mysql /var/lib/mysql

echo "Initializing MariaDB..."
# Setting up the database, user, and permissions in bootstrap mode. 
# --bootstrap: Runs MariaDB in a lightweight, non-networked mode without plugins, or other unnecessary features during initialization.
{
	echo "FLUSH PRIVILEGES;"
	echo "CREATE DATABASE IF NOT EXISTS \`$WP_DATABASE_NAME\`;"
	echo "CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_USER_PASSWORD';"
	echo "GRANT ALL PRIVILEGES ON \`$WP_DATABASE_NAME\`.* TO '$DB_USER'@'%' IDENTIFIED BY '$DB_USER_PASSWORD';"
	echo "FLUSH PRIVILEGES;"
} | mysqld --bootstrap

# Keep MariaDB running in the foreground
echo "Starting MariaDB..."
exec mysqld




# #!/bin/bash

# #service runs a program without env variables and runs it from /
# service mariadb start

# #not for any infinite shenanigans, simply giving MDB time to startup :)
# sleep 5 


# #usually mariadb (or msql) will open its own shell, 
# #the -e option lets you pass a command directly
# mariadb -e "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DB}\`;"


# mariadb -e "CREATE USER IF NOT EXISTS \`${MYSQL_USER}\`@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"


# mariadb -e "GRANT ALL PRIVILEGES ON ${MYSQL_DB}.* TO \`${MYSQL_USER}\`@'%';"


# #applying priveleges
# mariadb -e "FLUSH PRIVILEGES;"


# #finally a script provided by mariaDB, starting in safe mode means autorestarts on issues, 
# #so less chance of it not working :)
# #and more importantly it's a continues command so no unexpected container closing! B)
# mysqld_safe --port=3306 --bind-address=0.0.0.0 --datadir='/var/lib/mysql'
# #opens default port, will connect to any IP (since container IP's can change) and stores data in default dir.