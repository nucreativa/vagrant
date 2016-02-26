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
    echo "LC_ALL=\"en_US.UTF-8\"" | cat - /etc/default/locale > /tmp/locale.tmp && mv /tmp/locale.tmp /etc/default/locale && export LC_ALL="en_US.UTF-8"

echo "Installing Git"
    apt-get -y install git > /dev/null 2>&1

echo "Installing Nginx"
    add-apt-repository ppa:nginx/development > /dev/null 2>&1
    apt-get update && apt-get -y install nginx > /dev/null 2>&1

#echo "Installing PHP 5.6"
#    LC_ALL=en_US.UTF-8 add-apt-repository ppa:ondrej/php5-5.6 -y > /dev/null 2>&1
#    apt-get update > /dev/null 2>&1
#    apt-get -y install php5-common php5-dev php5-fpm php5-cli php5-curl php5-intl php5-mysql php5-sqlite php5-mcrypt php5-gd > /dev/null 2>&1

echo "Installing PHP 7"
    LC_ALL=en_US.UTF-8 add-apt-repository ppa:ondrej/php -y > /dev/null 2>&1
    apt-get update > /dev/null 2>&1
    apt-get -y install php7.0 php7.0-common php7.0-dev php7.0-fpm php7.0-cli php7.0-curl php7.0-intl php7.0-mysql php7.0-sqlite3 php7.0-mcrypt php7.0-gd > /dev/null 2>&1

echo "Installing Composer"
    curl -sS https://getcomposer.org/installer | php > /dev/null 2>&1
    mv composer.phar /usr/local/bin/composer > /dev/null 2>&1
    composer global require fxp/composer-asset-plugin > /dev/null 2>&1

echo "Installing SQLite3"
    apt-get install sqlite3 libsqlite3-dev > /dev/null 2>&1

echo "Installing MariaDB"
    apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xcbcb082a1bb943db > /dev/null 2>&1
    add-apt-repository 'deb [arch=amd64,i386] http://mariadb.biz.net.id/repo/10.1/ubuntu trusty main'  > /dev/null 2>&1
    echo "mysql-server mysql-server/root_password password $DBPASSWD" | debconf-set-selections
    echo "mysql-server mysql-server/root_password_again password $DBPASSWD" | debconf-set-selections
    apt-get update && apt-get -y install mariadb-server > /dev/null 2>&1
    mysql -uroot -p$DBPASSWD -e "grant all privileges on *.* to '$DBUSER'@'%' identified by '$DBPASSWD'"

echo "Installing Redis"
    apt-get -y install redis-server redis-tools > /dev/null 2>&1
    # temporary solution until Redis fully support PHP7
    cp /var/www/redis.dev/redis.so /usr/lib/php/20151012/redis.so > /dev/null 2>&1
    echo "extension=/usr/lib/php/20151012/redis.so" >> `php --ini | grep "Loaded Configuration" | sed -e "s|.*:\s*||"` > /dev/null 2>&1

echo "Installing NodeJS"
    curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash - > /dev/null 2>&1
    apt-get -y install nodejs > /dev/null 2>&1
    npm install bower -g > /dev/null 2>&1

echo "Installing Memcached"
    apt-get -y install memcached > /dev/null 2>&1

echo "Installing MongoDB"
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927 > /dev/null 2>&1
    echo "deb http://repo.mongodb.org/apt/ubuntu trusty/mongodb-org/3.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.2.list > /dev/null 2>&1
    apt-get update && apt-get -y install pkg-config libsasl2-dev mongodb-org > /dev/null 2>&1
    pecl install mongodb > /dev/null 2>&1
    echo "extension=/usr/lib/php/20151012/mongodb.so" >> `php --ini | grep "Loaded Configuration" | sed -e "s|.*:\s*||"` > /dev/null 2>&1
    service php7.0-fpm restart > /dev/null 2>&1

echo "Installing RabbitMQ"
    echo "deb http://www.rabbitmq.com/debian testing main" >> /etc/apt/sources.list > /dev/null 2>&1
    wget https://www.rabbitmq.com/rabbitmq-signing-key-public.asc > /dev/null 2>&1
    apt-key add rabbitmq-signing-key-public.asc > /dev/null 2>&1
    apt-get update && apt-get -y install rabbitmq-server > /dev/null 2>&1
    rabbitmq-plugins enable rabbitmq_management > /dev/null 2>&1
    rabbitmqctl add_user vagrant vagrant > /dev/null 2>&1
    rabbitmqctl set_user_tags vagrant administrator > /dev/null 2>&1
    rabbitmqctl set_permissions -p / vagrant ".*" ".*" ".*" > /dev/null 2>&1