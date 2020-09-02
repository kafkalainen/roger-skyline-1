#!/bin/bash
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt
#for testing use 1024, real one 4096
sudo openssl dhparam -out /etc/nginx/dhparam.pem 4096
sudo touch /etc/nginx/snippets/self-signed.conf
sudo echo "ssl_certificate /etc/ssl/certs/nginx-selfsigned.crt;">>/etc/nginx/snippets/self-signed.conf
sudo echo "ssl_certificate_key /etc/ssl/private/nginx-selfsigned.key;">>/etc/nginx/snippets/self-signed.conf
sudo touch /etc/nginx/snippets/ssl-params.conf
echo -e "ssl_protocols TLSv1.2;\nssl_prefer_server_ciphers on;\nssl_dhparam /etc/nginx/dhparam.pem;\nssl_ciphers ECDHE-RSA-AES256-GCM-SHA512:DHE-RSA-AES256-GCM-SHA512:ECDHE-RSA-AES256-GCM-SHA384:DHE-RSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-SHA384;\nssl_ecdh_curve secp384r1;\nssl_session_timeout  10m;\nssl_session_cache shared:SSL:10m;\nssl_session_tickets off;\nssl_stapling on;\nssl_stapling_verify on;\nresolver 8.8.8.8 8.8.4.4 valid=300s;\nresolver_timeout 5s;\nadd_header X-Frame-Options DENY;\nadd_header X-Content-Type-Options nosniff;\nadd_header X-XSS-Protection \"1; mode=block\";">>/etc/nginx/snippets/ssl-params.conf
echo "Created SSL certificate for nginx."
