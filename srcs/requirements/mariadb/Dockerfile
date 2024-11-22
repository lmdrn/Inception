# Dockerfile for mariadb

FROM alpine:3.19

RUN apk update \
    && apk upgrade \
    && apk add --no-cache mariadb \
    && apk add --no-cache mariadb-client\
    && apk add --no-cache curl 

COPY ./conf/mariadb-server.conf /etc/my.cnf.d/mariadb-server.conf

COPY ./tools/db-config.sh /db-config.sh
RUN chmod +x /db-config.sh

ENTRYPOINT /db-config.sh

