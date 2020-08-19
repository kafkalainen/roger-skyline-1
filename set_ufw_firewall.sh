#!/bin/bash
sudo ufw reset
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow from 192.168.56.1 proto tcp to any port 50486
sudo ufw allow 443
sudo ufw enable
sudo ufw numbered
