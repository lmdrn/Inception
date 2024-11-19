# Dockerfile for nginx
FROM alpine:3.19

RUN apk update \
    && apk add --no-cache nginx \
    && apk add --no-cache curl \
    && mkdir -p /etc/nginx/ssl \
    && apk add openssl \
    && openssl req -x509 -nodes \
    	       -out /etc/nginx/ssl/nginx.crt \
	       -keyout /etc/nginx/ssl/nginx.key -subj \
		#"/C=CH/ST=Vaud/L=Lausanne/O=42/OU=XXX/CN=$DOMAIN_NAME"
		"/C=CH/ST=Vaud/L=Lausanne/O=42/OU=XXX/CN=localhost"

COPY conf/nginx.conf /etc/nginx/nginx.conf

EXPOSE 443/tcp

CMD ["nginx", "-g", "daemon off;"]

