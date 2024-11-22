#!/bin/sh

mkdir -p /etc/nginx/ssl

openssl req -x509 -nodes \
	-out /etc/nginx/ssl/nginx.crt \
	-keyout /etc/nginx/ssl/nginx.key -subj \
	"/C=CH/ST=Vaud/L=Lausanne/O=42/OU=XXX/CN=$DOMAIN_NAME"
/usr/sbin/nginx -g "daemon off;"
