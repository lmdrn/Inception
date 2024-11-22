#!/bin/sh

#Script permettant l'ouverture de MYSQL et la creation de la db + user
#Demarre MYSQL
#Creation de la table, creation de l'utilisateur si il n'existe pas avec un mdp indiquer dans .env. 
#Attribution des droits a MYSQL_USER avec le mdp MYSQL_PASSWORD
#Changement des droit de root avec le mdp MYSQL_ROOT_PASSWORD 

mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld
chown -R mysql:mysql /var/lib/

echo "Install" 
mariadb_install_db --basedir=/usr --datadir=/var/lib/mysql --user=mysql --rpm > /dev/null
echo "Database create"

cat << EOF > /tmp/cmd.txt
USE mysql;
FLUSH PRIVILEGES;

DELETE FROM    mysql.user WHERE User='';

ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';

CREATE DATABASE $MYSQL_DATABASE CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE USER '$MYSQL_USER'@'%' IDENTIFIED by '$MYSQL_PASSWORD';
GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';

FLUSH PRIVILEGES;
EOF

mysqld --user=mysql --bootstrap < /tmp/cmd.txt

exec mysqld --user=mysql --console
