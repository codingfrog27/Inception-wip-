FROM debian:bullseye

RUN apt-get update && apt-get upgrade -y

#could add apt-get clean && \
	#rm -rf /var/lib/apt/lists/*

RUN apt-get install -y mariadb-server && \
	apt-get install -y curl && \
	rm -rf /var/lib/apt/lists/*
#optional i see is vim wget git mycli zsh and mariadb-client

# Temporary environment variables for testing
ENV DB_NAME=my_database
ENV DB_USER=cool_user
ENV DB_PASSWORD=cool_password


#COPY ./tools/mariadb.cnf /etc/mysql/mariadb.conf.d/mariadb.cnf
COPY ./tools/setup_db.sh /


RUN chmod +x /setup_db.sh
#&& chmod 644 /etc/mysql/mariadb.conf.d/mariadb.cnf

EXPOSE 3306

ENTRYPOINT [ "./setup_db.sh" ]