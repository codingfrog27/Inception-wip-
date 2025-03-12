FROM debian:bullseye

# Avoid prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install MariaDB server and client and gettext for set-env script
RUN apt-get update && apt-get install -y \
    mariadb-server \
    mariadb-client \
    gettext

#remove cached update lists to make container xtralightweight (optional)    
RUN rm -rf /var/lib/apt/lists/*

#move startup script into container, sql images will autorun scripts in htis folder
COPY init.sql.template /docker-entrypoint-initdb.d/
COPY set-env.sh /usr/local/bin/
COPY maria_conf.cnf /

RUN chmod +x /usr/local/bin/set-env.sh

# Expose the default MariaDB port so wordpess can connect
EXPOSE 3306

ENTRYPOINT ["set-env.sh"]

#give mysqld to set _env script to launch db after (could also be hardcoded in there)
CMD ["mysqld"]

# # Configure MariaDB to listen on all interfaces
# RUN sed -i 's/bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/' /etc/mysql/mariadb.conf.d/50-server.cnf
