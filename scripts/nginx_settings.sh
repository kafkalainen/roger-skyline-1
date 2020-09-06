#!/bin/bash
sed -i "s/worker_connections 768;/worker_connections 100000;/" /etc/nginx/nginx.conf
echo "fs.file-max = 500000">>/etc/sysctl.conf
sudo sysctl -p
echo -e "*		soft	nofile		102400\n*		hard	nofile		409600\nwww-data	soft	nofile		102400\nwww-data	hard	nofile		409600\n">>/etc/security/limits.conf
sed -i "s/pid \/run\/nginx.pid;/pid \/run\/nginx.pid;\nworker_rlimit_nofile 102400;/" /etc/nginx/nginx.conf
touch /etc/nginx/sites-available/42-hiddengames.com
sudo ln -s /etc/nginx/sites-available/42-hiddengames.com /etc/nginx/sites-enabled/
sudo rm /etc/nginx/sites-enabled/default
echo 'limit_req_zone $binary_remote_addr zone=ip:10m rate=15r/s;'>>/etc/nginx/sites-available/42-hiddengames.com
echo 'limit_conn_zone $binary_remote_addr zone=addr:10m;'>>/etc/nginx/sites-available/42-hiddengames.com
echo "client_body_timeout 5s;">>/etc/nginx/sites-available/42-hiddengames.com
echo "client_header_timeout 5s;">>/etc/nginx/sites-available/42-hiddengames.com
echo "keepalive_timeout 10s;">>/etc/nginx/sites-available/42-hiddengames.com
echo "send_timeout 12s;">>/etc/nginx/sites-available/42-hiddengames.com
echo "server {">>/etc/nginx/sites-available/42-hiddengames.com
echo "	listen 443 ssl;">>/etc/nginx/sites-available/42-hiddengames.com
echo "	server_name 42-hiddengames.com;">>/etc/nginx/sites-available/42-hiddengames.com
echo "	limit_req zone=ip burst=0 nodelay;">>/etc/nginx/sites-available/42-hiddengames.com
echo "	limit_conn addr 5;">>/etc/nginx/sites-available/42-hiddengames.com
echo "	limit_conn_log_level error;">>/etc/nginx/sites-available/42-hiddengames.com
echo "	include snippets/self-signed.conf;">>/etc/nginx/sites-available/42-hiddengames.com
echo "	include snippets/ssl-params.conf;">>/etc/nginx/sites-available/42-hiddengames.com
echo "	location / {">>/etc/nginx/sites-available/42-hiddengames.com
echo "		proxy_pass http://192.168.42.2:3000;">>/etc/nginx/sites-available/42-hiddengames.com
echo "		proxy_http_version 1.1;">>/etc/nginx/sites-available/42-hiddengames.com
echo '		proxy_set_header Upgrade $http_upgrade;'>>/etc/nginx/sites-available/42-hiddengames.com
echo -e "		proxy_set_header Connection 'upgrade';">>/etc/nginx/sites-available/42-hiddengames.com
echo '		proxy_set_header Host $host;'>>/etc/nginx/sites-available/42-hiddengames.com
echo '		proxy_cache_bypass $http_upgrade;'>>/etc/nginx/sites-available/42-hiddengames.com
echo "     }">>/etc/nginx/sites-available/42-hiddengames.com
echo "}">>/etc/nginx/sites-available/42-hiddengames.com
echo "server {">>/etc/nginx/sites-available/42-hiddengames.com
echo "      listen 80;">>/etc/nginx/sites-available/42-hiddengames.com
echo "		server_name 42-hiddengames.com;">>/etc/nginx/sites-available/42-hiddengames.com
echo "		limit_req zone=ip burst=0 nodelay;">>/etc/nginx/sites-available/42-hiddengames.com
echo "   	limit_conn addr 5;">>/etc/nginx/sites-available/42-hiddengames.com
echo "		limit_conn_log_level error">>/etc/nginx/sites-available/42-hiddengames.com
echo '		return 301 https://$server_name$request_uri;'>>/etc/nginx/sites-available/42-hiddengames.com
echo "}">>/etc/nginx/sites-available/42-hiddengames.com
sudo service nginx restart
echo "Nginx configured."
