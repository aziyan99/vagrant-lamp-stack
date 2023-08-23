#!/bin/bash

echo 'Setup PHP...'

LC_ALL=C.UTF-8 sudo add-apt-repository -y ppa:ondrej/php

sudo apt install -y php8.0 libapache2-mod-php8.0 php8.0-mysql
sudo apt install -y php8.0-bcmath \
	php8.0-curl \
	php8.0-mbstring \
	php8.0-tokenizer \
	php8.0-xml \
	php8.0-xmlrpc \
	php8.0-common \
	php8.0-zip \
	php8.0-soap \
	php8.0-gd \
	php8.0-intl

# If really needed to edit apache2 `php.ini`
# sed -i 's/max_execution_time = .*/max_execution_time = 60/' /etc/php/8.0/apache2/php.ini
# sed -i 's/post_max_size = .*/post_max_size = 64M/' /etc/php/8.0/apache2/php.ini
# sed -i 's/upload_max_filesize = .*/upload_max_filesize = 512M/' /etc/php/8.0/apache2/php.ini
# sed -i 's/memory_limit = .*/memory_limit = 512M/' /etc/php/8.0/apache2/php.ini

sudo systemctl restart apache2