#!/bin/bash
sudo apt-get update -y
sudo apt-get install sudo fail2ban portsentry mailutils nginx mariadb-server php-fpm php-curl php-gd php-intl php-mbstring php-soap php-xml php-xmlrpc php-zip
curl -LO https://wordpress.org/latest.tar.gz
echo "Installed sudo, fail2ban, portsentry, mailutils, nginx, mariadb-server and PHP packages for Wordpress"
