FROM debian:bullseye

RUN apt-get update && apt-get upgrade -y


RUN apt-get install -y mariadb-server && \
	apt-get install -y curl && \
	rm -rf /var/lib/apt/lists/*

COPY ./tools/setup_db.sh /
RUN chmod +x /setup_db.sh


EXPOSE 3306

ENTRYPOINT [ "./setup_db.sh" ]