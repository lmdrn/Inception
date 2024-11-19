#!/bin/sh

cd /var/www/html

# Check if WordPress is already installed
if [ ! -f wp-config.php ]; then
    echo "Downloading WordPress core files..."
    wp core download --allow-root

    echo "Creating wp-config.php..."
    wp config create --dbname="$MYSQL_DATABASE" --dbuser="$MYSQL_USER" --dbpass="$MYSQL_PASSWORD" --dbhost="$MYSQL_HOST" --allow-root

    echo "Installing WordPress..."
    wp core install --url="$DOMAIN_NAME" --title="$WP_TITLE" --admin_user="$WP_ADMINNAME" --admin_password="$WP_ADMINPASS" --admin_email="$WP_ADMINMAIL" --skip-email --allow-root
else
    echo "WordPress is already installed. Skipping download and installation."
fi

# Create an additional user if necessary
if ! wp user get "$WP_USER" --allow-root; then
    echo "Creating additional user..."
    wp user create "$WP_USER" "$WP_USEREMAIL" --user_pass="$WP_USERPASS" --allow-root
fi

# Start PHP-FPM
php-fpm -F

