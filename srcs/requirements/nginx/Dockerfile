# Dockerfile for nginx
FROM alpine:3.19

RUN apk update \
    && apk add --no-cache nginx \
    && apk add --no-cache curl \
    && apk add openssl

COPY conf/nginx.conf /etc/nginx/nginx.conf

COPY tools/nginx.sh /tmp/nginx.sh
RUN chmod +x /tmp/nginx.sh

ENTRYPOINT ["sh", "/tmp/nginx.sh"]

EXPOSE 443
