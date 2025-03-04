#!/bin/bash

#service runs a program without env variables and runs it from /
service mariadb start
echo "MYSQL_DB: ${MYSQL_DB}"
echo "MYSQL_USER: ${MYSQL_USER}"
echo "MYSQL_PASSWORD: ${MYSQL_PASSWORD}"

#not for any infinite shenanigans, simply giving MDB time to startup :)
sleep 5 


#usually mariadb (or msql) will open its own shell, 
#the -e option lets you pass a command directly
mariadb -e "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DB}\`;"


mariadb -e "CREATE USER IF NOT EXISTS \`${MYSQL_USER}\`@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"


mariadb -e "GRANT ALL PRIVILEGES ON ${MYSQL_DB}.* TO \`${MYSQL_USER}\`@'%';"
# .* for all tables in DB
#@ % means can connect from any host

#applying priveleges
mariadb -e "FLUSH PRIVILEGES;"


#finally a script provided by mariaDB, starting in safe mode means autorestarts on issues, 
#so less chance of it not working :)
#and more importantly it's a continues command so no unexpected container closing! B)
# mysqld_safe --port=3306 --bind-address=0.0.0.0 --datadir='/var/lib/mysql'
#opens default port, will connect to any IP (since container IP's can change) and stores data in default dir.