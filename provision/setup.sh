#!/bin/bash

echo "Provisioning virtual machine..."

echo "Updating Ubuntu Packages"
    apt-get update > /dev/null
    apt-get upgrade > /dev/null

echo "Updating Repository"
    apt-get install python-software-properties build-essential -y > /dev/null
    add-apt-repository ppa:ondrej/php5 -y > /dev/null
    add-apt-repository ppa:chris-lea/node.js > /dev/null
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10 > /dev/null
    echo "deb http://repo.mongodb.org/apt/ubuntu trusty/mongodb-org/3.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.0.list > /dev/null

echo "Updating Ubuntu Packages"
    apt-get update > /dev/null
    apt-get upgrade > /dev/null

echo "Installing Git"
    apt-get install git -y > /dev/null

echo "Installing Nginx"
    apt-get install nginx -y > /dev/null

echo "Installing PHP"
    apt-get install php5-common php5-dev php5-cli php5-fpm curl php5-intl php5-mongo php5-memcache php5-mcrypt php5-mysql php5-gd php5-imagick php5-pgsql php5-sqlite php5-curl -y > /dev/null

echo "Installing Composer"
    curl -sS https://getcomposer.org/installer | php > /dev/null
    mv composer.phar /usr/local/bin/composer > /dev/null
    composer global require "fxp/composer-asset-plugin:~1.0.3" > /dev/null

echo "Installing MongoDB"
    apt-get install -y mongodb-org > /dev/null

echo "Installing NodeJS"
    apt-get install nodejs > /dev/null
    apt-get install npm > /dev/null