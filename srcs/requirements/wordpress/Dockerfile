#Wordpress Dockerfile
FROM alpine:3.19

RUN apk add --update php \
		php-fpm \
		php-mysqli \
		php-phar \
		wget \
		curl \
		mariadb-client \
		php-iconv

COPY	conf/www.conf /etc/php/7.3/fpm/pool.d

RUN curl https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar --output /usr/local/bin/wp \
    && chmod +x /usr/local/bin/wp
EXPOSE 9000

COPY ./tools/wordpress.sh /wordpress.sh
RUN chmod +x /wordpress.sh

ENTRYPOINT /wordpress.sh
