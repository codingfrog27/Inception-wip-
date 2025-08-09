#!/bin/bash

# # Create a self-signed SSL certificate for TLS (or use your own cert files)
# echo "Creating a self-signed SSL certificate..."
# openssl req \
# 	-x509 \
# 	-nodes \
# 	-days 365 \
# 	-newkey rsa:2048 \
# 	-subj "/C=NL/ST=Holland/L=Amsterdam/O=Codam/CN=${DOMAIN_NAME}" \
# 	-out "/etc/nginx/ssl/selfsigned.crt" \
# 	-keyout "/etc/nginx/ssl/selfsigned.key"

# # Start NGINX in the foreground
# echo "Starting nginx..."
# exec nginx -g "daemon off;"

echo "Creating a self-signed SSL certificate..."
mkdir -p /etc/nginx/ssl
openssl req \
	-x509 \
	-nodes \
	-days 365 \
	-newkey rsa:2048 \
	-subj "/C=NL/ST=Holland/L=Amsterdam/O=Codam/CN=${DOMAIN_NAME}" \
	-out "/etc/nginx/ssl/selfsigned.crt" \
	-keyout "/etc/nginx/ssl/selfsigned.key"

# Replace env vars in nginx config
envsubst '${DOMAIN_NAME}' < /etc/nginx/conf.d/default.conf > /etc/nginx/conf.d/default.conf.tmp
mv /etc/nginx/conf.d/default.conf.tmp /etc/nginx/conf.d/default.conf

echo "Starting nginx..."
exec nginx -g "daemon off;"