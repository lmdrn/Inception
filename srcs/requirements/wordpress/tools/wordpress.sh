#!/bin/sh

sleep 5

mkdir -p /var/www/html
mkdir -p /var/www/html/wordpress
#cp /tmp/index.html /var/www/html/index.html
cd /var/www/html/wordpress/
wp core download --allow-root
echo "DOWNLOAD"
# Skip config creation since wp-config.php is pre-copied
if [ ! -f /var/www/html/wordpress/wp-config.php ]; then
    echo "ERROR: wp-config.php not found in /var/www/html. Exiting."
    exit 1
fi

#wp config create --dbname=$MYSQL_DATABASE --dbuser=$MYSQL_USER --dbpass=$MYSQL_PASSWORD --dbhost=mariadb:3306 --dbcharset="utf8" --dbcollate="utf8_general_ci" --allow-root
echo "Created config $?"
wp core install --url=$DOMAIN_NAME/wordpress --title=$WP_TITLE --admin_user=$WP_ADMIN_USER --admin_password=$WP_ADMIN_PASSWORD --admin_email=$WP_ADMIN_EMAIL --skip-email --allow-root
echo "Installed core"
wp user create $WP_USERNAME $WP_USER_EMAIL --user_pass=$WP_USER_PASSWORD --allow-root
echo "Created user"
echo "Running..."

/usr/sbin/php-fpm7.3 -F
