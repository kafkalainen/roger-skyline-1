#!/bin/bash
sed -i "s/worker_connections 768;/worker_connections 100000;/" /etc/nginx/nginx.conf
echo "fs.file-max = 500000">>/etc/sysctl.conf
sudo sysctl -p
echo -e "*		soft	nofile		102400\n*		hard	nofile		409600\nwww-data	soft	nofile		102400\nwww-data	hard	nofile		409600\n">>/etc/security/limits.conf
sed -i "s/pid \/run\/nginx.pid;/pid \/run\/nginx.pid;\nworker_rlimit_nofile 102400;/" /etc/nginx/nginx.conf
sed -i "s/http {/http {\n\tlimit_req_zone \$binary_remote_addr zone=ip:10m rate=1r\/s;\n\tlimit_conn_zone \$binary_remote_addr zone=maxcon:10m;\n\tclient_body_timeout 5s;\n\tclient_header_timeout 5s;\n/" /etc/nginx/nginx.conf
touch /etc/nginx/sites-available/hiddengames
sudo ln -s /etc/nginx/sites-available/hiddengames /etc/nginx/sites-enabled/
sudo rm /etc/nginx/sites-enabled/default
echo "server {">>/etc/nginx/sites-available/hiddengames
echo "	listen 443 ssl;">>/etc/nginx/sites-available/hiddengames
echo "	listen [::]:443 ssl;">>/etc/nginx/sites-available/hiddengames
echo "	server_name 192.168.42.2;">>/etc/nginx/sites-available/hiddengames
echo "	include snippets/self-signed.conf;">>/etc/nginx/sites-available/hiddengames
echo "	include snippets/ssl-params.conf;">>/etc/nginx/sites-available/hiddengames
echo "	location / {">>/etc/nginx/sites-available/hiddengames
echo "#		limit_req zone=ip nodelay;">>/etc/nginx/sites-available/hiddengames
echo "		limit_req zone=ip burst=5;">>/etc/nginx/sites-available/hiddengames
echo "		limit_conn maxcon 100;">>/etc/nginx/sites-available/hiddengames
echo "		proxy_pass http://192.168.42.2:3000;">>/etc/nginx/sites-available/hiddengames
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
echo "	server_name 192.168.42.2;">>/etc/nginx/sites-available/hiddengames
echo '	return 301 https://$server_name$request_uri;'>>/etc/nginx/sites-available/hiddengames
echo "}">>/etc/nginx/sites-available/hiddengames
sudo service nginx restart
echo "Nginx configured."
