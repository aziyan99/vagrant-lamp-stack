#!/bin/bash

echo 'Setup MySQL...'

if [ $# -ne 3 ]; then
    echo "Usage: $0 <dbname> <dbuser> <dbpassword>"
    exit 1
fi

DBHOST=localhost
DBNAME="$1"
DBUSER="$2"
DBPASSWD="$3"

# Install MySQL
apt-get update

echo "mysql-server mysql-server/root_password password $DBPASSWD" | debconf-set-selections
echo "mysql-server mysql-server/root_password_again password $DBPASSWD" | debconf-set-selections

apt-get -y install mysql-server

# Create the database and grant privileges
CMD="mysql -uroot -p$DBPASSWD -e"

$CMD "CREATE DATABASE IF NOT EXISTS $DBNAME"
$CMD "CREATE USER '$DBUSER'@'%' IDENTIFIED BY '$DBPASSWD'"
$CMD "GRANT ALL PRIVILEGES ON $DBNAME.* TO '$DBUSER'@'%';"
$CMD "FLUSH PRIVILEGES;"

# Allow remote access to the database
sed -i "s/.*bind-address.*/bind-address = 0.0.0.0/" /etc/mysql/mysql.conf.d/mysqld.cnf

sudo systemctl restart mysql
