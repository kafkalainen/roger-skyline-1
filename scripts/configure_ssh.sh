#!/bin/bash
sed -i 's/#Port 22/Port 50486/' /etc/ssh/sshd_config
sed -i 's/#ListenAddress 0.0.0.0/ListenAddress 192.168.56.2/' /etc/ssh/sshd_config
sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config
sed -i 's/#PubkeyAuthentication yes/PubkeyAuthentication yes/' /etc/ssh/sshd_config
echo "AllowUsers $USER" >>/etc/ssh/sshd_config
sudo service ssh restart
echo "Shh configuration set running."
