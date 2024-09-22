#!/bin/bash

yum update -y 
sudo yum install -y php php-mbstring php-intl
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer
composer install -n || true
echo "hii" >> /tmp/text.txt