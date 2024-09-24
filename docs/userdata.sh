#!/bin/bash

yum update -y 
sudo yum install -y php php-mbstring php-intl nginx

curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer
composer install -n || true

yum install 
systemctl start nginx
systemctl enable nginx

cat <<EOL > /etc/nginx/conf.d/laravel.conf
server {
    listen 80;
    server_name 0.0.0.0;
    root /var/www/html/current/public;

    add_header X-Frame-Options "SAMEORIGIN";
    add_header X-XSS-Protection "1; mode=block";
    add_header X-Content-Type-Options "nosniff";

    index index.html index.htm index.php;

    charset utf-8;

    location / {
        try_files \$uri \$uri/ /index.php?\$query_string;
    }

    location = /favicon.ico { access_log off; log_not_found off; }
    location = /robots.txt  { access_log off; log_not_found off; }

    error_page 404 /index.php;

    location ~ \.php$ {
        fastcgi_pass unix:/var/run/php-fpm/www.sock;
        fastcgi_index index.php;
        fastcgi_param SCRIPT_FILENAME \$realpath_root\$fastcgi_script_name;
        include fastcgi_params;
    }

    location ~ /\.(?!well-known).* {
        deny all;
    }
}
EOL

systemctl restart nginx

ssm_parameter_value=$(aws ssm get-parameter --name "public_key" --query "Parameter.Value" --output text)

# Append the SSM parameter value to the authorized_keys file
echo "$ssm_parameter_value" >> /home/ec2-user/.ssh/authorized_keys

# Ensure SSH permissions are set correctly
chmod 600 /home/ec2-user/.ssh/authorized_keys
echo "hii" >> /tmp/text.txt