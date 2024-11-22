#Wordpress Dockerfile
FROM alpine:3.19

RUN apk update \
    && apk upgrade \
    && apk add --no-cache php \
    && apk add --no-cache php-fpm \
    && apk add --no-cache php-mysqli \
    && apk add --no-cache php-phar \
    && apk add --no-cache curl \
    && apk add --no-cache mariadb-client

RUN mkdir -p /run/php/php7.3-fpm/
COPY /conf/www.conf /etc/php/7.3/fpm/pool.d/

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp \
    && mkdir -p /run/php/php7.3-fpm/

COPY ./conf/wp-config.php /var/www/html/wordpress/wp-config.php

COPY ./tools/wordpress.sh /wordpress.sh
RUN chmod +x /wordpress.sh

ENTRYPOINT /wordpress.sh
