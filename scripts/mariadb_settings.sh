#!/bin/bash
# Make sure that NOBODY can access the server without a password
mysql -e "UPDATE mysql.user SET Password = PASSWORD('love') WHERE User = 'root'"
# Create database for Wordpress.
mysql -e "CREATE DATABASE hiddenvault232 CHARACTER SET uft8 COLLATE utf8_unicode_ci;"
mysql -e "GRANT ALL ON hiddenvault232.* TO 'exaltedone'@'$(hostname)' IDENTIFIED BY '(livebythetruth)';"
# Flush privileges.
mysql -e "FLUSH PRIVILEGES"
