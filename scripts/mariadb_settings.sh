#!/bin/bash
# Make sure that NOBODY can access the server without a password
mysql -e "UPDATE mysql.user SET Password = PASSWORD('love') WHERE User = 'root'"
# Create database for Hidden Games.
mysql -e "CREATE USER 'exaltedone'@'localhost' IDENTIFIED BY 'pannacotta';"
mysql -e "CREATE DATABASE hiddenvault232 CHARACTER SET utf8 COLLATE utf8_unicode_ci;"
mysql -e "CREATE TABLE answers (task_id INT AUTO_INCREMENT PRIMARY KEY, answer VARCHAR(255) NOT NULL) ENGINE=INNODB;" hiddenvault232 
mysql -e "INSERT INTO answers(answer) VALUES ('cogitoergosum');" hiddenvault232
mysql -e "GRANT ALL ON hiddenvault232.* TO 'exaltedone'@'localhost' IDENTIFIED BY 'pannacotta';"
# Flush privileges.
mysql -e "FLUSH PRIVILEGES"
