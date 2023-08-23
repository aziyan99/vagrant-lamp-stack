#!/bin/bash
echo 'Setup Apache2...'

sudo apt-get update

LC_ALL=C.UTF-8 sudo add-apt-repository -y ppa:ondrej/apache2
sudo apt-get update

sudo apt install -y software-properties-common \
	ca-certificates \
	lsb-release \
	apt-transport-https  \
	openssl \
    net-tools
sudo apt-get install -y apache2
