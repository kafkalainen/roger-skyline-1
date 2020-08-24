#!/bin/bash
touch /etc/nginx/sites-available/hiddengames

sudo ln -s /etc/nginx/sites-available/hiddengames /etc/nginx/sites-enabled/
sudo rm /etc/nginx/sites-enabled/default
echo "server {">>/etc/nginx/sites-available/hiddengames
echo "	listen 443 ssl;">>/etc/nginx/sites-available/hiddengames
echo "	listen [::]:443 ssl;">>/etc/nginx/sites-available/hiddengames
echo "	server_name 192.168.56.2;">>/etc/nginx/sites-available/hiddengames
echo "	include snippets/self-signed.conf;">>/etc/nginx/sites-available/hiddengames
echo "	include snippets/ssl-params.conf;">>/etc/nginx/sites-available/hiddengames
echo "	location / {">>/etc/nginx/sites-available/hiddengames
echo "		proxy_pass http://192.168.56.2:3000;">>/etc/nginx/sites-available/hiddengames
echo "		proxy_http_version 1.1;">>/etc/nginx/sites-available/hiddengames
echo '		proxy_set_header Upgrade $http_upgrade;'>>/etc/nginx/sites-available/hiddengames
echo -e "		proxy_set_header Connection 'upgrade';">>/etc/nginx/sites-available/hiddengames
echo '		proxy_set_header Host $host;'>>/etc/nginx/sites-available/hiddengames
echo '		proxy_cache_bypass $http_upgrade;'>>/etc/nginx/sites-available/hiddengames
echo "     }">>/etc/nginx/sites-available/hiddengames
echo "}">>/etc/nginx/sites-available/hiddengames
echo "server {">>/etc/nginx/sites-available/hiddengames
echo "	listen 80;">>/etc/nginx/sites-available/hiddengames
echo "	listen [::]:80;">>/etc/nginx/sites-available/hiddengames
echo "	server_name 192.168.56.2;">>/etc/nginx/sites-available/hiddengames
echo '	return 301 https://$server_name$request_uri;'>>/etc/nginx/sites-available/hiddengames
echo "}">>/etc/nginx/sites-available/hiddengames
sudo service nginx restart
echo "Nginx configured."
