#Wordpress Dockerfile
FROM alpine:3.19

RUN apk update \
    && apk upgrade \
    && apk add --no-cache php \
    && apk add --no-cache php-fpm \
    && apk add --no-cache php-mbstring \
    && apk add --no-cache php-mysqli \
    && apk add --no-cache php-phar \
    && apk add --no-cache curl \
    && apk add --no-cache mariadb-client

RUN mkdir -p /run/php/php8.2-fpm/
COPY /conf/www.conf /etc/php/8.2/fpm/pool.d/

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

COPY ./tools/wordpress.sh /wordpress.sh
RUN chmod +x /wordpress.sh

EXPOSE 9000

ENTRYPOINT /wordpress.sh
