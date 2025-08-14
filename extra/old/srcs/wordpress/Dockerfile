FROM debian:bookworm

RUN apt-get update && apt-get upgrade -y


#install dependencies php for scripts, msql and mariadb client for database
RUN apt-get install -y curl php php7.4-fpm php-mysql mariadb-client

COPY ./Wordpress_config.sh /

RUN chmod +x /Wordpress_config.sh


#alternative to CMD, not as easily overwritable, CMD is more a default and entrpoint is forced execution
ENTRYPOINT ["./Wordpress_config.sh"]