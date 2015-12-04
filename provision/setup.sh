#!/bin/bash

# Variables
DBUSER=vagrant
DBPASSWD=vagrant

echo "Provisioning virtual machine..."

echo "Updating Ubuntu Packages"
    apt-get update > /dev/null 2>&1
    apt-get upgrade > /dev/null 2>&1
    apt-get -y install python-software-properties build-essential > /dev/null 2>&1
    locale-gen en_US en_US.UTF-8 > /dev/null 2>&1
    dpkg-reconfigure locales > /dev/null 2>&1

echo "Installing Git"
    apt-get -y install git > /dev/null 2>&1

echo "Installing Nginx"
    apt-get -y install nginx > /dev/null 2>&1

echo "Installing PHP"
    add-apt-repository ppa:ondrej/php5-5.6 -y > /dev/null 2>&1
    apt-get update > /dev/null 2>&1
    apt-get -y install php5-common php5-dev php5-cli php5-fpm curl php5-intl php5-mongo php5-memcache php5-mcrypt php5-mysql php5-gd php5-imagick php5-pgsql php5-sqlite php5-curl > /dev/null 2>&1

echo "Installing Composer"
    curl -sS https://getcomposer.org/installer | php > /dev/null 2>&1
    mv composer.phar /usr/local/bin/composer > /dev/null 2>&1
    composer global require fxp/composer-asset-plugin > /dev/null 2>&1

echo "Installing MariaDB"
    echo "mysql-server mysql-server/root_password password $DBPASSWD" | debconf-set-selections
    echo "mysql-server mysql-server/root_password_again password $DBPASSWD" | debconf-set-selections
    apt-get -y install mariadb-server > /dev/null 2>&1
    mysql -uroot -p$DBPASSWD -e "grant all privileges on *.* to '$DBUSER'@'%' identified by '$DBPASSWD'"

echo "Installing Redis"
    apt-get -y install redis-server redis-tools > /dev/null 2>&1

echo "Installing NodeJS"
    curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash - > /dev/null 2>&1
    apt-get -y install nodejs > /dev/null 2>&1
    npm install bower -g > /dev/null 2>&1

echo "Installing Memcached"
    apt-get -y install memcached > /dev/null 2>&1
