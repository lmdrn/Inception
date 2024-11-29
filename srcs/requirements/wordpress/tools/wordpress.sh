#!/bin/sh

while ! mysql -h mariadb -u $MYSQL_USER -p$MYSQL_PASSWORD $MYSQL_DATABASE; do
  sleep 3
done

echo "Connection successful with db"


mkdir /var/www/html/wordpress
cd /var/www/html/wordpress

wp core download

wp core config --dbname="${MYSQL_DATABASE}" --dbuser="${MYSQL_USER}" --dbpass="${MYSQL_PASSWORD}" \
		--dbhost=mariadb --locale=en_US --debug=true;

wp core install --url="${WP_DOMAINNAME}" --title="${WP_TITLE}" --admin_user="${WP_ADMIN_USER}" \
	--admin_password="${WP_ADMIN_PASSWORD}" --admin_email="${WP_ADMIN_EMAIL}" --locale=en_US --skip-email

sleep 3

wp user create "${WP_USER}" "${WP_USER_EMAIL}" --user_pass="${WP_USER_PASSWORD}" --role=author

exec /usr/sbin/php-fpm82 -F
