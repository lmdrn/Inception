# Dockerfile for mariadb

FROM alpine:3.19

RUN apk update \
    && apk upgrade \
    && apk add --no-cache mariadb \
    && apk add --no-cache mariadb-client 

COPY ./conf/mariadb-server.conf /etc/my.cnf.d/mariadb-server.conf
COPY ./conf/mariadb-server.conf /etc/my.cnf
COPY ./conf/mariadb-server.conf /etc/mysql/

COPY ./tools/db-config.sh /db-config.sh
RUN chmod +x /db-config.sh

ENTRYPOINT ["/db-config.sh"]
