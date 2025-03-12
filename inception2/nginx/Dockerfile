FROM debian:bullseye

#base image 



#base things up to date and install nginx and openssl

RUN apt-get update && apt-get upgrade -y

RUN apt-get install -y nginx openssl



#make ssl dir and generate certificate (-p == no error if existing)
RUN mkdir -p /etc/nginx/ssl && chmod 700 /etc/nginx/ssl

COPY ./nginx.conf /etc/nginx/conf.d/default.conf

COPY 	./tools/nginx_script.sh /

RUN 	chmod +x /nginx_script.sh

EXPOSE 	443

CMD ["/nginx_script.sh"]

# #certificate == selfsigned
# RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout \
#     /etc/nginx/ssl/inception.key -subj "/C=MO/ST=KH/L=KH/O=42/OU=42/CN=domain_name.fr/UID=admin_name"
# #^check later cause i dont live in Morocco xd