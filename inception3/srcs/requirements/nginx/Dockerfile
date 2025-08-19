FROM debian:bullseye


#update package list, debian and install required tools (best in 1 line for layer minimisation)
#BUT since all containers need to update and upgrade even better to seperate for shared caching
# + changing 1 layer will rebuild from that layer, so seperating also has upsides, its a balance
# and there's pro's and con's
RUN apt-get update && \
	apt-get upgrade -y
	
	
RUN apt-get install -y openssl nginx php-fpm && \
	mkdir -p /etc/nginx/ssl && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*


#making a selfisgned cert and key for nginx
#x509 == selfsigned, nodes == no pw (else docker will hang)
#newkey gens the key
#subj gives eert info country, orginsation, domain && 
#->UID == login
RUN openssl req -x509 -nodes -newkey rsa:2048 \
	-keyout /etc/nginx/ssl/coolkey.key \
	-out /etc/nginx/ssl/coolcert.crt \
	-subj "/C=NL/O=42/CN=mde-cloe.42.fr/UID=mde-cloe" && \
	chmod 600 /etc/nginx/ssl/coolkey.key && \
	echo "cert and key generated! Starting Nginx now...\n"

COPY ./tools/nginx.conf /etc/nginx/conf.d


#listens to port 443 in docker network, 
# (tho) expose actually doesnt do anything here, the docker file compose file handles this,
# its just for clarity
EXPOSE 443

#start nginx in foregreound.. should this be entrypoint?
CMD ["nginx", "-g", "daemon off;"]

