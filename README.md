# My Vagrant
This is my preferable vagrant configuration. It runs on [Ubuntu Trusty 64bit](https://vagrantcloud.com/ubuntu/boxes/trusty64).



## How to Use
```
git clone https://github.com/nucreativa/vagrant
cd vagrant
vagrant up
```

### What's inside
A pre-configured Ubuntu VM
* Nginx 1.8
* PHP 7 + Composer installed globally + Git enabled
* MariaDB 10.1
* SQLite3
* MongoDB 3.2
* Memcached
* Redis
* NodeJS
* RabbitMQ

### Notes

#### How to connect remotely to MariaDB
```
Host : 192.168.64.64
User : vagrant
Pass : vagrant
```

#### How to connect remotely to MongoDB
```
Host : 192.168.64.64:27017
User : vagrant
Pass : vagrant
```

#### RabbitMQ Management
```
Host : 192.168.64.64:15672
User : vagrant
Pass : vagrant
```
