#!/bin/bash

yum update -y 
sudo yum install -y php php-mbstring php-intl
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer
composer install -n || true
ssm_parameter_value=$(aws ssm get-parameter --name "public_key" --query "Parameter.Value" --output text)

# Append the SSM parameter value to the authorized_keys file
echo "$ssm_parameter_value" >> /home/ec2-user/.ssh/authorized_keys

# Ensure SSH permissions are set correctly
chmod 600 /home/ec2-user/.ssh/authorized_keys
echo "hii" >> /tmp/text.txt