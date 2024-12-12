#!/bin/sh

cd /var/www/html

while ! mysql -h mariadb -u $MYSQL_USER -p$MYSQL_PASSWORD $MYSQL_DATABASE; do
  sleep 3
done

echo "Connection successful with db"

wp core download --allow-root
wp config create --dbname="$MYSQL_DATABASE" --dbuser="$MYSQL_USER" --dbpass="$MYSQL_PASSWORD" --dbhost="$MYSQL_HOST" --allow-root
wp core install --allow-root --url="$WP_DOMAINNAME" --title="$WP_TITLE" --admin_user="$WP_ADMIN_USER" --admin_email="$WP_ADMIN_EMAIL" --admin_password="$WP_ADMIN_PASSWORD"
wp user create "$WP_USER" "$WP_USER_EMAIL" --role=author --user_pass="$WP_USER_PASSWORD" --allow-root

exec /usr/sbin/php-fpm8.2 -F -R
