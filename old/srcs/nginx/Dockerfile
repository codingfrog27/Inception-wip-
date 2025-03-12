FROM debian:bullseye

#base image 



#base things up to date and install nginx and openssl

RUN apt-get update && apt-get upgrade -y

RUN apt-get install -y nginx openssl



#make ssl dir and generate certificate (-p == no error if existing)
RUN mkdir -p /etc/nginx/ssl


#certificate == selfsigned
RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout \
    /etc/nginx/ssl/inception.key -subj "/C=MO/ST=KH/L=KH/O=42/OU=42/CN=domain_name.fr/UID=admin_name"
#^check later cause i dont live in Morocco xd

COPY ./nginx.conf /etc/nginx/nginx.conf

RUN mkdir -p /var/www/wordpress


RUN chown -R www-data:www-data /var/www/wordpress

#closes docker file by running nginx in the foreground
CMD ["nginx", "-g", "daemon off;"]