#!/bin/bash
sudo ufw reset
sed -i "s/IPV6=yes/IPV6=no/" /etc/default/ufw
sudo ufw disable
sudo ufw enable
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow from 192.168.42.1 proto tcp to any port 50486
sudo ufw allow 'Nginx Full'
sudo ufw delete 3
sudo ufw enable
sudo ufw numbered
echo "Uncomplicated firewall set."
