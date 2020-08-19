sed -i 's/PasswordAuthentication yes/PasswordAuthentivation no/' /etc/ssh/sshd_config
sudo service ssh restart
