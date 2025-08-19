FROM debian:bullseye


RUN apt-get update && \
	apt-get upgrade -y

#installing PHP (wp runs in php), fpm is for fast-pass
#also mariadb-client to connect with mariadb
#+ curl / wget for
#AND download the WP CLI
RUN apt-get -y install php php-fpm php-mysql mariadb-client wget curl sendmail



RUN	curl -L https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -o wp-cli.phar && \
	chmod +x wp-cli.phar && \
	mv wp-cli.phar /usr/local/bin/wp && \
	rm -rf /var/lib/apt/lists/* && \
	mkdir -p /var/www/html/wordpress



COPY ./tools/www.conf /etc/php/7.4/fpm/pool.d/


COPY ./tools/init_wp.sh /
RUN chmod +x /init_wp.sh

RUN chown -R www-data:www-data /var/www/html/wordpress

#what is workdir?
WORKDIR /var/www/html/wordpress

EXPOSE 9000


ENTRYPOINT ["/init_wp.sh"]
