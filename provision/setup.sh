#!/bin/bash

# Variables
DBUSER=vagrant
DBPASSWD=vagrant

echo "Provisioning virtual machine..."

echo "Updating Ubuntu Packages"
    apt-get update > /dev/null 2>&1
    apt-get upgrade > /dev/null 2>&1
    apt-get -y install python-software-properties build-essential curl > /dev/null 2>&1
    locale-gen en_US en_US.UTF-8 > /dev/null 2>&1
    dpkg-reconfigure locales > /dev/null 2>&1

echo "Installing Git"
    apt-get -y install git > /dev/null 2>&1

echo "Installing Nginx"
    apt-get -y install nginx > /dev/null 2>&1

echo "Installing PHP"
    add-apt-repository ppa:ondrej/php-7.0 -y > /dev/null 2>&1
    apt-get update > /dev/null 2>&1
    apt-get -y install php7.0 php7.0-fpm php7.0-cli php7.0-curl php7.0-intl php7.0-mysql > /dev/null 2>&1

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

echo "Installing MongoDB"
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927 > /dev/null 2>&1
    echo "deb http://repo.mongodb.org/apt/ubuntu trusty/mongodb-org/3.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.2.list > /dev/null 2>&1
    apt-get update > /dev/null 2>&1
    apt-get -y install mongodb-org > /dev/null 2>&1
